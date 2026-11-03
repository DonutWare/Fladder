import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:auto_route/annotations.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/photo_queue_source.dart';
import 'package:fladder/models/items/photos_model.dart';
import 'package:fladder/providers/settings/photo_view_settings_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/providers/window_title_provider.dart';
import 'package:fladder/screens/photo_viewer/media_viewer/media_gesture_viewer.dart';
import 'package:fladder/screens/photo_viewer/photo_viewer_controls.dart';
import 'package:fladder/screens/photo_viewer/photo_viewer_info_panel.dart';
import 'package:fladder/screens/photo_viewer/photo_viewer_page.dart';
import 'package:fladder/screens/photo_viewer/simple_video_player.dart';
import 'package:fladder/screens/shared/default_title_bar.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/themes_data.dart';
import 'package:fladder/widgets/navigation_scaffold/components/fladder_app_bar.dart';
import 'package:fladder/widgets/shared/animated_icon.dart';
import 'package:fladder/widgets/shared/hover_widget.dart';

@RoutePage()
class PhotoViewerScreen extends ConsumerStatefulWidget {
  final List<PhotoModel>? items;
  final String? selected;
  final PhotoQueueSource? photoQueueSource;
  const PhotoViewerScreen({
    this.items,
    @QueryParam("selectedId") this.selected,
    this.photoQueueSource,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PhotoViewerScreenState();
}

class _PhotoViewerScreenState extends ConsumerState<PhotoViewerScreen> with WidgetsBindingObserver {
  late List<PhotoModel> photos = widget.items ?? [];
  late int currentPage = photos.indexWhere((value) => value.id == widget.selected).clamp(0, photos.length - 1);
  late final PhotoModel initialPhoto = photos[currentPage];
  final viewer = MediaViewerController();
  bool toolbarHover = false;

  late final double topPadding = MediaQuery.of(context).viewPadding.top;
  late final double bottomPadding = MediaQuery.of(context).viewPadding.bottom;
  int _totalPhotoCount = 0;
  int _nextFetchStartIndex = 0;
  bool _isFetchingMore = false;
  bool _isFetchDepleted = false;
  final Set<String> _loadedPhotoIds = {};

  static const int _fetchThreshold = 5;

  WindowTitleNotifier? _windowTitleNotifier;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
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
    _totalPhotoCount = photos.length;
    _nextFetchStartIndex = photos.length;
    _loadedPhotoIds.addAll(photos.map((p) => p.id));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _windowTitleNotifier = ref.read(windowTitleProvider.notifier);
      await _fetchMorePhotos();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _windowTitleNotifier?.removeTitle(this);
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

  void _onPhotoChanged(PhotoModel photo) {
    final index = photos.indexWhere((value) => value.id == photo.id);
    if (index == -1) return;
    setState(() => currentPage = index);
    cacheNeighbors(index, 3);
    if (photos.length - index <= _fetchThreshold) {
      unawaited(_fetchMorePhotos());
    }
    _windowTitleNotifier?.updateTitle(this, "${context.localized.mediaTypePhoto(1)} - ${photo.title}");
  }

  @override
  Widget build(BuildContext context) {
    final usesPointer = AdaptiveLayout.inputDeviceOf(context) != InputDevice.touch;
    final theaterMode = ref.watch(photoViewSettingsProvider.select((value) => value.theaterMode));
    final currentPhoto = photos.elementAtOrNull(currentPage);
    final imageHash = currentPhoto?.images?.primary?.hash;
    return Theme(
      data: ThemesData.of(context).dark,
      child: PopScope(
        onPopInvokedWithResult: (didPop, result) => SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge),
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: photos.isEmpty
              ? FladderAppBar(
                  automaticallyImplyLeading: true,
                  isDesktop: AdaptiveLayout.of(context).isDesktop,
                )
              : null,
          body: photos.isEmpty
              ? Center(
                  child: Text(context.localized.noItemsToShow),
                )
              : Stack(
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: theaterMode && imageHash != null
                          ? Opacity(
                              key: Key(currentPhoto!.id),
                              opacity: 0.7,
                              child: SizedBox.expand(
                                child: Image(
                                  fit: BoxFit.cover,
                                  image: BlurHashImage(imageHash),
                                ),
                              ),
                            )
                          : const SizedBox.expand(),
                    ),
                    MediaGestureViewer<PhotoModel>(
                      items: photos,
                      itemKey: (photo) => photo.id,
                      initialItem: initialPhoto,
                      controller: viewer,
                      usesPointer: usesPointer,
                      sideInfo: AdaptiveLayout.viewSizeOf(context) != ViewSize.phone,
                      background: Colors.transparent,
                      onItemChanged: _onPhotoChanged,
                      pageBuilder: _page,
                      overlayBuilder: _overlay,
                      infoBuilder: _info,
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _page(BuildContext context, PhotoModel photo, MediaPage page) {
    return GestureDetector(
      onLongPress: () {
        if (photo.userData.isFavourite == true) {
          HapticFeedback.lightImpact();
        } else {
          markAsFavourite(photo, value: true);
          HapticFeedback.heavyImpact();
        }
      },
      child: switch (photo.internalType) {
        FladderItemType.video => page.active
            ? SimpleVideoPlayer(
                onTapped: page.onTap,
                showOverlay: page.overlayVisible,
                video: photo,
              )
            : Image(
                fit: BoxFit.contain,
                image: photoImageProvider(photo.thumbnail?.primary?.path),
              ),
        _ => PhotoViewerPage(photo: photo, page: page),
      },
    );
  }

  Widget _info(BuildContext context, PhotoModel photo, MediaInfoPlacement placement) {
    final panel = PhotoViewerInfoPanel(
      photo: photo,
      asSheet: placement == MediaInfoPlacement.sheet,
      onClose: viewer.toggleInfo,
      onRemove: removePhoto,
    );
    if (placement == MediaInfoPlacement.sheet) return panel;
    return SafeArea(
      left: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, AdaptiveLayout.of(context).isDesktop ? 45 : 12, 12, 12),
        child: panel,
      ),
    );
  }

  Widget _overlay(BuildContext context, PhotoModel currentPhoto, MediaOverlay overlay) {
    return Stack(
      children: [
        IgnorePointer(
          ignoring: !overlay.visible,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: overlay.visible ? 1 : 0,
            child: PhotoViewerControls(
              padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
              currentIndex: overlay.index,
              itemCount: overlay.count,
              loadingMoreItems: _isFetchingMore,
              totalPhotoCount: _totalPhotoCount,
              onNext: viewer.next,
              onPrevious: viewer.previous,
              onAdvance: viewer.advance,
              photo: currentPhoto,
              toggleOverlay: (value) => viewer.showOverlay(visible: value ?? !overlay.visible),
              openOptions: viewer.toggleInfo,
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
        if (AdaptiveLayout.of(context).isDesktop && !overlay.infoOpen) ...{
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
                      onPressed: viewer.next,
                      icon: const Icon(IconsaxPlusBold.arrow_right_1),
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
                      onPressed: viewer.previous,
                      icon: const Icon(IconsaxPlusBold.arrow_left),
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
            opacity: overlay.visible || toolbarHover ? 1 : 0,
            child: Align(
              alignment: Alignment.topCenter,
              widthFactor: 1,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.5),
                      Colors.black.withValues(alpha: 0),
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
        IgnorePointer(
          child: Align(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: overlay.visible || overlay.infoOpen ? 0 : 1,
              child: AnimatedVisibilityIcon(
                key: Key(currentPhoto.id),
                isFilled: currentPhoto.userData.isFavourite,
                filledIcon: IconsaxPlusBold.heart,
                outlinedIcon: IconsaxPlusLinear.heart,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> markAsFavourite(PhotoModel photo, {bool? value}) async {
    await ref.read(userProvider.notifier).setAsFavorite(value ?? !photo.userData.isFavourite, photo.id);

    setState(() {
      int index = photos.indexOf(photo);
      photos.remove(photo);
      photos.insert(
          index, photo.copyWith(userData: photo.userData.copyWith(isFavourite: value ?? !photo.userData.isFavourite)));
    });
  }

  Future<void> _fetchMorePhotos() async {
    if (_isFetchingMore || _isFetchDepleted || widget.photoQueueSource == null) return;
    setState(() => _isFetchingMore = true);
    try {
      final result = await widget.photoQueueSource!.fetchPhotos(
        ref.read,
        startIndex: _nextFetchStartIndex,
      );
      if (!mounted) return;
      final newPhotos = result.items.where((p) => !_loadedPhotoIds.contains(p.id)).toList();
      _loadedPhotoIds.addAll(result.items.map((p) => p.id));
      _nextFetchStartIndex += result.items.length;
      setState(() {
        _totalPhotoCount = result.totalCount;
        photos.addAll(newPhotos);
        if (result.items.isEmpty || _nextFetchStartIndex >= result.totalCount) {
          _isFetchDepleted = true;
        }
      });
    } catch (e, stackTrace) {
      log('Photo queue fetch error: $e\n$stackTrace');
    } finally {
      if (mounted) setState(() => _isFetchingMore = false);
    }
  }

  void cacheNeighbors(int index, int range) {
    photos
        .getRange((index - range).clamp(0, photos.length - 1), (index + range).clamp(0, photos.length - 1))
        .forEach((element) {
      precacheImage(photoImageProvider(element.thumbnail?.primary?.path), context);
      if (AdaptiveLayout.of(context).isDesktop) {
        precacheImage(photoImageProvider(element.images?.primary?.path), context);
      }
    });
  }
}
