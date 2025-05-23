import 'package:flutter/material.dart';

import 'package:fladder/models/settings/home_settings_model.dart';
import 'package:fladder/screens/shared/flat_button.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/widgets/shared/modal_bottom_sheet.dart';

class EnumBox<T> extends StatelessWidget {
  final String current;
  final List<PopupMenuEntry<T>> Function(BuildContext context) itemBuilder;

  const EnumBox({required this.current, required this.itemBuilder, super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleMedium;
    const padding = EdgeInsets.symmetric(horizontal: 12, vertical: 6);
    final itemList = itemBuilder(context);
    final useBottomSheet = AdaptiveLayout.viewSizeOf(context) <= ViewSize.phone;

    final labelWidget = Padding(
      padding: padding,
      child: Material(
        textStyle: textStyle?.copyWith(
            fontWeight: FontWeight.bold,
            color: itemList.length > 1 ? Theme.of(context).colorScheme.onPrimaryContainer : null),
        color: Colors.transparent,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                current,
                textAlign: TextAlign.start,
              ),
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
      color: Theme.of(context).colorScheme.primaryContainer,
      shadowColor: Colors.transparent,
      elevation: 0,
      child: useBottomSheet
          ? FlatButton(
              child: labelWidget,
              onTap: () => showBottomSheetPill(
                context: context,
                content: (context, scrollController) => ListView(
                  shrinkWrap: true,
                  controller: scrollController,
                  children: [
                    const SizedBox(height: 6),
                    ...itemBuilder(context),
                  ],
                ),
              ),
            )
          : PopupMenuButton(
              tooltip: '',
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              enabled: itemList.length > 1,
              itemBuilder: itemBuilder,
              padding: padding,
              child: labelWidget,
            ),
    );
  }
}

class EnumSelection<T> extends StatelessWidget {
  final Text label;
  final String current;
  final List<PopupMenuEntry<T>> Function(BuildContext context) itemBuilder;
  const EnumSelection({
    super.key,
    required this.label,
    required this.current,
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
          label,
          const Spacer(),
          EnumBox(current: current, itemBuilder: itemBuilder),
        ].toList(),
      ),
    );
  }
}
