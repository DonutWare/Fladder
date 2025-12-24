import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart';
import 'package:fladder/models/item_editing_model.dart';
import 'package:fladder/providers/edit_item_provider.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/screens/settings/settings_list_tile.dart';
import 'package:fladder/screens/shared/file_picker.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/localization_helper.dart';

class EditImageContent extends ConsumerStatefulWidget {
  final ImageType type;
  const EditImageContent({required this.type, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditImageContentState();
}

class _EditImageContentState extends ConsumerState<EditImageContent> {
  bool loading = false;

  Future<void> loadAll() async {
    setState(() {
      loading = true;
    });
    await ref.read(editItemProvider.notifier).fetchRemoteImages(type: widget.type);
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => loadAll());
  }

  @override
  Widget build(BuildContext context) {
    final posterSize = MediaQuery.sizeOf(context).width /
        (AdaptiveLayout.poster(context).gridRatio *
            ref.watch(clientSettingsProvider.select((value) => value.posterSize)));
    final decimal = posterSize - posterSize.toInt();
    final includeAllImages = ref.watch(editItemProvider.select((value) => value.includeAllImages));
    final images = ref.watch(editItemProvider.select((value) => switch (widget.type) {
          ImageType.backdrop => value.backdrop.images,
          ImageType.logo => value.logo.images,
          ImageType.primary || _ => value.primary.images,
        }));

    final customImages = ref.watch(editItemProvider.select((value) => switch (widget.type) {
          ImageType.backdrop => value.backdrop.customImages,
          ImageType.logo => value.logo.customImages,
          ImageType.primary || _ => value.primary.customImages,
        }));

    final selectedImage = ref.watch(editItemProvider.select((value) => switch (widget.type) {
          ImageType.logo => value.logo.selected,
          ImageType.primary => value.primary.selected,
          _ => null,
        }));

    final serverImages = ref.watch(editItemProvider.select((value) => switch (widget.type) {
          ImageType.logo => value.logo.serverImages,
          ImageType.primary => value.primary.serverImages,
          ImageType.backdrop => value.backdrop.serverImages,
          _ => null,
        }));

    final selections = ref.watch(editItemProvider.select((value) => switch (widget.type) {
          ImageType.backdrop => value.backdrop.selection,
          _ => [],
        }));

    Widget buildImageCard(dynamic image, {required bool isServerImage, required bool isSelected}) {
      final tooltipMessage =
          isServerImage ? "Server image" : "${image.providerName} - ${image.language} \n${image.width}x${image.height}";

      Future<void> showDeleteDialog() async {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Delete image"),
            content: const Text("Deleting is permanent are you sure?"),
            actions: [
              ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: const Text("Cancel")),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.error,
                  foregroundColor: Theme.of(context).colorScheme.onError,
                  iconColor: Theme.of(context).colorScheme.onError,
                ),
                onPressed: () async {
                  await ref.read(editItemProvider.notifier).deleteImage(widget.type, image);
                  Navigator.of(context).pop();
                },
                child: const Text("Delete"),
              )
            ],
          ),
        );
      }

      return Tooltip(
        message: tooltipMessage,
        child: FocusButton(
          onTap: () => ref.read(editItemProvider.notifier).selectImage(widget.type, isServerImage ? null : image),
          onLongPress: isServerImage
              ? () async {
                  await showDeleteDialog();
                }
              : null,
          onSecondaryTapDown: isServerImage
              ? (details) async {
                  await showDeleteDialog();
                }
              : null,
          child: Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
                aspectRatio: image.ratio,
                child: Container(
                  foregroundDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: isServerImage
                            ? Theme.of(context).colorScheme.primary
                            : isSelected
                                ? Colors.white
                                : Colors.transparent,
                        width: 4,
                        strokeAlign: BorderSide.strokeAlignInside),
                  ),
                  child: Card(
                    color: isSelected ? Theme.of(context).colorScheme.onPrimary : null,
                    child: isServerImage
                        ? CachedNetworkImage(
                            cacheKey: image.hashCode.toString(),
                            imageUrl: image.url ?? "",
                          )
                        : (image.imageData != null
                            ? Image(image: Image.memory(image.imageData!).image)
                            : CachedNetworkImage(
                                imageUrl: image.url ?? "",
                              )),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    final allImageCards = [
      ...?serverImages?.map((image) {
        final selected = selectedImage == null;
        return buildImageCard(image, isServerImage: true, isSelected: selected);
      }),
      ...([...customImages, ...images].map((image) {
        final selected = switch (widget.type) {
          ImageType.backdrop => selections.contains(image),
          _ => selectedImage == image,
        };
        return buildImageCard(image, isServerImage: false, isSelected: selected);
      }))
    ];
    final hintLabel = switch (AdaptiveLayout.inputDeviceOf(context)) {
      InputDevice.touch || InputDevice.dPad => context.localized.metadataImageLongPressTouch,
      InputDevice.pointer => context.localized.metadataImageLongPressClick,
    };
    return Column(
      children: [
        SizedBox(
          height: 80,
          child: FilePickerBar(
            multipleFiles: switch (widget.type) {
              ImageType.backdrop => true,
              _ => false,
            },
            extensions: FladderFile.imageTypes,
            urlPicked: (url) {
              final newFile = EditingImageModel(providerName: "Custom(URL)", url: url);
              ref.read(editItemProvider.notifier).addCustomImages(widget.type, [newFile]);
            },
            onFilesPicked: (file) {
              final newFiles = file.map(
                (e) => EditingImageModel(
                  providerName: "Custom(${e.name})",
                  imageData: e.data,
                ),
              );
              ref.read(editItemProvider.notifier).addCustomImages(widget.type, newFiles);
            },
          ),
        ),
        SettingsListTile(
          label: const Text("Include all languages"),
          trailing: Switch(
            value: includeAllImages,
            onChanged: (value) {
              ref.read(editItemProvider.notifier).setIncludeImages(value);
              loadAll();
            },
          ),
        ),
        Text(
          hintLabel,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Flexible(
          child: Stack(
            children: [
              GridView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: (8 * decimal) + 8,
                  crossAxisSpacing: (8 * decimal) + 8,
                  childAspectRatio: 1.0,
                  crossAxisCount: posterSize.toInt(),
                ),
                children: allImageCards,
              ),
              if (loading) const Center(child: CircularProgressIndicator.adaptive(strokeCap: StrokeCap.round)),
              if (!loading && allImageCards.isEmpty) Center(child: Text("No ${widget.type.value}s found"))
            ],
          ),
        ),
      ],
    );
  }
}
