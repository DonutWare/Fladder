import 'dart:async';

import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/screens/shared/animated_fade_size.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/keyboard/alpha_numeric_keyboard.dart';

ValueNotifier<bool> isKeyboardOpen = ValueNotifier<bool>(false);

double keyboardWidthFactor = 0.25;

class CustomKeyboardWrapper extends StatelessWidget {
  final Widget child;
  const CustomKeyboardWrapper({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: ValueListenableBuilder(
        valueListenable: isKeyboardOpen,
        builder: (context, value, _) {
          return AnimatedFractionallySizedBox(
            duration: const Duration(milliseconds: 175),
            widthFactor: value ? 1.0 - keyboardWidthFactor : 1.0,
            heightFactor: 1.0,
            alignment: Alignment.centerRight,
            child: child,
          );
        },
      ),
    );
  }
}

Future<T?> openKeyboard<T>(
  BuildContext context,
  TextEditingController controller, {
  TextInputType? inputType,
  TextInputAction? inputAction,
  FutureOr<List<String>> Function(String query)? searchQuery,
  VoidCallback? onChanged,
}) async {
  isKeyboardOpen.value = true;
  await showGeneralDialog(
    context: context,
    transitionDuration: const Duration(milliseconds: 175),
    barrierDismissible: true,
    barrierColor: Colors.transparent,
    barrierLabel: 'Custom keyboard',
    useRootNavigator: true,
    fullscreenDialog: true,
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween(begin: const Offset(-1, 0), end: const Offset(0, 0)).animate(
          animation,
        ),
        child: child,
      );
    },
    pageBuilder: (context, animation1, animation2) {
      return Align(
        alignment: Alignment.centerLeft,
        child: _SlideInKeyboard(
          controller: controller,
          onChanged: onChanged ?? () {},
          onClose: () {
            context.router.pop();
            isKeyboardOpen.value = false;
            return null;
          },
          inputType: inputType,
          inputAction: inputAction,
          searchQuery: searchQuery,
        ),
      );
    },
  );
  isKeyboardOpen.value = false;
  return null;
}

class _SlideInKeyboard extends StatefulWidget {
  final TextEditingController controller;
  final Function() onChanged;
  final Function() onClose;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final FutureOr<List<String>> Function(String query)? searchQuery;
  const _SlideInKeyboard({
    required this.controller,
    required this.onChanged,
    required this.onClose,
    this.inputType,
    this.inputAction,
    this.searchQuery,
  });

  @override
  State<_SlideInKeyboard> createState() => __SlideInKeyboardState();
}

class __SlideInKeyboardState extends State<_SlideInKeyboard> {
  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.paddingOf(context);
    final width = MediaQuery.sizeOf(context).width * keyboardWidthFactor;
    return FractionallySizedBox(
      widthFactor: keyboardWidthFactor,
      heightFactor: 1.0,
      child: Padding(
        padding: padding.copyWith(left: (padding.left - width).clamp(0, padding.left)),
        child: Container(
          height: double.infinity,
          color: Theme.of(context).colorScheme.surface,
          child: _CustomKeyboardView(
            controller: widget.controller,
            onChanged: widget.onChanged,
            onClose: widget.onClose,
            keyboardType: widget.inputType,
            keyboardActionType: widget.inputAction,
            searchQuery: widget.searchQuery,
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
        padding: const EdgeInsets.all(12.0),
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
                  Text(
                    context.localized.noResults,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
    );
  }
}
