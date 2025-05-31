import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/screens/shared/media/poster_widget.dart';
import 'package:fladder/widgets/shared/horizontal_list.dart';

class PosterRow extends ConsumerStatefulWidget {
  final List<ItemBaseModel> posters;
  final String label;
  final Function()? onLabelClick;
  final EdgeInsets contentPadding;
  const PosterRow({
    required this.posters,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16),
    required this.label,
    this.onLabelClick,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PosterRowState();
}

class _PosterRowState extends ConsumerState<PosterRow> {
  late final controller = ScrollController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HorizontalList(
      contentPadding: widget.contentPadding,
      label: widget.label,
      onLabelClick: widget.onLabelClick,
      items: widget.posters,
      itemBuilder: (context, index) {
        final poster = widget.posters[index];
        return PosterWidget(
          poster: poster,
          key: Key(poster.id),
        );
      },
    );
  }
}
