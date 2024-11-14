import 'dart:async';

import 'package:ficonsax/ficonsax.dart';
import 'package:fladder/providers/settings/photo_view_settings_provider.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/widgets/shared/fladder_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

import 'package:fladder/models/items/photos_model.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/util/duration_extensions.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:window_manager/window_manager.dart';

class SimpleVideoPlayer extends ConsumerStatefulWidget {
  final PhotoModel video;
  final bool showOverlay;
  final VoidCallback onTapped;
  const SimpleVideoPlayer({required this.video, required this.showOverlay, required this.onTapped, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SimpleVideoPlayerState();
}

class _SimpleVideoPlayerState extends ConsumerState<SimpleVideoPlayer> with WindowListener, WidgetsBindingObserver {
  final Player player = Player(
    configuration: const PlayerConfiguration(title: "nl.jknaapen.fladder", libass: true),
  );
  late VideoController controller = VideoController(player);
  late String videoUrl = "";

  bool playing = false;
  bool wasPlaying = false;
  Duration position = Duration.zero;
  Duration lastPosition = Duration.zero;
  Duration duration = Duration.zero;

  List<StreamSubscription> subscriptions = [];

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        if (playing) player.play();
        break;
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        if (playing) player.pause();
        break;
      default:
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    WidgetsBinding.instance.addObserver(this);
    playing = player.state.playing;
    position = player.state.position;
    duration = player.state.duration;
    Future.microtask(() async => {_init()});
  }

  @override
  void onWindowMinimize() {
    if (playing) player.pause();
    super.onWindowMinimize();
  }

  void _init() async {
    final Map<String, String?> directOptions = {
      'Static': 'true',
      'mediaSourceId': widget.video.id,
      'api_key': ref.read(userProvider)?.credentials.token,
    };

    final params = Uri(queryParameters: directOptions).query;

    videoUrl = '${ref.read(userProvider)?.server ?? ""}/Videos/${widget.video.id}/stream?$params';

    subscriptions.addAll(
      [
        player.stream.playing.listen((event) {
          setState(() {
            playing = event;
          });
          if (playing) {
            WakelockPlus.enable();
          } else {
            WakelockPlus.disable();
          }
        }),
        player.stream.position.listen((event) {
          setState(() {
            position = event;
          });
        }),
        player.stream.completed.listen((event) {
          if (event) {
            _restartVideo();
          }
        }),
        player.stream.duration.listen((event) {
          setState(() {
            duration = event;
          });
        }),
      ],
    );
    await player.setVolume(ref.watch(photoViewSettingsProvider.select((value) => value.mute)) ? 0 : 100);
    await player.open(Media(videoUrl), play: !ref.watch(photoViewSettingsProvider).autoPlay);
  }

  void _restartVideo() {
    if (ref.read(photoViewSettingsProvider.select((value) => value.repeat))) {
      player.play();
    }
  }

  @override
  void dispose() {
    Future.microtask(() async {
      await player.dispose();
    });
    for (final s in subscriptions) {
      s.cancel();
    }
    WidgetsBinding.instance.removeObserver(this);
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context)
        .textTheme
        .titleMedium
        ?.copyWith(fontWeight: FontWeight.bold, shadows: [const Shadow(blurRadius: 2)]);
    ref.listen(
      photoViewSettingsProvider.select((value) => value.mute),
      (previous, next) {
        if (previous != next) {
          player.setVolume(next ? 0 : 100);
        }
      },
    );
    return GestureDetector(
      onTap: widget.onTapped,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: FladderImage(
              image: widget.video.thumbnail?.primary,
              enableBlur: true,
              fit: BoxFit.contain,
            ),
          ),
          //Fixes small overlay problems with thumbnail
          Transform.scale(
            scaleY: 1.004,
            child: Video(
              fit: BoxFit.contain,
              fill: const Color.fromARGB(0, 123, 62, 62),
              controller: controller,
              controls: NoVideoControls,
              wakelock: false,
            ),
          ),
          IgnorePointer(
            ignoring: !widget.showOverlay,
            child: AnimatedOpacity(
              opacity: widget.showOverlay ? 1 : 0,
              duration: const Duration(milliseconds: 250),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12)
                        .add(EdgeInsets.only(bottom: 80 + MediaQuery.of(context).padding.bottom)),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: 40,
                                    child: FladderSlider(
                                      min: 0.0,
                                      max: duration.inMilliseconds.toDouble(),
                                      value: position.inMilliseconds.toDouble().clamp(
                                            0,
                                            duration.inMilliseconds.toDouble(),
                                          ),
                                      onChangeEnd: (e) async {
                                        await player.seek(Duration(milliseconds: e ~/ 1));
                                        if (wasPlaying) {
                                          player.play();
                                        }
                                      },
                                      onChangeStart: (value) {
                                        wasPlaying = player.state.playing;
                                        player.pause();
                                      },
                                      onChanged: (e) {
                                        setState(() => position = Duration(milliseconds: e ~/ 1));
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    child: Row(
                                      children: [
                                        Text(position.readAbleDuration, style: textStyle),
                                        const Spacer(),
                                        Text((duration - position).readAbleDuration, style: textStyle),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            IconButton(
                              color: Theme.of(context).colorScheme.onSurface,
                              onPressed: () {
                                player.playOrPause();
                              },
                              icon: Icon(
                                player.state.playing ? IconsaxBold.pause_circle : IconsaxBold.play_circle,
                                shadows: [
                                  BoxShadow(blurRadius: 16, spreadRadius: 2, color: Colors.black.withOpacity(0.15))
                                ],
                              ),
                            )
                          ],
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
