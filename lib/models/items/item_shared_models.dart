// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/widgets.dart';

import 'package:collection/collection.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart';
import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart' as dto;
import 'package:fladder/models/items/images_models.dart';

part 'item_shared_models.mapper.dart';

@MappableClass()
class UserData with UserDataMappable {
  final bool isFavourite;
  final int playCount;
  final int? unPlayedItemCount;
  final int playbackPositionTicks;
  final double progress;
  final bool played;
  final DateTime? lastPlayed;
  const UserData({
    this.isFavourite = false,
    this.playCount = 0,
    this.unPlayedItemCount,
    this.playbackPositionTicks = 0,
    this.progress = 0,
    this.lastPlayed,
    this.played = false,
  });

  factory UserData.fromDto(dto.UserItemDataDto? dto) {
    if (dto == null) {
      return const UserData();
    }
    return UserData(
      isFavourite: dto.isFavorite ?? false,
      playCount: dto.playCount ?? 0,
      playbackPositionTicks: dto.playbackPositionTicks ?? 0,
      played: dto.played ?? false,
      unPlayedItemCount: dto.unplayedItemCount ?? 0,
      lastPlayed: dto.lastPlayedDate,
      progress: dto.playedPercentage ?? 0,
    );
  }

  Duration get playBackPosition => Duration(milliseconds: playbackPositionTicks ~/ 10000);

  factory UserData.fromMap(Map<String, dynamic> map) => UserDataMapper.fromMap(map);
  factory UserData.fromJson(String json) => UserDataMapper.fromJson(json);
}

class UserDataJsonSerializer extends JsonConverter<UserData, String> {
  const UserDataJsonSerializer();

  @override
  UserData fromJson(String json) {
    return UserData.fromJson(json);
  }

  @override
  String toJson(UserData object) {
    return object.toJson();
  }
}

enum EditorLockedFields {
  name("Name"),
  overView("Overview"),
  genres("Genres"),
  officialRating("OfficialRating"),
  cast("Cast"),
  productionLocations("ProductionLocations"),
  runTime("Runtime"),
  studios("Studios"),
  tags("Tags"),
  ;

  const EditorLockedFields(this.value);

  static Map<EditorLockedFields, bool> enabled(List<String> fromStrings) => Map.fromEntries(
        EditorLockedFields.values.map(
          (e) => MapEntry(e, fromStrings.contains(e.value)),
        ),
      );

  final String value;
}

enum DisplayOrder {
  empty(""),
  aired("aired"),
  originalAirDate("originalAirDate"),
  absolute("absolute"),
  dvd("dvd"),
  digital("digital"),
  storyArc("storyArc"),
  production("production"),
  tv("tv"),
  ;

  const DisplayOrder(this.value);

  static DisplayOrder? fromMap(String? value) {
    return DisplayOrder.values.firstWhereOrNull((element) => element.value == value) ?? DisplayOrder.empty;
  }

  final String value;
}

enum ShowStatus {
  empty(""),
  ended("Ended"),
  continuing("Continuing");

  const ShowStatus(this.value);

  static ShowStatus? fromMap(String? value) {
    return ShowStatus.values.firstWhereOrNull((element) => element.value == value) ?? ShowStatus.empty;
  }

  final String value;
}

class ExternalUrls {
  final String name;
  final String url;
  ExternalUrls({
    required this.name,
    required this.url,
  });

  static List<ExternalUrls> fromDto(List<dto.ExternalUrl> dto) {
    return dto.map((e) => ExternalUrls(name: e.name ?? "", url: e.url ?? "")).toList();
  }

  Map<String, dynamic> toMap() {
    return {
      'Name': name,
      'Url': url,
    };
  }

