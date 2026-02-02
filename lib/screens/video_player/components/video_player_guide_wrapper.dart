import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/items/channel_model.dart';
import 'package:fladder/models/items/channel_program.dart';
import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/models/playback/tv_playback_model.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/screens/live_tv/live_tv_guide.dart';
import 'package:fladder/screens/shared/default_alert_dialog.dart';
import 'package:fladder/screens/video_player/tv_player_controls.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/localization_helper.dart';

class VideoPlayerGuideWrapper extends StatefulWidget {
  final Widget child;
  const VideoPlayerGuideWrapper({
    required this.child,
    super.key,
  });

  @override
  State<VideoPlayerGuideWrapper> createState() => _VideoPlayerGuideWrapperState();
}

class _VideoPlayerGuideWrapperState extends State<VideoPlayerGuideWrapper> {
  bool guideVisible = false;
  final Duration animDuration = const Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: animDuration,
      color: guideVisible ? Theme.of(context).colorScheme.surface : Colors.transparent,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: AnimatedSwitcher(
              duration: animDuration,
              child: guideVisible
                  ? _GuideOverview(
                      closeGuide: () => setState(() {
                        guideVisible = false;
                      }),
                    )
                  : const SizedBox.shrink(),
            ),
          ),
          FocusButton(
            onTap: () {
              if (!guideVisible) return;
              setState(() {
                guideVisible = false;
              });
            },
            child: Container(
              color: Colors.black,
              child: AnimatedFractionallySizedBox(
                duration: animDuration,
                widthFactor: guideVisible ? 0.5 : 1.0,
                heightFactor: guideVisible ? 0.5 : 1.0,
                alignment: Alignment.topLeft,
                child: widget.child,
              ),
            ),
          ),
          if (!guideVisible)
            Visibility.maintain(
              visible: !guideVisible,
              child: ExcludeFocusTraversal(
                excluding: guideVisible,
                child: IgnorePointer(
                  ignoring: guideVisible,
                  child: TvPlayerControls(
                    showGuide: (value) {
                      setState(() {
                        guideVisible = value;
                      });
                    },
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _GuideOverview extends ConsumerStatefulWidget {
  final Function() closeGuide;
  const _GuideOverview({
    required this.closeGuide,
  });

  @override
  ConsumerState<_GuideOverview> createState() => _GuideOverviewState();
}

class _GuideOverviewState extends ConsumerState<_GuideOverview> {
  ChannelProgram? _selectedProgram;
  ChannelModel? _selectedChannel;

  @override
  void initState() {
    super.initState();
    final tvModel = ref.read(playBackModel);
    final tv = tvModel is TvPlaybackModel ? tvModel : null;

    _selectedProgram = tv?.currentProgram;
  }

  @override
  Widget build(BuildContext context) {
    final tvModel = ref.watch(playBackModel.select((value) => value is TvPlaybackModel ? value : null));

    final currentChanel = tvModel?.channel;
    final currentProgram = _selectedProgram ?? tvModel?.currentProgram;

    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: SizedBox(
              width: constraints.maxWidth * 0.5,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    SizedBox(
                      height: 125,
                      child: FladderImage(
                        image: currentChanel?.images?.primary,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Text(
                      currentProgram?.name ?? "",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(currentProgram?.subLabel(context) ?? ""),
                    const Divider(),
                    Expanded(
                      child: Row(
                        spacing: 12,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: SizedBox(
                              width: 200,
                              child: AspectRatio(
                                aspectRatio: 0.75,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: FladderTheme.defaultPosterDecoration.borderRadius,
                                  ),
                                  foregroundDecoration: FladderTheme.defaultPosterDecoration,
                                  clipBehavior: Clip.hardEdge,
                                  child: FladderImage(
                                    image: currentProgram?.images?.primary,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              currentProgram?.overview ?? "",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      spacing: 8,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        FilledButton(
                          onPressed: () {
                            setState(() {
                              _selectedProgram = null;
                            });
                            widget.closeGuide();
                          },
                          child: Text(context.localized.close),
                        ),
                        FilledButton(
                          onPressed: () {
                            ref.read(playbackModelHelper).loadTVChannel(_selectedProgram?.channel);
                            widget.closeGuide();
                          },
                          child: Text(
                            _selectedProgram?.startDate.isAfter(DateTime.now()) ?? false
                                ? context.localized.watchChannel(_selectedChannel?.name ?? "")
                                : context.localized.watch,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            child: LiveTvGuide(
              currentChannel: currentChanel,
              selectedProgram: tvModel?.currentProgram,
              onProgramSelected: (program, channel) async {
                if (_selectedProgram == program && currentChanel != channel) {
                  await showDefaultAlertDialog(
                    context,
                    context.localized.switchChannel,
                    context.localized.switchChannelDesc(program.name, channel.name),
                    (currentContext) async {
                      Navigator.of(currentContext).pop();
                      ref.read(playbackModelHelper).loadTVChannel(channel);
                      widget.closeGuide();
                    },
                    context.localized.watch,
                    (currentContext) async {
                      Navigator.of(currentContext).pop();
                    },
                    context.localized.decline,
                  );
                } else {
                  setState(() {
                    _selectedProgram = program;
                    _selectedChannel = channel;
                  });
                }
              },
              onLongPressProgram: (program, channel) {
                if (channel != currentChanel) {
                  showDefaultAlertDialog(
                    context,
                    context.localized.switchChannel,
                    context.localized.switchChannelDesc(program.name, channel.name),
                    (currentContext) async {
                      Navigator.of(currentContext).pop();
                      ref.read(playbackModelHelper).loadTVChannel(channel);
                      widget.closeGuide();
                    },
                    context.localized.watch,
                    (currentContext) async {
                      Navigator.of(currentContext).pop();
                    },
                    context.localized.decline,
                  );
                }
              },
              horizontalScrollController: ScrollController(),
            ),
          )
        ],
      );
    });
  }
}
