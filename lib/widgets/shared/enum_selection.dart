import 'package:flutter/material.dart';

import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/widgets/shared/ensure_visible.dart';
import 'package:fladder/widgets/shared/item_actions.dart';
import 'package:fladder/widgets/shared/modal_bottom_sheet.dart';

class EnumBox<T> extends StatelessWidget {
  final String current;
  final Widget? currentWidget;
  final List<ItemAction> Function(BuildContext context) itemBuilder;

  const EnumBox({
    required this.current,
    this.currentWidget,
    required this.itemBuilder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleMedium;
    const padding = EdgeInsets.symmetric(horizontal: 12, vertical: 6);
    final itemList = itemBuilder(context);
    final useBottomSheet = AdaptiveLayout.inputDeviceOf(context) != InputDevice.pointer;

    final labelWidget = Padding(
      padding: padding,
      child: Material(
        textStyle: textStyle?.copyWith(
            fontWeight: FontWeight.bold,
            color: itemList.length > 1 ? Theme.of(context).colorScheme.onPrimaryContainer : null),
        color: Colors.transparent,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: currentWidget ?? Text(current, textAlign: TextAlign.start),
            ),
            const SizedBox(width: 6),
            if (itemList.length > 1)
              Icon(
                Icons.keyboard_arrow_down,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              )
          ],
        ),
      ),
    );
    return Card(
      color: itemList.length > 1 ? Theme.of(context).colorScheme.primaryContainer : Colors.transparent,
      shadowColor: Colors.transparent,
      elevation: 0,
      child: useBottomSheet
          ? FocusButton(
              child: labelWidget,
              darkOverlay: false,
              onFocusChanged: (value) {
                if (value) {
                  context.ensureVisible();
                }
              },
              onTap: itemList.length > 1
                  ? () => showBottomSheetPill(
                        context: context,
                        content: (context, scrollController) => ListView(
                          shrinkWrap: true,
                          controller: scrollController,
                          children: [
                            const SizedBox(height: 6),
                            ...itemList.map(
                              (e) => e.toListItem(context),
                            ),
                          ],
                        ),
                      )
                  : null,
            )
          : PopupMenuButton(
              tooltip: '',
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              enabled: itemList.length > 1,
              itemBuilder: (context) => itemList.map((e) => e.toPopupMenuItem()).toList(),
              padding: padding,
              child: labelWidget,
              requestFocus: true,
            ),
    );
  }
}

class EnumSelection<T> extends StatelessWidget {
  final Widget label;
  final String current;
  final Widget? currentWidget;
  final List<ItemAction> Function(BuildContext context) itemBuilder;
  const EnumSelection({
    super.key,
    required this.label,
    required this.current,
    this.currentWidget,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      textStyle: Theme.of(context).textTheme.titleMedium,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          DefaultTextStyle.merge(
            style: Theme.of(context).textTheme.titleMedium,
            child: label,
          ),
          const Spacer(),
          EnumBox(current: current, currentWidget: currentWidget, itemBuilder: itemBuilder),
        ].toList(),
      ),
    );
  }
}
