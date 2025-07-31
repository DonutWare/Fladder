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
    final size = MediaQuery.sizeOf(context);
    final maxHeight = size.height * 0.25;
    final textWidget = ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight),
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
            constraints: BoxConstraints(maxWidth: size.width * 0.25, maxHeight: maxHeight),
            child: FladderImage(
              image: logo,
              disableBlur: true,
              stackFit: StackFit.passthrough,
              alignment: Alignment.bottomLeft,
              imageErrorBuilder: (context, object, stack) => textWidget,
              placeHolder: textWidget,
              fit: BoxFit.contain,
            ),
          )
        : textWidget;
  }
}
