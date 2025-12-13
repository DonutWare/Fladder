import 'package:flutter/material.dart';

import 'package:fladder/util/position_provider.dart';

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
      children: List.generate(
        options.length,
        (index) {
          final option = options[index];
          final isSelected = selectedValues.contains(option.value);

          final position = index == 0
              ? PositionContext.first
              : (index == options.length - 1 ? PositionContext.last : PositionContext.middle);

          return PositionProvider(
            position: position,
            child: ExpressiveButton(
              isSelected: isSelected,
              label: option.child,
              icon: isSelected ? option.selected ?? const Icon(Icons.check_rounded) : option.icon,
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
            ),
          );
        },
      ),
    );
  }
}

class ExpressiveButton extends StatelessWidget {
  const ExpressiveButton({
    super.key,
    required this.isSelected,
    required this.label,
    this.icon,
    required this.onPressed,
  });

  final bool isSelected;
  final Widget label;
  final Widget? icon;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final position = PositionProvider.of(context);
    final borderRadius = BorderRadius.horizontal(
      left: isSelected || position == PositionContext.first ? const Radius.circular(16) : const Radius.circular(4),
      right: isSelected || position == PositionContext.last ? const Radius.circular(16) : const Radius.circular(4),
    );
    return ElevatedButton.icon(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: borderRadius)),
        elevation: const WidgetStatePropertyAll(0),
        backgroundColor: WidgetStatePropertyAll(
            isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surfaceContainerHighest),
        foregroundColor: WidgetStatePropertyAll(
            isSelected ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurfaceVariant),
        textStyle: WidgetStatePropertyAll(Theme.of(context).textTheme.labelLarge),
        visualDensity: VisualDensity.comfortable,
        side: WidgetStateProperty.resolveWith((states) => BorderSide(
              width: 2,
              color: (isSelected
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onPrimaryContainer)
                  .withValues(alpha: states.contains(WidgetState.focused) ? 1.0 : 0),
            )),
        padding: const WidgetStatePropertyAll(EdgeInsets.all(12)),
      ),
      onPressed: onPressed,
      label: label,
      icon: icon,
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
