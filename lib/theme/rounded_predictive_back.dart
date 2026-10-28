import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:fladder/util/back_gesture_arbiter.dart';
import 'package:fladder/util/frontmost_route.dart';

class RoundedPredictiveBackPageTransitionsBuilder extends PageTransitionsBuilder {
  const RoundedPredictiveBackPageTransitionsBuilder();

  static const _predictive = PredictiveBackPageTransitionsBuilder();

  @override
  Duration get transitionDuration => _predictive.transitionDuration;

  @override
  Duration get reverseTransitionDuration => _predictive.reverseTransitionDuration;

  @override
  DelegatedTransitionBuilder? get delegatedTransition => _predictive.delegatedTransition;

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) =>
      _CoveredRouteGestureBlocker(
        child: _predictive.buildTransitions(
          route,
          context,
          animation,
          secondaryAnimation,
          _RoundedBackGestureClip(route: route, animation: animation, child: child),
        ),
      );
}

class _RoundedBackGestureClip extends StatelessWidget {
  final PageRoute<Object?> route;
  final Animation<double> animation;
  final Widget child;
  const _RoundedBackGestureClip({required this.route, required this.animation, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final radius = route.popGestureInProgress ? 32 * ((1 - animation.value) * 5).clamp(0.0, 1.0) : 0.0;
        return ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          clipBehavior: radius == 0 ? Clip.none : Clip.antiAlias,
          child: child,
        );
      },
      child: child,
    );
  }
}

class _CoveredRouteGestureBlocker extends StatefulWidget {
  final Widget child;
  const _CoveredRouteGestureBlocker({required this.child});

  @override
  State<_CoveredRouteGestureBlocker> createState() => _CoveredRouteGestureBlockerState();
}

class _CoveredRouteGestureBlockerState extends State<_CoveredRouteGestureBlocker> {
  late final _popEntry = _BackGestureStartPopEntry(() => isFrontmostRoute(context));
  ModalRoute<Object?>? _route;

  @override
  void initState() {
    super.initState();
    BackGestureArbiter.ensureInitialized();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route == _route) return;
    _route?.unregisterPopEntry(_popEntry);
    _route = route?..registerPopEntry(_popEntry);
  }

  @override
  void dispose() {
    _route?.unregisterPopEntry(_popEntry);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

class _BackGestureStartPopEntry extends PopEntry<Object?> {
  _BackGestureStartPopEntry(bool Function() isFrontmost)
      : canPopNotifier = _ComputedListenable(
          () => !BackGestureArbiter.starting || (!BackGestureArbiter.claimed && isFrontmost()),
        );

  @override
  final ValueListenable<bool> canPopNotifier;
}

class _ComputedListenable extends ChangeNotifier implements ValueListenable<bool> {
  final bool Function() _compute;
  _ComputedListenable(this._compute);

  @override
  bool get value => _compute();
}
