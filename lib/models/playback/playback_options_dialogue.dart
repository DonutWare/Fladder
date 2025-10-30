import 'package:flutter/material.dart';

import 'package:collection/collection.dart';

import 'package:fladder/models/video_stream_model.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/localization_helper.dart';

Future<PlaybackType?> showPlaybackTypeSelection({
  required BuildContext context,
  required Set<PlaybackType> options,
}) async {
  PlaybackType? playbackType;

  await showDialog(
    context: context,
    useSafeArea: false,
    builder: (context) => PlaybackDialogue(
      options: options,
      onClose: (type) {
        playbackType = type;
        Navigator.of(context).pop();
      },
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
    return Dialog(
      child: Column(
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
          ...options.mapIndexed(
            (index, type) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: FocusButton(
                autoFocus: index == 0,
                onTap: () {
                  onClose(type);
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    spacing: 8,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(type.icon),
                      Text(type.name(context)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }
}
