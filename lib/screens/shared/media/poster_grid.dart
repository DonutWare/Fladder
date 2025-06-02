import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sticky_headers/sticky_headers.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/screens/shared/media/poster_widget.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/sticky_header_text.dart';

class PosterGrid extends ConsumerWidget {
  final String? name;
  final List<ItemBaseModel> posters;
  final Widget? Function(BuildContext context, int index)? itemBuilder;
  final bool stickyHeader;
  final Function(VoidCallback action, ItemBaseModel item)? onPressed;
  const PosterGrid(
      {this.stickyHeader = true, this.itemBuilder, this.name, required this.posters, this.onPressed, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context).width /
        (AdaptiveLayout.poster(context).gridRatio *
            ref.watch(clientSettingsProvider.select((value) => value.posterSize)));
    final decimals = size - size.toInt();
    var posterBuilder = GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: size.toInt(),
        mainAxisSpacing: (8 * decimals) + 8,
        crossAxisSpacing: (8 * decimals) + 8,
        childAspectRatio: AdaptiveLayout.poster(context).ratio,
      ),
      itemCount: posters.length,
      itemBuilder: itemBuilder ??
          (context, index) {
            return PosterWidget(
              poster: posters[index],
              onPressed: onPressed,
            );
          },
    );

    if (stickyHeader) {
      //Translate fixes small peaking pixel line
      return StickyHeader(
        header: name != null
            ? StickyHeaderText(label: name ?? "")
            : const SizedBox(
                height: 16,
              ),
        content: posterBuilder,
      );
    } else {
      return Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              name ?? "",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          posterBuilder,
        ],
      );
    }
  }
}
