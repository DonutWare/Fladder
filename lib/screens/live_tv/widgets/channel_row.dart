import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/items/channel_model.dart';
import 'package:fladder/models/items/channel_program.dart';
import 'package:fladder/providers/live_tv_provider.dart';
import 'package:fladder/screens/live_tv/widgets/guide_constants.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/localization_helper.dart';

class ChannelRow extends ConsumerStatefulWidget {
  final ChannelProgram? selectedProgram;
  final ChannelModel channel;
  final DateTime timelineStart;
  final Function(double position) scrollToPosition;
  final Function(ChannelProgram program)? onProgramSelected;
  final Function(ChannelProgram program)? onLongPressProgram;
  const ChannelRow({
    this.selectedProgram,
    required this.channel,
    required this.timelineStart,
    required this.scrollToPosition,
    this.onProgramSelected,
    this.onLongPressProgram,
    super.key,
  });

  @override
  ConsumerState<ChannelRow> createState() => ChannelRowState();
}

class ChannelRowState extends ConsumerState<ChannelRow> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(liveTvProvider.notifier).fetchPrograms(widget.channel));
  }

  @override
  void didUpdateWidget(covariant ChannelRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    Future.microtask(() => ref.read(liveTvProvider.notifier).fetchPrograms(widget.channel));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.microtask(() => ref.read(liveTvProvider.notifier).fetchPrograms(widget.channel));
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(liveTvProvider);
    final channel = state.channels.firstWhere((c) => c.id == widget.channel.id, orElse: () => widget.channel);

    if (state.loadingChannelIds.contains(channel.id)) {
      return const Center(child: CircularProgressIndicator());
    }

    if (channel.programs.isEmpty) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(
              left: GuideConstants.padding, right: GuideConstants.padding, top: GuideConstants.padding / 2),
          child: FocusButton(
            onTap: () {},
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              height: GuideConstants.channelRowHeight - GuideConstants.padding / 2,
              width: MediaQuery.sizeOf(context).width / 2,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: Colors.white.withAlpha(45),
                  width: 1,
                ),
              ),
              child: Text(
                context.localized.noPrograms,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ),
          ),
        ),
      );
    }

    final timelineStart = widget.timelineStart;
    final timelineEnd = state.endDate;
    final secondsPerPixel = GuideConstants.widthPerMinute / 60.0;
    final timelineWidth = (timelineEnd.difference(timelineStart).inSeconds * secondsPerPixel).toDouble();

    return Stack(
      clipBehavior: Clip.none,
      children: [
        ...channel.programs.mapIndexed(
          (index, program) {
            final visibleStart = program.startDate.isBefore(timelineStart) ? timelineStart : program.startDate;
            final visibleEnd = program.endDate.isAfter(timelineEnd) ? timelineEnd : program.endDate;

            if (!visibleEnd.isAfter(visibleStart)) return const SizedBox.shrink();

            final startOffset = (visibleStart.difference(timelineStart).inSeconds * secondsPerPixel).toDouble();
            final rawWidth = (visibleEnd.difference(visibleStart).inSeconds * secondsPerPixel).toDouble();

            final minWidth = GuideConstants.padding;
            final width = rawWidth < minWidth ? minWidth : rawWidth;

            final clampedLeft = startOffset.clamp(0.0, timelineWidth);
            final clampedWidth = ((clampedLeft + width) > timelineWidth) ? (timelineWidth - clampedLeft) : width;

            final endDateIsAfterNow = program.endDate.isAfter(DateTime.now());

            final isSelected = widget.selectedProgram?.id == program.id;

            return Positioned(
              left: clampedLeft,
              top: GuideConstants.padding / 2,
              height: GuideConstants.channelRowHeight - GuideConstants.padding / 2,
              width: clampedWidth,
              child: Opacity(
                opacity: endDateIsAfterNow ? 1.0 : 0.5,
                child: Builder(
                  builder: (context) {
                    return FocusButton(
                      onTap: () {
                        if (widget.onProgramSelected != null) {
                          widget.onProgramSelected!(program);
                        }
                      },
                      onLongPress: () {
                        if (widget.onLongPressProgram != null) {
                          widget.onLongPressProgram!(program);
                        }
                      },
                      autoFocus: isSelected && AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad,
                      borderRadius: BorderRadius.circular(8.0),
                      onFocusChanged: (focus) {
                        if (focus) {
                          widget.scrollToPosition(clampedLeft - (GuideConstants.widthPerMinute * 10));
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: GuideConstants.padding),
                        decoration: BoxDecoration(
                          color: colorFromString(
                            program.name,
                            inPast: endDateIsAfterNow,
                            selectedProgram: isSelected,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        foregroundDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: Colors.white.withAlpha(endDateIsAfterNow ? 45 : 15),
                            width: 1,
                          ),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: clampedWidth >= 75
                            ? Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  if (index == 0 ||
                                      channel.programs[(index - 1).clamp(0, channel.programs.length)].name !=
                                          program.name)
                                    Container(
                                      child: AspectRatio(
                                        aspectRatio: 0.7,
                                        child: FladderImage(
                                          image: program.images?.primary?.copyWith(
                                            key: 'program-${program.id}-${program.name}}',
                                          ),
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                    ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            program.name,
                                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            program.subLabel(context.localized),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            "${program.startDate.hour.toString().padLeft(2, '0')}:${program.startDate.minute.toString().padLeft(2, '0')} - ${program.endDate.hour.toString().padLeft(2, '0')}:${program.endDate.minute.toString().padLeft(2, '0')}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                  color: Colors.white70,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : null,
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Color colorFromString(String input, {bool inPast = false, bool selectedProgram = false}) {
    if (selectedProgram) {
      return Theme.of(context).colorScheme.primaryContainer;
    }
    final hash = input.codeUnits.fold(0, (prev, elem) => prev + elem);
    final r = (hash * 123) % 256;
    final g = (hash * 456) % 256;
    final b = (hash * 789) % 256;

    final base = Theme.of(context).colorScheme.surfaceContainer;
    final generated = Color.fromARGB(255, r, g, b);

    final harmonized = generated.harmonizeWith(base);

    return Color.lerp(base, harmonized, inPast ? 0.25 : 0.05) ?? harmonized;
  }
}
