import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/widgets/shared/fladder_slider.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PosterSizeWidget extends ConsumerWidget {
  final Color? iconColor;
  final double width;
  const PosterSizeWidget({this.width = 150, this.iconColor, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(clientSettingsProvider.select((value) => value.pinchPosterZoom))) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Tooltip(
            message: 'Set poster size',
            child: IconButton(
              onPressed: () =>
                  ref.read(clientSettingsProvider.notifier).update((current) => current.copyWith(posterSize: 1)),
              icon: const Icon(Icons.photo_size_select_large_rounded),
              color: iconColor ?? Theme.of(context).colorScheme.onSurface,
            ),
          ),
          SizedBox(
            width: width,
            child: FladderSlider(
              value: ref.watch(clientSettingsProvider.select((value) => value.posterSize)),
              min: 0.5,
              divisions: 12,
              max: 1.5,
              onChanged: (value) =>
                  ref.read(clientSettingsProvider.notifier).update((current) => current.copyWith(posterSize: value)),
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }
}
