import 'dart:async';

import 'package:flutter/material.dart';

import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:intl/intl.dart';

import 'package:fladder/models/items/channel_program.dart';
import 'package:fladder/screens/details_screens/components/overview_header.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/widgets/shared/ensure_visible.dart';
import 'package:fladder/widgets/shared/item_actions.dart';
import 'package:fladder/widgets/shared/modal_bottom_sheet.dart';

class ChannelProgramItem extends StatefulWidget {
  final ChannelProgram program;

  const ChannelProgramItem({required this.program, super.key});

  @override
  State<ChannelProgramItem> createState() => _ChannelProgramItemState();
}

class _ChannelProgramItemState extends State<ChannelProgramItem> with SingleTickerProviderStateMixin {
  bool _expanded = false;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _toggle() {
    if (AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad) {
      showBottomSheetPill(
        context: context,
        content: (context, scrollController) => ListView(
          shrinkWrap: true,
          controller: scrollController,
          children: [
            ItemActionButton(
              icon: const Icon(IconsaxPlusBold.record_circle),
              label: const Text("Record"),
              action: () {},
            ),
          ].listTileItems(context, useIcons: true),
        ),
      );
    } else {
      setState(() => _expanded = !_expanded);
    }
  }

  @override
  Widget build(BuildContext context) {
    final program = widget.program;
    final timeRemainingInPercentage = getTimeRemainingInPercentage(
      program.startDate,
      program.endDate,
    );

    final isActive = timeRemainingInPercentage > 0.0 && timeRemainingInPercentage < 1.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Column(
        children: [
          FocusButton(
            onTap: _toggle,
            onFocusChanged: (focus) {
              if (focus) {
                context.ensureVisible();
              }
              if (AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad && focus) {
                setState(() {
                  _expanded = true;
                });
              } else if (!focus && _expanded) {
                setState(() {
                  _expanded = false;
                });
              }
            },
            borderRadius: BorderRadius.circular(8),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).colorScheme.surfaceContainerLow,
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      if (isActive)
                        Positioned.fill(
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: timeRemainingInPercentage,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primaryContainer.withAlpha(175),
                                borderRadius: FladderTheme.defaultPosterDecoration.borderRadius,
                              ),
                              foregroundDecoration: FladderTheme.defaultPosterDecoration,
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    program.name,
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                                Text(
                                  "${DateFormat.Hm().format(program.startDate.toLocal())} - ${DateFormat.Hm().format(program.endDate.toLocal())}",
                                  style: Theme.of(context).textTheme.bodySmall,
                                )
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(program.subLabel(context)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                      constraints: _expanded ? const BoxConstraints() : const BoxConstraints(maxHeight: 0),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        child: IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 12,
                            children: [
                              if (program.images?.primary != null)
                                SizedBox(
                                  width: 100,
                                  child: Container(
                                    decoration: FladderTheme.defaultPosterDecoration,
                                    clipBehavior: Clip.hardEdge,
                                    child: AspectRatio(
                                      aspectRatio: 0.75,
                                      child: FladderImage(
                                        image: program.images?.primary,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      program.overview ?? '',
                                      style: Theme.of(context).textTheme.bodyMedium,
                                      maxLines: 10,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SimpleLabel(
                                      label: Text(program.officialRating),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

double getTimeRemainingInPercentage(DateTime start, DateTime end) {
  final now = DateTime.now().toUtc();
  if (now.isBefore(start.toUtc())) {
    return 0.0;
  } else if (now.isAfter(end.toUtc())) {
    return 1.0;
  } else {
    final totalDuration = end.toUtc().difference(start.toUtc()).inSeconds;
    final elapsedDuration = now.difference(start.toUtc()).inSeconds;
    return elapsedDuration / totalDuration;
  }
}
