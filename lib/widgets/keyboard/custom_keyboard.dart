import 'dart:async';

import 'package:flutter/material.dart';

import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/screens/shared/animated_fade_size.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/keyboard/alpha_numeric_keyboard.dart';

class CustomKeyboard extends InheritedWidget {
  final CustomKeyboardState state;

  const CustomKeyboard({
    required this.state,
    required super.child,
    super.key,
  });

  static CustomKeyboardState of(BuildContext context) {
    final inherited = context.dependOnInheritedWidgetOfExactType<CustomKeyboard>();
    assert(inherited != null, 'No CustomKeyboard found in context');
    return inherited!.state;
  }

  @override
  bool updateShouldNotify(CustomKeyboard oldWidget) => state != oldWidget.state;
}

class CustomKeyboardWrapper extends StatefulWidget {
  final Widget child;

  const CustomKeyboardWrapper({super.key, required this.child});

  @override
  CustomKeyboardState createState() => CustomKeyboardState();
}

class CustomKeyboardState extends State<CustomKeyboardWrapper> {
  bool _isOpen = false;
  TextEditingController? _controller;
  TextField? _textField;

  bool get isOpen => _isOpen;

  VoidCallback? onCloseCall;

  FutureOr<List<String>> Function(String query)? searchQuery;

  void openKeyboard(
    TextField textField, {
    VoidCallback? onClosed,
    FutureOr<List<String>> Function(String query)? query,
  }) {
    onCloseCall = onClosed;

    searchQuery = query;

    setState(() {
      _isOpen = true;
      _textField = textField;
      _controller = textField.controller;
    });
    _controller?.addListener(() {
      _textField?.onChanged?.call(_controller?.text ?? "");
    });
  }

  void closeKeyboard() {
    setState(() {
      _isOpen = false;
    });
    onCloseCall?.call();
    onCloseCall = null;
    if (_controller != null) {
      _textField?.onSubmitted?.call(_controller?.text ?? "");
      _textField?.onEditingComplete?.call();
      _controller?.removeListener(() {
        _textField?.onChanged?.call(_controller?.text ?? "");
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return BackButtonListener(
      onBackButtonPressed: () async {
        if (!context.mounted) return false;
        if (_isOpen && context.mounted) {
          closeKeyboard();
          return true;
        } else {
          return false;
        }
      },
      child: CustomKeyboard(
        state: this,
        child: Container(
          color: Theme.of(context).colorScheme.surface,
          alignment: Alignment.center,
          child: Row(
            children: [
              AnimatedSize(
                duration: const Duration(milliseconds: 125),
                child: _isOpen
                    ? SizedBox(
                        width: mq.size.width * 0.20,
                        height: double.infinity,
                        child: Material(
                          color: Theme.of(context).colorScheme.surface,
                          child: _CustomKeyboardView(
                            controller: _controller!,
                            keyboardType: _textField?.keyboardType,
                            keyboardActionType: _textField?.textInputAction,
                            onClose: closeKeyboard,
                            onChanged: () => _textField?.onChanged?.call(_controller?.text ?? ""),
                            searchQuery: searchQuery,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              Expanded(child: widget.child),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomKeyboardView extends StatefulWidget {
  final TextEditingController controller;
  final TextInputAction? keyboardActionType;
  final TextInputType? keyboardType;

  final VoidCallback onChanged;
  final VoidCallback onClose;
  final FutureOr<List<String>> Function(String query)? searchQuery;

  const _CustomKeyboardView({
    required this.controller,
    required this.onChanged,
    required this.onClose,
    this.keyboardActionType,
    this.keyboardType,
    this.searchQuery,
  });

  @override
  State<_CustomKeyboardView> createState() => _CustomKeyboardViewState();
}

class _CustomKeyboardViewState extends State<_CustomKeyboardView> {
  final FocusScopeNode scope = FocusScopeNode();

  ValueNotifier<List<String>> searchQueryResults = ValueNotifier([]);

  Future<void> startUpdate(String text) async {
    final newValues = await widget.searchQuery?.call(widget.controller.text) ?? [];
    searchQueryResults.value = newValues;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((value) {
      startUpdate(widget.controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!scope.hasFocus) {
      scope.requestFocus();
    }
    return FocusScope(
      node: scope,
      autofocus: true,
      child: Padding(
        padding: const EdgeInsets.all(12.0).add(MediaQuery.paddingOf(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  widget.keyboardType == TextInputType.visiblePassword
                      ? List.generate(
                          widget.controller.text.length,
                          (index) => "*",
                        ).join()
                      : widget.controller.text,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            if (widget.searchQuery != null)
              ValueListenableBuilder(
                valueListenable: searchQueryResults,
                builder: (context, values, child) => _SearchResults(
                  results: values,
                  query: widget.controller.text,
                  onTap: (value) {
                    widget.controller.text = value;
                    widget.onClose();
                  },
                ),
              ),
            Flexible(
              child: AlphaNumericKeyboard(
                onCharacter: (value) => setState(() {
                  widget.controller.text += value;
                  startUpdate(widget.controller.text);
                }),
                keyboardType: widget.keyboardType ?? TextInputType.name,
                keyboardActionType: widget.keyboardActionType ?? TextInputAction.done,
                onBackspace: () {
                  setState(() {
                    widget.controller.text = widget.controller.text.substring(0, widget.controller.text.length - 1);
                    widget.onChanged();
                  });
                  startUpdate(widget.controller.text);
                },
                onClear: () => setState(() => widget.controller.clear()),
                onDone: widget.onClose,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchResults extends StatelessWidget {
  final List<String> results;
  final String query;
  final Function(String value) onTap;
  const _SearchResults({
    required this.results,
    required this.query,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final minHeight = MediaQuery.sizeOf(context).height * 0.25;
    return AnimatedFadeSize(
      alignment: Alignment.topCenter,
      child: results.isNotEmpty && query.isNotEmpty
          ? ConstrainedBox(
              constraints: BoxConstraints(minHeight: minHeight),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 6,
                children: [
                  ...results.map(
                    (result) => FocusButton(
                      onTap: () => onTap(result),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            spacing: 8,
                            children: [
                              const Icon(IconsaxPlusLinear.arrow_right),
                              Flexible(
                                child: Text(
                                  result,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : SizedBox(
              height: minHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 8,
                children: [
                  const Icon(IconsaxPlusLinear.search_status_1),
                  Text(context.localized.noResults),
                ],
              ),
            ),
    );
  }
}
