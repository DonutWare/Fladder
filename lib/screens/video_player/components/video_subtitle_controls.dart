import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/providers/settings/subtitle_settings_provider.dart';
import 'package:fladder/screens/shared/flat_button.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/widget_extensions.dart';
import 'package:fladder/widgets/shared/fladder_slider.dart';

Future<void> showSubtitleControls({
  required BuildContext context,
  String? label,
}) async {
  await showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.1),
    builder: (context) => AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: ConstrainedBox(
          constraints: BoxConstraints(minWidth: MediaQuery.sizeOf(context).width * 0.75),
          child: VideoSubtitleControls(label: label)),
    ),
  );
  return;
}

class VideoSubtitleControls extends ConsumerStatefulWidget {
  final String? label;
  const VideoSubtitleControls({this.label, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VideoSubtitleControlsState();
}

class _VideoSubtitleControlsState extends ConsumerState<VideoSubtitleControls> {
  late final lastSettings = ref.read(subtitleSettingsProvider);
  final controller = ScrollController();

  Key? activeKey;

  bool showPartial = true;
  bool hideControls = false;

  void setOpacity(Key? key) => setState(() {
        activeKey = key;
        showPartial = !(activeKey != null);
      });

  @override
  Widget build(BuildContext context) {
    final subSettings = ref.watch(subtitleSettingsProvider);
    final provider = ref.read(subtitleSettingsProvider.notifier);
    final controlsHidden = hideControls ? false : showPartial;
    return AnimatedContainer(
      height: MediaQuery.sizeOf(context).width * 0.85,
      width: MediaQuery.sizeOf(context).height * 0.7,
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: controlsHidden ? Theme.of(context).dialogBackgroundColor.withOpacity(0.75) : Colors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.label?.isNotEmpty == true)
              Text(
                widget.label!,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            IconButton.filledTonal(
              isSelected: !hideControls,
              onPressed: () => setState(() => hideControls = !hideControls),
              icon: Icon(hideControls ? Icons.visibility_rounded : Icons.visibility_off_rounded),
            ),
            Flexible(
              child: IgnorePointer(
                ignoring: !controlsHidden,
                child: Scrollbar(
                  thumbVisibility: controlsHidden,
                  controller: controller,
                  child: SingleChildScrollView(
                    controller: controller,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: subSettings != lastSettings
                                    ? () => provider.resetSettings(value: lastSettings)
                                    : null,
                                child: Text(context.localized.clearChanges),
                              ),
                              const SizedBox(width: 32),
                              ElevatedButton(
                                onPressed: () => provider.resetSettings(),
                                child: Text(context.localized.useDefaults),
                              ),
                            ],
                          ).addVisiblity(controlsHidden),
                          SegmentedButton<FontWeight>(
                            showSelectedIcon: false,
                            multiSelectionEnabled: false,
                            segments: [
                              ButtonSegment(
                                label:
                                    Text(context.localized.light, style: const TextStyle(fontWeight: FontWeight.w100)),
                                value: FontWeight.w100,
                              ),
                              ButtonSegment(
                                label:
                                    Text(context.localized.normal, style: const TextStyle(fontWeight: FontWeight.w500)),
                                value: FontWeight.normal,
                              ),
                              ButtonSegment(
                                label:
                                    Text(context.localized.bold, style: const TextStyle(fontWeight: FontWeight.w900)),
                                value: FontWeight.bold,
                              ),
                            ],
                            selected: {subSettings.fontWeight},
                            onSelectionChanged: (p0) {
                              provider.setFontWeight(p0.first);
                            },
                          ).addVisiblity(controlsHidden),
                          Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.format_size_rounded),
                                  Flexible(
                                    child: FladderSlider(
                                      min: 8.0,
                                      max: 160.0,
                                      onChangeStart: (value) => setOpacity(const Key('fontSize')),
                                      onChangeEnd: (value) => setOpacity(null),
                                      value: subSettings.fontSize.clamp(8.0, 160.0),
                                      onChanged: (value) => provider.setFontSize(value.ceilToDouble()),
                                    ),
                                  ),
                                  ConstrainedBox(
                                    constraints: const BoxConstraints(minWidth: 35),
                                    child: Text(
                                      subSettings.fontSize.toStringAsFixed(0),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              Text(context.localized.fontSize),
                            ],
                          ).addVisiblity(activeKey == null ? controlsHidden : activeKey == const Key('fontSize')),
                          Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.height_rounded),
                                  Flexible(
                                    child: FladderSlider(
                                      min: 0.0,
                                      max: 1.0,
                                      divisions: 80,
                                      onChangeStart: (value) => setOpacity(const Key('verticalOffset')),
                                      onChangeEnd: (value) => setOpacity(null),
                                      value: subSettings.verticalOffset.clamp(0, 1),
                                      onChanged: (value) => provider.setVerticalOffset(value),
                                    ),
                                  ),
                                  ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      minWidth: 35,
                                    ),
                                    child: Text(
                                      subSettings.verticalOffset.toStringAsFixed(2),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              Text(context.localized.heightOffset),
                            ],
                          ).addVisiblity(activeKey == null ? controlsHidden : activeKey == const Key('verticalOffset')),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(Icons.color_lens_rounded),
                                  ...[Colors.white, Colors.yellow, Colors.black, Colors.grey].map(
                                    (e) => FlatButton(
                                      onTap: () => provider.setSubColor(e),
                                      borderRadiusGeometry: BorderRadius.circular(5),
                                      clipBehavior: Clip.antiAlias,
                                      child: Container(
                                        height: 25,
                                        width: 25,
                                        color: e,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(context.localized.fontColor),
                            ],
                          ).addVisiblity(controlsHidden),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(Icons.border_color_rounded),
                                  ...[Colors.white, Colors.yellow, Colors.black, Colors.grey, Colors.transparent].map(
                                    (e) => FlatButton(
                                      onTap: () =>
                                          provider.setOutlineColor(e == Colors.transparent ? e : e.withOpacity(0.85)),
                                      borderRadiusGeometry: BorderRadius.circular(5),
                                      clipBehavior: Clip.antiAlias,
                                      child: Container(
                                        height: 25,
                                        width: 25,
                                        color: e == Colors.transparent ? Colors.white : e,
                                        child: e == Colors.transparent
                                            ? const Icon(
                                                Icons.disabled_by_default_outlined,
                                                color: Colors.red,
                                              )
                                            : null,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(context.localized.outlineColor),
                            ],
                          ).addVisiblity(controlsHidden),
                          Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.border_style),
                                  Flexible(
                                    child: FladderSlider(
                                      min: 1,
                                      max: 25,
                                      divisions: 24,
                                      onChangeStart: (value) => setOpacity(const Key('outlineSize')),
                                      onChangeEnd: (value) => setOpacity(null),
                                      value: subSettings.outlineSize.clamp(1, 24),
                                      onChanged: (value) => provider.setOutlineThickness(value),
                                    ),
                                  ),
                                  ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      minWidth: 35,
                                    ),
                                    child: Text(
                                      subSettings.outlineSize.toStringAsFixed(2),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              Text(context.localized.outlineSize),
                            ],
                          ).addVisiblity(activeKey == null ? controlsHidden : activeKey == const Key('outlineSize')),
                          Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.square_rounded),
                                  Flexible(
                                    child: FladderSlider(
                                      min: 0,
                                      max: 1,
                                      divisions: 20,
                                      onChangeStart: (value) => setOpacity(const Key('backGroundOpacity')),
                                      onChangeEnd: (value) => setOpacity(null),
                                      value: subSettings.backGroundColor.opacity.clamp(0, 1),
                                      onChanged: (value) => provider.setBackGroundOpacity(value),
                                    ),
                                  ),
                                  ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      minWidth: 35,
                                    ),
                                    child: Text(
                                      subSettings.backGroundColor.opacity.toStringAsFixed(2),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              Text(context.localized.backgroundOpacity),
                            ],
                          ).addVisiblity(
                              activeKey == null ? controlsHidden : activeKey == const Key('backGroundOpacity')),
                          Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.blur_circular_rounded),
                                  Flexible(
                                    child: FladderSlider(
                                      min: 0,
                                      max: 1,
                                      divisions: 20,
                                      value: subSettings.shadow.clamp(0, 1),
                                      onChangeStart: (value) => setOpacity(const Key('shadowSlider')),
                                      onChangeEnd: (value) => setOpacity(null),
                                      onChanged: (value) => provider.setShadowIntensity(value),
                                    ),
                                  ),
                                  ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      minWidth: 35,
                                    ),
                                    child: Text(
                                      subSettings.shadow.toStringAsFixed(2),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              Text(context.localized.shadow)
                            ],
                          ).addVisiblity(activeKey == null ? controlsHidden : activeKey == const Key('shadowSlider')),
                        ].addPadding(const EdgeInsets.symmetric(vertical: 12)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
