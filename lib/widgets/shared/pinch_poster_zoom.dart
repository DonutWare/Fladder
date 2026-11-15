import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PinchPosterZoom extends ConsumerStatefulWidget {
  final Widget child;
  final Function(double difference)? scaleDifference;
  const PinchPosterZoom({required this.child, this.scaleDifference, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PinchPosterZoomState();
}

class _PinchPosterZoomState extends ConsumerState<PinchPosterZoom> {
  double lastScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: (details) {
        lastScale = 1;
      },
      onScaleUpdate: (details) {
        final difference = details.scale - lastScale;
        if (ref.watch(clientSettingsProvider.select((value) => value.pinchPosterZoom))) {
          widget.scaleDifference?.call(difference);
        }
        lastScale = details.scale;
      },
      child: widget.child,
    );
  }
}
