import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:palette_generator_master/palette_generator_master.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/sync/sync_provider_helpers.dart';
import 'package:fladder/providers/sync_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/screens/syncing/sync_button.dart';
import 'package:fladder/screens/syncing/sync_item_details.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/refresh_state.dart';
import 'package:fladder/util/router_extension.dart';
import 'package:fladder/widgets/navigation_scaffold/components/settings_user_icon.dart';
import 'package:fladder/widgets/shared/item_actions.dart';
import 'package:fladder/widgets/shared/modal_bottom_sheet.dart';
import 'package:fladder/widgets/shared/pull_to_refresh.dart';

Future<Color?> getDominantColor(ImageProvider imageProvider) async {
  final paletteGenerator = await PaletteGeneratorMaster.fromImageProvider(
    imageProvider,
    size: const Size(200, 200),
    maximumColorCount: 20,
  );

  return paletteGenerator.dominantColor?.color;
}

class DetailScaffold extends ConsumerStatefulWidget {
  final String label;
  final ItemBaseModel? item;
  final List<ItemAction>? Function(BuildContext context)? actions;
  final Color? backgroundColor;
  final ImagesData? backDrops;
  final Function(EdgeInsets padding) content;
  final Future<void> Function()? onRefresh;
  const DetailScaffold({
    required this.label,
    this.item,
    this.actions,
    this.backgroundColor,
    required this.content,
    this.backDrops,
    this.onRefresh,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DetailScaffoldState();
}

class _DetailScaffoldState extends ConsumerState<DetailScaffold> {
  List<ImageData>? lastImages;
  ImageData? backgroundImage;
  Color? dominantColor;

  ImageProvider? _lastRequestedImage;

  @override
  void didUpdateWidget(covariant DetailScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    updateImage();
    _updateDominantColor();
  }

  void updateImage() {
    if (lastImages == null) {
      lastImages = widget.backDrops?.backDrop;
      backgroundImage = widget.backDrops?.randomBackDrop;
    }
  }

  Future<void> _updateDominantColor() async {
    if (!ref.read(clientSettingsProvider.select((value) => value.deriveColorsFromItem))) return;
    final newImage = widget.item?.getPosters?.logo;
    if (newImage == null) return;

    final provider = newImage.imageProvider;
    _lastRequestedImage = provider;

    final newColor = await getDominantColor(provider);

    if (!mounted || _lastRequestedImage != provider) return;

    setState(() {
      dominantColor = newColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final padding = EdgeInsets.symmetric(horizontal: size.width / 25);
    final backGroundColor = Theme.of(context).colorScheme.surface.withValues(alpha: 0.8);
    final minHeight = 450.0.clamp(0, size.height).toDouble();
    final maxHeight = size.height - 10;
    final sideBarPadding = AdaptiveLayout.of(context).sideBarWidth;
    final newColorScheme = dominantColor != null
        ? ColorScheme.fromSeed(
            seedColor: dominantColor!,
            brightness: Theme.brightnessOf(context),
            dynamicSchemeVariant: ref.watch(clientSettingsProvider.select((value) => value.schemeVariant)),
          )
        : null;
    final amoledBlack = ref.watch(clientSettingsProvider.select((value) => value.amoledBlack));
    final amoledOverwrite = amoledBlack ? Colors.black : null;
    return Theme(
      data: Theme.of(context)
          .copyWith(
            colorScheme: newColorScheme,
          )
          .copyWith(
            scaffoldBackgroundColor: amoledOverwrite,
            cardColor: amoledOverwrite,
            canvasColor: amoledOverwrite,
            colorScheme: newColorScheme?.copyWith(
              surface: amoledOverwrite,
              surfaceContainerHighest: amoledOverwrite,
              surfaceContainerLow: amoledOverwrite,
            ),
          ),
      child: Builder(builder: (context) {
        return PullToRefresh(
          onRefresh: () async {
            await widget.onRefresh?.call();
            setState(() {
              if (context.mounted) {
                if (widget.backDrops?.backDrop?.contains(backgroundImage) == true) {
                  backgroundImage = widget.backDrops?.randomBackDrop;
                }
              }
            });
          },
          refreshOnStart: true,
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            extendBodyBehindAppBar: true,
            body: Stack(
              children: [
                SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Stack(
                    children: [
                      SizedBox(
                        height: maxHeight,
                        width: size.width,
                        child: FladderImage(
                          image: backgroundImage,
                          blurOnly: true,
                        ),
                      ),
                      if (backgroundImage != null)
                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: EdgeInsets.only(left: sideBarPadding),
                            child: ShaderMask(
                              shaderCallback: (bounds) => LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.white,
                                  Colors.white,
                                  Colors.white,
                                  Colors.white,
                                  Colors.white,
                                  Colors.white.withValues(alpha: 0),
                                ],
                              ).createShader(bounds),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: double.infinity,
                                  minHeight: minHeight - 20,
                                  maxHeight: maxHeight.clamp(minHeight, 2500) - 20,
                                ),
                                child: FadeInImage(
                                  placeholder: ResizeImage(
                                    backgroundImage!.imageProvider,
                                    height: maxHeight ~/ 1.5,
                                  ),
                                  placeholderColor: Colors.transparent,
                                  fit: BoxFit.cover,
                                  alignment: Alignment.topCenter,
                                  placeholderFit: BoxFit.cover,
                                  excludeFromSemantics: true,
                                  image: ResizeImage(
                                    backgroundImage!.imageProvider,
                                    height: maxHeight ~/ 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      Container(
                        width: double.infinity,
                        height: maxHeight + 10,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Theme.of(context).colorScheme.surface.withValues(alpha: 0),
                              Theme.of(context).colorScheme.surface.withValues(alpha: 0.10),
                              Theme.of(context).colorScheme.surface.withValues(alpha: 0.35),
                              Theme.of(context).colorScheme.surface.withValues(alpha: 0.85),
                              Theme.of(context).colorScheme.surface,
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: size.height,
                        width: size.width,
                        color: widget.backgroundColor,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 0,
                          top: MediaQuery.of(context).padding.top,
                        ),
                        child: FocusScope(
                          autofocus: true,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: size.height,
                              maxWidth: size.width,
                            ),
                            child: widget.content(
                              padding.copyWith(
                                left: sideBarPadding + 25 + MediaQuery.paddingOf(context).left,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //Top row buttons
                if (AdaptiveLayout.inputDeviceOf(context) != InputDevice.dPad)
                  IconTheme(
                    data: IconThemeData(color: Theme.of(context).colorScheme.onSurface),
                    child: Padding(
                      padding: MediaQuery.paddingOf(context)
                          .copyWith(left: sideBarPadding + MediaQuery.paddingOf(context).left)
                          .add(
                            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          ),
                      child: Row(
                        children: [
                          IconButton.filledTonal(
                            style: IconButton.styleFrom(
                              backgroundColor: backGroundColor,
                            ),
                            onPressed: () => context.router.popBack(),
                            icon: Padding(
                              padding:
                                  EdgeInsets.all(AdaptiveLayout.inputDeviceOf(context) == InputDevice.pointer ? 0 : 4),
                              child: const BackButtonIcon(),
                            ),
                          ),
                          const Spacer(),
                          AnimatedSize(
                            duration: const Duration(milliseconds: 250),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: backGroundColor, borderRadius: FladderTheme.defaultShape.borderRadius),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (widget.item != null) ...[
                                    ref.watch(syncedItemProvider(widget.item)).when(
                                          error: (error, stackTrace) => const SizedBox.shrink(),
                                          data: (syncedItem) {
                                            if (syncedItem == null &&
                                                ref.read(userProvider.select(
                                                  (value) => value?.canDownload ?? false,
                                                )) &&
                                                widget.item?.syncAble == true) {
                                              return IconButton(
                                                onPressed: () =>
                                                    ref.read(syncProvider.notifier).addSyncItem(context, widget.item!),
                                                icon: const Icon(
                                                  IconsaxPlusLinear.arrow_down_2,
                                                ),
                                              );
                                            } else if (syncedItem != null) {
                                              return IconButton(
                                                onPressed: () => showSyncItemDetails(context, syncedItem, ref),
                                                icon: SyncButton(item: widget.item!, syncedItem: syncedItem),
                                              );
                                            }
                                            return const SizedBox.shrink();
                                          },
                                          loading: () => const SizedBox.shrink(),
                                        ),
                                    Builder(
                                      builder: (context) {
                                        final newActions = widget.actions?.call(context);
                                        if (AdaptiveLayout.inputDeviceOf(context) == InputDevice.pointer) {
                                          return PopupMenuButton(
                                            tooltip: context.localized.moreOptions,
                                            enabled: newActions?.isNotEmpty == true,
                                            icon: Icon(
                                              widget.item!.type.icon,
                                              color: Theme.of(context).colorScheme.onSurface,
                                            ),
                                            itemBuilder: (context) => newActions?.popupMenuItems(useIcons: true) ?? [],
                                          );
                                        } else {
                                          return IconButton(
                                            onPressed: () => showBottomSheetPill(
                                              context: context,
                                              content: (context, scrollController) => ListView(
                                                controller: scrollController,
                                                shrinkWrap: true,
                                                children: newActions?.listTileItems(context, useIcons: true) ?? [],
                                              ),
                                            ),
                                            icon: Icon(
                                              widget.item!.type.icon,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                  if (AdaptiveLayout.inputDeviceOf(context) == InputDevice.pointer)
                                    Builder(
                                      builder: (context) => Tooltip(
                                        message: context.localized.refresh,
                                        child: IconButton(
                                          onPressed: () => context.refreshData(),
                                          icon: const Icon(IconsaxPlusLinear.refresh),
                                        ),
                                      ),
                                    ),
                                  if (AdaptiveLayout.layoutModeOf(context) == LayoutMode.single ||
                                      AdaptiveLayout.viewSizeOf(context) == ViewSize.phone)
                                    Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 6),
                                      child: const SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: SettingsUserIcon(),
                                      ),
                                    ),
                                  if (AdaptiveLayout.layoutModeOf(context) == LayoutMode.single)
                                    Tooltip(
                                        message: context.localized.home,
                                        child: IconButton(
                                          onPressed: () => context.navigateTo(const DashboardRoute()),
                                          icon: const Icon(IconsaxPlusLinear.home),
                                        )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
