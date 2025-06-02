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

    final serverImageCards = serverImages?.map((image) {
          final selected = selectedImage == null;
          return Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
                aspectRatio: image.ratio,
                child: Tooltip(
                  message: "Server image",
                  child: Container(
                    decoration: BoxDecoration(
                      color: selected ? Theme.of(context).colorScheme.primary : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: Colors.transparent, width: 4, strokeAlign: BorderSide.strokeAlignInside),
                    ),
                    child: Card(
                      color: selected ? Theme.of(context).colorScheme.onPrimary : null,
                      child: InkWell(
                        onTap: () => ref.read(editItemProvider.notifier).selectImage(widget.type, null),
                        child: CachedNetworkImage(
                          cacheKey: image.hashCode.toString(),
                          imageUrl: image.url ?? "",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Transform.translate(
                  offset: const Offset(2, 2),
                  child: IconButton.filledTonal(
                    style: FilledButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.error,
                      foregroundColor: Theme.of(context).colorScheme.onError,
                      iconColor: Theme.of(context).colorScheme.onError,
                    ),
                    onPressed: () async {
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
                              child: const Text(
                                "Delete",
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Icons.delete_rounded),
                  ),
                ),
              )
            ],
          );
        }) ??
        [];

    final imageCards = [...customImages, ...images].map((image) {
      final selected = switch (widget.type) {
        ImageType.backdrop => selections.contains(image),
        _ => selectedImage == image,
      };
      return Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: image.ratio,
            child: Tooltip(
              message: "${image.providerName} - ${image.language} \n${image.width}x${image.height}",
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: selected ? Theme.of(context).colorScheme.primary : Colors.transparent,
                      width: 4,
                      strokeAlign: BorderSide.strokeAlignInside),
                ),
                child: Card(
                  color: selected ? Theme.of(context).colorScheme.onPrimary : null,
                  child: InkWell(
                    onTap: () => ref.read(editItemProvider.notifier).selectImage(widget.type, image),
                    child: image.imageData != null
                        ? Image(image: Image.memory(image.imageData!).image)
                        : CachedNetworkImage(
                            imageUrl: image.url ?? "",
                          ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }).toList();
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
          trailing: Switch.adaptive(
            value: includeAllImages,
            onChanged: (value) {
              ref.read(editItemProvider.notifier).setIncludeImages(value);
              loadAll();
            },
          ),
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
                children: [...serverImageCards, ...imageCards],
              ),
              if (loading) const Center(child: CircularProgressIndicator.adaptive(strokeCap: StrokeCap.round)),
              if (!loading && [...serverImageCards, ...imageCards].isEmpty)
                Center(child: Text("No ${widget.type.value}s found"))
            ],
          ),
        ),
      ],
    );
  }
}
