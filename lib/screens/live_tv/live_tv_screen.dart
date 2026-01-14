import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/items/channel_model.dart';
import 'package:fladder/providers/live_tv_provider.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/focus_provider.dart';

const double _channelRowHeight = 125.0;
const double _widthPerMinute = 10;

const double _padding = 6.0;

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

    final channels = state.channels;

    final startDate = state.startDate.copyWith(
      minute: (state.startDate.minute) - ((state.startDate.minute) % 15),
      second: 0,
    );
    final endDate = state.endDate;

    final now = DateTime.now();
    final timelineWidth = (endDate.difference(startDate).inMinutes * _widthPerMinute).toDouble();
    final nowLeftRaw = (now.difference(startDate).inMinutes * _widthPerMinute).toDouble();
    final nowLeft = nowLeftRaw.clamp(0.0, timelineWidth);

    final channelsWidth = channels.length * _channelRowHeight;

    final timeLineTopPadding = 60.0;

    final timeLabels = _generateTimeLabels(startDate, endDate, 30);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0).add(AdaptiveLayout.adaptivePadding(context)),
        child: state.channels.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Text(
                    "Guide",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _horizontalScrollController.animateTo(
                            0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Text("Now"),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          ref.read(liveTvProvider.notifier).fetchDashboard();
                        },
                        child: Text("Refresh"),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    height: channelsWidth + timeLineTopPadding,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: timeLineTopPadding - 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ...channels.map(
                                (channel) => Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0).copyWith(bottom: 6.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.surfaceContainer,
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      alignment: Alignment.center,
                                      width: 175,
                                      height: 125,
                                      child: Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: SizedBox(
                                          child: channel.images != null
                                              ? AspectRatio(
                                                  aspectRatio: 1,
                                                  child: FladderImage(
                                                    image: channel.images?.primary,
                                                    fit: BoxFit.contain,
                                                  ),
                                                )
                                              : const Icon(Icons.tv),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: SingleChildScrollView(
                            controller: _horizontalScrollController,
                            scrollDirection: Axis.horizontal,
                            child: SizedBox(
                              width: endDate.difference(startDate).inMinutes * _widthPerMinute.toDouble(),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  ...timeLabels.where((t) => t.isAfter(startDate)).map(
                                    (t) {
                                      final leftPos = (t.difference(startDate).inMinutes * _widthPerMinute)
                                          .toDouble()
                                          .clamp(0.0, timelineWidth);
                                      return [
                                        Positioned(
                                          left: leftPos,
                                          height: channelsWidth + timeLineTopPadding,
                                          child: Container(
                                            width: 2,
                                            color: Theme.of(context).colorScheme.onSurface.withAlpha(50),
                                          ),
                                        ),
                                        Positioned(
                                          left: leftPos + 2,
                                          top: timeLineTopPadding / 2,
                                          child: SizedBox(
                                            width: 48.0,
                                            child: Align(
                                              alignment: Alignment.topCenter,
                                              child: Text(
                                                "${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}",
                                                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ].toList();
                                    },
                                  ).expand((element) => element),
                                  ...channels.map(
                                    (channel) {
                                      final width = endDate.difference(startDate).inMinutes * _widthPerMinute;
                                      return Positioned(
                                        top: channels.indexOf(channel) * _channelRowHeight + timeLineTopPadding,
                                        width: width,
                                        height: 120,
                                        child: ChannelRow(
                                          channel: channel,
                                          timelineStart: startDate,
                                          scrollToPosition: (value) {
                                            _horizontalScrollController.animateTo(
                                              value,
                                              duration: const Duration(milliseconds: 300),
                                              curve: Curves.easeInOut,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                  Positioned(
                                    left: nowLeft - 2,
                                    height: channelsWidth + timeLineTopPadding,
                                    width: 2,
                                    child: Container(color: Theme.of(context).colorScheme.primary.withAlpha(200)),
                                  ),
                                  Positioned(
                                    left: nowLeft - 24,
                                    top: 0,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
                                      decoration: BoxDecoration(
                                          color: Colors.black87, borderRadius: BorderRadius.circular(4.0)),
                                      child: Text(
                                        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}",
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

List<DateTime> _generateTimeLabels(DateTime start, DateTime end, int intervalMinutes) {
  DateTime alignToInterval(DateTime dt) {
    final minutes = dt.hour * 60 + dt.minute;
    final aligned = (minutes ~/ intervalMinutes) * intervalMinutes;
    return DateTime(dt.year, dt.month, dt.day).add(Duration(minutes: aligned));
  }

  final labels = <DateTime>[];
  for (var t = alignToInterval(start);
      t.isBefore(end.add(const Duration(minutes: 1)));
      t = t.add(Duration(minutes: intervalMinutes))) {
    labels.add(t);
  }
  return labels;
}

class ChannelRow extends ConsumerStatefulWidget {
  final ChannelModel channel;
  final DateTime timelineStart;
  final Function(double position) scrollToPosition;
  const ChannelRow({required this.channel, required this.timelineStart, required this.scrollToPosition, super.key});

  @override
  ConsumerState<ChannelRow> createState() => _ChannelRowState();
}

class _ChannelRowState extends ConsumerState<ChannelRow> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(liveTvProvider.notifier).fetchPrograms(widget.channel.id));
  }

  @override
  void didUpdateWidget(covariant ChannelRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    Future.microtask(() => ref.read(liveTvProvider.notifier).fetchPrograms(widget.channel.id));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.microtask(() => ref.read(liveTvProvider.notifier).fetchPrograms(widget.channel.id));
  }

  Color colorFromString(String input, {bool selected = false}) {
    final hash = input.codeUnits.fold(0, (prev, elem) => prev + elem);
    final r = (hash * 123) % 256;
    final g = (hash * 456) % 256;
    final b = (hash * 789) % 256;

    final base = Theme.of(context).colorScheme.surfaceContainer;
    final generated = Color.fromARGB(255, r, g, b);

    final harmonized = generated.harmonizeWith(base);

    return Color.lerp(base, harmonized, selected ? 0.25 : 0.05) ?? harmonized;
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(liveTvProvider);
    final channel = state.channels.firstWhere((c) => c.id == widget.channel.id, orElse: () => widget.channel);

    return state.loadingChannelIds.contains(channel.id)
        ? const Center(child: CircularProgressIndicator())
        : channel.programs.isEmpty
            ? const Center(child: Text('No programs'))
            : SizedBox(
                height: 120,
                child: Builder(
                  builder: (context) {
                    final timelineStart = widget.timelineStart;
                    final timelineEnd = state.endDate;
                    final secondsPerPixel = _widthPerMinute / 60.0;
                    final timelineWidth =
                        (timelineEnd.difference(timelineStart).inSeconds * secondsPerPixel).toDouble();

                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ...channel.programs.mapIndexed(
                          (index, program) {
                            final visibleStart =
                                program.startDate.isBefore(timelineStart) ? timelineStart : program.startDate;
                            final visibleEnd = program.endDate.isAfter(timelineEnd) ? timelineEnd : program.endDate;

                            if (!visibleEnd.isAfter(visibleStart)) return const SizedBox.shrink();

                            final startOffset =
                                (visibleStart.difference(timelineStart).inSeconds * secondsPerPixel).toDouble();
                            final rawWidth =
                                (visibleEnd.difference(visibleStart).inSeconds * secondsPerPixel).toDouble();

                            final minWidth = _padding;
                            final width = rawWidth < minWidth ? minWidth : rawWidth;

                            final clampedLeft = startOffset.clamp(0.0, timelineWidth);
                            final clampedWidth =
                                ((clampedLeft + width) > timelineWidth) ? (timelineWidth - clampedLeft) : width;

                            final endDateIsAfterNow = program.endDate.isAfter(DateTime.now());

                            return Positioned(
                              left: clampedLeft,
                              height: _channelRowHeight - _padding / 2,
                              width: clampedWidth,
                              child: Opacity(
                                opacity: endDateIsAfterNow ? 1.0 : 0.5,
                                child: Builder(
                                  builder: (context) {
                                    return FocusButton(
                                      onTap: () {},
                                      borderRadius: BorderRadius.circular(8.0),
                                      onFocusChanged: (focus) {
                                        if (focus) {
                                          widget.scrollToPosition(clampedLeft);
                                        }
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(right: _padding),
                                        decoration: BoxDecoration(
                                          color: colorFromString(program.name, selected: endDateIsAfterNow),
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
                                                      channel.programs[(index - 1).clamp(0, channel.programs.length)]
                                                              .name !=
                                                          program.name)
                                                    Container(
                                                      child: AspectRatio(
                                                        aspectRatio: 0.7,
                                                        child: FladderImage(
                                                          image: program.images?.primary?.copyWith(
                                                            key:
                                                                'program-${program.id}-image-${program.images?.primary?.path ?? ''}',
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
                                                            program.subLabel(context),
                                                            maxLines: 1,
                                                          ),
                                                          Text(
                                                            "${program.startDate.hour.toString().padLeft(2, '0')}:${program.startDate.minute.toString().padLeft(2, '0')} - ${program.endDate.hour.toString().padLeft(2, '0')}:${program.endDate.minute.toString().padLeft(2, '0')}",
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
                  },
                ),
              );
  }
}
