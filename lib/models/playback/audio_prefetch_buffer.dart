import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/playback/audio_url_resolver.dart';

class AudioPrefetchBuffer {
  AudioPrefetchBuffer({this.bufferSize = 50});

  final int bufferSize;
  final Map<String, Future<String>> _cache = {};

  void prefetch(List<ItemBaseModel> items, AudioUrlResolver resolver) {
    for (final item in items.take(bufferSize)) {
      _cache.putIfAbsent(item.id, () => resolver.resolve(item));
    }
  }

  Future<String?> getUrl(String itemId) => _cache[itemId] ?? Future.value(null);

  void invalidate() => _cache.clear();
}
