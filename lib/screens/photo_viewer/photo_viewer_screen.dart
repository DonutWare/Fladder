import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:fladder/main.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/photos_model.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/screens/photo_viewer/photo_viewer_controls.dart';
import 'package:fladder/providers/settings/photo_view_settings_provider.dart';
import 'package:fladder/screens/photo_viewer/simple_video_player.dart';
import 'package:fladder/screens/shared/default_title_bar.dart';
import 'package:fladder/util/adaptive_layout.dart';
import 'package:fladder/util/item_base_model/item_base_model_extensions.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/themes_data.dart';
import 'package:fladder/widgets/navigation_scaffold/components/fladder_appbar.dart';
import 'package:fladder/widgets/shared/animated_icon.dart';
import 'package:fladder/widgets/shared/elevated_icon.dart';
import 'package:fladder/widgets/shared/hover_widget.dart';
import 'package:fladder/widgets/shared/item_actions.dart';
import 'package:fladder/widgets/shared/modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhotoViewerScreen extends ConsumerStatefulWidget {
  final List<PhotoModel>? items;
  final int indexOfSelected;
  final Future<List<PhotoModel>>? loadingItems;
  const PhotoViewerScreen({
    this.items,
    this.indexOfSelected = 0,
    this.loadingItems,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PhotoViewerScreenState();
}

class _PhotoViewerScreenState extends ConsumerState<PhotoViewerScreen> with WidgetsBindingObserver {
  late List<PhotoModel> photos = widget.items ?? [];
  late final ExtendedPageController controller = ExtendedPageController(initialPage: widget.indexOfSelected);
  double currentScale = 1.0;
  late int currentPage = widget.indexOfSelected.clamp(0, photos.length - 1);
  bool showInterface = true;
  bool toolbarHover = false;

  late final double topPadding = MediaQuery.of(context).viewPadding.top;
  late final double bottomPadding = MediaQuery.of(context).viewPadding.bottom;
  bool loadingItems = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        SystemChrome.setEnabledSystemUIMode(!showInterface ? SystemUiMode.leanBack : SystemUiMode.edgeToEdge,
            overlays: []);
        SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarDividerColor: Colors.transparent,
        ));
      default:
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        cacheNeighbors(widget.indexOfSelected, 2);
        if (widget.loadingItems != null) {
          setState(() {
            loadingItems = true;
          });

          final newItems = await Future.value(widget.loadingItems);

          setState(() {
            photos = {...photos, ...newItems}.toList();
            loadingItems = false;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> removePhoto(ItemBaseModel photo) async {
    if (photos.length == 1) {
      Navigator.of(context).pop();
    } else {
      setState(() {
        photos.remove(photo);
      });
    }
  }

  void _showOverlay({bool? show}) {
    setState(() {
      showInterface = show ?? !showInterface;
    });
    SystemChrome.setEnabledSystemUIMode(
      !showInterface ? SystemUiMode.leanBack : SystemUiMode.edgeToEdge,
      overlays: [],
    );
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
    ));
  }

  final gestureConfig = GestureConfig(
    inertialSpeed: 300,
    initialAlignment: InitialAlignment.center,
    inPageView: true,
    initialScale: 1.0,
    maxScale: 6,
    minScale: 1,
    animationMinScale: 0.1,
    animationMaxScale: 7,
    cacheGesture: false,
    reverseMousePointerScrollDirection: true,
    hitTestBehavior: HitTestBehavior.translucent,
  );

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemesData.of(context).dark,
      child: PopScope(
        onPopInvokedWithResult: (didPop, result) =>
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []),
        child: MouseRegion(
          opaque: AdaptiveLayout.of(context).isDesktop,
          onEnter: (event) => setState(() => _showOverlay(show: true)),
          onExit: (event) => setState(() => _showOverlay(show: false)),
          child: Scaffold(
            appBar: photos.isEmpty
                ? const FladderAppbar(
                    automaticallyImplyLeading: true,
                  )
                : null,
            body: photos.isEmpty
                ? Center(
                    child: Text(context.localized.noItemsToShow),
                  )
                : buildViewer(),
          ),
        ),
      ),
    );
  }

  Widget buildViewer() {
    final currentPhoto = photos[currentPage];
    final imageHash = currentPhoto.images?.primary?.hash;
    return Stack(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: ref.watch(photoViewSettingsProvider.select((value) => value.theaterMode)) && imageHash != null
              ? Opacity(
                  key: Key(currentPhoto.id),
                  opacity: 0.7,
                  child: SizedBox.expand(
                    child: Image(
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                      image: BlurHashImage(imageHash),
                    ),
                  ),
                )
              : Container(
                  color: Colors.black,
                ),
        ),
        GestureDetector(
          onTapUp: (details) => _showOverlay(),
          onDoubleTapDown: AdaptiveLayout.of(context).isDesktop
              ? null
              : (details) async {
                  await openOptions(
                    context,
                    currentPhoto,
                    removePhoto,
                  );
                },
          onLongPress: () {
            if (currentPhoto.userData.isFavourite == true) {
              HapticFeedback.lightImpact();
            } else {
              markAsFavourite(currentPhoto, value: true);
              HapticFeedback.heavyImpact();
            }
          },
          child: ExtendedImageGesturePageView.builder(
            itemCount: photos.length,
            controller: controller,
            onPageChanged: (index) => setState(() {
              currentPage = index;
              cacheNeighbors(index, 3);
              SystemChrome.setEnabledSystemUIMode(!showInterface ? SystemUiMode.leanBack : SystemUiMode.edgeToEdge,
                  overlays: []);
            }),
            itemBuilder: (context, index) {
              final photo = photos[index];
              return ExtendedImage(
                key: Key(photo.id),
                fit: BoxFit.contain,
                mode: ExtendedImageMode.gesture,
                initGestureConfigHandler: (state) => gestureConfig,
                handleLoadingProgress: true,
                onDoubleTap: (state) {
                  return;
                },
                gaplessPlayback: true,
                loadStateChanged: (state) {
                  return Stack(
                    alignment: Alignment.center,
                    fit: StackFit.expand,
                    children: [
                      if (state.extendedImageLoadState != LoadState.completed)
                        Positioned.fill(
                          child: CachedNetworkImage(
                            fit: BoxFit.contain,
                            cacheManager: CustomCacheManager.instance,
                            imageUrl: photo.thumbnail?.primary?.path ?? "",
                          ),
                        ),
                      switch (state.extendedImageLoadState) {
                        LoadState.loading => const Center(
                            child: CircularProgressIndicator.adaptive(strokeCap: StrokeCap.round),
                          ),
                        LoadState.completed => switch (photo.internalType) {
                            FladderItemType.video => SimpleVideoPlayer(
                                onTapped: _showOverlay,
                                showOverlay: showInterface,
                                video: photos[index],
                              ),
                            _ => state.completedWidget,
                          },
                        LoadState.failed || _ => Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.all(24).copyWith(top: topPadding + 85),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(24),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        context.localized.failedToLoadImage,
                                        style: Theme.of(context).textTheme.bodyLarge,
                                      ),
                                      const SizedBox(height: 6),
                                      FilledButton.tonal(
                                        onPressed: () => state.reLoadImage(),
                                        child: Text(context.localized.retry),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                      }
                    ],
                  );
                },
                image: CachedNetworkImageProvider(
                  photo.images?.primary?.path ?? "",
                  cacheManager: CustomCacheManager.instance,
                ),
              );
            },
          ),
        ),
        IgnorePointer(
          ignoring: !showInterface,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: showInterface ? 1 : 0,
            child: PhotoViewerControls(
              padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
              currentIndex: currentPage,
              itemCount: photos.length,
              loadingMoreItems: loadingItems,
              pageController: controller,
              photo: currentPhoto,
              toggleOverlay: (value) => setState(() => showInterface = value ?? !showInterface),
              openOptions: () => openOptions(context, currentPhoto, removePhoto),
              onPhotoChanged: (photo) {
                setState(() {
                  int index = photos.indexOf(currentPhoto);
                  photos.remove(currentPhoto);
                  photos.insert(index, photo);
                });
              },
            ),
          ),
        ),
        if (AdaptiveLayout.of(context).isDesktop) ...{
          Align(
            alignment: Alignment.centerRight,
            child: HoverWidget(
              child: (visible) => AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: visible ? 1 : 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
                    alignment: Alignment.centerRight,
                    width: 50,
                    height: MediaQuery.sizeOf(context).height * 0.5,
                    child: IconButton.filledTonal(
                      style:
                          IconButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                      onPressed: () =>
                          controller.nextPage(duration: const Duration(milliseconds: 125), curve: Curves.easeInOut),
                      icon: const Icon(IconsaxBold.arrow_right_1),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: HoverWidget(
              child: (visible) => AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: visible ? 1 : 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: 50,
                    height: MediaQuery.sizeOf(context).height * 0.5,
                    child: IconButton.filledTonal(
                      style:
                          IconButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                      onPressed: () =>
                          controller.previousPage(duration: const Duration(milliseconds: 125), curve: Curves.easeInOut),
                      icon: const Icon(IconsaxBold.arrow_left),
                    ),
                  ),
                ),
              ),
            ),
          ),
        },
        if (AdaptiveLayout.of(context).isDesktop)
          AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: showInterface
                ? 1
                : toolbarHover
                    ? 1
                    : 0,
            child: Align(
              alignment: Alignment.topCenter,
              widthFactor: 1,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.5),
                      Colors.black.withOpacity(0),
                    ],
                  ),
                ),
                height: 45,
                child: MouseRegion(
                  onEnter: (event) => setState(() => toolbarHover = true),
                  onExit: (event) => setState(() => toolbarHover = false),
                  child: const Column(
                    children: [
                      DefaultTitleBar(
                        brightness: Brightness.dark,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        Align(
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: showInterface ? 0 : 1,
            child: AnimatedVisibilityIcon(
              key: Key(currentPhoto.id),
              isFilled: currentPhoto.userData.isFavourite,
              filledIcon: IconsaxBold.heart,
              outlinedIcon: IconsaxOutline.heart,
            ),
          ),
        )
      ],
    );
  }

  Future<void> openOptions(BuildContext context, PhotoModel currentPhoto, Function(ItemBaseModel item) onRemove) =>
      showBottomSheetPill(
        context: context,
        content: (context, scrollController) {
          return ListView(
            shrinkWrap: true,
            controller: scrollController,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Consumer(builder: (context, ref, child) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedIconButtonLabel(
                          label: context.localized.loop,
                          onPressed: () => ref
                              .read(photoViewSettingsProvider.notifier)
                              .update((state) => state.copyWith(repeat: !state.repeat)),
                          icon: ref.watch(photoViewSettingsProvider.select((value) => value.repeat))
                              ? IconsaxOutline.repeat
                              : IconsaxOutline.repeate_one,
                        ),
                        ElevatedIconButtonLabel(
                          label: context.localized.audio,
                          onPressed: () => ref
                              .read(photoViewSettingsProvider.notifier)
                              .update((state) => state.copyWith(mute: !state.mute)),
                          icon: ref.watch(photoViewSettingsProvider.select((value) => value.mute))
                              ? IconsaxOutline.volume_slash
                              : IconsaxOutline.volume_high,
                        ),
                        ElevatedIconButtonLabel(
                          label: context.localized.autoPlay,
                          onPressed: () => ref
                              .read(photoViewSettingsProvider.notifier)
                              .update((state) => state.copyWith(autoPlay: !state.autoPlay)),
                          icon: ref.watch(photoViewSettingsProvider.select((value) => value.autoPlay))
                              ? IconsaxOutline.play_remove
                              : IconsaxOutline.play,
                        ),
                        ElevatedIconButtonLabel(
                          label: context.localized.backgroundBlur,
                          onPressed: () => ref
                              .read(photoViewSettingsProvider.notifier)
                              .update((state) => state.copyWith(theaterMode: !state.theaterMode)),
                          icon: ref.watch(photoViewSettingsProvider.select((value) => value.theaterMode))
                              ? IconsaxOutline.filter_remove
                              : IconsaxOutline.filter,
                        ),
                      ].addInBetween(const SizedBox(width: 18)),
                    );
                  }),
                ),
              ),
              const Divider(),
              ...currentPhoto
                  .generateActions(
                    context,
                    ref,
                    exclude: {
                      ItemActions.details,
                      ItemActions.markPlayed,
                      ItemActions.markUnplayed,
                    },
                    onDeleteSuccesFully: onRemove,
                  )
                  .listTileItems(context, useIcons: true),
            ],
          );
        },
      );

  void markAsFavourite(PhotoModel photo, {bool? value}) {
    ref.read(userProvider.notifier).setAsFavorite(value ?? !photo.userData.isFavourite, photo.id);

    setState(() {
      int index = photos.indexOf(photo);
      photos.remove(photo);
      photos.insert(
          index, photo.copyWith(userData: photo.userData.copyWith(isFavourite: value ?? !photo.userData.isFavourite)));
    });
  }

  void cacheNeighbors(int index, int range) {
    photos
        .getRange((index - range).clamp(0, photos.length - 1), (index + range).clamp(0, photos.length - 1))
        .forEach((element) {
      precacheImage(
          CachedNetworkImageProvider(
            element.thumbnail?.primary?.path ?? "",
            cacheManager: CustomCacheManager.instance,
          ),
          context);
      if (AdaptiveLayout.of(context).isDesktop) {
        precacheImage(
            CachedNetworkImageProvider(
              element.images?.primary?.path ?? "",
              cacheManager: CustomCacheManager.instance,
            ),
            context);
      }
    });
  }
}
