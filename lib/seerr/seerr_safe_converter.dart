import 'dart:async';
import 'dart:convert';

import 'package:chopper/chopper.dart' as chopper;

import 'seerr_open_api.swagger.dart';

class SeerrSafeJsonSerializableConverter extends chopper.JsonConverter {
  const SeerrSafeJsonSerializableConverter();

  @override
  FutureOr<chopper.Response<ResultType>> convertResponse<ResultType, Item>(
    chopper.Response response,
  ) async {
    if (response.bodyString.isEmpty) {
      return chopper.Response(response.base, null, error: response.error);
    }

    if (ResultType == String) {
      return response.copyWith();
    }

    if (ResultType == DateTime) {
      return response.copyWith(
        body: DateTime.parse((response.body as String).replaceAll('"', '')) as ResultType,
      );
    }

    final jsonRes = await super.convertResponse(response);

    final dynamic sanitizedBody = _sanitizeBodyFor<Item>(jsonRes.body);

    return jsonRes.copyWith<ResultType>(
      body: $jsonDecoder.decode<Item>(sanitizedBody) as ResultType,
    );
  }

  dynamic _sanitizeBodyFor<T>(dynamic body) {
    // The generated models expect `watchProviders` to be `List<WatchProviders>`
    // (aka `List<List<WatchProviders$Item>>`), but some Seerr instances return
    // a TMDB-style map. Since Fladder doesn't rely on this field, we drop it to
    // avoid hard decode crashes.
    if (T == MovieDetails || T == TvDetails) {
      final map = _stringKeyedMap(body);
      if (map == null) return body;

      final watchProviders = map['watchProviders'];
      final shouldDropWatchProviders = switch (watchProviders) {
        null => false,
        // TMDB-style object/map shape.
        Map() => true,
        // Some servers respond with a flat list (eg `[{...}, {...}]`) instead
        // of the generated nested list shape (`[[{...}], [{...}]]`).
        List() => watchProviders.isNotEmpty && watchProviders.any((e) => e is! List),
        _ => true,
      };

      if (shouldDropWatchProviders) {
        final copy = Map<String, dynamic>.from(map);
        copy.remove('watchProviders');
        return copy;
      }

      return map;
    }

    return body;
  }

  Map<String, dynamic>? _stringKeyedMap(Object? value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) {
      return value.map((key, val) => MapEntry(key.toString(), val));
    }

    // Sometimes `super.convertResponse` returns a JSON string.
    if (value is String) {
      try {
        final decoded = jsonDecode(value);
        if (decoded is Map) {
          return decoded.map((key, val) => MapEntry(key.toString(), val));
        }
      } catch (_) {
        return null;
      }
    }

    return null;
  }
}
