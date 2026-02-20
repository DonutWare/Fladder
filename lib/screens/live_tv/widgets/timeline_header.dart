import 'package:flutter/material.dart';

import 'package:fladder/screens/live_tv/widgets/guide_constants.dart';

class TimelineHeader extends StatelessWidget {
  final ScrollController horizontalScrollController;
  final DateTime startDate;
  final DateTime endDate;
  final List<DateTime> timeLabels;
  final double timelineWidth;
  final DateTime now;
  final double nowLeft;
  final double timeLineTopPadding;

  const TimelineHeader({
    required this.horizontalScrollController,
    required this.startDate,
    required this.endDate,
    required this.timeLabels,
    required this.timelineWidth,
    required this.now,
    required this.nowLeft,
    required this.timeLineTopPadding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: timeLineTopPadding,
      child: Row(
        children: [
          const SizedBox(width: GuideConstants.leftColumnWidth),
          Expanded(
            child: SingleChildScrollView(
              controller: horizontalScrollController,
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              child: SizedBox(
                width: timelineWidth,
                height: timeLineTopPadding,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ...timeLabels.where((t) => t.isAfter(startDate)).map(
                      (t) {
                        final leftPos = (t.difference(startDate).inMinutes * GuideConstants.widthPerMinute)
                            .toDouble()
                            .clamp(0.0, timelineWidth);
                        return [
                          Positioned(
                            left: leftPos,
                            bottom: 0,
                            child: Container(
                              width: 2,
                              height: timeLineTopPadding / 2,
                              color: Theme.of(context).colorScheme.onSurface.withAlpha(50),
                            ),
                          ),
                          Positioned(
                            left: leftPos + 2,
                            bottom: 0,
                            child: SizedBox(
                              width: 48.0,
                              height: timeLineTopPadding / 2,
                              child: Align(
                                alignment: Alignment.bottomCenter,
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
