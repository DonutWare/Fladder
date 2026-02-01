import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/items/channel_model.dart';
import 'package:fladder/models/items/channel_program.dart';
import 'package:fladder/providers/live_tv_provider.dart';
import 'package:fladder/screens/live_tv/widgets/channel_row.dart';
import 'package:fladder/screens/live_tv/widgets/guide_constants.dart';
import 'package:fladder/screens/live_tv/widgets/timeline_header.dart';
import 'package:fladder/util/fladder_image.dart';

class LiveTvGuide extends ConsumerStatefulWidget {
  final ChannelModel? currentChannel;
  final ChannelProgram? selectedProgram;
  final ScrollController horizontalScrollController;
  final Function(ChannelProgram program, ChannelModel channel)? onProgramSelected;
  final Function(ChannelProgram program, ChannelModel channel)? onLongPressProgram;
  const LiveTvGuide({
    this.currentChannel,
    this.selectedProgram,
    required this.horizontalScrollController,
    this.onProgramSelected,
    this.onLongPressProgram,
    super.key,
  });

  @override
  ConsumerState<LiveTvGuide> createState() => _LiveTvGuideState();
}

class _LiveTvGuideState extends ConsumerState<LiveTvGuide> {
  final ScrollController _verticalScrollController = ScrollController();
  final List<ScrollController> _channelScrollControllers = [];
  bool _isSyncingScroll = false;

  String? _lastScrolledChannelId;
  Timer? _nowTimer;

