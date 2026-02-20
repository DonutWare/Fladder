import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/providers/live_tv_provider.dart';
import 'package:fladder/screens/live_tv/live_tv_guide.dart';
import 'package:fladder/screens/shared/default_alert_dialog.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/item_base_model/play_item_helpers.dart';
import 'package:fladder/util/localization_helper.dart';

@RoutePage()
class LiveTvScreen extends ConsumerStatefulWidget {
  final String viewId;
  const LiveTvScreen({
    @QueryParam() this.viewId = "",
    super.key,
  });

  @override
  ConsumerState<LiveTvScreen> createState() => _LiveTvScreenState();
}

class _LiveTvScreenState extends ConsumerState<LiveTvScreen> {
  final ScrollController _horizontalScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(liveTvProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0).add(AdaptiveLayout.adaptivePadding(context)),
        child: state.channels.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: MediaQuery.paddingOf(context),
                child: Column(
                  spacing: 16,
                  children: [
                    Row(
                      spacing: 6,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const BackButton(),
                        Text(
                          "TV Guide",
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        const SizedBox(width: 48),
                      ],
                    ),
                    Row(
                      spacing: 6,
                      children: [
                        FilledButton(
                          onPressed: () {
                            _horizontalScrollController.animateTo(
                              0,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Text(context.localized.now),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            ref.read(liveTvProvider.notifier).fetchDashboard();
                          },
                          child: Text(context.localized.refresh),
                        ),
                      ],
                    ),
                    Expanded(
                      child: LiveTvGuide(
                        horizontalScrollController: _horizontalScrollController,
                        onProgramSelected: (program, channel) async {
                          await showDefaultAlertDialog(
                            context,
                            context.localized.switchChannel,
                            context.localized.switchChannelDesc(program.name, channel.name),
                            (currentContext) async {
                              Navigator.of(currentContext).pop();
                              program.channel.play(context, ref);
                            },
                            context.localized.watch,
                            (currentContext) async {
                              Navigator.of(currentContext).pop();
                            },
                            context.localized.decline,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
