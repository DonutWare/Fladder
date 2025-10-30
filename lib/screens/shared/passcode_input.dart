import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/screens/shared/animated_fade_size.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';

class PassCodeInput extends ConsumerStatefulWidget {
  final ValueChanged<String> passCode;
  const PassCodeInput({required this.passCode, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PassCodeInputState();
}

class _PassCodeInputState extends ConsumerState<PassCodeInput> {
  final iconSize = 45.0;
  final passCodeLength = 4;
  var currentPasscode = "";

  @override
  void initState() {
    super.initState();
    HardwareKeyboard.instance.addHandler(_onKey);
  }

  @override
  void dispose() {
    HardwareKeyboard.instance.removeHandler(_onKey);
    super.dispose();
  }

  bool _onKey(KeyEvent value) {
    if (value is KeyDownEvent) {
      final keyInt = int.tryParse(value.logicalKey.keyLabel);
      if (keyInt != null) {
        addToPassCode(value.logicalKey.keyLabel);
        return true;
      }
      if (value.logicalKey == LogicalKeyboardKey.backspace) {
        backSpace();
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 8,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              passCodeLength,
              (index) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: SizedBox(
                    height: iconSize * 1.2,
                    width: iconSize * 1.2,
                    child: Card(
                      child: Transform.translate(
                        offset: const Offset(0, 5),
                        child: AnimatedFadeSize(
                          child: Text(
                            currentPasscode.length > index ? "*" : "",
                            style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 60),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.of([1, 2, 3]).map((e) => passCodeNumber(e)).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.of([4, 5, 6]).map((e) => passCodeNumber(e)).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.of([7, 8, 9]).map((e) => passCodeNumber(e)).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              backSpaceButton,
              passCodeNumber(0),
              clearAllButton,
            ],
          )
        ],
      ),
    );
  }

  Widget passCodeNumber(int value) {
    return ElevatedButton(
      autofocus: AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad ? value == 1 : false,
      onPressed: () {
        addToPassCode(value.toString());
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(8),
        foregroundColor: Theme.of(context).colorScheme.onSurface,
      ),
      child: Container(
        width: iconSize,
        height: iconSize,
        alignment: Alignment.center,
        child: Text(
          value.toString(),
          style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void addToPassCode(String value) async {
    String newPasscode = currentPasscode + value.toString();
    if (newPasscode.length == passCodeLength) {
      Navigator.of(context).pop();
      await Future.delayed(const Duration(milliseconds: 250));
      widget.passCode(newPasscode);
    } else {
      setState(() {
        currentPasscode = newPasscode;
      });
    }
  }

  void backSpace() {
    setState(() {
      if (currentPasscode.isNotEmpty) {
        currentPasscode = currentPasscode.substring(0, currentPasscode.length - 1);
      }
    });
  }

  Widget get clearAllButton {
    return IconButton.filled(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.errorContainer),
        iconColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.onErrorContainer),
      ),
      onPressed: () {
        setState(() {
          currentPasscode = "";
        });
      },
      icon: Icon(
        Icons.clear_rounded,
        size: iconSize,
      ),
    );
  }

  Widget get backSpaceButton {
    return IconButton.filled(
      onPressed: () => backSpace(),
      icon: Icon(
        Icons.backspace_rounded,
        size: iconSize,
      ),
    );
  }
}

void showPassCodeDialog(BuildContext context, ValueChanged<String> newPin) {
  showDialog(
    context: context,
    builder: (context) => PassCodeInput(
      passCode: (value) {
        newPin.call(value);
      },
    ),
  );
}
