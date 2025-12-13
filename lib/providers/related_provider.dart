import 'package:chopper/chopper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/service_provider.dart';

final relatedUtilityProvider = Provider<RelatedNotifier>((ref) {
  return RelatedNotifier(ref: ref);
});

class RelatedNotifier {
  final Ref ref;
  RelatedNotifier({
    required this.ref,
  });

  late final JellyService api = ref.read(jellyApiProvider);

  late final String currentServerUrl = ref.read(serverUrlProvider) ?? "";

  Future<Response<List<ItemBaseModel>>> relatedContent(String itemId) async {
    final related = await api.itemsItemIdSimilarGet(itemId: itemId, limit: 50);
    List<ItemBaseModel> posters = related.body?.items?.map((e) => ItemBaseModel.fromBaseDto(e, ref)).toList() ?? [];
    return Response(related.base, posters);
  }
}
