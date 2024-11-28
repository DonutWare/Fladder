import 'package:flutter/material.dart';

import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/settings/subtitle_settings_model.dart';
import 'package:fladder/providers/settings/subtitle_settings_provider.dart';
import 'package:fladder/providers/settings/video_player_settings_provider.dart';
import 'package:fladder/screens/video_player/components/video_subtitle_controls.dart';
import 'package:fladder/util/adaptive_layout.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/navigation_scaffold/components/fladder_app_bar.dart';

class SubtitleEditor extends ConsumerStatefulWidget {
  const SubtitleEditor({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SubtitleEditorState();
}

class _SubtitleEditorState extends ConsumerState<SubtitleEditor> {
  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(subtitleSettingsProvider);
    final fillScreen = ref.watch(videoPlayerSettingsProvider.select((value) => value.fillScreen));
    final padding = MediaQuery.of(context).padding;
    final fakeText = context.localized.subtitleConfiguratorPlaceHolder;
    double lastScale = 0.0;

    return Scaffold(
      body: Dialog.fullscreen(
        child: GestureDetector(
          onScaleUpdate: (details) {
            lastScale = details.scale;
          },
          onScaleEnd: (details) {
            if (lastScale < 1.0) {
              ref.read(videoPlayerSettingsProvider.notifier).setFillScreen(false, context: context);
            } else if (lastScale > 1.0) {
              ref.read(videoPlayerSettingsProvider.notifier).setFillScreen(true, context: context);
            }
            lastScale = 0.0;
          },
          child: Stack(
            children: [
              Padding(
                padding: (fillScreen ? EdgeInsets.zero : EdgeInsets.only(left: padding.left, right: padding.right)),
                child: const Center(
                  child: AspectRatio(
                    aspectRatio: 2.1,
                    child: Card(
                      child: Image(
                        image: BlurHashImage('LEF}}|0000~p8w~W%N4n~pIU4o%g'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              SubtitleText(subModel: settings, padding: padding, offset: settings.verticalOffset, text: fakeText),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding:
                      MediaQuery.paddingOf(context).add(const EdgeInsets.all(32).add(const EdgeInsets.only(top: 48))),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.95,
                    child: const VideoSubtitleControls(),
                  ),
                ),
              ),
              Padding(
                padding: MediaQuery.paddingOf(context),
                child: Column(
                  children: [
                    if (AdaptiveLayout.of(context).isDesktop) const FladderAppBar(),
                    Row(
                      children: [
                        const BackButton(),
                        Text(
                          context.localized.subtitleConfigurator,
                          style: Theme.of(context).textTheme.headlineMedium,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
