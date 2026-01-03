import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:chopper/chopper.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/util/localization_helper.dart';

extension JellyApiExtension on JellyfinOpenApi {
  Future<Response<dynamic>?> itemIdImagesImageTypePost(
    ImageType type,
    String itemId,
    Uint8List data,
  ) async {
    final client = this.client;
    final uri = Uri.parse('/Items/$itemId/Images/${type.value}');
    final response = await client.send(
      Request(
        'POST',
        uri,
        this.client.baseUrl,
        body: base64Encode(data),
        headers: {
          'Content-Type': 'image/*',
        },
      ),
    );
    return response;
  }
}

extension SyncPlayUserAccessTypeExtension on SyncPlayUserAccessType? {
  String? label(BuildContext context) {
    return switch (this) {
      SyncPlayUserAccessType.createandjoingroups => context.localized.syncplayAccessCreateAndJoinGroups,
      SyncPlayUserAccessType.joingroups => context.localized.syncplayAccessJoinGroups,
      SyncPlayUserAccessType.none => context.localized.syncplayAccessNone,
      _ => context.localized.unknown,
    };
  }
}

extension SubtitlePlaybackModeExtension on SubtitlePlaybackMode? {
  String label(BuildContext context) {
    return switch (this) {
      SubtitlePlaybackMode.$default => context.localized.subtitlePlaybackModeDefault,
      SubtitlePlaybackMode.always => context.localized.subtitlePlaybackModeAlways,
      SubtitlePlaybackMode.onlyforced => context.localized.subtitlePlaybackModeOnlyForced,
      SubtitlePlaybackMode.none => context.localized.subtitlePlaybackModeNone,
      SubtitlePlaybackMode.smart => context.localized.subtitlePlaybackModeSmart,
      _ => context.localized.unknown,
    };
  }
}
