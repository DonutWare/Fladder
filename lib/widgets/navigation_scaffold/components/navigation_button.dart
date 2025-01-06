import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/util/widget_extensions.dart';

class NavigationButton extends ConsumerStatefulWidget {
  final String? label;
  final Widget selectedIcon;
  final Widget icon;
  final bool horizontal;
  final Function()? onPressed;
  final bool selected;
  final Duration duration;
  const NavigationButton({
    required this.label,
    required this.selectedIcon,
    required this.icon,
    this.horizontal = false,
    this.onPressed,
    this.selected = false,
    this.duration = const Duration(milliseconds: 125),
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NavigationButtonState();
}

class _NavigationButtonState extends ConsumerState<NavigationButton> {
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      waitDuration: const Duration(seconds: 1),
      preferBelow: false,
      triggerMode: TooltipTriggerMode.longPress,
      message: widget.label ?? "",
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: widget.horizontal
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: getChildren(context),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: getChildren(context),
              ),
      ),
    );
  }

  List<Widget> getChildren(BuildContext context) {
    return [
      Flexible(
        child: ElevatedButton(
          style: ButtonStyle(
              elevation: const WidgetStatePropertyAll(0),
              padding: const WidgetStatePropertyAll(EdgeInsets.zero),
              backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
              iconSize: const WidgetStatePropertyAll(24),
              iconColor: WidgetStateProperty.resolveWith((states) {
                return widget.selected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.45);
              }),
              foregroundColor: WidgetStateProperty.resolveWith((states) {
                return widget.selected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.45);
              })),
          onPressed: widget.onPressed,
          child: AnimatedContainer(
            curve: Curves.fastOutSlowIn,
            duration: widget.duration,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      AnimatedSwitcher(
                        duration: widget.duration,
                        child: widget.selected
                            ? widget.selectedIcon.setKey(Key("${widget.label}+selected"))
                            : widget.icon.setKey(Key("${widget.label}+normal")),
                      ),
                      if (widget.horizontal && widget.label != null)
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: _Label(widget: widget),
                        )
                    ],
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: EdgeInsets.only(top: widget.selected ? 8 : 0),
                    height: widget.selected ? 6 : 0,
                    width: widget.selected ? 14 : 0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).colorScheme.primary.withValues(alpha: widget.selected ? 1 : 0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ];
  }
}

class _Label extends StatelessWidget {
  const _Label({required this.widget});

  final NavigationButton widget;

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.label!,
      maxLines: 1,
      overflow: TextOverflow.fade,
      style:
          Theme.of(context).textTheme.labelMedium?.copyWith(color: Theme.of(context).colorScheme.onSecondaryContainer),
    );
  }
}
