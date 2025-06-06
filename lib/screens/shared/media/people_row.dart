import 'package:flutter/material.dart';

import 'package:animations/animations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/screens/details_screens/person_detail_screen.dart';
import 'package:fladder/screens/shared/flat_button.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/string_extensions.dart';
import 'package:fladder/widgets/shared/clickable_text.dart';
import 'package:fladder/widgets/shared/horizontal_list.dart';

class PeopleRow extends ConsumerWidget {
  final List<Person> people;
  final EdgeInsets contentPadding;
  const PeopleRow({required this.people, required this.contentPadding, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget placeHolder(String name) {
      return Center(
        child: SizedBox(
          height: 75,
          width: 75,
          child: Card(
            elevation: 5,
            shadowColor: Colors.transparent,
            color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.50),
            child: Center(
                child: Text(
              name.getInitials(),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            )),
          ),
        ),
      );
    }

    return HorizontalList(
      label: people.any((e) => e.type != PersonKind.gueststar)
          ? context.localized.castAndCrew
          : context.localized.guestActor(people.length),
      height: AdaptiveLayout.poster(context).size * 0.9,
      contentPadding: contentPadding,
      items: people,
      itemBuilder: (context, index) {
        final person = people[index];
        return AspectRatio(
          aspectRatio: 0.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: OpenContainer(
                  closedColor: Colors.transparent,
                  closedElevation: 5,
                  openElevation: 0,
                  closedShape: const RoundedRectangleBorder(),
                  transitionType: ContainerTransitionType.fadeThrough,
                  openColor: Colors.transparent,
                  tappable: false,
                  closedBuilder: (context, action) => Stack(
                    children: [
                      Positioned.fill(
                        child: Card(
                          child: FladderImage(
                            image: person.image,
                            placeHolder: placeHolder(person.name),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      FlatButton(onTap: () => action()),
                    ],
                  ),
                  openBuilder: (context, action) => PersonDetailScreen(
                    person: person,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              ClickableText(
                text: person.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              ClickableText(
                opacity: 0.45,
                text: person.role,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 13, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      },
    );
  }
}
