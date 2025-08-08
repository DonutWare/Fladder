import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/settings/hotkeys_model.dart';
import 'package:fladder/providers/settings/video_player_settings_provider.dart';
import 'package:fladder/screens/shared/fladder_snackbar.dart';

final shiftKeys = {
  LogicalKeyboardKey.shift,
  LogicalKeyboardKey.shiftLeft,
  LogicalKeyboardKey.shiftRight,
};

final altKeys = {
  LogicalKeyboardKey.alt,
  LogicalKeyboardKey.altRight,
  LogicalKeyboardKey.altLeft,
};

final ctrlKeys = {
  LogicalKeyboardKey.control,
  LogicalKeyboardKey.controlLeft,
  LogicalKeyboardKey.controlRight,
};

final modifierKeys = {
  ...shiftKeys,
  ...altKeys,
  ...ctrlKeys,
};

class KeyCombinationWidget extends ConsumerStatefulWidget {
  final KeyCombination? currentKey;
  final KeyCombination defaultKey;
  final Function(KeyCombination? value) onChanged;

  KeyCombinationWidget({required this.currentKey, required this.defaultKey, required this.onChanged, super.key});

  @override
  KeyCombinationWidgetState createState() => KeyCombinationWidgetState();
}

class KeyCombinationWidgetState extends ConsumerState<KeyCombinationWidget> {
  final focusNode = FocusNode();
  bool _isListening = false;
  bool resetOnRelease = false;
  LogicalKeyboardKey? _pressedKey;
  LogicalKeyboardKey? _pressedModifier;

  @override
  void dispose() {
    _stopListening();
    super.dispose();
  }

  void _startListening() {
    setState(() {
      _isListening = true;
      _pressedKey = null;
      _pressedModifier = null;
    });
  }

  void _stopListening() {
    setState(() {
      _isListening = false;
      if (_pressedKey != null) {
        widget.onChanged(KeyCombination(
          key: _pressedKey!,
          modifier: _pressedModifier,
        ));
      }
      _pressedKey = null;
      _pressedModifier = null;
    });
  }

  void _handleKeyEvent(KeyEvent event) {
    final videoHotKeys = ref.read(videoPlayerSettingsProvider.select((value) => value.hotKeys.currentShortcuts)).values;
    final activeHotKeys = [...videoHotKeys].toList();

    if (event.logicalKey == LogicalKeyboardKey.escape) {
      _stopListening();
      return;
    }
    if (_isListening) {
      focusNode.requestFocus();
      setState(() {
        if (event is KeyDownEvent) {
          if (modifierKeys.contains(event.logicalKey)) {
            _pressedModifier = event.logicalKey;
          } else {
            final currentHotKey = KeyCombination(key: event.logicalKey, modifier: _pressedModifier);
            bool isExistingHotkey = activeHotKeys.any((element) {
              return element == currentHotKey;
            });

            if (!isExistingHotkey) {
              _pressedKey = event.logicalKey;
              _stopListening();
            } else {
              if (context.mounted) {
                fladderSnackbar(context, title: "Shortcut '${currentHotKey.label}' already assigned");
                _stopListening();
              }
            }
          }
        } else if (event is KeyUpEvent && resetOnRelease) {
          if (modifierKeys.contains(event.logicalKey) && _pressedModifier == event.logicalKey) {
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

  @override
  Widget build(BuildContext context) {
    final currentModifier =
        _pressedModifier ?? (widget.currentKey != null ? widget.currentKey?.modifier : widget.defaultKey.modifier);
    final currentKey = _pressedKey ?? (widget.currentKey?.key ?? widget.defaultKey.key);
    final currentHotKey = KeyCombination(key: currentKey, modifier: currentModifier);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 50),
          child: InkWell(
            onTap: _isListening ? null : _startListening,
            child: Card(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  spacing: 6,
                  children: [
                    Text(currentHotKey.label),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: _isListening
                          ? KeyboardListener(
                              focusNode: focusNode,
                              autofocus: true,
                              onKeyEvent: _handleKeyEvent,
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              ),
                            )
                          : IconButton(
                              onPressed: widget.currentKey == null
                                  ? null
                                  : () {
                                      _pressedKey = null;
                                      _pressedModifier = null;
                                      widget.onChanged(null);
                                    },
                              iconSize: 24,
                              icon: const Icon(IconsaxPlusBold.broom),
                            ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

extension LogicalKeyExtension on LogicalKeyboardKey {
  String get label {
    return switch (this) { LogicalKeyboardKey.space => "Space", _ => keyLabel };
  }
}
