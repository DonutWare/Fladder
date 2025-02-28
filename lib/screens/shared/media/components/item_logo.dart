import 'package:flutter/material.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/util/fladder_image.dart';

class ItemLogo extends StatelessWidget {
  final ItemBaseModel item;
  final Alignment imageAlignment;
  final TextStyle? textStyle;
  const ItemLogo({
    required this.item,
    this.imageAlignment = Alignment.bottomCenter,
    this.textStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final logo = item.getPosters?.logo;
    final textWidget = Container(
      height: 512,
      alignment: imageAlignment,
      child: Text(
        item.parentBaseModel.name,
        textAlign: TextAlign.start,
        maxLines: 3,
        overflow: TextOverflow.fade,
        style: textStyle ??
            Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: 55,
                ),
      ),
    );
    return logo != null
        ? ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500, maxHeight: 500),
            child: FladderImage(
              image: logo,
              disableBlur: true,
              alignment: imageAlignment,
              imageErrorBuilder: (context, object, stack) => textWidget,
              placeHolder: const SizedBox(height: 0),
              fit: BoxFit.contain,
            ),
          )
        : textWidget;
  }
}
