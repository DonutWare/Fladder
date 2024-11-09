import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/items/chapters_model.dart';
import 'package:fladder/models/items/media_segments_model.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/util/duration_extensions.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/string_extensions.dart';
import 'package:fladder/widgets/gapped_container_shape.dart';
import 'package:fladder/widgets/shared/fladder_slider.dart';
import 'package:fladder/widgets/shared/trick_play_image.dart';

class VideoProgressBar extends ConsumerStatefulWidget {
  final Function(bool value) wasPlayingChanged;
  final bool wasPlaying;
  final VoidCallback timerReset;
  final Duration duration;
  final Duration position;
  final bool buffering;
  final Duration buffer;
  final Function(Duration duration) onPositionChanged;
  const VideoProgressBar({
    required this.wasPlayingChanged,
    required this.wasPlaying,
    required this.timerReset,
    required this.onPositionChanged,
    required this.duration,
    required this.position,
    required this.buffering,
    required this.buffer,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChapterProgressSliderState();
}

class _ChapterProgressSliderState extends ConsumerState<VideoProgressBar> {
  bool onHoverStart = false;
  bool onDragStart = false;
  double _chapterPosition = 0.0;
  double imageBottomOffset = 0.0;
  double chapterCardWidth = 250;
  Duration currentDuration = Duration.zero;

  @override
  Widget build(BuildContext context) {
    final List<Chapter> chapters = ref.read(playBackModel.select((value) => value?.chapters ?? []));
    final isVisible = (onDragStart ? true : onHoverStart);
    final player = ref.watch(videoPlayerProvider);
    final position = onDragStart ? currentDuration : widget.position;
    final MediaSegmentsModel? mediaSegments = ref.read(playBackModel.select((value) => value?.mediaSegments));
    final relativeFraction = position.inMilliseconds / widget.duration.inMilliseconds;
    return LayoutBuilder(
      builder: (context, constraints) {
        final sliderHeight = SliderTheme.of(context).trackHeight ?? (constraints.maxHeight / 3);
        final bufferWidth = calculateFractionWidth(constraints, widget.buffer);
        final bufferFraction = relativeFraction / (bufferWidth / constraints.maxWidth);
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Align(
              alignment: Alignment.center,
              child: MouseRegion(
                opaque: !widget.buffering,
                onHover: (event) {
                  setState(() {
                    onHoverStart = true;
                    _updateSliderPosition(event.localPosition.dx, constraints.maxWidth);
                  });
                },
                onExit: (event) {
                  setState(() {
                    onHoverStart = false;
                  });
                },
                child: Listener(
                  onPointerDown: (event) {
                    setState(() {
                      onDragStart = true;
                      _updateSliderPosition(event.localPosition.dx, constraints.maxWidth);
                    });
                  },
                  onPointerMove: (event) {
                    _updateSliderPosition(event.localPosition.dx, constraints.maxWidth);
                  },
                  onPointerUp: (_) {
                    setState(() {
                      onDragStart = false;
                    });
                  },
                  child: Opacity(
                    opacity: widget.buffering ? 0 : 1.0,
                    child: FladderSlider(
                      min: 0.0,
                      max: widget.duration.inMilliseconds.toDouble(),
                      animation: Duration.zero,
                      thumbWidth: 10.0,
                      showThumb: false,
                      value: (position.inMilliseconds).toDouble().clamp(
                            0,
                            widget.duration.inMilliseconds.toDouble(),
                          ),
                      onChangeEnd: (e) async {
                        currentDuration = Duration(milliseconds: e.toInt());
                        await player.seek(Duration(milliseconds: e ~/ 1));
                        await Future.delayed(const Duration(milliseconds: 250));
                        if (widget.wasPlaying) {
                          player.play();
                        }
                        widget.timerReset.call();
                        setState(() {
                          onHoverStart = false;
                        });
                      },
                      onChangeStart: (value) {
                        setState(() {
                          onHoverStart = true;
                        });
                        widget.wasPlayingChanged.call(player.player?.state.playing ?? false);
                        player.pause();
                      },
                      onChanged: (e) {
                        currentDuration = Duration(milliseconds: e.toInt());
                        widget.timerReset.call();
                      },
                    ),
                  ),
                ),
              ),
            ),
            IgnorePointer(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ...?mediaSegments?.segments.map(
                    (segment) => Positioned(
                      left: calculateStartOffset(constraints, segment.start),
                      right: calculateRightOffset(constraints, segment.end),
                      bottom: 0,
                      child: Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: segment.type.color,
                          borderRadius: BorderRadius.circular(
                            100,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (!widget.buffering) ...{
                    //VideoBufferBar
                    Positioned(
                      left: 0,
                      child: SizedBox(
                        width: (constraints.maxWidth / (widget.duration.inMilliseconds / widget.buffer.inMilliseconds))
                            .clamp(1, constraints.maxWidth),
                        height: sliderHeight,
                        child: GappedContainerShape(
                          activeColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                          inActiveColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                          thumbPosition: bufferFraction,
                        ),
                      ),
                    ),
                  } else
                    Align(
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: LinearProgressIndicator(
                          backgroundColor: Colors.transparent,
                          minHeight: sliderHeight,
                        ),
                      ),
                    ),
                  if (chapters.isNotEmpty && !widget.buffering) ...{
                    ...chapters.map(
                      (chapter) {
                        final offset = constraints.maxWidth /
                            (widget.duration.inMilliseconds / chapter.startPosition.inMilliseconds)
                                .clamp(1, constraints.maxWidth);
                        final activePosition = chapter.startPosition < widget.position;
                        if (chapter.startPosition.inSeconds == 0) return null;
                        return Positioned(
                          left: offset,
                          child: IgnorePointer(
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: activePosition
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                              ),
                              height: constraints.maxHeight,
                              width: sliderHeight - (activePosition ? 2 : 4),
                            ),
                          ),
                        );
                      },
                    ).whereNotNull(),
                  },
                ],
              ),
            ),
            if (!widget.buffering) ...[
              chapterCard(context, position, isVisible),
              Positioned(
                left: (constraints.maxWidth / (widget.duration.inMilliseconds / position.inMilliseconds))
                    .clamp(1, constraints.maxWidth),
                child: Transform.translate(
                  offset: Offset(-(constraints.maxHeight / 2), 0),
                  child: IgnorePointer(
                    child: SizedBox(
                      height: constraints.maxHeight,
                      width: constraints.maxHeight,
                      child: Center(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 125),
                          height: isVisible ? sliderHeight * 3.5 : sliderHeight,
                          width: sliderHeight,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isVisible
                                ? Theme.of(context).colorScheme.onSurface
                                : Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  double calculateFractionWidth(BoxConstraints constraints, Duration incoming) {
    return (constraints.maxWidth * (incoming.inSeconds / widget.duration.inSeconds)).clamp(0, constraints.maxWidth);
  }

  double calculateStartOffset(BoxConstraints constraints, Duration start) {
    return (constraints.maxWidth * (start.inSeconds / widget.duration.inSeconds)).clamp(0, constraints.maxWidth);
  }

  double calculateEndOffset(BoxConstraints constraints, Duration end) {
    return (constraints.maxWidth * (end.inSeconds / widget.duration.inSeconds)).clamp(0, constraints.maxWidth);
  }

  double calculateRightOffset(BoxConstraints constraints, Duration end) {
    double endOffset = calculateEndOffset(constraints, end);
    return constraints.maxWidth - endOffset;
  }

  Widget chapterCard(BuildContext context, Duration duration, bool visible) {
    const double height = 350;
    final currentStream = ref.watch(playBackModel.select((value) => value));
    final chapter = (currentStream?.chapters ?? []).getChapterFromDuration(currentDuration);
    final trickPlay = currentStream?.trickPlay;
    final screenWidth = MediaQuery.of(context).size.width;
    final calculatedPosition = _chapterPosition.clamp(-50, screenWidth - (chapterCardWidth + 45)).toDouble();
    final offsetDifference = _chapterPosition - calculatedPosition;
    return Positioned(
      left: calculatedPosition,
      child: IgnorePointer(
        child: AnimatedOpacity(
          opacity: visible ? 1 : 0,
          duration: const Duration(milliseconds: 250),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: height, maxWidth: chapterCardWidth),
            child: Transform.translate(
              offset: const Offset(0, -height - 10),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 250),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxHeight: 250),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(8)),
                              child: trickPlay == null || trickPlay.images.isEmpty
                                  ? chapter != null
                                      ? Image(
                                          image: chapter.imageProvider,
                                          fit: BoxFit.contain,
                                        )
                                      : const SizedBox.shrink()
                                  : AspectRatio(
                                      aspectRatio: trickPlay.width.toDouble() / trickPlay.height.toDouble(),
                                      child: TrickPlayImage(
                                        trickPlay,
                                        position: currentDuration,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Transform.translate(
                              offset: Offset(offsetDifference, 10),
                              child: Transform.rotate(
                                angle: -math.pi / 4,
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.surface,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    if (chapter?.name.isNotEmpty ?? false)
                                      Flexible(
                                        child: Text(
                                          chapter?.name.capitalize() ?? "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall
                                              ?.copyWith(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    Text(
                                      currentDuration.readAbleDuration,
                                      textAlign: TextAlign.center,
                                      style:
                                          Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ].addPadding(const EdgeInsets.symmetric(vertical: 4)),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _updateSliderPosition(double xPosition, double maxWidth) {
    if (widget.buffering) return;
    setState(() {
      _chapterPosition = xPosition - chapterCardWidth / 2;
      final value = ((maxWidth - xPosition) / maxWidth - 1).abs();
      currentDuration = Duration(milliseconds: (widget.duration.inMilliseconds * value).toInt());
    });
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
