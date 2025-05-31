import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/screens/home_screen.dart';
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

  @override
  void didUpdateWidget(covariant DetailScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (lastImages == null) {
      lastImages = widget.backDrops?.backDrop;
      setState(() {
        backgroundImage = widget.backDrops?.randomBackDrop;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width / 25);
    final backGroundColor = Theme.of(context).colorScheme.surface.withValues(alpha: 0.8);
    final minHeight = 450.0.clamp(0, MediaQuery.sizeOf(context).height).toDouble();
    final maxHeight = MediaQuery.sizeOf(context).height - 10;
    final sideBarPadding = AdaptiveLayout.of(context).sideBarWidth;
    return PullToRefresh(
      onRefresh: () async {
        await widget.onRefresh?.call();
        setState(() {
          if (widget.backDrops?.backDrop?.contains(backgroundImage) == true) {
            backgroundImage = widget.backDrops?.randomBackDrop;
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
                    width: MediaQuery.sizeOf(context).width,
                    child: FladderImage(
                      image: backgroundImage,
                      blurOnly: true,
                    ),
                  ),
                  if (backgroundImage != null)
                    Align(
                      alignment: Alignment.topCenter,
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
                            placeholder: backgroundImage!.imageProvider,
                            placeholderColor: Colors.transparent,
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                            placeholderFit: BoxFit.cover,
                            excludeFromSemantics: true,
                            placeholderFilterQuality: FilterQuality.low,
                            image: backgroundImage!.imageProvider,
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
                    height: MediaQuery.sizeOf(context).height,
                    width: MediaQuery.sizeOf(context).width,
                    color: widget.backgroundColor,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 0,
                      top: MediaQuery.of(context).padding.top,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.sizeOf(context).height,
                        maxWidth: MediaQuery.sizeOf(context).width,
                      ),
                      child: widget.content(padding.copyWith(
                        left: sideBarPadding + 25 + MediaQuery.paddingOf(context).left,
                      )),
                    ),
                  ),
                ],
              ),
            ),
            //Top row buttons
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
                        padding: EdgeInsets.all(AdaptiveLayout.of(context).inputDevice == InputDevice.pointer ? 0 : 4),
                        child: const Icon(IconsaxPlusLinear.arrow_left_2),
                      ),
                    ),
                    const Spacer(),
                    AnimatedSize(
                      duration: const Duration(milliseconds: 250),
                      child: Container(
                        decoration:
                            BoxDecoration(color: backGroundColor, borderRadius: FladderTheme.defaultShape.borderRadius),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (widget.item != null) ...[
                              Builder(
                                builder: (context) {
                                  final newActions = widget.actions?.call(context);
                                  if (AdaptiveLayout.of(context).inputDevice == InputDevice.pointer) {
                                    return PopupMenuButton(
                                      tooltip: context.localized.moreOptions,
                                      enabled: newActions?.isNotEmpty == true,
                                      icon: Icon(widget.item!.type.icon),
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
                            if (AdaptiveLayout.of(context).inputDevice == InputDevice.pointer)
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
                                child: PopupMenuButton(
                                  icon: const Icon(IconsaxPlusLinear.home),
                                  itemBuilder: (context) => HomeTabs.values
                                      .map(
                                        (value) => PopupMenuItem(
                                          onTap: () => value.navigate(context),
                                          child: Row(
                                            spacing: 6,
                                            children: [
                                              Icon(value.icon),
                                              Text(value.name),
                                            ],
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
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
  }
}
