import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/widget_extensions.dart';
import 'package:fladder/widgets/shared/item_actions.dart';

class NavigationButton extends ConsumerStatefulWidget {
  final String? label;
  final Widget selectedIcon;
  final Widget icon;
  final bool horizontal;
  final bool expanded;
  final Function()? onPressed;
  final List<ItemAction> trailing;
  final bool selected;
  final Duration duration;
  const NavigationButton({
    required this.label,
    required this.selectedIcon,
    required this.icon,
    this.horizontal = false,
    this.expanded = false,
    this.onPressed,
    this.selected = false,
    this.trailing = const [],
    this.duration = const Duration(milliseconds: 125),
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NavigationButtonState();
}

class _NavigationButtonState extends ConsumerState<NavigationButton> {
  bool showPopupButton = false;
  @override
  Widget build(BuildContext context) {
    final foreGroundColor = widget.selected
        ? widget.expanded
            ? Theme.of(context).colorScheme.onPrimary
            : Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.45);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: ElevatedButton(
        onHover: (value) => setState(() => showPopupButton = value),
        style: ButtonStyle(
            elevation: const WidgetStatePropertyAll(0),
            padding: const WidgetStatePropertyAll(EdgeInsets.zero),
            backgroundColor: WidgetStatePropertyAll(
              widget.expanded && widget.selected ? Theme.of(context).colorScheme.primary : Colors.transparent,
            ),
            iconSize: const WidgetStatePropertyAll(24),
            iconColor: WidgetStateProperty.resolveWith((states) {
              return foreGroundColor;
            }),
            foregroundColor: WidgetStateProperty.resolveWith((states) {
              return foreGroundColor;
            })),
        onPressed: widget.onPressed,
        child: widget.horizontal
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: SizedBox(
                  height: 35,
                  child: Row(
                    spacing: 8,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: EdgeInsets.only(top: widget.selected ? 4 : 0),
                        height: widget.selected ? 14 : 0,
                        width: 6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withValues(alpha: widget.selected && !widget.expanded ? 1 : 0),
                        ),
                      ),
                      AnimatedSwitcher(
                        duration: widget.duration,
                        child: widget.selected
                            ? widget.selectedIcon.setKey(Key("${widget.label}+selected"))
                            : widget.icon.setKey(Key("${widget.label}+normal")),
                      ),
                      const SizedBox(width: 6),
                      if (widget.horizontal && widget.expanded) ...[
                        if (widget.label != null)
                          Expanded(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(minWidth: 80),
                              child: Text(
                                widget.label!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        if (widget.trailing.isNotEmpty)
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 125),
                            opacity: showPopupButton ? 1 : 0,
                            child: PopupMenuButton(
                              tooltip: context.localized.options,
                              iconColor: foreGroundColor,
                              iconSize: 18,
                              itemBuilder: (context) => widget.trailing.popupMenuItems(useIcons: true),
                            ),
                          )
                      ],
                    ],
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      spacing: 8,
                      children: [
                        AnimatedSwitcher(
                          duration: widget.duration,
                          child: widget.selected
                              ? widget.selectedIcon.setKey(Key("${widget.label}+selected"))
                              : widget.icon.setKey(Key("${widget.label}+normal")),
                        ),
                        if (widget.label != null && widget.horizontal && widget.expanded)
                          Flexible(child: Text(widget.label!))
                      ],
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: EdgeInsets.only(top: widget.selected ? 4 : 0),
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
    );
  }
}
