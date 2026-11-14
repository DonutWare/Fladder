import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListButton extends ConsumerWidget {
  final String label;
  final Icon icon;
  final VoidCallback onTap;
  final double height;
  const ListButton({required this.label, required this.icon, required this.onTap, this.height = 56, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      onTap: onTap,
      horizontalTitleGap: 15,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
      leading: Padding(
        padding: const EdgeInsets.all(3),
        child: icon,
      ),
      title: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(28.0)),
      ),
    );
  }
}
