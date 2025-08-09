import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/settings/key_combinations.dart';
import 'package:fladder/providers/settings/client_settings_provider.dart';
import 'package:fladder/providers/settings/video_player_settings_provider.dart';
import 'package:fladder/screens/shared/fladder_snackbar.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/localization_helper.dart';

final keyListeningProvider = StateProvider<bool>((ref) {
  return false;
});

class KeyCombinationWidget extends StatelessWidget {
  final KeyCombination? currentKey;
  final KeyCombination defaultKey;
  final Function(KeyCombination value) onChanged;

  const KeyCombinationWidget({
    required this.currentKey,
    required this.defaultKey,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final comboKey = currentKey ?? defaultKey;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            spacing: 6,
            children: [
              KeyListenerWidget(
                currentKey: comboKey,
                onChanged: (value) => onChanged(comboKey.setKeys(
                  value?.key,
                  modifier: value?.modifier,
                )),
              ),
              if (comboKey.key != null) ...[
                const Opacity(opacity: 0.25, child: Text("alt")),
                KeyListenerWidget(
                  currentKey: comboKey.altSet,
                  onChanged: (value) => onChanged(comboKey.setKeys(
                    value?.key,
                    modifier: value?.modifier,
                    alt: true,
                  )),
                ),
              ],
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: IconButton(
                  onPressed: currentKey == defaultKey || currentKey == null ? null : () => onChanged(defaultKey),
                  iconSize: 24,
                  icon: const Icon(IconsaxPlusBold.broom),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class KeyListenerWidget extends ConsumerStatefulWidget {
  final KeyCombination? currentKey;
  final Function(KeyCombination? value) onChanged;

  KeyListenerWidget({
    required this.currentKey,
    required this.onChanged,
    super.key,
  });

  @override
  KeyListenerWidgetState createState() => KeyListenerWidgetState();
}

class KeyListenerWidgetState extends ConsumerState<KeyListenerWidget> {
  final focusNode = FocusNode();
  bool _isListening = false;
  bool _showClearButton = false;
  LogicalKeyboardKey? _pressedKey;
  LogicalKeyboardKey? _pressedModifier;

  void setIsListening(bool value) {
    ref.read(keyListeningProvider.notifier).state = value;
    _isListening = value;
  }

  @override
  void dispose() {
    _isListening = false;
    _pressedKey = null;
    _pressedModifier = null;
    super.dispose();
  }

  void _startListening() {
    if (ref.read(keyListeningProvider)) return;
    setState(() {
      setIsListening(true);
      _pressedKey = null;
      _pressedModifier = null;
    });
  }

  void _stopListening() {
    setState(() {
      setIsListening(false);
      if (_pressedKey != null) {
        final newKeyComb = KeyCombination(
          key: _pressedKey!,
          modifier: _pressedModifier,
        );
        widget.onChanged(newKeyComb);
      }
      _pressedKey = null;
      _pressedModifier = null;
    });
  }

  void _handleKeyEvent(KeyEvent event) {
    final videoHotKeys = ref.read(videoPlayerSettingsProvider.select((value) => value.currentShortcuts)).values;
    final clientHotKeys = ref.read(clientSettingsProvider.select((value) => value.currentShortcuts)).values;
    final activeHotKeys = [...videoHotKeys, ...clientHotKeys].toList();

    if (_isListening) {
      focusNode.requestFocus();
      setState(() {
        if (event is KeyDownEvent) {
          if (KeyCombination.modifierKeys.contains(event.logicalKey)) {
            _pressedModifier = event.logicalKey;
          } else {
            final currentHotKey = KeyCombination(key: event.logicalKey, modifier: _pressedModifier);
            bool isExistingHotkey = activeHotKeys.any((element) {
              return element.containsSameSet(currentHotKey) && currentHotKey != widget.currentKey;
            });

            if (!isExistingHotkey) {
              _pressedKey = event.logicalKey;
              _stopListening();
            } else {
              if (context.mounted) {
                fladderSnackbar(context, title: context.localized.shortCutAlreadyAssigned(currentHotKey.label));
              }
              _stopListening();
            }
          }
        } else if (event is KeyUpEvent) {
          if (KeyCombination.modifierKeys.contains(event.logicalKey) && _pressedModifier == event.logicalKey) {
            _pressedModifier = null;
          } else if (_pressedKey == event.logicalKey) {
            _pressedKey = null;
          }
        }
      });
    } else {
      _pressedKey = null;
      _pressedModifier = null;
    }
  }

  void showClearButton(bool value) {
    setState(() {
      _showClearButton = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentModifier = _pressedModifier ?? (widget.currentKey?.modifier);
    final currentKey = _pressedKey ?? widget.currentKey?.key;
    final currentHotKey = currentKey == null ? null : KeyCombination(key: currentKey, modifier: currentModifier);
    return MouseRegion(
      onEnter: (event) => showClearButton(true),
      onExit: (event) => showClearButton(false),
      child: ClipRRect(
        borderRadius: FladderTheme.smallShape.borderRadius,
        child: InkWell(
          onTap: _isListening ? _stopListening : _startListening,
          onSecondaryTap: () {
            setState(() {
              setIsListening(false);
              widget.onChanged(null);
            });
          },
          child: Container(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: AnimatedSize(
              duration: const Duration(milliseconds: 125),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      spacing: 8,
                      children: [
                        Text(currentHotKey?.label ?? "+"),
                        if (_showClearButton && currentHotKey != null)
                          GestureDetector(
                            onTap: () {
                              setIsListening(false);
                              widget.onChanged(null);
                            },
                            child: const Icon(
                              IconsaxPlusLinear.trash,
                              size: 17,
                            ),
                          )
                      ],
                    ),
                  ),
                  if (_isListening)
                    Positioned.fill(
                      child: KeyboardListener(
                        focusNode: focusNode,
                        autofocus: true,
                        onKeyEvent: _handleKeyEvent,
                        child: const Opacity(
                          opacity: 0.25,
                          child: LinearProgressIndicator(),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
