import 'package:flutter/material.dart';

Future<void> showModalSideSheet(
  BuildContext context, {
  required Widget content,
  Widget? header,
  bool barrierDismissible = true,
  bool backButton = false,
  bool closeButton = false,
  bool addDivider = true,
  List<Widget>? actions,
  Function()? onDismiss,
  Duration? transitionDuration,
}) async {
  await showGeneralDialog(
    context: context,
    transitionDuration: transitionDuration ?? const Duration(milliseconds: 200),
    barrierDismissible: barrierDismissible,
    barrierColor: Theme.of(context).colorScheme.scrim.withValues(alpha: 0.3),
    barrierLabel: 'Material 3 side sheet',
    useRootNavigator: false,
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween(begin: const Offset(1, 0), end: const Offset(0, 0)).animate(
          animation,
        ),
        child: child,
      );
    },
    pageBuilder: (context, animation1, animation2) {
      return Align(
        alignment: Alignment.centerRight,
        child: Sheet(
          header: header,
          backButton: backButton,
          closeButton: closeButton,
          actions: actions,
          content: content,
          addDivider: addDivider,
        ),
      );
    },
  );
  onDismiss?.call();
}

class Sheet extends StatelessWidget {
  final Widget? header;
  final bool backButton;
  final bool closeButton;
  final Widget content;
  final bool addDivider;
  final List<Widget>? actions;

  const Sheet({
    super.key,
    this.header,
    required this.backButton,
    required this.closeButton,
    required this.content,
    required this.addDivider,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Material(
      elevation: 1,
      color: colorScheme.surface,
      surfaceTintColor: colorScheme.onSurface,
      borderRadius: const BorderRadius.horizontal(left: Radius.circular(20)),
      child: Padding(
        padding: MediaQuery.of(context).padding,
        child: Container(
          constraints: BoxConstraints(
            minWidth: 256,
            maxWidth: size.width <= 600 ? size.width : 400,
            minHeight: size.height,
            maxHeight: size.height,
          ),
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: content,
              ),
              if (actions?.isNotEmpty ?? false) _buildFooter(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 16, 16),
      child: Row(
        children: [
          Visibility(
            visible: backButton,
            child: const BackButton(),
          ),
          if (header != null)
            Material(
              textStyle: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
              color: Colors.transparent,
              child: header!,
            ),
          const Spacer(),
          Visibility(
            visible: closeButton,
            child: const CloseButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: addDivider,
          child: const Divider(
            indent: 24,
            endIndent: 24,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 16, 24, 24),
          child: Row(
            children: actions ?? [],
          ),
        ),
      ],
    );
  }
}
