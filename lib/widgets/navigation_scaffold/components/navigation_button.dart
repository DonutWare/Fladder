import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/navigation_scaffold/components/side_navigation_bar.dart';
import 'package:fladder/widgets/shared/item_actions.dart';

class NavigationButton extends ConsumerStatefulWidget {
  final String? label;
  final Widget selectedIcon;
  final Widget icon;
  final Widget? badge;
  final bool navFocusNode;
  final bool horizontal;
  final bool expanded;
  final Function()? onPressed;
  final Function()? onLongPress;
  final List<ItemAction> trailing;
  final Widget? customIcon;
  final bool selected;
  final Duration duration;
  const NavigationButton({
    required this.label,
    required this.selectedIcon,
    required this.icon,
    this.badge,
    this.navFocusNode = false,
    this.horizontal = false,
    this.expanded = false,
    this.onPressed,
    this.onLongPress,
    this.customIcon,
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
    return TextButton(
      focusNode: widget.navFocusNode ? navBarNode : null,
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
      onLongPress: widget.onLongPress,
      child: ExcludeFocusTraversal(
        child: widget.horizontal
            ? Padding(
                padding: widget.customIcon != null
                    ? EdgeInsetsGeometry.zero
                    : const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                child: SizedBox(
                  height: widget.customIcon != null ? 60 : 35,
                  child: Row(
                    spacing: 4,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        height: widget.selected ? 16 : 0,
                        margin: const EdgeInsets.only(top: 1.5),
                        width: 6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withValues(alpha: widget.selected && !widget.expanded ? 1 : 0),
                        ),
                      ),
                      widget.customIcon ??
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              AnimatedSwitcher(
                                duration: widget.duration,
                                child: widget.selected ? widget.selectedIcon : widget.icon,
                              ),
                              if (widget.badge != null && !widget.expanded)
                                Transform.translate(
                                  offset: const Offset(8, -8),
                                  child: widget.badge,
                                ),
                            ],
                          ),
                      const SizedBox(width: 6),
                      if (widget.horizontal && widget.expanded) ...[
                        if (widget.label != null)
                          Expanded(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(minWidth: 80),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.label!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  if (widget.badge != null) widget.badge!,
                                ],
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
                padding: widget.customIcon != null ? EdgeInsetsGeometry.zero : const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      spacing: 8,
                      children: [
                        widget.customIcon ??
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                AnimatedSwitcher(
                                  duration: widget.duration,
                                  child: widget.selected ? widget.selectedIcon : widget.icon,
                                ),
                                if (widget.badge != null && !widget.expanded)
                                  Transform.translate(
                                    offset: const Offset(8, -8),
                                    child: widget.badge,
                                  ),
                              ],
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
