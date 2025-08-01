import 'package:chopper/chopper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/items/movie_model.dart';
import 'package:fladder/providers/api_provider.dart';
import 'package:fladder/providers/related_provider.dart';
import 'package:fladder/providers/service_provider.dart';

part 'movies_details_provider.g.dart';

@riverpod
class MovieDetails extends _$MovieDetails {
  late final JellyService api = ref.read(jellyApiProvider);

  @override
  MovieModel? build(String arg) => null;

  Future<Response?> fetchDetails(ItemBaseModel item) async {
    try {
      if (item is MovieModel) {
        state = state ?? item;
      }
      MovieModel? newState;
      final response = await api.usersUserIdItemsItemIdGet(itemId: item.id);
      if (response.body == null) return null;
      newState = (response.bodyOrThrow as MovieModel).copyWith(related: state?.related);
      final related = await ref.read(relatedUtilityProvider).relatedContent(item.id);
      state = newState.copyWith(related: related.body);
      return null;
    } catch (e) {
      return null;
    }
  }

  void setSubIndex(int index) {
    state = state?.copyWith(mediaStreams: state?.mediaStreams.copyWith(defaultSubStreamIndex: index));
  }

  void setAudioIndex(int index) {
    state = state?.copyWith(mediaStreams: state?.mediaStreams.copyWith(defaultAudioStreamIndex: index));
  }

  void setVersionIndex(int index) {
    state = state?.copyWith(mediaStreams: state?.mediaStreams.copyWith(versionStreamIndex: index));
  }
}
