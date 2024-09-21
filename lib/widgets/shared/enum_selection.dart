import 'package:flutter/material.dart';

class EnumBox<T> extends StatelessWidget {
  final String current;
  final List<PopupMenuEntry<T>> Function(BuildContext context) itemBuilder;

  const EnumBox({required this.current, required this.itemBuilder, super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleMedium;
    const padding = EdgeInsets.symmetric(horizontal: 12, vertical: 6);
    final itemList = itemBuilder(context);
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      shadowColor: Colors.transparent,
      elevation: 0,
      child: PopupMenuButton(
        tooltip: '',
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        enabled: itemList.length > 1,
        itemBuilder: itemBuilder,
        padding: padding,
        child: Padding(
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
        ),
      ),
    );
  }
}

class EnumSelection<T> extends StatelessWidget {
  final Text label;
  final String current;
  final List<PopupMenuEntry<T>> Function(BuildContext context) itemBuilder;
  const EnumSelection({super.key, 
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
