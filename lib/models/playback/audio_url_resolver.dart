import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/item_stream_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/sync_provider.dart';
import 'package:fladder/providers/user_provider.dart';

class AudioUrlResolver {
  const AudioUrlResolver(this.ref);

  final Ref ref;

  Future<String> resolve(ItemBaseModel item) async {
    final synced = await ref.read(syncProvider.notifier).getSyncedItem(item.id);
    if (synced != null && synced.videoFile.existsSync()) {
      return synced.videoFile.path;
    }
    return _directUrl(item);
  }

  String _directUrl(ItemBaseModel item) {
    final token = ref.read(userProvider)?.credentials.token;
    final params = <String, String?>{
      'Static': 'true',
      if (token != null) 'api_key': token,
    };

    var streamId = item.id;
    if (item is ItemStreamModel) {
      final mediaSourceId = item.mediaStreams.currentVersionStream?.id;
      if (mediaSourceId != null && mediaSourceId.isNotEmpty) {
        streamId = mediaSourceId;
        params['mediaSourceId'] = mediaSourceId;
      }
    }

    return buildServerUrl(ref, pathSegments: ['Audio', streamId, 'stream'], queryParameters: params);
  }
}
