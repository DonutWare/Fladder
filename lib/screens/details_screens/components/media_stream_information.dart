import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/items/media_streams_model.dart';
import 'package:fladder/screens/details_screens/components/label_title_item.dart';
import 'package:fladder/util/localization_helper.dart';

class MediaStreamInformation extends ConsumerWidget {
  final MediaStreamsModel mediaStream;
  final Function(int index)? onAudioIndexChanged;
  final Function(int index)? onSubIndexChanged;
  const MediaStreamInformation(
      {required this.mediaStream, this.onAudioIndexChanged, this.onSubIndexChanged, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (mediaStream.videoStreams.isNotEmpty)
          _StreamOptionSelect(
            label: Text(context.localized.video),
            current: (mediaStream.videoStreams.first).prettyName,
            itemBuilder: (context) => mediaStream.videoStreams
                .map(
                  (e) => PopupMenuItem(
                    value: e,
                    padding: EdgeInsets.zero,
                    child: Text(e.prettyName),
                  ),
                )
                .toList(),
          ),
        if (mediaStream.audioStreams.isNotEmpty)
          _StreamOptionSelect(
            label: Text(context.localized.audio),
            current: mediaStream.currentAudioStream?.displayTitle ?? "",
            itemBuilder: (context) => [AudioStreamModel.no(), ...mediaStream.audioStreams]
                .map(
                  (e) => PopupMenuItem(
                    value: e,
                    padding: EdgeInsets.zero,
                    child: textWidget(context,
                        selected: mediaStream.currentAudioStream?.index == e.index, label: e.displayTitle),
                    onTap: () => onAudioIndexChanged?.call(e.index),
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
                  (e) => PopupMenuItem(
                    value: e,
                    padding: EdgeInsets.zero,
                    child: textWidget(context,
                        selected: mediaStream.currentSubStream?.index == e.index, label: e.displayTitle),
                    onTap: () => onSubIndexChanged?.call(e.index),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }

  Widget textWidget(BuildContext context, {required bool selected, required String label}) {
    return Container(
      height: kMinInteractiveDimension,
      width: double.maxFinite,
      color: selected ? Theme.of(context).colorScheme.primary : null,
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: selected ? Theme.of(context).colorScheme.onPrimary : null,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}

class _StreamOptionSelect<T> extends StatelessWidget {
  final Text label;
  final String current;
  final List<PopupMenuEntry<T>> Function(BuildContext context) itemBuilder;
  const _StreamOptionSelect({
    required this.label,
    required this.current,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleMedium;
    const padding = EdgeInsets.all(6);
    final itemList = itemBuilder(context);
    return LabelTitleItem(
      title: label,
      content: Flexible(
        child: PopupMenuButton(
          tooltip: '',
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          enabled: itemList.length > 1,
          itemBuilder: itemBuilder,
          menuPadding: const EdgeInsets.symmetric(vertical: 16),
          padding: padding,
          child: Padding(
            padding: padding,
            child: Material(
              textStyle: textStyle?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: itemList.length > 1 ? Theme.of(context).colorScheme.primary : null),
              color: Colors.transparent,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      current,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const SizedBox(width: 6),
                  if (itemList.length > 1)
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: Theme.of(context).colorScheme.primary,
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
