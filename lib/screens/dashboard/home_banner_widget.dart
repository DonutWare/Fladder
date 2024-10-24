import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/settings/home_settings_model.dart';
import 'package:fladder/providers/settings/home_settings_provider.dart';
import 'package:fladder/screens/shared/media/carousel_banner.dart';
import 'package:fladder/screens/shared/media/media_banner.dart';

class HomeBannerWidget extends ConsumerWidget {
  final List<ItemBaseModel> posters;
  const HomeBannerWidget({required this.posters, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bannerType = ref.watch(homeSettingsProvider.select((value) => value.homeBanner));
    final maxHeight = (MediaQuery.sizeOf(context).shortestSide * 0.6).clamp(125.0, 375.0);
    return switch (bannerType) {
      HomeBanner.carousel => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CarouselBanner(
              items: posters,
              maxHeight: maxHeight,
            ),
            const SizedBox(height: 24)
          ],
        ),
      HomeBanner.banner => MediaBanner(
          items: posters,
          maxHeight: maxHeight,
        ),
      _ => const SizedBox.shrink(),
    };
  }
}
