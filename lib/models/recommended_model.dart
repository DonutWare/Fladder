import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/util/localization_helper.dart';

sealed class NameSwitch {
  const NameSwitch();

  String label(BuildContext context);
}

class NextUp extends NameSwitch {
  const NextUp();

  @override
  String label(BuildContext context) => context.localized.nextUp;
}

class Latest extends NameSwitch {
  const Latest();

  @override
  String label(BuildContext context) => context.localized.latest;
}

class Other extends NameSwitch {
  final String customLabel;

  const Other(this.customLabel);

  @override
  String label(BuildContext context) => customLabel;
}

extension RecommendationTypeExtenstion on RecommendationType {
  String label(BuildContext context) => switch (this) {
        RecommendationType.similartorecentlyplayed => context.localized.similarToRecentlyPlayed,
        RecommendationType.similartolikeditem => context.localized.similarToLikedItem,
        RecommendationType.hasdirectorfromrecentlyplayed => context.localized.hasDirectorFromRecentlyPlayed,
        RecommendationType.hasactorfromrecentlyplayed => context.localized.hasActorFromRecentlyPlayed,
        RecommendationType.haslikeddirector => context.localized.hasLikedDirector,
        RecommendationType.haslikedactor => context.localized.hasLikedActor,
        _ => "",
      };
}

class RecommendedModel {
  final NameSwitch name;
  final List<ItemBaseModel> posters;
  final RecommendationType? type;
  RecommendedModel({
    required this.name,
    required this.posters,
    this.type,
  });

  RecommendedModel copyWith({
    NameSwitch? name,
    List<ItemBaseModel>? posters,
    RecommendationType? type,
  }) {
    return RecommendedModel(
      name: name ?? this.name,
      posters: posters ?? this.posters,
      type: type ?? this.type,
    );
  }

  factory RecommendedModel.fromBaseDto(RecommendationDto e, Ref ref) {
    return RecommendedModel(
      name: Other(e.baselineItemName ?? ""),
      posters: e.items?.map((e) => ItemBaseModel.fromBaseDto(e, ref)).toList() ?? [],
      type: e.recommendationType,
    );
  }
}
