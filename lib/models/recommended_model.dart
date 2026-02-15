import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/l10n/generated/app_localizations.dart';

sealed class NameSwitch {
  const NameSwitch();

  String label(AppLocalizations l10n);
}

class Continue extends NameSwitch {
  const Continue();

  @override
  String label(AppLocalizations l10n) => l10n.dashboardContinue;
}

class NextUp extends NameSwitch {
  const NextUp();

  @override
  String label(AppLocalizations l10n) => l10n.nextUp;
}

class Latest extends NameSwitch {
  const Latest();

  @override
  String label(AppLocalizations l10n) => l10n.latest;
}

class Other extends NameSwitch {
  final String customLabel;

  const Other(this.customLabel);

  @override
  String label(AppLocalizations l10n) => customLabel;
}

extension RecommendationTypeExtenstion on RecommendationType {
  String label(AppLocalizations l10n) => switch (this) {
        RecommendationType.similartorecentlyplayed => l10n.similarToRecentlyPlayed,
        RecommendationType.similartolikeditem => l10n.similarToLikedItem,
        RecommendationType.hasdirectorfromrecentlyplayed => l10n.hasDirectorFromRecentlyPlayed,
        RecommendationType.hasactorfromrecentlyplayed => l10n.hasActorFromRecentlyPlayed,
        RecommendationType.haslikeddirector => l10n.hasLikedDirector,
        RecommendationType.haslikedactor => l10n.hasLikedActor,
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