  @override
  void initState() {
    super.initState();
    widget.horizontalScrollController.addListener(_onHorizontalScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) => _maybeScrollToSelection());
    _startNowTimer();
  }

  void _startNowTimer() {
    _nowTimer?.cancel();
    final now = DateTime.now();
    final nextMinute = DateTime(now.year, now.month, now.day, now.hour, now.minute).add(const Duration(minutes: 1));
    final initialDelay = nextMinute.difference(now);
    _nowTimer = Timer(initialDelay, () {
      if (!mounted) return;
      setState(() {});
      _nowTimer = Timer.periodic(const Duration(minutes: 1), (_) {
        if (!mounted) return;
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    widget.horizontalScrollController.removeListener(_onHorizontalScroll);
    for (var controller in _channelScrollControllers) {
      controller.dispose();
    }
    _verticalScrollController.dispose();
    _nowTimer?.cancel();
    super.dispose();
  }

  void _onHorizontalScroll() {
    if (_isSyncingScroll) return;
    _syncScrollPositions(widget.horizontalScrollController);
  }

  void _syncScrollPositions(ScrollController source, {bool animate = false}) {
    if (_isSyncingScroll) return;
    _isSyncingScroll = true;
    final offset = source.offset;

    final allControllers = [
      widget.horizontalScrollController,
      ..._channelScrollControllers,
    ];

    for (var controller in allControllers) {
      if (controller != source && controller.hasClients && controller.offset != offset) {
        if (animate) {
          controller.animateTo(
            offset,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        } else {
          controller.jumpTo(offset);
        }
      }
    }
    _isSyncingScroll = false;
  }

  @override
  void didUpdateWidget(covariant LiveTvGuide oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentChannel?.id != widget.currentChannel?.id ||
        oldWidget.selectedProgram?.id != widget.selectedProgram?.id) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _maybeScrollToSelection());
    }
  }

  void _maybeScrollToSelection() {
    final state = ref.read(liveTvProvider);
    final channels = state.channels;

    if (widget.currentChannel == null) return;

    final channelIndex = channels.indexWhere((c) => c.id == widget.currentChannel!.id);
    if (channelIndex >= 0 && _lastScrolledChannelId != widget.currentChannel!.id) {
      final target = channelIndex * GuideConstants.channelRowHeight;
      if (_verticalScrollController.hasClients) {
        _verticalScrollController.animateTo(
          target,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
      _lastScrolledChannelId = widget.currentChannel!.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(liveTvProvider);

    final channels = state.channels;

    final startDate = state.startDate;
    final endDate = state.endDate;

    final now = DateTime.now();
    final timelineWidth = (endDate.difference(startDate).inMinutes * GuideConstants.widthPerMinute).toDouble();
    final nowLeftRaw = (now.difference(startDate).inMinutes * GuideConstants.widthPerMinute).toDouble();
    final nowLeft = nowLeftRaw.clamp(0.0, timelineWidth);

    final timeLineTopPadding = 60.0;

    final timeLabels = _generateTimeLabels(startDate, endDate, 30);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      width: double.infinity,
      child: Stack(
        children: [
          Column(
            children: [
              TimelineHeader(
                horizontalScrollController: widget.horizontalScrollController,
                startDate: startDate,
                endDate: endDate,
                timeLabels: timeLabels,
                timelineWidth: timelineWidth,
                now: now,
                nowLeft: nowLeft,
                timeLineTopPadding: timeLineTopPadding,
              ),
              Container(
                height: 1,
                width: double.infinity,
                color: Theme.of(context).colorScheme.onSurface.withAlpha(50),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  controller: _verticalScrollController,
                  itemCount: channels.length,
                  itemBuilder: (context, index) {
                    while (_channelScrollControllers.length <= index) {
                      final controller = ScrollController();
                      controller.addListener(() {
                        if (_isSyncingScroll) return;
                        _syncScrollPositions(controller);
                      });
                      _channelScrollControllers.add(controller);
                    }

                    final channel = channels[index];
                    final selected = channel.id == widget.currentChannel?.id;
                    return RepaintBoundary(
                      child: SizedBox(
                        height: GuideConstants.channelRowHeight,
                        child: Row(
                          children: [
                            Container(
                              width: GuideConstants.leftColumnWidth,
                              height: GuideConstants.channelRowHeight,
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: selected
                                        ? Theme.of(context).colorScheme.primaryContainer
                                        : Theme.of(context).colorScheme.surfaceContainer,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  alignment: Alignment.center,
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
                            Expanded(
                              child: SingleChildScrollView(
                                controller: _channelScrollControllers[index],
                                scrollDirection: Axis.horizontal,
                                physics: const ClampingScrollPhysics(),
                                child: SizedBox(
                                  width: timelineWidth,
                                  height: GuideConstants.channelRowHeight,
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      ChannelRow(
                                        channel: channel,
                                        selectedProgram: widget.selectedProgram,
                                        onProgramSelected: (program) =>
                                            widget.onProgramSelected?.call(program, channel),
                                        onLongPressProgram: (program) =>
                                            widget.onLongPressProgram?.call(program, channel),
                                        timelineStart: startDate,
                                        scrollToPosition: (value) {
                                          if (value < 0) value = 0;
                                          _isSyncingScroll = true;
                                          final offset = value;

                                          final allControllers = [
                                            widget.horizontalScrollController,
                                            ..._channelScrollControllers,
                                          ];

                                          for (var controller in allControllers) {
                                            if (controller.hasClients) {
                                              controller.animateTo(
                                                offset,
                                                duration: const Duration(milliseconds: 300),
                                                curve: Curves.easeInOut,
                                              );
                                            }
                                          }

                                          Future.delayed(const Duration(milliseconds: 300), () {
                                            _isSyncingScroll = false;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          AnimatedBuilder(
            animation: widget.horizontalScrollController,
            builder: (context, child) {
              final scrollOffset =
                  widget.horizontalScrollController.hasClients ? widget.horizontalScrollController.offset : 0.0;
              final left = (GuideConstants.leftColumnWidth + nowLeft - scrollOffset);
              final lineLeft =
                  left.clamp(GuideConstants.leftColumnWidth, GuideConstants.leftColumnWidth + timelineWidth);
              final bubbleLeft =
                  (left - 24).clamp(GuideConstants.leftColumnWidth, GuideConstants.leftColumnWidth + timelineWidth);
              return Stack(
                children: [
                  Positioned(
                    left: lineLeft - 2,
                    top: 0,
                    bottom: 0,
                    child: IgnorePointer(
                      child: Container(
                        width: 2,
                        color: Theme.of(context).colorScheme.primary.withAlpha(200),
                      ),
                    ),
                  ),
                  Positioned(
                    left: bubbleLeft,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
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
              );
            },
          ),
        ],
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
