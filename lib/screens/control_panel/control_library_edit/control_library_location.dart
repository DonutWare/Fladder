import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/providers/control_panel/control_libraries_provider.dart';
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
              const Expanded(
                child: Text(
                  "Folders",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
    final directorSystem = ref.watch(controlLibrariesProvider.select((value) => value.systemFolders));
    final hasParentDirectory = directorSystem?.parentFolder != null &&
        directorSystem?.parentFolder?.isNotEmpty == true &&
        directorSystem?.paths.contains(directorSystem.parentFolder) == false;
    return Dialog(
      child: PullToRefresh(
        onRefresh: () async => ref.read(controlLibrariesProvider.notifier).fetchFolders(startDirectory),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Select folder to add",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close),
                  )
                ],
              ),
              if (directorSystem?.currentPath != null)
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    "Selected path: ${directorSystem?.currentPath ?? ''}",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              const Divider(),
              if (hasParentDirectory) ...[
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Row(
                    spacing: 8,
                    children: [
                      Icon(IconsaxPlusLinear.arrow_left_1),
                      Text("System default"),
                    ],
                  ),
                  onTap: () => ref.read(controlLibrariesProvider.notifier).moveToRoot(),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Row(
                    spacing: 8,
                    children: [
                      Icon(IconsaxPlusLinear.arrow_left_1),
                      Text(directorSystem?.parentFolder ?? ''),
                    ],
                  ),
                  onTap: () => ref.read(controlLibrariesProvider.notifier).fetchFolders(directorSystem?.parentFolder),
                ),
                const Divider(),
              ],
              Flexible(
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: [
                    ...?directorSystem?.paths.map(
                      (path) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Row(
                          spacing: 8,
                          children: [
                            Icon(IconsaxPlusLinear.arrow_right_3),
                            Expanded(child: Text(path)),
                          ],
                        ),
                        onTap: () => ref.read(controlLibrariesProvider.notifier).fetchFolders(path),
                      ),
                    ),
                  ],
                ),
              ),
              FilledButton(
                onPressed: onSelect != null && directorSystem?.currentPath != null
                    ? () {
                        onSelect?.call(directorSystem?.currentPath ?? "");
                        Navigator.of(context).pop();
                      }
                    : null,
                child: Text("Select"),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
