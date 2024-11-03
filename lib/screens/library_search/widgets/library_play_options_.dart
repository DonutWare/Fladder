import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/localization_helper.dart';

Future<void> showLibraryPlayOptions(
  BuildContext context,
  String label, {
  Function()? playVideos,
  Function()? viewGallery,
}) {
  return showDialog(
      context: context,
      builder: (context) => LibraryPlayOptions(
            label: label,
            playVideos: playVideos,
            viewGallery: viewGallery,
          ));
}

class LibraryPlayOptions extends ConsumerWidget {
  final String label;
  final Function()? playVideos;
  final Function()? viewGallery;
  const LibraryPlayOptions({required this.label, required this.playVideos, required this.viewGallery, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Divider(),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (playVideos != null)
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        playVideos?.call();
                      },
                      child: Text(context.localized.playVideos),
                    ),
                  if (viewGallery != null)
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        viewGallery?.call();
                      },
                      child: Text(context.localized.viewPhotos),
                    )
                ].addInBetween(const SizedBox(height: 8)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
