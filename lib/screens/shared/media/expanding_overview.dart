import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/screens/shared/flat_button.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/ensure_visible.dart';

class ExpandingOverview extends ConsumerStatefulWidget {
  final String text;
  const ExpandingOverview({required this.text, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExpandingOverviewState();
}

class _ExpandingOverviewState extends ConsumerState<ExpandingOverview> {
  bool expanded = false;

  void toggleState() {
    setState(() {
      expanded = !expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurface;
    const int maxLength = 200;
    final bool canExpand = widget.text.length > maxLength;
    final isDpad = AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad;
    return FlatButton(
      onTap: canExpand && isDpad ? toggleState : null,
      onFocusChange: (value) {
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
            Text(
              context.localized.overview,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0, 1],
                colors: [
                  color,
                  color.withValues(
                      alpha: !canExpand
                          ? 1
                          : expanded
                              ? 1
                              : 0),
                ],
              ).createShader(bounds),
              child: HtmlWidget(
                widget.text.substring(0, !expanded ? maxLength.clamp(0, widget.text.length) : widget.text.length - 1),
                textStyle: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            if (canExpand && !isDpad) ...{
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.center,
                child: Transform.translate(
                  offset: Offset(0, expanded ? 0 : -15),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: expanded
                        ? IconButton.filledTonal(
                            onPressed: toggleState,
                            icon: const Icon(IconsaxPlusLinear.arrow_up_1),
                          )
                        : IconButton.filledTonal(
                            onPressed: toggleState,
                            icon: const Icon(IconsaxPlusLinear.arrow_down),
                          ),
                  ),
                ),
              ),
            },
          ],
        ),
      ),
    );
  }
}
