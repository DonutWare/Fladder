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
      SyncPlayUserAccessType.createandjoingroups => "Create and Join Groups",
      SyncPlayUserAccessType.joingroups => "Join Groups",
      SyncPlayUserAccessType.none => "None",
      _ => context.localized.unknown,
    };
  }
}
