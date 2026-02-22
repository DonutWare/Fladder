import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/screens/details_screens/details_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PersonList extends ConsumerWidget {
  final String label;
  final List<Person> people;
  final ValueChanged<Person>? onPersonTap;
  const PersonList({required this.label, required this.people, this.onPersonTap, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 16,
      runSpacing: 16,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        ...people.map((person) => TextButton(
            onPressed:
                onPersonTap != null ? () => onPersonTap?.call(person) : () => openPersonDetailPage(context, person),
            child: Text(person.name)))
      ],
    );
  }

  void openPersonDetailPage(BuildContext context, Person person) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => PersonDetailScreen(person: person),
    ));
  }
}
