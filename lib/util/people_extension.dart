import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart';
import 'package:fladder/models/items/item_shared_models.dart';

/// Crew roles in display order; anything else follows in its original order.
/// Directors and writers are not listed because they get their own lines.
const _crewOrder = [
  PersonKind.creator,
  PersonKind.producer,
  PersonKind.composer,
];

extension PeopleExtension on List<Person> {
  List<Person> get guestActors => where((person) => person.type == PersonKind.gueststar).toList();

  /// Billed actors only, in the order the metadata provider supplied them.
  List<Person> get actors => where((person) => person.type == PersonKind.actor).toList();

  /// Non-acting credits other than directors and writers, which get their own
  /// lines: creator, producer, composer, then the rest. Grouped rather than
  /// sorted so billing order within a role is kept ([List.sort] is not
  /// guaranteed to be stable).
  List<Person> get crew {
    final others = where((person) => switch (person.type) {
          PersonKind.actor || PersonKind.gueststar || PersonKind.director || PersonKind.writer => false,
          _ => true,
        }).toList();

    final ordered = <Person>[];
    for (final kind in _crewOrder) {
      ordered.addAll(others.where((person) => person.type == kind));
    }
    ordered.addAll(others.where((person) => !_crewOrder.contains(person.type)));
    return ordered;
  }
}
