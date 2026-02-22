import 'package:fladder/util/fladder_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/screens/shared/flat_button.dart';
import 'package:fladder/util/duration_extensions.dart';
import 'package:fladder/util/localization_helper.dart';

class ItemDetailListWidget extends ConsumerStatefulWidget {
  final ItemBaseModel item;
  final Widget? iconOverlay;
  final double elevation;
  final List<Widget> actions;
  const ItemDetailListWidget(
      {super.key, required this.item, this.iconOverlay, this.elevation = 1, this.actions = const []});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ItemDetailListWidgetState();
}

class _ItemDetailListWidgetState extends ConsumerState<ItemDetailListWidget> {
  bool showImageOverlay = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: widget.elevation,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          FlatButton(
            onTap: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 32),
            child: Row(
              children: [
                MouseRegion(
                  onEnter: (event) => setState(() => showImageOverlay = true),
                  onExit: (event) => setState(() => showImageOverlay = false),
                  child: Stack(
                    children: [
                      FladderImage(image: widget.item.images?.primary),
                      if (widget.item.subTextShort(context.localized) != null)
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(7),
                            child: Text(
                              widget.item.subTextShort(context.localized) ?? "",
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      if (widget.iconOverlay != null)
                        Positioned.fill(
                          child: AnimatedOpacity(
                            opacity: showImageOverlay ? 1 : 0,
                            duration: const Duration(milliseconds: 250),
                            child: widget.iconOverlay!,
                          ),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: IgnorePointer(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.item.name,
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: Opacity(
                              opacity: 0.65,
                              child: Text(
                                widget.item.overview.summary,
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ...widget.actions,
                if (widget.item.overview.runTime != null)
                  Opacity(opacity: 0.65, child: Text(widget.item.overview.runTime?.readAbleDuration ?? "")),
                const VerticalDivider(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
