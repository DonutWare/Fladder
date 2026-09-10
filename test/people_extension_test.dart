import 'package:flutter_test/flutter_test.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/util/people_extension.dart';

Person _person(String name, PersonKind? type) => Person(id: name, name: name, type: type);

void main() {
  // Mirrors what the server actually returns: a long run of actors with the
  // crew appended at the end, in whatever order the metadata provider used.
  final people = [
    _person('actor1', PersonKind.actor),
    _person('actor2', PersonKind.actor),
    _person('guest1', PersonKind.gueststar),
    _person('composer1', PersonKind.composer),
    _person('director1', PersonKind.director),
    _person('producer1', PersonKind.producer),
    _person('writer1', PersonKind.writer),
    _person('producer2', PersonKind.producer),
    _person('creator1', PersonKind.creator),
    _person('unknownRole', null),
  ];

  group('actors', () {
    test('contains only billed actors, in provider order', () {
      expect(people.actors.map((e) => e.name), ['actor1', 'actor2']);
    });

    test('is empty when there are no actors', () {
      expect([_person('director1', PersonKind.director)].actors, isEmpty);
    });
  });

  group('guestActors', () {
    test('selects only guest stars', () {
      expect(people.guestActors.map((e) => e.name), ['guest1']);
    });
  });

  group('crew', () {
    test('orders creator, producer, composer, then the rest', () {
      expect(
        people.crew.map((e) => e.name),
        ['creator1', 'producer1', 'producer2', 'composer1', 'unknownRole'],
      );
    });

    test('keeps billing order within a single role', () {
      expect(people.crew.where((e) => e.type == PersonKind.producer).map((e) => e.name), ['producer1', 'producer2']);
    });

    test('excludes actors, guest stars, directors and writers', () {
      const excluded = {PersonKind.actor, PersonKind.gueststar, PersonKind.director, PersonKind.writer};
      expect(people.crew.any((e) => excluded.contains(e.type)), isFalse);
    });

    test('is empty when there is no other crew', () {
      final castOnly = [
        _person('actor1', PersonKind.actor),
        _person('director1', PersonKind.director),
        _person('writer1', PersonKind.writer),
      ];
      expect(castOnly.crew, isEmpty);
    });
  });
}
