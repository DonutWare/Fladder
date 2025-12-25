import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/providers/directory_browser_provider.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/pull_to_refresh.dart';

class ControlLibraryLocationEditor extends StatelessWidget {
  final VirtualFolderInfo library;
  final List<String> locations;
  final Function(String folder)? onAdd;
  final Function(String folder)? onRemove;
  const ControlLibraryLocationEditor({
    required this.library,
    required this.onAdd,
    this.locations = const [],
    this.onRemove,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final locations = library.locations ?? [];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  context.localized.folders,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                onPressed: () {
                  showAdaptiveDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) => DirectorySelectionDialog(
                      onSelect: (path) {
                        onAdd?.call(path);
                      },
                    ),
                  );
                },
                icon: const Icon(IconsaxPlusBold.add_circle),
              )
            ],
          ),
          ...locations.map(
            (folder) => Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      folder,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  IconButton.filled(
                    icon: const Icon(IconsaxPlusLinear.trash),
                    style: IconButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.errorContainer,
                      foregroundColor: Theme.of(context).colorScheme.error,
                    ),
                    onPressed: onRemove != null ? () => onRemove!(folder) : null,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DirectorySelectionDialog extends ConsumerWidget {
  final String? startDirectory;
  final Function(String path)? onSelect;
  const DirectorySelectionDialog({
    this.startDirectory,
    this.onSelect,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final browserState = ref.watch(directoryBrowserProvider);
    final parentFolder = browserState.parentFolder;
    final currentPath = browserState.currentPath;
    final paths = browserState.paths;
    final isLoading = browserState.loading;
    final hasParentDirectory =
        parentFolder != null && parentFolder.isNotEmpty == true && paths.contains(parentFolder) == false;
    return Dialog(
      child: PullToRefresh(
        onRefresh: () async => ref.read(directoryBrowserProvider.notifier).fetchFolders(startDirectory),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          context.localized.selectFolderToAdd,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      if (isLoading)
                        const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      else
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.close),
                        )
                    ],
                  ),
                  if (currentPath != null)
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        context.localized.selectedPath(currentPath),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  const Divider(),
                  if (hasParentDirectory) ...[
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Row(
                        spacing: 8,
                        children: [
                          const Icon(IconsaxPlusLinear.arrow_left_1),
                          Text(context.localized.systemRootFolder),
                        ],
                      ),
                      onTap: isLoading ? null : () => ref.read(directoryBrowserProvider.notifier).moveToRoot(),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Row(
                        spacing: 8,
                        children: [
                          const Icon(IconsaxPlusLinear.arrow_left_1),
                          Text(parentFolder),
                        ],
                      ),
                      onTap: isLoading
                          ? null
                          : () => ref.read(directoryBrowserProvider.notifier).fetchFolders(parentFolder),
                    ),
                    const Divider(),
                  ],
                  Flexible(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      children: [
                        ...paths.map(
                          (path) => ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Row(
                              spacing: 8,
                              children: [
                                const Icon(IconsaxPlusLinear.arrow_right_3),
                                Expanded(child: Text(path)),
                              ],
                            ),
                            onTap: () => ref.read(directoryBrowserProvider.notifier).fetchFolders(path),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FilledButton(
                    onPressed: !isLoading && onSelect != null && currentPath != null
                        ? () {
                            onSelect?.call(currentPath);
                            Navigator.of(context).pop();
                          }
                        : null,
                    child: Text(context.localized.select),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
              if (isLoading)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainerLowest.withAlpha(175),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
