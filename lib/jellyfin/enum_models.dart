import 'package:flutter/material.dart';

import 'package:collection/collection.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/util/localization_helper.dart';

enum MetadataRefresh {
  defaultRefresh(MetadataRefreshMode.$default),
  validation(MetadataRefreshMode.validationonly),
  fullRefresh(MetadataRefreshMode.fullrefresh);

  const MetadataRefresh(this.api);

  final MetadataRefreshMode api;
  String label(BuildContext context) {
    return switch (this) {
      defaultRefresh => context.localized.metadataRefreshDefault,
      validation => context.localized.metadataRefreshValidation,
      fullRefresh => context.localized.metadataRefreshFull,
    };
  }

  ItemsItemIdRefreshPostMetadataRefreshMode? get metadataRefreshMode => switch (this) {
        MetadataRefresh.fullRefresh => ItemsItemIdRefreshPostMetadataRefreshMode.fullrefresh,
        MetadataRefresh.validation => ItemsItemIdRefreshPostMetadataRefreshMode.validationonly,
        _ => ItemsItemIdRefreshPostMetadataRefreshMode.$default
      };

  ItemsItemIdRefreshPostImageRefreshMode? get imageRefreshMode => switch (this) {
        MetadataRefresh.fullRefresh => ItemsItemIdRefreshPostImageRefreshMode.fullrefresh,
        MetadataRefresh.validation => ItemsItemIdRefreshPostImageRefreshMode.validationonly,
        _ => ItemsItemIdRefreshPostImageRefreshMode.$default
      };
}

enum ItemLocation {
  filesystem('FileSystem'),
  remote('Remote'),
  virtual('Virtual'),
  offline('Offline');

  final String? value;

  factory ItemLocation.fromDto(LocationType? type) =>
      ItemLocation.values.firstWhereOrNull((element) => type?.value == element.value) ?? ItemLocation.filesystem;

  const ItemLocation(this.value);
}
