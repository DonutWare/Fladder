import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/screens/details_screens/components/label_title_item.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/enum_selection.dart';
import 'package:fladder/widgets/shared/item_actions.dart';

class MediaStreamInformation extends ConsumerWidget {
  final MediaStreamsModel mediaStream;
  final Function(int index)? onVersionIndexChanged;
  final Function(int index)? onAudioIndexChanged;
  final Function(int index)? onSubIndexChanged;
  const MediaStreamInformation({
    required this.mediaStream,
    required this.onVersionIndexChanged,
    this.onAudioIndexChanged,
    this.onSubIndexChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (mediaStream.versionStreams.isNotEmpty && mediaStream.versionStreams.length > 1)
          _StreamOptionSelect(
            label: Text(context.localized.version),
            current: mediaStream.currentVersionStream?.name ?? "",
            itemBuilder: (context) => mediaStream.versionStreams
                .map((e) => ItemActionButton(
                      selected: mediaStream.currentVersionStream == e,
                      label: textWidget(
                        context,
                        label: e.name,
                      ),
                      action: () => onVersionIndexChanged?.call(e.index),
                    ))
                .toList(),
          ),
        if (mediaStream.videoStreams.isNotEmpty)
          _StreamOptionSelect(
            label: Text(context.localized.video(1)),
            current: (mediaStream.videoStreams.first).prettyName,
            itemBuilder: (context) => mediaStream.videoStreams
                .map(
                  (e) => ItemActionButton(
                    label: Text(e.prettyName),
                  ),
                )
                .toList(),
          ),
        if (mediaStream.audioStreams.isNotEmpty)
          _StreamOptionSelect(
            label: Text(context.localized.audio(1)),
            current: mediaStream.currentAudioStream?.displayTitle ?? "",
            itemBuilder: (context) => [AudioStreamModel.no(), ...mediaStream.audioStreams]
                .map(
                  (e) => ItemActionButton(
                    selected: mediaStream.currentAudioStream?.index == e.index,
                    label: textWidget(
                      context,
                      label: e.displayTitle,
                    ),
                    action: () => onAudioIndexChanged?.call(e.index),
                  ),
                )
                .toList(),
          ),
        if (mediaStream.subStreams.isNotEmpty)
          _StreamOptionSelect(
            label: Text(context.localized.subtitles),
            current: mediaStream.currentSubStream?.displayTitle ?? "",
            itemBuilder: (context) => [SubStreamModel.no(), ...mediaStream.subStreams]
                .map(
                  (e) => ItemActionButton(
                    selected: mediaStream.currentSubStream?.index == e.index,
                    label: textWidget(
                      context,
                      label: e.displayTitle,
                    ),
                    action: () => onSubIndexChanged?.call(e.index),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }

  Widget textWidget(BuildContext context, {required String label}) {
    return Text(
      label,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

class _StreamOptionSelect<T> extends StatelessWidget {
  final Text label;
  final String current;
  final List<ItemAction> Function(BuildContext context) itemBuilder;
  const _StreamOptionSelect({
    required this.label,
    required this.current,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: LabelTitleItem(
        title: label,
        content: Flexible(
          child: EnumBox(
            current: current,
            itemBuilder: itemBuilder,
          ),
        ),
      ),
    );
  }
}
