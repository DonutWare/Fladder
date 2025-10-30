import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/providers/settings/book_viewer_settings_provider.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/string_extensions.dart';
import 'package:fladder/widgets/shared/enum_selection.dart';
import 'package:fladder/widgets/shared/fladder_slider.dart';
import 'package:fladder/widgets/shared/item_actions.dart';
import 'package:fladder/widgets/shared/modal_side_sheet.dart';

Future<void> showBookViewerSettings(
  BuildContext context,
) async {
  if (AdaptiveLayout.of(context).isDesktop) {
    return showModalSideSheet(context, content: const BookViewerSettingsScreen());
  } else {
    return showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) => const BookViewerSettingsScreen(),
    );
  }
}

class BookViewerSettingsScreen extends ConsumerWidget {
  const BookViewerSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(bookViewerSettingsProvider);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Reader settings",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
        const Divider(),
        if (!AdaptiveLayout.of(context).isDesktop) ...{
          ListTile(
            title: Row(
              children: [
                const Text("Screen Brightness"),
                Flexible(
                  child: Opacity(
                    opacity: settings.screenBrightness == null ? 0.5 : 1,
                    child: FladderSlider(
                      value: settings.screenBrightness ?? 1.0,
                      min: 0,
                      max: 1,
                      onChanged: (value) => ref.read(bookViewerSettingsProvider.notifier).setScreenBrightness(value),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => ref.read(bookViewerSettingsProvider.notifier).setScreenBrightness(null),
                  icon: Opacity(
                    opacity: settings.screenBrightness != null ? 0.5 : 1,
                    child: Icon(
                      Icons.brightness_auto_rounded,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                )
              ],
            ),
          ),
        },
        ListTile(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: EnumSelection(
                  label: const Text("Read direction"),
                  current: settings.readDirection.name.toUpperCaseSplit(),
                  itemBuilder: (context) => ReadDirection.values
                      .map((value) => ItemActionButton(
                            label: Text(value.name.toUpperCaseSplit()),
                            action: () => ref
                                .read(bookViewerSettingsProvider.notifier)
                                .update((state) => state.copyWith(readDirection: value)),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
        ListTile(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: EnumSelection(
                  label: const Text("Init zoom"),
                  current: settings.initZoomState.name.toUpperCaseSplit(),
                  itemBuilder: (context) => InitZoomState.values
                      .map((value) => ItemActionButton(
                            label: Text(value.name.toUpperCaseSplit()),
                            action: () => ref
                                .read(bookViewerSettingsProvider.notifier)
                                .update((state) => state.copyWith(initZoomState: value)),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
        ListTile(
          onTap: () => ref
              .read(bookViewerSettingsProvider.notifier)
              .update((state) => state.copyWith(disableScrollOnZoom: !settings.disableScrollOnZoom)),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Expanded(
                flex: 3,
                child: Text("Disable slide page gestures when zoomed"),
              ),
              const Spacer(),
              Switch.adaptive(
                value: settings.disableScrollOnZoom,
                onChanged: (value) => ref
                    .read(bookViewerSettingsProvider.notifier)
                    .update((state) => state.copyWith(disableScrollOnZoom: value)),
              )
            ],
          ),
        ),
        ListTile(
          onTap: () => ref
              .read(bookViewerSettingsProvider.notifier)
              .update((state) => state.copyWith(cachePageZoom: !settings.cachePageZoom)),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Expanded(
                flex: 3,
                child: Text("Cache page zoom state"),
              ),
              const Spacer(),
              Switch.adaptive(
                value: settings.cachePageZoom,
                onChanged: (value) => ref
                    .read(bookViewerSettingsProvider.notifier)
                    .update((incoming) => incoming.copyWith(cachePageZoom: value)),
              )
            ],
          ),
        ),
        ListTile(
          onTap: () => ref
              .read(bookViewerSettingsProvider.notifier)
              .update((state) => state.copyWith(keepPageZoom: !settings.keepPageZoom)),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Expanded(
                flex: 3,
                child: Text("Keep page zoom"),
              ),
              const Spacer(),
              Switch.adaptive(
                value: settings.keepPageZoom,
                onChanged: (value) => ref
                    .read(bookViewerSettingsProvider.notifier)
                    .update((incoming) => incoming.copyWith(keepPageZoom: value)),
              )
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).padding.bottom,
        )
      ],
    );
  }
}
