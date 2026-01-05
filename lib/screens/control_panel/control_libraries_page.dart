import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/collection_types.dart';
import 'package:fladder/providers/control_panel/control_libraries_provider.dart';
import 'package:fladder/screens/control_panel/control_library_edit/segments/basic_options_section.dart';
import 'package:fladder/screens/control_panel/control_library_edit/segments/chapter_images_section.dart';
import 'package:fladder/screens/control_panel/control_library_edit/segments/fetchers_section.dart';
import 'package:fladder/screens/control_panel/control_library_edit/segments/location_editor_section.dart';
import 'package:fladder/screens/control_panel/control_library_edit/segments/metadata_section.dart';
import 'package:fladder/screens/control_panel/control_library_edit/segments/new_library_section.dart';
import 'package:fladder/screens/control_panel/control_library_edit/segments/save_metadata_section.dart';
import 'package:fladder/screens/control_panel/control_library_edit/segments/segment_providers_section.dart';
import 'package:fladder/screens/control_panel/control_library_edit/segments/subtitle_downloads_section.dart';
import 'package:fladder/screens/control_panel/control_library_edit/segments/trickplay_section.dart';
import 'package:fladder/screens/library/library_screen.dart';
import 'package:fladder/screens/metadata/edit_item.dart';
import 'package:fladder/screens/settings/settings_scaffold.dart';
import 'package:fladder/screens/shared/default_alert_dialog.dart';
import 'package:fladder/screens/shared/fladder_snackbar.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/refresh_state.dart';
import 'package:fladder/widgets/shared/filled_button_await.dart';
import 'package:fladder/widgets/shared/item_actions.dart';
import 'package:fladder/widgets/shared/pull_to_refresh.dart';

@RoutePage()
class ControlLibrariesPage extends ConsumerWidget {
  const ControlLibrariesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final libraries = ref.watch(controlLibrariesProvider);
    final provider = ref.read(controlLibrariesProvider.notifier);
    final selectedLibrary = libraries.selectedLibrary;
    final selectedFolder = libraries.newVirtualFolder ??
        libraries.virtualFolders.firstWhereOrNull(
          (folder) => folder.itemId == selectedLibrary?.id,
        );

    final collectionType = libraries.currentCollectionType;

    final currentOptions = selectedFolder?.libraryOptions;
    final availableOptions = libraries.availableOptions;

    final isNewFolder = libraries.newVirtualFolder != null;

    return ClipRect(
      clipBehavior: Clip.hardEdge,
      child: PullToRefresh(
        onRefresh: () => provider.fetchInfo(),
        child: (context) => SettingsScaffold(
          bottomActions: [
            if (selectedFolder == null)
              FilledButtonAwait(
                onPressed: () {
                  provider.createNewLibrary();
                },
                child: Row(
                  spacing: 8,
                  children: [
                    const Icon(IconsaxPlusLinear.add),
                    Text(context.localized.create),
                  ],
                ),
              )
            else ...[
              FilledButtonAwait.tonal(
                onPressed: () => provider.fetchInfo(clearSelected: true),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(context.localized.cancel),
                  ],
                ),
              ),
              FilledButtonAwait(
                onPressed: libraries.isSaveAble
                    ? () async {
                        String? responseMessage = await provider.commitLibraryOptions(
                          selectedFolder.itemId,
                          currentOptions,
                        );
                        if (responseMessage != null) {
                          fladderSnackbar(context, title: responseMessage);
                        } else {
                          fladderSnackbar(context, title: context.localized.saved);
                        }
                      }
                    : null,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(IconsaxPlusLinear.book_saved),
                    const SizedBox(width: 8),
                    Text(context.localized.save),
                  ],
                ),
              ),
            ],
          ],
          label: context.localized.library(2),
          items: [
            LibraryRow(
              views: libraries.availableLibraries,
              selectedView: libraries.selectedLibrary,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              onSelected: provider.selectLibrary,
              enableImageCache: false,
              onLongPress: (view) {},
              viewActions: (view) => [
                ItemActionButton(
                  label: Text(context.localized.editMetadata),
                  icon: const Icon(IconsaxPlusLinear.gallery_edit),
                  action: () async {
                    await showEditItemPopup(
                      context,
                      view.id,
                      options: {MetaEditOptions.primary},
                    );
                  },
                ),
                ItemActionButton(
                  label: Text(context.localized.delete),
                  icon: const Icon(IconsaxPlusLinear.trash),
                  action: () async {
                    await showDefaultAlertDialog(
                      context,
                      context.localized.deleteLibraryConfirmTitle,
                      context.localized.deleteLibraryConfirmMessage(view.name),
                      (context) {
                        provider.deleteLibrary(view);
                        context.refreshData();
                        Navigator.of(context).pop();
                      },
                      context.localized.accept,
                      (context) {
                        context.refreshData();
                        Navigator.of(context).pop();
                      },
                      context.localized.cancel,
                    );
                  },
                ),
              ],
            ),
            if (selectedFolder == null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Center(
                  child: Text(context.localized.noLibrarySelected),
                ),
              )
            else
              ...[
                if (isNewFolder)
                  NewLibrarySection(
                    selectedFolder: selectedFolder,
                  ),
                LocationEditorSection(selectedFolder: selectedFolder),
                if (collectionType != null) ...[
                  BasicOptionsSection(
                    selectedFolder: selectedFolder,
                    currentOptions: currentOptions,
                  ),
                  MetadataSection(
                    currentOptions: currentOptions,
                    cultures: libraries.cultures,
                    countries: libraries.countries,
                  ),
                  if (currentOptions?.localMetadataReaderOrder?.isEmpty == false)
                    SaveMetadataSection(currentOptions: currentOptions),
                  FetchersSection(currentOptions: currentOptions),
                  if (collectionType.videos == true) ...[
                    SegmentProvidersSection(
                      currentOptions: currentOptions,
                      availableOptions: availableOptions,
                    ),
                    TrickplaySection(currentOptions: currentOptions),
                    ChapterImagesSection(currentOptions: currentOptions),
                  ],
                  if (collectionType.hasSubtitles == true)
                    SubtitleDownloadsSection(
                      currentOptions: currentOptions,
                      cultures: libraries.cultures,
                      availableOptions: availableOptions,
                    ),
                ],
              ].addInBetween(const SizedBox(height: 16)),
          ],
        ),
      ),
    );
  }
}
