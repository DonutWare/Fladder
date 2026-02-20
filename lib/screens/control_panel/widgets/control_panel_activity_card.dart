import 'package:flutter/material.dart';

import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/providers/control_panel/control_activity_provider.dart';
import 'package:fladder/screens/shared/user_icon.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/humanize_duration.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/ensure_visible.dart';
import 'package:fladder/widgets/shared/trick_play_image.dart';

class ControlPanelActivityCard extends StatefulWidget {
  final ControlActivityModel activity;
  const ControlPanelActivityCard({
    required this.activity,
    super.key,
  });

  @override
  State<ControlPanelActivityCard> createState() => _ControlPanelActivityCardState();
}

class _ControlPanelActivityCardState extends State<ControlPanelActivityCard> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final nowPlayingItem = widget.activity.nowPlayingItem;
    final trickPlayModel = widget.activity.trickPlay;
    final playState = widget.activity.playState;
    final calculatedProgress = playState != null && nowPlayingItem != null
        ? playState.currentPosition.inMilliseconds / (nowPlayingItem.overview.runTime ?? Duration.zero).inMilliseconds
        : null;
    final backgroundColor = Theme.of(context).colorScheme.tertiaryContainer;
    return FocusButton(
      onTap: AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad
          ? () {
              setState(() {
                expanded = !expanded;
              });
            }
          : null,
      onFocusChanged: AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad
          ? (focus) {
              if (focus) {
                context.ensureVisible();
              }
            }
          : null,
      onLongPress: nowPlayingItem != null && AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad
          ? () {
              nowPlayingItem.navigateTo(context);
            }
          : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 125),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: FladderTheme.defaultPosterDecoration.borderRadius,
        ),
        clipBehavior: Clip.hardEdge,
        child: AnimatedSize(
          duration: const Duration(milliseconds: 125),
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Stack(
                  children: [
                    if (nowPlayingItem != null)
                      Positioned.fill(
                        child: trickPlayModel == null
                            ? FladderImage(
                                image: nowPlayingItem.images?.primary,
                              )
                            : TrickPlayImage(
                                trickPlayModel,
                                position: widget.activity.playState?.currentPosition,
                              ),
                      ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            backgroundColor.withAlpha(nowPlayingItem != null ? 255 : 0),
                            backgroundColor.withAlpha(0),
                            backgroundColor.withAlpha(0),
                            backgroundColor.withAlpha(nowPlayingItem != null ? 125 : 0),
                            backgroundColor.withAlpha(nowPlayingItem != null ? 255 : 0),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              spacing: 8,
                              children: [
                                SizedBox.square(
                                  dimension: 36,
                                  child: UserIcon(user: widget.activity.user),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(widget.activity.user?.name ?? "--"),
                                    Text(
                                        "${widget.activity.client} (${widget.activity.deviceName ?? "--"}) - ${widget.activity.applicationVersion ?? "--"}"),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (playState?.isPaused == true)
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.black45,
                            shape: BoxShape.circle,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              IconsaxPlusBold.pause,
                              size: 32,
                            ),
                          ),
                        ),
                      ),
                    if (nowPlayingItem != null)
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(
                            expanded ? Icons.expand_less : Icons.expand_more,
                            color: Theme.of(context).colorScheme.onTertiaryContainer,
                          ),
                          onPressed: () {
                            setState(() {
                              expanded = !expanded;
                            });
                          },
                        ),
                      ),
                    if (calculatedProgress != null)
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          spacing: 8,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                spacing: 8,
                                children: [
                                  Expanded(
                                    child: Text(
                                      nowPlayingItem?.label(context.localized) ?? "",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  if (playState != null && nowPlayingItem != null) ...[
                                    Text(
                                      "${playState.currentPosition.humanizeSmall ?? ""} / -${(nowPlayingItem.overview.runTime ?? Duration.zero - playState.currentPosition).humanizeSmall}",
                                    ),
                                  ]
                                ],
                              ),
                            ),
                            //Offset of 1 to hide border line
                            Transform.translate(
                              offset: const Offset(0, 1),
                              child: LinearProgressIndicator(
                                value: calculatedProgress.clamp(0.0, 1.0),
                                minHeight: 8,
                                backgroundColor: backgroundColor,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).colorScheme.onTertiaryContainer,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    else if (widget.activity.lastActivityDate != null && nowPlayingItem == null) ...[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Builder(builder: (context) {
                            final lastActivityInMinutes =
                                DateTime.now().difference(widget.activity.lastActivityDate!).inMinutes;
                            if (lastActivityInMinutes <= 5) {
                              return Text(
                                "${context.localized.lastActivity}: $lastActivityInMinutes ${context.localized.minutes(lastActivityInMinutes)} ago",
                                style: Theme.of(context).textTheme.bodyMedium,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                              );
                            }
                            return Text(
                              "${context.localized.lastActivity}: ${context.localized.formattedTime(widget.activity.lastActivityDate!)}",
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.start,
                              maxLines: 1,
                            );
                          }),
                        ),
                      ),
                    ]
                  ],
                ),
              ),
              if (expanded && nowPlayingItem != null) ...[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    spacing: 8,
                    children: [
                      Expanded(
                        child: Column(
                          spacing: 4,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              nowPlayingItem.title,
                              style: Theme.of(context).textTheme.titleMedium,
                              textAlign: TextAlign.start,
                              maxLines: 1,
                            ),
                            if (nowPlayingItem.label(context.localized) != nowPlayingItem.title)
                              Text(
                                nowPlayingItem.label(context.localized) ?? "",
                                style: Theme.of(context).textTheme.bodyMedium,
                                textAlign: TextAlign.start,
                                maxLines: 2,
                              ),
                            Text(
                              playState?.playMethod ?? "",
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.start,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 125),
                        child: AspectRatio(
                          aspectRatio: 0.7,
                          child: FocusButton(
                            onTap: () => nowPlayingItem.navigateTo(context),
                            child: Container(
                              decoration: FladderTheme.defaultPosterDecoration,
                              clipBehavior: Clip.hardEdge,
                              child: FladderImage(image: nowPlayingItem.getPosters?.primary),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