  factory ExternalUrls.fromMap(Map<String, dynamic> map) {
    return ExternalUrls(
      name: map['Name'] ?? '',
      url: map['Url'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ExternalUrls.fromJson(String source) => ExternalUrls.fromMap(json.decode(source));
}

class GenreItems {
  final String id;
  final String name;
  GenreItems({
    required this.id,
    required this.name,
  });

  @override
  String toString() => 'GenreItems(id: $id, name: $name)';
}

class Person {
  final String id;
  final String name;
  final ImageData? image;
  final String role;
  final PersonKind? type;
  Person({
    required this.id,
    this.name = "",
    this.image,
    this.role = "",
    this.type,
  });

  static Person fromBaseDto(dto.BaseItemDto item, Ref ref) {
    return Person(
      id: item.id ?? "",
      name: item.name ?? "",
      image: ImagesData.fromBaseItem(item, ref).primary,
    );
  }

  static Person fromBasePerson(dto.BaseItemPerson person, Ref ref) {
    return Person(
        id: person.id ?? "",
        name: person.name ?? "",
        image: ImagesData.fromPersonDto(person, ref)?.primary,
        role: person.role ?? "",
        type: person.type);
  }

  dto.BaseItemPerson toPerson() {
    return dto.BaseItemPerson(
      id: id,
      name: name,
      type: type,
      role: role,
    );
  }

  static List<Person> peopleFromDto(List<dto.BaseItemPerson>? people, Ref ref) {
    return people
            ?.mapIndexed(
              (index, person) => fromBasePerson(person, ref),
            )
            .toList() ??
        [];
  }

  @override
  String toString() {
    return 'People(id: $id, name: $name, imageUrl: $image, role: $role, type: $type)';
  }
}

class Studio {
  final String id;
  final String name;
  Studio({
    required this.id,
    required this.name,
  });

  Studio copyWith({
    String? id,
    String? name,
    ValueGetter<String?>? image,
  }) {
    return Studio(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  String toString() => 'Studio(name: $name, id: $id)';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory Studio.fromMap(Map<String, dynamic> map) {
    return Studio(
      id: map['id'] ?? map['Id'] ?? '',
      name: map['name'] ?? map['Name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Studio.fromJson(String source) => Studio.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Studio && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

// class UserData {
//   final bool isFavourite;
//   final int playCount;
//   final int? unPlayedItemCount;
//   final int playbackPositionTicks;
//   final double progress;
//   final bool played;
//   UserData({
//     this.isFavourite = false,
//     this.playCount = 0,
//     this.unPlayedItemCount,
//     this.playbackPositionTicks = 0,
//     this.progress = 0,
//     this.played = false,
//   });

//   factory UserData.fromDto(dto.UserItemDataDto? dto) {
//     if (dto == null) {
//       return UserData();
//     }
//     return UserData(
//       isFavourite: dto.isFavorite ?? false,
//       playCount: dto.playCount ?? 0,
//       playbackPositionTicks: dto.playbackPositionTicks ?? 0,
//       played: dto.played ?? false,
//       unPlayedItemCount: dto.unplayedItemCount ?? 0,
//       progress: dto.playedPercentage ?? 0,
//     );
//   }

//   Duration get playBackPosition => Duration(milliseconds: playbackPositionTicks ~/ 10000);

//   @override
//   String toString() {
//     return 'UserData(isFavourite: $isFavourite, playCount: $playCount, unPlayedItemCount: $unPlayedItemCount, playbackPositionTicks: $playbackPositionTicks, progress: $progress, played: $played)';
//   }

//   UserData copyWith({
//     bool? isFavourite,
//     int? playCount,
//     int? unPlayedItemCount,
//     int? playbackPositionTicks,
//     double? progress,
//     bool? played,
//   }) {
//     return UserData(
//       isFavourite: isFavourite ?? this.isFavourite,
//       playCount: playCount ?? this.playCount,
//       unPlayedItemCount: unPlayedItemCount ?? this.unPlayedItemCount,
//       playbackPositionTicks: playbackPositionTicks ?? this.playbackPositionTicks,
//       progress: progress ?? this.progress,
//       played: played ?? this.played,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'isFavourite': isFavourite,
//       'playCount': playCount,
//       'unPlayedItemCount': unPlayedItemCount,
//       'playbackPositionTicks': playbackPositionTicks,
//       'progress': progress,
//       'played': played,
//     };
//   }

//   factory UserData.fromMap(Map<String, dynamic> map) {
//     return UserData(
//       isFavourite: (map['isFavourite'] ?? false) as bool,
//       playCount: (map['playCount'] ?? 0) as int,
//       unPlayedItemCount: (map['unPlayedItemCount'] ?? 0) as int,
//       playbackPositionTicks: (map['playbackPositionTicks'] ?? 0) as int,
//       progress: (map['progress'] ?? 0.0) as double,
//       played: (map['played'] ?? false) as bool,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory UserData.fromJson(String source) => UserData.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   bool operator ==(covariant UserData other) {
//     if (identical(this, other)) return true;

//     return other.isFavourite == isFavourite &&
//         other.playCount == playCount &&
//         other.unPlayedItemCount == unPlayedItemCount &&
//         other.playbackPositionTicks == playbackPositionTicks &&
//         other.progress == progress &&
//         other.played == played;
//   }

//   @override
//   int get hashCode {
//     return isFavourite.hashCode ^
//         playCount.hashCode ^
//         unPlayedItemCount.hashCode ^
//         playbackPositionTicks.hashCode ^
//         progress.hashCode ^
//         played.hashCode;
//   }
// }
