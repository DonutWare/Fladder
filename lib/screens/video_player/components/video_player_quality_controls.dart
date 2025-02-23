import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/playback/playback_model.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/util/localization_helper.dart';

Future<void> openQualityOptions(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (context) => const _QualityOptionsDialogue(),
  );
}

class _QualityOptionsDialogue extends ConsumerWidget {
  const _QualityOptionsDialogue();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playbackModel = ref.watch(playBackModel);
    final qualityOptions = playbackModel?.bitRateOptions;

    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              context.localized.qualityOptionsTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(height: 6),
          const Divider(),
          Flexible(
            child: ListView(
              shrinkWrap: true,
              children: qualityOptions?.entries
                      .map(
                        (entry) => RadioListTile(
                          value: entry.value,
                          groupValue: true,
                          onChanged: (value) async {
                            final newModel = await playbackModel?.setQualityOption(
                              qualityOptions.map(
                                (key, value) => MapEntry(key, key == entry.key ? true : false),
                              ),
                            );
                            ref.read(playBackModel.notifier).update((state) => newModel);
                            if (newModel != null) {
                              await ref.read(playbackModelHelper).shouldReload(newModel);
                            }
                            context.router.maybePop();
                          },
                          title: Text(entry.key.label(context)),
                        ),
                      )
                      .toList() ??
                  [],
            ),
          ),
        ],
      ),
    );
  }
}
