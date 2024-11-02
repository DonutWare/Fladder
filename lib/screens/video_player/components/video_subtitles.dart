import 'dart:async';

import 'package:fladder/providers/settings/subtitle_settings_provider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit_video/media_kit_video.dart';

import 'package:fladder/models/settings/subtitle_settings_model.dart';

class VideoSubtitles extends ConsumerStatefulWidget {
  final VideoController controller;
  final bool overLayed;
  const VideoSubtitles({
    required this.controller,
    this.overLayed = false,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VideoSubtitlesState();
}

class _VideoSubtitlesState extends ConsumerState<VideoSubtitles> {
  late List<String> subtitle = widget.controller.player.state.subtitle;
  StreamSubscription<List<String>>? subscription;

  @override
  void initState() {
    subscription = widget.controller.player.stream.subtitle.listen((value) {
      setState(() {
        subtitle = value;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(subtitleSettingsProvider);
    final padding = MediaQuery.of(context).padding;
    final text = [
      for (final line in subtitle)
        if (line.trim().isNotEmpty) line.trim(),
    ].join('\n');

    if (widget.controller.player.platform?.configuration.libass ?? false) {
      return const IgnorePointer(child: SizedBox());
    } else {
      return SubtitleText(
        subModel: settings,
        padding: padding,
        offset: (widget.overLayed ? 0.5 : settings.verticalOffset),
        text: text,
      );
    }
  }
}
