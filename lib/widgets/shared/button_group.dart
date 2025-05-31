import 'package:flutter/material.dart';

class ExpressiveButtonGroup<T> extends StatelessWidget {
  final List<ButtonGroupOption<T>> options;
  final Set<T> selectedValues;
  final ValueChanged<Set<T>> onSelected;
  final bool multiSelection;

  const ExpressiveButtonGroup({
    super.key,
    required this.options,
    required this.selectedValues,
    required this.onSelected,
    this.multiSelection = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      spacing: 2,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(options.length, (index) {
        final option = options[index];
        final isSelected = selectedValues.contains(option.value);
        final isFirst = index == 0;
        final isLast = index == options.length - 1;

        final borderRadius = BorderRadius.horizontal(
          left: isSelected || isFirst ? const Radius.circular(20) : const Radius.circular(6),
          right: isSelected || isLast ? const Radius.circular(20) : const Radius.circular(6),
        );

        return ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: borderRadius),
            elevation: isSelected ? 3 : 0,
            backgroundColor: isSelected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.surfaceContainerHighest,
            foregroundColor:
                isSelected ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurfaceVariant,
            textStyle: Theme.of(context).textTheme.labelLarge,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          onPressed: () {
            final newSet = Set<T>.from(selectedValues);
            if (multiSelection) {
              isSelected ? newSet.remove(option.value) : newSet.add(option.value);
            } else {
              newSet
                ..clear()
                ..add(option.value);
            }
            onSelected(newSet);
          },
          label: option.child,
          icon: isSelected ? option.selected ?? const Icon(Icons.check_rounded) : option.icon,
        );
      }),
    );
  }
}

class ButtonGroupOption<T> {
  final T value;
  final Icon? icon;
  final Icon? selected;
  final Widget child;

  const ButtonGroupOption({
    required this.value,
    this.icon,
    this.selected,
    required this.child,
  });
}
