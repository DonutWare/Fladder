import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:fladder/widgets/navigation_scaffold/components/adaptive_fab.dart';
import 'package:fladder/widgets/navigation_scaffold/components/navigation_button.dart';

class DestinationModel {
  final String label;
  final Widget? icon;
  final Widget? selectedIcon;
  final PageRouteInfo? route;
  final Function()? action;
  final String? tooltip;
  final Widget? badge;
  final AdaptiveFab? floatingActionButton;

  DestinationModel({
    required this.label,
    this.icon,
    this.selectedIcon,
    this.route,
    this.action,
    this.tooltip,
    this.badge,
    this.floatingActionButton,
  });

  /// Converts this [DestinationModel] to a [NavigationRailDestination] used in a [NavigationRail].
  NavigationRailDestination toNavigationRailDestination({EdgeInsets? padding}) {
    return NavigationRailDestination(
      icon: icon!,
      label: Text(label),
      selectedIcon: selectedIcon,
      padding: padding,
    );
  }

  /// Converts this [DestinationModel] to a [NavigationDrawerDestination] used in a [NavigationDrawer].
  NavigationDrawerDestination toNavigationDrawerDestination() {
    return NavigationDrawerDestination(
      icon: icon!,
      label: Text(label),
      selectedIcon: selectedIcon,
    );
  }

  /// Converts this [DestinationModel] to a [NavigationDestination] used in a [BottomNavigationBar].
  NavigationDestination toNavigationDestination() {
    return NavigationDestination(
      icon: icon!,
      label: label,
      selectedIcon: selectedIcon,
      tooltip: tooltip,
    );
  }

  NavigationButton toNavigationButton(bool selected, bool horizontal, bool expanded,
      {bool navFocusNode = false, Widget? customIcon}) {
    return NavigationButton(
      label: label,
      selected: selected,
      navFocusNode: navFocusNode,
      badge: badge,
      onPressed: action,
      horizontal: horizontal,
      expanded: expanded,
      customIcon: customIcon,
      selectedIcon: selectedIcon!,
      icon: icon!,
    );
  }
}
