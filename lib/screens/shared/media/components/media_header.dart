import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/items/images_models.dart';
import 'package:fladder/util/fladder_image.dart';

class MediaHeader extends ConsumerWidget {
  final String name;
  final ImageData? logo;
  final Function()? onTap;
  final Alignment alignment;
  final TextAlign textAlign;
  const MediaHeader({
    required this.name,
    required this.logo,
    this.onTap,
    this.alignment = Alignment.bottomCenter,
    this.textAlign = TextAlign.center,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final maxSize = 700.0;
    final textWidget = Container(
      constraints: const BoxConstraints(minHeight: 10, maxHeight: 200),
      alignment: alignment,
      child: SelectableText(
        name,
        textAlign: textAlign,
        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontSize: 55,
            ),
      ),
    );

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: (MediaQuery.sizeOf(context).height * 0.275).clamp(0, maxSize),
        maxWidth: MediaQuery.sizeOf(context).width.clamp(0, maxSize),
      ),
      child: Stack(
        children: [
          logo != null
              ? FladderImage(
                  image: logo,
                  disableBlur: true,
                  alignment: alignment,
                  imageErrorBuilder: (context, object, stack) => textWidget,
                  placeHolder: const SizedBox(height: 0),
                  fit: BoxFit.contain,
                )
              : textWidget,
          if (onTap != null)
            Positioned.fill(
              child: GestureDetector(
                onTap: onTap,
              ),
            ),
        ],
      ),
    );
  }
}
