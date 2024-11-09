// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jellyfin_open_api.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccessSchedule _$AccessScheduleFromJson(Map<String, dynamic> json) =>
    AccessSchedule(
      id: (json['Id'] as num?)?.toInt(),
      userId: json['UserId'] as String?,
      dayOfWeek: dynamicDayOfWeekNullableFromJson(json['DayOfWeek']),
      startHour: (json['StartHour'] as num?)?.toDouble(),
      endHour: (json['EndHour'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$AccessScheduleToJson(AccessSchedule instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Id', instance.id);
  writeNotNull('UserId', instance.userId);
  writeNotNull('DayOfWeek', dynamicDayOfWeekNullableToJson(instance.dayOfWeek));
  writeNotNull('StartHour', instance.startHour);
  writeNotNull('EndHour', instance.endHour);
  return val;
}

ActivityLogEntry _$ActivityLogEntryFromJson(Map<String, dynamic> json) =>
    ActivityLogEntry(
      id: (json['Id'] as num?)?.toInt(),
      name: json['Name'] as String?,
      overview: json['Overview'] as String?,
      shortOverview: json['ShortOverview'] as String?,
      type: json['Type'] as String?,
      itemId: json['ItemId'] as String?,
      date:
          json['Date'] == null ? null : DateTime.parse(json['Date'] as String),
      userId: json['UserId'] as String?,
      userPrimaryImageTag: json['UserPrimaryImageTag'] as String?,
      severity: logLevelNullableFromJson(json['Severity']),
    );

Map<String, dynamic> _$ActivityLogEntryToJson(ActivityLogEntry instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Id', instance.id);
  writeNotNull('Name', instance.name);
  writeNotNull('Overview', instance.overview);
  writeNotNull('ShortOverview', instance.shortOverview);
  writeNotNull('Type', instance.type);
  writeNotNull('ItemId', instance.itemId);
  writeNotNull('Date', instance.date?.toIso8601String());
  writeNotNull('UserId', instance.userId);
  writeNotNull('UserPrimaryImageTag', instance.userPrimaryImageTag);
  writeNotNull('Severity', logLevelNullableToJson(instance.severity));
  return val;
}

ActivityLogEntryMessage _$ActivityLogEntryMessageFromJson(
        Map<String, dynamic> json) =>
    ActivityLogEntryMessage(
      data: (json['Data'] as List<dynamic>?)
              ?.map((e) => ActivityLogEntry.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      messageId: json['MessageId'] as String?,
      messageType:
          ActivityLogEntryMessage.sessionMessageTypeMessageTypeNullableFromJson(
              json['MessageType']),
    );

Map<String, dynamic> _$ActivityLogEntryMessageToJson(
    ActivityLogEntryMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Data', instance.data?.map((e) => e.toJson()).toList());
  writeNotNull('MessageId', instance.messageId);
  writeNotNull(
      'MessageType', sessionMessageTypeNullableToJson(instance.messageType));
  return val;
}

ActivityLogEntryQueryResult _$ActivityLogEntryQueryResultFromJson(
        Map<String, dynamic> json) =>
    ActivityLogEntryQueryResult(
      items: (json['Items'] as List<dynamic>?)
              ?.map((e) => ActivityLogEntry.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      totalRecordCount: (json['TotalRecordCount'] as num?)?.toInt(),
      startIndex: (json['StartIndex'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ActivityLogEntryQueryResultToJson(
    ActivityLogEntryQueryResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Items', instance.items?.map((e) => e.toJson()).toList());
  writeNotNull('TotalRecordCount', instance.totalRecordCount);
  writeNotNull('StartIndex', instance.startIndex);
  return val;
}

ActivityLogEntryStartMessage _$ActivityLogEntryStartMessageFromJson(
        Map<String, dynamic> json) =>
    ActivityLogEntryStartMessage(
      data: json['Data'] as String?,
      messageType: ActivityLogEntryStartMessage
          .sessionMessageTypeMessageTypeNullableFromJson(json['MessageType']),
    );

Map<String, dynamic> _$ActivityLogEntryStartMessageToJson(
    ActivityLogEntryStartMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Data', instance.data);
  writeNotNull(
      'MessageType', sessionMessageTypeNullableToJson(instance.messageType));
  return val;
}

ActivityLogEntryStopMessage _$ActivityLogEntryStopMessageFromJson(
        Map<String, dynamic> json) =>
    ActivityLogEntryStopMessage(
      messageType: ActivityLogEntryStopMessage
          .sessionMessageTypeMessageTypeNullableFromJson(json['MessageType']),
    );

Map<String, dynamic> _$ActivityLogEntryStopMessageToJson(
    ActivityLogEntryStopMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'MessageType', sessionMessageTypeNullableToJson(instance.messageType));
  return val;
}

AddVirtualFolderDto _$AddVirtualFolderDtoFromJson(Map<String, dynamic> json) =>
    AddVirtualFolderDto(
      libraryOptions: json['LibraryOptions'] == null
          ? null
          : LibraryOptions.fromJson(
              json['LibraryOptions'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddVirtualFolderDtoToJson(AddVirtualFolderDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('LibraryOptions', instance.libraryOptions?.toJson());
  return val;
}

AlbumInfo _$AlbumInfoFromJson(Map<String, dynamic> json) => AlbumInfo(
      name: json['Name'] as String?,
      originalTitle: json['OriginalTitle'] as String?,
      path: json['Path'] as String?,
      metadataLanguage: json['MetadataLanguage'] as String?,
      metadataCountryCode: json['MetadataCountryCode'] as String?,
      providerIds: json['ProviderIds'] as Map<String, dynamic>?,
      year: (json['Year'] as num?)?.toInt(),
      indexNumber: (json['IndexNumber'] as num?)?.toInt(),
      parentIndexNumber: (json['ParentIndexNumber'] as num?)?.toInt(),
      premiereDate: json['PremiereDate'] == null
          ? null
          : DateTime.parse(json['PremiereDate'] as String),
      isAutomated: json['IsAutomated'] as bool?,
      albumArtists: (json['AlbumArtists'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      artistProviderIds: json['ArtistProviderIds'] as Map<String, dynamic>?,
      songInfos: (json['SongInfos'] as List<dynamic>?)
              ?.map((e) => SongInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$AlbumInfoToJson(AlbumInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Name', instance.name);
  writeNotNull('OriginalTitle', instance.originalTitle);
  writeNotNull('Path', instance.path);
  writeNotNull('MetadataLanguage', instance.metadataLanguage);
  writeNotNull('MetadataCountryCode', instance.metadataCountryCode);
  writeNotNull('ProviderIds', instance.providerIds);
  writeNotNull('Year', instance.year);
  writeNotNull('IndexNumber', instance.indexNumber);
  writeNotNull('ParentIndexNumber', instance.parentIndexNumber);
  writeNotNull('PremiereDate', instance.premiereDate?.toIso8601String());
  writeNotNull('IsAutomated', instance.isAutomated);
  writeNotNull('AlbumArtists', instance.albumArtists);
  writeNotNull('ArtistProviderIds', instance.artistProviderIds);
  writeNotNull(
      'SongInfos', instance.songInfos?.map((e) => e.toJson()).toList());
  return val;
}

AlbumInfoRemoteSearchQuery _$AlbumInfoRemoteSearchQueryFromJson(
        Map<String, dynamic> json) =>
    AlbumInfoRemoteSearchQuery(
      searchInfo: json['SearchInfo'] == null
          ? null
          : AlbumInfo.fromJson(json['SearchInfo'] as Map<String, dynamic>),
      itemId: json['ItemId'] as String?,
      searchProviderName: json['SearchProviderName'] as String?,
      includeDisabledProviders: json['IncludeDisabledProviders'] as bool?,
    );

Map<String, dynamic> _$AlbumInfoRemoteSearchQueryToJson(
    AlbumInfoRemoteSearchQuery instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('SearchInfo', instance.searchInfo?.toJson());
  writeNotNull('ItemId', instance.itemId);
  writeNotNull('SearchProviderName', instance.searchProviderName);
  writeNotNull('IncludeDisabledProviders', instance.includeDisabledProviders);
  return val;
}

AllThemeMediaResult _$AllThemeMediaResultFromJson(Map<String, dynamic> json) =>
    AllThemeMediaResult(
      themeVideosResult: json['ThemeVideosResult'] == null
          ? null
          : ThemeMediaResult.fromJson(
              json['ThemeVideosResult'] as Map<String, dynamic>),
      themeSongsResult: json['ThemeSongsResult'] == null
          ? null
          : ThemeMediaResult.fromJson(
              json['ThemeSongsResult'] as Map<String, dynamic>),
      soundtrackSongsResult: json['SoundtrackSongsResult'] == null
          ? null
          : ThemeMediaResult.fromJson(
              json['SoundtrackSongsResult'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AllThemeMediaResultToJson(AllThemeMediaResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ThemeVideosResult', instance.themeVideosResult?.toJson());
  writeNotNull('ThemeSongsResult', instance.themeSongsResult?.toJson());
  writeNotNull(
      'SoundtrackSongsResult', instance.soundtrackSongsResult?.toJson());
  return val;
}

ArtistInfo _$ArtistInfoFromJson(Map<String, dynamic> json) => ArtistInfo(
      name: json['Name'] as String?,
      originalTitle: json['OriginalTitle'] as String?,
      path: json['Path'] as String?,
      metadataLanguage: json['MetadataLanguage'] as String?,
      metadataCountryCode: json['MetadataCountryCode'] as String?,
      providerIds: json['ProviderIds'] as Map<String, dynamic>?,
      year: (json['Year'] as num?)?.toInt(),
      indexNumber: (json['IndexNumber'] as num?)?.toInt(),
      parentIndexNumber: (json['ParentIndexNumber'] as num?)?.toInt(),
      premiereDate: json['PremiereDate'] == null
          ? null
          : DateTime.parse(json['PremiereDate'] as String),
      isAutomated: json['IsAutomated'] as bool?,
      songInfos: (json['SongInfos'] as List<dynamic>?)
              ?.map((e) => SongInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$ArtistInfoToJson(ArtistInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Name', instance.name);
  writeNotNull('OriginalTitle', instance.originalTitle);
  writeNotNull('Path', instance.path);
  writeNotNull('MetadataLanguage', instance.metadataLanguage);
  writeNotNull('MetadataCountryCode', instance.metadataCountryCode);
  writeNotNull('ProviderIds', instance.providerIds);
  writeNotNull('Year', instance.year);
  writeNotNull('IndexNumber', instance.indexNumber);
  writeNotNull('ParentIndexNumber', instance.parentIndexNumber);
  writeNotNull('PremiereDate', instance.premiereDate?.toIso8601String());
  writeNotNull('IsAutomated', instance.isAutomated);
  writeNotNull(
      'SongInfos', instance.songInfos?.map((e) => e.toJson()).toList());
  return val;
}

ArtistInfoRemoteSearchQuery _$ArtistInfoRemoteSearchQueryFromJson(
        Map<String, dynamic> json) =>
    ArtistInfoRemoteSearchQuery(
      searchInfo: json['SearchInfo'] == null
          ? null
          : ArtistInfo.fromJson(json['SearchInfo'] as Map<String, dynamic>),
      itemId: json['ItemId'] as String?,
      searchProviderName: json['SearchProviderName'] as String?,
      includeDisabledProviders: json['IncludeDisabledProviders'] as bool?,
    );

Map<String, dynamic> _$ArtistInfoRemoteSearchQueryToJson(
    ArtistInfoRemoteSearchQuery instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('SearchInfo', instance.searchInfo?.toJson());
  writeNotNull('ItemId', instance.itemId);
  writeNotNull('SearchProviderName', instance.searchProviderName);
  writeNotNull('IncludeDisabledProviders', instance.includeDisabledProviders);
  return val;
}

AuthenticateUserByName _$AuthenticateUserByNameFromJson(
        Map<String, dynamic> json) =>
    AuthenticateUserByName(
      username: json['Username'] as String?,
      pw: json['Pw'] as String?,
    );

Map<String, dynamic> _$AuthenticateUserByNameToJson(
    AuthenticateUserByName instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Username', instance.username);
  writeNotNull('Pw', instance.pw);
  return val;
}

AuthenticationInfo _$AuthenticationInfoFromJson(Map<String, dynamic> json) =>
    AuthenticationInfo(
      id: (json['Id'] as num?)?.toInt(),
      accessToken: json['AccessToken'] as String?,
      deviceId: json['DeviceId'] as String?,
      appName: json['AppName'] as String?,
      appVersion: json['AppVersion'] as String?,
      deviceName: json['DeviceName'] as String?,
      userId: json['UserId'] as String?,
      isActive: json['IsActive'] as bool?,
      dateCreated: json['DateCreated'] == null
          ? null
          : DateTime.parse(json['DateCreated'] as String),
      dateRevoked: json['DateRevoked'] == null
          ? null
          : DateTime.parse(json['DateRevoked'] as String),
      dateLastActivity: json['DateLastActivity'] == null
          ? null
          : DateTime.parse(json['DateLastActivity'] as String),
      userName: json['UserName'] as String?,
    );

Map<String, dynamic> _$AuthenticationInfoToJson(AuthenticationInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Id', instance.id);
  writeNotNull('AccessToken', instance.accessToken);
  writeNotNull('DeviceId', instance.deviceId);
  writeNotNull('AppName', instance.appName);
  writeNotNull('AppVersion', instance.appVersion);
  writeNotNull('DeviceName', instance.deviceName);
  writeNotNull('UserId', instance.userId);
  writeNotNull('IsActive', instance.isActive);
  writeNotNull('DateCreated', instance.dateCreated?.toIso8601String());
  writeNotNull('DateRevoked', instance.dateRevoked?.toIso8601String());
  writeNotNull(
      'DateLastActivity', instance.dateLastActivity?.toIso8601String());
  writeNotNull('UserName', instance.userName);
  return val;
}

AuthenticationInfoQueryResult _$AuthenticationInfoQueryResultFromJson(
        Map<String, dynamic> json) =>
    AuthenticationInfoQueryResult(
      items: (json['Items'] as List<dynamic>?)
              ?.map(
                  (e) => AuthenticationInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      totalRecordCount: (json['TotalRecordCount'] as num?)?.toInt(),
      startIndex: (json['StartIndex'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AuthenticationInfoQueryResultToJson(
    AuthenticationInfoQueryResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Items', instance.items?.map((e) => e.toJson()).toList());
  writeNotNull('TotalRecordCount', instance.totalRecordCount);
  writeNotNull('StartIndex', instance.startIndex);
  return val;
}

AuthenticationResult _$AuthenticationResultFromJson(
        Map<String, dynamic> json) =>
    AuthenticationResult(
      user: json['User'] == null
          ? null
          : UserDto.fromJson(json['User'] as Map<String, dynamic>),
      sessionInfo: json['SessionInfo'] == null
          ? null
          : SessionInfoDto.fromJson(
              json['SessionInfo'] as Map<String, dynamic>),
      accessToken: json['AccessToken'] as String?,
      serverId: json['ServerId'] as String?,
    );

Map<String, dynamic> _$AuthenticationResultToJson(
    AuthenticationResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('User', instance.user?.toJson());
  writeNotNull('SessionInfo', instance.sessionInfo?.toJson());
  writeNotNull('AccessToken', instance.accessToken);
  writeNotNull('ServerId', instance.serverId);
  return val;
}

BaseItemDto _$BaseItemDtoFromJson(Map<String, dynamic> json) => BaseItemDto(
      name: json['Name'] as String?,
      originalTitle: json['OriginalTitle'] as String?,
      serverId: json['ServerId'] as String?,
      id: json['Id'] as String?,
      etag: json['Etag'] as String?,
      sourceType: json['SourceType'] as String?,
      playlistItemId: json['PlaylistItemId'] as String?,
      dateCreated: json['DateCreated'] == null
          ? null
          : DateTime.parse(json['DateCreated'] as String),
      dateLastMediaAdded: json['DateLastMediaAdded'] == null
          ? null
          : DateTime.parse(json['DateLastMediaAdded'] as String),
      extraType: extraTypeNullableFromJson(json['ExtraType']),
      airsBeforeSeasonNumber: (json['AirsBeforeSeasonNumber'] as num?)?.toInt(),
      airsAfterSeasonNumber: (json['AirsAfterSeasonNumber'] as num?)?.toInt(),
      airsBeforeEpisodeNumber:
          (json['AirsBeforeEpisodeNumber'] as num?)?.toInt(),
      canDelete: json['CanDelete'] as bool?,
      canDownload: json['CanDownload'] as bool?,
      hasLyrics: json['HasLyrics'] as bool?,
      hasSubtitles: json['HasSubtitles'] as bool?,
      preferredMetadataLanguage: json['PreferredMetadataLanguage'] as String?,
      preferredMetadataCountryCode:
          json['PreferredMetadataCountryCode'] as String?,
      container: json['Container'] as String?,
      sortName: json['SortName'] as String?,
      forcedSortName: json['ForcedSortName'] as String?,
      video3DFormat: video3DFormatNullableFromJson(json['Video3DFormat']),
      premiereDate: json['PremiereDate'] == null
          ? null
          : DateTime.parse(json['PremiereDate'] as String),
      externalUrls: (json['ExternalUrls'] as List<dynamic>?)
              ?.map((e) => ExternalUrl.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      mediaSources: (json['MediaSources'] as List<dynamic>?)
              ?.map((e) => MediaSourceInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      criticRating: (json['CriticRating'] as num?)?.toDouble(),
      productionLocations: (json['ProductionLocations'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      path: json['Path'] as String?,
      enableMediaSourceDisplay: json['EnableMediaSourceDisplay'] as bool?,
      officialRating: json['OfficialRating'] as String?,
      customRating: json['CustomRating'] as String?,
      channelId: json['ChannelId'] as String?,
      channelName: json['ChannelName'] as String?,
      overview: json['Overview'] as String?,
      taglines: (json['Taglines'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      genres: (json['Genres'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      communityRating: (json['CommunityRating'] as num?)?.toDouble(),
      cumulativeRunTimeTicks: (json['CumulativeRunTimeTicks'] as num?)?.toInt(),
      runTimeTicks: (json['RunTimeTicks'] as num?)?.toInt(),
      playAccess: playAccessNullableFromJson(json['PlayAccess']),
      aspectRatio: json['AspectRatio'] as String?,
      productionYear: (json['ProductionYear'] as num?)?.toInt(),
      isPlaceHolder: json['IsPlaceHolder'] as bool?,
      number: json['Number'] as String?,
      channelNumber: json['ChannelNumber'] as String?,
      indexNumber: (json['IndexNumber'] as num?)?.toInt(),
      indexNumberEnd: (json['IndexNumberEnd'] as num?)?.toInt(),
      parentIndexNumber: (json['ParentIndexNumber'] as num?)?.toInt(),
      remoteTrailers: (json['RemoteTrailers'] as List<dynamic>?)
              ?.map((e) => MediaUrl.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      providerIds: json['ProviderIds'] as Map<String, dynamic>?,
      isHD: json['IsHD'] as bool?,
      isFolder: json['IsFolder'] as bool?,
      parentId: json['ParentId'] as String?,
      type: baseItemKindNullableFromJson(json['Type']),
      people: (json['People'] as List<dynamic>?)
              ?.map((e) => BaseItemPerson.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      studios: (json['Studios'] as List<dynamic>?)
              ?.map((e) => NameGuidPair.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      genreItems: (json['GenreItems'] as List<dynamic>?)
              ?.map((e) => NameGuidPair.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      parentLogoItemId: json['ParentLogoItemId'] as String?,
      parentBackdropItemId: json['ParentBackdropItemId'] as String?,
      parentBackdropImageTags:
          (json['ParentBackdropImageTags'] as List<dynamic>?)
                  ?.map((e) => e as String)
                  .toList() ??
              [],
      localTrailerCount: (json['LocalTrailerCount'] as num?)?.toInt(),
      userData: json['UserData'] == null
          ? null
          : UserItemDataDto.fromJson(json['UserData'] as Map<String, dynamic>),
      recursiveItemCount: (json['RecursiveItemCount'] as num?)?.toInt(),
      childCount: (json['ChildCount'] as num?)?.toInt(),
      seriesName: json['SeriesName'] as String?,
      seriesId: json['SeriesId'] as String?,
      seasonId: json['SeasonId'] as String?,
      specialFeatureCount: (json['SpecialFeatureCount'] as num?)?.toInt(),
      displayPreferencesId: json['DisplayPreferencesId'] as String?,
      status: json['Status'] as String?,
      airTime: json['AirTime'] as String?,
      airDays: dayOfWeekListFromJson(json['AirDays'] as List?),
      tags:
          (json['Tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      primaryImageAspectRatio:
          (json['PrimaryImageAspectRatio'] as num?)?.toDouble(),
      artists: (json['Artists'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      artistItems: (json['ArtistItems'] as List<dynamic>?)
              ?.map((e) => NameGuidPair.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      album: json['Album'] as String?,
      collectionType: collectionTypeNullableFromJson(json['CollectionType']),
      displayOrder: json['DisplayOrder'] as String?,
      albumId: json['AlbumId'] as String?,
      albumPrimaryImageTag: json['AlbumPrimaryImageTag'] as String?,
      seriesPrimaryImageTag: json['SeriesPrimaryImageTag'] as String?,
      albumArtist: json['AlbumArtist'] as String?,
      albumArtists: (json['AlbumArtists'] as List<dynamic>?)
              ?.map((e) => NameGuidPair.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      seasonName: json['SeasonName'] as String?,
      mediaStreams: (json['MediaStreams'] as List<dynamic>?)
              ?.map((e) => MediaStream.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      videoType: videoTypeNullableFromJson(json['VideoType']),
      partCount: (json['PartCount'] as num?)?.toInt(),
      mediaSourceCount: (json['MediaSourceCount'] as num?)?.toInt(),
      imageTags: json['ImageTags'] as Map<String, dynamic>?,
      backdropImageTags: (json['BackdropImageTags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      screenshotImageTags: (json['ScreenshotImageTags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      parentLogoImageTag: json['ParentLogoImageTag'] as String?,
      parentArtItemId: json['ParentArtItemId'] as String?,
      parentArtImageTag: json['ParentArtImageTag'] as String?,
      seriesThumbImageTag: json['SeriesThumbImageTag'] as String?,
      imageBlurHashes: json['ImageBlurHashes'] == null
          ? null
          : BaseItemDto$ImageBlurHashes.fromJson(
              json['ImageBlurHashes'] as Map<String, dynamic>),
      seriesStudio: json['SeriesStudio'] as String?,
      parentThumbItemId: json['ParentThumbItemId'] as String?,
      parentThumbImageTag: json['ParentThumbImageTag'] as String?,
      parentPrimaryImageItemId: json['ParentPrimaryImageItemId'] as String?,
      parentPrimaryImageTag: json['ParentPrimaryImageTag'] as String?,
      chapters: (json['Chapters'] as List<dynamic>?)
              ?.map((e) => ChapterInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      trickplay: json['Trickplay'] as Map<String, dynamic>?,
      locationType: locationTypeNullableFromJson(json['LocationType']),
      isoType: isoTypeNullableFromJson(json['IsoType']),
      mediaType: mediaTypeNullableFromJson(json['MediaType']),
      endDate: json['EndDate'] == null
          ? null
          : DateTime.parse(json['EndDate'] as String),
      lockedFields: metadataFieldListFromJson(json['LockedFields'] as List?),
      trailerCount: (json['TrailerCount'] as num?)?.toInt(),
      movieCount: (json['MovieCount'] as num?)?.toInt(),
      seriesCount: (json['SeriesCount'] as num?)?.toInt(),
      programCount: (json['ProgramCount'] as num?)?.toInt(),
      episodeCount: (json['EpisodeCount'] as num?)?.toInt(),
      songCount: (json['SongCount'] as num?)?.toInt(),
      albumCount: (json['AlbumCount'] as num?)?.toInt(),
      artistCount: (json['ArtistCount'] as num?)?.toInt(),
      musicVideoCount: (json['MusicVideoCount'] as num?)?.toInt(),
      lockData: json['LockData'] as bool?,
      width: (json['Width'] as num?)?.toInt(),
      height: (json['Height'] as num?)?.toInt(),
      cameraMake: json['CameraMake'] as String?,
      cameraModel: json['CameraModel'] as String?,
      software: json['Software'] as String?,
      exposureTime: (json['ExposureTime'] as num?)?.toDouble(),
      focalLength: (json['FocalLength'] as num?)?.toDouble(),
      imageOrientation:
          imageOrientationNullableFromJson(json['ImageOrientation']),
      aperture: (json['Aperture'] as num?)?.toDouble(),
      shutterSpeed: (json['ShutterSpeed'] as num?)?.toDouble(),
      latitude: (json['Latitude'] as num?)?.toDouble(),
      longitude: (json['Longitude'] as num?)?.toDouble(),
      altitude: (json['Altitude'] as num?)?.toDouble(),
      isoSpeedRating: (json['IsoSpeedRating'] as num?)?.toInt(),
      seriesTimerId: json['SeriesTimerId'] as String?,
      programId: json['ProgramId'] as String?,
      channelPrimaryImageTag: json['ChannelPrimaryImageTag'] as String?,
      startDate: json['StartDate'] == null
          ? null
          : DateTime.parse(json['StartDate'] as String),
      completionPercentage: (json['CompletionPercentage'] as num?)?.toDouble(),
      isRepeat: json['IsRepeat'] as bool?,
      episodeTitle: json['EpisodeTitle'] as String?,
      channelType: channelTypeNullableFromJson(json['ChannelType']),
      audio: programAudioNullableFromJson(json['Audio']),
      isMovie: json['IsMovie'] as bool?,
      isSports: json['IsSports'] as bool?,
      isSeries: json['IsSeries'] as bool?,
      isLive: json['IsLive'] as bool?,
      isNews: json['IsNews'] as bool?,
      isKids: json['IsKids'] as bool?,
      isPremiere: json['IsPremiere'] as bool?,
      timerId: json['TimerId'] as String?,
      normalizationGain: (json['NormalizationGain'] as num?)?.toDouble(),
      currentProgram: json['CurrentProgram'] == null
          ? null
          : BaseItemDto.fromJson(
              json['CurrentProgram'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BaseItemDtoToJson(BaseItemDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Name', instance.name);
  writeNotNull('OriginalTitle', instance.originalTitle);
  writeNotNull('ServerId', instance.serverId);
  writeNotNull('Id', instance.id);
  writeNotNull('Etag', instance.etag);
  writeNotNull('SourceType', instance.sourceType);
  writeNotNull('PlaylistItemId', instance.playlistItemId);
  writeNotNull('DateCreated', instance.dateCreated?.toIso8601String());
  writeNotNull(
      'DateLastMediaAdded', instance.dateLastMediaAdded?.toIso8601String());
  writeNotNull('ExtraType', extraTypeNullableToJson(instance.extraType));
  writeNotNull('AirsBeforeSeasonNumber', instance.airsBeforeSeasonNumber);
  writeNotNull('AirsAfterSeasonNumber', instance.airsAfterSeasonNumber);
  writeNotNull('AirsBeforeEpisodeNumber', instance.airsBeforeEpisodeNumber);
  writeNotNull('CanDelete', instance.canDelete);
  writeNotNull('CanDownload', instance.canDownload);
  writeNotNull('HasLyrics', instance.hasLyrics);
  writeNotNull('HasSubtitles', instance.hasSubtitles);
  writeNotNull('PreferredMetadataLanguage', instance.preferredMetadataLanguage);
  writeNotNull(
      'PreferredMetadataCountryCode', instance.preferredMetadataCountryCode);
  writeNotNull('Container', instance.container);
  writeNotNull('SortName', instance.sortName);
  writeNotNull('ForcedSortName', instance.forcedSortName);
  writeNotNull(
      'Video3DFormat', video3DFormatNullableToJson(instance.video3DFormat));
  writeNotNull('PremiereDate', instance.premiereDate?.toIso8601String());
  writeNotNull(
      'ExternalUrls', instance.externalUrls?.map((e) => e.toJson()).toList());
  writeNotNull(
      'MediaSources', instance.mediaSources?.map((e) => e.toJson()).toList());
  writeNotNull('CriticRating', instance.criticRating);
  writeNotNull('ProductionLocations', instance.productionLocations);
  writeNotNull('Path', instance.path);
  writeNotNull('EnableMediaSourceDisplay', instance.enableMediaSourceDisplay);
  writeNotNull('OfficialRating', instance.officialRating);
  writeNotNull('CustomRating', instance.customRating);
  writeNotNull('ChannelId', instance.channelId);
  writeNotNull('ChannelName', instance.channelName);
  writeNotNull('Overview', instance.overview);
  writeNotNull('Taglines', instance.taglines);
  writeNotNull('Genres', instance.genres);
  writeNotNull('CommunityRating', instance.communityRating);
  writeNotNull('CumulativeRunTimeTicks', instance.cumulativeRunTimeTicks);
  writeNotNull('RunTimeTicks', instance.runTimeTicks);
  writeNotNull('PlayAccess', playAccessNullableToJson(instance.playAccess));
  writeNotNull('AspectRatio', instance.aspectRatio);
  writeNotNull('ProductionYear', instance.productionYear);
  writeNotNull('IsPlaceHolder', instance.isPlaceHolder);
  writeNotNull('Number', instance.number);
  writeNotNull('ChannelNumber', instance.channelNumber);
  writeNotNull('IndexNumber', instance.indexNumber);
  writeNotNull('IndexNumberEnd', instance.indexNumberEnd);
  writeNotNull('ParentIndexNumber', instance.parentIndexNumber);
  writeNotNull('RemoteTrailers',
      instance.remoteTrailers?.map((e) => e.toJson()).toList());
  writeNotNull('ProviderIds', instance.providerIds);
  writeNotNull('IsHD', instance.isHD);
  writeNotNull('IsFolder', instance.isFolder);
  writeNotNull('ParentId', instance.parentId);
  writeNotNull('Type', baseItemKindNullableToJson(instance.type));
  writeNotNull('People', instance.people?.map((e) => e.toJson()).toList());
  writeNotNull('Studios', instance.studios?.map((e) => e.toJson()).toList());
  writeNotNull(
      'GenreItems', instance.genreItems?.map((e) => e.toJson()).toList());
  writeNotNull('ParentLogoItemId', instance.parentLogoItemId);
  writeNotNull('ParentBackdropItemId', instance.parentBackdropItemId);
  writeNotNull('ParentBackdropImageTags', instance.parentBackdropImageTags);
  writeNotNull('LocalTrailerCount', instance.localTrailerCount);
  writeNotNull('UserData', instance.userData?.toJson());
  writeNotNull('RecursiveItemCount', instance.recursiveItemCount);
  writeNotNull('ChildCount', instance.childCount);
  writeNotNull('SeriesName', instance.seriesName);
  writeNotNull('SeriesId', instance.seriesId);
  writeNotNull('SeasonId', instance.seasonId);
  writeNotNull('SpecialFeatureCount', instance.specialFeatureCount);
  writeNotNull('DisplayPreferencesId', instance.displayPreferencesId);
  writeNotNull('Status', instance.status);
  writeNotNull('AirTime', instance.airTime);
  val['AirDays'] = dayOfWeekListToJson(instance.airDays);
  writeNotNull('Tags', instance.tags);
  writeNotNull('PrimaryImageAspectRatio', instance.primaryImageAspectRatio);
  writeNotNull('Artists', instance.artists);
  writeNotNull(
      'ArtistItems', instance.artistItems?.map((e) => e.toJson()).toList());
  writeNotNull('Album', instance.album);
  writeNotNull(
      'CollectionType', collectionTypeNullableToJson(instance.collectionType));
  writeNotNull('DisplayOrder', instance.displayOrder);
  writeNotNull('AlbumId', instance.albumId);
  writeNotNull('AlbumPrimaryImageTag', instance.albumPrimaryImageTag);
  writeNotNull('SeriesPrimaryImageTag', instance.seriesPrimaryImageTag);
  writeNotNull('AlbumArtist', instance.albumArtist);
  writeNotNull(
      'AlbumArtists', instance.albumArtists?.map((e) => e.toJson()).toList());
  writeNotNull('SeasonName', instance.seasonName);
  writeNotNull(
      'MediaStreams', instance.mediaStreams?.map((e) => e.toJson()).toList());
  writeNotNull('VideoType', videoTypeNullableToJson(instance.videoType));
  writeNotNull('PartCount', instance.partCount);
  writeNotNull('MediaSourceCount', instance.mediaSourceCount);
  writeNotNull('ImageTags', instance.imageTags);
  writeNotNull('BackdropImageTags', instance.backdropImageTags);
  writeNotNull('ScreenshotImageTags', instance.screenshotImageTags);
  writeNotNull('ParentLogoImageTag', instance.parentLogoImageTag);
  writeNotNull('ParentArtItemId', instance.parentArtItemId);
  writeNotNull('ParentArtImageTag', instance.parentArtImageTag);
  writeNotNull('SeriesThumbImageTag', instance.seriesThumbImageTag);
  writeNotNull('ImageBlurHashes', instance.imageBlurHashes?.toJson());
  writeNotNull('SeriesStudio', instance.seriesStudio);
  writeNotNull('ParentThumbItemId', instance.parentThumbItemId);
  writeNotNull('ParentThumbImageTag', instance.parentThumbImageTag);
  writeNotNull('ParentPrimaryImageItemId', instance.parentPrimaryImageItemId);
  writeNotNull('ParentPrimaryImageTag', instance.parentPrimaryImageTag);
  writeNotNull('Chapters', instance.chapters?.map((e) => e.toJson()).toList());
  writeNotNull('Trickplay', instance.trickplay);
  writeNotNull(
      'LocationType', locationTypeNullableToJson(instance.locationType));
  writeNotNull('IsoType', isoTypeNullableToJson(instance.isoType));
  writeNotNull('MediaType', mediaTypeNullableToJson(instance.mediaType));
  writeNotNull('EndDate', instance.endDate?.toIso8601String());
  val['LockedFields'] = metadataFieldListToJson(instance.lockedFields);
  writeNotNull('TrailerCount', instance.trailerCount);
  writeNotNull('MovieCount', instance.movieCount);
  writeNotNull('SeriesCount', instance.seriesCount);
  writeNotNull('ProgramCount', instance.programCount);
  writeNotNull('EpisodeCount', instance.episodeCount);
  writeNotNull('SongCount', instance.songCount);
  writeNotNull('AlbumCount', instance.albumCount);
  writeNotNull('ArtistCount', instance.artistCount);
  writeNotNull('MusicVideoCount', instance.musicVideoCount);
  writeNotNull('LockData', instance.lockData);
  writeNotNull('Width', instance.width);
  writeNotNull('Height', instance.height);
  writeNotNull('CameraMake', instance.cameraMake);
  writeNotNull('CameraModel', instance.cameraModel);
  writeNotNull('Software', instance.software);
  writeNotNull('ExposureTime', instance.exposureTime);
  writeNotNull('FocalLength', instance.focalLength);
  writeNotNull('ImageOrientation',
      imageOrientationNullableToJson(instance.imageOrientation));
  writeNotNull('Aperture', instance.aperture);
  writeNotNull('ShutterSpeed', instance.shutterSpeed);
  writeNotNull('Latitude', instance.latitude);
  writeNotNull('Longitude', instance.longitude);
  writeNotNull('Altitude', instance.altitude);
  writeNotNull('IsoSpeedRating', instance.isoSpeedRating);
  writeNotNull('SeriesTimerId', instance.seriesTimerId);
  writeNotNull('ProgramId', instance.programId);
  writeNotNull('ChannelPrimaryImageTag', instance.channelPrimaryImageTag);
  writeNotNull('StartDate', instance.startDate?.toIso8601String());
  writeNotNull('CompletionPercentage', instance.completionPercentage);
  writeNotNull('IsRepeat', instance.isRepeat);
  writeNotNull('EpisodeTitle', instance.episodeTitle);
  writeNotNull('ChannelType', channelTypeNullableToJson(instance.channelType));
  writeNotNull('Audio', programAudioNullableToJson(instance.audio));
  writeNotNull('IsMovie', instance.isMovie);
  writeNotNull('IsSports', instance.isSports);
  writeNotNull('IsSeries', instance.isSeries);
  writeNotNull('IsLive', instance.isLive);
  writeNotNull('IsNews', instance.isNews);
  writeNotNull('IsKids', instance.isKids);
  writeNotNull('IsPremiere', instance.isPremiere);
  writeNotNull('TimerId', instance.timerId);
  writeNotNull('NormalizationGain', instance.normalizationGain);
  writeNotNull('CurrentProgram', instance.currentProgram?.toJson());
  return val;
}

BaseItemDtoQueryResult _$BaseItemDtoQueryResultFromJson(
        Map<String, dynamic> json) =>
    BaseItemDtoQueryResult(
      items: (json['Items'] as List<dynamic>?)
              ?.map((e) => BaseItemDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      totalRecordCount: (json['TotalRecordCount'] as num?)?.toInt(),
      startIndex: (json['StartIndex'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BaseItemDtoQueryResultToJson(
    BaseItemDtoQueryResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Items', instance.items?.map((e) => e.toJson()).toList());
  writeNotNull('TotalRecordCount', instance.totalRecordCount);
  writeNotNull('StartIndex', instance.startIndex);
  return val;
}

BaseItemPerson _$BaseItemPersonFromJson(Map<String, dynamic> json) =>
    BaseItemPerson(
      name: json['Name'] as String?,
      id: json['Id'] as String?,
      role: json['Role'] as String?,
      type: personKindNullableFromJson(json['Type']),
      primaryImageTag: json['PrimaryImageTag'] as String?,
      imageBlurHashes: json['ImageBlurHashes'] == null
          ? null
          : BaseItemPerson$ImageBlurHashes.fromJson(
              json['ImageBlurHashes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BaseItemPersonToJson(BaseItemPerson instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Name', instance.name);
  writeNotNull('Id', instance.id);
  writeNotNull('Role', instance.role);
  writeNotNull('Type', personKindNullableToJson(instance.type));
  writeNotNull('PrimaryImageTag', instance.primaryImageTag);
  writeNotNull('ImageBlurHashes', instance.imageBlurHashes?.toJson());
  return val;
}

BasePluginConfiguration _$BasePluginConfigurationFromJson(
        Map<String, dynamic> json) =>
    BasePluginConfiguration();

Map<String, dynamic> _$BasePluginConfigurationToJson(
        BasePluginConfiguration instance) =>
    <String, dynamic>{};

BookInfo _$BookInfoFromJson(Map<String, dynamic> json) => BookInfo(
      name: json['Name'] as String?,
      originalTitle: json['OriginalTitle'] as String?,
      path: json['Path'] as String?,
      metadataLanguage: json['MetadataLanguage'] as String?,
      metadataCountryCode: json['MetadataCountryCode'] as String?,
      providerIds: json['ProviderIds'] as Map<String, dynamic>?,
      year: (json['Year'] as num?)?.toInt(),
      indexNumber: (json['IndexNumber'] as num?)?.toInt(),
      parentIndexNumber: (json['ParentIndexNumber'] as num?)?.toInt(),
      premiereDate: json['PremiereDate'] == null
          ? null
          : DateTime.parse(json['PremiereDate'] as String),
      isAutomated: json['IsAutomated'] as bool?,
      seriesName: json['SeriesName'] as String?,
    );

Map<String, dynamic> _$BookInfoToJson(BookInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Name', instance.name);
  writeNotNull('OriginalTitle', instance.originalTitle);
  writeNotNull('Path', instance.path);
  writeNotNull('MetadataLanguage', instance.metadataLanguage);
  writeNotNull('MetadataCountryCode', instance.metadataCountryCode);
  writeNotNull('ProviderIds', instance.providerIds);
  writeNotNull('Year', instance.year);
  writeNotNull('IndexNumber', instance.indexNumber);
  writeNotNull('ParentIndexNumber', instance.parentIndexNumber);
  writeNotNull('PremiereDate', instance.premiereDate?.toIso8601String());
  writeNotNull('IsAutomated', instance.isAutomated);
  writeNotNull('SeriesName', instance.seriesName);
  return val;
}

BookInfoRemoteSearchQuery _$BookInfoRemoteSearchQueryFromJson(
        Map<String, dynamic> json) =>
    BookInfoRemoteSearchQuery(
      searchInfo: json['SearchInfo'] == null
          ? null
          : BookInfo.fromJson(json['SearchInfo'] as Map<String, dynamic>),
      itemId: json['ItemId'] as String?,
      searchProviderName: json['SearchProviderName'] as String?,
      includeDisabledProviders: json['IncludeDisabledProviders'] as bool?,
    );

Map<String, dynamic> _$BookInfoRemoteSearchQueryToJson(
    BookInfoRemoteSearchQuery instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('SearchInfo', instance.searchInfo?.toJson());
  writeNotNull('ItemId', instance.itemId);
  writeNotNull('SearchProviderName', instance.searchProviderName);
  writeNotNull('IncludeDisabledProviders', instance.includeDisabledProviders);
  return val;
}

BoxSetInfo _$BoxSetInfoFromJson(Map<String, dynamic> json) => BoxSetInfo(
      name: json['Name'] as String?,
      originalTitle: json['OriginalTitle'] as String?,
      path: json['Path'] as String?,
      metadataLanguage: json['MetadataLanguage'] as String?,
      metadataCountryCode: json['MetadataCountryCode'] as String?,
      providerIds: json['ProviderIds'] as Map<String, dynamic>?,
      year: (json['Year'] as num?)?.toInt(),
      indexNumber: (json['IndexNumber'] as num?)?.toInt(),
      parentIndexNumber: (json['ParentIndexNumber'] as num?)?.toInt(),
      premiereDate: json['PremiereDate'] == null
          ? null
          : DateTime.parse(json['PremiereDate'] as String),
      isAutomated: json['IsAutomated'] as bool?,
    );

Map<String, dynamic> _$BoxSetInfoToJson(BoxSetInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Name', instance.name);
  writeNotNull('OriginalTitle', instance.originalTitle);
  writeNotNull('Path', instance.path);
  writeNotNull('MetadataLanguage', instance.metadataLanguage);
  writeNotNull('MetadataCountryCode', instance.metadataCountryCode);
  writeNotNull('ProviderIds', instance.providerIds);
  writeNotNull('Year', instance.year);
  writeNotNull('IndexNumber', instance.indexNumber);
  writeNotNull('ParentIndexNumber', instance.parentIndexNumber);
  writeNotNull('PremiereDate', instance.premiereDate?.toIso8601String());
  writeNotNull('IsAutomated', instance.isAutomated);
  return val;
}

BoxSetInfoRemoteSearchQuery _$BoxSetInfoRemoteSearchQueryFromJson(
        Map<String, dynamic> json) =>
    BoxSetInfoRemoteSearchQuery(
      searchInfo: json['SearchInfo'] == null
          ? null
          : BoxSetInfo.fromJson(json['SearchInfo'] as Map<String, dynamic>),
      itemId: json['ItemId'] as String?,
      searchProviderName: json['SearchProviderName'] as String?,
      includeDisabledProviders: json['IncludeDisabledProviders'] as bool?,
    );

Map<String, dynamic> _$BoxSetInfoRemoteSearchQueryToJson(
    BoxSetInfoRemoteSearchQuery instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('SearchInfo', instance.searchInfo?.toJson());
  writeNotNull('ItemId', instance.itemId);
  writeNotNull('SearchProviderName', instance.searchProviderName);
  writeNotNull('IncludeDisabledProviders', instance.includeDisabledProviders);
  return val;
}

BrandingOptions _$BrandingOptionsFromJson(Map<String, dynamic> json) =>
    BrandingOptions(
      loginDisclaimer: json['LoginDisclaimer'] as String?,
      customCss: json['CustomCss'] as String?,
      splashscreenEnabled: json['SplashscreenEnabled'] as bool?,
    );

Map<String, dynamic> _$BrandingOptionsToJson(BrandingOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('LoginDisclaimer', instance.loginDisclaimer);
  writeNotNull('CustomCss', instance.customCss);
  writeNotNull('SplashscreenEnabled', instance.splashscreenEnabled);
  return val;
}

BufferRequestDto _$BufferRequestDtoFromJson(Map<String, dynamic> json) =>
    BufferRequestDto(
      when:
          json['When'] == null ? null : DateTime.parse(json['When'] as String),
      positionTicks: (json['PositionTicks'] as num?)?.toInt(),
      isPlaying: json['IsPlaying'] as bool?,
      playlistItemId: json['PlaylistItemId'] as String?,
    );

Map<String, dynamic> _$BufferRequestDtoToJson(BufferRequestDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('When', instance.when?.toIso8601String());
  writeNotNull('PositionTicks', instance.positionTicks);
  writeNotNull('IsPlaying', instance.isPlaying);
  writeNotNull('PlaylistItemId', instance.playlistItemId);
  return val;
}

CastReceiverApplication _$CastReceiverApplicationFromJson(
        Map<String, dynamic> json) =>
    CastReceiverApplication(
      id: json['Id'] as String?,
      name: json['Name'] as String?,
    );

Map<String, dynamic> _$CastReceiverApplicationToJson(
    CastReceiverApplication instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Id', instance.id);
  writeNotNull('Name', instance.name);
  return val;
}

ChannelFeatures _$ChannelFeaturesFromJson(Map<String, dynamic> json) =>
    ChannelFeatures(
      name: json['Name'] as String?,
      id: json['Id'] as String?,
      canSearch: json['CanSearch'] as bool?,
      mediaTypes: channelMediaTypeListFromJson(json['MediaTypes'] as List?),
      contentTypes:
          channelMediaContentTypeListFromJson(json['ContentTypes'] as List?),
      maxPageSize: (json['MaxPageSize'] as num?)?.toInt(),
      autoRefreshLevels: (json['AutoRefreshLevels'] as num?)?.toInt(),
      defaultSortFields:
          channelItemSortFieldListFromJson(json['DefaultSortFields'] as List?),
      supportsSortOrderToggle: json['SupportsSortOrderToggle'] as bool?,
      supportsLatestMedia: json['SupportsLatestMedia'] as bool?,
      canFilter: json['CanFilter'] as bool?,
      supportsContentDownloading: json['SupportsContentDownloading'] as bool?,
    );

Map<String, dynamic> _$ChannelFeaturesToJson(ChannelFeatures instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Name', instance.name);
  writeNotNull('Id', instance.id);
  writeNotNull('CanSearch', instance.canSearch);
  val['MediaTypes'] = channelMediaTypeListToJson(instance.mediaTypes);
  val['ContentTypes'] =
      channelMediaContentTypeListToJson(instance.contentTypes);
  writeNotNull('MaxPageSize', instance.maxPageSize);
  writeNotNull('AutoRefreshLevels', instance.autoRefreshLevels);
  val['DefaultSortFields'] =
      channelItemSortFieldListToJson(instance.defaultSortFields);
  writeNotNull('SupportsSortOrderToggle', instance.supportsSortOrderToggle);
  writeNotNull('SupportsLatestMedia', instance.supportsLatestMedia);
  writeNotNull('CanFilter', instance.canFilter);
  writeNotNull(
      'SupportsContentDownloading', instance.supportsContentDownloading);
  return val;
}

ChannelMappingOptionsDto _$ChannelMappingOptionsDtoFromJson(
        Map<String, dynamic> json) =>
    ChannelMappingOptionsDto(
      tunerChannels: (json['TunerChannels'] as List<dynamic>?)
              ?.map((e) =>
                  TunerChannelMapping.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      providerChannels: (json['ProviderChannels'] as List<dynamic>?)
              ?.map((e) => NameIdPair.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      mappings: (json['Mappings'] as List<dynamic>?)
              ?.map((e) => NameValuePair.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      providerName: json['ProviderName'] as String?,
    );

Map<String, dynamic> _$ChannelMappingOptionsDtoToJson(
    ChannelMappingOptionsDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'TunerChannels', instance.tunerChannels?.map((e) => e.toJson()).toList());
  writeNotNull('ProviderChannels',
      instance.providerChannels?.map((e) => e.toJson()).toList());
  writeNotNull('Mappings', instance.mappings?.map((e) => e.toJson()).toList());
  writeNotNull('ProviderName', instance.providerName);
  return val;
}

ChapterInfo _$ChapterInfoFromJson(Map<String, dynamic> json) => ChapterInfo(
      startPositionTicks: (json['StartPositionTicks'] as num?)?.toInt(),
      name: json['Name'] as String?,
      imagePath: json['ImagePath'] as String?,
      imageDateModified: json['ImageDateModified'] == null
          ? null
          : DateTime.parse(json['ImageDateModified'] as String),
      imageTag: json['ImageTag'] as String?,
    );

Map<String, dynamic> _$ChapterInfoToJson(ChapterInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('StartPositionTicks', instance.startPositionTicks);
  writeNotNull('Name', instance.name);
  writeNotNull('ImagePath', instance.imagePath);
  writeNotNull(
      'ImageDateModified', instance.imageDateModified?.toIso8601String());
  writeNotNull('ImageTag', instance.imageTag);
  return val;
}

ClientCapabilitiesDto _$ClientCapabilitiesDtoFromJson(
        Map<String, dynamic> json) =>
    ClientCapabilitiesDto(
      playableMediaTypes:
          mediaTypeListFromJson(json['PlayableMediaTypes'] as List?),
      supportedCommands:
          generalCommandTypeListFromJson(json['SupportedCommands'] as List?),
      supportsMediaControl: json['SupportsMediaControl'] as bool?,
      supportsPersistentIdentifier:
          json['SupportsPersistentIdentifier'] as bool?,
      deviceProfile: json['DeviceProfile'] == null
          ? null
          : DeviceProfile.fromJson(
              json['DeviceProfile'] as Map<String, dynamic>),
      appStoreUrl: json['AppStoreUrl'] as String?,
      iconUrl: json['IconUrl'] as String?,
    );

Map<String, dynamic> _$ClientCapabilitiesDtoToJson(
    ClientCapabilitiesDto instance) {
  final val = <String, dynamic>{
    'PlayableMediaTypes': mediaTypeListToJson(instance.playableMediaTypes),
    'SupportedCommands':
        generalCommandTypeListToJson(instance.supportedCommands),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('SupportsMediaControl', instance.supportsMediaControl);
  writeNotNull(
      'SupportsPersistentIdentifier', instance.supportsPersistentIdentifier);
  writeNotNull('DeviceProfile', instance.deviceProfile?.toJson());
  writeNotNull('AppStoreUrl', instance.appStoreUrl);
  writeNotNull('IconUrl', instance.iconUrl);
  return val;
}

ClientLogDocumentResponseDto _$ClientLogDocumentResponseDtoFromJson(
        Map<String, dynamic> json) =>
    ClientLogDocumentResponseDto(
      fileName: json['FileName'] as String?,
    );

Map<String, dynamic> _$ClientLogDocumentResponseDtoToJson(
    ClientLogDocumentResponseDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('FileName', instance.fileName);
  return val;
}

CodecProfile _$CodecProfileFromJson(Map<String, dynamic> json) => CodecProfile(
      type: codecTypeNullableFromJson(json['Type']),
      conditions: (json['Conditions'] as List<dynamic>?)
              ?.map((e) => ProfileCondition.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      applyConditions: (json['ApplyConditions'] as List<dynamic>?)
              ?.map((e) => ProfileCondition.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      codec: json['Codec'] as String?,
      container: json['Container'] as String?,
      subContainer: json['SubContainer'] as String?,
    );

Map<String, dynamic> _$CodecProfileToJson(CodecProfile instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Type', codecTypeNullableToJson(instance.type));
  writeNotNull(
      'Conditions', instance.conditions?.map((e) => e.toJson()).toList());
  writeNotNull('ApplyConditions',
      instance.applyConditions?.map((e) => e.toJson()).toList());
  writeNotNull('Codec', instance.codec);
  writeNotNull('Container', instance.container);
  writeNotNull('SubContainer', instance.subContainer);
  return val;
}

CollectionCreationResult _$CollectionCreationResultFromJson(
        Map<String, dynamic> json) =>
    CollectionCreationResult(
      id: json['Id'] as String?,
    );

Map<String, dynamic> _$CollectionCreationResultToJson(
    CollectionCreationResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Id', instance.id);
  return val;
}

ConfigImageTypes _$ConfigImageTypesFromJson(Map<String, dynamic> json) =>
    ConfigImageTypes(
      backdropSizes: (json['BackdropSizes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      baseUrl: json['BaseUrl'] as String?,
      logoSizes: (json['LogoSizes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      posterSizes: (json['PosterSizes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      profileSizes: (json['ProfileSizes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      secureBaseUrl: json['SecureBaseUrl'] as String?,
      stillSizes: (json['StillSizes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$ConfigImageTypesToJson(ConfigImageTypes instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('BackdropSizes', instance.backdropSizes);
  writeNotNull('BaseUrl', instance.baseUrl);
  writeNotNull('LogoSizes', instance.logoSizes);
  writeNotNull('PosterSizes', instance.posterSizes);
  writeNotNull('ProfileSizes', instance.profileSizes);
  writeNotNull('SecureBaseUrl', instance.secureBaseUrl);
  writeNotNull('StillSizes', instance.stillSizes);
  return val;
}

ConfigurationPageInfo _$ConfigurationPageInfoFromJson(
        Map<String, dynamic> json) =>
    ConfigurationPageInfo(
      name: json['Name'] as String?,
      enableInMainMenu: json['EnableInMainMenu'] as bool?,
      menuSection: json['MenuSection'] as String?,
      menuIcon: json['MenuIcon'] as String?,
      displayName: json['DisplayName'] as String?,
      pluginId: json['PluginId'] as String?,
    );

Map<String, dynamic> _$ConfigurationPageInfoToJson(
    ConfigurationPageInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Name', instance.name);
  writeNotNull('EnableInMainMenu', instance.enableInMainMenu);
  writeNotNull('MenuSection', instance.menuSection);
  writeNotNull('MenuIcon', instance.menuIcon);
  writeNotNull('DisplayName', instance.displayName);
  writeNotNull('PluginId', instance.pluginId);
  return val;
}

ContainerProfile _$ContainerProfileFromJson(Map<String, dynamic> json) =>
    ContainerProfile(
      type: dlnaProfileTypeNullableFromJson(json['Type']),
      conditions: (json['Conditions'] as List<dynamic>?)
              ?.map((e) => ProfileCondition.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      container: json['Container'] as String?,
      subContainer: json['SubContainer'] as String?,
    );

Map<String, dynamic> _$ContainerProfileToJson(ContainerProfile instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Type', dlnaProfileTypeNullableToJson(instance.type));
  writeNotNull(
      'Conditions', instance.conditions?.map((e) => e.toJson()).toList());
  writeNotNull('Container', instance.container);
  writeNotNull('SubContainer', instance.subContainer);
  return val;
}

CountryInfo _$CountryInfoFromJson(Map<String, dynamic> json) => CountryInfo(
      name: json['Name'] as String?,
      displayName: json['DisplayName'] as String?,
      twoLetterISORegionName: json['TwoLetterISORegionName'] as String?,
      threeLetterISORegionName: json['ThreeLetterISORegionName'] as String?,
    );

Map<String, dynamic> _$CountryInfoToJson(CountryInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Name', instance.name);
  writeNotNull('DisplayName', instance.displayName);
  writeNotNull('TwoLetterISORegionName', instance.twoLetterISORegionName);
  writeNotNull('ThreeLetterISORegionName', instance.threeLetterISORegionName);
  return val;
}

CreatePlaylistDto _$CreatePlaylistDtoFromJson(Map<String, dynamic> json) =>
    CreatePlaylistDto(
      name: json['Name'] as String?,
      ids: (json['Ids'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          [],
      userId: json['UserId'] as String?,
      mediaType: mediaTypeNullableFromJson(json['MediaType']),
      users: (json['Users'] as List<dynamic>?)
              ?.map((e) =>
                  PlaylistUserPermissions.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      isPublic: json['IsPublic'] as bool?,
    );

Map<String, dynamic> _$CreatePlaylistDtoToJson(CreatePlaylistDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Name', instance.name);
  writeNotNull('Ids', instance.ids);
  writeNotNull('UserId', instance.userId);
  writeNotNull('MediaType', mediaTypeNullableToJson(instance.mediaType));
  writeNotNull('Users', instance.users?.map((e) => e.toJson()).toList());
  writeNotNull('IsPublic', instance.isPublic);
  return val;
}

CreateUserByName _$CreateUserByNameFromJson(Map<String, dynamic> json) =>
    CreateUserByName(
      name: json['Name'] as String,
      password: json['Password'] as String?,
    );

Map<String, dynamic> _$CreateUserByNameToJson(CreateUserByName instance) {
  final val = <String, dynamic>{
    'Name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Password', instance.password);
  return val;
}

CultureDto _$CultureDtoFromJson(Map<String, dynamic> json) => CultureDto(
      name: json['Name'] as String?,
      displayName: json['DisplayName'] as String?,
      twoLetterISOLanguageName: json['TwoLetterISOLanguageName'] as String?,
      threeLetterISOLanguageName: json['ThreeLetterISOLanguageName'] as String?,
      threeLetterISOLanguageNames:
          (json['ThreeLetterISOLanguageNames'] as List<dynamic>?)
                  ?.map((e) => e as String)
                  .toList() ??
              [],
    );

Map<String, dynamic> _$CultureDtoToJson(CultureDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Name', instance.name);
  writeNotNull('DisplayName', instance.displayName);
  writeNotNull('TwoLetterISOLanguageName', instance.twoLetterISOLanguageName);
  writeNotNull(
      'ThreeLetterISOLanguageName', instance.threeLetterISOLanguageName);
  writeNotNull(
      'ThreeLetterISOLanguageNames', instance.threeLetterISOLanguageNames);
  return val;
}

DefaultDirectoryBrowserInfoDto _$DefaultDirectoryBrowserInfoDtoFromJson(
        Map<String, dynamic> json) =>
    DefaultDirectoryBrowserInfoDto(
      path: json['Path'] as String?,
    );

Map<String, dynamic> _$DefaultDirectoryBrowserInfoDtoToJson(
    DefaultDirectoryBrowserInfoDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Path', instance.path);
  return val;
}

DeviceInfoDto _$DeviceInfoDtoFromJson(Map<String, dynamic> json) =>
    DeviceInfoDto(
      name: json['Name'] as String?,
      customName: json['CustomName'] as String?,
      accessToken: json['AccessToken'] as String?,
      id: json['Id'] as String?,
      lastUserName: json['LastUserName'] as String?,
      appName: json['AppName'] as String?,
      appVersion: json['AppVersion'] as String?,
      lastUserId: json['LastUserId'] as String?,
      dateLastActivity: json['DateLastActivity'] == null
          ? null
          : DateTime.parse(json['DateLastActivity'] as String),
      capabilities: json['Capabilities'] == null
          ? null
          : ClientCapabilitiesDto.fromJson(
              json['Capabilities'] as Map<String, dynamic>),
      iconUrl: json['IconUrl'] as String?,
    );

Map<String, dynamic> _$DeviceInfoDtoToJson(DeviceInfoDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Name', instance.name);
  writeNotNull('CustomName', instance.customName);
  writeNotNull('AccessToken', instance.accessToken);
  writeNotNull('Id', instance.id);
  writeNotNull('LastUserName', instance.lastUserName);
  writeNotNull('AppName', instance.appName);
  writeNotNull('AppVersion', instance.appVersion);
  writeNotNull('LastUserId', instance.lastUserId);
  writeNotNull(
      'DateLastActivity', instance.dateLastActivity?.toIso8601String());
  writeNotNull('Capabilities', instance.capabilities?.toJson());
  writeNotNull('IconUrl', instance.iconUrl);
  return val;
}

DeviceInfoDtoQueryResult _$DeviceInfoDtoQueryResultFromJson(
        Map<String, dynamic> json) =>
    DeviceInfoDtoQueryResult(
      items: (json['Items'] as List<dynamic>?)
              ?.map((e) => DeviceInfoDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      totalRecordCount: (json['TotalRecordCount'] as num?)?.toInt(),
      startIndex: (json['StartIndex'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DeviceInfoDtoQueryResultToJson(
    DeviceInfoDtoQueryResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Items', instance.items?.map((e) => e.toJson()).toList());
  writeNotNull('TotalRecordCount', instance.totalRecordCount);
  writeNotNull('StartIndex', instance.startIndex);
  return val;
}

DeviceOptionsDto _$DeviceOptionsDtoFromJson(Map<String, dynamic> json) =>
    DeviceOptionsDto(
      id: (json['Id'] as num?)?.toInt(),
      deviceId: json['DeviceId'] as String?,
      customName: json['CustomName'] as String?,
    );

Map<String, dynamic> _$DeviceOptionsDtoToJson(DeviceOptionsDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Id', instance.id);
  writeNotNull('DeviceId', instance.deviceId);
  writeNotNull('CustomName', instance.customName);
  return val;
}

DeviceProfile _$DeviceProfileFromJson(Map<String, dynamic> json) =>
    DeviceProfile(
      name: json['Name'] as String?,
      id: json['Id'] as String?,
      maxStreamingBitrate: (json['MaxStreamingBitrate'] as num?)?.toInt(),
      maxStaticBitrate: (json['MaxStaticBitrate'] as num?)?.toInt(),
      musicStreamingTranscodingBitrate:
          (json['MusicStreamingTranscodingBitrate'] as num?)?.toInt(),
      maxStaticMusicBitrate: (json['MaxStaticMusicBitrate'] as num?)?.toInt(),
      directPlayProfiles: (json['DirectPlayProfiles'] as List<dynamic>?)
              ?.map(
                  (e) => DirectPlayProfile.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      transcodingProfiles: (json['TranscodingProfiles'] as List<dynamic>?)
              ?.map(
                  (e) => TranscodingProfile.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      containerProfiles: (json['ContainerProfiles'] as List<dynamic>?)
              ?.map((e) => ContainerProfile.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      codecProfiles: (json['CodecProfiles'] as List<dynamic>?)
              ?.map((e) => CodecProfile.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      subtitleProfiles: (json['SubtitleProfiles'] as List<dynamic>?)
              ?.map((e) => SubtitleProfile.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$DeviceProfileToJson(DeviceProfile instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Name', instance.name);
  writeNotNull('Id', instance.id);
  writeNotNull('MaxStreamingBitrate', instance.maxStreamingBitrate);
  writeNotNull('MaxStaticBitrate', instance.maxStaticBitrate);
  writeNotNull('MusicStreamingTranscodingBitrate',
      instance.musicStreamingTranscodingBitrate);
  writeNotNull('MaxStaticMusicBitrate', instance.maxStaticMusicBitrate);
  writeNotNull('DirectPlayProfiles',
      instance.directPlayProfiles?.map((e) => e.toJson()).toList());
  writeNotNull('TranscodingProfiles',
      instance.transcodingProfiles?.map((e) => e.toJson()).toList());
  writeNotNull('ContainerProfiles',
      instance.containerProfiles?.map((e) => e.toJson()).toList());
  writeNotNull(
      'CodecProfiles', instance.codecProfiles?.map((e) => e.toJson()).toList());
  writeNotNull('SubtitleProfiles',
      instance.subtitleProfiles?.map((e) => e.toJson()).toList());
  return val;
}

DirectPlayProfile _$DirectPlayProfileFromJson(Map<String, dynamic> json) =>
    DirectPlayProfile(
      container: json['Container'] as String?,
      audioCodec: json['AudioCodec'] as String?,
      videoCodec: json['VideoCodec'] as String?,
      type: dlnaProfileTypeNullableFromJson(json['Type']),
    );

Map<String, dynamic> _$DirectPlayProfileToJson(DirectPlayProfile instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Container', instance.container);
  writeNotNull('AudioCodec', instance.audioCodec);
  writeNotNull('VideoCodec', instance.videoCodec);
  writeNotNull('Type', dlnaProfileTypeNullableToJson(instance.type));
  return val;
}

DisplayPreferencesDto _$DisplayPreferencesDtoFromJson(
        Map<String, dynamic> json) =>
    DisplayPreferencesDto(
      id: json['Id'] as String?,
      viewType: json['ViewType'] as String?,
      sortBy: json['SortBy'] as String?,
      indexBy: json['IndexBy'] as String?,
      rememberIndexing: json['RememberIndexing'] as bool?,
      primaryImageHeight: (json['PrimaryImageHeight'] as num?)?.toInt(),
      primaryImageWidth: (json['PrimaryImageWidth'] as num?)?.toInt(),
      customPrefs: json['CustomPrefs'] as Map<String, dynamic>?,
      scrollDirection: scrollDirectionNullableFromJson(json['ScrollDirection']),
      showBackdrop: json['ShowBackdrop'] as bool?,
      rememberSorting: json['RememberSorting'] as bool?,
      sortOrder: sortOrderNullableFromJson(json['SortOrder']),
      showSidebar: json['ShowSidebar'] as bool?,
      $Client: json['Client'] as String?,
    );

Map<String, dynamic> _$DisplayPreferencesDtoToJson(
    DisplayPreferencesDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Id', instance.id);
  writeNotNull('ViewType', instance.viewType);
  writeNotNull('SortBy', instance.sortBy);
  writeNotNull('IndexBy', instance.indexBy);
  writeNotNull('RememberIndexing', instance.rememberIndexing);
  writeNotNull('PrimaryImageHeight', instance.primaryImageHeight);
  writeNotNull('PrimaryImageWidth', instance.primaryImageWidth);
  writeNotNull('CustomPrefs', instance.customPrefs);
  writeNotNull('ScrollDirection',
      scrollDirectionNullableToJson(instance.scrollDirection));
  writeNotNull('ShowBackdrop', instance.showBackdrop);
  writeNotNull('RememberSorting', instance.rememberSorting);
  writeNotNull('SortOrder', sortOrderNullableToJson(instance.sortOrder));
  writeNotNull('ShowSidebar', instance.showSidebar);
  writeNotNull('Client', instance.$Client);
  return val;
}

EncodingOptions _$EncodingOptionsFromJson(Map<String, dynamic> json) =>
    EncodingOptions(
      encodingThreadCount: (json['EncodingThreadCount'] as num?)?.toInt(),
      transcodingTempPath: json['TranscodingTempPath'] as String?,
      fallbackFontPath: json['FallbackFontPath'] as String?,
      enableFallbackFont: json['EnableFallbackFont'] as bool?,
      enableAudioVbr: json['EnableAudioVbr'] as bool?,
      downMixAudioBoost: (json['DownMixAudioBoost'] as num?)?.toDouble(),
      downMixStereoAlgorithm: downMixStereoAlgorithmsNullableFromJson(
          json['DownMixStereoAlgorithm']),
      maxMuxingQueueSize: (json['MaxMuxingQueueSize'] as num?)?.toInt(),
      enableThrottling: json['EnableThrottling'] as bool?,
      throttleDelaySeconds: (json['ThrottleDelaySeconds'] as num?)?.toInt(),
      enableSegmentDeletion: json['EnableSegmentDeletion'] as bool?,
      segmentKeepSeconds: (json['SegmentKeepSeconds'] as num?)?.toInt(),
      hardwareAccelerationType: hardwareAccelerationTypeNullableFromJson(
          json['HardwareAccelerationType']),
      encoderAppPath: json['EncoderAppPath'] as String?,
      encoderAppPathDisplay: json['EncoderAppPathDisplay'] as String?,
      vaapiDevice: json['VaapiDevice'] as String?,
      qsvDevice: json['QsvDevice'] as String?,
      enableTonemapping: json['EnableTonemapping'] as bool?,
      enableVppTonemapping: json['EnableVppTonemapping'] as bool?,
      enableVideoToolboxTonemapping:
          json['EnableVideoToolboxTonemapping'] as bool?,
      tonemappingAlgorithm:
          tonemappingAlgorithmNullableFromJson(json['TonemappingAlgorithm']),
      tonemappingMode: tonemappingModeNullableFromJson(json['TonemappingMode']),
      tonemappingRange:
          tonemappingRangeNullableFromJson(json['TonemappingRange']),
      tonemappingDesat: (json['TonemappingDesat'] as num?)?.toDouble(),
      tonemappingPeak: (json['TonemappingPeak'] as num?)?.toDouble(),
      tonemappingParam: (json['TonemappingParam'] as num?)?.toDouble(),
      vppTonemappingBrightness:
          (json['VppTonemappingBrightness'] as num?)?.toDouble(),
      vppTonemappingContrast:
          (json['VppTonemappingContrast'] as num?)?.toDouble(),
      h264Crf: (json['H264Crf'] as num?)?.toInt(),
      h265Crf: (json['H265Crf'] as num?)?.toInt(),
      encoderPreset: encoderPresetNullableFromJson(json['EncoderPreset']),
      deinterlaceDoubleRate: json['DeinterlaceDoubleRate'] as bool?,
      deinterlaceMethod:
          deinterlaceMethodNullableFromJson(json['DeinterlaceMethod']),
      enableDecodingColorDepth10Hevc:
          json['EnableDecodingColorDepth10Hevc'] as bool?,
      enableDecodingColorDepth10Vp9:
          json['EnableDecodingColorDepth10Vp9'] as bool?,
      enableDecodingColorDepth10HevcRext:
          json['EnableDecodingColorDepth10HevcRext'] as bool?,
      enableDecodingColorDepth12HevcRext:
          json['EnableDecodingColorDepth12HevcRext'] as bool?,
      enableEnhancedNvdecDecoder: json['EnableEnhancedNvdecDecoder'] as bool?,
      preferSystemNativeHwDecoder: json['PreferSystemNativeHwDecoder'] as bool?,
      enableIntelLowPowerH264HwEncoder:
          json['EnableIntelLowPowerH264HwEncoder'] as bool?,
      enableIntelLowPowerHevcHwEncoder:
          json['EnableIntelLowPowerHevcHwEncoder'] as bool?,
      enableHardwareEncoding: json['EnableHardwareEncoding'] as bool?,
      allowHevcEncoding: json['AllowHevcEncoding'] as bool?,
      allowAv1Encoding: json['AllowAv1Encoding'] as bool?,
      enableSubtitleExtraction: json['EnableSubtitleExtraction'] as bool?,
      hardwareDecodingCodecs: (json['HardwareDecodingCodecs'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      allowOnDemandMetadataBasedKeyframeExtractionForExtensions:
          (json['AllowOnDemandMetadataBasedKeyframeExtractionForExtensions']
                      as List<dynamic>?)
                  ?.map((e) => e as String)
                  .toList() ??
              [],
    );

Map<String, dynamic> _$EncodingOptionsToJson(EncodingOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('EncodingThreadCount', instance.encodingThreadCount);
  writeNotNull('TranscodingTempPath', instance.transcodingTempPath);
  writeNotNull('FallbackFontPath', instance.fallbackFontPath);
  writeNotNull('EnableFallbackFont', instance.enableFallbackFont);
  writeNotNull('EnableAudioVbr', instance.enableAudioVbr);
  writeNotNull('DownMixAudioBoost', instance.downMixAudioBoost);
  writeNotNull('DownMixStereoAlgorithm',
      downMixStereoAlgorithmsNullableToJson(instance.downMixStereoAlgorithm));
  writeNotNull('MaxMuxingQueueSize', instance.maxMuxingQueueSize);
  writeNotNull('EnableThrottling', instance.enableThrottling);
  writeNotNull('ThrottleDelaySeconds', instance.throttleDelaySeconds);
  writeNotNull('EnableSegmentDeletion', instance.enableSegmentDeletion);
  writeNotNull('SegmentKeepSeconds', instance.segmentKeepSeconds);
  writeNotNull(
      'HardwareAccelerationType',
      hardwareAccelerationTypeNullableToJson(
          instance.hardwareAccelerationType));
  writeNotNull('EncoderAppPath', instance.encoderAppPath);
  writeNotNull('EncoderAppPathDisplay', instance.encoderAppPathDisplay);
  writeNotNull('VaapiDevice', instance.vaapiDevice);
  writeNotNull('QsvDevice', instance.qsvDevice);
  writeNotNull('EnableTonemapping', instance.enableTonemapping);
  writeNotNull('EnableVppTonemapping', instance.enableVppTonemapping);
  writeNotNull(
      'EnableVideoToolboxTonemapping', instance.enableVideoToolboxTonemapping);
  writeNotNull('TonemappingAlgorithm',
      tonemappingAlgorithmNullableToJson(instance.tonemappingAlgorithm));
  writeNotNull('TonemappingMode',
      tonemappingModeNullableToJson(instance.tonemappingMode));
  writeNotNull('TonemappingRange',
      tonemappingRangeNullableToJson(instance.tonemappingRange));
  writeNotNull('TonemappingDesat', instance.tonemappingDesat);
  writeNotNull('TonemappingPeak', instance.tonemappingPeak);
  writeNotNull('TonemappingParam', instance.tonemappingParam);
  writeNotNull('VppTonemappingBrightness', instance.vppTonemappingBrightness);
  writeNotNull('VppTonemappingContrast', instance.vppTonemappingContrast);
  writeNotNull('H264Crf', instance.h264Crf);
  writeNotNull('H265Crf', instance.h265Crf);
  writeNotNull(
      'EncoderPreset', encoderPresetNullableToJson(instance.encoderPreset));
  writeNotNull('DeinterlaceDoubleRate', instance.deinterlaceDoubleRate);
  writeNotNull('DeinterlaceMethod',
      deinterlaceMethodNullableToJson(instance.deinterlaceMethod));
  writeNotNull('EnableDecodingColorDepth10Hevc',
      instance.enableDecodingColorDepth10Hevc);
  writeNotNull(
      'EnableDecodingColorDepth10Vp9', instance.enableDecodingColorDepth10Vp9);
  writeNotNull('EnableDecodingColorDepth10HevcRext',
      instance.enableDecodingColorDepth10HevcRext);
  writeNotNull('EnableDecodingColorDepth12HevcRext',
      instance.enableDecodingColorDepth12HevcRext);
  writeNotNull(
      'EnableEnhancedNvdecDecoder', instance.enableEnhancedNvdecDecoder);
  writeNotNull(
      'PreferSystemNativeHwDecoder', instance.preferSystemNativeHwDecoder);
  writeNotNull('EnableIntelLowPowerH264HwEncoder',
      instance.enableIntelLowPowerH264HwEncoder);
  writeNotNull('EnableIntelLowPowerHevcHwEncoder',
      instance.enableIntelLowPowerHevcHwEncoder);
  writeNotNull('EnableHardwareEncoding', instance.enableHardwareEncoding);
  writeNotNull('AllowHevcEncoding', instance.allowHevcEncoding);
  writeNotNull('AllowAv1Encoding', instance.allowAv1Encoding);
  writeNotNull('EnableSubtitleExtraction', instance.enableSubtitleExtraction);
  writeNotNull('HardwareDecodingCodecs', instance.hardwareDecodingCodecs);
  writeNotNull('AllowOnDemandMetadataBasedKeyframeExtractionForExtensions',
      instance.allowOnDemandMetadataBasedKeyframeExtractionForExtensions);
  return val;
}

EndPointInfo _$EndPointInfoFromJson(Map<String, dynamic> json) => EndPointInfo(
      isLocal: json['IsLocal'] as bool?,
      isInNetwork: json['IsInNetwork'] as bool?,
    );

Map<String, dynamic> _$EndPointInfoToJson(EndPointInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('IsLocal', instance.isLocal);
  writeNotNull('IsInNetwork', instance.isInNetwork);
  return val;
}

ExternalIdInfo _$ExternalIdInfoFromJson(Map<String, dynamic> json) =>
    ExternalIdInfo(
      name: json['Name'] as String?,
      key: json['Key'] as String?,
      type: externalIdMediaTypeNullableFromJson(json['Type']),
      urlFormatString: json['UrlFormatString'] as String?,
    );

Map<String, dynamic> _$ExternalIdInfoToJson(ExternalIdInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Name', instance.name);
  writeNotNull('Key', instance.key);
  writeNotNull('Type', externalIdMediaTypeNullableToJson(instance.type));
  writeNotNull('UrlFormatString', instance.urlFormatString);
  return val;
}

ExternalUrl _$ExternalUrlFromJson(Map<String, dynamic> json) => ExternalUrl(
      name: json['Name'] as String?,
      url: json['Url'] as String?,
    );

Map<String, dynamic> _$ExternalUrlToJson(ExternalUrl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Name', instance.name);
  writeNotNull('Url', instance.url);
  return val;
}

FileSystemEntryInfo _$FileSystemEntryInfoFromJson(Map<String, dynamic> json) =>
    FileSystemEntryInfo(
      name: json['Name'] as String?,
      path: json['Path'] as String?,
      type: fileSystemEntryTypeNullableFromJson(json['Type']),
    );

Map<String, dynamic> _$FileSystemEntryInfoToJson(FileSystemEntryInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Name', instance.name);
  writeNotNull('Path', instance.path);
  writeNotNull('Type', fileSystemEntryTypeNullableToJson(instance.type));
  return val;
}

FontFile _$FontFileFromJson(Map<String, dynamic> json) => FontFile(
      name: json['Name'] as String?,
      size: (json['Size'] as num?)?.toInt(),
      dateCreated: json['DateCreated'] == null
          ? null
          : DateTime.parse(json['DateCreated'] as String),
      dateModified: json['DateModified'] == null
          ? null
          : DateTime.parse(json['DateModified'] as String),
    );

Map<String, dynamic> _$FontFileToJson(FontFile instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Name', instance.name);
  writeNotNull('Size', instance.size);
  writeNotNull('DateCreated', instance.dateCreated?.toIso8601String());
  writeNotNull('DateModified', instance.dateModified?.toIso8601String());
  return val;
}

ForceKeepAliveMessage _$ForceKeepAliveMessageFromJson(
        Map<String, dynamic> json) =>
    ForceKeepAliveMessage(
      data: (json['Data'] as num?)?.toInt(),
      messageId: json['MessageId'] as String?,
      messageType:
          ForceKeepAliveMessage.sessionMessageTypeMessageTypeNullableFromJson(
              json['MessageType']),
    );

Map<String, dynamic> _$ForceKeepAliveMessageToJson(
    ForceKeepAliveMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Data', instance.data);
  writeNotNull('MessageId', instance.messageId);
  writeNotNull(
      'MessageType', sessionMessageTypeNullableToJson(instance.messageType));
  return val;
}

ForgotPasswordDto _$ForgotPasswordDtoFromJson(Map<String, dynamic> json) =>
    ForgotPasswordDto(
      enteredUsername: json['EnteredUsername'] as String,
    );

Map<String, dynamic> _$ForgotPasswordDtoToJson(ForgotPasswordDto instance) =>
    <String, dynamic>{
      'EnteredUsername': instance.enteredUsername,
    };

ForgotPasswordPinDto _$ForgotPasswordPinDtoFromJson(
        Map<String, dynamic> json) =>
    ForgotPasswordPinDto(
      pin: json['Pin'] as String,
    );

Map<String, dynamic> _$ForgotPasswordPinDtoToJson(
        ForgotPasswordPinDto instance) =>
    <String, dynamic>{
      'Pin': instance.pin,
    };

ForgotPasswordResult _$ForgotPasswordResultFromJson(
        Map<String, dynamic> json) =>
    ForgotPasswordResult(
      action: forgotPasswordActionNullableFromJson(json['Action']),
      pinFile: json['PinFile'] as String?,
      pinExpirationDate: json['PinExpirationDate'] == null
          ? null
          : DateTime.parse(json['PinExpirationDate'] as String),
    );

Map<String, dynamic> _$ForgotPasswordResultToJson(
    ForgotPasswordResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Action', forgotPasswordActionNullableToJson(instance.action));
  writeNotNull('PinFile', instance.pinFile);
  writeNotNull(
      'PinExpirationDate', instance.pinExpirationDate?.toIso8601String());
  return val;
}

GeneralCommand _$GeneralCommandFromJson(Map<String, dynamic> json) =>
    GeneralCommand(
      name: generalCommandTypeNullableFromJson(json['Name']),
      controllingUserId: json['ControllingUserId'] as String?,
      arguments: json['Arguments'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$GeneralCommandToJson(GeneralCommand instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Name', generalCommandTypeNullableToJson(instance.name));
  writeNotNull('ControllingUserId', instance.controllingUserId);
  writeNotNull('Arguments', instance.arguments);
  return val;
}

GeneralCommandMessage _$GeneralCommandMessageFromJson(
        Map<String, dynamic> json) =>
    GeneralCommandMessage(
      data: json['Data'] == null
          ? null
          : GeneralCommand.fromJson(json['Data'] as Map<String, dynamic>),
      messageId: json['MessageId'] as String?,
      messageType:
          GeneralCommandMessage.sessionMessageTypeMessageTypeNullableFromJson(
              json['MessageType']),
    );

Map<String, dynamic> _$GeneralCommandMessageToJson(
    GeneralCommandMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Data', instance.data?.toJson());
  writeNotNull('MessageId', instance.messageId);
  writeNotNull(
      'MessageType', sessionMessageTypeNullableToJson(instance.messageType));
  return val;
}

GetProgramsDto _$GetProgramsDtoFromJson(Map<String, dynamic> json) =>
    GetProgramsDto(
      channelIds: (json['ChannelIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      userId: json['UserId'] as String?,
      minStartDate: json['MinStartDate'] == null
          ? null
          : DateTime.parse(json['MinStartDate'] as String),
      hasAired: json['HasAired'] as bool?,
      isAiring: json['IsAiring'] as bool?,
      maxStartDate: json['MaxStartDate'] == null
          ? null
          : DateTime.parse(json['MaxStartDate'] as String),
      minEndDate: json['MinEndDate'] == null
          ? null
          : DateTime.parse(json['MinEndDate'] as String),
      maxEndDate: json['MaxEndDate'] == null
          ? null
          : DateTime.parse(json['MaxEndDate'] as String),
      isMovie: json['IsMovie'] as bool?,
      isSeries: json['IsSeries'] as bool?,
      isNews: json['IsNews'] as bool?,
      isKids: json['IsKids'] as bool?,
      isSports: json['IsSports'] as bool?,
      startIndex: (json['StartIndex'] as num?)?.toInt(),
      limit: (json['Limit'] as num?)?.toInt(),
      sortBy: itemSortByListFromJson(json['SortBy'] as List?),
      sortOrder: sortOrderListFromJson(json['SortOrder'] as List?),
      genres: (json['Genres'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      genreIds: (json['GenreIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      enableImages: json['EnableImages'] as bool?,
      enableTotalRecordCount: json['EnableTotalRecordCount'] as bool? ?? true,
      imageTypeLimit: (json['ImageTypeLimit'] as num?)?.toInt(),
      enableImageTypes:
          imageTypeListFromJson(json['EnableImageTypes'] as List?),
      enableUserData: json['EnableUserData'] as bool?,
      seriesTimerId: json['SeriesTimerId'] as String?,
      librarySeriesId: json['LibrarySeriesId'] as String?,
      fields: itemFieldsListFromJson(json['Fields'] as List?),
    );

Map<String, dynamic> _$GetProgramsDtoToJson(GetProgramsDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ChannelIds', instance.channelIds);
  writeNotNull('UserId', instance.userId);
  writeNotNull('MinStartDate', instance.minStartDate?.toIso8601String());
  writeNotNull('HasAired', instance.hasAired);
  writeNotNull('IsAiring', instance.isAiring);
  writeNotNull('MaxStartDate', instance.maxStartDate?.toIso8601String());
  writeNotNull('MinEndDate', instance.minEndDate?.toIso8601String());
  writeNotNull('MaxEndDate', instance.maxEndDate?.toIso8601String());
  writeNotNull('IsMovie', instance.isMovie);
  writeNotNull('IsSeries', instance.isSeries);
  writeNotNull('IsNews', instance.isNews);
  writeNotNull('IsKids', instance.isKids);
  writeNotNull('IsSports', instance.isSports);
  writeNotNull('StartIndex', instance.startIndex);
  writeNotNull('Limit', instance.limit);
  val['SortBy'] = itemSortByListToJson(instance.sortBy);
  val['SortOrder'] = sortOrderListToJson(instance.sortOrder);
  writeNotNull('Genres', instance.genres);
  writeNotNull('GenreIds', instance.genreIds);
  writeNotNull('EnableImages', instance.enableImages);
  writeNotNull('EnableTotalRecordCount', instance.enableTotalRecordCount);
  writeNotNull('ImageTypeLimit', instance.imageTypeLimit);
  val['EnableImageTypes'] = imageTypeListToJson(instance.enableImageTypes);
  writeNotNull('EnableUserData', instance.enableUserData);
  writeNotNull('SeriesTimerId', instance.seriesTimerId);
  writeNotNull('LibrarySeriesId', instance.librarySeriesId);
  val['Fields'] = itemFieldsListToJson(instance.fields);
  return val;
}

GroupInfoDto _$GroupInfoDtoFromJson(Map<String, dynamic> json) => GroupInfoDto(
      groupId: json['GroupId'] as String?,
      groupName: json['GroupName'] as String?,
      state: groupStateTypeNullableFromJson(json['State']),
      participants: (json['Participants'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      lastUpdatedAt: json['LastUpdatedAt'] == null
          ? null
          : DateTime.parse(json['LastUpdatedAt'] as String),
    );

Map<String, dynamic> _$GroupInfoDtoToJson(GroupInfoDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('GroupId', instance.groupId);
  writeNotNull('GroupName', instance.groupName);
  writeNotNull('State', groupStateTypeNullableToJson(instance.state));
  writeNotNull('Participants', instance.participants);
  writeNotNull('LastUpdatedAt', instance.lastUpdatedAt?.toIso8601String());
  return val;
}

GroupInfoDtoGroupUpdate _$GroupInfoDtoGroupUpdateFromJson(
        Map<String, dynamic> json) =>
    GroupInfoDtoGroupUpdate(
      groupId: json['GroupId'] as String?,
      type: groupUpdateTypeNullableFromJson(json['Type']),
      data: json['Data'] == null
          ? null
          : GroupInfoDto.fromJson(json['Data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GroupInfoDtoGroupUpdateToJson(
    GroupInfoDtoGroupUpdate instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('GroupId', instance.groupId);
  writeNotNull('Type', groupUpdateTypeNullableToJson(instance.type));
  writeNotNull('Data', instance.data?.toJson());
  return val;
}

GroupStateUpdate _$GroupStateUpdateFromJson(Map<String, dynamic> json) =>
    GroupStateUpdate(
      state: groupStateTypeNullableFromJson(json['State']),
      reason: playbackRequestTypeNullableFromJson(json['Reason']),
    );

Map<String, dynamic> _$GroupStateUpdateToJson(GroupStateUpdate instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('State', groupStateTypeNullableToJson(instance.state));
  writeNotNull('Reason', playbackRequestTypeNullableToJson(instance.reason));
  return val;
}

GroupStateUpdateGroupUpdate _$GroupStateUpdateGroupUpdateFromJson(
        Map<String, dynamic> json) =>
    GroupStateUpdateGroupUpdate(
      groupId: json['GroupId'] as String?,
      type: groupUpdateTypeNullableFromJson(json['Type']),
      data: json['Data'] == null
          ? null
          : GroupStateUpdate.fromJson(json['Data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GroupStateUpdateGroupUpdateToJson(
    GroupStateUpdateGroupUpdate instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('GroupId', instance.groupId);
  writeNotNull('Type', groupUpdateTypeNullableToJson(instance.type));
  writeNotNull('Data', instance.data?.toJson());
  return val;
}

GroupUpdate _$GroupUpdateFromJson(Map<String, dynamic> json) => GroupUpdate(
      groupId: json['GroupId'] as String?,
      type: groupUpdateTypeNullableFromJson(json['Type']),
    );

Map<String, dynamic> _$GroupUpdateToJson(GroupUpdate instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('GroupId', instance.groupId);
  writeNotNull('Type', groupUpdateTypeNullableToJson(instance.type));
  return val;
}

GuideInfo _$GuideInfoFromJson(Map<String, dynamic> json) => GuideInfo(
      startDate: json['StartDate'] == null
          ? null
          : DateTime.parse(json['StartDate'] as String),
      endDate: json['EndDate'] == null
          ? null
          : DateTime.parse(json['EndDate'] as String),
    );

Map<String, dynamic> _$GuideInfoToJson(GuideInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('StartDate', instance.startDate?.toIso8601String());
  writeNotNull('EndDate', instance.endDate?.toIso8601String());
  return val;
}

IgnoreWaitRequestDto _$IgnoreWaitRequestDtoFromJson(
        Map<String, dynamic> json) =>
    IgnoreWaitRequestDto(
      ignoreWait: json['IgnoreWait'] as bool?,
    );

Map<String, dynamic> _$IgnoreWaitRequestDtoToJson(
    IgnoreWaitRequestDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('IgnoreWait', instance.ignoreWait);
  return val;
}

ImageInfo _$ImageInfoFromJson(Map<String, dynamic> json) => ImageInfo(
      imageType: imageTypeNullableFromJson(json['ImageType']),
      imageIndex: (json['ImageIndex'] as num?)?.toInt(),
      imageTag: json['ImageTag'] as String?,
      path: json['Path'] as String?,
      blurHash: json['BlurHash'] as String?,
      height: (json['Height'] as num?)?.toInt(),
      width: (json['Width'] as num?)?.toInt(),
      size: (json['Size'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ImageInfoToJson(ImageInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ImageType', imageTypeNullableToJson(instance.imageType));
  writeNotNull('ImageIndex', instance.imageIndex);
  writeNotNull('ImageTag', instance.imageTag);
  writeNotNull('Path', instance.path);
  writeNotNull('BlurHash', instance.blurHash);
  writeNotNull('Height', instance.height);
  writeNotNull('Width', instance.width);
  writeNotNull('Size', instance.size);
  return val;
}

ImageOption _$ImageOptionFromJson(Map<String, dynamic> json) => ImageOption(
      type: imageTypeNullableFromJson(json['Type']),
      limit: (json['Limit'] as num?)?.toInt(),
      minWidth: (json['MinWidth'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ImageOptionToJson(ImageOption instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Type', imageTypeNullableToJson(instance.type));
  writeNotNull('Limit', instance.limit);
  writeNotNull('MinWidth', instance.minWidth);
  return val;
}

ImageProviderInfo _$ImageProviderInfoFromJson(Map<String, dynamic> json) =>
    ImageProviderInfo(
      name: json['Name'] as String?,
      supportedImages: imageTypeListFromJson(json['SupportedImages'] as List?),
    );

Map<String, dynamic> _$ImageProviderInfoToJson(ImageProviderInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Name', instance.name);
  val['SupportedImages'] = imageTypeListToJson(instance.supportedImages);
  return val;
}

InboundKeepAliveMessage _$InboundKeepAliveMessageFromJson(
        Map<String, dynamic> json) =>
    InboundKeepAliveMessage(
      messageType:
          InboundKeepAliveMessage.sessionMessageTypeMessageTypeNullableFromJson(
              json['MessageType']),
    );

Map<String, dynamic> _$InboundKeepAliveMessageToJson(
    InboundKeepAliveMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'MessageType', sessionMessageTypeNullableToJson(instance.messageType));
  return val;
}

InboundWebSocketMessage _$InboundWebSocketMessageFromJson(
        Map<String, dynamic> json) =>
    InboundWebSocketMessage();

Map<String, dynamic> _$InboundWebSocketMessageToJson(
        InboundWebSocketMessage instance) =>
    <String, dynamic>{};

InstallationInfo _$InstallationInfoFromJson(Map<String, dynamic> json) =>
    InstallationInfo(
      guid: json['Guid'] as String?,
      name: json['Name'] as String?,
      version: json['Version'] as String?,
      changelog: json['Changelog'] as String?,
      sourceUrl: json['SourceUrl'] as String?,
      checksum: json['Checksum'] as String?,
      packageInfo: json['PackageInfo'] == null
          ? null
          : PackageInfo.fromJson(json['PackageInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InstallationInfoToJson(InstallationInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Guid', instance.guid);
  writeNotNull('Name', instance.name);
  writeNotNull('Version', instance.version);
  writeNotNull('Changelog', instance.changelog);
  writeNotNull('SourceUrl', instance.sourceUrl);
  writeNotNull('Checksum', instance.checksum);
  writeNotNull('PackageInfo', instance.packageInfo?.toJson());
  return val;
}

IPlugin _$IPluginFromJson(Map<String, dynamic> json) => IPlugin(
      name: json['Name'] as String?,
      description: json['Description'] as String?,
      id: json['Id'] as String?,
      version: json['Version'] as String?,
      assemblyFilePath: json['AssemblyFilePath'] as String?,
      canUninstall: json['CanUninstall'] as bool?,
      dataFolderPath: json['DataFolderPath'] as String?,
    );

Map<String, dynamic> _$IPluginToJson(IPlugin instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Name', instance.name);
  writeNotNull('Description', instance.description);
  writeNotNull('Id', instance.id);
  writeNotNull('Version', instance.version);
  writeNotNull('AssemblyFilePath', instance.assemblyFilePath);
  writeNotNull('CanUninstall', instance.canUninstall);
  writeNotNull('DataFolderPath', instance.dataFolderPath);
  return val;
}

ItemCounts _$ItemCountsFromJson(Map<String, dynamic> json) => ItemCounts(
      movieCount: (json['MovieCount'] as num?)?.toInt(),
      seriesCount: (json['SeriesCount'] as num?)?.toInt(),
      episodeCount: (json['EpisodeCount'] as num?)?.toInt(),
      artistCount: (json['ArtistCount'] as num?)?.toInt(),
      programCount: (json['ProgramCount'] as num?)?.toInt(),
      trailerCount: (json['TrailerCount'] as num?)?.toInt(),
      songCount: (json['SongCount'] as num?)?.toInt(),
      albumCount: (json['AlbumCount'] as num?)?.toInt(),
      musicVideoCount: (json['MusicVideoCount'] as num?)?.toInt(),
      boxSetCount: (json['BoxSetCount'] as num?)?.toInt(),
      bookCount: (json['BookCount'] as num?)?.toInt(),
      itemCount: (json['ItemCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ItemCountsToJson(ItemCounts instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('MovieCount', instance.movieCount);
  writeNotNull('SeriesCount', instance.seriesCount);
  writeNotNull('EpisodeCount', instance.episodeCount);
  writeNotNull('ArtistCount', instance.artistCount);
  writeNotNull('ProgramCount', instance.programCount);
  writeNotNull('TrailerCount', instance.trailerCount);
  writeNotNull('SongCount', instance.songCount);
  writeNotNull('AlbumCount', instance.albumCount);
  writeNotNull('MusicVideoCount', instance.musicVideoCount);
  writeNotNull('BoxSetCount', instance.boxSetCount);
  writeNotNull('BookCount', instance.bookCount);
  writeNotNull('ItemCount', instance.itemCount);
  return val;
}

JoinGroupRequestDto _$JoinGroupRequestDtoFromJson(Map<String, dynamic> json) =>
    JoinGroupRequestDto(
      groupId: json['GroupId'] as String?,
    );

Map<String, dynamic> _$JoinGroupRequestDtoToJson(JoinGroupRequestDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('GroupId', instance.groupId);
  return val;
}

LibraryChangedMessage _$LibraryChangedMessageFromJson(
        Map<String, dynamic> json) =>
    LibraryChangedMessage(
      data: json['Data'] == null
          ? null
          : LibraryUpdateInfo.fromJson(json['Data'] as Map<String, dynamic>),
      messageId: json['MessageId'] as String?,
      messageType:
          LibraryChangedMessage.sessionMessageTypeMessageTypeNullableFromJson(
              json['MessageType']),
    );

Map<String, dynamic> _$LibraryChangedMessageToJson(
    LibraryChangedMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Data', instance.data?.toJson());
  writeNotNull('MessageId', instance.messageId);
  writeNotNull(
      'MessageType', sessionMessageTypeNullableToJson(instance.messageType));
  return val;
}

LibraryOptionInfoDto _$LibraryOptionInfoDtoFromJson(
        Map<String, dynamic> json) =>
    LibraryOptionInfoDto(
      name: json['Name'] as String?,
      defaultEnabled: json['DefaultEnabled'] as bool?,
    );

Map<String, dynamic> _$LibraryOptionInfoDtoToJson(
    LibraryOptionInfoDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Name', instance.name);
  writeNotNull('DefaultEnabled', instance.defaultEnabled);
  return val;
}

LibraryOptions _$LibraryOptionsFromJson(Map<String, dynamic> json) =>
    LibraryOptions(
      enabled: json['Enabled'] as bool?,
      enablePhotos: json['EnablePhotos'] as bool?,
      enableRealtimeMonitor: json['EnableRealtimeMonitor'] as bool?,
      enableLUFSScan: json['EnableLUFSScan'] as bool?,
      enableChapterImageExtraction:
          json['EnableChapterImageExtraction'] as bool?,
      extractChapterImagesDuringLibraryScan:
          json['ExtractChapterImagesDuringLibraryScan'] as bool?,
      enableTrickplayImageExtraction:
          json['EnableTrickplayImageExtraction'] as bool?,
      extractTrickplayImagesDuringLibraryScan:
          json['ExtractTrickplayImagesDuringLibraryScan'] as bool?,
      pathInfos: (json['PathInfos'] as List<dynamic>?)
              ?.map((e) => MediaPathInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      saveLocalMetadata: json['SaveLocalMetadata'] as bool?,
      enableInternetProviders: json['EnableInternetProviders'] as bool?,
      enableAutomaticSeriesGrouping:
          json['EnableAutomaticSeriesGrouping'] as bool?,
      enableEmbeddedTitles: json['EnableEmbeddedTitles'] as bool?,
      enableEmbeddedExtrasTitles: json['EnableEmbeddedExtrasTitles'] as bool?,
      enableEmbeddedEpisodeInfos: json['EnableEmbeddedEpisodeInfos'] as bool?,
      automaticRefreshIntervalDays:
          (json['AutomaticRefreshIntervalDays'] as num?)?.toInt(),
      preferredMetadataLanguage: json['PreferredMetadataLanguage'] as String?,
      metadataCountryCode: json['MetadataCountryCode'] as String?,
      seasonZeroDisplayName: json['SeasonZeroDisplayName'] as String?,
      metadataSavers: (json['MetadataSavers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      disabledLocalMetadataReaders:
          (json['DisabledLocalMetadataReaders'] as List<dynamic>?)
                  ?.map((e) => e as String)
                  .toList() ??
              [],
      localMetadataReaderOrder:
          (json['LocalMetadataReaderOrder'] as List<dynamic>?)
                  ?.map((e) => e as String)
                  .toList() ??
              [],
      disabledSubtitleFetchers:
          (json['DisabledSubtitleFetchers'] as List<dynamic>?)
                  ?.map((e) => e as String)
                  .toList() ??
              [],
      subtitleFetcherOrder: (json['SubtitleFetcherOrder'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      disabledMediaSegmentProviders:
          (json['DisabledMediaSegmentProviders'] as List<dynamic>?)
                  ?.map((e) => e as String)
                  .toList() ??
              [],
      mediaSegmentProvideOrder:
          (json['MediaSegmentProvideOrder'] as List<dynamic>?)
                  ?.map((e) => e as String)
                  .toList() ??
              [],
      skipSubtitlesIfEmbeddedSubtitlesPresent:
          json['SkipSubtitlesIfEmbeddedSubtitlesPresent'] as bool?,
      skipSubtitlesIfAudioTrackMatches:
          json['SkipSubtitlesIfAudioTrackMatches'] as bool?,
      subtitleDownloadLanguages:
          (json['SubtitleDownloadLanguages'] as List<dynamic>?)
                  ?.map((e) => e as String)
                  .toList() ??
              [],
      requirePerfectSubtitleMatch: json['RequirePerfectSubtitleMatch'] as bool?,
      saveSubtitlesWithMedia: json['SaveSubtitlesWithMedia'] as bool?,
      saveLyricsWithMedia: json['SaveLyricsWithMedia'] as bool? ?? false,
      saveTrickplayWithMedia: json['SaveTrickplayWithMedia'] as bool? ?? false,
      disabledLyricFetchers: (json['DisabledLyricFetchers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      lyricFetcherOrder: (json['LyricFetcherOrder'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      preferNonstandardArtistsTag:
          json['PreferNonstandardArtistsTag'] as bool? ?? false,
      useCustomTagDelimiters: json['UseCustomTagDelimiters'] as bool? ?? false,
      customTagDelimiters: (json['CustomTagDelimiters'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      delimiterWhitelist: (json['DelimiterWhitelist'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      automaticallyAddToCollection:
          json['AutomaticallyAddToCollection'] as bool?,
      allowEmbeddedSubtitles: embeddedSubtitleOptionsNullableFromJson(
          json['AllowEmbeddedSubtitles']),
      typeOptions: (json['TypeOptions'] as List<dynamic>?)
              ?.map((e) => TypeOptions.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$LibraryOptionsToJson(LibraryOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Enabled', instance.enabled);
  writeNotNull('EnablePhotos', instance.enablePhotos);
  writeNotNull('EnableRealtimeMonitor', instance.enableRealtimeMonitor);
  writeNotNull('EnableLUFSScan', instance.enableLUFSScan);
  writeNotNull(
      'EnableChapterImageExtraction', instance.enableChapterImageExtraction);
  writeNotNull('ExtractChapterImagesDuringLibraryScan',
      instance.extractChapterImagesDuringLibraryScan);
  writeNotNull('EnableTrickplayImageExtraction',
      instance.enableTrickplayImageExtraction);
  writeNotNull('ExtractTrickplayImagesDuringLibraryScan',
      instance.extractTrickplayImagesDuringLibraryScan);
  writeNotNull(
      'PathInfos', instance.pathInfos?.map((e) => e.toJson()).toList());
  writeNotNull('SaveLocalMetadata', instance.saveLocalMetadata);
  writeNotNull('EnableInternetProviders', instance.enableInternetProviders);
  writeNotNull(
      'EnableAutomaticSeriesGrouping', instance.enableAutomaticSeriesGrouping);
  writeNotNull('EnableEmbeddedTitles', instance.enableEmbeddedTitles);
  writeNotNull(
      'EnableEmbeddedExtrasTitles', instance.enableEmbeddedExtrasTitles);
  writeNotNull(
      'EnableEmbeddedEpisodeInfos', instance.enableEmbeddedEpisodeInfos);
  writeNotNull(
      'AutomaticRefreshIntervalDays', instance.automaticRefreshIntervalDays);
  writeNotNull('PreferredMetadataLanguage', instance.preferredMetadataLanguage);
  writeNotNull('MetadataCountryCode', instance.metadataCountryCode);
  writeNotNull('SeasonZeroDisplayName', instance.seasonZeroDisplayName);
  writeNotNull('MetadataSavers', instance.metadataSavers);
  writeNotNull(
      'DisabledLocalMetadataReaders', instance.disabledLocalMetadataReaders);
  writeNotNull('LocalMetadataReaderOrder', instance.localMetadataReaderOrder);
  writeNotNull('DisabledSubtitleFetchers', instance.disabledSubtitleFetchers);
  writeNotNull('SubtitleFetcherOrder', instance.subtitleFetcherOrder);
  writeNotNull(
      'DisabledMediaSegmentProviders', instance.disabledMediaSegmentProviders);
  writeNotNull('MediaSegmentProvideOrder', instance.mediaSegmentProvideOrder);
  writeNotNull('SkipSubtitlesIfEmbeddedSubtitlesPresent',
      instance.skipSubtitlesIfEmbeddedSubtitlesPresent);
  writeNotNull('SkipSubtitlesIfAudioTrackMatches',
      instance.skipSubtitlesIfAudioTrackMatches);
  writeNotNull('SubtitleDownloadLanguages', instance.subtitleDownloadLanguages);
  writeNotNull(
      'RequirePerfectSubtitleMatch', instance.requirePerfectSubtitleMatch);
  writeNotNull('SaveSubtitlesWithMedia', instance.saveSubtitlesWithMedia);
  writeNotNull('SaveLyricsWithMedia', instance.saveLyricsWithMedia);
  writeNotNull('SaveTrickplayWithMedia', instance.saveTrickplayWithMedia);
  writeNotNull('DisabledLyricFetchers', instance.disabledLyricFetchers);
  writeNotNull('LyricFetcherOrder', instance.lyricFetcherOrder);
  writeNotNull(
      'PreferNonstandardArtistsTag', instance.preferNonstandardArtistsTag);
  writeNotNull('UseCustomTagDelimiters', instance.useCustomTagDelimiters);
  writeNotNull('CustomTagDelimiters', instance.customTagDelimiters);
  writeNotNull('DelimiterWhitelist', instance.delimiterWhitelist);
  writeNotNull(
      'AutomaticallyAddToCollection', instance.automaticallyAddToCollection);
  writeNotNull('AllowEmbeddedSubtitles',
      embeddedSubtitleOptionsNullableToJson(instance.allowEmbeddedSubtitles));
  writeNotNull(
      'TypeOptions', instance.typeOptions?.map((e) => e.toJson()).toList());
  return val;
}

LibraryOptionsResultDto _$LibraryOptionsResultDtoFromJson(
        Map<String, dynamic> json) =>
    LibraryOptionsResultDto(
      metadataSavers: (json['MetadataSavers'] as List<dynamic>?)
              ?.map((e) =>
                  LibraryOptionInfoDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      metadataReaders: (json['MetadataReaders'] as List<dynamic>?)
              ?.map((e) =>
                  LibraryOptionInfoDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      subtitleFetchers: (json['SubtitleFetchers'] as List<dynamic>?)
              ?.map((e) =>
                  LibraryOptionInfoDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      lyricFetchers: (json['LyricFetchers'] as List<dynamic>?)
              ?.map((e) =>
                  LibraryOptionInfoDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      typeOptions: (json['TypeOptions'] as List<dynamic>?)
              ?.map((e) =>
                  LibraryTypeOptionsDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$LibraryOptionsResultDtoToJson(
    LibraryOptionsResultDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('MetadataSavers',
      instance.metadataSavers?.map((e) => e.toJson()).toList());
  writeNotNull('MetadataReaders',
      instance.metadataReaders?.map((e) => e.toJson()).toList());
  writeNotNull('SubtitleFetchers',
      instance.subtitleFetchers?.map((e) => e.toJson()).toList());
  writeNotNull(
      'LyricFetchers', instance.lyricFetchers?.map((e) => e.toJson()).toList());
  writeNotNull(
      'TypeOptions', instance.typeOptions?.map((e) => e.toJson()).toList());
  return val;
}

LibraryTypeOptionsDto _$LibraryTypeOptionsDtoFromJson(
        Map<String, dynamic> json) =>
    LibraryTypeOptionsDto(
      type: json['Type'] as String?,
      metadataFetchers: (json['MetadataFetchers'] as List<dynamic>?)
              ?.map((e) =>
                  LibraryOptionInfoDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      imageFetchers: (json['ImageFetchers'] as List<dynamic>?)
              ?.map((e) =>
                  LibraryOptionInfoDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      supportedImageTypes:
          imageTypeListFromJson(json['SupportedImageTypes'] as List?),
      defaultImageOptions: (json['DefaultImageOptions'] as List<dynamic>?)
              ?.map((e) => ImageOption.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$LibraryTypeOptionsDtoToJson(
    LibraryTypeOptionsDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Type', instance.type);
  writeNotNull('MetadataFetchers',
      instance.metadataFetchers?.map((e) => e.toJson()).toList());
  writeNotNull(
      'ImageFetchers', instance.imageFetchers?.map((e) => e.toJson()).toList());
  val['SupportedImageTypes'] =
      imageTypeListToJson(instance.supportedImageTypes);
  writeNotNull('DefaultImageOptions',
      instance.defaultImageOptions?.map((e) => e.toJson()).toList());
  return val;
}

LibraryUpdateInfo _$LibraryUpdateInfoFromJson(Map<String, dynamic> json) =>
    LibraryUpdateInfo(
      foldersAddedTo: (json['FoldersAddedTo'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      foldersRemovedFrom: (json['FoldersRemovedFrom'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      itemsAdded: (json['ItemsAdded'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      itemsRemoved: (json['ItemsRemoved'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      itemsUpdated: (json['ItemsUpdated'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      collectionFolders: (json['CollectionFolders'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      isEmpty: json['IsEmpty'] as bool?,
    );

Map<String, dynamic> _$LibraryUpdateInfoToJson(LibraryUpdateInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('FoldersAddedTo', instance.foldersAddedTo);
  writeNotNull('FoldersRemovedFrom', instance.foldersRemovedFrom);
  writeNotNull('ItemsAdded', instance.itemsAdded);
  writeNotNull('ItemsRemoved', instance.itemsRemoved);
  writeNotNull('ItemsUpdated', instance.itemsUpdated);
  writeNotNull('CollectionFolders', instance.collectionFolders);
  writeNotNull('IsEmpty', instance.isEmpty);
  return val;
}

ListingsProviderInfo _$ListingsProviderInfoFromJson(
        Map<String, dynamic> json) =>
    ListingsProviderInfo(
      id: json['Id'] as String?,
      type: json['Type'] as String?,
      username: json['Username'] as String?,
      password: json['Password'] as String?,
      listingsId: json['ListingsId'] as String?,
      zipCode: json['ZipCode'] as String?,
      country: json['Country'] as String?,
      path: json['Path'] as String?,
      enabledTuners: (json['EnabledTuners'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      enableAllTuners: json['EnableAllTuners'] as bool?,
      newsCategories: (json['NewsCategories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      sportsCategories: (json['SportsCategories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      kidsCategories: (json['KidsCategories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      movieCategories: (json['MovieCategories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      channelMappings: (json['ChannelMappings'] as List<dynamic>?)
              ?.map((e) => NameValuePair.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      moviePrefix: json['MoviePrefix'] as String?,
      preferredLanguage: json['PreferredLanguage'] as String?,
      userAgent: json['UserAgent'] as String?,
    );

Map<String, dynamic> _$ListingsProviderInfoToJson(
    ListingsProviderInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Id', instance.id);
  writeNotNull('Type', instance.type);
  writeNotNull('Username', instance.username);
  writeNotNull('Password', instance.password);
  writeNotNull('ListingsId', instance.listingsId);
  writeNotNull('ZipCode', instance.zipCode);
  writeNotNull('Country', instance.country);
  writeNotNull('Path', instance.path);
  writeNotNull('EnabledTuners', instance.enabledTuners);
  writeNotNull('EnableAllTuners', instance.enableAllTuners);
  writeNotNull('NewsCategories', instance.newsCategories);
  writeNotNull('SportsCategories', instance.sportsCategories);
  writeNotNull('KidsCategories', instance.kidsCategories);
  writeNotNull('MovieCategories', instance.movieCategories);
  writeNotNull('ChannelMappings',
      instance.channelMappings?.map((e) => e.toJson()).toList());
  writeNotNull('MoviePrefix', instance.moviePrefix);
  writeNotNull('PreferredLanguage', instance.preferredLanguage);
  writeNotNull('UserAgent', instance.userAgent);
  return val;
}

LiveStreamResponse _$LiveStreamResponseFromJson(Map<String, dynamic> json) =>
    LiveStreamResponse(
      mediaSource: json['MediaSource'] == null
          ? null
          : MediaSourceInfo.fromJson(
              json['MediaSource'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LiveStreamResponseToJson(LiveStreamResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('MediaSource', instance.mediaSource?.toJson());
  return val;
}

LiveTvInfo _$LiveTvInfoFromJson(Map<String, dynamic> json) => LiveTvInfo(
      services: (json['Services'] as List<dynamic>?)
              ?.map(
                  (e) => LiveTvServiceInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      isEnabled: json['IsEnabled'] as bool?,
      enabledUsers: (json['EnabledUsers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$LiveTvInfoToJson(LiveTvInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Services', instance.services?.map((e) => e.toJson()).toList());
  writeNotNull('IsEnabled', instance.isEnabled);
  writeNotNull('EnabledUsers', instance.enabledUsers);
  return val;
}

LiveTvOptions _$LiveTvOptionsFromJson(Map<String, dynamic> json) =>
    LiveTvOptions(
      guideDays: (json['GuideDays'] as num?)?.toInt(),
      recordingPath: json['RecordingPath'] as String?,
      movieRecordingPath: json['MovieRecordingPath'] as String?,
      seriesRecordingPath: json['SeriesRecordingPath'] as String?,
      enableRecordingSubfolders: json['EnableRecordingSubfolders'] as bool?,
      enableOriginalAudioWithEncodedRecordings:
          json['EnableOriginalAudioWithEncodedRecordings'] as bool?,
      tunerHosts: (json['TunerHosts'] as List<dynamic>?)
              ?.map((e) => TunerHostInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      listingProviders: (json['ListingProviders'] as List<dynamic>?)
              ?.map((e) =>
                  ListingsProviderInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      prePaddingSeconds: (json['PrePaddingSeconds'] as num?)?.toInt(),
      postPaddingSeconds: (json['PostPaddingSeconds'] as num?)?.toInt(),
      mediaLocationsCreated: (json['MediaLocationsCreated'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      recordingPostProcessor: json['RecordingPostProcessor'] as String?,
      recordingPostProcessorArguments:
          json['RecordingPostProcessorArguments'] as String?,
      saveRecordingNFO: json['SaveRecordingNFO'] as bool?,
      saveRecordingImages: json['SaveRecordingImages'] as bool?,
    );

Map<String, dynamic> _$LiveTvOptionsToJson(LiveTvOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('GuideDays', instance.guideDays);
  writeNotNull('RecordingPath', instance.recordingPath);
  writeNotNull('MovieRecordingPath', instance.movieRecordingPath);
  writeNotNull('SeriesRecordingPath', instance.seriesRecordingPath);
  writeNotNull('EnableRecordingSubfolders', instance.enableRecordingSubfolders);
  writeNotNull('EnableOriginalAudioWithEncodedRecordings',
      instance.enableOriginalAudioWithEncodedRecordings);
  writeNotNull(
      'TunerHosts', instance.tunerHosts?.map((e) => e.toJson()).toList());
  writeNotNull('ListingProviders',
      instance.listingProviders?.map((e) => e.toJson()).toList());
  writeNotNull('PrePaddingSeconds', instance.prePaddingSeconds);
  writeNotNull('PostPaddingSeconds', instance.postPaddingSeconds);
  writeNotNull('MediaLocationsCreated', instance.mediaLocationsCreated);
  writeNotNull('RecordingPostProcessor', instance.recordingPostProcessor);
  writeNotNull('RecordingPostProcessorArguments',
      instance.recordingPostProcessorArguments);
  writeNotNull('SaveRecordingNFO', instance.saveRecordingNFO);
  writeNotNull('SaveRecordingImages', instance.saveRecordingImages);
  return val;
}

LiveTvServiceInfo _$LiveTvServiceInfoFromJson(Map<String, dynamic> json) =>
    LiveTvServiceInfo(
      name: json['Name'] as String?,
      homePageUrl: json['HomePageUrl'] as String?,
      status: liveTvServiceStatusNullableFromJson(json['Status']),
      statusMessage: json['StatusMessage'] as String?,
      version: json['Version'] as String?,
      hasUpdateAvailable: json['HasUpdateAvailable'] as bool?,
      isVisible: json['IsVisible'] as bool?,
      tuners: (json['Tuners'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$LiveTvServiceInfoToJson(LiveTvServiceInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Name', instance.name);
  writeNotNull('HomePageUrl', instance.homePageUrl);
  writeNotNull('Status', liveTvServiceStatusNullableToJson(instance.status));
  writeNotNull('StatusMessage', instance.statusMessage);
  writeNotNull('Version', instance.version);
  writeNotNull('HasUpdateAvailable', instance.hasUpdateAvailable);
  writeNotNull('IsVisible', instance.isVisible);
  writeNotNull('Tuners', instance.tuners);
  return val;
}

LocalizationOption _$LocalizationOptionFromJson(Map<String, dynamic> json) =>
    LocalizationOption(
      name: json['Name'] as String?,
      $Value: json['Value'] as String?,
    );

Map<String, dynamic> _$LocalizationOptionToJson(LocalizationOption instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Name', instance.name);
  writeNotNull('Value', instance.$Value);
  return val;
}

LogFile _$LogFileFromJson(Map<String, dynamic> json) => LogFile(
      dateCreated: json['DateCreated'] == null
          ? null
          : DateTime.parse(json['DateCreated'] as String),
      dateModified: json['DateModified'] == null
          ? null
          : DateTime.parse(json['DateModified'] as String),
      size: (json['Size'] as num?)?.toInt(),
      name: json['Name'] as String?,
    );

Map<String, dynamic> _$LogFileToJson(LogFile instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('DateCreated', instance.dateCreated?.toIso8601String());
  writeNotNull('DateModified', instance.dateModified?.toIso8601String());
  writeNotNull('Size', instance.size);
  writeNotNull('Name', instance.name);
  return val;
}

LyricDto _$LyricDtoFromJson(Map<String, dynamic> json) => LyricDto(
      metadata: json['Metadata'] == null
          ? null
          : LyricMetadata.fromJson(json['Metadata'] as Map<String, dynamic>),
      lyrics: (json['Lyrics'] as List<dynamic>?)
              ?.map((e) => LyricLine.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$LyricDtoToJson(LyricDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Metadata', instance.metadata?.toJson());
  writeNotNull('Lyrics', instance.lyrics?.map((e) => e.toJson()).toList());
  return val;
}

LyricLine _$LyricLineFromJson(Map<String, dynamic> json) => LyricLine(
      text: json['Text'] as String?,
      start: (json['Start'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LyricLineToJson(LyricLine instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Text', instance.text);
  writeNotNull('Start', instance.start);
  return val;
}

LyricMetadata _$LyricMetadataFromJson(Map<String, dynamic> json) =>
    LyricMetadata(
      artist: json['Artist'] as String?,
      album: json['Album'] as String?,
      title: json['Title'] as String?,
      author: json['Author'] as String?,
      length: (json['Length'] as num?)?.toInt(),
      by: json['By'] as String?,
      offset: (json['Offset'] as num?)?.toInt(),
      creator: json['Creator'] as String?,
      version: json['Version'] as String?,
      isSynced: json['IsSynced'] as bool?,
    );

Map<String, dynamic> _$LyricMetadataToJson(LyricMetadata instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Artist', instance.artist);
  writeNotNull('Album', instance.album);
  writeNotNull('Title', instance.title);
  writeNotNull('Author', instance.author);
  writeNotNull('Length', instance.length);
  writeNotNull('By', instance.by);
  writeNotNull('Offset', instance.offset);
  writeNotNull('Creator', instance.creator);
  writeNotNull('Version', instance.version);
  writeNotNull('IsSynced', instance.isSynced);
  return val;
}

MediaAttachment _$MediaAttachmentFromJson(Map<String, dynamic> json) =>
    MediaAttachment(
      codec: json['Codec'] as String?,
      codecTag: json['CodecTag'] as String?,
      comment: json['Comment'] as String?,
      index: (json['Index'] as num?)?.toInt(),
      fileName: json['FileName'] as String?,
      mimeType: json['MimeType'] as String?,
      deliveryUrl: json['DeliveryUrl'] as String?,
    );

Map<String, dynamic> _$MediaAttachmentToJson(MediaAttachment instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Codec', instance.codec);
  writeNotNull('CodecTag', instance.codecTag);
  writeNotNull('Comment', instance.comment);
  writeNotNull('Index', instance.index);
  writeNotNull('FileName', instance.fileName);
  writeNotNull('MimeType', instance.mimeType);
  writeNotNull('DeliveryUrl', instance.deliveryUrl);
  return val;
}

MediaPathDto _$MediaPathDtoFromJson(Map<String, dynamic> json) => MediaPathDto(
      name: json['Name'] as String,
      path: json['Path'] as String?,
      pathInfo: json['PathInfo'] == null
          ? null
          : MediaPathInfo.fromJson(json['PathInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MediaPathDtoToJson(MediaPathDto instance) {
  final val = <String, dynamic>{
    'Name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Path', instance.path);
  writeNotNull('PathInfo', instance.pathInfo?.toJson());
  return val;
}

MediaPathInfo _$MediaPathInfoFromJson(Map<String, dynamic> json) =>
    MediaPathInfo(
      path: json['Path'] as String?,
    );

Map<String, dynamic> _$MediaPathInfoToJson(MediaPathInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Path', instance.path);
  return val;
}

MediaSegmentDto _$MediaSegmentDtoFromJson(Map<String, dynamic> json) =>
    MediaSegmentDto(
      id: json['Id'] as String?,
      itemId: json['ItemId'] as String?,
      type: mediaSegmentTypeNullableFromJson(json['Type']),
      startTicks: (json['StartTicks'] as num?)?.toInt(),
      endTicks: (json['EndTicks'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MediaSegmentDtoToJson(MediaSegmentDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Id', instance.id);
  writeNotNull('ItemId', instance.itemId);
  writeNotNull('Type', mediaSegmentTypeNullableToJson(instance.type));
  writeNotNull('StartTicks', instance.startTicks);
  writeNotNull('EndTicks', instance.endTicks);
  return val;
}

MediaSegmentDtoQueryResult _$MediaSegmentDtoQueryResultFromJson(
        Map<String, dynamic> json) =>
    MediaSegmentDtoQueryResult(
      items: (json['Items'] as List<dynamic>?)
              ?.map((e) => MediaSegmentDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      totalRecordCount: (json['TotalRecordCount'] as num?)?.toInt(),
      startIndex: (json['StartIndex'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MediaSegmentDtoQueryResultToJson(
    MediaSegmentDtoQueryResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Items', instance.items?.map((e) => e.toJson()).toList());
  writeNotNull('TotalRecordCount', instance.totalRecordCount);
  writeNotNull('StartIndex', instance.startIndex);
  return val;
}

MediaSourceInfo _$MediaSourceInfoFromJson(Map<String, dynamic> json) =>
    MediaSourceInfo(
      protocol: mediaProtocolNullableFromJson(json['Protocol']),
      id: json['Id'] as String?,
      path: json['Path'] as String?,
      encoderPath: json['EncoderPath'] as String?,
      encoderProtocol: mediaProtocolNullableFromJson(json['EncoderProtocol']),
      type: mediaSourceTypeNullableFromJson(json['Type']),
      container: json['Container'] as String?,
      size: (json['Size'] as num?)?.toInt(),
      name: json['Name'] as String?,
      isRemote: json['IsRemote'] as bool?,
      eTag: json['ETag'] as String?,
      runTimeTicks: (json['RunTimeTicks'] as num?)?.toInt(),
      readAtNativeFramerate: json['ReadAtNativeFramerate'] as bool?,
      ignoreDts: json['IgnoreDts'] as bool?,
      ignoreIndex: json['IgnoreIndex'] as bool?,
      genPtsInput: json['GenPtsInput'] as bool?,
      supportsTranscoding: json['SupportsTranscoding'] as bool?,
      supportsDirectStream: json['SupportsDirectStream'] as bool?,
      supportsDirectPlay: json['SupportsDirectPlay'] as bool?,
      isInfiniteStream: json['IsInfiniteStream'] as bool?,
      useMostCompatibleTranscodingProfile:
          json['UseMostCompatibleTranscodingProfile'] as bool? ?? false,
      requiresOpening: json['RequiresOpening'] as bool?,
      openToken: json['OpenToken'] as String?,
      requiresClosing: json['RequiresClosing'] as bool?,
      liveStreamId: json['LiveStreamId'] as String?,
      bufferMs: (json['BufferMs'] as num?)?.toInt(),
      requiresLooping: json['RequiresLooping'] as bool?,
      supportsProbing: json['SupportsProbing'] as bool?,
      videoType: videoTypeNullableFromJson(json['VideoType']),
      isoType: isoTypeNullableFromJson(json['IsoType']),
      video3DFormat: video3DFormatNullableFromJson(json['Video3DFormat']),
      mediaStreams: (json['MediaStreams'] as List<dynamic>?)
              ?.map((e) => MediaStream.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      mediaAttachments: (json['MediaAttachments'] as List<dynamic>?)
              ?.map((e) => MediaAttachment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      formats: (json['Formats'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      bitrate: (json['Bitrate'] as num?)?.toInt(),
      fallbackMaxStreamingBitrate:
          (json['FallbackMaxStreamingBitrate'] as num?)?.toInt(),
      timestamp: transportStreamTimestampNullableFromJson(json['Timestamp']),
      requiredHttpHeaders: json['RequiredHttpHeaders'] as Map<String, dynamic>?,
      transcodingUrl: json['TranscodingUrl'] as String?,
      transcodingSubProtocol:
          mediaStreamProtocolNullableFromJson(json['TranscodingSubProtocol']),
      transcodingContainer: json['TranscodingContainer'] as String?,
      analyzeDurationMs: (json['AnalyzeDurationMs'] as num?)?.toInt(),
      defaultAudioStreamIndex:
          (json['DefaultAudioStreamIndex'] as num?)?.toInt(),
      defaultSubtitleStreamIndex:
          (json['DefaultSubtitleStreamIndex'] as num?)?.toInt(),
      hasSegments: json['HasSegments'] as bool?,
    );

Map<String, dynamic> _$MediaSourceInfoToJson(MediaSourceInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Protocol', mediaProtocolNullableToJson(instance.protocol));
  writeNotNull('Id', instance.id);
  writeNotNull('Path', instance.path);
  writeNotNull('EncoderPath', instance.encoderPath);
  writeNotNull(
      'EncoderProtocol', mediaProtocolNullableToJson(instance.encoderProtocol));
  writeNotNull('Type', mediaSourceTypeNullableToJson(instance.type));
  writeNotNull('Container', instance.container);
  writeNotNull('Size', instance.size);
  writeNotNull('Name', instance.name);
  writeNotNull('IsRemote', instance.isRemote);
  writeNotNull('ETag', instance.eTag);
  writeNotNull('RunTimeTicks', instance.runTimeTicks);
  writeNotNull('ReadAtNativeFramerate', instance.readAtNativeFramerate);
  writeNotNull('IgnoreDts', instance.ignoreDts);
  writeNotNull('IgnoreIndex', instance.ignoreIndex);
  writeNotNull('GenPtsInput', instance.genPtsInput);
  writeNotNull('SupportsTranscoding', instance.supportsTranscoding);
  writeNotNull('SupportsDirectStream', instance.supportsDirectStream);
  writeNotNull('SupportsDirectPlay', instance.supportsDirectPlay);
  writeNotNull('IsInfiniteStream', instance.isInfiniteStream);
  writeNotNull('UseMostCompatibleTranscodingProfile',
      instance.useMostCompatibleTranscodingProfile);
  writeNotNull('RequiresOpening', instance.requiresOpening);
  writeNotNull('OpenToken', instance.openToken);
  writeNotNull('RequiresClosing', instance.requiresClosing);
  writeNotNull('LiveStreamId', instance.liveStreamId);
  writeNotNull('BufferMs', instance.bufferMs);
  writeNotNull('RequiresLooping', instance.requiresLooping);
  writeNotNull('SupportsProbing', instance.supportsProbing);
  writeNotNull('VideoType', videoTypeNullableToJson(instance.videoType));
  writeNotNull('IsoType', isoTypeNullableToJson(instance.isoType));
  writeNotNull(
      'Video3DFormat', video3DFormatNullableToJson(instance.video3DFormat));
  writeNotNull(
      'MediaStreams', instance.mediaStreams?.map((e) => e.toJson()).toList());
  writeNotNull('MediaAttachments',
      instance.mediaAttachments?.map((e) => e.toJson()).toList());
  writeNotNull('Formats', instance.formats);
  writeNotNull('Bitrate', instance.bitrate);
  writeNotNull(
      'FallbackMaxStreamingBitrate', instance.fallbackMaxStreamingBitrate);
  writeNotNull(
      'Timestamp', transportStreamTimestampNullableToJson(instance.timestamp));
  writeNotNull('RequiredHttpHeaders', instance.requiredHttpHeaders);
  writeNotNull('TranscodingUrl', instance.transcodingUrl);
  writeNotNull('TranscodingSubProtocol',
      mediaStreamProtocolNullableToJson(instance.transcodingSubProtocol));
  writeNotNull('TranscodingContainer', instance.transcodingContainer);
  writeNotNull('AnalyzeDurationMs', instance.analyzeDurationMs);
  writeNotNull('DefaultAudioStreamIndex', instance.defaultAudioStreamIndex);
  writeNotNull(
      'DefaultSubtitleStreamIndex', instance.defaultSubtitleStreamIndex);
  writeNotNull('HasSegments', instance.hasSegments);
  return val;
}

MediaStream _$MediaStreamFromJson(Map<String, dynamic> json) => MediaStream(
      codec: json['Codec'] as String?,
      codecTag: json['CodecTag'] as String?,
      language: json['Language'] as String?,
      colorRange: json['ColorRange'] as String?,
      colorSpace: json['ColorSpace'] as String?,
      colorTransfer: json['ColorTransfer'] as String?,
      colorPrimaries: json['ColorPrimaries'] as String?,
      dvVersionMajor: (json['DvVersionMajor'] as num?)?.toInt(),
      dvVersionMinor: (json['DvVersionMinor'] as num?)?.toInt(),
      dvProfile: (json['DvProfile'] as num?)?.toInt(),
      dvLevel: (json['DvLevel'] as num?)?.toInt(),
      rpuPresentFlag: (json['RpuPresentFlag'] as num?)?.toInt(),
      elPresentFlag: (json['ElPresentFlag'] as num?)?.toInt(),
      blPresentFlag: (json['BlPresentFlag'] as num?)?.toInt(),
      dvBlSignalCompatibilityId:
          (json['DvBlSignalCompatibilityId'] as num?)?.toInt(),
      rotation: (json['Rotation'] as num?)?.toInt(),
      comment: json['Comment'] as String?,
      timeBase: json['TimeBase'] as String?,
      codecTimeBase: json['CodecTimeBase'] as String?,
      title: json['Title'] as String?,
      videoRange: videoRangeNullableFromJson(json['VideoRange']),
      videoRangeType: videoRangeTypeNullableFromJson(json['VideoRangeType']),
      videoDoViTitle: json['VideoDoViTitle'] as String?,
      audioSpatialFormat:
          MediaStream.audioSpatialFormatAudioSpatialFormatNullableFromJson(
              json['AudioSpatialFormat']),
      localizedUndefined: json['LocalizedUndefined'] as String?,
      localizedDefault: json['LocalizedDefault'] as String?,
      localizedForced: json['LocalizedForced'] as String?,
      localizedExternal: json['LocalizedExternal'] as String?,
      localizedHearingImpaired: json['LocalizedHearingImpaired'] as String?,
      displayTitle: json['DisplayTitle'] as String?,
      nalLengthSize: json['NalLengthSize'] as String?,
      isInterlaced: json['IsInterlaced'] as bool?,
      isAVC: json['IsAVC'] as bool?,
      channelLayout: json['ChannelLayout'] as String?,
      bitRate: (json['BitRate'] as num?)?.toInt(),
      bitDepth: (json['BitDepth'] as num?)?.toInt(),
      refFrames: (json['RefFrames'] as num?)?.toInt(),
      packetLength: (json['PacketLength'] as num?)?.toInt(),
      channels: (json['Channels'] as num?)?.toInt(),
      sampleRate: (json['SampleRate'] as num?)?.toInt(),
      isDefault: json['IsDefault'] as bool?,
      isForced: json['IsForced'] as bool?,
      isHearingImpaired: json['IsHearingImpaired'] as bool?,
      height: (json['Height'] as num?)?.toInt(),
      width: (json['Width'] as num?)?.toInt(),
      averageFrameRate: (json['AverageFrameRate'] as num?)?.toDouble(),
      realFrameRate: (json['RealFrameRate'] as num?)?.toDouble(),
      referenceFrameRate: (json['ReferenceFrameRate'] as num?)?.toDouble(),
      profile: json['Profile'] as String?,
      type: mediaStreamTypeNullableFromJson(json['Type']),
      aspectRatio: json['AspectRatio'] as String?,
      index: (json['Index'] as num?)?.toInt(),
      score: (json['Score'] as num?)?.toInt(),
      isExternal: json['IsExternal'] as bool?,
      deliveryMethod:
          subtitleDeliveryMethodNullableFromJson(json['DeliveryMethod']),
      deliveryUrl: json['DeliveryUrl'] as String?,
      isExternalUrl: json['IsExternalUrl'] as bool?,
      isTextSubtitleStream: json['IsTextSubtitleStream'] as bool?,
      supportsExternalStream: json['SupportsExternalStream'] as bool?,
      path: json['Path'] as String?,
      pixelFormat: json['PixelFormat'] as String?,
      level: (json['Level'] as num?)?.toDouble(),
      isAnamorphic: json['IsAnamorphic'] as bool?,
    );

Map<String, dynamic> _$MediaStreamToJson(MediaStream instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Codec', instance.codec);
  writeNotNull('CodecTag', instance.codecTag);
  writeNotNull('Language', instance.language);
  writeNotNull('ColorRange', instance.colorRange);
  writeNotNull('ColorSpace', instance.colorSpace);
  writeNotNull('ColorTransfer', instance.colorTransfer);
  writeNotNull('ColorPrimaries', instance.colorPrimaries);
  writeNotNull('DvVersionMajor', instance.dvVersionMajor);
  writeNotNull('DvVersionMinor', instance.dvVersionMinor);
  writeNotNull('DvProfile', instance.dvProfile);
  writeNotNull('DvLevel', instance.dvLevel);
  writeNotNull('RpuPresentFlag', instance.rpuPresentFlag);
  writeNotNull('ElPresentFlag', instance.elPresentFlag);
  writeNotNull('BlPresentFlag', instance.blPresentFlag);
  writeNotNull('DvBlSignalCompatibilityId', instance.dvBlSignalCompatibilityId);
  writeNotNull('Rotation', instance.rotation);
  writeNotNull('Comment', instance.comment);
  writeNotNull('TimeBase', instance.timeBase);
  writeNotNull('CodecTimeBase', instance.codecTimeBase);
  writeNotNull('Title', instance.title);
  writeNotNull('VideoRange', videoRangeNullableToJson(instance.videoRange));
  writeNotNull(
      'VideoRangeType', videoRangeTypeNullableToJson(instance.videoRangeType));
  writeNotNull('VideoDoViTitle', instance.videoDoViTitle);
  writeNotNull('AudioSpatialFormat',
      audioSpatialFormatNullableToJson(instance.audioSpatialFormat));
  writeNotNull('LocalizedUndefined', instance.localizedUndefined);
  writeNotNull('LocalizedDefault', instance.localizedDefault);
  writeNotNull('LocalizedForced', instance.localizedForced);
  writeNotNull('LocalizedExternal', instance.localizedExternal);
  writeNotNull('LocalizedHearingImpaired', instance.localizedHearingImpaired);
  writeNotNull('DisplayTitle', instance.displayTitle);
  writeNotNull('NalLengthSize', instance.nalLengthSize);
  writeNotNull('IsInterlaced', instance.isInterlaced);
  writeNotNull('IsAVC', instance.isAVC);
  writeNotNull('ChannelLayout', instance.channelLayout);
  writeNotNull('BitRate', instance.bitRate);
  writeNotNull('BitDepth', instance.bitDepth);
  writeNotNull('RefFrames', instance.refFrames);
  writeNotNull('PacketLength', instance.packetLength);
  writeNotNull('Channels', instance.channels);
  writeNotNull('SampleRate', instance.sampleRate);
  writeNotNull('IsDefault', instance.isDefault);
  writeNotNull('IsForced', instance.isForced);
  writeNotNull('IsHearingImpaired', instance.isHearingImpaired);
  writeNotNull('Height', instance.height);
  writeNotNull('Width', instance.width);
  writeNotNull('AverageFrameRate', instance.averageFrameRate);
  writeNotNull('RealFrameRate', instance.realFrameRate);
  writeNotNull('ReferenceFrameRate', instance.referenceFrameRate);
  writeNotNull('Profile', instance.profile);
  writeNotNull('Type', mediaStreamTypeNullableToJson(instance.type));
  writeNotNull('AspectRatio', instance.aspectRatio);
  writeNotNull('Index', instance.index);
  writeNotNull('Score', instance.score);
  writeNotNull('IsExternal', instance.isExternal);
  writeNotNull('DeliveryMethod',
      subtitleDeliveryMethodNullableToJson(instance.deliveryMethod));
  writeNotNull('DeliveryUrl', instance.deliveryUrl);
  writeNotNull('IsExternalUrl', instance.isExternalUrl);
  writeNotNull('IsTextSubtitleStream', instance.isTextSubtitleStream);
  writeNotNull('SupportsExternalStream', instance.supportsExternalStream);
  writeNotNull('Path', instance.path);
  writeNotNull('PixelFormat', instance.pixelFormat);
  writeNotNull('Level', instance.level);
  writeNotNull('IsAnamorphic', instance.isAnamorphic);
  return val;
}

MediaUpdateInfoDto _$MediaUpdateInfoDtoFromJson(Map<String, dynamic> json) =>
    MediaUpdateInfoDto(
      updates: (json['Updates'] as List<dynamic>?)
              ?.map((e) =>
                  MediaUpdateInfoPathDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$MediaUpdateInfoDtoToJson(MediaUpdateInfoDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Updates', instance.updates?.map((e) => e.toJson()).toList());
  return val;
}

MediaUpdateInfoPathDto _$MediaUpdateInfoPathDtoFromJson(
        Map<String, dynamic> json) =>
    MediaUpdateInfoPathDto(
      path: json['Path'] as String?,
      updateType: json['UpdateType'] as String?,
    );

Map<String, dynamic> _$MediaUpdateInfoPathDtoToJson(
    MediaUpdateInfoPathDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Path', instance.path);
  writeNotNull('UpdateType', instance.updateType);
  return val;
}

MediaUrl _$MediaUrlFromJson(Map<String, dynamic> json) => MediaUrl(
      url: json['Url'] as String?,
      name: json['Name'] as String?,
    );

Map<String, dynamic> _$MediaUrlToJson(MediaUrl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Url', instance.url);
  writeNotNull('Name', instance.name);
  return val;
}

MessageCommand _$MessageCommandFromJson(Map<String, dynamic> json) =>
    MessageCommand(
      header: json['Header'] as String?,
      text: json['Text'] as String,
      timeoutMs: (json['TimeoutMs'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MessageCommandToJson(MessageCommand instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Header', instance.header);
  val['Text'] = instance.text;
  writeNotNull('TimeoutMs', instance.timeoutMs);
  return val;
}

MetadataConfiguration _$MetadataConfigurationFromJson(
        Map<String, dynamic> json) =>
    MetadataConfiguration(
      useFileCreationTimeForDateAdded:
          json['UseFileCreationTimeForDateAdded'] as bool?,
    );

Map<String, dynamic> _$MetadataConfigurationToJson(
    MetadataConfiguration instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('UseFileCreationTimeForDateAdded',
      instance.useFileCreationTimeForDateAdded);
  return val;
}

MetadataEditorInfo _$MetadataEditorInfoFromJson(Map<String, dynamic> json) =>
    MetadataEditorInfo(
      parentalRatingOptions: (json['ParentalRatingOptions'] as List<dynamic>?)
              ?.map((e) => ParentalRating.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      countries: (json['Countries'] as List<dynamic>?)
              ?.map((e) => CountryInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      cultures: (json['Cultures'] as List<dynamic>?)
              ?.map((e) => CultureDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      externalIdInfos: (json['ExternalIdInfos'] as List<dynamic>?)
              ?.map((e) => ExternalIdInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      contentType: collectionTypeNullableFromJson(json['ContentType']),
      contentTypeOptions: (json['ContentTypeOptions'] as List<dynamic>?)
              ?.map((e) => NameValuePair.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$MetadataEditorInfoToJson(MetadataEditorInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ParentalRatingOptions',
      instance.parentalRatingOptions?.map((e) => e.toJson()).toList());
  writeNotNull(
      'Countries', instance.countries?.map((e) => e.toJson()).toList());
  writeNotNull('Cultures', instance.cultures?.map((e) => e.toJson()).toList());
  writeNotNull('ExternalIdInfos',
      instance.externalIdInfos?.map((e) => e.toJson()).toList());
  writeNotNull(
      'ContentType', collectionTypeNullableToJson(instance.contentType));
  writeNotNull('ContentTypeOptions',
      instance.contentTypeOptions?.map((e) => e.toJson()).toList());
  return val;
}

MetadataOptions _$MetadataOptionsFromJson(Map<String, dynamic> json) =>
    MetadataOptions(
      itemType: json['ItemType'] as String?,
      disabledMetadataSavers: (json['DisabledMetadataSavers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      localMetadataReaderOrder:
          (json['LocalMetadataReaderOrder'] as List<dynamic>?)
                  ?.map((e) => e as String)
                  .toList() ??
              [],
      disabledMetadataFetchers:
          (json['DisabledMetadataFetchers'] as List<dynamic>?)
                  ?.map((e) => e as String)
                  .toList() ??
              [],
      metadataFetcherOrder: (json['MetadataFetcherOrder'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      disabledImageFetchers: (json['DisabledImageFetchers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      imageFetcherOrder: (json['ImageFetcherOrder'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$MetadataOptionsToJson(MetadataOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ItemType', instance.itemType);
  writeNotNull('DisabledMetadataSavers', instance.disabledMetadataSavers);
  writeNotNull('LocalMetadataReaderOrder', instance.localMetadataReaderOrder);
  writeNotNull('DisabledMetadataFetchers', instance.disabledMetadataFetchers);
  writeNotNull('MetadataFetcherOrder', instance.metadataFetcherOrder);
  writeNotNull('DisabledImageFetchers', instance.disabledImageFetchers);
  writeNotNull('ImageFetcherOrder', instance.imageFetcherOrder);
  return val;
}

MovePlaylistItemRequestDto _$MovePlaylistItemRequestDtoFromJson(
        Map<String, dynamic> json) =>
    MovePlaylistItemRequestDto(
      playlistItemId: json['PlaylistItemId'] as String?,
      newIndex: (json['NewIndex'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MovePlaylistItemRequestDtoToJson(
    MovePlaylistItemRequestDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('PlaylistItemId', instance.playlistItemId);
  writeNotNull('NewIndex', instance.newIndex);
  return val;
}

MovieInfo _$MovieInfoFromJson(Map<String, dynamic> json) => MovieInfo(
      name: json['Name'] as String?,
      originalTitle: json['OriginalTitle'] as String?,
      path: json['Path'] as String?,
      metadataLanguage: json['MetadataLanguage'] as String?,
      metadataCountryCode: json['MetadataCountryCode'] as String?,
      providerIds: json['ProviderIds'] as Map<String, dynamic>?,
      year: (json['Year'] as num?)?.toInt(),
      indexNumber: (json['IndexNumber'] as num?)?.toInt(),
      parentIndexNumber: (json['ParentIndexNumber'] as num?)?.toInt(),
      premiereDate: json['PremiereDate'] == null
          ? null
          : DateTime.parse(json['PremiereDate'] as String),
      isAutomated: json['IsAutomated'] as bool?,
    );

Map<String, dynamic> _$MovieInfoToJson(MovieInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Name', instance.name);
  writeNotNull('OriginalTitle', instance.originalTitle);
  writeNotNull('Path', instance.path);
  writeNotNull('MetadataLanguage', instance.metadataLanguage);
  writeNotNull('MetadataCountryCode', instance.metadataCountryCode);
  writeNotNull('ProviderIds', instance.providerIds);
  writeNotNull('Year', instance.year);
  writeNotNull('IndexNumber', instance.indexNumber);
  writeNotNull('ParentIndexNumber', instance.parentIndexNumber);
  writeNotNull('PremiereDate', instance.premiereDate?.toIso8601String());
  writeNotNull('IsAutomated', instance.isAutomated);
  return val;
}

MovieInfoRemoteSearchQuery _$MovieInfoRemoteSearchQueryFromJson(
        Map<String, dynamic> json) =>
    MovieInfoRemoteSearchQuery(
      searchInfo: json['SearchInfo'] == null
          ? null
          : MovieInfo.fromJson(json['SearchInfo'] as Map<String, dynamic>),
      itemId: json['ItemId'] as String?,
      searchProviderName: json['SearchProviderName'] as String?,
      includeDisabledProviders: json['IncludeDisabledProviders'] as bool?,
    );

Map<String, dynamic> _$MovieInfoRemoteSearchQueryToJson(
    MovieInfoRemoteSearchQuery instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('SearchInfo', instance.searchInfo?.toJson());
  writeNotNull('ItemId', instance.itemId);
  writeNotNull('SearchProviderName', instance.searchProviderName);
  writeNotNull('IncludeDisabledProviders', instance.includeDisabledProviders);
  return val;
}

MusicVideoInfo _$MusicVideoInfoFromJson(Map<String, dynamic> json) =>
    MusicVideoInfo(
      name: json['Name'] as String?,
      originalTitle: json['OriginalTitle'] as String?,
      path: json['Path'] as String?,
      metadataLanguage: json['MetadataLanguage'] as String?,
      metadataCountryCode: json['MetadataCountryCode'] as String?,
      providerIds: json['ProviderIds'] as Map<String, dynamic>?,
      year: (json['Year'] as num?)?.toInt(),
      indexNumber: (json['IndexNumber'] as num?)?.toInt(),
      parentIndexNumber: (json['ParentIndexNumber'] as num?)?.toInt(),
      premiereDate: json['PremiereDate'] == null
          ? null
          : DateTime.parse(json['PremiereDate'] as String),
      isAutomated: json['IsAutomated'] as bool?,
      artists: (json['Artists'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$MusicVideoInfoToJson(MusicVideoInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Name', instance.name);
  writeNotNull('OriginalTitle', instance.originalTitle);
  writeNotNull('Path', instance.path);
  writeNotNull('MetadataLanguage', instance.metadataLanguage);
  writeNotNull('MetadataCountryCode', instance.metadataCountryCode);
  writeNotNull('ProviderIds', instance.providerIds);
  writeNotNull('Year', instance.year);
  writeNotNull('IndexNumber', instance.indexNumber);
  writeNotNull('ParentIndexNumber', instance.parentIndexNumber);
  writeNotNull('PremiereDate', instance.premiereDate?.toIso8601String());
  writeNotNull('IsAutomated', instance.isAutomated);
  writeNotNull('Artists', instance.artists);
  return val;
}

MusicVideoInfoRemoteSearchQuery _$MusicVideoInfoRemoteSearchQueryFromJson(
        Map<String, dynamic> json) =>
    MusicVideoInfoRemoteSearchQuery(
      searchInfo: json['SearchInfo'] == null
          ? null
          : MusicVideoInfo.fromJson(json['SearchInfo'] as Map<String, dynamic>),
      itemId: json['ItemId'] as String?,
      searchProviderName: json['SearchProviderName'] as String?,
      includeDisabledProviders: json['IncludeDisabledProviders'] as bool?,
    );

Map<String, dynamic> _$MusicVideoInfoRemoteSearchQueryToJson(
    MusicVideoInfoRemoteSearchQuery instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('SearchInfo', instance.searchInfo?.toJson());
  writeNotNull('ItemId', instance.itemId);
  writeNotNull('SearchProviderName', instance.searchProviderName);
  writeNotNull('IncludeDisabledProviders', instance.includeDisabledProviders);
  return val;
}

NameGuidPair _$NameGuidPairFromJson(Map<String, dynamic> json) => NameGuidPair(
      name: json['Name'] as String?,
      id: json['Id'] as String?,
    );

Map<String, dynamic> _$NameGuidPairToJson(NameGuidPair instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Name', instance.name);
  writeNotNull('Id', instance.id);
  return val;
}

NameIdPair _$NameIdPairFromJson(Map<String, dynamic> json) => NameIdPair(
      name: json['Name'] as String?,
      id: json['Id'] as String?,
    );

Map<String, dynamic> _$NameIdPairToJson(NameIdPair instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Name', instance.name);
  writeNotNull('Id', instance.id);
  return val;
}

NameValuePair _$NameValuePairFromJson(Map<String, dynamic> json) =>
    NameValuePair(
      name: json['Name'] as String?,
      $Value: json['Value'] as String?,
    );

Map<String, dynamic> _$NameValuePairToJson(NameValuePair instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Name', instance.name);
  writeNotNull('Value', instance.$Value);
  return val;
}

NetworkConfiguration _$NetworkConfigurationFromJson(
        Map<String, dynamic> json) =>
    NetworkConfiguration(
      baseUrl: json['BaseUrl'] as String?,
      enableHttps: json['EnableHttps'] as bool?,
      requireHttps: json['RequireHttps'] as bool?,
      certificatePath: json['CertificatePath'] as String?,
      certificatePassword: json['CertificatePassword'] as String?,
      internalHttpPort: (json['InternalHttpPort'] as num?)?.toInt(),
      internalHttpsPort: (json['InternalHttpsPort'] as num?)?.toInt(),
      publicHttpPort: (json['PublicHttpPort'] as num?)?.toInt(),
      publicHttpsPort: (json['PublicHttpsPort'] as num?)?.toInt(),
      autoDiscovery: json['AutoDiscovery'] as bool?,
      enableUPnP: json['EnableUPnP'] as bool?,
      enableIPv4: json['EnableIPv4'] as bool?,
      enableIPv6: json['EnableIPv6'] as bool?,
      enableRemoteAccess: json['EnableRemoteAccess'] as bool?,
      localNetworkSubnets: (json['LocalNetworkSubnets'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      localNetworkAddresses: (json['LocalNetworkAddresses'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      knownProxies: (json['KnownProxies'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      ignoreVirtualInterfaces: json['IgnoreVirtualInterfaces'] as bool?,
      virtualInterfaceNames: (json['VirtualInterfaceNames'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      enablePublishedServerUriByRequest:
          json['EnablePublishedServerUriByRequest'] as bool?,
      publishedServerUriBySubnet:
          (json['PublishedServerUriBySubnet'] as List<dynamic>?)
                  ?.map((e) => e as String)
                  .toList() ??
              [],
      remoteIPFilter: (json['RemoteIPFilter'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      isRemoteIPFilterBlacklist: json['IsRemoteIPFilterBlacklist'] as bool?,
    );

Map<String, dynamic> _$NetworkConfigurationToJson(
    NetworkConfiguration instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('BaseUrl', instance.baseUrl);
  writeNotNull('EnableHttps', instance.enableHttps);
  writeNotNull('RequireHttps', instance.requireHttps);
  writeNotNull('CertificatePath', instance.certificatePath);
  writeNotNull('CertificatePassword', instance.certificatePassword);
  writeNotNull('InternalHttpPort', instance.internalHttpPort);
  writeNotNull('InternalHttpsPort', instance.internalHttpsPort);
  writeNotNull('PublicHttpPort', instance.publicHttpPort);
  writeNotNull('PublicHttpsPort', instance.publicHttpsPort);
  writeNotNull('AutoDiscovery', instance.autoDiscovery);
  writeNotNull('EnableUPnP', instance.enableUPnP);
  writeNotNull('EnableIPv4', instance.enableIPv4);
  writeNotNull('EnableIPv6', instance.enableIPv6);
  writeNotNull('EnableRemoteAccess', instance.enableRemoteAccess);
  writeNotNull('LocalNetworkSubnets', instance.localNetworkSubnets);
  writeNotNull('LocalNetworkAddresses', instance.localNetworkAddresses);
  writeNotNull('KnownProxies', instance.knownProxies);
  writeNotNull('IgnoreVirtualInterfaces', instance.ignoreVirtualInterfaces);
  writeNotNull('VirtualInterfaceNames', instance.virtualInterfaceNames);
  writeNotNull('EnablePublishedServerUriByRequest',
      instance.enablePublishedServerUriByRequest);
  writeNotNull(
      'PublishedServerUriBySubnet', instance.publishedServerUriBySubnet);
  writeNotNull('RemoteIPFilter', instance.remoteIPFilter);
  writeNotNull('IsRemoteIPFilterBlacklist', instance.isRemoteIPFilterBlacklist);
  return val;
}

NewGroupRequestDto _$NewGroupRequestDtoFromJson(Map<String, dynamic> json) =>
    NewGroupRequestDto(
      groupName: json['GroupName'] as String?,
    );

Map<String, dynamic> _$NewGroupRequestDtoToJson(NewGroupRequestDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('GroupName', instance.groupName);
  return val;
}

NextItemRequestDto _$NextItemRequestDtoFromJson(Map<String, dynamic> json) =>
    NextItemRequestDto(
      playlistItemId: json['PlaylistItemId'] as String?,
    );

Map<String, dynamic> _$NextItemRequestDtoToJson(NextItemRequestDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('PlaylistItemId', instance.playlistItemId);
  return val;
}

OpenLiveStreamDto _$OpenLiveStreamDtoFromJson(Map<String, dynamic> json) =>
    OpenLiveStreamDto(
      openToken: json['OpenToken'] as String?,
      userId: json['UserId'] as String?,
      playSessionId: json['PlaySessionId'] as String?,
      maxStreamingBitrate: (json['MaxStreamingBitrate'] as num?)?.toInt(),
      startTimeTicks: (json['StartTimeTicks'] as num?)?.toInt(),
      audioStreamIndex: (json['AudioStreamIndex'] as num?)?.toInt(),
      subtitleStreamIndex: (json['SubtitleStreamIndex'] as num?)?.toInt(),
      maxAudioChannels: (json['MaxAudioChannels'] as num?)?.toInt(),
      itemId: json['ItemId'] as String?,
      enableDirectPlay: json['EnableDirectPlay'] as bool?,
      enableDirectStream: json['EnableDirectStream'] as bool?,
      alwaysBurnInSubtitleWhenTranscoding:
          json['AlwaysBurnInSubtitleWhenTranscoding'] as bool?,
      deviceProfile: json['DeviceProfile'] == null
          ? null
          : DeviceProfile.fromJson(
              json['DeviceProfile'] as Map<String, dynamic>),
      directPlayProtocols:
          mediaProtocolListFromJson(json['DirectPlayProtocols'] as List?),
    );

Map<String, dynamic> _$OpenLiveStreamDtoToJson(OpenLiveStreamDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('OpenToken', instance.openToken);
  writeNotNull('UserId', instance.userId);
  writeNotNull('PlaySessionId', instance.playSessionId);
  writeNotNull('MaxStreamingBitrate', instance.maxStreamingBitrate);
  writeNotNull('StartTimeTicks', instance.startTimeTicks);
  writeNotNull('AudioStreamIndex', instance.audioStreamIndex);
  writeNotNull('SubtitleStreamIndex', instance.subtitleStreamIndex);
  writeNotNull('MaxAudioChannels', instance.maxAudioChannels);
  writeNotNull('ItemId', instance.itemId);
  writeNotNull('EnableDirectPlay', instance.enableDirectPlay);
  writeNotNull('EnableDirectStream', instance.enableDirectStream);
  writeNotNull('AlwaysBurnInSubtitleWhenTranscoding',
      instance.alwaysBurnInSubtitleWhenTranscoding);
  writeNotNull('DeviceProfile', instance.deviceProfile?.toJson());
  val['DirectPlayProtocols'] =
      mediaProtocolListToJson(instance.directPlayProtocols);
  return val;
}

OutboundKeepAliveMessage _$OutboundKeepAliveMessageFromJson(
        Map<String, dynamic> json) =>
    OutboundKeepAliveMessage(
      messageId: json['MessageId'] as String?,
      messageType: OutboundKeepAliveMessage
          .sessionMessageTypeMessageTypeNullableFromJson(json['MessageType']),
    );

Map<String, dynamic> _$OutboundKeepAliveMessageToJson(
    OutboundKeepAliveMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('MessageId', instance.messageId);
  writeNotNull(
      'MessageType', sessionMessageTypeNullableToJson(instance.messageType));
  return val;
}

OutboundWebSocketMessage _$OutboundWebSocketMessageFromJson(
        Map<String, dynamic> json) =>
    OutboundWebSocketMessage();

Map<String, dynamic> _$OutboundWebSocketMessageToJson(
        OutboundWebSocketMessage instance) =>
    <String, dynamic>{};

PackageInfo _$PackageInfoFromJson(Map<String, dynamic> json) => PackageInfo(
      name: json['name'] as String?,
      description: json['description'] as String?,
      overview: json['overview'] as String?,
      owner: json['owner'] as String?,
      category: json['category'] as String?,
      guid: json['guid'] as String?,
      versions: (json['versions'] as List<dynamic>?)
              ?.map((e) => VersionInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$PackageInfoToJson(PackageInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('description', instance.description);
  writeNotNull('overview', instance.overview);
  writeNotNull('owner', instance.owner);
  writeNotNull('category', instance.category);
  writeNotNull('guid', instance.guid);
  writeNotNull('versions', instance.versions?.map((e) => e.toJson()).toList());
  writeNotNull('imageUrl', instance.imageUrl);
  return val;
}

ParentalRating _$ParentalRatingFromJson(Map<String, dynamic> json) =>
    ParentalRating(
      name: json['Name'] as String?,
      $Value: (json['Value'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ParentalRatingToJson(ParentalRating instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Name', instance.name);
  writeNotNull('Value', instance.$Value);
  return val;
}

PathSubstitution _$PathSubstitutionFromJson(Map<String, dynamic> json) =>
    PathSubstitution(
      from: json['From'] as String?,
      to: json['To'] as String?,
    );

Map<String, dynamic> _$PathSubstitutionToJson(PathSubstitution instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('From', instance.from);
  writeNotNull('To', instance.to);
  return val;
}

PersonLookupInfo _$PersonLookupInfoFromJson(Map<String, dynamic> json) =>
    PersonLookupInfo(
      name: json['Name'] as String?,
      originalTitle: json['OriginalTitle'] as String?,
      path: json['Path'] as String?,
      metadataLanguage: json['MetadataLanguage'] as String?,
      metadataCountryCode: json['MetadataCountryCode'] as String?,
      providerIds: json['ProviderIds'] as Map<String, dynamic>?,
      year: (json['Year'] as num?)?.toInt(),
      indexNumber: (json['IndexNumber'] as num?)?.toInt(),
      parentIndexNumber: (json['ParentIndexNumber'] as num?)?.toInt(),
      premiereDate: json['PremiereDate'] == null
          ? null
          : DateTime.parse(json['PremiereDate'] as String),
      isAutomated: json['IsAutomated'] as bool?,
    );

Map<String, dynamic> _$PersonLookupInfoToJson(PersonLookupInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Name', instance.name);
  writeNotNull('OriginalTitle', instance.originalTitle);
  writeNotNull('Path', instance.path);
  writeNotNull('MetadataLanguage', instance.metadataLanguage);
  writeNotNull('MetadataCountryCode', instance.metadataCountryCode);
  writeNotNull('ProviderIds', instance.providerIds);
  writeNotNull('Year', instance.year);
  writeNotNull('IndexNumber', instance.indexNumber);
  writeNotNull('ParentIndexNumber', instance.parentIndexNumber);
  writeNotNull('PremiereDate', instance.premiereDate?.toIso8601String());
  writeNotNull('IsAutomated', instance.isAutomated);
  return val;
}

PersonLookupInfoRemoteSearchQuery _$PersonLookupInfoRemoteSearchQueryFromJson(
        Map<String, dynamic> json) =>
    PersonLookupInfoRemoteSearchQuery(
      searchInfo: json['SearchInfo'] == null
          ? null
          : PersonLookupInfo.fromJson(
              json['SearchInfo'] as Map<String, dynamic>),
      itemId: json['ItemId'] as String?,
      searchProviderName: json['SearchProviderName'] as String?,
      includeDisabledProviders: json['IncludeDisabledProviders'] as bool?,
    );

Map<String, dynamic> _$PersonLookupInfoRemoteSearchQueryToJson(
    PersonLookupInfoRemoteSearchQuery instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('SearchInfo', instance.searchInfo?.toJson());
  writeNotNull('ItemId', instance.itemId);
  writeNotNull('SearchProviderName', instance.searchProviderName);
  writeNotNull('IncludeDisabledProviders', instance.includeDisabledProviders);
  return val;
}

PingRequestDto _$PingRequestDtoFromJson(Map<String, dynamic> json) =>
    PingRequestDto(
      ping: (json['Ping'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PingRequestDtoToJson(PingRequestDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Ping', instance.ping);
  return val;
}

PinRedeemResult _$PinRedeemResultFromJson(Map<String, dynamic> json) =>
    PinRedeemResult(
      success: json['Success'] as bool?,
      usersReset: (json['UsersReset'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$PinRedeemResultToJson(PinRedeemResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Success', instance.success);
  writeNotNull('UsersReset', instance.usersReset);
  return val;
}

PlaybackInfoDto _$PlaybackInfoDtoFromJson(Map<String, dynamic> json) =>
    PlaybackInfoDto(
      userId: json['UserId'] as String?,
      maxStreamingBitrate: (json['MaxStreamingBitrate'] as num?)?.toInt(),
      startTimeTicks: (json['StartTimeTicks'] as num?)?.toInt(),
      audioStreamIndex: (json['AudioStreamIndex'] as num?)?.toInt(),
      subtitleStreamIndex: (json['SubtitleStreamIndex'] as num?)?.toInt(),
      maxAudioChannels: (json['MaxAudioChannels'] as num?)?.toInt(),
      mediaSourceId: json['MediaSourceId'] as String?,
      liveStreamId: json['LiveStreamId'] as String?,
      deviceProfile: json['DeviceProfile'] == null
          ? null
          : DeviceProfile.fromJson(
              json['DeviceProfile'] as Map<String, dynamic>),
      enableDirectPlay: json['EnableDirectPlay'] as bool?,
      enableDirectStream: json['EnableDirectStream'] as bool?,
      enableTranscoding: json['EnableTranscoding'] as bool?,
      allowVideoStreamCopy: json['AllowVideoStreamCopy'] as bool?,
      allowAudioStreamCopy: json['AllowAudioStreamCopy'] as bool?,
      autoOpenLiveStream: json['AutoOpenLiveStream'] as bool?,
      alwaysBurnInSubtitleWhenTranscoding:
          json['AlwaysBurnInSubtitleWhenTranscoding'] as bool?,
    );

Map<String, dynamic> _$PlaybackInfoDtoToJson(PlaybackInfoDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('UserId', instance.userId);
  writeNotNull('MaxStreamingBitrate', instance.maxStreamingBitrate);
  writeNotNull('StartTimeTicks', instance.startTimeTicks);
  writeNotNull('AudioStreamIndex', instance.audioStreamIndex);
  writeNotNull('SubtitleStreamIndex', instance.subtitleStreamIndex);
  writeNotNull('MaxAudioChannels', instance.maxAudioChannels);
  writeNotNull('MediaSourceId', instance.mediaSourceId);
  writeNotNull('LiveStreamId', instance.liveStreamId);
  writeNotNull('DeviceProfile', instance.deviceProfile?.toJson());
  writeNotNull('EnableDirectPlay', instance.enableDirectPlay);
  writeNotNull('EnableDirectStream', instance.enableDirectStream);
  writeNotNull('EnableTranscoding', instance.enableTranscoding);
  writeNotNull('AllowVideoStreamCopy', instance.allowVideoStreamCopy);
  writeNotNull('AllowAudioStreamCopy', instance.allowAudioStreamCopy);
  writeNotNull('AutoOpenLiveStream', instance.autoOpenLiveStream);
  writeNotNull('AlwaysBurnInSubtitleWhenTranscoding',
      instance.alwaysBurnInSubtitleWhenTranscoding);
  return val;
}

PlaybackInfoResponse _$PlaybackInfoResponseFromJson(
        Map<String, dynamic> json) =>
    PlaybackInfoResponse(
      mediaSources: (json['MediaSources'] as List<dynamic>?)
              ?.map((e) => MediaSourceInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      playSessionId: json['PlaySessionId'] as String?,
      errorCode: playbackErrorCodeNullableFromJson(json['ErrorCode']),
    );

Map<String, dynamic> _$PlaybackInfoResponseToJson(
    PlaybackInfoResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'MediaSources', instance.mediaSources?.map((e) => e.toJson()).toList());
  writeNotNull('PlaySessionId', instance.playSessionId);
  writeNotNull(
      'ErrorCode', playbackErrorCodeNullableToJson(instance.errorCode));
  return val;
}

PlaybackProgressInfo _$PlaybackProgressInfoFromJson(
        Map<String, dynamic> json) =>
    PlaybackProgressInfo(
      canSeek: json['CanSeek'] as bool?,
      item: json['Item'] == null
          ? null
          : BaseItemDto.fromJson(json['Item'] as Map<String, dynamic>),
      itemId: json['ItemId'] as String?,
      sessionId: json['SessionId'] as String?,
      mediaSourceId: json['MediaSourceId'] as String?,
      audioStreamIndex: (json['AudioStreamIndex'] as num?)?.toInt(),
      subtitleStreamIndex: (json['SubtitleStreamIndex'] as num?)?.toInt(),
      isPaused: json['IsPaused'] as bool?,
      isMuted: json['IsMuted'] as bool?,
      positionTicks: (json['PositionTicks'] as num?)?.toInt(),
      playbackStartTimeTicks: (json['PlaybackStartTimeTicks'] as num?)?.toInt(),
      volumeLevel: (json['VolumeLevel'] as num?)?.toInt(),
      brightness: (json['Brightness'] as num?)?.toInt(),
      aspectRatio: json['AspectRatio'] as String?,
      playMethod: playMethodNullableFromJson(json['PlayMethod']),
      liveStreamId: json['LiveStreamId'] as String?,
      playSessionId: json['PlaySessionId'] as String?,
      repeatMode: repeatModeNullableFromJson(json['RepeatMode']),
      playbackOrder: playbackOrderNullableFromJson(json['PlaybackOrder']),
      nowPlayingQueue: (json['NowPlayingQueue'] as List<dynamic>?)
              ?.map((e) => QueueItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      playlistItemId: json['PlaylistItemId'] as String?,
    );

Map<String, dynamic> _$PlaybackProgressInfoToJson(
    PlaybackProgressInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('CanSeek', instance.canSeek);
  writeNotNull('Item', instance.item?.toJson());
  writeNotNull('ItemId', instance.itemId);
  writeNotNull('SessionId', instance.sessionId);
  writeNotNull('MediaSourceId', instance.mediaSourceId);
  writeNotNull('AudioStreamIndex', instance.audioStreamIndex);
  writeNotNull('SubtitleStreamIndex', instance.subtitleStreamIndex);
  writeNotNull('IsPaused', instance.isPaused);
  writeNotNull('IsMuted', instance.isMuted);
  writeNotNull('PositionTicks', instance.positionTicks);
  writeNotNull('PlaybackStartTimeTicks', instance.playbackStartTimeTicks);
  writeNotNull('VolumeLevel', instance.volumeLevel);
  writeNotNull('Brightness', instance.brightness);
  writeNotNull('AspectRatio', instance.aspectRatio);
  writeNotNull('PlayMethod', playMethodNullableToJson(instance.playMethod));
  writeNotNull('LiveStreamId', instance.liveStreamId);
  writeNotNull('PlaySessionId', instance.playSessionId);
  writeNotNull('RepeatMode', repeatModeNullableToJson(instance.repeatMode));
  writeNotNull(
      'PlaybackOrder', playbackOrderNullableToJson(instance.playbackOrder));
  writeNotNull('NowPlayingQueue',
      instance.nowPlayingQueue?.map((e) => e.toJson()).toList());
  writeNotNull('PlaylistItemId', instance.playlistItemId);
  return val;
}

PlaybackStartInfo _$PlaybackStartInfoFromJson(Map<String, dynamic> json) =>
    PlaybackStartInfo(
      canSeek: json['CanSeek'] as bool?,
      item: json['Item'] == null
          ? null
          : BaseItemDto.fromJson(json['Item'] as Map<String, dynamic>),
      itemId: json['ItemId'] as String?,
      sessionId: json['SessionId'] as String?,
      mediaSourceId: json['MediaSourceId'] as String?,
      audioStreamIndex: (json['AudioStreamIndex'] as num?)?.toInt(),
      subtitleStreamIndex: (json['SubtitleStreamIndex'] as num?)?.toInt(),
      isPaused: json['IsPaused'] as bool?,
      isMuted: json['IsMuted'] as bool?,
      positionTicks: (json['PositionTicks'] as num?)?.toInt(),
      playbackStartTimeTicks: (json['PlaybackStartTimeTicks'] as num?)?.toInt(),
      volumeLevel: (json['VolumeLevel'] as num?)?.toInt(),
      brightness: (json['Brightness'] as num?)?.toInt(),
      aspectRatio: json['AspectRatio'] as String?,
      playMethod: playMethodNullableFromJson(json['PlayMethod']),
      liveStreamId: json['LiveStreamId'] as String?,
      playSessionId: json['PlaySessionId'] as String?,
      repeatMode: repeatModeNullableFromJson(json['RepeatMode']),
      playbackOrder: playbackOrderNullableFromJson(json['PlaybackOrder']),
      nowPlayingQueue: (json['NowPlayingQueue'] as List<dynamic>?)
              ?.map((e) => QueueItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      playlistItemId: json['PlaylistItemId'] as String?,
    );

Map<String, dynamic> _$PlaybackStartInfoToJson(PlaybackStartInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('CanSeek', instance.canSeek);
  writeNotNull('Item', instance.item?.toJson());
  writeNotNull('ItemId', instance.itemId);
  writeNotNull('SessionId', instance.sessionId);
  writeNotNull('MediaSourceId', instance.mediaSourceId);
  writeNotNull('AudioStreamIndex', instance.audioStreamIndex);
  writeNotNull('SubtitleStreamIndex', instance.subtitleStreamIndex);
  writeNotNull('IsPaused', instance.isPaused);
  writeNotNull('IsMuted', instance.isMuted);
  writeNotNull('PositionTicks', instance.positionTicks);
  writeNotNull('PlaybackStartTimeTicks', instance.playbackStartTimeTicks);
  writeNotNull('VolumeLevel', instance.volumeLevel);
  writeNotNull('Brightness', instance.brightness);
  writeNotNull('AspectRatio', instance.aspectRatio);
  writeNotNull('PlayMethod', playMethodNullableToJson(instance.playMethod));
  writeNotNull('LiveStreamId', instance.liveStreamId);
  writeNotNull('PlaySessionId', instance.playSessionId);
  writeNotNull('RepeatMode', repeatModeNullableToJson(instance.repeatMode));
  writeNotNull(
      'PlaybackOrder', playbackOrderNullableToJson(instance.playbackOrder));
  writeNotNull('NowPlayingQueue',
      instance.nowPlayingQueue?.map((e) => e.toJson()).toList());
  writeNotNull('PlaylistItemId', instance.playlistItemId);
  return val;
}

PlaybackStopInfo _$PlaybackStopInfoFromJson(Map<String, dynamic> json) =>
    PlaybackStopInfo(
      item: json['Item'] == null
          ? null
          : BaseItemDto.fromJson(json['Item'] as Map<String, dynamic>),
      itemId: json['ItemId'] as String?,
      sessionId: json['SessionId'] as String?,
      mediaSourceId: json['MediaSourceId'] as String?,
      positionTicks: (json['PositionTicks'] as num?)?.toInt(),
      liveStreamId: json['LiveStreamId'] as String?,
      playSessionId: json['PlaySessionId'] as String?,
      failed: json['Failed'] as bool?,
      nextMediaType: json['NextMediaType'] as String?,
      playlistItemId: json['PlaylistItemId'] as String?,
      nowPlayingQueue: (json['NowPlayingQueue'] as List<dynamic>?)
              ?.map((e) => QueueItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$PlaybackStopInfoToJson(PlaybackStopInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Item', instance.item?.toJson());
  writeNotNull('ItemId', instance.itemId);
  writeNotNull('SessionId', instance.sessionId);
  writeNotNull('MediaSourceId', instance.mediaSourceId);
  writeNotNull('PositionTicks', instance.positionTicks);
  writeNotNull('LiveStreamId', instance.liveStreamId);
  writeNotNull('PlaySessionId', instance.playSessionId);
  writeNotNull('Failed', instance.failed);
  writeNotNull('NextMediaType', instance.nextMediaType);
  writeNotNull('PlaylistItemId', instance.playlistItemId);
  writeNotNull('NowPlayingQueue',
      instance.nowPlayingQueue?.map((e) => e.toJson()).toList());
  return val;
}

PlayerStateInfo _$PlayerStateInfoFromJson(Map<String, dynamic> json) =>
    PlayerStateInfo(
      positionTicks: (json['PositionTicks'] as num?)?.toInt(),
      canSeek: json['CanSeek'] as bool?,
      isPaused: json['IsPaused'] as bool?,
      isMuted: json['IsMuted'] as bool?,
      volumeLevel: (json['VolumeLevel'] as num?)?.toInt(),
      audioStreamIndex: (json['AudioStreamIndex'] as num?)?.toInt(),
      subtitleStreamIndex: (json['SubtitleStreamIndex'] as num?)?.toInt(),
      mediaSourceId: json['MediaSourceId'] as String?,
      playMethod: playMethodNullableFromJson(json['PlayMethod']),
      repeatMode: repeatModeNullableFromJson(json['RepeatMode']),
      playbackOrder: playbackOrderNullableFromJson(json['PlaybackOrder']),
      liveStreamId: json['LiveStreamId'] as String?,
    );

Map<String, dynamic> _$PlayerStateInfoToJson(PlayerStateInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('PositionTicks', instance.positionTicks);
  writeNotNull('CanSeek', instance.canSeek);
  writeNotNull('IsPaused', instance.isPaused);
  writeNotNull('IsMuted', instance.isMuted);
  writeNotNull('VolumeLevel', instance.volumeLevel);
  writeNotNull('AudioStreamIndex', instance.audioStreamIndex);
  writeNotNull('SubtitleStreamIndex', instance.subtitleStreamIndex);
  writeNotNull('MediaSourceId', instance.mediaSourceId);
  writeNotNull('PlayMethod', playMethodNullableToJson(instance.playMethod));
  writeNotNull('RepeatMode', repeatModeNullableToJson(instance.repeatMode));
  writeNotNull(
      'PlaybackOrder', playbackOrderNullableToJson(instance.playbackOrder));
  writeNotNull('LiveStreamId', instance.liveStreamId);
  return val;
}

PlaylistCreationResult _$PlaylistCreationResultFromJson(
        Map<String, dynamic> json) =>
    PlaylistCreationResult(
      id: json['Id'] as String?,
    );

Map<String, dynamic> _$PlaylistCreationResultToJson(
    PlaylistCreationResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Id', instance.id);
  return val;
}

PlaylistDto _$PlaylistDtoFromJson(Map<String, dynamic> json) => PlaylistDto(
      openAccess: json['OpenAccess'] as bool?,
      shares: (json['Shares'] as List<dynamic>?)
              ?.map((e) =>
                  PlaylistUserPermissions.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      itemIds: (json['ItemIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$PlaylistDtoToJson(PlaylistDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('OpenAccess', instance.openAccess);
  writeNotNull('Shares', instance.shares?.map((e) => e.toJson()).toList());
  writeNotNull('ItemIds', instance.itemIds);
  return val;
}

PlaylistUserPermissions _$PlaylistUserPermissionsFromJson(
        Map<String, dynamic> json) =>
    PlaylistUserPermissions(
      userId: json['UserId'] as String?,
      canEdit: json['CanEdit'] as bool?,
    );

Map<String, dynamic> _$PlaylistUserPermissionsToJson(
    PlaylistUserPermissions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('UserId', instance.userId);
  writeNotNull('CanEdit', instance.canEdit);
  return val;
}

PlayMessage _$PlayMessageFromJson(Map<String, dynamic> json) => PlayMessage(
      data: json['Data'] == null
          ? null
          : PlayRequest.fromJson(json['Data'] as Map<String, dynamic>),
      messageId: json['MessageId'] as String?,
      messageType: PlayMessage.sessionMessageTypeMessageTypeNullableFromJson(
          json['MessageType']),
    );

Map<String, dynamic> _$PlayMessageToJson(PlayMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Data', instance.data?.toJson());
  writeNotNull('MessageId', instance.messageId);
  writeNotNull(
      'MessageType', sessionMessageTypeNullableToJson(instance.messageType));
  return val;
}

PlayQueueUpdate _$PlayQueueUpdateFromJson(Map<String, dynamic> json) =>
    PlayQueueUpdate(
      reason: playQueueUpdateReasonNullableFromJson(json['Reason']),
      lastUpdate: json['LastUpdate'] == null
          ? null
          : DateTime.parse(json['LastUpdate'] as String),
      playlist: (json['Playlist'] as List<dynamic>?)
              ?.map(
                  (e) => SyncPlayQueueItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      playingItemIndex: (json['PlayingItemIndex'] as num?)?.toInt(),
      startPositionTicks: (json['StartPositionTicks'] as num?)?.toInt(),
      isPlaying: json['IsPlaying'] as bool?,
      shuffleMode: groupShuffleModeNullableFromJson(json['ShuffleMode']),
      repeatMode: groupRepeatModeNullableFromJson(json['RepeatMode']),
    );

Map<String, dynamic> _$PlayQueueUpdateToJson(PlayQueueUpdate instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Reason', playQueueUpdateReasonNullableToJson(instance.reason));
  writeNotNull('LastUpdate', instance.lastUpdate?.toIso8601String());
  writeNotNull('Playlist', instance.playlist?.map((e) => e.toJson()).toList());
  writeNotNull('PlayingItemIndex', instance.playingItemIndex);
  writeNotNull('StartPositionTicks', instance.startPositionTicks);
  writeNotNull('IsPlaying', instance.isPlaying);
  writeNotNull(
      'ShuffleMode', groupShuffleModeNullableToJson(instance.shuffleMode));
  writeNotNull(
      'RepeatMode', groupRepeatModeNullableToJson(instance.repeatMode));
  return val;
}

PlayQueueUpdateGroupUpdate _$PlayQueueUpdateGroupUpdateFromJson(
        Map<String, dynamic> json) =>
    PlayQueueUpdateGroupUpdate(
      groupId: json['GroupId'] as String?,
      type: groupUpdateTypeNullableFromJson(json['Type']),
      data: json['Data'] == null
          ? null
          : PlayQueueUpdate.fromJson(json['Data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlayQueueUpdateGroupUpdateToJson(
    PlayQueueUpdateGroupUpdate instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('GroupId', instance.groupId);
  writeNotNull('Type', groupUpdateTypeNullableToJson(instance.type));
  writeNotNull('Data', instance.data?.toJson());
  return val;
}

PlayRequest _$PlayRequestFromJson(Map<String, dynamic> json) => PlayRequest(
      itemIds: (json['ItemIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      startPositionTicks: (json['StartPositionTicks'] as num?)?.toInt(),
      playCommand: playCommandNullableFromJson(json['PlayCommand']),
      controllingUserId: json['ControllingUserId'] as String?,
      subtitleStreamIndex: (json['SubtitleStreamIndex'] as num?)?.toInt(),
      audioStreamIndex: (json['AudioStreamIndex'] as num?)?.toInt(),
      mediaSourceId: json['MediaSourceId'] as String?,
      startIndex: (json['StartIndex'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PlayRequestToJson(PlayRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ItemIds', instance.itemIds);
  writeNotNull('StartPositionTicks', instance.startPositionTicks);
  writeNotNull('PlayCommand', playCommandNullableToJson(instance.playCommand));
  writeNotNull('ControllingUserId', instance.controllingUserId);
  writeNotNull('SubtitleStreamIndex', instance.subtitleStreamIndex);
  writeNotNull('AudioStreamIndex', instance.audioStreamIndex);
  writeNotNull('MediaSourceId', instance.mediaSourceId);
  writeNotNull('StartIndex', instance.startIndex);
  return val;
}

PlayRequestDto _$PlayRequestDtoFromJson(Map<String, dynamic> json) =>
    PlayRequestDto(
      playingQueue: (json['PlayingQueue'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      playingItemPosition: (json['PlayingItemPosition'] as num?)?.toInt(),
      startPositionTicks: (json['StartPositionTicks'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PlayRequestDtoToJson(PlayRequestDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('PlayingQueue', instance.playingQueue);
  writeNotNull('PlayingItemPosition', instance.playingItemPosition);
  writeNotNull('StartPositionTicks', instance.startPositionTicks);
  return val;
}

PlaystateMessage _$PlaystateMessageFromJson(Map<String, dynamic> json) =>
    PlaystateMessage(
      data: json['Data'] == null
          ? null
          : PlaystateRequest.fromJson(json['Data'] as Map<String, dynamic>),
      messageId: json['MessageId'] as String?,
      messageType:
          PlaystateMessage.sessionMessageTypeMessageTypeNullableFromJson(
              json['MessageType']),
    );

Map<String, dynamic> _$PlaystateMessageToJson(PlaystateMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Data', instance.data?.toJson());
  writeNotNull('MessageId', instance.messageId);
  writeNotNull(
      'MessageType', sessionMessageTypeNullableToJson(instance.messageType));
  return val;
}

PlaystateRequest _$PlaystateRequestFromJson(Map<String, dynamic> json) =>
    PlaystateRequest(
      command: playstateCommandNullableFromJson(json['Command']),
      seekPositionTicks: (json['SeekPositionTicks'] as num?)?.toInt(),
      controllingUserId: json['ControllingUserId'] as String?,
    );

Map<String, dynamic> _$PlaystateRequestToJson(PlaystateRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Command', playstateCommandNullableToJson(instance.command));
  writeNotNull('SeekPositionTicks', instance.seekPositionTicks);
  writeNotNull('ControllingUserId', instance.controllingUserId);
  return val;
}

PluginInfo _$PluginInfoFromJson(Map<String, dynamic> json) => PluginInfo(
      name: json['Name'] as String?,
      version: json['Version'] as String?,
      configurationFileName: json['ConfigurationFileName'] as String?,
      description: json['Description'] as String?,
      id: json['Id'] as String?,
      canUninstall: json['CanUninstall'] as bool?,
      hasImage: json['HasImage'] as bool?,
      status: pluginStatusNullableFromJson(json['Status']),
    );

Map<String, dynamic> _$PluginInfoToJson(PluginInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Name', instance.name);
  writeNotNull('Version', instance.version);
  writeNotNull('ConfigurationFileName', instance.configurationFileName);
  writeNotNull('Description', instance.description);
  writeNotNull('Id', instance.id);
  writeNotNull('CanUninstall', instance.canUninstall);
  writeNotNull('HasImage', instance.hasImage);
  writeNotNull('Status', pluginStatusNullableToJson(instance.status));
  return val;
}

PluginInstallationCancelledMessage _$PluginInstallationCancelledMessageFromJson(
        Map<String, dynamic> json) =>
    PluginInstallationCancelledMessage(
      data: json['Data'] == null
          ? null
          : InstallationInfo.fromJson(json['Data'] as Map<String, dynamic>),
      messageId: json['MessageId'] as String?,
      messageType: PluginInstallationCancelledMessage
          .sessionMessageTypeMessageTypeNullableFromJson(json['MessageType']),
    );

Map<String, dynamic> _$PluginInstallationCancelledMessageToJson(
    PluginInstallationCancelledMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Data', instance.data?.toJson());
  writeNotNull('MessageId', instance.messageId);
  writeNotNull(
      'MessageType', sessionMessageTypeNullableToJson(instance.messageType));
  return val;
}

PluginInstallationCompletedMessage _$PluginInstallationCompletedMessageFromJson(
        Map<String, dynamic> json) =>
    PluginInstallationCompletedMessage(
      data: json['Data'] == null
          ? null
          : InstallationInfo.fromJson(json['Data'] as Map<String, dynamic>),
      messageId: json['MessageId'] as String?,
      messageType: PluginInstallationCompletedMessage
          .sessionMessageTypeMessageTypeNullableFromJson(json['MessageType']),
    );

Map<String, dynamic> _$PluginInstallationCompletedMessageToJson(
    PluginInstallationCompletedMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Data', instance.data?.toJson());
  writeNotNull('MessageId', instance.messageId);
  writeNotNull(
      'MessageType', sessionMessageTypeNullableToJson(instance.messageType));
  return val;
}

PluginInstallationFailedMessage _$PluginInstallationFailedMessageFromJson(
        Map<String, dynamic> json) =>
    PluginInstallationFailedMessage(
      data: json['Data'] == null
          ? null
          : InstallationInfo.fromJson(json['Data'] as Map<String, dynamic>),
      messageId: json['MessageId'] as String?,
      messageType: PluginInstallationFailedMessage
          .sessionMessageTypeMessageTypeNullableFromJson(json['MessageType']),
    );

Map<String, dynamic> _$PluginInstallationFailedMessageToJson(
    PluginInstallationFailedMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Data', instance.data?.toJson());
  writeNotNull('MessageId', instance.messageId);
  writeNotNull(
      'MessageType', sessionMessageTypeNullableToJson(instance.messageType));
  return val;
}

PluginInstallingMessage _$PluginInstallingMessageFromJson(
        Map<String, dynamic> json) =>
    PluginInstallingMessage(
      data: json['Data'] == null
          ? null
          : InstallationInfo.fromJson(json['Data'] as Map<String, dynamic>),
      messageId: json['MessageId'] as String?,
      messageType:
          PluginInstallingMessage.sessionMessageTypeMessageTypeNullableFromJson(
              json['MessageType']),
    );

Map<String, dynamic> _$PluginInstallingMessageToJson(
    PluginInstallingMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Data', instance.data?.toJson());
  writeNotNull('MessageId', instance.messageId);
  writeNotNull(
      'MessageType', sessionMessageTypeNullableToJson(instance.messageType));
  return val;
}

PluginUninstalledMessage _$PluginUninstalledMessageFromJson(
        Map<String, dynamic> json) =>
    PluginUninstalledMessage(
      data: json['Data'] == null
          ? null
          : PluginInfo.fromJson(json['Data'] as Map<String, dynamic>),
      messageId: json['MessageId'] as String?,
      messageType: PluginUninstalledMessage
          .sessionMessageTypeMessageTypeNullableFromJson(json['MessageType']),
    );

Map<String, dynamic> _$PluginUninstalledMessageToJson(
    PluginUninstalledMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Data', instance.data?.toJson());
  writeNotNull('MessageId', instance.messageId);
  writeNotNull(
      'MessageType', sessionMessageTypeNullableToJson(instance.messageType));
  return val;
}

PreviousItemRequestDto _$PreviousItemRequestDtoFromJson(
        Map<String, dynamic> json) =>
    PreviousItemRequestDto(
      playlistItemId: json['PlaylistItemId'] as String?,
    );

Map<String, dynamic> _$PreviousItemRequestDtoToJson(
    PreviousItemRequestDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('PlaylistItemId', instance.playlistItemId);
  return val;
}

ProblemDetails _$ProblemDetailsFromJson(Map<String, dynamic> json) =>
    ProblemDetails(
      type: json['type'] as String?,
      title: json['title'] as String?,
      status: (json['status'] as num?)?.toInt(),
      detail: json['detail'] as String?,
      instance: json['instance'] as String?,
    );

Map<String, dynamic> _$ProblemDetailsToJson(ProblemDetails instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', instance.type);
  writeNotNull('title', instance.title);
  writeNotNull('status', instance.status);
  writeNotNull('detail', instance.detail);
  writeNotNull('instance', instance.instance);
  return val;
}

ProfileCondition _$ProfileConditionFromJson(Map<String, dynamic> json) =>
    ProfileCondition(
      condition: profileConditionTypeNullableFromJson(json['Condition']),
      property: profileConditionValueNullableFromJson(json['Property']),
      $Value: json['Value'] as String?,
      isRequired: json['IsRequired'] as bool?,
    );

Map<String, dynamic> _$ProfileConditionToJson(ProfileCondition instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'Condition', profileConditionTypeNullableToJson(instance.condition));
  writeNotNull(
      'Property', profileConditionValueNullableToJson(instance.property));
  writeNotNull('Value', instance.$Value);
  writeNotNull('IsRequired', instance.isRequired);
  return val;
}

PublicSystemInfo _$PublicSystemInfoFromJson(Map<String, dynamic> json) =>
    PublicSystemInfo(
      localAddress: json['LocalAddress'] as String?,
      serverName: json['ServerName'] as String?,
      version: json['Version'] as String?,
      productName: json['ProductName'] as String?,
      operatingSystem: json['OperatingSystem'] as String?,
      id: json['Id'] as String?,
      startupWizardCompleted: json['StartupWizardCompleted'] as bool?,
    );

Map<String, dynamic> _$PublicSystemInfoToJson(PublicSystemInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('LocalAddress', instance.localAddress);
  writeNotNull('ServerName', instance.serverName);
  writeNotNull('Version', instance.version);
  writeNotNull('ProductName', instance.productName);
  writeNotNull('OperatingSystem', instance.operatingSystem);
  writeNotNull('Id', instance.id);
  writeNotNull('StartupWizardCompleted', instance.startupWizardCompleted);
  return val;
}

QueryFilters _$QueryFiltersFromJson(Map<String, dynamic> json) => QueryFilters(
      genres: (json['Genres'] as List<dynamic>?)
              ?.map((e) => NameGuidPair.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      tags:
          (json['Tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
    );

Map<String, dynamic> _$QueryFiltersToJson(QueryFilters instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Genres', instance.genres?.map((e) => e.toJson()).toList());
  writeNotNull('Tags', instance.tags);
  return val;
}

QueryFiltersLegacy _$QueryFiltersLegacyFromJson(Map<String, dynamic> json) =>
    QueryFiltersLegacy(
      genres: (json['Genres'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      tags:
          (json['Tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      officialRatings: (json['OfficialRatings'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      years: (json['Years'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          [],
    );

Map<String, dynamic> _$QueryFiltersLegacyToJson(QueryFiltersLegacy instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Genres', instance.genres);
  writeNotNull('Tags', instance.tags);
  writeNotNull('OfficialRatings', instance.officialRatings);
  writeNotNull('Years', instance.years);
  return val;
}

QueueItem _$QueueItemFromJson(Map<String, dynamic> json) => QueueItem(
      id: json['Id'] as String?,
      playlistItemId: json['PlaylistItemId'] as String?,
    );

Map<String, dynamic> _$QueueItemToJson(QueueItem instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Id', instance.id);
  writeNotNull('PlaylistItemId', instance.playlistItemId);
  return val;
}

QueueRequestDto _$QueueRequestDtoFromJson(Map<String, dynamic> json) =>
    QueueRequestDto(
      itemIds: (json['ItemIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      mode: groupQueueModeNullableFromJson(json['Mode']),
    );

Map<String, dynamic> _$QueueRequestDtoToJson(QueueRequestDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ItemIds', instance.itemIds);
  writeNotNull('Mode', groupQueueModeNullableToJson(instance.mode));
  return val;
}

QuickConnectDto _$QuickConnectDtoFromJson(Map<String, dynamic> json) =>
    QuickConnectDto(
      secret: json['Secret'] as String,
    );

Map<String, dynamic> _$QuickConnectDtoToJson(QuickConnectDto instance) =>
    <String, dynamic>{
      'Secret': instance.secret,
    };

QuickConnectResult _$QuickConnectResultFromJson(Map<String, dynamic> json) =>
    QuickConnectResult(
      authenticated: json['Authenticated'] as bool?,
      secret: json['Secret'] as String?,
      code: json['Code'] as String?,
      deviceId: json['DeviceId'] as String?,
      deviceName: json['DeviceName'] as String?,
      appName: json['AppName'] as String?,
      appVersion: json['AppVersion'] as String?,
      dateAdded: json['DateAdded'] == null
          ? null
          : DateTime.parse(json['DateAdded'] as String),
    );

Map<String, dynamic> _$QuickConnectResultToJson(QuickConnectResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Authenticated', instance.authenticated);
  writeNotNull('Secret', instance.secret);
  writeNotNull('Code', instance.code);
  writeNotNull('DeviceId', instance.deviceId);
  writeNotNull('DeviceName', instance.deviceName);
  writeNotNull('AppName', instance.appName);
  writeNotNull('AppVersion', instance.appVersion);
  writeNotNull('DateAdded', instance.dateAdded?.toIso8601String());
  return val;
}

ReadyRequestDto _$ReadyRequestDtoFromJson(Map<String, dynamic> json) =>
    ReadyRequestDto(
      when:
          json['When'] == null ? null : DateTime.parse(json['When'] as String),
      positionTicks: (json['PositionTicks'] as num?)?.toInt(),
      isPlaying: json['IsPlaying'] as bool?,
      playlistItemId: json['PlaylistItemId'] as String?,
    );

Map<String, dynamic> _$ReadyRequestDtoToJson(ReadyRequestDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('When', instance.when?.toIso8601String());
  writeNotNull('PositionTicks', instance.positionTicks);
  writeNotNull('IsPlaying', instance.isPlaying);
  writeNotNull('PlaylistItemId', instance.playlistItemId);
  return val;
}

RecommendationDto _$RecommendationDtoFromJson(Map<String, dynamic> json) =>
    RecommendationDto(
      items: (json['Items'] as List<dynamic>?)
              ?.map((e) => BaseItemDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      recommendationType:
          recommendationTypeNullableFromJson(json['RecommendationType']),
      baselineItemName: json['BaselineItemName'] as String?,
      categoryId: json['CategoryId'] as String?,
    );

Map<String, dynamic> _$RecommendationDtoToJson(RecommendationDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Items', instance.items?.map((e) => e.toJson()).toList());
  writeNotNull('RecommendationType',
      recommendationTypeNullableToJson(instance.recommendationType));
  writeNotNull('BaselineItemName', instance.baselineItemName);
  writeNotNull('CategoryId', instance.categoryId);
  return val;
}

RefreshProgressMessage _$RefreshProgressMessageFromJson(
        Map<String, dynamic> json) =>
    RefreshProgressMessage(
      data: json['Data'] as Map<String, dynamic>?,
      messageId: json['MessageId'] as String?,
      messageType:
          RefreshProgressMessage.sessionMessageTypeMessageTypeNullableFromJson(
              json['MessageType']),
    );

Map<String, dynamic> _$RefreshProgressMessageToJson(
    RefreshProgressMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Data', instance.data);
  writeNotNull('MessageId', instance.messageId);
  writeNotNull(
      'MessageType', sessionMessageTypeNullableToJson(instance.messageType));
  return val;
}

RemoteImageInfo _$RemoteImageInfoFromJson(Map<String, dynamic> json) =>
    RemoteImageInfo(
      providerName: json['ProviderName'] as String?,
      url: json['Url'] as String?,
      thumbnailUrl: json['ThumbnailUrl'] as String?,
      height: (json['Height'] as num?)?.toInt(),
      width: (json['Width'] as num?)?.toInt(),
      communityRating: (json['CommunityRating'] as num?)?.toDouble(),
      voteCount: (json['VoteCount'] as num?)?.toInt(),
      language: json['Language'] as String?,
      type: imageTypeNullableFromJson(json['Type']),
      ratingType: ratingTypeNullableFromJson(json['RatingType']),
    );

Map<String, dynamic> _$RemoteImageInfoToJson(RemoteImageInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ProviderName', instance.providerName);
  writeNotNull('Url', instance.url);
  writeNotNull('ThumbnailUrl', instance.thumbnailUrl);
  writeNotNull('Height', instance.height);
  writeNotNull('Width', instance.width);
  writeNotNull('CommunityRating', instance.communityRating);
  writeNotNull('VoteCount', instance.voteCount);
  writeNotNull('Language', instance.language);
  writeNotNull('Type', imageTypeNullableToJson(instance.type));
  writeNotNull('RatingType', ratingTypeNullableToJson(instance.ratingType));
  return val;
}

RemoteImageResult _$RemoteImageResultFromJson(Map<String, dynamic> json) =>
    RemoteImageResult(
      images: (json['Images'] as List<dynamic>?)
              ?.map((e) => RemoteImageInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      totalRecordCount: (json['TotalRecordCount'] as num?)?.toInt(),
      providers: (json['Providers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$RemoteImageResultToJson(RemoteImageResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Images', instance.images?.map((e) => e.toJson()).toList());
  writeNotNull('TotalRecordCount', instance.totalRecordCount);
  writeNotNull('Providers', instance.providers);
  return val;
}

RemoteLyricInfoDto _$RemoteLyricInfoDtoFromJson(Map<String, dynamic> json) =>
    RemoteLyricInfoDto(
      id: json['Id'] as String?,
      providerName: json['ProviderName'] as String?,
      lyrics: json['Lyrics'] == null
          ? null
          : LyricDto.fromJson(json['Lyrics'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RemoteLyricInfoDtoToJson(RemoteLyricInfoDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Id', instance.id);
  writeNotNull('ProviderName', instance.providerName);
  writeNotNull('Lyrics', instance.lyrics?.toJson());
  return val;
}

RemoteSearchResult _$RemoteSearchResultFromJson(Map<String, dynamic> json) =>
    RemoteSearchResult(
      name: json['Name'] as String?,
      providerIds: json['ProviderIds'] as Map<String, dynamic>?,
      productionYear: (json['ProductionYear'] as num?)?.toInt(),
      indexNumber: (json['IndexNumber'] as num?)?.toInt(),
      indexNumberEnd: (json['IndexNumberEnd'] as num?)?.toInt(),
      parentIndexNumber: (json['ParentIndexNumber'] as num?)?.toInt(),
      premiereDate: json['PremiereDate'] == null
          ? null
          : DateTime.parse(json['PremiereDate'] as String),
      imageUrl: json['ImageUrl'] as String?,
      searchProviderName: json['SearchProviderName'] as String?,
      overview: json['Overview'] as String?,
      albumArtist: json['AlbumArtist'] == null
          ? null
          : RemoteSearchResult.fromJson(
              json['AlbumArtist'] as Map<String, dynamic>),
      artists: (json['Artists'] as List<dynamic>?)
              ?.map(
                  (e) => RemoteSearchResult.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$RemoteSearchResultToJson(RemoteSearchResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Name', instance.name);
  writeNotNull('ProviderIds', instance.providerIds);
  writeNotNull('ProductionYear', instance.productionYear);
  writeNotNull('IndexNumber', instance.indexNumber);
  writeNotNull('IndexNumberEnd', instance.indexNumberEnd);
  writeNotNull('ParentIndexNumber', instance.parentIndexNumber);
  writeNotNull('PremiereDate', instance.premiereDate?.toIso8601String());
  writeNotNull('ImageUrl', instance.imageUrl);
  writeNotNull('SearchProviderName', instance.searchProviderName);
  writeNotNull('Overview', instance.overview);
  writeNotNull('AlbumArtist', instance.albumArtist?.toJson());
  writeNotNull('Artists', instance.artists?.map((e) => e.toJson()).toList());
  return val;
}

RemoteSubtitleInfo _$RemoteSubtitleInfoFromJson(Map<String, dynamic> json) =>
    RemoteSubtitleInfo(
      threeLetterISOLanguageName: json['ThreeLetterISOLanguageName'] as String?,
      id: json['Id'] as String?,
      providerName: json['ProviderName'] as String?,
      name: json['Name'] as String?,
      format: json['Format'] as String?,
      author: json['Author'] as String?,
      comment: json['Comment'] as String?,
      dateCreated: json['DateCreated'] == null
          ? null
          : DateTime.parse(json['DateCreated'] as String),
      communityRating: (json['CommunityRating'] as num?)?.toDouble(),
      frameRate: (json['FrameRate'] as num?)?.toDouble(),
      downloadCount: (json['DownloadCount'] as num?)?.toInt(),
      isHashMatch: json['IsHashMatch'] as bool?,
      aiTranslated: json['AiTranslated'] as bool?,
      machineTranslated: json['MachineTranslated'] as bool?,
      forced: json['Forced'] as bool?,
      hearingImpaired: json['HearingImpaired'] as bool?,
    );

Map<String, dynamic> _$RemoteSubtitleInfoToJson(RemoteSubtitleInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'ThreeLetterISOLanguageName', instance.threeLetterISOLanguageName);
  writeNotNull('Id', instance.id);
  writeNotNull('ProviderName', instance.providerName);
  writeNotNull('Name', instance.name);
  writeNotNull('Format', instance.format);
  writeNotNull('Author', instance.author);
  writeNotNull('Comment', instance.comment);
  writeNotNull('DateCreated', instance.dateCreated?.toIso8601String());
  writeNotNull('CommunityRating', instance.communityRating);
  writeNotNull('FrameRate', instance.frameRate);
  writeNotNull('DownloadCount', instance.downloadCount);
  writeNotNull('IsHashMatch', instance.isHashMatch);
  writeNotNull('AiTranslated', instance.aiTranslated);
  writeNotNull('MachineTranslated', instance.machineTranslated);
  writeNotNull('Forced', instance.forced);
  writeNotNull('HearingImpaired', instance.hearingImpaired);
  return val;
}

RemoveFromPlaylistRequestDto _$RemoveFromPlaylistRequestDtoFromJson(
        Map<String, dynamic> json) =>
    RemoveFromPlaylistRequestDto(
      playlistItemIds: (json['PlaylistItemIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      clearPlaylist: json['ClearPlaylist'] as bool?,
      clearPlayingItem: json['ClearPlayingItem'] as bool?,
    );

Map<String, dynamic> _$RemoveFromPlaylistRequestDtoToJson(
    RemoveFromPlaylistRequestDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('PlaylistItemIds', instance.playlistItemIds);
  writeNotNull('ClearPlaylist', instance.clearPlaylist);
  writeNotNull('ClearPlayingItem', instance.clearPlayingItem);
  return val;
}

RepositoryInfo _$RepositoryInfoFromJson(Map<String, dynamic> json) =>
    RepositoryInfo(
      name: json['Name'] as String?,
      url: json['Url'] as String?,
      enabled: json['Enabled'] as bool?,
    );

Map<String, dynamic> _$RepositoryInfoToJson(RepositoryInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Name', instance.name);
  writeNotNull('Url', instance.url);
  writeNotNull('Enabled', instance.enabled);
  return val;
}

RestartRequiredMessage _$RestartRequiredMessageFromJson(
        Map<String, dynamic> json) =>
    RestartRequiredMessage(
      messageId: json['MessageId'] as String?,
      messageType:
          RestartRequiredMessage.sessionMessageTypeMessageTypeNullableFromJson(
              json['MessageType']),
    );

Map<String, dynamic> _$RestartRequiredMessageToJson(
    RestartRequiredMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('MessageId', instance.messageId);
  writeNotNull(
      'MessageType', sessionMessageTypeNullableToJson(instance.messageType));
  return val;
}

ScheduledTaskEndedMessage _$ScheduledTaskEndedMessageFromJson(
        Map<String, dynamic> json) =>
    ScheduledTaskEndedMessage(
      data: json['Data'] == null
          ? null
          : TaskResult.fromJson(json['Data'] as Map<String, dynamic>),
      messageId: json['MessageId'] as String?,
      messageType: ScheduledTaskEndedMessage
          .sessionMessageTypeMessageTypeNullableFromJson(json['MessageType']),
    );

Map<String, dynamic> _$ScheduledTaskEndedMessageToJson(
    ScheduledTaskEndedMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Data', instance.data?.toJson());
  writeNotNull('MessageId', instance.messageId);
  writeNotNull(
      'MessageType', sessionMessageTypeNullableToJson(instance.messageType));
  return val;
}

ScheduledTasksInfoMessage _$ScheduledTasksInfoMessageFromJson(
        Map<String, dynamic> json) =>
    ScheduledTasksInfoMessage(
      data: (json['Data'] as List<dynamic>?)
              ?.map((e) => TaskInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      messageId: json['MessageId'] as String?,
      messageType: ScheduledTasksInfoMessage
          .sessionMessageTypeMessageTypeNullableFromJson(json['MessageType']),
    );

Map<String, dynamic> _$ScheduledTasksInfoMessageToJson(
    ScheduledTasksInfoMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Data', instance.data?.map((e) => e.toJson()).toList());
  writeNotNull('MessageId', instance.messageId);
  writeNotNull(
      'MessageType', sessionMessageTypeNullableToJson(instance.messageType));
  return val;
}

ScheduledTasksInfoStartMessage _$ScheduledTasksInfoStartMessageFromJson(
        Map<String, dynamic> json) =>
    ScheduledTasksInfoStartMessage(
      data: json['Data'] as String?,
      messageType: ScheduledTasksInfoStartMessage
          .sessionMessageTypeMessageTypeNullableFromJson(json['MessageType']),
    );

Map<String, dynamic> _$ScheduledTasksInfoStartMessageToJson(
    ScheduledTasksInfoStartMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Data', instance.data);
  writeNotNull(
      'MessageType', sessionMessageTypeNullableToJson(instance.messageType));
  return val;
}

ScheduledTasksInfoStopMessage _$ScheduledTasksInfoStopMessageFromJson(
        Map<String, dynamic> json) =>
    ScheduledTasksInfoStopMessage(
      messageType: ScheduledTasksInfoStopMessage
          .sessionMessageTypeMessageTypeNullableFromJson(json['MessageType']),
    );

Map<String, dynamic> _$ScheduledTasksInfoStopMessageToJson(
    ScheduledTasksInfoStopMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'MessageType', sessionMessageTypeNullableToJson(instance.messageType));
  return val;
}

SearchHint _$SearchHintFromJson(Map<String, dynamic> json) => SearchHint(
      itemId: json['ItemId'] as String?,
      id: json['Id'] as String?,
      name: json['Name'] as String?,
      matchedTerm: json['MatchedTerm'] as String?,
      indexNumber: (json['IndexNumber'] as num?)?.toInt(),
      productionYear: (json['ProductionYear'] as num?)?.toInt(),
      parentIndexNumber: (json['ParentIndexNumber'] as num?)?.toInt(),
      primaryImageTag: json['PrimaryImageTag'] as String?,
      thumbImageTag: json['ThumbImageTag'] as String?,
      thumbImageItemId: json['ThumbImageItemId'] as String?,
      backdropImageTag: json['BackdropImageTag'] as String?,
      backdropImageItemId: json['BackdropImageItemId'] as String?,
      type: baseItemKindNullableFromJson(json['Type']),
      isFolder: json['IsFolder'] as bool?,
      runTimeTicks: (json['RunTimeTicks'] as num?)?.toInt(),
      mediaType: mediaTypeNullableFromJson(json['MediaType']),
      startDate: json['StartDate'] == null
          ? null
          : DateTime.parse(json['StartDate'] as String),
      endDate: json['EndDate'] == null
          ? null
          : DateTime.parse(json['EndDate'] as String),
      series: json['Series'] as String?,
      status: json['Status'] as String?,
      album: json['Album'] as String?,
      albumId: json['AlbumId'] as String?,
      albumArtist: json['AlbumArtist'] as String?,
      artists: (json['Artists'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      songCount: (json['SongCount'] as num?)?.toInt(),
      episodeCount: (json['EpisodeCount'] as num?)?.toInt(),
      channelId: json['ChannelId'] as String?,
      channelName: json['ChannelName'] as String?,
      primaryImageAspectRatio:
          (json['PrimaryImageAspectRatio'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$SearchHintToJson(SearchHint instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ItemId', instance.itemId);
  writeNotNull('Id', instance.id);
  writeNotNull('Name', instance.name);
  writeNotNull('MatchedTerm', instance.matchedTerm);
  writeNotNull('IndexNumber', instance.indexNumber);
  writeNotNull('ProductionYear', instance.productionYear);
  writeNotNull('ParentIndexNumber', instance.parentIndexNumber);
  writeNotNull('PrimaryImageTag', instance.primaryImageTag);
  writeNotNull('ThumbImageTag', instance.thumbImageTag);
  writeNotNull('ThumbImageItemId', instance.thumbImageItemId);
  writeNotNull('BackdropImageTag', instance.backdropImageTag);
  writeNotNull('BackdropImageItemId', instance.backdropImageItemId);
  writeNotNull('Type', baseItemKindNullableToJson(instance.type));
  writeNotNull('IsFolder', instance.isFolder);
  writeNotNull('RunTimeTicks', instance.runTimeTicks);
  writeNotNull('MediaType', mediaTypeNullableToJson(instance.mediaType));
  writeNotNull('StartDate', instance.startDate?.toIso8601String());
  writeNotNull('EndDate', instance.endDate?.toIso8601String());
  writeNotNull('Series', instance.series);
  writeNotNull('Status', instance.status);
  writeNotNull('Album', instance.album);
  writeNotNull('AlbumId', instance.albumId);
  writeNotNull('AlbumArtist', instance.albumArtist);
  writeNotNull('Artists', instance.artists);
  writeNotNull('SongCount', instance.songCount);
  writeNotNull('EpisodeCount', instance.episodeCount);
  writeNotNull('ChannelId', instance.channelId);
  writeNotNull('ChannelName', instance.channelName);
  writeNotNull('PrimaryImageAspectRatio', instance.primaryImageAspectRatio);
  return val;
}

SearchHintResult _$SearchHintResultFromJson(Map<String, dynamic> json) =>
    SearchHintResult(
      searchHints: (json['SearchHints'] as List<dynamic>?)
              ?.map((e) => SearchHint.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      totalRecordCount: (json['TotalRecordCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SearchHintResultToJson(SearchHintResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'SearchHints', instance.searchHints?.map((e) => e.toJson()).toList());
  writeNotNull('TotalRecordCount', instance.totalRecordCount);
  return val;
}

SeekRequestDto _$SeekRequestDtoFromJson(Map<String, dynamic> json) =>
    SeekRequestDto(
      positionTicks: (json['PositionTicks'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SeekRequestDtoToJson(SeekRequestDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('PositionTicks', instance.positionTicks);
  return val;
}

SendCommand _$SendCommandFromJson(Map<String, dynamic> json) => SendCommand(
      groupId: json['GroupId'] as String?,
      playlistItemId: json['PlaylistItemId'] as String?,
      when:
          json['When'] == null ? null : DateTime.parse(json['When'] as String),
      positionTicks: (json['PositionTicks'] as num?)?.toInt(),
      command: sendCommandTypeNullableFromJson(json['Command']),
      emittedAt: json['EmittedAt'] == null
          ? null
          : DateTime.parse(json['EmittedAt'] as String),
    );

Map<String, dynamic> _$SendCommandToJson(SendCommand instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('GroupId', instance.groupId);
  writeNotNull('PlaylistItemId', instance.playlistItemId);
  writeNotNull('When', instance.when?.toIso8601String());
  writeNotNull('PositionTicks', instance.positionTicks);
  writeNotNull('Command', sendCommandTypeNullableToJson(instance.command));
  writeNotNull('EmittedAt', instance.emittedAt?.toIso8601String());
  return val;
}

SeriesInfo _$SeriesInfoFromJson(Map<String, dynamic> json) => SeriesInfo(
      name: json['Name'] as String?,
      originalTitle: json['OriginalTitle'] as String?,
      path: json['Path'] as String?,
      metadataLanguage: json['MetadataLanguage'] as String?,
      metadataCountryCode: json['MetadataCountryCode'] as String?,
      providerIds: json['ProviderIds'] as Map<String, dynamic>?,
      year: (json['Year'] as num?)?.toInt(),
      indexNumber: (json['IndexNumber'] as num?)?.toInt(),
      parentIndexNumber: (json['ParentIndexNumber'] as num?)?.toInt(),
      premiereDate: json['PremiereDate'] == null
          ? null
          : DateTime.parse(json['PremiereDate'] as String),
      isAutomated: json['IsAutomated'] as bool?,
    );

Map<String, dynamic> _$SeriesInfoToJson(SeriesInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Name', instance.name);
  writeNotNull('OriginalTitle', instance.originalTitle);
  writeNotNull('Path', instance.path);
  writeNotNull('MetadataLanguage', instance.metadataLanguage);
  writeNotNull('MetadataCountryCode', instance.metadataCountryCode);
  writeNotNull('ProviderIds', instance.providerIds);
  writeNotNull('Year', instance.year);
  writeNotNull('IndexNumber', instance.indexNumber);
  writeNotNull('ParentIndexNumber', instance.parentIndexNumber);
  writeNotNull('PremiereDate', instance.premiereDate?.toIso8601String());
  writeNotNull('IsAutomated', instance.isAutomated);
  return val;
}

SeriesInfoRemoteSearchQuery _$SeriesInfoRemoteSearchQueryFromJson(
        Map<String, dynamic> json) =>
    SeriesInfoRemoteSearchQuery(
      searchInfo: json['SearchInfo'] == null
          ? null
          : SeriesInfo.fromJson(json['SearchInfo'] as Map<String, dynamic>),
      itemId: json['ItemId'] as String?,
      searchProviderName: json['SearchProviderName'] as String?,
      includeDisabledProviders: json['IncludeDisabledProviders'] as bool?,
    );

Map<String, dynamic> _$SeriesInfoRemoteSearchQueryToJson(
    SeriesInfoRemoteSearchQuery instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('SearchInfo', instance.searchInfo?.toJson());
  writeNotNull('ItemId', instance.itemId);
  writeNotNull('SearchProviderName', instance.searchProviderName);
  writeNotNull('IncludeDisabledProviders', instance.includeDisabledProviders);
  return val;
}

SeriesTimerCancelledMessage _$SeriesTimerCancelledMessageFromJson(
        Map<String, dynamic> json) =>
    SeriesTimerCancelledMessage(
      data: json['Data'] == null
          ? null
          : TimerEventInfo.fromJson(json['Data'] as Map<String, dynamic>),
      messageId: json['MessageId'] as String?,
      messageType: SeriesTimerCancelledMessage
          .sessionMessageTypeMessageTypeNullableFromJson(json['MessageType']),
    );

Map<String, dynamic> _$SeriesTimerCancelledMessageToJson(
    SeriesTimerCancelledMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Data', instance.data?.toJson());
  writeNotNull('MessageId', instance.messageId);
  writeNotNull(
      'MessageType', sessionMessageTypeNullableToJson(instance.messageType));
  return val;
}

SeriesTimerCreatedMessage _$SeriesTimerCreatedMessageFromJson(
        Map<String, dynamic> json) =>
    SeriesTimerCreatedMessage(
      data: json['Data'] == null
          ? null
          : TimerEventInfo.fromJson(json['Data'] as Map<String, dynamic>),
      messageId: json['MessageId'] as String?,
      messageType: SeriesTimerCreatedMessage
          .sessionMessageTypeMessageTypeNullableFromJson(json['MessageType']),
    );

Map<String, dynamic> _$SeriesTimerCreatedMessageToJson(
    SeriesTimerCreatedMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Data', instance.data?.toJson());
  writeNotNull('MessageId', instance.messageId);
  writeNotNull(
      'MessageType', sessionMessageTypeNullableToJson(instance.messageType));
  return val;
}

SeriesTimerInfoDto _$SeriesTimerInfoDtoFromJson(Map<String, dynamic> json) =>
    SeriesTimerInfoDto(
      id: json['Id'] as String?,
      type: json['Type'] as String?,
      serverId: json['ServerId'] as String?,
      externalId: json['ExternalId'] as String?,
      channelId: json['ChannelId'] as String?,
      externalChannelId: json['ExternalChannelId'] as String?,
      channelName: json['ChannelName'] as String?,
      channelPrimaryImageTag: json['ChannelPrimaryImageTag'] as String?,
      programId: json['ProgramId'] as String?,
      externalProgramId: json['ExternalProgramId'] as String?,
      name: json['Name'] as String?,
      overview: json['Overview'] as String?,
      startDate: json['StartDate'] == null
          ? null
          : DateTime.parse(json['StartDate'] as String),
      endDate: json['EndDate'] == null
          ? null
          : DateTime.parse(json['EndDate'] as String),
      serviceName: json['ServiceName'] as String?,
      priority: (json['Priority'] as num?)?.toInt(),
      prePaddingSeconds: (json['PrePaddingSeconds'] as num?)?.toInt(),
      postPaddingSeconds: (json['PostPaddingSeconds'] as num?)?.toInt(),
      isPrePaddingRequired: json['IsPrePaddingRequired'] as bool?,
      parentBackdropItemId: json['ParentBackdropItemId'] as String?,
      parentBackdropImageTags:
          (json['ParentBackdropImageTags'] as List<dynamic>?)
                  ?.map((e) => e as String)
                  .toList() ??
              [],
      isPostPaddingRequired: json['IsPostPaddingRequired'] as bool?,
      keepUntil: keepUntilNullableFromJson(json['KeepUntil']),
      recordAnyTime: json['RecordAnyTime'] as bool?,
      skipEpisodesInLibrary: json['SkipEpisodesInLibrary'] as bool?,
      recordAnyChannel: json['RecordAnyChannel'] as bool?,
      keepUpTo: (json['KeepUpTo'] as num?)?.toInt(),
      recordNewOnly: json['RecordNewOnly'] as bool?,
      days: dayOfWeekListFromJson(json['Days'] as List?),
      dayPattern: dayPatternNullableFromJson(json['DayPattern']),
      imageTags: json['ImageTags'] as Map<String, dynamic>?,
      parentThumbItemId: json['ParentThumbItemId'] as String?,
      parentThumbImageTag: json['ParentThumbImageTag'] as String?,
      parentPrimaryImageItemId: json['ParentPrimaryImageItemId'] as String?,
      parentPrimaryImageTag: json['ParentPrimaryImageTag'] as String?,
    );

Map<String, dynamic> _$SeriesTimerInfoDtoToJson(SeriesTimerInfoDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Id', instance.id);
  writeNotNull('Type', instance.type);
  writeNotNull('ServerId', instance.serverId);
  writeNotNull('ExternalId', instance.externalId);
  writeNotNull('ChannelId', instance.channelId);
  writeNotNull('ExternalChannelId', instance.externalChannelId);
  writeNotNull('ChannelName', instance.channelName);
  writeNotNull('ChannelPrimaryImageTag', instance.channelPrimaryImageTag);
  writeNotNull('ProgramId', instance.programId);
  writeNotNull('ExternalProgramId', instance.externalProgramId);
  writeNotNull('Name', instance.name);
  writeNotNull('Overview', instance.overview);
  writeNotNull('StartDate', instance.startDate?.toIso8601String());
  writeNotNull('EndDate', instance.endDate?.toIso8601String());
  writeNotNull('ServiceName', instance.serviceName);
  writeNotNull('Priority', instance.priority);
  writeNotNull('PrePaddingSeconds', instance.prePaddingSeconds);
  writeNotNull('PostPaddingSeconds', instance.postPaddingSeconds);
  writeNotNull('IsPrePaddingRequired', instance.isPrePaddingRequired);
  writeNotNull('ParentBackdropItemId', instance.parentBackdropItemId);
  writeNotNull('ParentBackdropImageTags', instance.parentBackdropImageTags);
  writeNotNull('IsPostPaddingRequired', instance.isPostPaddingRequired);
  writeNotNull('KeepUntil', keepUntilNullableToJson(instance.keepUntil));
  writeNotNull('RecordAnyTime', instance.recordAnyTime);
  writeNotNull('SkipEpisodesInLibrary', instance.skipEpisodesInLibrary);
  writeNotNull('RecordAnyChannel', instance.recordAnyChannel);
  writeNotNull('KeepUpTo', instance.keepUpTo);
  writeNotNull('RecordNewOnly', instance.recordNewOnly);
  val['Days'] = dayOfWeekListToJson(instance.days);
  writeNotNull('DayPattern', dayPatternNullableToJson(instance.dayPattern));
  writeNotNull('ImageTags', instance.imageTags);
  writeNotNull('ParentThumbItemId', instance.parentThumbItemId);
  writeNotNull('ParentThumbImageTag', instance.parentThumbImageTag);
  writeNotNull('ParentPrimaryImageItemId', instance.parentPrimaryImageItemId);
  writeNotNull('ParentPrimaryImageTag', instance.parentPrimaryImageTag);
  return val;
}

SeriesTimerInfoDtoQueryResult _$SeriesTimerInfoDtoQueryResultFromJson(
        Map<String, dynamic> json) =>
    SeriesTimerInfoDtoQueryResult(
      items: (json['Items'] as List<dynamic>?)
              ?.map(
                  (e) => SeriesTimerInfoDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      totalRecordCount: (json['TotalRecordCount'] as num?)?.toInt(),
      startIndex: (json['StartIndex'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SeriesTimerInfoDtoQueryResultToJson(
    SeriesTimerInfoDtoQueryResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Items', instance.items?.map((e) => e.toJson()).toList());
  writeNotNull('TotalRecordCount', instance.totalRecordCount);
  writeNotNull('StartIndex', instance.startIndex);
  return val;
}

ServerConfiguration _$ServerConfigurationFromJson(Map<String, dynamic> json) =>
    ServerConfiguration(
      logFileRetentionDays: (json['LogFileRetentionDays'] as num?)?.toInt(),
      isStartupWizardCompleted: json['IsStartupWizardCompleted'] as bool?,
      cachePath: json['CachePath'] as String?,
      previousVersion: json['PreviousVersion'] as String?,
      previousVersionStr: json['PreviousVersionStr'] as String?,
      enableMetrics: json['EnableMetrics'] as bool?,
      enableNormalizedItemByNameIds:
          json['EnableNormalizedItemByNameIds'] as bool?,
      isPortAuthorized: json['IsPortAuthorized'] as bool?,
      quickConnectAvailable: json['QuickConnectAvailable'] as bool?,
      enableCaseSensitiveItemIds: json['EnableCaseSensitiveItemIds'] as bool?,
      disableLiveTvChannelUserDataName:
          json['DisableLiveTvChannelUserDataName'] as bool?,
      metadataPath: json['MetadataPath'] as String?,
      preferredMetadataLanguage: json['PreferredMetadataLanguage'] as String?,
      metadataCountryCode: json['MetadataCountryCode'] as String?,
      sortReplaceCharacters: (json['SortReplaceCharacters'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      sortRemoveCharacters: (json['SortRemoveCharacters'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      sortRemoveWords: (json['SortRemoveWords'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      minResumePct: (json['MinResumePct'] as num?)?.toInt(),
      maxResumePct: (json['MaxResumePct'] as num?)?.toInt(),
      minResumeDurationSeconds:
          (json['MinResumeDurationSeconds'] as num?)?.toInt(),
      minAudiobookResume: (json['MinAudiobookResume'] as num?)?.toInt(),
      maxAudiobookResume: (json['MaxAudiobookResume'] as num?)?.toInt(),
      inactiveSessionThreshold:
          (json['InactiveSessionThreshold'] as num?)?.toInt(),
      libraryMonitorDelay: (json['LibraryMonitorDelay'] as num?)?.toInt(),
      libraryUpdateDuration: (json['LibraryUpdateDuration'] as num?)?.toInt(),
      imageSavingConvention:
          imageSavingConventionNullableFromJson(json['ImageSavingConvention']),
      metadataOptions: (json['MetadataOptions'] as List<dynamic>?)
              ?.map((e) => MetadataOptions.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      skipDeserializationForBasicTypes:
          json['SkipDeserializationForBasicTypes'] as bool?,
      serverName: json['ServerName'] as String?,
      uICulture: json['UICulture'] as String?,
      saveMetadataHidden: json['SaveMetadataHidden'] as bool?,
      contentTypes: (json['ContentTypes'] as List<dynamic>?)
              ?.map((e) => NameValuePair.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      remoteClientBitrateLimit:
          (json['RemoteClientBitrateLimit'] as num?)?.toInt(),
      enableFolderView: json['EnableFolderView'] as bool?,
      enableGroupingIntoCollections:
          json['EnableGroupingIntoCollections'] as bool?,
      displaySpecialsWithinSeasons:
          json['DisplaySpecialsWithinSeasons'] as bool?,
      codecsUsed: (json['CodecsUsed'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      pluginRepositories: (json['PluginRepositories'] as List<dynamic>?)
              ?.map((e) => RepositoryInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      enableExternalContentInSuggestions:
          json['EnableExternalContentInSuggestions'] as bool?,
      imageExtractionTimeoutMs:
          (json['ImageExtractionTimeoutMs'] as num?)?.toInt(),
      pathSubstitutions: (json['PathSubstitutions'] as List<dynamic>?)
              ?.map((e) => PathSubstitution.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      enableSlowResponseWarning: json['EnableSlowResponseWarning'] as bool?,
      slowResponseThresholdMs:
          (json['SlowResponseThresholdMs'] as num?)?.toInt(),
      corsHosts: (json['CorsHosts'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      activityLogRetentionDays:
          (json['ActivityLogRetentionDays'] as num?)?.toInt(),
      libraryScanFanoutConcurrency:
          (json['LibraryScanFanoutConcurrency'] as num?)?.toInt(),
      libraryMetadataRefreshConcurrency:
          (json['LibraryMetadataRefreshConcurrency'] as num?)?.toInt(),
      removeOldPlugins: json['RemoveOldPlugins'] as bool?,
      allowClientLogUpload: json['AllowClientLogUpload'] as bool?,
      dummyChapterDuration: (json['DummyChapterDuration'] as num?)?.toInt(),
      chapterImageResolution:
          imageResolutionNullableFromJson(json['ChapterImageResolution']),
      parallelImageEncodingLimit:
          (json['ParallelImageEncodingLimit'] as num?)?.toInt(),
      castReceiverApplications: (json['CastReceiverApplications']
                  as List<dynamic>?)
              ?.map((e) =>
                  CastReceiverApplication.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      trickplayOptions: json['TrickplayOptions'] == null
          ? null
          : TrickplayOptions.fromJson(
              json['TrickplayOptions'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ServerConfigurationToJson(ServerConfiguration instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('LogFileRetentionDays', instance.logFileRetentionDays);
  writeNotNull('IsStartupWizardCompleted', instance.isStartupWizardCompleted);
  writeNotNull('CachePath', instance.cachePath);
  writeNotNull('PreviousVersion', instance.previousVersion);
  writeNotNull('PreviousVersionStr', instance.previousVersionStr);
  writeNotNull('EnableMetrics', instance.enableMetrics);
  writeNotNull(
      'EnableNormalizedItemByNameIds', instance.enableNormalizedItemByNameIds);
  writeNotNull('IsPortAuthorized', instance.isPortAuthorized);
  writeNotNull('QuickConnectAvailable', instance.quickConnectAvailable);
  writeNotNull(
      'EnableCaseSensitiveItemIds', instance.enableCaseSensitiveItemIds);
  writeNotNull('DisableLiveTvChannelUserDataName',
      instance.disableLiveTvChannelUserDataName);
  writeNotNull('MetadataPath', instance.metadataPath);
  writeNotNull('PreferredMetadataLanguage', instance.preferredMetadataLanguage);
  writeNotNull('MetadataCountryCode', instance.metadataCountryCode);
  writeNotNull('SortReplaceCharacters', instance.sortReplaceCharacters);
  writeNotNull('SortRemoveCharacters', instance.sortRemoveCharacters);
  writeNotNull('SortRemoveWords', instance.sortRemoveWords);
  writeNotNull('MinResumePct', instance.minResumePct);
  writeNotNull('MaxResumePct', instance.maxResumePct);
  writeNotNull('MinResumeDurationSeconds', instance.minResumeDurationSeconds);
  writeNotNull('MinAudiobookResume', instance.minAudiobookResume);
  writeNotNull('MaxAudiobookResume', instance.maxAudiobookResume);
  writeNotNull('InactiveSessionThreshold', instance.inactiveSessionThreshold);
  writeNotNull('LibraryMonitorDelay', instance.libraryMonitorDelay);
  writeNotNull('LibraryUpdateDuration', instance.libraryUpdateDuration);
  writeNotNull('ImageSavingConvention',
      imageSavingConventionNullableToJson(instance.imageSavingConvention));
  writeNotNull('MetadataOptions',
      instance.metadataOptions?.map((e) => e.toJson()).toList());
  writeNotNull('SkipDeserializationForBasicTypes',
      instance.skipDeserializationForBasicTypes);
  writeNotNull('ServerName', instance.serverName);
  writeNotNull('UICulture', instance.uICulture);
  writeNotNull('SaveMetadataHidden', instance.saveMetadataHidden);
  writeNotNull(
      'ContentTypes', instance.contentTypes?.map((e) => e.toJson()).toList());
  writeNotNull('RemoteClientBitrateLimit', instance.remoteClientBitrateLimit);
  writeNotNull('EnableFolderView', instance.enableFolderView);
  writeNotNull(
      'EnableGroupingIntoCollections', instance.enableGroupingIntoCollections);
  writeNotNull(
      'DisplaySpecialsWithinSeasons', instance.displaySpecialsWithinSeasons);
  writeNotNull('CodecsUsed', instance.codecsUsed);
  writeNotNull('PluginRepositories',
      instance.pluginRepositories?.map((e) => e.toJson()).toList());
  writeNotNull('EnableExternalContentInSuggestions',
      instance.enableExternalContentInSuggestions);
  writeNotNull('ImageExtractionTimeoutMs', instance.imageExtractionTimeoutMs);
  writeNotNull('PathSubstitutions',
      instance.pathSubstitutions?.map((e) => e.toJson()).toList());
  writeNotNull('EnableSlowResponseWarning', instance.enableSlowResponseWarning);
  writeNotNull('SlowResponseThresholdMs', instance.slowResponseThresholdMs);
  writeNotNull('CorsHosts', instance.corsHosts);
  writeNotNull('ActivityLogRetentionDays', instance.activityLogRetentionDays);
  writeNotNull(
      'LibraryScanFanoutConcurrency', instance.libraryScanFanoutConcurrency);
  writeNotNull('LibraryMetadataRefreshConcurrency',
      instance.libraryMetadataRefreshConcurrency);
  writeNotNull('RemoveOldPlugins', instance.removeOldPlugins);
  writeNotNull('AllowClientLogUpload', instance.allowClientLogUpload);
  writeNotNull('DummyChapterDuration', instance.dummyChapterDuration);
  writeNotNull('ChapterImageResolution',
      imageResolutionNullableToJson(instance.chapterImageResolution));
  writeNotNull(
      'ParallelImageEncodingLimit', instance.parallelImageEncodingLimit);
  writeNotNull('CastReceiverApplications',
      instance.castReceiverApplications?.map((e) => e.toJson()).toList());
  writeNotNull('TrickplayOptions', instance.trickplayOptions?.toJson());
  return val;
}

ServerDiscoveryInfo _$ServerDiscoveryInfoFromJson(Map<String, dynamic> json) =>
    ServerDiscoveryInfo(
      address: json['Address'] as String?,
      id: json['Id'] as String?,
      name: json['Name'] as String?,
      endpointAddress: json['EndpointAddress'] as String?,
    );

Map<String, dynamic> _$ServerDiscoveryInfoToJson(ServerDiscoveryInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Address', instance.address);
  writeNotNull('Id', instance.id);
  writeNotNull('Name', instance.name);
  writeNotNull('EndpointAddress', instance.endpointAddress);
  return val;
}

ServerRestartingMessage _$ServerRestartingMessageFromJson(
        Map<String, dynamic> json) =>
    ServerRestartingMessage(
      messageId: json['MessageId'] as String?,
      messageType:
          ServerRestartingMessage.sessionMessageTypeMessageTypeNullableFromJson(
              json['MessageType']),
    );

Map<String, dynamic> _$ServerRestartingMessageToJson(
    ServerRestartingMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('MessageId', instance.messageId);
  writeNotNull(
      'MessageType', sessionMessageTypeNullableToJson(instance.messageType));
  return val;
}

ServerShuttingDownMessage _$ServerShuttingDownMessageFromJson(
        Map<String, dynamic> json) =>
    ServerShuttingDownMessage(
      messageId: json['MessageId'] as String?,
      messageType: ServerShuttingDownMessage
          .sessionMessageTypeMessageTypeNullableFromJson(json['MessageType']),
    );

Map<String, dynamic> _$ServerShuttingDownMessageToJson(
    ServerShuttingDownMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('MessageId', instance.messageId);
  writeNotNull(
      'MessageType', sessionMessageTypeNullableToJson(instance.messageType));
  return val;
}

SessionInfoDto _$SessionInfoDtoFromJson(Map<String, dynamic> json) =>
    SessionInfoDto(
      playState: json['PlayState'] == null
          ? null
          : PlayerStateInfo.fromJson(json['PlayState'] as Map<String, dynamic>),
      additionalUsers: (json['AdditionalUsers'] as List<dynamic>?)
              ?.map((e) => SessionUserInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      capabilities: json['Capabilities'] == null
          ? null
          : ClientCapabilitiesDto.fromJson(
              json['Capabilities'] as Map<String, dynamic>),
      remoteEndPoint: json['RemoteEndPoint'] as String?,
      playableMediaTypes:
          mediaTypeListFromJson(json['PlayableMediaTypes'] as List?),
      id: json['Id'] as String?,
      userId: json['UserId'] as String?,
      userName: json['UserName'] as String?,
      $Client: json['Client'] as String?,
      lastActivityDate: json['LastActivityDate'] == null
          ? null
          : DateTime.parse(json['LastActivityDate'] as String),
      lastPlaybackCheckIn: json['LastPlaybackCheckIn'] == null
          ? null
          : DateTime.parse(json['LastPlaybackCheckIn'] as String),
      lastPausedDate: json['LastPausedDate'] == null
          ? null
          : DateTime.parse(json['LastPausedDate'] as String),
      deviceName: json['DeviceName'] as String?,
      deviceType: json['DeviceType'] as String?,
      nowPlayingItem: json['NowPlayingItem'] == null
          ? null
          : BaseItemDto.fromJson(
              json['NowPlayingItem'] as Map<String, dynamic>),
      nowViewingItem: json['NowViewingItem'] == null
          ? null
          : BaseItemDto.fromJson(
              json['NowViewingItem'] as Map<String, dynamic>),
      deviceId: json['DeviceId'] as String?,
      applicationVersion: json['ApplicationVersion'] as String?,
      transcodingInfo: json['TranscodingInfo'] == null
          ? null
          : TranscodingInfo.fromJson(
              json['TranscodingInfo'] as Map<String, dynamic>),
      isActive: json['IsActive'] as bool?,
      supportsMediaControl: json['SupportsMediaControl'] as bool?,
      supportsRemoteControl: json['SupportsRemoteControl'] as bool?,
      nowPlayingQueue: (json['NowPlayingQueue'] as List<dynamic>?)
              ?.map((e) => QueueItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      nowPlayingQueueFullItems:
          (json['NowPlayingQueueFullItems'] as List<dynamic>?)
                  ?.map((e) => BaseItemDto.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              [],
      hasCustomDeviceName: json['HasCustomDeviceName'] as bool?,
      playlistItemId: json['PlaylistItemId'] as String?,
      serverId: json['ServerId'] as String?,
      userPrimaryImageTag: json['UserPrimaryImageTag'] as String?,
      supportedCommands:
          generalCommandTypeListFromJson(json['SupportedCommands'] as List?),
    );

Map<String, dynamic> _$SessionInfoDtoToJson(SessionInfoDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('PlayState', instance.playState?.toJson());
  writeNotNull('AdditionalUsers',
      instance.additionalUsers?.map((e) => e.toJson()).toList());
  writeNotNull('Capabilities', instance.capabilities?.toJson());
  writeNotNull('RemoteEndPoint', instance.remoteEndPoint);
  val['PlayableMediaTypes'] = mediaTypeListToJson(instance.playableMediaTypes);
  writeNotNull('Id', instance.id);
  writeNotNull('UserId', instance.userId);
  writeNotNull('UserName', instance.userName);
  writeNotNull('Client', instance.$Client);
  writeNotNull(
      'LastActivityDate', instance.lastActivityDate?.toIso8601String());
  writeNotNull(
      'LastPlaybackCheckIn', instance.lastPlaybackCheckIn?.toIso8601String());
  writeNotNull('LastPausedDate', instance.lastPausedDate?.toIso8601String());
  writeNotNull('DeviceName', instance.deviceName);
  writeNotNull('DeviceType', instance.deviceType);
  writeNotNull('NowPlayingItem', instance.nowPlayingItem?.toJson());
  writeNotNull('NowViewingItem', instance.nowViewingItem?.toJson());
  writeNotNull('DeviceId', instance.deviceId);
  writeNotNull('ApplicationVersion', instance.applicationVersion);
  writeNotNull('TranscodingInfo', instance.transcodingInfo?.toJson());
  writeNotNull('IsActive', instance.isActive);
  writeNotNull('SupportsMediaControl', instance.supportsMediaControl);
  writeNotNull('SupportsRemoteControl', instance.supportsRemoteControl);
  writeNotNull('NowPlayingQueue',
      instance.nowPlayingQueue?.map((e) => e.toJson()).toList());
  writeNotNull('NowPlayingQueueFullItems',
      instance.nowPlayingQueueFullItems?.map((e) => e.toJson()).toList());
  writeNotNull('HasCustomDeviceName', instance.hasCustomDeviceName);
  writeNotNull('PlaylistItemId', instance.playlistItemId);
  writeNotNull('ServerId', instance.serverId);
  writeNotNull('UserPrimaryImageTag', instance.userPrimaryImageTag);
  val['SupportedCommands'] =
      generalCommandTypeListToJson(instance.supportedCommands);
  return val;
}

SessionsMessage _$SessionsMessageFromJson(Map<String, dynamic> json) =>
    SessionsMessage(
      data: (json['Data'] as List<dynamic>?)
              ?.map((e) => SessionInfoDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      messageId: json['MessageId'] as String?,
      messageType:
          SessionsMessage.sessionMessageTypeMessageTypeNullableFromJson(
              json['MessageType']),
    );

Map<String, dynamic> _$SessionsMessageToJson(SessionsMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Data', instance.data?.map((e) => e.toJson()).toList());
  writeNotNull('MessageId', instance.messageId);
  writeNotNull(
      'MessageType', sessionMessageTypeNullableToJson(instance.messageType));
  return val;
}

SessionsStartMessage _$SessionsStartMessageFromJson(
        Map<String, dynamic> json) =>
    SessionsStartMessage(
      data: json['Data'] as String?,
      messageType:
          SessionsStartMessage.sessionMessageTypeMessageTypeNullableFromJson(
              json['MessageType']),
    );

Map<String, dynamic> _$SessionsStartMessageToJson(
    SessionsStartMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Data', instance.data);
  writeNotNull(
      'MessageType', sessionMessageTypeNullableToJson(instance.messageType));
  return val;
}

SessionsStopMessage _$SessionsStopMessageFromJson(Map<String, dynamic> json) =>
    SessionsStopMessage(
      messageType:
          SessionsStopMessage.sessionMessageTypeMessageTypeNullableFromJson(
              json['MessageType']),
    );

Map<String, dynamic> _$SessionsStopMessageToJson(SessionsStopMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'MessageType', sessionMessageTypeNullableToJson(instance.messageType));
  return val;
}

SessionUserInfo _$SessionUserInfoFromJson(Map<String, dynamic> json) =>
    SessionUserInfo(
      userId: json['UserId'] as String?,
      userName: json['UserName'] as String?,
    );

Map<String, dynamic> _$SessionUserInfoToJson(SessionUserInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('UserId', instance.userId);
  writeNotNull('UserName', instance.userName);
  return val;
}

SetChannelMappingDto _$SetChannelMappingDtoFromJson(
        Map<String, dynamic> json) =>
    SetChannelMappingDto(
      providerId: json['ProviderId'] as String,
      tunerChannelId: json['TunerChannelId'] as String,
      providerChannelId: json['ProviderChannelId'] as String,
    );

Map<String, dynamic> _$SetChannelMappingDtoToJson(
        SetChannelMappingDto instance) =>
    <String, dynamic>{
      'ProviderId': instance.providerId,
      'TunerChannelId': instance.tunerChannelId,
      'ProviderChannelId': instance.providerChannelId,
    };

SetPlaylistItemRequestDto _$SetPlaylistItemRequestDtoFromJson(
        Map<String, dynamic> json) =>
    SetPlaylistItemRequestDto(
      playlistItemId: json['PlaylistItemId'] as String?,
    );

Map<String, dynamic> _$SetPlaylistItemRequestDtoToJson(
    SetPlaylistItemRequestDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('PlaylistItemId', instance.playlistItemId);
  return val;
}

SetRepeatModeRequestDto _$SetRepeatModeRequestDtoFromJson(
        Map<String, dynamic> json) =>
    SetRepeatModeRequestDto(
      mode: groupRepeatModeNullableFromJson(json['Mode']),
    );

Map<String, dynamic> _$SetRepeatModeRequestDtoToJson(
    SetRepeatModeRequestDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Mode', groupRepeatModeNullableToJson(instance.mode));
  return val;
}

SetShuffleModeRequestDto _$SetShuffleModeRequestDtoFromJson(
        Map<String, dynamic> json) =>
    SetShuffleModeRequestDto(
      mode: groupShuffleModeNullableFromJson(json['Mode']),
    );

Map<String, dynamic> _$SetShuffleModeRequestDtoToJson(
    SetShuffleModeRequestDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Mode', groupShuffleModeNullableToJson(instance.mode));
  return val;
}

SongInfo _$SongInfoFromJson(Map<String, dynamic> json) => SongInfo(
      name: json['Name'] as String?,
      originalTitle: json['OriginalTitle'] as String?,
      path: json['Path'] as String?,
      metadataLanguage: json['MetadataLanguage'] as String?,
      metadataCountryCode: json['MetadataCountryCode'] as String?,
      providerIds: json['ProviderIds'] as Map<String, dynamic>?,
      year: (json['Year'] as num?)?.toInt(),
      indexNumber: (json['IndexNumber'] as num?)?.toInt(),
      parentIndexNumber: (json['ParentIndexNumber'] as num?)?.toInt(),
      premiereDate: json['PremiereDate'] == null
          ? null
          : DateTime.parse(json['PremiereDate'] as String),
      isAutomated: json['IsAutomated'] as bool?,
      albumArtists: (json['AlbumArtists'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      album: json['Album'] as String?,
      artists: (json['Artists'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$SongInfoToJson(SongInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Name', instance.name);
  writeNotNull('OriginalTitle', instance.originalTitle);
  writeNotNull('Path', instance.path);
  writeNotNull('MetadataLanguage', instance.metadataLanguage);
  writeNotNull('MetadataCountryCode', instance.metadataCountryCode);
  writeNotNull('ProviderIds', instance.providerIds);
  writeNotNull('Year', instance.year);
  writeNotNull('IndexNumber', instance.indexNumber);
  writeNotNull('ParentIndexNumber', instance.parentIndexNumber);
  writeNotNull('PremiereDate', instance.premiereDate?.toIso8601String());
  writeNotNull('IsAutomated', instance.isAutomated);
  writeNotNull('AlbumArtists', instance.albumArtists);
  writeNotNull('Album', instance.album);
  writeNotNull('Artists', instance.artists);
  return val;
}

SpecialViewOptionDto _$SpecialViewOptionDtoFromJson(
        Map<String, dynamic> json) =>
    SpecialViewOptionDto(
      name: json['Name'] as String?,
      id: json['Id'] as String?,
    );

Map<String, dynamic> _$SpecialViewOptionDtoToJson(
    SpecialViewOptionDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Name', instance.name);
  writeNotNull('Id', instance.id);
  return val;
}

StartupConfigurationDto _$StartupConfigurationDtoFromJson(
        Map<String, dynamic> json) =>
    StartupConfigurationDto(
      uICulture: json['UICulture'] as String?,
      metadataCountryCode: json['MetadataCountryCode'] as String?,
      preferredMetadataLanguage: json['PreferredMetadataLanguage'] as String?,
    );

Map<String, dynamic> _$StartupConfigurationDtoToJson(
    StartupConfigurationDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('UICulture', instance.uICulture);
  writeNotNull('MetadataCountryCode', instance.metadataCountryCode);
  writeNotNull('PreferredMetadataLanguage', instance.preferredMetadataLanguage);
  return val;
}

StartupRemoteAccessDto _$StartupRemoteAccessDtoFromJson(
        Map<String, dynamic> json) =>
    StartupRemoteAccessDto(
      enableRemoteAccess: json['EnableRemoteAccess'] as bool,
      enableAutomaticPortMapping: json['EnableAutomaticPortMapping'] as bool,
    );

Map<String, dynamic> _$StartupRemoteAccessDtoToJson(
        StartupRemoteAccessDto instance) =>
    <String, dynamic>{
      'EnableRemoteAccess': instance.enableRemoteAccess,
      'EnableAutomaticPortMapping': instance.enableAutomaticPortMapping,
    };

StartupUserDto _$StartupUserDtoFromJson(Map<String, dynamic> json) =>
    StartupUserDto(
      name: json['Name'] as String?,
      password: json['Password'] as String?,
    );

Map<String, dynamic> _$StartupUserDtoToJson(StartupUserDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Name', instance.name);
  writeNotNull('Password', instance.password);
  return val;
}

StringGroupUpdate _$StringGroupUpdateFromJson(Map<String, dynamic> json) =>
    StringGroupUpdate(
      groupId: json['GroupId'] as String?,
      type: groupUpdateTypeNullableFromJson(json['Type']),
      data: json['Data'] as String?,
    );

Map<String, dynamic> _$StringGroupUpdateToJson(StringGroupUpdate instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('GroupId', instance.groupId);
  writeNotNull('Type', groupUpdateTypeNullableToJson(instance.type));
  writeNotNull('Data', instance.data);
  return val;
}

SubtitleOptions _$SubtitleOptionsFromJson(Map<String, dynamic> json) =>
    SubtitleOptions(
      skipIfEmbeddedSubtitlesPresent:
          json['SkipIfEmbeddedSubtitlesPresent'] as bool?,
      skipIfAudioTrackMatches: json['SkipIfAudioTrackMatches'] as bool?,
      downloadLanguages: (json['DownloadLanguages'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      downloadMovieSubtitles: json['DownloadMovieSubtitles'] as bool?,
      downloadEpisodeSubtitles: json['DownloadEpisodeSubtitles'] as bool?,
      openSubtitlesUsername: json['OpenSubtitlesUsername'] as String?,
      openSubtitlesPasswordHash: json['OpenSubtitlesPasswordHash'] as String?,
      isOpenSubtitleVipAccount: json['IsOpenSubtitleVipAccount'] as bool?,
      requirePerfectMatch: json['RequirePerfectMatch'] as bool?,
    );

Map<String, dynamic> _$SubtitleOptionsToJson(SubtitleOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('SkipIfEmbeddedSubtitlesPresent',
      instance.skipIfEmbeddedSubtitlesPresent);
  writeNotNull('SkipIfAudioTrackMatches', instance.skipIfAudioTrackMatches);
  writeNotNull('DownloadLanguages', instance.downloadLanguages);
  writeNotNull('DownloadMovieSubtitles', instance.downloadMovieSubtitles);
  writeNotNull('DownloadEpisodeSubtitles', instance.downloadEpisodeSubtitles);
  writeNotNull('OpenSubtitlesUsername', instance.openSubtitlesUsername);
  writeNotNull('OpenSubtitlesPasswordHash', instance.openSubtitlesPasswordHash);
  writeNotNull('IsOpenSubtitleVipAccount', instance.isOpenSubtitleVipAccount);
  writeNotNull('RequirePerfectMatch', instance.requirePerfectMatch);
  return val;
}

SubtitleProfile _$SubtitleProfileFromJson(Map<String, dynamic> json) =>
    SubtitleProfile(
      format: json['Format'] as String?,
      method: subtitleDeliveryMethodNullableFromJson(json['Method']),
      didlMode: json['DidlMode'] as String?,
      language: json['Language'] as String?,
      container: json['Container'] as String?,
    );

Map<String, dynamic> _$SubtitleProfileToJson(SubtitleProfile instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Format', instance.format);
  writeNotNull('Method', subtitleDeliveryMethodNullableToJson(instance.method));
  writeNotNull('DidlMode', instance.didlMode);
  writeNotNull('Language', instance.language);
  writeNotNull('Container', instance.container);
  return val;
}

SyncPlayCommandMessage _$SyncPlayCommandMessageFromJson(
        Map<String, dynamic> json) =>
    SyncPlayCommandMessage(
      data: json['Data'] == null
          ? null
          : SendCommand.fromJson(json['Data'] as Map<String, dynamic>),
      messageId: json['MessageId'] as String?,
      messageType:
          SyncPlayCommandMessage.sessionMessageTypeMessageTypeNullableFromJson(
              json['MessageType']),
    );

Map<String, dynamic> _$SyncPlayCommandMessageToJson(
    SyncPlayCommandMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Data', instance.data?.toJson());
  writeNotNull('MessageId', instance.messageId);
  writeNotNull(
      'MessageType', sessionMessageTypeNullableToJson(instance.messageType));
  return val;
}

SyncPlayGroupUpdateCommandMessage _$SyncPlayGroupUpdateCommandMessageFromJson(
        Map<String, dynamic> json) =>
    SyncPlayGroupUpdateCommandMessage(
      data: json['Data'] == null
          ? null
          : GroupUpdate.fromJson(json['Data'] as Map<String, dynamic>),
      messageId: json['MessageId'] as String?,
      messageType: SyncPlayGroupUpdateCommandMessage
          .sessionMessageTypeMessageTypeNullableFromJson(json['MessageType']),
    );

Map<String, dynamic> _$SyncPlayGroupUpdateCommandMessageToJson(
    SyncPlayGroupUpdateCommandMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Data', instance.data?.toJson());
  writeNotNull('MessageId', instance.messageId);
  writeNotNull(
      'MessageType', sessionMessageTypeNullableToJson(instance.messageType));
  return val;
}

SyncPlayQueueItem _$SyncPlayQueueItemFromJson(Map<String, dynamic> json) =>
    SyncPlayQueueItem(
      itemId: json['ItemId'] as String?,
      playlistItemId: json['PlaylistItemId'] as String?,
    );

Map<String, dynamic> _$SyncPlayQueueItemToJson(SyncPlayQueueItem instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ItemId', instance.itemId);
  writeNotNull('PlaylistItemId', instance.playlistItemId);
  return val;
}

SystemInfo _$SystemInfoFromJson(Map<String, dynamic> json) => SystemInfo(
      localAddress: json['LocalAddress'] as String?,
      serverName: json['ServerName'] as String?,
      version: json['Version'] as String?,
      productName: json['ProductName'] as String?,
      operatingSystem: json['OperatingSystem'] as String?,
      id: json['Id'] as String?,
      startupWizardCompleted: json['StartupWizardCompleted'] as bool?,
      operatingSystemDisplayName: json['OperatingSystemDisplayName'] as String?,
      packageName: json['PackageName'] as String?,
      hasPendingRestart: json['HasPendingRestart'] as bool?,
      isShuttingDown: json['IsShuttingDown'] as bool?,
      supportsLibraryMonitor: json['SupportsLibraryMonitor'] as bool?,
      webSocketPortNumber: (json['WebSocketPortNumber'] as num?)?.toInt(),
      completedInstallations: (json['CompletedInstallations'] as List<dynamic>?)
              ?.map((e) => InstallationInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      canSelfRestart: json['CanSelfRestart'] as bool? ?? true,
      canLaunchWebBrowser: json['CanLaunchWebBrowser'] as bool? ?? false,
      programDataPath: json['ProgramDataPath'] as String?,
      webPath: json['WebPath'] as String?,
      itemsByNamePath: json['ItemsByNamePath'] as String?,
      cachePath: json['CachePath'] as String?,
      logPath: json['LogPath'] as String?,
      internalMetadataPath: json['InternalMetadataPath'] as String?,
      transcodingTempPath: json['TranscodingTempPath'] as String?,
      castReceiverApplications: (json['CastReceiverApplications']
                  as List<dynamic>?)
              ?.map((e) =>
                  CastReceiverApplication.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      hasUpdateAvailable: json['HasUpdateAvailable'] as bool? ?? false,
      encoderLocation: json['EncoderLocation'] as String?,
      systemArchitecture: json['SystemArchitecture'] as String?,
    );

Map<String, dynamic> _$SystemInfoToJson(SystemInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('LocalAddress', instance.localAddress);
  writeNotNull('ServerName', instance.serverName);
  writeNotNull('Version', instance.version);
  writeNotNull('ProductName', instance.productName);
  writeNotNull('OperatingSystem', instance.operatingSystem);
  writeNotNull('Id', instance.id);
  writeNotNull('StartupWizardCompleted', instance.startupWizardCompleted);
  writeNotNull(
      'OperatingSystemDisplayName', instance.operatingSystemDisplayName);
  writeNotNull('PackageName', instance.packageName);
  writeNotNull('HasPendingRestart', instance.hasPendingRestart);
  writeNotNull('IsShuttingDown', instance.isShuttingDown);
  writeNotNull('SupportsLibraryMonitor', instance.supportsLibraryMonitor);
  writeNotNull('WebSocketPortNumber', instance.webSocketPortNumber);
  writeNotNull('CompletedInstallations',
      instance.completedInstallations?.map((e) => e.toJson()).toList());
  writeNotNull('CanSelfRestart', instance.canSelfRestart);
  writeNotNull('CanLaunchWebBrowser', instance.canLaunchWebBrowser);
  writeNotNull('ProgramDataPath', instance.programDataPath);
  writeNotNull('WebPath', instance.webPath);
  writeNotNull('ItemsByNamePath', instance.itemsByNamePath);
  writeNotNull('CachePath', instance.cachePath);
  writeNotNull('LogPath', instance.logPath);
  writeNotNull('InternalMetadataPath', instance.internalMetadataPath);
  writeNotNull('TranscodingTempPath', instance.transcodingTempPath);
  writeNotNull('CastReceiverApplications',
      instance.castReceiverApplications?.map((e) => e.toJson()).toList());
  writeNotNull('HasUpdateAvailable', instance.hasUpdateAvailable);
  writeNotNull('EncoderLocation', instance.encoderLocation);
  writeNotNull('SystemArchitecture', instance.systemArchitecture);
  return val;
}

TaskInfo _$TaskInfoFromJson(Map<String, dynamic> json) => TaskInfo(
      name: json['Name'] as String?,
      state: taskStateNullableFromJson(json['State']),
      currentProgressPercentage:
          (json['CurrentProgressPercentage'] as num?)?.toDouble(),
      id: json['Id'] as String?,
      lastExecutionResult: json['LastExecutionResult'] == null
          ? null
          : TaskResult.fromJson(
              json['LastExecutionResult'] as Map<String, dynamic>),
      triggers: (json['Triggers'] as List<dynamic>?)
              ?.map((e) => TaskTriggerInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      description: json['Description'] as String?,
      category: json['Category'] as String?,
      isHidden: json['IsHidden'] as bool?,
      key: json['Key'] as String?,
    );

Map<String, dynamic> _$TaskInfoToJson(TaskInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Name', instance.name);
  writeNotNull('State', taskStateNullableToJson(instance.state));
  writeNotNull('CurrentProgressPercentage', instance.currentProgressPercentage);
  writeNotNull('Id', instance.id);
  writeNotNull('LastExecutionResult', instance.lastExecutionResult?.toJson());
  writeNotNull('Triggers', instance.triggers?.map((e) => e.toJson()).toList());
  writeNotNull('Description', instance.description);
  writeNotNull('Category', instance.category);
  writeNotNull('IsHidden', instance.isHidden);
  writeNotNull('Key', instance.key);
  return val;
}

TaskResult _$TaskResultFromJson(Map<String, dynamic> json) => TaskResult(
      startTimeUtc: json['StartTimeUtc'] == null
          ? null
          : DateTime.parse(json['StartTimeUtc'] as String),
      endTimeUtc: json['EndTimeUtc'] == null
          ? null
          : DateTime.parse(json['EndTimeUtc'] as String),
      status: taskCompletionStatusNullableFromJson(json['Status']),
      name: json['Name'] as String?,
      key: json['Key'] as String?,
      id: json['Id'] as String?,
      errorMessage: json['ErrorMessage'] as String?,
      longErrorMessage: json['LongErrorMessage'] as String?,
    );

Map<String, dynamic> _$TaskResultToJson(TaskResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('StartTimeUtc', instance.startTimeUtc?.toIso8601String());
  writeNotNull('EndTimeUtc', instance.endTimeUtc?.toIso8601String());
  writeNotNull('Status', taskCompletionStatusNullableToJson(instance.status));
  writeNotNull('Name', instance.name);
  writeNotNull('Key', instance.key);
  writeNotNull('Id', instance.id);
  writeNotNull('ErrorMessage', instance.errorMessage);
  writeNotNull('LongErrorMessage', instance.longErrorMessage);
  return val;
}

TaskTriggerInfo _$TaskTriggerInfoFromJson(Map<String, dynamic> json) =>
    TaskTriggerInfo(
      type: json['Type'] as String?,
      timeOfDayTicks: (json['TimeOfDayTicks'] as num?)?.toInt(),
      intervalTicks: (json['IntervalTicks'] as num?)?.toInt(),
      dayOfWeek: dayOfWeekNullableFromJson(json['DayOfWeek']),
      maxRuntimeTicks: (json['MaxRuntimeTicks'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TaskTriggerInfoToJson(TaskTriggerInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Type', instance.type);
  writeNotNull('TimeOfDayTicks', instance.timeOfDayTicks);
  writeNotNull('IntervalTicks', instance.intervalTicks);
  writeNotNull('DayOfWeek', dayOfWeekNullableToJson(instance.dayOfWeek));
  writeNotNull('MaxRuntimeTicks', instance.maxRuntimeTicks);
  return val;
}

ThemeMediaResult _$ThemeMediaResultFromJson(Map<String, dynamic> json) =>
    ThemeMediaResult(
      items: (json['Items'] as List<dynamic>?)
              ?.map((e) => BaseItemDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      totalRecordCount: (json['TotalRecordCount'] as num?)?.toInt(),
      startIndex: (json['StartIndex'] as num?)?.toInt(),
      ownerId: json['OwnerId'] as String?,
    );

Map<String, dynamic> _$ThemeMediaResultToJson(ThemeMediaResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Items', instance.items?.map((e) => e.toJson()).toList());
  writeNotNull('TotalRecordCount', instance.totalRecordCount);
  writeNotNull('StartIndex', instance.startIndex);
  writeNotNull('OwnerId', instance.ownerId);
  return val;
}

TimerCancelledMessage _$TimerCancelledMessageFromJson(
        Map<String, dynamic> json) =>
    TimerCancelledMessage(
      data: json['Data'] == null
          ? null
          : TimerEventInfo.fromJson(json['Data'] as Map<String, dynamic>),
      messageId: json['MessageId'] as String?,
      messageType:
          TimerCancelledMessage.sessionMessageTypeMessageTypeNullableFromJson(
              json['MessageType']),
    );

Map<String, dynamic> _$TimerCancelledMessageToJson(
    TimerCancelledMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Data', instance.data?.toJson());
  writeNotNull('MessageId', instance.messageId);
  writeNotNull(
      'MessageType', sessionMessageTypeNullableToJson(instance.messageType));
  return val;
}

TimerCreatedMessage _$TimerCreatedMessageFromJson(Map<String, dynamic> json) =>
    TimerCreatedMessage(
      data: json['Data'] == null
          ? null
          : TimerEventInfo.fromJson(json['Data'] as Map<String, dynamic>),
      messageId: json['MessageId'] as String?,
      messageType:
          TimerCreatedMessage.sessionMessageTypeMessageTypeNullableFromJson(
              json['MessageType']),
    );

Map<String, dynamic> _$TimerCreatedMessageToJson(TimerCreatedMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Data', instance.data?.toJson());
  writeNotNull('MessageId', instance.messageId);
  writeNotNull(
      'MessageType', sessionMessageTypeNullableToJson(instance.messageType));
  return val;
}

TimerEventInfo _$TimerEventInfoFromJson(Map<String, dynamic> json) =>
    TimerEventInfo(
      id: json['Id'] as String?,
      programId: json['ProgramId'] as String?,
    );

Map<String, dynamic> _$TimerEventInfoToJson(TimerEventInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Id', instance.id);
  writeNotNull('ProgramId', instance.programId);
  return val;
}

TimerInfoDto _$TimerInfoDtoFromJson(Map<String, dynamic> json) => TimerInfoDto(
      id: json['Id'] as String?,
      type: json['Type'] as String?,
      serverId: json['ServerId'] as String?,
      externalId: json['ExternalId'] as String?,
      channelId: json['ChannelId'] as String?,
      externalChannelId: json['ExternalChannelId'] as String?,
      channelName: json['ChannelName'] as String?,
      channelPrimaryImageTag: json['ChannelPrimaryImageTag'] as String?,
      programId: json['ProgramId'] as String?,
      externalProgramId: json['ExternalProgramId'] as String?,
      name: json['Name'] as String?,
      overview: json['Overview'] as String?,
      startDate: json['StartDate'] == null
          ? null
          : DateTime.parse(json['StartDate'] as String),
      endDate: json['EndDate'] == null
          ? null
          : DateTime.parse(json['EndDate'] as String),
      serviceName: json['ServiceName'] as String?,
      priority: (json['Priority'] as num?)?.toInt(),
      prePaddingSeconds: (json['PrePaddingSeconds'] as num?)?.toInt(),
      postPaddingSeconds: (json['PostPaddingSeconds'] as num?)?.toInt(),
      isPrePaddingRequired: json['IsPrePaddingRequired'] as bool?,
      parentBackdropItemId: json['ParentBackdropItemId'] as String?,
      parentBackdropImageTags:
          (json['ParentBackdropImageTags'] as List<dynamic>?)
                  ?.map((e) => e as String)
                  .toList() ??
              [],
      isPostPaddingRequired: json['IsPostPaddingRequired'] as bool?,
      keepUntil: keepUntilNullableFromJson(json['KeepUntil']),
      status: recordingStatusNullableFromJson(json['Status']),
      seriesTimerId: json['SeriesTimerId'] as String?,
      externalSeriesTimerId: json['ExternalSeriesTimerId'] as String?,
      runTimeTicks: (json['RunTimeTicks'] as num?)?.toInt(),
      programInfo: json['ProgramInfo'] == null
          ? null
          : BaseItemDto.fromJson(json['ProgramInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TimerInfoDtoToJson(TimerInfoDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Id', instance.id);
  writeNotNull('Type', instance.type);
  writeNotNull('ServerId', instance.serverId);
  writeNotNull('ExternalId', instance.externalId);
  writeNotNull('ChannelId', instance.channelId);
  writeNotNull('ExternalChannelId', instance.externalChannelId);
  writeNotNull('ChannelName', instance.channelName);
  writeNotNull('ChannelPrimaryImageTag', instance.channelPrimaryImageTag);
  writeNotNull('ProgramId', instance.programId);
  writeNotNull('ExternalProgramId', instance.externalProgramId);
  writeNotNull('Name', instance.name);
  writeNotNull('Overview', instance.overview);
  writeNotNull('StartDate', instance.startDate?.toIso8601String());
  writeNotNull('EndDate', instance.endDate?.toIso8601String());
  writeNotNull('ServiceName', instance.serviceName);
  writeNotNull('Priority', instance.priority);
  writeNotNull('PrePaddingSeconds', instance.prePaddingSeconds);
  writeNotNull('PostPaddingSeconds', instance.postPaddingSeconds);
  writeNotNull('IsPrePaddingRequired', instance.isPrePaddingRequired);
  writeNotNull('ParentBackdropItemId', instance.parentBackdropItemId);
  writeNotNull('ParentBackdropImageTags', instance.parentBackdropImageTags);
  writeNotNull('IsPostPaddingRequired', instance.isPostPaddingRequired);
  writeNotNull('KeepUntil', keepUntilNullableToJson(instance.keepUntil));
  writeNotNull('Status', recordingStatusNullableToJson(instance.status));
  writeNotNull('SeriesTimerId', instance.seriesTimerId);
  writeNotNull('ExternalSeriesTimerId', instance.externalSeriesTimerId);
  writeNotNull('RunTimeTicks', instance.runTimeTicks);
  writeNotNull('ProgramInfo', instance.programInfo?.toJson());
  return val;
}

TimerInfoDtoQueryResult _$TimerInfoDtoQueryResultFromJson(
        Map<String, dynamic> json) =>
    TimerInfoDtoQueryResult(
      items: (json['Items'] as List<dynamic>?)
              ?.map((e) => TimerInfoDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      totalRecordCount: (json['TotalRecordCount'] as num?)?.toInt(),
      startIndex: (json['StartIndex'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TimerInfoDtoQueryResultToJson(
    TimerInfoDtoQueryResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Items', instance.items?.map((e) => e.toJson()).toList());
  writeNotNull('TotalRecordCount', instance.totalRecordCount);
  writeNotNull('StartIndex', instance.startIndex);
  return val;
}

TrailerInfo _$TrailerInfoFromJson(Map<String, dynamic> json) => TrailerInfo(
      name: json['Name'] as String?,
      originalTitle: json['OriginalTitle'] as String?,
      path: json['Path'] as String?,
      metadataLanguage: json['MetadataLanguage'] as String?,
      metadataCountryCode: json['MetadataCountryCode'] as String?,
      providerIds: json['ProviderIds'] as Map<String, dynamic>?,
      year: (json['Year'] as num?)?.toInt(),
      indexNumber: (json['IndexNumber'] as num?)?.toInt(),
      parentIndexNumber: (json['ParentIndexNumber'] as num?)?.toInt(),
      premiereDate: json['PremiereDate'] == null
          ? null
          : DateTime.parse(json['PremiereDate'] as String),
      isAutomated: json['IsAutomated'] as bool?,
    );

Map<String, dynamic> _$TrailerInfoToJson(TrailerInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Name', instance.name);
  writeNotNull('OriginalTitle', instance.originalTitle);
  writeNotNull('Path', instance.path);
  writeNotNull('MetadataLanguage', instance.metadataLanguage);
  writeNotNull('MetadataCountryCode', instance.metadataCountryCode);
  writeNotNull('ProviderIds', instance.providerIds);
  writeNotNull('Year', instance.year);
  writeNotNull('IndexNumber', instance.indexNumber);
  writeNotNull('ParentIndexNumber', instance.parentIndexNumber);
  writeNotNull('PremiereDate', instance.premiereDate?.toIso8601String());
  writeNotNull('IsAutomated', instance.isAutomated);
  return val;
}

TrailerInfoRemoteSearchQuery _$TrailerInfoRemoteSearchQueryFromJson(
        Map<String, dynamic> json) =>
    TrailerInfoRemoteSearchQuery(
      searchInfo: json['SearchInfo'] == null
          ? null
          : TrailerInfo.fromJson(json['SearchInfo'] as Map<String, dynamic>),
      itemId: json['ItemId'] as String?,
      searchProviderName: json['SearchProviderName'] as String?,
      includeDisabledProviders: json['IncludeDisabledProviders'] as bool?,
    );

Map<String, dynamic> _$TrailerInfoRemoteSearchQueryToJson(
    TrailerInfoRemoteSearchQuery instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('SearchInfo', instance.searchInfo?.toJson());
  writeNotNull('ItemId', instance.itemId);
  writeNotNull('SearchProviderName', instance.searchProviderName);
  writeNotNull('IncludeDisabledProviders', instance.includeDisabledProviders);
  return val;
}

TranscodingInfo _$TranscodingInfoFromJson(Map<String, dynamic> json) =>
    TranscodingInfo(
      audioCodec: json['AudioCodec'] as String?,
      videoCodec: json['VideoCodec'] as String?,
      container: json['Container'] as String?,
      isVideoDirect: json['IsVideoDirect'] as bool?,
      isAudioDirect: json['IsAudioDirect'] as bool?,
      bitrate: (json['Bitrate'] as num?)?.toInt(),
      framerate: (json['Framerate'] as num?)?.toDouble(),
      completionPercentage: (json['CompletionPercentage'] as num?)?.toDouble(),
      width: (json['Width'] as num?)?.toInt(),
      height: (json['Height'] as num?)?.toInt(),
      audioChannels: (json['AudioChannels'] as num?)?.toInt(),
      hardwareAccelerationType: hardwareAccelerationTypeNullableFromJson(
          json['HardwareAccelerationType']),
      transcodeReasons:
          transcodeReasonListFromJson(json['TranscodeReasons'] as List?),
    );

Map<String, dynamic> _$TranscodingInfoToJson(TranscodingInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('AudioCodec', instance.audioCodec);
  writeNotNull('VideoCodec', instance.videoCodec);
  writeNotNull('Container', instance.container);
  writeNotNull('IsVideoDirect', instance.isVideoDirect);
  writeNotNull('IsAudioDirect', instance.isAudioDirect);
  writeNotNull('Bitrate', instance.bitrate);
  writeNotNull('Framerate', instance.framerate);
  writeNotNull('CompletionPercentage', instance.completionPercentage);
  writeNotNull('Width', instance.width);
  writeNotNull('Height', instance.height);
  writeNotNull('AudioChannels', instance.audioChannels);
  writeNotNull(
      'HardwareAccelerationType',
      hardwareAccelerationTypeNullableToJson(
          instance.hardwareAccelerationType));
  val['TranscodeReasons'] =
      transcodeReasonListToJson(instance.transcodeReasons);
  return val;
}

TranscodingProfile _$TranscodingProfileFromJson(Map<String, dynamic> json) =>
    TranscodingProfile(
      container: json['Container'] as String?,
      type: dlnaProfileTypeNullableFromJson(json['Type']),
      videoCodec: json['VideoCodec'] as String?,
      audioCodec: json['AudioCodec'] as String?,
      protocol: mediaStreamProtocolNullableFromJson(json['Protocol']),
      estimateContentLength: json['EstimateContentLength'] as bool? ?? false,
      enableMpegtsM2TsMode: json['EnableMpegtsM2TsMode'] as bool? ?? false,
      transcodeSeekInfo:
          TranscodingProfile.transcodeSeekInfoTranscodeSeekInfoNullableFromJson(
              json['TranscodeSeekInfo']),
      copyTimestamps: json['CopyTimestamps'] as bool? ?? false,
      context: TranscodingProfile.encodingContextContextNullableFromJson(
          json['Context']),
      enableSubtitlesInManifest:
          json['EnableSubtitlesInManifest'] as bool? ?? false,
      maxAudioChannels: json['MaxAudioChannels'] as String?,
      minSegments: (json['MinSegments'] as num?)?.toInt(),
      segmentLength: (json['SegmentLength'] as num?)?.toInt(),
      breakOnNonKeyFrames: json['BreakOnNonKeyFrames'] as bool? ?? false,
      conditions: (json['Conditions'] as List<dynamic>?)
              ?.map((e) => ProfileCondition.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      enableAudioVbrEncoding: json['EnableAudioVbrEncoding'] as bool? ?? true,
    );

Map<String, dynamic> _$TranscodingProfileToJson(TranscodingProfile instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Container', instance.container);
  writeNotNull('Type', dlnaProfileTypeNullableToJson(instance.type));
  writeNotNull('VideoCodec', instance.videoCodec);
  writeNotNull('AudioCodec', instance.audioCodec);
  writeNotNull(
      'Protocol', mediaStreamProtocolNullableToJson(instance.protocol));
  writeNotNull('EstimateContentLength', instance.estimateContentLength);
  writeNotNull('EnableMpegtsM2TsMode', instance.enableMpegtsM2TsMode);
  writeNotNull('TranscodeSeekInfo',
      transcodeSeekInfoNullableToJson(instance.transcodeSeekInfo));
  writeNotNull('CopyTimestamps', instance.copyTimestamps);
  writeNotNull('Context', encodingContextNullableToJson(instance.context));
  writeNotNull('EnableSubtitlesInManifest', instance.enableSubtitlesInManifest);
  writeNotNull('MaxAudioChannels', instance.maxAudioChannels);
  writeNotNull('MinSegments', instance.minSegments);
  writeNotNull('SegmentLength', instance.segmentLength);
  writeNotNull('BreakOnNonKeyFrames', instance.breakOnNonKeyFrames);
  writeNotNull(
      'Conditions', instance.conditions?.map((e) => e.toJson()).toList());
  writeNotNull('EnableAudioVbrEncoding', instance.enableAudioVbrEncoding);
  return val;
}

TrickplayInfo _$TrickplayInfoFromJson(Map<String, dynamic> json) =>
    TrickplayInfo(
      width: (json['Width'] as num?)?.toInt(),
      height: (json['Height'] as num?)?.toInt(),
      tileWidth: (json['TileWidth'] as num?)?.toInt(),
      tileHeight: (json['TileHeight'] as num?)?.toInt(),
      thumbnailCount: (json['ThumbnailCount'] as num?)?.toInt(),
      interval: (json['Interval'] as num?)?.toInt(),
      bandwidth: (json['Bandwidth'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TrickplayInfoToJson(TrickplayInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Width', instance.width);
  writeNotNull('Height', instance.height);
  writeNotNull('TileWidth', instance.tileWidth);
  writeNotNull('TileHeight', instance.tileHeight);
  writeNotNull('ThumbnailCount', instance.thumbnailCount);
  writeNotNull('Interval', instance.interval);
  writeNotNull('Bandwidth', instance.bandwidth);
  return val;
}

TrickplayOptions _$TrickplayOptionsFromJson(Map<String, dynamic> json) =>
    TrickplayOptions(
      enableHwAcceleration: json['EnableHwAcceleration'] as bool?,
      enableHwEncoding: json['EnableHwEncoding'] as bool?,
      enableKeyFrameOnlyExtraction:
          json['EnableKeyFrameOnlyExtraction'] as bool?,
      scanBehavior: trickplayScanBehaviorNullableFromJson(json['ScanBehavior']),
      processPriority:
          processPriorityClassNullableFromJson(json['ProcessPriority']),
      interval: (json['Interval'] as num?)?.toInt(),
      widthResolutions: (json['WidthResolutions'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          [],
      tileWidth: (json['TileWidth'] as num?)?.toInt(),
      tileHeight: (json['TileHeight'] as num?)?.toInt(),
      qscale: (json['Qscale'] as num?)?.toInt(),
      jpegQuality: (json['JpegQuality'] as num?)?.toInt(),
      processThreads: (json['ProcessThreads'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TrickplayOptionsToJson(TrickplayOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('EnableHwAcceleration', instance.enableHwAcceleration);
  writeNotNull('EnableHwEncoding', instance.enableHwEncoding);
  writeNotNull(
      'EnableKeyFrameOnlyExtraction', instance.enableKeyFrameOnlyExtraction);
  writeNotNull('ScanBehavior',
      trickplayScanBehaviorNullableToJson(instance.scanBehavior));
  writeNotNull('ProcessPriority',
      processPriorityClassNullableToJson(instance.processPriority));
  writeNotNull('Interval', instance.interval);
  writeNotNull('WidthResolutions', instance.widthResolutions);
  writeNotNull('TileWidth', instance.tileWidth);
  writeNotNull('TileHeight', instance.tileHeight);
  writeNotNull('Qscale', instance.qscale);
  writeNotNull('JpegQuality', instance.jpegQuality);
  writeNotNull('ProcessThreads', instance.processThreads);
  return val;
}

TunerChannelMapping _$TunerChannelMappingFromJson(Map<String, dynamic> json) =>
    TunerChannelMapping(
      name: json['Name'] as String?,
      providerChannelName: json['ProviderChannelName'] as String?,
      providerChannelId: json['ProviderChannelId'] as String?,
      id: json['Id'] as String?,
    );

Map<String, dynamic> _$TunerChannelMappingToJson(TunerChannelMapping instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Name', instance.name);
  writeNotNull('ProviderChannelName', instance.providerChannelName);
  writeNotNull('ProviderChannelId', instance.providerChannelId);
  writeNotNull('Id', instance.id);
  return val;
}

TunerHostInfo _$TunerHostInfoFromJson(Map<String, dynamic> json) =>
    TunerHostInfo(
      id: json['Id'] as String?,
      url: json['Url'] as String?,
      type: json['Type'] as String?,
      deviceId: json['DeviceId'] as String?,
      friendlyName: json['FriendlyName'] as String?,
      importFavoritesOnly: json['ImportFavoritesOnly'] as bool?,
      allowHWTranscoding: json['AllowHWTranscoding'] as bool?,
      allowFmp4TranscodingContainer:
          json['AllowFmp4TranscodingContainer'] as bool?,
      allowStreamSharing: json['AllowStreamSharing'] as bool?,
      fallbackMaxStreamingBitrate:
          (json['FallbackMaxStreamingBitrate'] as num?)?.toInt(),
      enableStreamLooping: json['EnableStreamLooping'] as bool?,
      source: json['Source'] as String?,
      tunerCount: (json['TunerCount'] as num?)?.toInt(),
      userAgent: json['UserAgent'] as String?,
      ignoreDts: json['IgnoreDts'] as bool?,
    );

Map<String, dynamic> _$TunerHostInfoToJson(TunerHostInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Id', instance.id);
  writeNotNull('Url', instance.url);
  writeNotNull('Type', instance.type);
  writeNotNull('DeviceId', instance.deviceId);
  writeNotNull('FriendlyName', instance.friendlyName);
  writeNotNull('ImportFavoritesOnly', instance.importFavoritesOnly);
  writeNotNull('AllowHWTranscoding', instance.allowHWTranscoding);
  writeNotNull(
      'AllowFmp4TranscodingContainer', instance.allowFmp4TranscodingContainer);
  writeNotNull('AllowStreamSharing', instance.allowStreamSharing);
  writeNotNull(
      'FallbackMaxStreamingBitrate', instance.fallbackMaxStreamingBitrate);
  writeNotNull('EnableStreamLooping', instance.enableStreamLooping);
  writeNotNull('Source', instance.source);
  writeNotNull('TunerCount', instance.tunerCount);
  writeNotNull('UserAgent', instance.userAgent);
  writeNotNull('IgnoreDts', instance.ignoreDts);
  return val;
}

TypeOptions _$TypeOptionsFromJson(Map<String, dynamic> json) => TypeOptions(
      type: json['Type'] as String?,
      metadataFetchers: (json['MetadataFetchers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      metadataFetcherOrder: (json['MetadataFetcherOrder'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      imageFetchers: (json['ImageFetchers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      imageFetcherOrder: (json['ImageFetcherOrder'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      imageOptions: (json['ImageOptions'] as List<dynamic>?)
              ?.map((e) => ImageOption.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$TypeOptionsToJson(TypeOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Type', instance.type);
  writeNotNull('MetadataFetchers', instance.metadataFetchers);
  writeNotNull('MetadataFetcherOrder', instance.metadataFetcherOrder);
  writeNotNull('ImageFetchers', instance.imageFetchers);
  writeNotNull('ImageFetcherOrder', instance.imageFetcherOrder);
  writeNotNull(
      'ImageOptions', instance.imageOptions?.map((e) => e.toJson()).toList());
  return val;
}

UpdateLibraryOptionsDto _$UpdateLibraryOptionsDtoFromJson(
        Map<String, dynamic> json) =>
    UpdateLibraryOptionsDto(
      id: json['Id'] as String?,
      libraryOptions: json['LibraryOptions'] == null
          ? null
          : LibraryOptions.fromJson(
              json['LibraryOptions'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateLibraryOptionsDtoToJson(
    UpdateLibraryOptionsDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Id', instance.id);
  writeNotNull('LibraryOptions', instance.libraryOptions?.toJson());
  return val;
}

UpdateMediaPathRequestDto _$UpdateMediaPathRequestDtoFromJson(
        Map<String, dynamic> json) =>
    UpdateMediaPathRequestDto(
      name: json['Name'] as String,
      pathInfo:
          MediaPathInfo.fromJson(json['PathInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateMediaPathRequestDtoToJson(
        UpdateMediaPathRequestDto instance) =>
    <String, dynamic>{
      'Name': instance.name,
      'PathInfo': instance.pathInfo.toJson(),
    };

UpdatePlaylistDto _$UpdatePlaylistDtoFromJson(Map<String, dynamic> json) =>
    UpdatePlaylistDto(
      name: json['Name'] as String?,
      ids: (json['Ids'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          [],
      users: (json['Users'] as List<dynamic>?)
              ?.map((e) =>
                  PlaylistUserPermissions.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      isPublic: json['IsPublic'] as bool?,
    );

Map<String, dynamic> _$UpdatePlaylistDtoToJson(UpdatePlaylistDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Name', instance.name);
  writeNotNull('Ids', instance.ids);
  writeNotNull('Users', instance.users?.map((e) => e.toJson()).toList());
  writeNotNull('IsPublic', instance.isPublic);
  return val;
}

UpdatePlaylistUserDto _$UpdatePlaylistUserDtoFromJson(
        Map<String, dynamic> json) =>
    UpdatePlaylistUserDto(
      canEdit: json['CanEdit'] as bool?,
    );

Map<String, dynamic> _$UpdatePlaylistUserDtoToJson(
    UpdatePlaylistUserDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('CanEdit', instance.canEdit);
  return val;
}

UpdateUserItemDataDto _$UpdateUserItemDataDtoFromJson(
        Map<String, dynamic> json) =>
    UpdateUserItemDataDto(
      rating: (json['Rating'] as num?)?.toDouble(),
      playedPercentage: (json['PlayedPercentage'] as num?)?.toDouble(),
      unplayedItemCount: (json['UnplayedItemCount'] as num?)?.toInt(),
      playbackPositionTicks: (json['PlaybackPositionTicks'] as num?)?.toInt(),
      playCount: (json['PlayCount'] as num?)?.toInt(),
      isFavorite: json['IsFavorite'] as bool?,
      likes: json['Likes'] as bool?,
      lastPlayedDate: json['LastPlayedDate'] == null
          ? null
          : DateTime.parse(json['LastPlayedDate'] as String),
      played: json['Played'] as bool?,
      key: json['Key'] as String?,
      itemId: json['ItemId'] as String?,
    );

Map<String, dynamic> _$UpdateUserItemDataDtoToJson(
    UpdateUserItemDataDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Rating', instance.rating);
  writeNotNull('PlayedPercentage', instance.playedPercentage);
  writeNotNull('UnplayedItemCount', instance.unplayedItemCount);
  writeNotNull('PlaybackPositionTicks', instance.playbackPositionTicks);
  writeNotNull('PlayCount', instance.playCount);
  writeNotNull('IsFavorite', instance.isFavorite);
  writeNotNull('Likes', instance.likes);
  writeNotNull('LastPlayedDate', instance.lastPlayedDate?.toIso8601String());
  writeNotNull('Played', instance.played);
  writeNotNull('Key', instance.key);
  writeNotNull('ItemId', instance.itemId);
  return val;
}

UpdateUserPassword _$UpdateUserPasswordFromJson(Map<String, dynamic> json) =>
    UpdateUserPassword(
      currentPassword: json['CurrentPassword'] as String?,
      currentPw: json['CurrentPw'] as String?,
      newPw: json['NewPw'] as String?,
      resetPassword: json['ResetPassword'] as bool?,
    );

Map<String, dynamic> _$UpdateUserPasswordToJson(UpdateUserPassword instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('CurrentPassword', instance.currentPassword);
  writeNotNull('CurrentPw', instance.currentPw);
  writeNotNull('NewPw', instance.newPw);
  writeNotNull('ResetPassword', instance.resetPassword);
  return val;
}

UploadSubtitleDto _$UploadSubtitleDtoFromJson(Map<String, dynamic> json) =>
    UploadSubtitleDto(
      language: json['Language'] as String,
      format: json['Format'] as String,
      isForced: json['IsForced'] as bool,
      isHearingImpaired: json['IsHearingImpaired'] as bool,
      data: json['Data'] as String,
    );

Map<String, dynamic> _$UploadSubtitleDtoToJson(UploadSubtitleDto instance) =>
    <String, dynamic>{
      'Language': instance.language,
      'Format': instance.format,
      'IsForced': instance.isForced,
      'IsHearingImpaired': instance.isHearingImpaired,
      'Data': instance.data,
    };

UserConfiguration _$UserConfigurationFromJson(Map<String, dynamic> json) =>
    UserConfiguration(
      audioLanguagePreference: json['AudioLanguagePreference'] as String?,
      playDefaultAudioTrack: json['PlayDefaultAudioTrack'] as bool?,
      subtitleLanguagePreference: json['SubtitleLanguagePreference'] as String?,
      displayMissingEpisodes: json['DisplayMissingEpisodes'] as bool?,
      groupedFolders: (json['GroupedFolders'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      subtitleMode: subtitlePlaybackModeNullableFromJson(json['SubtitleMode']),
      displayCollectionsView: json['DisplayCollectionsView'] as bool?,
      enableLocalPassword: json['EnableLocalPassword'] as bool?,
      orderedViews: (json['OrderedViews'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      latestItemsExcludes: (json['LatestItemsExcludes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      myMediaExcludes: (json['MyMediaExcludes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      hidePlayedInLatest: json['HidePlayedInLatest'] as bool?,
      rememberAudioSelections: json['RememberAudioSelections'] as bool?,
      rememberSubtitleSelections: json['RememberSubtitleSelections'] as bool?,
      enableNextEpisodeAutoPlay: json['EnableNextEpisodeAutoPlay'] as bool?,
      castReceiverId: json['CastReceiverId'] as String?,
    );

Map<String, dynamic> _$UserConfigurationToJson(UserConfiguration instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('AudioLanguagePreference', instance.audioLanguagePreference);
  writeNotNull('PlayDefaultAudioTrack', instance.playDefaultAudioTrack);
  writeNotNull(
      'SubtitleLanguagePreference', instance.subtitleLanguagePreference);
  writeNotNull('DisplayMissingEpisodes', instance.displayMissingEpisodes);
  writeNotNull('GroupedFolders', instance.groupedFolders);
  writeNotNull('SubtitleMode',
      subtitlePlaybackModeNullableToJson(instance.subtitleMode));
  writeNotNull('DisplayCollectionsView', instance.displayCollectionsView);
  writeNotNull('EnableLocalPassword', instance.enableLocalPassword);
  writeNotNull('OrderedViews', instance.orderedViews);
  writeNotNull('LatestItemsExcludes', instance.latestItemsExcludes);
  writeNotNull('MyMediaExcludes', instance.myMediaExcludes);
  writeNotNull('HidePlayedInLatest', instance.hidePlayedInLatest);
  writeNotNull('RememberAudioSelections', instance.rememberAudioSelections);
  writeNotNull(
      'RememberSubtitleSelections', instance.rememberSubtitleSelections);
  writeNotNull('EnableNextEpisodeAutoPlay', instance.enableNextEpisodeAutoPlay);
  writeNotNull('CastReceiverId', instance.castReceiverId);
  return val;
}

UserDataChangedMessage _$UserDataChangedMessageFromJson(
        Map<String, dynamic> json) =>
    UserDataChangedMessage(
      data: json['Data'] == null
          ? null
          : UserDataChangeInfo.fromJson(json['Data'] as Map<String, dynamic>),
      messageId: json['MessageId'] as String?,
      messageType:
          UserDataChangedMessage.sessionMessageTypeMessageTypeNullableFromJson(
              json['MessageType']),
    );

Map<String, dynamic> _$UserDataChangedMessageToJson(
    UserDataChangedMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Data', instance.data?.toJson());
  writeNotNull('MessageId', instance.messageId);
  writeNotNull(
      'MessageType', sessionMessageTypeNullableToJson(instance.messageType));
  return val;
}

UserDataChangeInfo _$UserDataChangeInfoFromJson(Map<String, dynamic> json) =>
    UserDataChangeInfo(
      userId: json['UserId'] as String?,
      userDataList: (json['UserDataList'] as List<dynamic>?)
              ?.map((e) => UserItemDataDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$UserDataChangeInfoToJson(UserDataChangeInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('UserId', instance.userId);
  writeNotNull(
      'UserDataList', instance.userDataList?.map((e) => e.toJson()).toList());
  return val;
}

UserDeletedMessage _$UserDeletedMessageFromJson(Map<String, dynamic> json) =>
    UserDeletedMessage(
      data: json['Data'] as String?,
      messageId: json['MessageId'] as String?,
      messageType:
          UserDeletedMessage.sessionMessageTypeMessageTypeNullableFromJson(
              json['MessageType']),
    );

Map<String, dynamic> _$UserDeletedMessageToJson(UserDeletedMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Data', instance.data);
  writeNotNull('MessageId', instance.messageId);
  writeNotNull(
      'MessageType', sessionMessageTypeNullableToJson(instance.messageType));
  return val;
}

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
      name: json['Name'] as String?,
      serverId: json['ServerId'] as String?,
      serverName: json['ServerName'] as String?,
      id: json['Id'] as String?,
      primaryImageTag: json['PrimaryImageTag'] as String?,
      hasPassword: json['HasPassword'] as bool?,
      hasConfiguredPassword: json['HasConfiguredPassword'] as bool?,
      hasConfiguredEasyPassword: json['HasConfiguredEasyPassword'] as bool?,
      enableAutoLogin: json['EnableAutoLogin'] as bool?,
      lastLoginDate: json['LastLoginDate'] == null
          ? null
          : DateTime.parse(json['LastLoginDate'] as String),
      lastActivityDate: json['LastActivityDate'] == null
          ? null
          : DateTime.parse(json['LastActivityDate'] as String),
      configuration: json['Configuration'] == null
          ? null
          : UserConfiguration.fromJson(
              json['Configuration'] as Map<String, dynamic>),
      policy: json['Policy'] == null
          ? null
          : UserPolicy.fromJson(json['Policy'] as Map<String, dynamic>),
      primaryImageAspectRatio:
          (json['PrimaryImageAspectRatio'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$UserDtoToJson(UserDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Name', instance.name);
  writeNotNull('ServerId', instance.serverId);
  writeNotNull('ServerName', instance.serverName);
  writeNotNull('Id', instance.id);
  writeNotNull('PrimaryImageTag', instance.primaryImageTag);
  writeNotNull('HasPassword', instance.hasPassword);
  writeNotNull('HasConfiguredPassword', instance.hasConfiguredPassword);
  writeNotNull('HasConfiguredEasyPassword', instance.hasConfiguredEasyPassword);
  writeNotNull('EnableAutoLogin', instance.enableAutoLogin);
  writeNotNull('LastLoginDate', instance.lastLoginDate?.toIso8601String());
  writeNotNull(
      'LastActivityDate', instance.lastActivityDate?.toIso8601String());
  writeNotNull('Configuration', instance.configuration?.toJson());
  writeNotNull('Policy', instance.policy?.toJson());
  writeNotNull('PrimaryImageAspectRatio', instance.primaryImageAspectRatio);
  return val;
}

UserItemDataDto _$UserItemDataDtoFromJson(Map<String, dynamic> json) =>
    UserItemDataDto(
      rating: (json['Rating'] as num?)?.toDouble(),
      playedPercentage: (json['PlayedPercentage'] as num?)?.toDouble(),
      unplayedItemCount: (json['UnplayedItemCount'] as num?)?.toInt(),
      playbackPositionTicks: (json['PlaybackPositionTicks'] as num?)?.toInt(),
      playCount: (json['PlayCount'] as num?)?.toInt(),
      isFavorite: json['IsFavorite'] as bool?,
      likes: json['Likes'] as bool?,
      lastPlayedDate: json['LastPlayedDate'] == null
          ? null
          : DateTime.parse(json['LastPlayedDate'] as String),
      played: json['Played'] as bool?,
      key: json['Key'] as String?,
      itemId: json['ItemId'] as String?,
    );

Map<String, dynamic> _$UserItemDataDtoToJson(UserItemDataDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Rating', instance.rating);
  writeNotNull('PlayedPercentage', instance.playedPercentage);
  writeNotNull('UnplayedItemCount', instance.unplayedItemCount);
  writeNotNull('PlaybackPositionTicks', instance.playbackPositionTicks);
  writeNotNull('PlayCount', instance.playCount);
  writeNotNull('IsFavorite', instance.isFavorite);
  writeNotNull('Likes', instance.likes);
  writeNotNull('LastPlayedDate', instance.lastPlayedDate?.toIso8601String());
  writeNotNull('Played', instance.played);
  writeNotNull('Key', instance.key);
  writeNotNull('ItemId', instance.itemId);
  return val;
}

UserPolicy _$UserPolicyFromJson(Map<String, dynamic> json) => UserPolicy(
      isAdministrator: json['IsAdministrator'] as bool?,
      isHidden: json['IsHidden'] as bool?,
      enableCollectionManagement:
          json['EnableCollectionManagement'] as bool? ?? false,
      enableSubtitleManagement:
          json['EnableSubtitleManagement'] as bool? ?? false,
      enableLyricManagement: json['EnableLyricManagement'] as bool? ?? false,
      isDisabled: json['IsDisabled'] as bool?,
      maxParentalRating: (json['MaxParentalRating'] as num?)?.toInt(),
      blockedTags: (json['BlockedTags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      allowedTags: (json['AllowedTags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      enableUserPreferenceAccess: json['EnableUserPreferenceAccess'] as bool?,
      accessSchedules: (json['AccessSchedules'] as List<dynamic>?)
              ?.map((e) => AccessSchedule.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      blockUnratedItems:
          unratedItemListFromJson(json['BlockUnratedItems'] as List?),
      enableRemoteControlOfOtherUsers:
          json['EnableRemoteControlOfOtherUsers'] as bool?,
      enableSharedDeviceControl: json['EnableSharedDeviceControl'] as bool?,
      enableRemoteAccess: json['EnableRemoteAccess'] as bool?,
      enableLiveTvManagement: json['EnableLiveTvManagement'] as bool?,
      enableLiveTvAccess: json['EnableLiveTvAccess'] as bool?,
      enableMediaPlayback: json['EnableMediaPlayback'] as bool?,
      enableAudioPlaybackTranscoding:
          json['EnableAudioPlaybackTranscoding'] as bool?,
      enableVideoPlaybackTranscoding:
          json['EnableVideoPlaybackTranscoding'] as bool?,
      enablePlaybackRemuxing: json['EnablePlaybackRemuxing'] as bool?,
      forceRemoteSourceTranscoding:
          json['ForceRemoteSourceTranscoding'] as bool?,
      enableContentDeletion: json['EnableContentDeletion'] as bool?,
      enableContentDeletionFromFolders:
          (json['EnableContentDeletionFromFolders'] as List<dynamic>?)
                  ?.map((e) => e as String)
                  .toList() ??
              [],
      enableContentDownloading: json['EnableContentDownloading'] as bool?,
      enableSyncTranscoding: json['EnableSyncTranscoding'] as bool?,
      enableMediaConversion: json['EnableMediaConversion'] as bool?,
      enabledDevices: (json['EnabledDevices'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      enableAllDevices: json['EnableAllDevices'] as bool?,
      enabledChannels: (json['EnabledChannels'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      enableAllChannels: json['EnableAllChannels'] as bool?,
      enabledFolders: (json['EnabledFolders'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      enableAllFolders: json['EnableAllFolders'] as bool?,
      invalidLoginAttemptCount:
          (json['InvalidLoginAttemptCount'] as num?)?.toInt(),
      loginAttemptsBeforeLockout:
          (json['LoginAttemptsBeforeLockout'] as num?)?.toInt(),
      maxActiveSessions: (json['MaxActiveSessions'] as num?)?.toInt(),
      enablePublicSharing: json['EnablePublicSharing'] as bool?,
      blockedMediaFolders: (json['BlockedMediaFolders'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      blockedChannels: (json['BlockedChannels'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      remoteClientBitrateLimit:
          (json['RemoteClientBitrateLimit'] as num?)?.toInt(),
      authenticationProviderId: json['AuthenticationProviderId'] as String,
      passwordResetProviderId: json['PasswordResetProviderId'] as String,
      syncPlayAccess:
          syncPlayUserAccessTypeNullableFromJson(json['SyncPlayAccess']),
    );

Map<String, dynamic> _$UserPolicyToJson(UserPolicy instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('IsAdministrator', instance.isAdministrator);
  writeNotNull('IsHidden', instance.isHidden);
  writeNotNull(
      'EnableCollectionManagement', instance.enableCollectionManagement);
  writeNotNull('EnableSubtitleManagement', instance.enableSubtitleManagement);
  writeNotNull('EnableLyricManagement', instance.enableLyricManagement);
  writeNotNull('IsDisabled', instance.isDisabled);
  writeNotNull('MaxParentalRating', instance.maxParentalRating);
  writeNotNull('BlockedTags', instance.blockedTags);
  writeNotNull('AllowedTags', instance.allowedTags);
  writeNotNull(
      'EnableUserPreferenceAccess', instance.enableUserPreferenceAccess);
  writeNotNull('AccessSchedules',
      instance.accessSchedules?.map((e) => e.toJson()).toList());
  val['BlockUnratedItems'] = unratedItemListToJson(instance.blockUnratedItems);
  writeNotNull('EnableRemoteControlOfOtherUsers',
      instance.enableRemoteControlOfOtherUsers);
  writeNotNull('EnableSharedDeviceControl', instance.enableSharedDeviceControl);
  writeNotNull('EnableRemoteAccess', instance.enableRemoteAccess);
  writeNotNull('EnableLiveTvManagement', instance.enableLiveTvManagement);
  writeNotNull('EnableLiveTvAccess', instance.enableLiveTvAccess);
  writeNotNull('EnableMediaPlayback', instance.enableMediaPlayback);
  writeNotNull('EnableAudioPlaybackTranscoding',
      instance.enableAudioPlaybackTranscoding);
  writeNotNull('EnableVideoPlaybackTranscoding',
      instance.enableVideoPlaybackTranscoding);
  writeNotNull('EnablePlaybackRemuxing', instance.enablePlaybackRemuxing);
  writeNotNull(
      'ForceRemoteSourceTranscoding', instance.forceRemoteSourceTranscoding);
  writeNotNull('EnableContentDeletion', instance.enableContentDeletion);
  writeNotNull('EnableContentDeletionFromFolders',
      instance.enableContentDeletionFromFolders);
  writeNotNull('EnableContentDownloading', instance.enableContentDownloading);
  writeNotNull('EnableSyncTranscoding', instance.enableSyncTranscoding);
  writeNotNull('EnableMediaConversion', instance.enableMediaConversion);
  writeNotNull('EnabledDevices', instance.enabledDevices);
  writeNotNull('EnableAllDevices', instance.enableAllDevices);
  writeNotNull('EnabledChannels', instance.enabledChannels);
  writeNotNull('EnableAllChannels', instance.enableAllChannels);
  writeNotNull('EnabledFolders', instance.enabledFolders);
  writeNotNull('EnableAllFolders', instance.enableAllFolders);
  writeNotNull('InvalidLoginAttemptCount', instance.invalidLoginAttemptCount);
  writeNotNull(
      'LoginAttemptsBeforeLockout', instance.loginAttemptsBeforeLockout);
  writeNotNull('MaxActiveSessions', instance.maxActiveSessions);
  writeNotNull('EnablePublicSharing', instance.enablePublicSharing);
  writeNotNull('BlockedMediaFolders', instance.blockedMediaFolders);
  writeNotNull('BlockedChannels', instance.blockedChannels);
  writeNotNull('RemoteClientBitrateLimit', instance.remoteClientBitrateLimit);
  val['AuthenticationProviderId'] = instance.authenticationProviderId;
  val['PasswordResetProviderId'] = instance.passwordResetProviderId;
  writeNotNull('SyncPlayAccess',
      syncPlayUserAccessTypeNullableToJson(instance.syncPlayAccess));
  return val;
}

UserUpdatedMessage _$UserUpdatedMessageFromJson(Map<String, dynamic> json) =>
    UserUpdatedMessage(
      data: json['Data'] == null
          ? null
          : UserDto.fromJson(json['Data'] as Map<String, dynamic>),
      messageId: json['MessageId'] as String?,
      messageType:
          UserUpdatedMessage.sessionMessageTypeMessageTypeNullableFromJson(
              json['MessageType']),
    );

Map<String, dynamic> _$UserUpdatedMessageToJson(UserUpdatedMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Data', instance.data?.toJson());
  writeNotNull('MessageId', instance.messageId);
  writeNotNull(
      'MessageType', sessionMessageTypeNullableToJson(instance.messageType));
  return val;
}

UtcTimeResponse _$UtcTimeResponseFromJson(Map<String, dynamic> json) =>
    UtcTimeResponse(
      requestReceptionTime: json['RequestReceptionTime'] == null
          ? null
          : DateTime.parse(json['RequestReceptionTime'] as String),
      responseTransmissionTime: json['ResponseTransmissionTime'] == null
          ? null
          : DateTime.parse(json['ResponseTransmissionTime'] as String),
    );

Map<String, dynamic> _$UtcTimeResponseToJson(UtcTimeResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'RequestReceptionTime', instance.requestReceptionTime?.toIso8601String());
  writeNotNull('ResponseTransmissionTime',
      instance.responseTransmissionTime?.toIso8601String());
  return val;
}

ValidatePathDto _$ValidatePathDtoFromJson(Map<String, dynamic> json) =>
    ValidatePathDto(
      validateWritable: json['ValidateWritable'] as bool?,
      path: json['Path'] as String?,
      isFile: json['IsFile'] as bool?,
    );

Map<String, dynamic> _$ValidatePathDtoToJson(ValidatePathDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ValidateWritable', instance.validateWritable);
  writeNotNull('Path', instance.path);
  writeNotNull('IsFile', instance.isFile);
  return val;
}

VersionInfo _$VersionInfoFromJson(Map<String, dynamic> json) => VersionInfo(
      version: json['version'] as String?,
      versionNumber: json['VersionNumber'] as String?,
      changelog: json['changelog'] as String?,
      targetAbi: json['targetAbi'] as String?,
      sourceUrl: json['sourceUrl'] as String?,
      checksum: json['checksum'] as String?,
      timestamp: json['timestamp'] as String?,
      repositoryName: json['repositoryName'] as String?,
      repositoryUrl: json['repositoryUrl'] as String?,
    );

Map<String, dynamic> _$VersionInfoToJson(VersionInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('version', instance.version);
  writeNotNull('VersionNumber', instance.versionNumber);
  writeNotNull('changelog', instance.changelog);
  writeNotNull('targetAbi', instance.targetAbi);
  writeNotNull('sourceUrl', instance.sourceUrl);
  writeNotNull('checksum', instance.checksum);
  writeNotNull('timestamp', instance.timestamp);
  writeNotNull('repositoryName', instance.repositoryName);
  writeNotNull('repositoryUrl', instance.repositoryUrl);
  return val;
}

VirtualFolderInfo _$VirtualFolderInfoFromJson(Map<String, dynamic> json) =>
    VirtualFolderInfo(
      name: json['Name'] as String?,
      locations: (json['Locations'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      collectionType:
          collectionTypeOptionsNullableFromJson(json['CollectionType']),
      libraryOptions: json['LibraryOptions'] == null
          ? null
          : LibraryOptions.fromJson(
              json['LibraryOptions'] as Map<String, dynamic>),
      itemId: json['ItemId'] as String?,
      primaryImageItemId: json['PrimaryImageItemId'] as String?,
      refreshProgress: (json['RefreshProgress'] as num?)?.toDouble(),
      refreshStatus: json['RefreshStatus'] as String?,
    );

Map<String, dynamic> _$VirtualFolderInfoToJson(VirtualFolderInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Name', instance.name);
  writeNotNull('Locations', instance.locations);
  writeNotNull('CollectionType',
      collectionTypeOptionsNullableToJson(instance.collectionType));
  writeNotNull('LibraryOptions', instance.libraryOptions?.toJson());
  writeNotNull('ItemId', instance.itemId);
  writeNotNull('PrimaryImageItemId', instance.primaryImageItemId);
  writeNotNull('RefreshProgress', instance.refreshProgress);
  writeNotNull('RefreshStatus', instance.refreshStatus);
  return val;
}

WakeOnLanInfo _$WakeOnLanInfoFromJson(Map<String, dynamic> json) =>
    WakeOnLanInfo(
      macAddress: json['MacAddress'] as String?,
      port: (json['Port'] as num?)?.toInt(),
    );

Map<String, dynamic> _$WakeOnLanInfoToJson(WakeOnLanInfo instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('MacAddress', instance.macAddress);
  writeNotNull('Port', instance.port);
  return val;
}

WebSocketMessage _$WebSocketMessageFromJson(Map<String, dynamic> json) =>
    WebSocketMessage();

Map<String, dynamic> _$WebSocketMessageToJson(WebSocketMessage instance) =>
    <String, dynamic>{};

XbmcMetadataOptions _$XbmcMetadataOptionsFromJson(Map<String, dynamic> json) =>
    XbmcMetadataOptions(
      userId: json['UserId'] as String?,
      releaseDateFormat: json['ReleaseDateFormat'] as String?,
      saveImagePathsInNfo: json['SaveImagePathsInNfo'] as bool?,
      enablePathSubstitution: json['EnablePathSubstitution'] as bool?,
      enableExtraThumbsDuplication:
          json['EnableExtraThumbsDuplication'] as bool?,
    );

Map<String, dynamic> _$XbmcMetadataOptionsToJson(XbmcMetadataOptions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('UserId', instance.userId);
  writeNotNull('ReleaseDateFormat', instance.releaseDateFormat);
  writeNotNull('SaveImagePathsInNfo', instance.saveImagePathsInNfo);
  writeNotNull('EnablePathSubstitution', instance.enablePathSubstitution);
  writeNotNull(
      'EnableExtraThumbsDuplication', instance.enableExtraThumbsDuplication);
  return val;
}

BaseItemDto$ImageBlurHashes _$BaseItemDto$ImageBlurHashesFromJson(
        Map<String, dynamic> json) =>
    BaseItemDto$ImageBlurHashes(
      primary: json['Primary'] as Map<String, dynamic>?,
      art: json['Art'] as Map<String, dynamic>?,
      backdrop: json['Backdrop'] as Map<String, dynamic>?,
      banner: json['Banner'] as Map<String, dynamic>?,
      logo: json['Logo'] as Map<String, dynamic>?,
      thumb: json['Thumb'] as Map<String, dynamic>?,
      disc: json['Disc'] as Map<String, dynamic>?,
      box: json['Box'] as Map<String, dynamic>?,
      screenshot: json['Screenshot'] as Map<String, dynamic>?,
      menu: json['Menu'] as Map<String, dynamic>?,
      chapter: json['Chapter'] as Map<String, dynamic>?,
      boxRear: json['BoxRear'] as Map<String, dynamic>?,
      profile: json['Profile'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$BaseItemDto$ImageBlurHashesToJson(
    BaseItemDto$ImageBlurHashes instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Primary', instance.primary);
  writeNotNull('Art', instance.art);
  writeNotNull('Backdrop', instance.backdrop);
  writeNotNull('Banner', instance.banner);
  writeNotNull('Logo', instance.logo);
  writeNotNull('Thumb', instance.thumb);
  writeNotNull('Disc', instance.disc);
  writeNotNull('Box', instance.box);
  writeNotNull('Screenshot', instance.screenshot);
  writeNotNull('Menu', instance.menu);
  writeNotNull('Chapter', instance.chapter);
  writeNotNull('BoxRear', instance.boxRear);
  writeNotNull('Profile', instance.profile);
  return val;
}

BaseItemPerson$ImageBlurHashes _$BaseItemPerson$ImageBlurHashesFromJson(
        Map<String, dynamic> json) =>
    BaseItemPerson$ImageBlurHashes(
      primary: json['Primary'] as Map<String, dynamic>?,
      art: json['Art'] as Map<String, dynamic>?,
      backdrop: json['Backdrop'] as Map<String, dynamic>?,
      banner: json['Banner'] as Map<String, dynamic>?,
      logo: json['Logo'] as Map<String, dynamic>?,
      thumb: json['Thumb'] as Map<String, dynamic>?,
      disc: json['Disc'] as Map<String, dynamic>?,
      box: json['Box'] as Map<String, dynamic>?,
      screenshot: json['Screenshot'] as Map<String, dynamic>?,
      menu: json['Menu'] as Map<String, dynamic>?,
      chapter: json['Chapter'] as Map<String, dynamic>?,
      boxRear: json['BoxRear'] as Map<String, dynamic>?,
      profile: json['Profile'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$BaseItemPerson$ImageBlurHashesToJson(
    BaseItemPerson$ImageBlurHashes instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Primary', instance.primary);
  writeNotNull('Art', instance.art);
  writeNotNull('Backdrop', instance.backdrop);
  writeNotNull('Banner', instance.banner);
  writeNotNull('Logo', instance.logo);
  writeNotNull('Thumb', instance.thumb);
  writeNotNull('Disc', instance.disc);
  writeNotNull('Box', instance.box);
  writeNotNull('Screenshot', instance.screenshot);
  writeNotNull('Menu', instance.menu);
  writeNotNull('Chapter', instance.chapter);
  writeNotNull('BoxRear', instance.boxRear);
  writeNotNull('Profile', instance.profile);
  return val;
}
