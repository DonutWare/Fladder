import 'package:material_ui/material_ui.dart';

class SpacedListTile extends StatelessWidget {
  final Widget title;
  final Widget? content;
  final Function()? onTap;
  const SpacedListTile({required this.title, this.content, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(flex: 1, child: title),
          if (content != null)
            Flexible(
              flex: 1,
              child: content!,
            ),
        ],
      ),
      onTap: onTap,
    );
  }
}
