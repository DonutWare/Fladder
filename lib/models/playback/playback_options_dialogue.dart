import 'package:flutter/material.dart';

import 'package:fladder/models/video_stream_model.dart';
import 'package:fladder/util/localization_helper.dart';

Future<PlaybackType?> showPlaybackTypeSelection({
  required BuildContext context,
  required Set<PlaybackType> options,
}) async {
  PlaybackType? playbackType;

  await showDialog(
    context: context,
    useSafeArea: false,
    builder: (context) => Dialog(
      child: PlaybackDialogue(
        options: options,
        onClose: (type) {
          playbackType = type;
          Navigator.of(context).pop();
        },
      ),
    ),
  );
  return playbackType;
}

class PlaybackDialogue extends StatelessWidget {
  final Set<PlaybackType> options;
  final Function(PlaybackType type) onClose;
  const PlaybackDialogue({required this.options, required this.onClose, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16).add(const EdgeInsets.only(top: 16, bottom: 8)),
          child: Text(
            context.localized.playbackType,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const Divider(),
        ...options.map((type) => ListTile(
              title: Text(type.name(context)),
              leading: Icon(type.icon),
              onTap: () {
                onClose(type);
              },
            ))
      ],
    );
  }
}
