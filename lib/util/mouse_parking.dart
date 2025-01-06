import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MouseParking extends ConsumerStatefulWidget {
  final Function(PointerEvent)? onHover;
  const MouseParking({this.onHover, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MouseParkingState();
}

class _MouseParkingState extends ConsumerState<MouseParking> {
  bool parked = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: MouseRegion(
        onEnter: (event) => setState(() => parked = true),
        onExit: (event) => setState(() => parked = false),
        onHover: widget.onHover,
        cursor: SystemMouseCursors.none,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(20)),
            color: parked ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.5) : Colors.black12,
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.mouse_rounded),
              Icon(Icons.local_parking),
            ],
          ),
        ),
      ),
    );
  }
}
