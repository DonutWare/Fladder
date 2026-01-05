import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/widgets/keyboard/keyboard_localization.dart';

class AlphaNumericKeyboard extends ConsumerStatefulWidget {
  final void Function(String character) onCharacter;
  final TextInputType keyboardType;
  final TextInputAction keyboardActionType;
  final VoidCallback onBackspace;
  final VoidCallback onClear;
  final VoidCallback onDone;

  const AlphaNumericKeyboard({
    required this.onCharacter,
    this.keyboardType = TextInputType.name,
    this.keyboardActionType = TextInputAction.done,
    required this.onBackspace,
    required this.onClear,
    required this.onDone,
    super.key,
  });

  @override
  ConsumerState<AlphaNumericKeyboard> createState() => _AlphaNumericKeyboardState();
}

class _AlphaNumericKeyboardState extends ConsumerState<AlphaNumericKeyboard> {
  static final _numericKeyboardTypes = {
    TextInputType.number,
    TextInputType.phone,
    const TextInputType.numberWithOptions(decimal: true, signed: false),
    const TextInputType.numberWithOptions(decimal: false, signed: true),
    const TextInputType.numberWithOptions(decimal: true, signed: true),
  };

  bool usingAlpha = true;
  bool shift = false;
  late TextInputType type = widget.keyboardType;
  late TextInputAction actionType = widget.keyboardActionType;

  bool get isNumericKeyboard => _numericKeyboardTypes.contains(type);

  List<List<String>> activeLayout(Locale locale) {
    if (isNumericKeyboard) {
      return [
        ['1', '2', '3', '⌫'],
        ['4', '5', '6', ','],
        ['7', '8', '9', '.'],
        ['', '0', ''],
      ];
    }

    final localeLayouts = KeyboardLayouts.layouts.containsKey(locale.languageCode)
        ? KeyboardLayouts.layouts[locale.languageCode]!
        : KeyboardLayouts.layouts['en']!;
    return usingAlpha ? localeLayouts[KeyboardLayer.alpha]! : localeLayouts[KeyboardLayer.numericExtra]!;
  }

  Widget buildKey(String label, {bool autofocus = false}) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: ExcludeFocus(
        excluding: label.isEmpty,
        child: ElevatedButton(
          autofocus: autofocus,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(8),
            foregroundColor: Theme.of(context).colorScheme.onSurface,
          ),
          onPressed: label.isNotEmpty
              ? () {
                  switch (label) {
                    case '⌫':
                      widget.onBackspace();
                      break;
                    case '123':
                    case 'ABC':
                      setState(() => usingAlpha = !usingAlpha);
                      break;
                    default:
                      widget.onCharacter(shift ? label.toUpperCase() : label.toLowerCase());
                  }
                }
              : null,
          child: SizedBox.square(
            dimension: 52,
            child: FittedBox(
              child: switch (label) {
                '⌫' => const Padding(
                    padding: EdgeInsets.all(4),
                    child: Icon(Icons.backspace_rounded),
                  ),
                _ => Text(
                    shift ? label.toUpperCase() : label.toLowerCase(),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final language = ref.watch(clientSettingsProvider
        .select((value) => value.selectedLocale ?? WidgetsBinding.instance.platformDispatcher.locale));
    final rows = activeLayout(language);

    final helperButtons = switch (type) {
      TextInputType.url => ["https://", "http://", ".", "://", ".com", ".nl"],
      TextInputType.emailAddress => ["@gmail.com", "@hotmail.com"],
      _ => [],
    };

    return FocusTraversalGroup(
      policy: OrderedTraversalPolicy(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 12,
        children: [
          FittedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int r = 0; r < rows.length; r++)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      for (int c = 0; c < rows[r].length; c++)
                        buildKey(
                          rows[r][c],
                          autofocus: r == 0 && c == 0,
                        ),
                    ],
                  ),
              ],
            ),
          ),
          if (helperButtons.isNotEmpty) ...[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 8,
                children: helperButtons
                    .map(
                      (e) => FilledButton.tonal(
                        onPressed: () => widget.onCharacter(e),
                        style: FilledButton.styleFrom(
                          shape: FladderTheme.smallShape,
                        ),
                        child: Text(
                          e,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            const Divider(),
          ],
          FittedBox(
            child: SizedBox(
              height: 58,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 12,
                children: [
                  ...KeyboardActions.values.map(
                    (action) => FittedBox(
                      child: FilledButton.tonal(
                        style: FilledButton.styleFrom(
                          shape: FladderTheme.smallShape,
                          backgroundColor: switch (action) {
                            KeyboardActions.shift => shift ? Theme.of(context).colorScheme.primary : null,
                            _ => null,
                          },
                          iconColor: switch (action) {
                            KeyboardActions.shift => shift ? Theme.of(context).colorScheme.onPrimary : null,
                            _ => null,
                          },
                        ),
                        onPressed: () {
                          switch (action) {
                            case KeyboardActions.space:
                              widget.onCharacter(" ");
                              break;
                            case KeyboardActions.clear:
                              widget.onClear();
                              break;
                            case KeyboardActions.action:
                              widget.onDone();
                              break;
                            case KeyboardActions.shift:
                              setState(() {
                                shift = !shift;
                              });
                              break;
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: switch (action) {
                            KeyboardActions.action => Icon(
                                switch (actionType) {
                                  TextInputAction.next => IconsaxPlusBold.next,
                                  TextInputAction.done => Icons.check_rounded,
                                  TextInputAction.send => IconsaxPlusBold.send_1,
                                  _ => IconsaxPlusBold.send_1,
                                },
                                size: 32,
                              ),
                            _ => switch (action) {
                                KeyboardActions.shift => const Icon(Icons.keyboard_capslock_rounded, size: 32),
                                _ => Text(
                                    action.label(context).toUpperCase(),
                                    style:
                                        Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                                  )
                              }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

enum KeyboardActions {
  shift,
  space,
  clear,
  action;

  const KeyboardActions();

  String label(BuildContext context) {
    return switch (this) {
      KeyboardActions.space => "Space",
      KeyboardActions.clear => "Clear",
      KeyboardActions.action => "Action",
      KeyboardActions.shift => "Shift",
    };
  }
}
