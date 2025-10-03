import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/providers/edit_item_provider.dart';
import 'package:fladder/screens/metadata/edit_screens/edit_fields.dart';
import 'package:fladder/screens/metadata/edit_screens/edit_image_content.dart';
import 'package:fladder/screens/shared/fladder_snackbar.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/refresh_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<ItemBaseModel?> showEditItemPopup(
  BuildContext context,
  String itemId,
) async {
  ItemBaseModel? updatedItem;
  var shouldRefresh = false;
  await showDialog<bool>(
    context: context,
    useSafeArea: false,
    builder: (context) {
      Widget editWidget() => EditDialogSwitcher(
            id: itemId,
            itemUpdated: (newItem) => updatedItem = newItem,
            refreshOnClose: (refresh) => shouldRefresh = refresh,
          );
      return AdaptiveLayout.inputDeviceOf(context) == InputDevice.pointer
          ? Dialog(
              insetPadding: const EdgeInsets.all(64),
              child: editWidget(),
            )
          : Dialog.fullscreen(
              child: editWidget(),
            );
    },
  );
  if (shouldRefresh == true) {
    context.refreshData();
  }
  return updatedItem;
}

class EditDialogSwitcher extends ConsumerStatefulWidget {
  final String id;
  final Function(ItemBaseModel? newItem) itemUpdated;
  final Function(bool refresh) refreshOnClose;

  const EditDialogSwitcher({required this.id, required this.itemUpdated, required this.refreshOnClose, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditDialogSwitcherState();
}

class _EditDialogSwitcherState extends ConsumerState<EditDialogSwitcher> with TickerProviderStateMixin {
  late final TabController tabController = TabController(length: 5, vsync: this);

  Future<void> refreshEditor() async {
    return ref.read(editItemProvider.notifier).fetchInformation(widget.id);
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => refreshEditor());
  }

  @override
  Widget build(BuildContext context) {
    final currentItem = ref.watch(editItemProvider.select((value) => value.item));
    final saving = ref.watch(editItemProvider.select((value) => value.saving));
    final state = ref.watch(editItemProvider).editedJson;
    final generalFields = ref.watch(editItemProvider.notifier).getFields ?? {};
    final advancedFields = ref.watch(editItemProvider.notifier).advancedFields ?? {};

    Map<Tab, Widget> widgets = {
      const Tab(text: "General"): EditFields(fields: generalFields, json: state),
      const Tab(text: "Primary"): const EditImageContent(type: ImageType.primary),
      const Tab(text: "Logo"): const EditImageContent(type: ImageType.logo),
      const Tab(text: "Backdrops"): const EditImageContent(type: ImageType.backdrop),
      const Tab(text: "Advanced"): EditFields(fields: advancedFields, json: state),
    };

    return Card(
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: MediaQuery.paddingOf(context).top),
          Container(
            color: Theme.of(context).colorScheme.surface,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      currentItem?.detailedName(context) ?? currentItem?.name ?? "",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  IconButton(onPressed: () => refreshEditor(), icon: const Icon(IconsaxPlusLinear.refresh))
                ],
              ),
            ),
          ),
          Container(
            color: Theme.of(context).colorScheme.surface,
            child: TabBar(
              isScrollable: true,
              controller: tabController,
              tabs: widgets.keys.toList(),
            ),
          ),
          Flexible(child: TabBarView(controller: tabController, children: widgets.values.toList())),
          Container(
            color: Theme.of(context).colorScheme.surface,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: Text(context.localized.close)),
                  const SizedBox(width: 16),
                  FilledButton(
                    onPressed: saving
                        ? null
                        : () async {
                            final response = await ref.read(editItemProvider.notifier).saveInformation();
                            if (response != null && context.mounted) {
                              if (response.isSuccessful) {
                                widget.itemUpdated(response.body);
                                fladderSnackbar(context,
                                    title: context.localized.metaDataSavedFor(
                                        currentItem?.detailedName(context) ?? currentItem?.name ?? ""));
                              } else {
                                fladderSnackbarResponse(context, response);
                              }
                            }
                            widget.refreshOnClose(true);
                            Navigator.of(context).pop();
                          },
                    child: saving
                        ? SizedBox(
                            width: 21,
                            height: 21,
                            child: CircularProgressIndicator.adaptive(
                                backgroundColor: Theme.of(context).colorScheme.onPrimary, strokeCap: StrokeCap.round),
                          )
                        : Text(context.localized.save),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
