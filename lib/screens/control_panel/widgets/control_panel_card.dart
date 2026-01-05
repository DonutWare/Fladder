import 'package:flutter/material.dart';

import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/screens/settings/widgets/settings_label_divider.dart';
import 'package:fladder/screens/settings/widgets/settings_list_group.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/widgets/shared/ensure_visible.dart';

class ControlPanelCard extends StatelessWidget {
  final String? title;
  final Function()? onTapTitle;
  final Widget child;
  final bool navigationChild;
  const ControlPanelCard({
    this.title,
    this.onTapTitle,
    required this.child,
    this.navigationChild = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (title != null) ...[
          SettingsListGroupTitle(
            label: ExcludeFocusTraversal(
              excluding: AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad,
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  alignment: Alignment.centerLeft,
                  foregroundColor: Theme.of(context).colorScheme.onSurface,
                ),
                onPressed: onTapTitle,
                onFocusChange: (value) {
                  if (value) {
                    context.ensureVisible();
                  }
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 8,
                  children: [
                    DefaultTextStyle(
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: SettingsLabelDivider(
                          label: title ?? "",
                        ),
                      ),
                    ),
                    if (onTapTitle != null)
                      const Icon(
                        IconsaxPlusLinear.arrow_right_3,
                        size: 14,
                      )
                  ],
                ),
              ),
            ),
          ),
        ],
        FocusButton(
          onTap:
              navigationChild && AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad ? onTapTitle ?? () {} : null,
          onFocusChanged: (value) {
            if (value) {
              context.ensureVisible();
            }
          },
          child: SettingsListChild(
            isLast: true,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Material(
                color: Colors.transparent,
                textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                child: child,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
