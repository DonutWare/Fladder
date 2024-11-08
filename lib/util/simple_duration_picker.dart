import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/screens/shared/outlined_text_field.dart';
import 'package:fladder/util/localization_helper.dart';

String timePickerString(BuildContext context, Duration? duration) {
  if (duration == null) return context.localized.never;
  if (duration.inSeconds <= 0) return context.localized.immediately;

  final minutes = duration.inMinutes;
  final seconds = duration.inSeconds % 60;

  final minutesString = "$minutes ${context.localized.minutes(minutes)}";
  final secondsString = "$seconds ${context.localized.seconds(seconds)}";

  if (minutes > 0 && seconds > 0) {
    return context.localized.timeAndAnnotation(minutesString, secondsString);
  } else if (minutes > 0) {
    return minutesString;
  } else {
    return secondsString;
  }
}

Future<Duration?> showSimpleDurationPicker({
  required BuildContext context,
  required Duration initialValue,
  bool showNever = true,
}) async {
  Duration? duration;
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(context.localized.selectTime),
      content: SimpleDurationPicker(
        initialValue: initialValue,
        onChanged: (value) {
          duration = value;
          Navigator.of(context).pop();
        },
        showNever: showNever,
      ),
    ),
  );
  return duration;
}

class SimpleDurationPicker extends ConsumerWidget {
  final Duration initialValue;
  final ValueChanged<Duration?> onChanged;
  final bool showNever;
  const SimpleDurationPicker({required this.initialValue, required this.onChanged, required this.showNever, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final minuteTextController = TextEditingController(text: initialValue.inMinutes.toString().padLeft(2, '0'));
    final secondsTextController = TextEditingController(text: (initialValue.inSeconds % 60).toString().padLeft(2, '0'));
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 32),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OutlinedTextField(
                      controller: minuteTextController,
                      style: Theme.of(context).textTheme.displaySmall,
                      keyboardType: const TextInputType.numberWithOptions(decimal: false, signed: false),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      borderWidth: 0,
                      textInputAction: TextInputAction.done,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      context.localized.minutes(0),
                      style: Theme.of(context).textTheme.labelLarge,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  ':',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OutlinedTextField(
                      controller: secondsTextController,
                      style: Theme.of(context).textTheme.displaySmall,
                      keyboardType: const TextInputType.numberWithOptions(decimal: false, signed: false),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      borderWidth: 0,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (value) {
                        try {
                          final parsedValue = int.parse(value);
                          if (parsedValue >= 60) {
                            secondsTextController.text = (parsedValue % 60).toString().padLeft(2, '0');
                            minuteTextController.text = (int.parse(minuteTextController.text) + parsedValue / 60)
                                .floor()
                                .toString()
                                .padLeft(2, '0');
                          }
                          onChanged(
                            Duration(
                              minutes: int.tryParse(minuteTextController.text) ?? 0,
                              seconds: int.tryParse(secondsTextController.text) ?? 0,
                            ),
                          );
                        } catch (e) {
                          log(e.toString());
                        }
                      },
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      context.localized.seconds(0),
                      style: Theme.of(context).textTheme.labelLarge,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (showNever) ...{
              TextButton(
                onPressed: () => onChanged(null),
                child: Text(context.localized.never),
              ),
              const Spacer(),
            },
            TextButton(
              onPressed: () => onChanged(initialValue),
              child: Text(context.localized.cancel),
            ),
            if (!showNever) const Spacer() else const SizedBox(width: 6),
            FilledButton(
              onPressed: () => onChanged(
                Duration(
                  minutes: int.tryParse(minuteTextController.text) ?? 0,
                  seconds: int.tryParse(secondsTextController.text) ?? 0,
                ),
              ),
              child: Text(context.localized.set),
            ),
          ],
        )
      ],
    );
  }
}
