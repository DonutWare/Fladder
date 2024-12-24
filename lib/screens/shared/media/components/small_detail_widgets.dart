import 'package:flutter/material.dart';

import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/models/items/movie_model.dart';
import 'package:fladder/screens/shared/media/components/chip_button.dart';
import 'package:fladder/util/string_extensions.dart';

class Ratings extends StatelessWidget {
  final double? communityRating;
  final String? officialRating;
  const Ratings({
    super.key,
    this.communityRating,
    this.officialRating,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (communityRating != null) ...{
          const Icon(
            Icons.star_rounded,
            color: Colors.yellow,
          ),
          Text(
            communityRating?.toStringAsFixed(1) ?? "",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        },
        if (officialRating != null) ...{
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                officialRating ?? "",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        },
      ],
    );
  }
}

class Tags extends StatelessWidget {
  final List<String> tags;
  const Tags({
    super.key,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 8,
      spacing: 8,
      children: tags
          .map((tag) => ChipButton(
                onPressed: () {},
                label: tag.capitalize(),
              ))
          .toList(),
    );
  }
}

class Genres extends StatelessWidget {
  final List<GenreItems> genres;
  const Genres({
    super.key,
    required this.genres,
    this.details,
  });

  final MovieModel? details;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 8,
      spacing: 8,
      runAlignment: WrapAlignment.center,
      alignment: WrapAlignment.center,
      children: genres
          .map(
            (genre) => ChipButton(
              onPressed: null,
              label: genre.name.capitalize(),
            ),
          )
          .toList(),
    );
  }
}
