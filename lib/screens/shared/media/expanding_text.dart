import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/screens/shared/flat_button.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/ensure_visible.dart';

class ExpandingText extends ConsumerStatefulWidget {
  final String text;
  final bool showTitle;
  final Function(bool onFocus)? onFocusChange;
  final bool disableBottomButton;
  const ExpandingText({
    required this.text,
    this.showTitle = true,
    this.disableBottomButton = false,
    this.onFocusChange,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExpandingTextState();
}

class _ExpandingTextState extends ConsumerState<ExpandingText> {
  bool expanded = false;

  void toggleState() {
    setState(() {
      expanded = !expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDpad = AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad;

    final useFlatButton = isDpad || widget.disableBottomButton;
    final int maxLength = 200;
    final bool canExpand = (widget.text.length - maxLength) > maxLength * 0.1;
    return FlatButton(
      onTap: canExpand && useFlatButton
          ? toggleState
          : isDpad
              ? () {}
              : null,
      onFocusChange: widget.onFocusChange ??
          (value) {
            if (value) {
              context.ensureVisible();
            }
          },
      child: AnimatedSize(
        duration: const Duration(milliseconds: 250),
        alignment: Alignment.topCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.showTitle)
              Text(
                context.localized.overview,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            HtmlWidget(
              widget.text.substring(0, !expanded ? maxLength.clamp(0, widget.text.length) : widget.text.length - 1) +
                  (!expanded && canExpand ? ' ....' : ''),
              textStyle: Theme.of(context).textTheme.bodyLarge,
            ),
            if (canExpand && !useFlatButton)
              Transform.translate(
                offset: const Offset(-10, 0),
                child: TextButton.icon(
                  onPressed: toggleState,
                  icon: Icon(expanded ? IconsaxPlusLinear.arrow_up_1 : IconsaxPlusLinear.arrow_down),
                  label: Text(expanded ? context.localized.showLess : context.localized.showMore),
                  iconAlignment: IconAlignment.end,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
