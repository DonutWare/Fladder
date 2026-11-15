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

Map<String, dynamic> _$AccessScheduleToJson(AccessSchedule instance) =>
    <String, dynamic>{
      'Id': ?instance.id,
      'UserId': ?instance.userId,
      'DayOfWeek': ?dynamicDayOfWeekNullableToJson(instance.dayOfWeek),
      'StartHour': ?instance.startHour,
      'EndHour': ?instance.endHour,
    };

ActivityLogEntry _$ActivityLogEntryFromJson(Map<String, dynamic> json) =>
    ActivityLogEntry(
      id: (json['Id'] as num?)?.toInt(),
      name: json['Name'] as String?,
      overview: json['Overview'] as String?,
      shortOverview: json['ShortOverview'] as String?,
      type: json['Type'] as String?,
      itemId: json['ItemId'] as String?,
      date: json['Date'] == null
          ? null
          : DateTime.parse(json['Date'] as String),
      userId: json['UserId'] as String?,
      userPrimaryImageTag: json['UserPrimaryImageTag'] as String?,
      severity: logLevelNullableFromJson(json['Severity']),
    );

Map<String, dynamic> _$ActivityLogEntryToJson(ActivityLogEntry instance) =>
    <String, dynamic>{
      'Id': ?instance.id,
      'Name': ?instance.name,
      'Overview': ?instance.overview,
      'ShortOverview': ?instance.shortOverview,
      'Type': ?instance.type,
      'ItemId': ?instance.itemId,
      'Date': ?instance.date?.toIso8601String(),
      'UserId': ?instance.userId,
      'UserPrimaryImageTag': ?instance.userPrimaryImageTag,
      'Severity': ?logLevelNullableToJson(instance.severity),
    };

ActivityLogEntryMessage _$ActivityLogEntryMessageFromJson(
  Map<String, dynamic> json,
) => ActivityLogEntryMessage(
  data:
      (json['Data'] as List<dynamic>?)
          ?.map((e) => ActivityLogEntry.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  messageId: json['MessageId'] as String?,
  messageType:
      ActivityLogEntryMessage.sessionMessageTypeMessageTypeNullableFromJson(
        json['MessageType'],
      ),
);

Map<String, dynamic> _$ActivityLogEntryMessageToJson(
  ActivityLogEntryMessage instance,
) => <String, dynamic>{
  'Data': ?instance.data?.map((e) => e.toJson()).toList(),
  'MessageId': ?instance.messageId,
  'MessageType': ?sessionMessageTypeNullableToJson(instance.messageType),
};

ActivityLogEntryQueryResult _$ActivityLogEntryQueryResultFromJson(
  Map<String, dynamic> json,
) => ActivityLogEntryQueryResult(
  items:
      (json['Items'] as List<dynamic>?)
          ?.map((e) => ActivityLogEntry.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  totalRecordCount: (json['TotalRecordCount'] as num?)?.toInt(),
  startIndex: (json['StartIndex'] as num?)?.toInt(),
);

Map<String, dynamic> _$ActivityLogEntryQueryResultToJson(
  ActivityLogEntryQueryResult instance,
) => <String, dynamic>{
  'Items': ?instance.items?.map((e) => e.toJson()).toList(),
  'TotalRecordCount': ?instance.totalRecordCount,
  'StartIndex': ?instance.startIndex,
};

ActivityLogEntryStartMessage _$ActivityLogEntryStartMessageFromJson(
  Map<String, dynamic> json,
) => ActivityLogEntryStartMessage(
  data: json['Data'] as String?,
  messageType:
      ActivityLogEntryStartMessage.sessionMessageTypeMessageTypeNullableFromJson(
        json['MessageType'],
      ),
);

Map<String, dynamic> _$ActivityLogEntryStartMessageToJson(
  ActivityLogEntryStartMessage instance,
) => <String, dynamic>{
  'Data': ?instance.data,
  'MessageType': ?sessionMessageTypeNullableToJson(instance.messageType),
};

ActivityLogEntryStopMessage _$ActivityLogEntryStopMessageFromJson(
  Map<String, dynamic> json,
) => ActivityLogEntryStopMessage(
  messageType:
      ActivityLogEntryStopMessage.sessionMessageTypeMessageTypeNullableFromJson(
        json['MessageType'],
      ),
);

Map<String, dynamic> _$ActivityLogEntryStopMessageToJson(
  ActivityLogEntryStopMessage instance,
) => <String, dynamic>{
  'MessageType': ?sessionMessageTypeNullableToJson(instance.messageType),
};

AddVirtualFolderDto _$AddVirtualFolderDtoFromJson(Map<String, dynamic> json) =>
    AddVirtualFolderDto(
      libraryOptions: json['LibraryOptions'] == null
          ? null
          : LibraryOptions.fromJson(
              json['LibraryOptions'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$AddVirtualFolderDtoToJson(
  AddVirtualFolderDto instance,
) => <String, dynamic>{'LibraryOptions': ?instance.libraryOptions?.toJson()};

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
  albumArtists:
      (json['AlbumArtists'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  artistProviderIds: json['ArtistProviderIds'] as Map<String, dynamic>?,
  songInfos:
      (json['SongInfos'] as List<dynamic>?)
          ?.map((e) => SongInfo.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$AlbumInfoToJson(AlbumInfo instance) => <String, dynamic>{
  'Name': ?instance.name,
  'OriginalTitle': ?instance.originalTitle,
  'Path': ?instance.path,
  'MetadataLanguage': ?instance.metadataLanguage,
  'MetadataCountryCode': ?instance.metadataCountryCode,
  'ProviderIds': ?instance.providerIds,
  'Year': ?instance.year,
  'IndexNumber': ?instance.indexNumber,
  'ParentIndexNumber': ?instance.parentIndexNumber,
  'PremiereDate': ?instance.premiereDate?.toIso8601String(),
  'IsAutomated': ?instance.isAutomated,
  'AlbumArtists': ?instance.albumArtists,
  'ArtistProviderIds': ?instance.artistProviderIds,
  'SongInfos': ?instance.songInfos?.map((e) => e.toJson()).toList(),
};

AlbumInfoRemoteSearchQuery _$AlbumInfoRemoteSearchQueryFromJson(
  Map<String, dynamic> json,
) => AlbumInfoRemoteSearchQuery(
  searchInfo: json['SearchInfo'] == null
      ? null
      : AlbumInfo.fromJson(json['SearchInfo'] as Map<String, dynamic>),
  itemId: json['ItemId'] as String?,
  searchProviderName: json['SearchProviderName'] as String?,
  includeDisabledProviders: json['IncludeDisabledProviders'] as bool?,
);

Map<String, dynamic> _$AlbumInfoRemoteSearchQueryToJson(
  AlbumInfoRemoteSearchQuery instance,
) => <String, dynamic>{
  'SearchInfo': ?instance.searchInfo?.toJson(),
  'ItemId': ?instance.itemId,
  'SearchProviderName': ?instance.searchProviderName,
  'IncludeDisabledProviders': ?instance.includeDisabledProviders,
};

AllThemeMediaResult _$AllThemeMediaResultFromJson(Map<String, dynamic> json) =>
    AllThemeMediaResult(
      themeVideosResult: json['ThemeVideosResult'] == null
          ? null
          : ThemeMediaResult.fromJson(
              json['ThemeVideosResult'] as Map<String, dynamic>,
            ),
      themeSongsResult: json['ThemeSongsResult'] == null
          ? null
          : ThemeMediaResult.fromJson(
              json['ThemeSongsResult'] as Map<String, dynamic>,
            ),
      soundtrackSongsResult: json['SoundtrackSongsResult'] == null
          ? null
          : ThemeMediaResult.fromJson(
              json['SoundtrackSongsResult'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$AllThemeMediaResultToJson(
  AllThemeMediaResult instance,
) => <String, dynamic>{
  'ThemeVideosResult': ?instance.themeVideosResult?.toJson(),
  'ThemeSongsResult': ?instance.themeSongsResult?.toJson(),
  'SoundtrackSongsResult': ?instance.soundtrackSongsResult?.toJson(),
};

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
  songInfos:
      (json['SongInfos'] as List<dynamic>?)
          ?.map((e) => SongInfo.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$ArtistInfoToJson(ArtistInfo instance) =>
    <String, dynamic>{
      'Name': ?instance.name,
      'OriginalTitle': ?instance.originalTitle,
      'Path': ?instance.path,
      'MetadataLanguage': ?instance.metadataLanguage,
      'MetadataCountryCode': ?instance.metadataCountryCode,
      'ProviderIds': ?instance.providerIds,
      'Year': ?instance.year,
      'IndexNumber': ?instance.indexNumber,
      'ParentIndexNumber': ?instance.parentIndexNumber,
      'PremiereDate': ?instance.premiereDate?.toIso8601String(),
      'IsAutomated': ?instance.isAutomated,
      'SongInfos': ?instance.songInfos?.map((e) => e.toJson()).toList(),
    };

ArtistInfoRemoteSearchQuery _$ArtistInfoRemoteSearchQueryFromJson(
  Map<String, dynamic> json,
) => ArtistInfoRemoteSearchQuery(
  searchInfo: json['SearchInfo'] == null
      ? null
      : ArtistInfo.fromJson(json['SearchInfo'] as Map<String, dynamic>),
  itemId: json['ItemId'] as String?,
  searchProviderName: json['SearchProviderName'] as String?,
  includeDisabledProviders: json['IncludeDisabledProviders'] as bool?,
);

Map<String, dynamic> _$ArtistInfoRemoteSearchQueryToJson(
  ArtistInfoRemoteSearchQuery instance,
) => <String, dynamic>{
  'SearchInfo': ?instance.searchInfo?.toJson(),
  'ItemId': ?instance.itemId,
  'SearchProviderName': ?instance.searchProviderName,
  'IncludeDisabledProviders': ?instance.includeDisabledProviders,
};

AuthenticateUserByName _$AuthenticateUserByNameFromJson(
  Map<String, dynamic> json,
) => AuthenticateUserByName(
  username: json['Username'] as String?,
  pw: json['Pw'] as String?,
);

Map<String, dynamic> _$AuthenticateUserByNameToJson(
  AuthenticateUserByName instance,
) => <String, dynamic>{'Username': ?instance.username, 'Pw': ?instance.pw};

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

Map<String, dynamic> _$AuthenticationInfoToJson(AuthenticationInfo instance) =>
    <String, dynamic>{
      'Id': ?instance.id,
      'AccessToken': ?instance.accessToken,
      'DeviceId': ?instance.deviceId,
      'AppName': ?instance.appName,
      'AppVersion': ?instance.appVersion,
      'DeviceName': ?instance.deviceName,
      'UserId': ?instance.userId,
      'IsActive': ?instance.isActive,
      'DateCreated': ?instance.dateCreated?.toIso8601String(),
      'DateRevoked': ?instance.dateRevoked?.toIso8601String(),
      'DateLastActivity': ?instance.dateLastActivity?.toIso8601String(),
      'UserName': ?instance.userName,
    };

AuthenticationInfoQueryResult _$AuthenticationInfoQueryResultFromJson(
  Map<String, dynamic> json,
) => AuthenticationInfoQueryResult(
  items:
      (json['Items'] as List<dynamic>?)
          ?.map((e) => AuthenticationInfo.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  totalRecordCount: (json['TotalRecordCount'] as num?)?.toInt(),
  startIndex: (json['StartIndex'] as num?)?.toInt(),
);

Map<String, dynamic> _$AuthenticationInfoQueryResultToJson(
  AuthenticationInfoQueryResult instance,
) => <String, dynamic>{
  'Items': ?instance.items?.map((e) => e.toJson()).toList(),
  'TotalRecordCount': ?instance.totalRecordCount,
  'StartIndex': ?instance.startIndex,
};

AuthenticationResult _$AuthenticationResultFromJson(
  Map<String, dynamic> json,
) => AuthenticationResult(
  user: json['User'] == null
      ? null
      : UserDto.fromJson(json['User'] as Map<String, dynamic>),
  sessionInfo: json['SessionInfo'] == null
      ? null
      : SessionInfoDto.fromJson(json['SessionInfo'] as Map<String, dynamic>),
  accessToken: json['AccessToken'] as String?,
  serverId: json['ServerId'] as String?,
);

Map<String, dynamic> _$AuthenticationResultToJson(
  AuthenticationResult instance,
) => <String, dynamic>{
  'User': ?instance.user?.toJson(),
  'SessionInfo': ?instance.sessionInfo?.toJson(),
  'AccessToken': ?instance.accessToken,
  'ServerId': ?instance.serverId,
};

BackupManifestDto _$BackupManifestDtoFromJson(Map<String, dynamic> json) =>
    BackupManifestDto(
      serverVersion: json['ServerVersion'] as String?,
      backupEngineVersion: json['BackupEngineVersion'] as String?,
      dateCreated: json['DateCreated'] == null
          ? null
          : DateTime.parse(json['DateCreated'] as String),
      path: json['Path'] as String?,
      options: json['Options'] == null
          ? null
          : BackupOptionsDto.fromJson(json['Options'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BackupManifestDtoToJson(BackupManifestDto instance) =>
    <String, dynamic>{
      'ServerVersion': ?instance.serverVersion,
      'BackupEngineVersion': ?instance.backupEngineVersion,
      'DateCreated': ?instance.dateCreated?.toIso8601String(),
      'Path': ?instance.path,
      'Options': ?instance.options?.toJson(),
    };

BackupOptionsDto _$BackupOptionsDtoFromJson(Map<String, dynamic> json) =>
    BackupOptionsDto(
      metadata: json['Metadata'] as bool?,
      trickplay: json['Trickplay'] as bool?,
      subtitles: json['Subtitles'] as bool?,
      database: json['Database'] as bool?,
    );

Map<String, dynamic> _$BackupOptionsDtoToJson(BackupOptionsDto instance) =>
    <String, dynamic>{
      'Metadata': ?instance.metadata,
      'Trickplay': ?instance.trickplay,
      'Subtitles': ?instance.subtitles,
      'Database': ?instance.database,
    };

BackupRestoreRequestDto _$BackupRestoreRequestDtoFromJson(
  Map<String, dynamic> json,
) => BackupRestoreRequestDto(
  archiveFileName: json['ArchiveFileName'] as String?,
);

Map<String, dynamic> _$BackupRestoreRequestDtoToJson(
  BackupRestoreRequestDto instance,
) => <String, dynamic>{'ArchiveFileName': ?instance.archiveFileName};

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
  airsBeforeEpisodeNumber: (json['AirsBeforeEpisodeNumber'] as num?)?.toInt(),
  canDelete: json['CanDelete'] as bool?,
  canDownload: json['CanDownload'] as bool?,
  hasLyrics: json['HasLyrics'] as bool?,
  hasSubtitles: json['HasSubtitles'] as bool?,
  preferredMetadataLanguage: json['PreferredMetadataLanguage'] as String?,
  preferredMetadataCountryCode: json['PreferredMetadataCountryCode'] as String?,
  container: json['Container'] as String?,
  sortName: json['SortName'] as String?,
  forcedSortName: json['ForcedSortName'] as String?,
  video3DFormat: video3DFormatNullableFromJson(json['Video3DFormat']),
  premiereDate: json['PremiereDate'] == null
      ? null
      : DateTime.parse(json['PremiereDate'] as String),
  externalUrls:
      (json['ExternalUrls'] as List<dynamic>?)
          ?.map((e) => ExternalUrl.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  mediaSources:
      (json['MediaSources'] as List<dynamic>?)
          ?.map((e) => MediaSourceInfo.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  criticRating: (json['CriticRating'] as num?)?.toDouble(),
  productionLocations:
      (json['ProductionLocations'] as List<dynamic>?)
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
  taglines:
      (json['Taglines'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      [],
  genres:
      (json['Genres'] as List<dynamic>?)?.map((e) => e as String).toList() ??
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
  remoteTrailers:
      (json['RemoteTrailers'] as List<dynamic>?)
          ?.map((e) => MediaUrl.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  providerIds: json['ProviderIds'] as Map<String, dynamic>?,
  isHD: json['IsHD'] as bool?,
  isFolder: json['IsFolder'] as bool?,
  parentId: json['ParentId'] as String?,
  type: baseItemKindNullableFromJson(json['Type']),
  people:
      (json['People'] as List<dynamic>?)
          ?.map((e) => BaseItemPerson.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  studios:
      (json['Studios'] as List<dynamic>?)
          ?.map((e) => NameGuidPair.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  genreItems:
      (json['GenreItems'] as List<dynamic>?)
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
      (json['Tags'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
  primaryImageAspectRatio: (json['PrimaryImageAspectRatio'] as num?)
      ?.toDouble(),
  artists:
      (json['Artists'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      [],
  artistItems:
      (json['ArtistItems'] as List<dynamic>?)
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
  albumArtists:
      (json['AlbumArtists'] as List<dynamic>?)
          ?.map((e) => NameGuidPair.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  seasonName: json['SeasonName'] as String?,
  mediaStreams:
      (json['MediaStreams'] as List<dynamic>?)
          ?.map((e) => MediaStream.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  videoType: videoTypeNullableFromJson(json['VideoType']),
  partCount: (json['PartCount'] as num?)?.toInt(),
  mediaSourceCount: (json['MediaSourceCount'] as num?)?.toInt(),
  imageTags: json['ImageTags'] as Map<String, dynamic>?,
  backdropImageTags:
      (json['BackdropImageTags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  screenshotImageTags:
      (json['ScreenshotImageTags'] as List<dynamic>?)
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
          json['ImageBlurHashes'] as Map<String, dynamic>,
        ),
  seriesStudio: json['SeriesStudio'] as String?,
  parentThumbItemId: json['ParentThumbItemId'] as String?,
  parentThumbImageTag: json['ParentThumbImageTag'] as String?,
  parentPrimaryImageItemId: json['ParentPrimaryImageItemId'] as String?,
  parentPrimaryImageTag: json['ParentPrimaryImageTag'] as String?,
  chapters:
      (json['Chapters'] as List<dynamic>?)
          ?.map((e) => ChapterInfo.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  trickplay: json['Trickplay'] as Map<String, dynamic>?,
  locationType: locationTypeNullableFromJson(json['LocationType']),
  isoType: isoTypeNullableFromJson(json['IsoType']),
  mediaType: BaseItemDto.mediaTypeMediaTypeNullableFromJson(json['MediaType']),
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
  imageOrientation: imageOrientationNullableFromJson(json['ImageOrientation']),
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
      : BaseItemDto.fromJson(json['CurrentProgram'] as Map<String, dynamic>),
);

Map<String, dynamic> _$BaseItemDtoToJson(
  BaseItemDto instance,
) => <String, dynamic>{
  'Name': ?instance.name,
  'OriginalTitle': ?instance.originalTitle,
  'ServerId': ?instance.serverId,
  'Id': ?instance.id,
  'Etag': ?instance.etag,
  'SourceType': ?instance.sourceType,
  'PlaylistItemId': ?instance.playlistItemId,
  'DateCreated': ?instance.dateCreated?.toIso8601String(),
  'DateLastMediaAdded': ?instance.dateLastMediaAdded?.toIso8601String(),
  'ExtraType': ?extraTypeNullableToJson(instance.extraType),
  'AirsBeforeSeasonNumber': ?instance.airsBeforeSeasonNumber,
  'AirsAfterSeasonNumber': ?instance.airsAfterSeasonNumber,
  'AirsBeforeEpisodeNumber': ?instance.airsBeforeEpisodeNumber,
  'CanDelete': ?instance.canDelete,
  'CanDownload': ?instance.canDownload,
  'HasLyrics': ?instance.hasLyrics,
  'HasSubtitles': ?instance.hasSubtitles,
  'PreferredMetadataLanguage': ?instance.preferredMetadataLanguage,
  'PreferredMetadataCountryCode': ?instance.preferredMetadataCountryCode,
  'Container': ?instance.container,
  'SortName': ?instance.sortName,
  'ForcedSortName': ?instance.forcedSortName,
  'Video3DFormat': ?video3DFormatNullableToJson(instance.video3DFormat),
  'PremiereDate': ?instance.premiereDate?.toIso8601String(),
  'ExternalUrls': ?instance.externalUrls?.map((e) => e.toJson()).toList(),
  'MediaSources': ?instance.mediaSources?.map((e) => e.toJson()).toList(),
  'CriticRating': ?instance.criticRating,
  'ProductionLocations': ?instance.productionLocations,
  'Path': ?instance.path,
  'EnableMediaSourceDisplay': ?instance.enableMediaSourceDisplay,
  'OfficialRating': ?instance.officialRating,
  'CustomRating': ?instance.customRating,
  'ChannelId': ?instance.channelId,
  'ChannelName': ?instance.channelName,
  'Overview': ?instance.overview,
  'Taglines': ?instance.taglines,
  'Genres': ?instance.genres,
  'CommunityRating': ?instance.communityRating,
  'CumulativeRunTimeTicks': ?instance.cumulativeRunTimeTicks,
  'RunTimeTicks': ?instance.runTimeTicks,
  'PlayAccess': ?playAccessNullableToJson(instance.playAccess),
  'AspectRatio': ?instance.aspectRatio,
  'ProductionYear': ?instance.productionYear,
  'IsPlaceHolder': ?instance.isPlaceHolder,
  'Number': ?instance.number,
  'ChannelNumber': ?instance.channelNumber,
  'IndexNumber': ?instance.indexNumber,
  'IndexNumberEnd': ?instance.indexNumberEnd,
  'ParentIndexNumber': ?instance.parentIndexNumber,
  'RemoteTrailers': ?instance.remoteTrailers?.map((e) => e.toJson()).toList(),
  'ProviderIds': ?instance.providerIds,
  'IsHD': ?instance.isHD,
  'IsFolder': ?instance.isFolder,
  'ParentId': ?instance.parentId,
  'Type': ?baseItemKindNullableToJson(instance.type),
  'People': ?instance.people?.map((e) => e.toJson()).toList(),
  'Studios': ?instance.studios?.map((e) => e.toJson()).toList(),
  'GenreItems': ?instance.genreItems?.map((e) => e.toJson()).toList(),
  'ParentLogoItemId': ?instance.parentLogoItemId,
  'ParentBackdropItemId': ?instance.parentBackdropItemId,
  'ParentBackdropImageTags': ?instance.parentBackdropImageTags,
  'LocalTrailerCount': ?instance.localTrailerCount,
  'UserData': ?instance.userData?.toJson(),
  'RecursiveItemCount': ?instance.recursiveItemCount,
  'ChildCount': ?instance.childCount,
  'SeriesName': ?instance.seriesName,
  'SeriesId': ?instance.seriesId,
  'SeasonId': ?instance.seasonId,
  'SpecialFeatureCount': ?instance.specialFeatureCount,
  'DisplayPreferencesId': ?instance.displayPreferencesId,
  'Status': ?instance.status,
  'AirTime': ?instance.airTime,
  'AirDays': dayOfWeekListToJson(instance.airDays),
  'Tags': ?instance.tags,
  'PrimaryImageAspectRatio': ?instance.primaryImageAspectRatio,
  'Artists': ?instance.artists,
  'ArtistItems': ?instance.artistItems?.map((e) => e.toJson()).toList(),
  'Album': ?instance.album,
  'CollectionType': ?collectionTypeNullableToJson(instance.collectionType),
  'DisplayOrder': ?instance.displayOrder,
  'AlbumId': ?instance.albumId,
  'AlbumPrimaryImageTag': ?instance.albumPrimaryImageTag,
  'SeriesPrimaryImageTag': ?instance.seriesPrimaryImageTag,
  'AlbumArtist': ?instance.albumArtist,
  'AlbumArtists': ?instance.albumArtists?.map((e) => e.toJson()).toList(),
  'SeasonName': ?instance.seasonName,
  'MediaStreams': ?instance.mediaStreams?.map((e) => e.toJson()).toList(),
  'VideoType': ?videoTypeNullableToJson(instance.videoType),
  'PartCount': ?instance.partCount,
  'MediaSourceCount': ?instance.mediaSourceCount,
  'ImageTags': ?instance.imageTags,
  'BackdropImageTags': ?instance.backdropImageTags,
  'ScreenshotImageTags': ?instance.screenshotImageTags,
  'ParentLogoImageTag': ?instance.parentLogoImageTag,
  'ParentArtItemId': ?instance.parentArtItemId,
  'ParentArtImageTag': ?instance.parentArtImageTag,
  'SeriesThumbImageTag': ?instance.seriesThumbImageTag,
  'ImageBlurHashes': ?instance.imageBlurHashes?.toJson(),
  'SeriesStudio': ?instance.seriesStudio,
  'ParentThumbItemId': ?instance.parentThumbItemId,
  'ParentThumbImageTag': ?instance.parentThumbImageTag,
  'ParentPrimaryImageItemId': ?instance.parentPrimaryImageItemId,
  'ParentPrimaryImageTag': ?instance.parentPrimaryImageTag,
  'Chapters': ?instance.chapters?.map((e) => e.toJson()).toList(),
  'Trickplay': ?instance.trickplay,
  'LocationType': ?locationTypeNullableToJson(instance.locationType),
  'IsoType': ?isoTypeNullableToJson(instance.isoType),
  'MediaType': ?mediaTypeNullableToJson(instance.mediaType),
  'EndDate': ?instance.endDate?.toIso8601String(),
  'LockedFields': metadataFieldListToJson(instance.lockedFields),
  'TrailerCount': ?instance.trailerCount,
  'MovieCount': ?instance.movieCount,
  'SeriesCount': ?instance.seriesCount,
  'ProgramCount': ?instance.programCount,
  'EpisodeCount': ?instance.episodeCount,
  'SongCount': ?instance.songCount,
  'AlbumCount': ?instance.albumCount,
  'ArtistCount': ?instance.artistCount,
  'MusicVideoCount': ?instance.musicVideoCount,
  'LockData': ?instance.lockData,
  'Width': ?instance.width,
  'Height': ?instance.height,
  'CameraMake': ?instance.cameraMake,
  'CameraModel': ?instance.cameraModel,
  'Software': ?instance.software,
  'ExposureTime': ?instance.exposureTime,
  'FocalLength': ?instance.focalLength,
  'ImageOrientation': ?imageOrientationNullableToJson(
    instance.imageOrientation,
  ),
  'Aperture': ?instance.aperture,
  'ShutterSpeed': ?instance.shutterSpeed,
  'Latitude': ?instance.latitude,
  'Longitude': ?instance.longitude,
  'Altitude': ?instance.altitude,
  'IsoSpeedRating': ?instance.isoSpeedRating,
  'SeriesTimerId': ?instance.seriesTimerId,
  'ProgramId': ?instance.programId,
  'ChannelPrimaryImageTag': ?instance.channelPrimaryImageTag,
  'StartDate': ?instance.startDate?.toIso8601String(),
  'CompletionPercentage': ?instance.completionPercentage,
  'IsRepeat': ?instance.isRepeat,
  'EpisodeTitle': ?instance.episodeTitle,
  'ChannelType': ?channelTypeNullableToJson(instance.channelType),
  'Audio': ?programAudioNullableToJson(instance.audio),
  'IsMovie': ?instance.isMovie,
  'IsSports': ?instance.isSports,
  'IsSeries': ?instance.isSeries,
  'IsLive': ?instance.isLive,
  'IsNews': ?instance.isNews,
  'IsKids': ?instance.isKids,
  'IsPremiere': ?instance.isPremiere,
  'TimerId': ?instance.timerId,
  'NormalizationGain': ?instance.normalizationGain,
  'CurrentProgram': ?instance.currentProgram?.toJson(),
};

BaseItemDtoQueryResult _$BaseItemDtoQueryResultFromJson(
  Map<String, dynamic> json,
) => BaseItemDtoQueryResult(
  items:
      (json['Items'] as List<dynamic>?)
          ?.map((e) => BaseItemDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  totalRecordCount: (json['TotalRecordCount'] as num?)?.toInt(),
  startIndex: (json['StartIndex'] as num?)?.toInt(),
);

Map<String, dynamic> _$BaseItemDtoQueryResultToJson(
  BaseItemDtoQueryResult instance,
) => <String, dynamic>{
  'Items': ?instance.items?.map((e) => e.toJson()).toList(),
  'TotalRecordCount': ?instance.totalRecordCount,
  'StartIndex': ?instance.startIndex,
};

BaseItemPerson _$BaseItemPersonFromJson(Map<String, dynamic> json) =>
    BaseItemPerson(
      name: json['Name'] as String?,
      id: json['Id'] as String?,
      role: json['Role'] as String?,
      type: BaseItemPerson.personKindTypeNullableFromJson(json['Type']),
      primaryImageTag: json['PrimaryImageTag'] as String?,
      imageBlurHashes: json['ImageBlurHashes'] == null
          ? null
          : BaseItemPerson$ImageBlurHashes.fromJson(
              json['ImageBlurHashes'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$BaseItemPersonToJson(BaseItemPerson instance) =>
    <String, dynamic>{
      'Name': ?instance.name,
      'Id': ?instance.id,
      'Role': ?instance.role,
      'Type': ?personKindNullableToJson(instance.type),
      'PrimaryImageTag': ?instance.primaryImageTag,
      'ImageBlurHashes': ?instance.imageBlurHashes?.toJson(),
    };

BasePluginConfiguration _$BasePluginConfigurationFromJson(
  Map<String, dynamic> json,
) => BasePluginConfiguration();

Map<String, dynamic> _$BasePluginConfigurationToJson(
  BasePluginConfiguration instance,
) => <String, dynamic>{};

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

Map<String, dynamic> _$BookInfoToJson(BookInfo instance) => <String, dynamic>{
  'Name': ?instance.name,
  'OriginalTitle': ?instance.originalTitle,
  'Path': ?instance.path,
  'MetadataLanguage': ?instance.metadataLanguage,
  'MetadataCountryCode': ?instance.metadataCountryCode,
  'ProviderIds': ?instance.providerIds,
  'Year': ?instance.year,
  'IndexNumber': ?instance.indexNumber,
  'ParentIndexNumber': ?instance.parentIndexNumber,
  'PremiereDate': ?instance.premiereDate?.toIso8601String(),
  'IsAutomated': ?instance.isAutomated,
  'SeriesName': ?instance.seriesName,
};

BookInfoRemoteSearchQuery _$BookInfoRemoteSearchQueryFromJson(
  Map<String, dynamic> json,
) => BookInfoRemoteSearchQuery(
  searchInfo: json['SearchInfo'] == null
      ? null
      : BookInfo.fromJson(json['SearchInfo'] as Map<String, dynamic>),
  itemId: json['ItemId'] as String?,
  searchProviderName: json['SearchProviderName'] as String?,
  includeDisabledProviders: json['IncludeDisabledProviders'] as bool?,
);

Map<String, dynamic> _$BookInfoRemoteSearchQueryToJson(
  BookInfoRemoteSearchQuery instance,
) => <String, dynamic>{
  'SearchInfo': ?instance.searchInfo?.toJson(),
  'ItemId': ?instance.itemId,
  'SearchProviderName': ?instance.searchProviderName,
  'IncludeDisabledProviders': ?instance.includeDisabledProviders,
};

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

Map<String, dynamic> _$BoxSetInfoToJson(BoxSetInfo instance) =>
    <String, dynamic>{
      'Name': ?instance.name,
      'OriginalTitle': ?instance.originalTitle,
      'Path': ?instance.path,
      'MetadataLanguage': ?instance.metadataLanguage,
      'MetadataCountryCode': ?instance.metadataCountryCode,
      'ProviderIds': ?instance.providerIds,
      'Year': ?instance.year,
      'IndexNumber': ?instance.indexNumber,
      'ParentIndexNumber': ?instance.parentIndexNumber,
      'PremiereDate': ?instance.premiereDate?.toIso8601String(),
      'IsAutomated': ?instance.isAutomated,
    };

BoxSetInfoRemoteSearchQuery _$BoxSetInfoRemoteSearchQueryFromJson(
  Map<String, dynamic> json,
) => BoxSetInfoRemoteSearchQuery(
  searchInfo: json['SearchInfo'] == null
      ? null
      : BoxSetInfo.fromJson(json['SearchInfo'] as Map<String, dynamic>),
  itemId: json['ItemId'] as String?,
  searchProviderName: json['SearchProviderName'] as String?,
  includeDisabledProviders: json['IncludeDisabledProviders'] as bool?,
);

Map<String, dynamic> _$BoxSetInfoRemoteSearchQueryToJson(
  BoxSetInfoRemoteSearchQuery instance,
) => <String, dynamic>{
  'SearchInfo': ?instance.searchInfo?.toJson(),
  'ItemId': ?instance.itemId,
  'SearchProviderName': ?instance.searchProviderName,
  'IncludeDisabledProviders': ?instance.includeDisabledProviders,
};

BrandingOptionsDto _$BrandingOptionsDtoFromJson(Map<String, dynamic> json) =>
    BrandingOptionsDto(
      loginDisclaimer: json['LoginDisclaimer'] as String?,
      customCss: json['CustomCss'] as String?,
      splashscreenEnabled: json['SplashscreenEnabled'] as bool?,
    );

Map<String, dynamic> _$BrandingOptionsDtoToJson(BrandingOptionsDto instance) =>
    <String, dynamic>{
      'LoginDisclaimer': ?instance.loginDisclaimer,
      'CustomCss': ?instance.customCss,
      'SplashscreenEnabled': ?instance.splashscreenEnabled,
    };

BufferRequestDto _$BufferRequestDtoFromJson(Map<String, dynamic> json) =>
    BufferRequestDto(
      when: json['When'] == null
          ? null
          : DateTime.parse(json['When'] as String),
      positionTicks: (json['PositionTicks'] as num?)?.toInt(),
      isPlaying: json['IsPlaying'] as bool?,
      playlistItemId: json['PlaylistItemId'] as String?,
    );

Map<String, dynamic> _$BufferRequestDtoToJson(BufferRequestDto instance) =>
    <String, dynamic>{
      'When': ?instance.when?.toIso8601String(),
      'PositionTicks': ?instance.positionTicks,
      'IsPlaying': ?instance.isPlaying,
      'PlaylistItemId': ?instance.playlistItemId,
    };

CastReceiverApplication _$CastReceiverApplicationFromJson(
  Map<String, dynamic> json,
) => CastReceiverApplication(
  id: json['Id'] as String?,
  name: json['Name'] as String?,
);

Map<String, dynamic> _$CastReceiverApplicationToJson(
  CastReceiverApplication instance,
) => <String, dynamic>{'Id': ?instance.id, 'Name': ?instance.name};

ChannelFeatures _$ChannelFeaturesFromJson(Map<String, dynamic> json) =>
    ChannelFeatures(
      name: json['Name'] as String?,
      id: json['Id'] as String?,
      canSearch: json['CanSearch'] as bool?,
      mediaTypes: channelMediaTypeListFromJson(json['MediaTypes'] as List?),
      contentTypes: channelMediaContentTypeListFromJson(
        json['ContentTypes'] as List?,
      ),
      maxPageSize: (json['MaxPageSize'] as num?)?.toInt(),
      autoRefreshLevels: (json['AutoRefreshLevels'] as num?)?.toInt(),
      defaultSortFields: channelItemSortFieldListFromJson(
        json['DefaultSortFields'] as List?,
      ),
      supportsSortOrderToggle: json['SupportsSortOrderToggle'] as bool?,
      supportsLatestMedia: json['SupportsLatestMedia'] as bool?,
      canFilter: json['CanFilter'] as bool?,
      supportsContentDownloading: json['SupportsContentDownloading'] as bool?,
    );

Map<String, dynamic> _$ChannelFeaturesToJson(ChannelFeatures instance) =>
    <String, dynamic>{
      'Name': ?instance.name,
      'Id': ?instance.id,
      'CanSearch': ?instance.canSearch,
      'MediaTypes': channelMediaTypeListToJson(instance.mediaTypes),
      'ContentTypes': channelMediaContentTypeListToJson(instance.contentTypes),
      'MaxPageSize': ?instance.maxPageSize,
      'AutoRefreshLevels': ?instance.autoRefreshLevels,
      'DefaultSortFields': channelItemSortFieldListToJson(
        instance.defaultSortFields,
      ),
      'SupportsSortOrderToggle': ?instance.supportsSortOrderToggle,
      'SupportsLatestMedia': ?instance.supportsLatestMedia,
      'CanFilter': ?instance.canFilter,
      'SupportsContentDownloading': ?instance.supportsContentDownloading,
    };

ChannelMappingOptionsDto _$ChannelMappingOptionsDtoFromJson(
  Map<String, dynamic> json,
) => ChannelMappingOptionsDto(
  tunerChannels:
      (json['TunerChannels'] as List<dynamic>?)
          ?.map((e) => TunerChannelMapping.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  providerChannels:
      (json['ProviderChannels'] as List<dynamic>?)
          ?.map((e) => NameIdPair.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  mappings:
      (json['Mappings'] as List<dynamic>?)
          ?.map((e) => NameValuePair.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  providerName: json['ProviderName'] as String?,
);

Map<String, dynamic> _$ChannelMappingOptionsDtoToJson(
  ChannelMappingOptionsDto instance,
) => <String, dynamic>{
  'TunerChannels': ?instance.tunerChannels?.map((e) => e.toJson()).toList(),
  'ProviderChannels': ?instance.providerChannels
      ?.map((e) => e.toJson())
      .toList(),
  'Mappings': ?instance.mappings?.map((e) => e.toJson()).toList(),
  'ProviderName': ?instance.providerName,
};

ChapterInfo _$ChapterInfoFromJson(Map<String, dynamic> json) => ChapterInfo(
  startPositionTicks: (json['StartPositionTicks'] as num?)?.toInt(),
  name: json['Name'] as String?,
  imagePath: json['ImagePath'] as String?,
  imageDateModified: json['ImageDateModified'] == null
      ? null
      : DateTime.parse(json['ImageDateModified'] as String),
  imageTag: json['ImageTag'] as String?,
);

Map<String, dynamic> _$ChapterInfoToJson(ChapterInfo instance) =>
    <String, dynamic>{
      'StartPositionTicks': ?instance.startPositionTicks,
      'Name': ?instance.name,
      'ImagePath': ?instance.imagePath,
      'ImageDateModified': ?instance.imageDateModified?.toIso8601String(),
      'ImageTag': ?instance.imageTag,
    };

ClientCapabilitiesDto _$ClientCapabilitiesDtoFromJson(
  Map<String, dynamic> json,
) => ClientCapabilitiesDto(
  playableMediaTypes: mediaTypeListFromJson(
    json['PlayableMediaTypes'] as List?,
  ),
  supportedCommands: generalCommandTypeListFromJson(
    json['SupportedCommands'] as List?,
  ),
  supportsMediaControl: json['SupportsMediaControl'] as bool?,
  supportsPersistentIdentifier: json['SupportsPersistentIdentifier'] as bool?,
  deviceProfile: json['DeviceProfile'] == null
      ? null
      : DeviceProfile.fromJson(json['DeviceProfile'] as Map<String, dynamic>),
  appStoreUrl: json['AppStoreUrl'] as String?,
  iconUrl: json['IconUrl'] as String?,
);

Map<String, dynamic> _$ClientCapabilitiesDtoToJson(
  ClientCapabilitiesDto instance,
) => <String, dynamic>{
  'PlayableMediaTypes': mediaTypeListToJson(instance.playableMediaTypes),
  'SupportedCommands': generalCommandTypeListToJson(instance.supportedCommands),
  'SupportsMediaControl': ?instance.supportsMediaControl,
  'SupportsPersistentIdentifier': ?instance.supportsPersistentIdentifier,
  'DeviceProfile': ?instance.deviceProfile?.toJson(),
  'AppStoreUrl': ?instance.appStoreUrl,
  'IconUrl': ?instance.iconUrl,
};

ClientLogDocumentResponseDto _$ClientLogDocumentResponseDtoFromJson(
  Map<String, dynamic> json,
) => ClientLogDocumentResponseDto(fileName: json['FileName'] as String?);

Map<String, dynamic> _$ClientLogDocumentResponseDtoToJson(
  ClientLogDocumentResponseDto instance,
) => <String, dynamic>{'FileName': ?instance.fileName};

CodecProfile _$CodecProfileFromJson(Map<String, dynamic> json) => CodecProfile(
  type: codecTypeNullableFromJson(json['Type']),
  conditions:
      (json['Conditions'] as List<dynamic>?)
          ?.map((e) => ProfileCondition.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  applyConditions:
      (json['ApplyConditions'] as List<dynamic>?)
          ?.map((e) => ProfileCondition.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  codec: json['Codec'] as String?,
  container: json['Container'] as String?,
  subContainer: json['SubContainer'] as String?,
);

Map<String, dynamic> _$CodecProfileToJson(
  CodecProfile instance,
) => <String, dynamic>{
  'Type': ?codecTypeNullableToJson(instance.type),
  'Conditions': ?instance.conditions?.map((e) => e.toJson()).toList(),
  'ApplyConditions': ?instance.applyConditions?.map((e) => e.toJson()).toList(),
  'Codec': ?instance.codec,
  'Container': ?instance.container,
  'SubContainer': ?instance.subContainer,
};

CollectionCreationResult _$CollectionCreationResultFromJson(
  Map<String, dynamic> json,
) => CollectionCreationResult(id: json['Id'] as String?);

Map<String, dynamic> _$CollectionCreationResultToJson(
  CollectionCreationResult instance,
) => <String, dynamic>{'Id': ?instance.id};

ConfigImageTypes _$ConfigImageTypesFromJson(Map<String, dynamic> json) =>
    ConfigImageTypes(
      backdropSizes:
          (json['BackdropSizes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      baseUrl: json['BaseUrl'] as String?,
      logoSizes:
          (json['LogoSizes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      posterSizes:
          (json['PosterSizes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      profileSizes:
          (json['ProfileSizes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      secureBaseUrl: json['SecureBaseUrl'] as String?,
      stillSizes:
          (json['StillSizes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$ConfigImageTypesToJson(ConfigImageTypes instance) =>
    <String, dynamic>{
      'BackdropSizes': ?instance.backdropSizes,
      'BaseUrl': ?instance.baseUrl,
      'LogoSizes': ?instance.logoSizes,
      'PosterSizes': ?instance.posterSizes,
      'ProfileSizes': ?instance.profileSizes,
      'SecureBaseUrl': ?instance.secureBaseUrl,
      'StillSizes': ?instance.stillSizes,
    };

ConfigurationPageInfo _$ConfigurationPageInfoFromJson(
  Map<String, dynamic> json,
) => ConfigurationPageInfo(
  name: json['Name'] as String?,
  enableInMainMenu: json['EnableInMainMenu'] as bool?,
  menuSection: json['MenuSection'] as String?,
  menuIcon: json['MenuIcon'] as String?,
  displayName: json['DisplayName'] as String?,
  pluginId: json['PluginId'] as String?,
);

Map<String, dynamic> _$ConfigurationPageInfoToJson(
  ConfigurationPageInfo instance,
) => <String, dynamic>{
  'Name': ?instance.name,
  'EnableInMainMenu': ?instance.enableInMainMenu,
  'MenuSection': ?instance.menuSection,
  'MenuIcon': ?instance.menuIcon,
  'DisplayName': ?instance.displayName,
  'PluginId': ?instance.pluginId,
};

ContainerProfile _$ContainerProfileFromJson(Map<String, dynamic> json) =>
    ContainerProfile(
      type: dlnaProfileTypeNullableFromJson(json['Type']),
      conditions:
          (json['Conditions'] as List<dynamic>?)
              ?.map((e) => ProfileCondition.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      container: json['Container'] as String?,
      subContainer: json['SubContainer'] as String?,
    );

Map<String, dynamic> _$ContainerProfileToJson(ContainerProfile instance) =>
    <String, dynamic>{
      'Type': ?dlnaProfileTypeNullableToJson(instance.type),
      'Conditions': ?instance.conditions?.map((e) => e.toJson()).toList(),
      'Container': ?instance.container,
      'SubContainer': ?instance.subContainer,
    };

CountryInfo _$CountryInfoFromJson(Map<String, dynamic> json) => CountryInfo(
  name: json['Name'] as String?,
  displayName: json['DisplayName'] as String?,
  twoLetterISORegionName: json['TwoLetterISORegionName'] as String?,
  threeLetterISORegionName: json['ThreeLetterISORegionName'] as String?,
);

Map<String, dynamic> _$CountryInfoToJson(CountryInfo instance) =>
    <String, dynamic>{
      'Name': ?instance.name,
      'DisplayName': ?instance.displayName,
      'TwoLetterISORegionName': ?instance.twoLetterISORegionName,
      'ThreeLetterISORegionName': ?instance.threeLetterISORegionName,
    };

CreatePlaylistDto _$CreatePlaylistDtoFromJson(
  Map<String, dynamic> json,
) => CreatePlaylistDto(
  name: json['Name'] as String?,
  ids: (json['Ids'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
  userId: json['UserId'] as String?,
  mediaType: mediaTypeNullableFromJson(json['MediaType']),
  users:
      (json['Users'] as List<dynamic>?)
          ?.map(
            (e) => PlaylistUserPermissions.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      [],
  isPublic: json['IsPublic'] as bool?,
);

Map<String, dynamic> _$CreatePlaylistDtoToJson(CreatePlaylistDto instance) =>
    <String, dynamic>{
      'Name': ?instance.name,
      'Ids': ?instance.ids,
      'UserId': ?instance.userId,
      'MediaType': ?mediaTypeNullableToJson(instance.mediaType),
      'Users': ?instance.users?.map((e) => e.toJson()).toList(),
      'IsPublic': ?instance.isPublic,
    };

CreateUserByName _$CreateUserByNameFromJson(Map<String, dynamic> json) =>
    CreateUserByName(
      name: json['Name'] as String,
      password: json['Password'] as String?,
    );

Map<String, dynamic> _$CreateUserByNameToJson(CreateUserByName instance) =>
    <String, dynamic>{'Name': instance.name, 'Password': ?instance.password};

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

Map<String, dynamic> _$CultureDtoToJson(CultureDto instance) =>
    <String, dynamic>{
      'Name': ?instance.name,
      'DisplayName': ?instance.displayName,
      'TwoLetterISOLanguageName': ?instance.twoLetterISOLanguageName,
      'ThreeLetterISOLanguageName': ?instance.threeLetterISOLanguageName,
      'ThreeLetterISOLanguageNames': ?instance.threeLetterISOLanguageNames,
    };

CustomDatabaseOption _$CustomDatabaseOptionFromJson(
  Map<String, dynamic> json,
) => CustomDatabaseOption(
  key: json['Key'] as String?,
  value: json['Value'] as String?,
);

Map<String, dynamic> _$CustomDatabaseOptionToJson(
  CustomDatabaseOption instance,
) => <String, dynamic>{'Key': ?instance.key, 'Value': ?instance.value};

CustomDatabaseOptions _$CustomDatabaseOptionsFromJson(
  Map<String, dynamic> json,
) => CustomDatabaseOptions(
  pluginName: json['PluginName'] as String?,
  pluginAssembly: json['PluginAssembly'] as String?,
  connectionString: json['ConnectionString'] as String?,
  options:
      (json['Options'] as List<dynamic>?)
          ?.map((e) => CustomDatabaseOption.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$CustomDatabaseOptionsToJson(
  CustomDatabaseOptions instance,
) => <String, dynamic>{
  'PluginName': ?instance.pluginName,
  'PluginAssembly': ?instance.pluginAssembly,
  'ConnectionString': ?instance.connectionString,
  'Options': ?instance.options?.map((e) => e.toJson()).toList(),
};

CustomQueryData _$CustomQueryDataFromJson(Map<String, dynamic> json) =>
    CustomQueryData(
      customQueryString: json['CustomQueryString'] as String?,
      replaceUserId: json['ReplaceUserId'] as bool?,
    );

Map<String, dynamic> _$CustomQueryDataToJson(CustomQueryData instance) =>
    <String, dynamic>{
      'CustomQueryString': ?instance.customQueryString,
      'ReplaceUserId': ?instance.replaceUserId,
    };

DatabaseConfigurationOptions _$DatabaseConfigurationOptionsFromJson(
  Map<String, dynamic> json,
) => DatabaseConfigurationOptions(
  databaseType: json['DatabaseType'] as String?,
  customProviderOptions: json['CustomProviderOptions'] == null
      ? null
      : CustomDatabaseOptions.fromJson(
          json['CustomProviderOptions'] as Map<String, dynamic>,
        ),
  lockingBehavior: databaseLockingBehaviorTypesNullableFromJson(
    json['LockingBehavior'],
  ),
);

Map<String, dynamic> _$DatabaseConfigurationOptionsToJson(
  DatabaseConfigurationOptions instance,
) => <String, dynamic>{
  'DatabaseType': ?instance.databaseType,
  'CustomProviderOptions': ?instance.customProviderOptions?.toJson(),
  'LockingBehavior': ?databaseLockingBehaviorTypesNullableToJson(
    instance.lockingBehavior,
  ),
};

DefaultDirectoryBrowserInfoDto _$DefaultDirectoryBrowserInfoDtoFromJson(
  Map<String, dynamic> json,
) => DefaultDirectoryBrowserInfoDto(path: json['Path'] as String?);

Map<String, dynamic> _$DefaultDirectoryBrowserInfoDtoToJson(
  DefaultDirectoryBrowserInfoDto instance,
) => <String, dynamic>{'Path': ?instance.path};

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
              json['Capabilities'] as Map<String, dynamic>,
            ),
      iconUrl: json['IconUrl'] as String?,
    );

Map<String, dynamic> _$DeviceInfoDtoToJson(DeviceInfoDto instance) =>
    <String, dynamic>{
      'Name': ?instance.name,
      'CustomName': ?instance.customName,
      'AccessToken': ?instance.accessToken,
      'Id': ?instance.id,
      'LastUserName': ?instance.lastUserName,
      'AppName': ?instance.appName,
      'AppVersion': ?instance.appVersion,
      'LastUserId': ?instance.lastUserId,
      'DateLastActivity': ?instance.dateLastActivity?.toIso8601String(),
      'Capabilities': ?instance.capabilities?.toJson(),
      'IconUrl': ?instance.iconUrl,
    };

DeviceInfoDtoQueryResult _$DeviceInfoDtoQueryResultFromJson(
  Map<String, dynamic> json,
) => DeviceInfoDtoQueryResult(
  items:
      (json['Items'] as List<dynamic>?)
          ?.map((e) => DeviceInfoDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  totalRecordCount: (json['TotalRecordCount'] as num?)?.toInt(),
  startIndex: (json['StartIndex'] as num?)?.toInt(),
);

Map<String, dynamic> _$DeviceInfoDtoQueryResultToJson(
  DeviceInfoDtoQueryResult instance,
) => <String, dynamic>{
  'Items': ?instance.items?.map((e) => e.toJson()).toList(),
  'TotalRecordCount': ?instance.totalRecordCount,
  'StartIndex': ?instance.startIndex,
};

DeviceOptionsDto _$DeviceOptionsDtoFromJson(Map<String, dynamic> json) =>
    DeviceOptionsDto(
      id: (json['Id'] as num?)?.toInt(),
      deviceId: json['DeviceId'] as String?,
      customName: json['CustomName'] as String?,
    );

Map<String, dynamic> _$DeviceOptionsDtoToJson(DeviceOptionsDto instance) =>
    <String, dynamic>{
      'Id': ?instance.id,
      'DeviceId': ?instance.deviceId,
      'CustomName': ?instance.customName,
    };

DeviceProfile _$DeviceProfileFromJson(
  Map<String, dynamic> json,
) => DeviceProfile(
  name: json['Name'] as String?,
  id: json['Id'] as String?,
  maxStreamingBitrate: (json['MaxStreamingBitrate'] as num?)?.toInt(),
  maxStaticBitrate: (json['MaxStaticBitrate'] as num?)?.toInt(),
  musicStreamingTranscodingBitrate:
      (json['MusicStreamingTranscodingBitrate'] as num?)?.toInt(),
  maxStaticMusicBitrate: (json['MaxStaticMusicBitrate'] as num?)?.toInt(),
  directPlayProfiles:
      (json['DirectPlayProfiles'] as List<dynamic>?)
          ?.map((e) => DirectPlayProfile.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  transcodingProfiles:
      (json['TranscodingProfiles'] as List<dynamic>?)
          ?.map((e) => TranscodingProfile.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  containerProfiles:
      (json['ContainerProfiles'] as List<dynamic>?)
          ?.map((e) => ContainerProfile.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  codecProfiles:
      (json['CodecProfiles'] as List<dynamic>?)
          ?.map((e) => CodecProfile.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  subtitleProfiles:
      (json['SubtitleProfiles'] as List<dynamic>?)
          ?.map((e) => SubtitleProfile.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$DeviceProfileToJson(DeviceProfile instance) =>
    <String, dynamic>{
      'Name': ?instance.name,
      'Id': ?instance.id,
      'MaxStreamingBitrate': ?instance.maxStreamingBitrate,
      'MaxStaticBitrate': ?instance.maxStaticBitrate,
      'MusicStreamingTranscodingBitrate':
          ?instance.musicStreamingTranscodingBitrate,
      'MaxStaticMusicBitrate': ?instance.maxStaticMusicBitrate,
      'DirectPlayProfiles': ?instance.directPlayProfiles
          ?.map((e) => e.toJson())
          .toList(),
      'TranscodingProfiles': ?instance.transcodingProfiles
          ?.map((e) => e.toJson())
          .toList(),
      'ContainerProfiles': ?instance.containerProfiles
          ?.map((e) => e.toJson())
          .toList(),
      'CodecProfiles': ?instance.codecProfiles?.map((e) => e.toJson()).toList(),
      'SubtitleProfiles': ?instance.subtitleProfiles
          ?.map((e) => e.toJson())
          .toList(),
    };

DirectPlayProfile _$DirectPlayProfileFromJson(Map<String, dynamic> json) =>
    DirectPlayProfile(
      container: json['Container'] as String?,
      audioCodec: json['AudioCodec'] as String?,
      videoCodec: json['VideoCodec'] as String?,
      type: dlnaProfileTypeNullableFromJson(json['Type']),
    );

Map<String, dynamic> _$DirectPlayProfileToJson(DirectPlayProfile instance) =>
    <String, dynamic>{
      'Container': ?instance.container,
      'AudioCodec': ?instance.audioCodec,
      'VideoCodec': ?instance.videoCodec,
      'Type': ?dlnaProfileTypeNullableToJson(instance.type),
    };

DisplayPreferencesDto _$DisplayPreferencesDtoFromJson(
  Map<String, dynamic> json,
) => DisplayPreferencesDto(
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
  DisplayPreferencesDto instance,
) => <String, dynamic>{
  'Id': ?instance.id,
  'ViewType': ?instance.viewType,
  'SortBy': ?instance.sortBy,
  'IndexBy': ?instance.indexBy,
  'RememberIndexing': ?instance.rememberIndexing,
  'PrimaryImageHeight': ?instance.primaryImageHeight,
  'PrimaryImageWidth': ?instance.primaryImageWidth,
  'CustomPrefs': ?instance.customPrefs,
  'ScrollDirection': ?scrollDirectionNullableToJson(instance.scrollDirection),
  'ShowBackdrop': ?instance.showBackdrop,
  'RememberSorting': ?instance.rememberSorting,
  'SortOrder': ?sortOrderNullableToJson(instance.sortOrder),
  'ShowSidebar': ?instance.showSidebar,
  'Client': ?instance.$Client,
};

EncodingOptions _$EncodingOptionsFromJson(
  Map<String, dynamic> json,
) => EncodingOptions(
  encodingThreadCount: (json['EncodingThreadCount'] as num?)?.toInt(),
  transcodingTempPath: json['TranscodingTempPath'] as String?,
  fallbackFontPath: json['FallbackFontPath'] as String?,
  enableFallbackFont: json['EnableFallbackFont'] as bool?,
  enableAudioVbr: json['EnableAudioVbr'] as bool?,
  downMixAudioBoost: (json['DownMixAudioBoost'] as num?)?.toDouble(),
  downMixStereoAlgorithm: downMixStereoAlgorithmsNullableFromJson(
    json['DownMixStereoAlgorithm'],
  ),
  maxMuxingQueueSize: (json['MaxMuxingQueueSize'] as num?)?.toInt(),
  enableThrottling: json['EnableThrottling'] as bool?,
  throttleDelaySeconds: (json['ThrottleDelaySeconds'] as num?)?.toInt(),
  enableSegmentDeletion: json['EnableSegmentDeletion'] as bool?,
  segmentKeepSeconds: (json['SegmentKeepSeconds'] as num?)?.toInt(),
  hardwareAccelerationType: hardwareAccelerationTypeNullableFromJson(
    json['HardwareAccelerationType'],
  ),
  encoderAppPath: json['EncoderAppPath'] as String?,
  encoderAppPathDisplay: json['EncoderAppPathDisplay'] as String?,
  vaapiDevice: json['VaapiDevice'] as String?,
  qsvDevice: json['QsvDevice'] as String?,
  enableTonemapping: json['EnableTonemapping'] as bool?,
  enableVppTonemapping: json['EnableVppTonemapping'] as bool?,
  enableVideoToolboxTonemapping: json['EnableVideoToolboxTonemapping'] as bool?,
  tonemappingAlgorithm: tonemappingAlgorithmNullableFromJson(
    json['TonemappingAlgorithm'],
  ),
  tonemappingMode: tonemappingModeNullableFromJson(json['TonemappingMode']),
  tonemappingRange: tonemappingRangeNullableFromJson(json['TonemappingRange']),
  tonemappingDesat: (json['TonemappingDesat'] as num?)?.toDouble(),
  tonemappingPeak: (json['TonemappingPeak'] as num?)?.toDouble(),
  tonemappingParam: (json['TonemappingParam'] as num?)?.toDouble(),
  vppTonemappingBrightness: (json['VppTonemappingBrightness'] as num?)
      ?.toDouble(),
  vppTonemappingContrast: (json['VppTonemappingContrast'] as num?)?.toDouble(),
  h264Crf: (json['H264Crf'] as num?)?.toInt(),
  h265Crf: (json['H265Crf'] as num?)?.toInt(),
  encoderPreset: encoderPresetNullableFromJson(json['EncoderPreset']),
  deinterlaceDoubleRate: json['DeinterlaceDoubleRate'] as bool?,
  deinterlaceMethod: deinterlaceMethodNullableFromJson(
    json['DeinterlaceMethod'],
  ),
  enableDecodingColorDepth10Hevc:
      json['EnableDecodingColorDepth10Hevc'] as bool?,
  enableDecodingColorDepth10Vp9: json['EnableDecodingColorDepth10Vp9'] as bool?,
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
  hardwareDecodingCodecs:
      (json['HardwareDecodingCodecs'] as List<dynamic>?)
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

Map<String, dynamic> _$EncodingOptionsToJson(
  EncodingOptions instance,
) => <String, dynamic>{
  'EncodingThreadCount': ?instance.encodingThreadCount,
  'TranscodingTempPath': ?instance.transcodingTempPath,
  'FallbackFontPath': ?instance.fallbackFontPath,
  'EnableFallbackFont': ?instance.enableFallbackFont,
  'EnableAudioVbr': ?instance.enableAudioVbr,
  'DownMixAudioBoost': ?instance.downMixAudioBoost,
  'DownMixStereoAlgorithm': ?downMixStereoAlgorithmsNullableToJson(
    instance.downMixStereoAlgorithm,
  ),
  'MaxMuxingQueueSize': ?instance.maxMuxingQueueSize,
  'EnableThrottling': ?instance.enableThrottling,
  'ThrottleDelaySeconds': ?instance.throttleDelaySeconds,
  'EnableSegmentDeletion': ?instance.enableSegmentDeletion,
  'SegmentKeepSeconds': ?instance.segmentKeepSeconds,
  'HardwareAccelerationType': ?hardwareAccelerationTypeNullableToJson(
    instance.hardwareAccelerationType,
  ),
  'EncoderAppPath': ?instance.encoderAppPath,
  'EncoderAppPathDisplay': ?instance.encoderAppPathDisplay,
  'VaapiDevice': ?instance.vaapiDevice,
  'QsvDevice': ?instance.qsvDevice,
  'EnableTonemapping': ?instance.enableTonemapping,
  'EnableVppTonemapping': ?instance.enableVppTonemapping,
  'EnableVideoToolboxTonemapping': ?instance.enableVideoToolboxTonemapping,
  'TonemappingAlgorithm': ?tonemappingAlgorithmNullableToJson(
    instance.tonemappingAlgorithm,
  ),
  'TonemappingMode': ?tonemappingModeNullableToJson(instance.tonemappingMode),
  'TonemappingRange': ?tonemappingRangeNullableToJson(
    instance.tonemappingRange,
  ),
  'TonemappingDesat': ?instance.tonemappingDesat,
  'TonemappingPeak': ?instance.tonemappingPeak,
  'TonemappingParam': ?instance.tonemappingParam,
  'VppTonemappingBrightness': ?instance.vppTonemappingBrightness,
  'VppTonemappingContrast': ?instance.vppTonemappingContrast,
  'H264Crf': ?instance.h264Crf,
  'H265Crf': ?instance.h265Crf,
  'EncoderPreset': ?encoderPresetNullableToJson(instance.encoderPreset),
  'DeinterlaceDoubleRate': ?instance.deinterlaceDoubleRate,
  'DeinterlaceMethod': ?deinterlaceMethodNullableToJson(
    instance.deinterlaceMethod,
  ),
  'EnableDecodingColorDepth10Hevc': ?instance.enableDecodingColorDepth10Hevc,
  'EnableDecodingColorDepth10Vp9': ?instance.enableDecodingColorDepth10Vp9,
  'EnableDecodingColorDepth10HevcRext':
      ?instance.enableDecodingColorDepth10HevcRext,
  'EnableDecodingColorDepth12HevcRext':
      ?instance.enableDecodingColorDepth12HevcRext,
  'EnableEnhancedNvdecDecoder': ?instance.enableEnhancedNvdecDecoder,
  'PreferSystemNativeHwDecoder': ?instance.preferSystemNativeHwDecoder,
  'EnableIntelLowPowerH264HwEncoder':
      ?instance.enableIntelLowPowerH264HwEncoder,
  'EnableIntelLowPowerHevcHwEncoder':
      ?instance.enableIntelLowPowerHevcHwEncoder,
  'EnableHardwareEncoding': ?instance.enableHardwareEncoding,
  'AllowHevcEncoding': ?instance.allowHevcEncoding,
  'AllowAv1Encoding': ?instance.allowAv1Encoding,
  'EnableSubtitleExtraction': ?instance.enableSubtitleExtraction,
  'HardwareDecodingCodecs': ?instance.hardwareDecodingCodecs,
  'AllowOnDemandMetadataBasedKeyframeExtractionForExtensions':
      ?instance.allowOnDemandMetadataBasedKeyframeExtractionForExtensions,
};

EndPointInfo _$EndPointInfoFromJson(Map<String, dynamic> json) => EndPointInfo(
  isLocal: json['IsLocal'] as bool?,
  isInNetwork: json['IsInNetwork'] as bool?,
);

Map<String, dynamic> _$EndPointInfoToJson(EndPointInfo instance) =>
    <String, dynamic>{
      'IsLocal': ?instance.isLocal,
      'IsInNetwork': ?instance.isInNetwork,
    };

ExternalIdInfo _$ExternalIdInfoFromJson(Map<String, dynamic> json) =>
    ExternalIdInfo(
      name: json['Name'] as String?,
      key: json['Key'] as String?,
      type: externalIdMediaTypeNullableFromJson(json['Type']),
    );

Map<String, dynamic> _$ExternalIdInfoToJson(ExternalIdInfo instance) =>
    <String, dynamic>{
      'Name': ?instance.name,
      'Key': ?instance.key,
      'Type': ?externalIdMediaTypeNullableToJson(instance.type),
    };

ExternalUrl _$ExternalUrlFromJson(Map<String, dynamic> json) =>
    ExternalUrl(name: json['Name'] as String?, url: json['Url'] as String?);

Map<String, dynamic> _$ExternalUrlToJson(ExternalUrl instance) =>
    <String, dynamic>{'Name': ?instance.name, 'Url': ?instance.url};

FileSystemEntryInfo _$FileSystemEntryInfoFromJson(Map<String, dynamic> json) =>
    FileSystemEntryInfo(
      name: json['Name'] as String?,
      path: json['Path'] as String?,
      type: fileSystemEntryTypeNullableFromJson(json['Type']),
    );

Map<String, dynamic> _$FileSystemEntryInfoToJson(
  FileSystemEntryInfo instance,
) => <String, dynamic>{
  'Name': ?instance.name,
  'Path': ?instance.path,
  'Type': ?fileSystemEntryTypeNullableToJson(instance.type),
};

FolderStorageDto _$FolderStorageDtoFromJson(Map<String, dynamic> json) =>
    FolderStorageDto(
      path: json['Path'] as String?,
      freeSpace: (json['FreeSpace'] as num?)?.toInt(),
      usedSpace: (json['UsedSpace'] as num?)?.toInt(),
      storageType: json['StorageType'] as String?,
      deviceId: json['DeviceId'] as String?,
    );

Map<String, dynamic> _$FolderStorageDtoToJson(FolderStorageDto instance) =>
    <String, dynamic>{
      'Path': ?instance.path,
      'FreeSpace': ?instance.freeSpace,
      'UsedSpace': ?instance.usedSpace,
      'StorageType': ?instance.storageType,
      'DeviceId': ?instance.deviceId,
    };

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

Map<String, dynamic> _$FontFileToJson(FontFile instance) => <String, dynamic>{
  'Name': ?instance.name,
  'Size': ?instance.size,
  'DateCreated': ?instance.dateCreated?.toIso8601String(),
  'DateModified': ?instance.dateModified?.toIso8601String(),
};

ForceKeepAliveMessage _$ForceKeepAliveMessageFromJson(
  Map<String, dynamic> json,
) => ForceKeepAliveMessage(
  data: (json['Data'] as num?)?.toInt(),
  messageId: json['MessageId'] as String?,
  messageType:
      ForceKeepAliveMessage.sessionMessageTypeMessageTypeNullableFromJson(
        json['MessageType'],
      ),
);

Map<String, dynamic> _$ForceKeepAliveMessageToJson(
  ForceKeepAliveMessage instance,
) => <String, dynamic>{
  'Data': ?instance.data,
  'MessageId': ?instance.messageId,
  'MessageType': ?sessionMessageTypeNullableToJson(instance.messageType),
};

ForgotPasswordDto _$ForgotPasswordDtoFromJson(Map<String, dynamic> json) =>
    ForgotPasswordDto(enteredUsername: json['EnteredUsername'] as String);

Map<String, dynamic> _$ForgotPasswordDtoToJson(ForgotPasswordDto instance) =>
    <String, dynamic>{'EnteredUsername': instance.enteredUsername};

ForgotPasswordPinDto _$ForgotPasswordPinDtoFromJson(
  Map<String, dynamic> json,
) => ForgotPasswordPinDto(pin: json['Pin'] as String);

Map<String, dynamic> _$ForgotPasswordPinDtoToJson(
  ForgotPasswordPinDto instance,
) => <String, dynamic>{'Pin': instance.pin};

ForgotPasswordResult _$ForgotPasswordResultFromJson(
  Map<String, dynamic> json,
) => ForgotPasswordResult(
  action: forgotPasswordActionNullableFromJson(json['Action']),
  pinFile: json['PinFile'] as String?,
  pinExpirationDate: json['PinExpirationDate'] == null
      ? null
      : DateTime.parse(json['PinExpirationDate'] as String),
);

Map<String, dynamic> _$ForgotPasswordResultToJson(
  ForgotPasswordResult instance,
) => <String, dynamic>{
  'Action': ?forgotPasswordActionNullableToJson(instance.action),
  'PinFile': ?instance.pinFile,
  'PinExpirationDate': ?instance.pinExpirationDate?.toIso8601String(),
};

GeneralCommand _$GeneralCommandFromJson(Map<String, dynamic> json) =>
    GeneralCommand(
      name: generalCommandTypeNullableFromJson(json['Name']),
      controllingUserId: json['ControllingUserId'] as String?,
      arguments: json['Arguments'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$GeneralCommandToJson(GeneralCommand instance) =>
    <String, dynamic>{
      'Name': ?generalCommandTypeNullableToJson(instance.name),
      'ControllingUserId': ?instance.controllingUserId,
      'Arguments': ?instance.arguments,
    };

GeneralCommandMessage _$GeneralCommandMessageFromJson(
  Map<String, dynamic> json,
) => GeneralCommandMessage(
  data: json['Data'] == null
      ? null
      : GeneralCommand.fromJson(json['Data'] as Map<String, dynamic>),
  messageId: json['MessageId'] as String?,
  messageType:
      GeneralCommandMessage.sessionMessageTypeMessageTypeNullableFromJson(
        json['MessageType'],
      ),
);

Map<String, dynamic> _$GeneralCommandMessageToJson(
  GeneralCommandMessage instance,
) => <String, dynamic>{
  'Data': ?instance.data?.toJson(),
  'MessageId': ?instance.messageId,
  'MessageType': ?sessionMessageTypeNullableToJson(instance.messageType),
};

GetProgramsDto _$GetProgramsDtoFromJson(
  Map<String, dynamic> json,
) => GetProgramsDto(
  channelIds:
      (json['ChannelIds'] as List<dynamic>?)
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
  genres:
      (json['Genres'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      [],
  genreIds:
      (json['GenreIds'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      [],
  enableImages: json['EnableImages'] as bool?,
  enableTotalRecordCount: json['EnableTotalRecordCount'] as bool? ?? true,
  imageTypeLimit: (json['ImageTypeLimit'] as num?)?.toInt(),
  enableImageTypes: imageTypeListFromJson(json['EnableImageTypes'] as List?),
  enableUserData: json['EnableUserData'] as bool?,
  seriesTimerId: json['SeriesTimerId'] as String?,
  librarySeriesId: json['LibrarySeriesId'] as String?,
  fields: itemFieldsListFromJson(json['Fields'] as List?),
);

Map<String, dynamic> _$GetProgramsDtoToJson(GetProgramsDto instance) =>
    <String, dynamic>{
      'ChannelIds': ?instance.channelIds,
      'UserId': ?instance.userId,
      'MinStartDate': ?instance.minStartDate?.toIso8601String(),
      'HasAired': ?instance.hasAired,
      'IsAiring': ?instance.isAiring,
      'MaxStartDate': ?instance.maxStartDate?.toIso8601String(),
      'MinEndDate': ?instance.minEndDate?.toIso8601String(),
      'MaxEndDate': ?instance.maxEndDate?.toIso8601String(),
      'IsMovie': ?instance.isMovie,
      'IsSeries': ?instance.isSeries,
      'IsNews': ?instance.isNews,
      'IsKids': ?instance.isKids,
      'IsSports': ?instance.isSports,
      'StartIndex': ?instance.startIndex,
      'Limit': ?instance.limit,
      'SortBy': itemSortByListToJson(instance.sortBy),
      'SortOrder': sortOrderListToJson(instance.sortOrder),
      'Genres': ?instance.genres,
      'GenreIds': ?instance.genreIds,
      'EnableImages': ?instance.enableImages,
      'EnableTotalRecordCount': ?instance.enableTotalRecordCount,
      'ImageTypeLimit': ?instance.imageTypeLimit,
      'EnableImageTypes': imageTypeListToJson(instance.enableImageTypes),
      'EnableUserData': ?instance.enableUserData,
      'SeriesTimerId': ?instance.seriesTimerId,
      'LibrarySeriesId': ?instance.librarySeriesId,
      'Fields': itemFieldsListToJson(instance.fields),
    };

GroupInfoDto _$GroupInfoDtoFromJson(Map<String, dynamic> json) => GroupInfoDto(
  groupId: json['GroupId'] as String?,
  groupName: json['GroupName'] as String?,
  state: groupStateTypeNullableFromJson(json['State']),
  participants:
      (json['Participants'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  lastUpdatedAt: json['LastUpdatedAt'] == null
      ? null
      : DateTime.parse(json['LastUpdatedAt'] as String),
);

Map<String, dynamic> _$GroupInfoDtoToJson(GroupInfoDto instance) =>
    <String, dynamic>{
      'GroupId': ?instance.groupId,
      'GroupName': ?instance.groupName,
      'State': ?groupStateTypeNullableToJson(instance.state),
      'Participants': ?instance.participants,
      'LastUpdatedAt': ?instance.lastUpdatedAt?.toIso8601String(),
    };

GroupStateUpdate _$GroupStateUpdateFromJson(Map<String, dynamic> json) =>
    GroupStateUpdate(
      state: groupStateTypeNullableFromJson(json['State']),
      reason: playbackRequestTypeNullableFromJson(json['Reason']),
    );

Map<String, dynamic> _$GroupStateUpdateToJson(GroupStateUpdate instance) =>
    <String, dynamic>{
      'State': ?groupStateTypeNullableToJson(instance.state),
      'Reason': ?playbackRequestTypeNullableToJson(instance.reason),
    };

GroupUpdate _$GroupUpdateFromJson(Map<String, dynamic> json) => GroupUpdate();

Map<String, dynamic> _$GroupUpdateToJson(GroupUpdate instance) =>
    <String, dynamic>{};

GuideInfo _$GuideInfoFromJson(Map<String, dynamic> json) => GuideInfo(
  startDate: json['StartDate'] == null
      ? null
      : DateTime.parse(json['StartDate'] as String),
  endDate: json['EndDate'] == null
      ? null
      : DateTime.parse(json['EndDate'] as String),
);

Map<String, dynamic> _$GuideInfoToJson(GuideInfo instance) => <String, dynamic>{
  'StartDate': ?instance.startDate?.toIso8601String(),
  'EndDate': ?instance.endDate?.toIso8601String(),
};

IgnoreWaitRequestDto _$IgnoreWaitRequestDtoFromJson(
  Map<String, dynamic> json,
) => IgnoreWaitRequestDto(ignoreWait: json['IgnoreWait'] as bool?);

Map<String, dynamic> _$IgnoreWaitRequestDtoToJson(
  IgnoreWaitRequestDto instance,
) => <String, dynamic>{'IgnoreWait': ?instance.ignoreWait};

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

Map<String, dynamic> _$ImageInfoToJson(ImageInfo instance) => <String, dynamic>{
  'ImageType': ?imageTypeNullableToJson(instance.imageType),
  'ImageIndex': ?instance.imageIndex,
  'ImageTag': ?instance.imageTag,
  'Path': ?instance.path,
  'BlurHash': ?instance.blurHash,
  'Height': ?instance.height,
  'Width': ?instance.width,
  'Size': ?instance.size,
};

ImageOption _$ImageOptionFromJson(Map<String, dynamic> json) => ImageOption(
  type: imageTypeNullableFromJson(json['Type']),
  limit: (json['Limit'] as num?)?.toInt(),
  minWidth: (json['MinWidth'] as num?)?.toInt(),
);

Map<String, dynamic> _$ImageOptionToJson(ImageOption instance) =>
    <String, dynamic>{
      'Type': ?imageTypeNullableToJson(instance.type),
      'Limit': ?instance.limit,
      'MinWidth': ?instance.minWidth,
    };

ImageProviderInfo _$ImageProviderInfoFromJson(Map<String, dynamic> json) =>
    ImageProviderInfo(
      name: json['Name'] as String?,
      supportedImages: imageTypeListFromJson(json['SupportedImages'] as List?),
    );

Map<String, dynamic> _$ImageProviderInfoToJson(ImageProviderInfo instance) =>
    <String, dynamic>{
      'Name': ?instance.name,
      'SupportedImages': imageTypeListToJson(instance.supportedImages),
    };

InboundKeepAliveMessage _$InboundKeepAliveMessageFromJson(
  Map<String, dynamic> json,
) => InboundKeepAliveMessage(
  messageType:
      InboundKeepAliveMessage.sessionMessageTypeMessageTypeNullableFromJson(
        json['MessageType'],
      ),
);

Map<String, dynamic> _$InboundKeepAliveMessageToJson(
  InboundKeepAliveMessage instance,
) => <String, dynamic>{
  'MessageType': ?sessionMessageTypeNullableToJson(instance.messageType),
};

InboundWebSocketMessage _$InboundWebSocketMessageFromJson(
  Map<String, dynamic> json,
) => InboundWebSocketMessage();

Map<String, dynamic> _$InboundWebSocketMessageToJson(
  InboundWebSocketMessage instance,
) => <String, dynamic>{};

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

Map<String, dynamic> _$InstallationInfoToJson(InstallationInfo instance) =>
    <String, dynamic>{
      'Guid': ?instance.guid,
      'Name': ?instance.name,
      'Version': ?instance.version,
      'Changelog': ?instance.changelog,
      'SourceUrl': ?instance.sourceUrl,
      'Checksum': ?instance.checksum,
      'PackageInfo': ?instance.packageInfo?.toJson(),
    };

IPlugin _$IPluginFromJson(Map<String, dynamic> json) => IPlugin(
  name: json['Name'] as String?,
  description: json['Description'] as String?,
  id: json['Id'] as String?,
  version: json['Version'] as String?,
  assemblyFilePath: json['AssemblyFilePath'] as String?,
  canUninstall: json['CanUninstall'] as bool?,
  dataFolderPath: json['DataFolderPath'] as String?,
);

Map<String, dynamic> _$IPluginToJson(IPlugin instance) => <String, dynamic>{
  'Name': ?instance.name,
  'Description': ?instance.description,
  'Id': ?instance.id,
  'Version': ?instance.version,
  'AssemblyFilePath': ?instance.assemblyFilePath,
  'CanUninstall': ?instance.canUninstall,
  'DataFolderPath': ?instance.dataFolderPath,
};

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

Map<String, dynamic> _$ItemCountsToJson(ItemCounts instance) =>
    <String, dynamic>{
      'MovieCount': ?instance.movieCount,
      'SeriesCount': ?instance.seriesCount,
      'EpisodeCount': ?instance.episodeCount,
      'ArtistCount': ?instance.artistCount,
      'ProgramCount': ?instance.programCount,
      'TrailerCount': ?instance.trailerCount,
      'SongCount': ?instance.songCount,
      'AlbumCount': ?instance.albumCount,
      'MusicVideoCount': ?instance.musicVideoCount,
      'BoxSetCount': ?instance.boxSetCount,
      'BookCount': ?instance.bookCount,
      'ItemCount': ?instance.itemCount,
    };

JoinGroupRequestDto _$JoinGroupRequestDtoFromJson(Map<String, dynamic> json) =>
    JoinGroupRequestDto(groupId: json['GroupId'] as String?);

Map<String, dynamic> _$JoinGroupRequestDtoToJson(
  JoinGroupRequestDto instance,
) => <String, dynamic>{'GroupId': ?instance.groupId};

LibraryChangedMessage _$LibraryChangedMessageFromJson(
  Map<String, dynamic> json,
) => LibraryChangedMessage(
  data: json['Data'] == null
      ? null
      : LibraryUpdateInfo.fromJson(json['Data'] as Map<String, dynamic>),
  messageId: json['MessageId'] as String?,
  messageType:
      LibraryChangedMessage.sessionMessageTypeMessageTypeNullableFromJson(
        json['MessageType'],
      ),
);

Map<String, dynamic> _$LibraryChangedMessageToJson(
  LibraryChangedMessage instance,
) => <String, dynamic>{
  'Data': ?instance.data?.toJson(),
  'MessageId': ?instance.messageId,
  'MessageType': ?sessionMessageTypeNullableToJson(instance.messageType),
};

LibraryOptionInfoDto _$LibraryOptionInfoDtoFromJson(
  Map<String, dynamic> json,
) => LibraryOptionInfoDto(
  name: json['Name'] as String?,
  defaultEnabled: json['DefaultEnabled'] as bool?,
);

Map<String, dynamic> _$LibraryOptionInfoDtoToJson(
  LibraryOptionInfoDto instance,
) => <String, dynamic>{
  'Name': ?instance.name,
  'DefaultEnabled': ?instance.defaultEnabled,
};

LibraryOptions _$LibraryOptionsFromJson(
  Map<String, dynamic> json,
) => LibraryOptions(
  enabled: json['Enabled'] as bool?,
  enablePhotos: json['EnablePhotos'] as bool?,
  enableRealtimeMonitor: json['EnableRealtimeMonitor'] as bool?,
  enableLUFSScan: json['EnableLUFSScan'] as bool?,
  enableChapterImageExtraction: json['EnableChapterImageExtraction'] as bool?,
  extractChapterImagesDuringLibraryScan:
      json['ExtractChapterImagesDuringLibraryScan'] as bool?,
  enableTrickplayImageExtraction:
      json['EnableTrickplayImageExtraction'] as bool?,
  extractTrickplayImagesDuringLibraryScan:
      json['ExtractTrickplayImagesDuringLibraryScan'] as bool?,
  pathInfos:
      (json['PathInfos'] as List<dynamic>?)
          ?.map((e) => MediaPathInfo.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  saveLocalMetadata: json['SaveLocalMetadata'] as bool?,
  enableInternetProviders: json['EnableInternetProviders'] as bool?,
  enableAutomaticSeriesGrouping: json['EnableAutomaticSeriesGrouping'] as bool?,
  enableEmbeddedTitles: json['EnableEmbeddedTitles'] as bool?,
  enableEmbeddedExtrasTitles: json['EnableEmbeddedExtrasTitles'] as bool?,
  enableEmbeddedEpisodeInfos: json['EnableEmbeddedEpisodeInfos'] as bool?,
  automaticRefreshIntervalDays: (json['AutomaticRefreshIntervalDays'] as num?)
      ?.toInt(),
  preferredMetadataLanguage: json['PreferredMetadataLanguage'] as String?,
  metadataCountryCode: json['MetadataCountryCode'] as String?,
  seasonZeroDisplayName: json['SeasonZeroDisplayName'] as String?,
  metadataSavers:
      (json['MetadataSavers'] as List<dynamic>?)
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
  subtitleFetcherOrder:
      (json['SubtitleFetcherOrder'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  disabledMediaSegmentProviders:
      (json['DisabledMediaSegmentProviders'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  mediaSegmentProviderOrder:
      (json['MediaSegmentProviderOrder'] as List<dynamic>?)
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
  disabledLyricFetchers:
      (json['DisabledLyricFetchers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  lyricFetcherOrder:
      (json['LyricFetcherOrder'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  preferNonstandardArtistsTag:
      json['PreferNonstandardArtistsTag'] as bool? ?? false,
  useCustomTagDelimiters: json['UseCustomTagDelimiters'] as bool? ?? false,
  customTagDelimiters:
      (json['CustomTagDelimiters'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  delimiterWhitelist:
      (json['DelimiterWhitelist'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  automaticallyAddToCollection: json['AutomaticallyAddToCollection'] as bool?,
  allowEmbeddedSubtitles: embeddedSubtitleOptionsNullableFromJson(
    json['AllowEmbeddedSubtitles'],
  ),
  typeOptions:
      (json['TypeOptions'] as List<dynamic>?)
          ?.map((e) => TypeOptions.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$LibraryOptionsToJson(
  LibraryOptions instance,
) => <String, dynamic>{
  'Enabled': ?instance.enabled,
  'EnablePhotos': ?instance.enablePhotos,
  'EnableRealtimeMonitor': ?instance.enableRealtimeMonitor,
  'EnableLUFSScan': ?instance.enableLUFSScan,
  'EnableChapterImageExtraction': ?instance.enableChapterImageExtraction,
  'ExtractChapterImagesDuringLibraryScan':
      ?instance.extractChapterImagesDuringLibraryScan,
  'EnableTrickplayImageExtraction': ?instance.enableTrickplayImageExtraction,
  'ExtractTrickplayImagesDuringLibraryScan':
      ?instance.extractTrickplayImagesDuringLibraryScan,
  'PathInfos': ?instance.pathInfos?.map((e) => e.toJson()).toList(),
  'SaveLocalMetadata': ?instance.saveLocalMetadata,
  'EnableInternetProviders': ?instance.enableInternetProviders,
  'EnableAutomaticSeriesGrouping': ?instance.enableAutomaticSeriesGrouping,
  'EnableEmbeddedTitles': ?instance.enableEmbeddedTitles,
  'EnableEmbeddedExtrasTitles': ?instance.enableEmbeddedExtrasTitles,
  'EnableEmbeddedEpisodeInfos': ?instance.enableEmbeddedEpisodeInfos,
  'AutomaticRefreshIntervalDays': ?instance.automaticRefreshIntervalDays,
  'PreferredMetadataLanguage': ?instance.preferredMetadataLanguage,
  'MetadataCountryCode': ?instance.metadataCountryCode,
  'SeasonZeroDisplayName': ?instance.seasonZeroDisplayName,
  'MetadataSavers': ?instance.metadataSavers,
  'DisabledLocalMetadataReaders': ?instance.disabledLocalMetadataReaders,
  'LocalMetadataReaderOrder': ?instance.localMetadataReaderOrder,
  'DisabledSubtitleFetchers': ?instance.disabledSubtitleFetchers,
  'SubtitleFetcherOrder': ?instance.subtitleFetcherOrder,
  'DisabledMediaSegmentProviders': ?instance.disabledMediaSegmentProviders,
  'MediaSegmentProviderOrder': ?instance.mediaSegmentProviderOrder,
  'SkipSubtitlesIfEmbeddedSubtitlesPresent':
      ?instance.skipSubtitlesIfEmbeddedSubtitlesPresent,
  'SkipSubtitlesIfAudioTrackMatches':
      ?instance.skipSubtitlesIfAudioTrackMatches,
  'SubtitleDownloadLanguages': ?instance.subtitleDownloadLanguages,
  'RequirePerfectSubtitleMatch': ?instance.requirePerfectSubtitleMatch,
  'SaveSubtitlesWithMedia': ?instance.saveSubtitlesWithMedia,
  'SaveLyricsWithMedia': ?instance.saveLyricsWithMedia,
  'SaveTrickplayWithMedia': ?instance.saveTrickplayWithMedia,
  'DisabledLyricFetchers': ?instance.disabledLyricFetchers,
  'LyricFetcherOrder': ?instance.lyricFetcherOrder,
  'PreferNonstandardArtistsTag': ?instance.preferNonstandardArtistsTag,
  'UseCustomTagDelimiters': ?instance.useCustomTagDelimiters,
  'CustomTagDelimiters': ?instance.customTagDelimiters,
  'DelimiterWhitelist': ?instance.delimiterWhitelist,
  'AutomaticallyAddToCollection': ?instance.automaticallyAddToCollection,
  'AllowEmbeddedSubtitles': ?embeddedSubtitleOptionsNullableToJson(
    instance.allowEmbeddedSubtitles,
  ),
  'TypeOptions': ?instance.typeOptions?.map((e) => e.toJson()).toList(),
};

LibraryOptionsResultDto _$LibraryOptionsResultDtoFromJson(
  Map<String, dynamic> json,
) => LibraryOptionsResultDto(
  metadataSavers:
      (json['MetadataSavers'] as List<dynamic>?)
          ?.map((e) => LibraryOptionInfoDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  metadataReaders:
      (json['MetadataReaders'] as List<dynamic>?)
          ?.map((e) => LibraryOptionInfoDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  subtitleFetchers:
      (json['SubtitleFetchers'] as List<dynamic>?)
          ?.map((e) => LibraryOptionInfoDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  lyricFetchers:
      (json['LyricFetchers'] as List<dynamic>?)
          ?.map((e) => LibraryOptionInfoDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  mediaSegmentProviders:
      (json['MediaSegmentProviders'] as List<dynamic>?)
          ?.map((e) => LibraryOptionInfoDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  typeOptions:
      (json['TypeOptions'] as List<dynamic>?)
          ?.map(
            (e) => LibraryTypeOptionsDto.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      [],
);

Map<String, dynamic> _$LibraryOptionsResultDtoToJson(
  LibraryOptionsResultDto instance,
) => <String, dynamic>{
  'MetadataSavers': ?instance.metadataSavers?.map((e) => e.toJson()).toList(),
  'MetadataReaders': ?instance.metadataReaders?.map((e) => e.toJson()).toList(),
  'SubtitleFetchers': ?instance.subtitleFetchers
      ?.map((e) => e.toJson())
      .toList(),
  'LyricFetchers': ?instance.lyricFetchers?.map((e) => e.toJson()).toList(),
  'MediaSegmentProviders': ?instance.mediaSegmentProviders
      ?.map((e) => e.toJson())
      .toList(),
  'TypeOptions': ?instance.typeOptions?.map((e) => e.toJson()).toList(),
};

LibraryStorageDto _$LibraryStorageDtoFromJson(Map<String, dynamic> json) =>
    LibraryStorageDto(
      id: json['Id'] as String?,
      name: json['Name'] as String?,
      folders:
          (json['Folders'] as List<dynamic>?)
              ?.map((e) => FolderStorageDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$LibraryStorageDtoToJson(LibraryStorageDto instance) =>
    <String, dynamic>{
      'Id': ?instance.id,
      'Name': ?instance.name,
      'Folders': ?instance.folders?.map((e) => e.toJson()).toList(),
    };

LibraryTypeOptionsDto _$LibraryTypeOptionsDtoFromJson(
  Map<String, dynamic> json,
) => LibraryTypeOptionsDto(
  type: json['Type'] as String?,
  metadataFetchers:
      (json['MetadataFetchers'] as List<dynamic>?)
          ?.map((e) => LibraryOptionInfoDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  imageFetchers:
      (json['ImageFetchers'] as List<dynamic>?)
          ?.map((e) => LibraryOptionInfoDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  supportedImageTypes: imageTypeListFromJson(
    json['SupportedImageTypes'] as List?,
  ),
  defaultImageOptions:
      (json['DefaultImageOptions'] as List<dynamic>?)
          ?.map((e) => ImageOption.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$LibraryTypeOptionsDtoToJson(
  LibraryTypeOptionsDto instance,
) => <String, dynamic>{
  'Type': ?instance.type,
  'MetadataFetchers': ?instance.metadataFetchers
      ?.map((e) => e.toJson())
      .toList(),
  'ImageFetchers': ?instance.imageFetchers?.map((e) => e.toJson()).toList(),
  'SupportedImageTypes': imageTypeListToJson(instance.supportedImageTypes),
  'DefaultImageOptions': ?instance.defaultImageOptions
      ?.map((e) => e.toJson())
      .toList(),
};

LibraryUpdateInfo _$LibraryUpdateInfoFromJson(Map<String, dynamic> json) =>
    LibraryUpdateInfo(
      foldersAddedTo:
          (json['FoldersAddedTo'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      foldersRemovedFrom:
          (json['FoldersRemovedFrom'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      itemsAdded:
          (json['ItemsAdded'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      itemsRemoved:
          (json['ItemsRemoved'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      itemsUpdated:
          (json['ItemsUpdated'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      collectionFolders:
          (json['CollectionFolders'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      isEmpty: json['IsEmpty'] as bool?,
    );

Map<String, dynamic> _$LibraryUpdateInfoToJson(LibraryUpdateInfo instance) =>
    <String, dynamic>{
      'FoldersAddedTo': ?instance.foldersAddedTo,
      'FoldersRemovedFrom': ?instance.foldersRemovedFrom,
      'ItemsAdded': ?instance.itemsAdded,
      'ItemsRemoved': ?instance.itemsRemoved,
      'ItemsUpdated': ?instance.itemsUpdated,
      'CollectionFolders': ?instance.collectionFolders,
      'IsEmpty': ?instance.isEmpty,
    };

ListingsProviderInfo _$ListingsProviderInfoFromJson(
  Map<String, dynamic> json,
) => ListingsProviderInfo(
  id: json['Id'] as String?,
  type: json['Type'] as String?,
  username: json['Username'] as String?,
  password: json['Password'] as String?,
  listingsId: json['ListingsId'] as String?,
  zipCode: json['ZipCode'] as String?,
  country: json['Country'] as String?,
  path: json['Path'] as String?,
  enabledTuners:
      (json['EnabledTuners'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  enableAllTuners: json['EnableAllTuners'] as bool?,
  newsCategories:
      (json['NewsCategories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  sportsCategories:
      (json['SportsCategories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  kidsCategories:
      (json['KidsCategories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  movieCategories:
      (json['MovieCategories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  channelMappings:
      (json['ChannelMappings'] as List<dynamic>?)
          ?.map((e) => NameValuePair.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  moviePrefix: json['MoviePrefix'] as String?,
  preferredLanguage: json['PreferredLanguage'] as String?,
  userAgent: json['UserAgent'] as String?,
);

Map<String, dynamic> _$ListingsProviderInfoToJson(
  ListingsProviderInfo instance,
) => <String, dynamic>{
  'Id': ?instance.id,
  'Type': ?instance.type,
  'Username': ?instance.username,
  'Password': ?instance.password,
  'ListingsId': ?instance.listingsId,
  'ZipCode': ?instance.zipCode,
  'Country': ?instance.country,
  'Path': ?instance.path,
  'EnabledTuners': ?instance.enabledTuners,
  'EnableAllTuners': ?instance.enableAllTuners,
  'NewsCategories': ?instance.newsCategories,
  'SportsCategories': ?instance.sportsCategories,
  'KidsCategories': ?instance.kidsCategories,
  'MovieCategories': ?instance.movieCategories,
  'ChannelMappings': ?instance.channelMappings?.map((e) => e.toJson()).toList(),
  'MoviePrefix': ?instance.moviePrefix,
  'PreferredLanguage': ?instance.preferredLanguage,
  'UserAgent': ?instance.userAgent,
};

LiveStreamResponse _$LiveStreamResponseFromJson(Map<String, dynamic> json) =>
    LiveStreamResponse(
      mediaSource: json['MediaSource'] == null
          ? null
          : MediaSourceInfo.fromJson(
              json['MediaSource'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$LiveStreamResponseToJson(LiveStreamResponse instance) =>
    <String, dynamic>{'MediaSource': ?instance.mediaSource?.toJson()};

LiveTvInfo _$LiveTvInfoFromJson(Map<String, dynamic> json) => LiveTvInfo(
  services:
      (json['Services'] as List<dynamic>?)
          ?.map((e) => LiveTvServiceInfo.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  isEnabled: json['IsEnabled'] as bool?,
  enabledUsers:
      (json['EnabledUsers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
);

Map<String, dynamic> _$LiveTvInfoToJson(LiveTvInfo instance) =>
    <String, dynamic>{
      'Services': ?instance.services?.map((e) => e.toJson()).toList(),
      'IsEnabled': ?instance.isEnabled,
      'EnabledUsers': ?instance.enabledUsers,
    };

LiveTvOptions _$LiveTvOptionsFromJson(Map<String, dynamic> json) =>
    LiveTvOptions(
      guideDays: (json['GuideDays'] as num?)?.toInt(),
      recordingPath: json['RecordingPath'] as String?,
      movieRecordingPath: json['MovieRecordingPath'] as String?,
      seriesRecordingPath: json['SeriesRecordingPath'] as String?,
      enableRecordingSubfolders: json['EnableRecordingSubfolders'] as bool?,
      enableOriginalAudioWithEncodedRecordings:
          json['EnableOriginalAudioWithEncodedRecordings'] as bool?,
      tunerHosts:
          (json['TunerHosts'] as List<dynamic>?)
              ?.map((e) => TunerHostInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      listingProviders:
          (json['ListingProviders'] as List<dynamic>?)
              ?.map(
                (e) => ListingsProviderInfo.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      prePaddingSeconds: (json['PrePaddingSeconds'] as num?)?.toInt(),
      postPaddingSeconds: (json['PostPaddingSeconds'] as num?)?.toInt(),
      mediaLocationsCreated:
          (json['MediaLocationsCreated'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      recordingPostProcessor: json['RecordingPostProcessor'] as String?,
      recordingPostProcessorArguments:
          json['RecordingPostProcessorArguments'] as String?,
      saveRecordingNFO: json['SaveRecordingNFO'] as bool?,
      saveRecordingImages: json['SaveRecordingImages'] as bool?,
    );

Map<String, dynamic> _$LiveTvOptionsToJson(
  LiveTvOptions instance,
) => <String, dynamic>{
  'GuideDays': ?instance.guideDays,
  'RecordingPath': ?instance.recordingPath,
  'MovieRecordingPath': ?instance.movieRecordingPath,
  'SeriesRecordingPath': ?instance.seriesRecordingPath,
  'EnableRecordingSubfolders': ?instance.enableRecordingSubfolders,
  'EnableOriginalAudioWithEncodedRecordings':
      ?instance.enableOriginalAudioWithEncodedRecordings,
  'TunerHosts': ?instance.tunerHosts?.map((e) => e.toJson()).toList(),
  'ListingProviders': ?instance.listingProviders
      ?.map((e) => e.toJson())
      .toList(),
  'PrePaddingSeconds': ?instance.prePaddingSeconds,
  'PostPaddingSeconds': ?instance.postPaddingSeconds,
  'MediaLocationsCreated': ?instance.mediaLocationsCreated,
  'RecordingPostProcessor': ?instance.recordingPostProcessor,
  'RecordingPostProcessorArguments': ?instance.recordingPostProcessorArguments,
  'SaveRecordingNFO': ?instance.saveRecordingNFO,
  'SaveRecordingImages': ?instance.saveRecordingImages,
};

LiveTvServiceInfo _$LiveTvServiceInfoFromJson(Map<String, dynamic> json) =>
    LiveTvServiceInfo(
      name: json['Name'] as String?,
      homePageUrl: json['HomePageUrl'] as String?,
      status: liveTvServiceStatusNullableFromJson(json['Status']),
      statusMessage: json['StatusMessage'] as String?,
      version: json['Version'] as String?,
      hasUpdateAvailable: json['HasUpdateAvailable'] as bool?,
      isVisible: json['IsVisible'] as bool?,
      tuners:
          (json['Tuners'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$LiveTvServiceInfoToJson(LiveTvServiceInfo instance) =>
    <String, dynamic>{
      'Name': ?instance.name,
      'HomePageUrl': ?instance.homePageUrl,
      'Status': ?liveTvServiceStatusNullableToJson(instance.status),
      'StatusMessage': ?instance.statusMessage,
      'Version': ?instance.version,
      'HasUpdateAvailable': ?instance.hasUpdateAvailable,
      'IsVisible': ?instance.isVisible,
      'Tuners': ?instance.tuners,
    };

LocalizationOption _$LocalizationOptionFromJson(Map<String, dynamic> json) =>
    LocalizationOption(
      name: json['Name'] as String?,
      value: json['Value'] as String?,
    );

Map<String, dynamic> _$LocalizationOptionToJson(LocalizationOption instance) =>
    <String, dynamic>{'Name': ?instance.name, 'Value': ?instance.value};

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

Map<String, dynamic> _$LogFileToJson(LogFile instance) => <String, dynamic>{
  'DateCreated': ?instance.dateCreated?.toIso8601String(),
  'DateModified': ?instance.dateModified?.toIso8601String(),
  'Size': ?instance.size,
  'Name': ?instance.name,
};

LoginInfoInput _$LoginInfoInputFromJson(Map<String, dynamic> json) =>
    LoginInfoInput(
      username: json['Username'] as String,
      password: json['Password'] as String,
    );

Map<String, dynamic> _$LoginInfoInputToJson(LoginInfoInput instance) =>
    <String, dynamic>{
      'Username': instance.username,
      'Password': instance.password,
    };

LyricDto _$LyricDtoFromJson(Map<String, dynamic> json) => LyricDto(
  metadata: json['Metadata'] == null
      ? null
      : LyricMetadata.fromJson(json['Metadata'] as Map<String, dynamic>),
  lyrics:
      (json['Lyrics'] as List<dynamic>?)
          ?.map((e) => LyricLine.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$LyricDtoToJson(LyricDto instance) => <String, dynamic>{
  'Metadata': ?instance.metadata?.toJson(),
  'Lyrics': ?instance.lyrics?.map((e) => e.toJson()).toList(),
};

LyricLine _$LyricLineFromJson(Map<String, dynamic> json) => LyricLine(
  text: json['Text'] as String?,
  start: (json['Start'] as num?)?.toInt(),
  cues:
      (json['Cues'] as List<dynamic>?)
          ?.map((e) => LyricLineCue.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$LyricLineToJson(LyricLine instance) => <String, dynamic>{
  'Text': ?instance.text,
  'Start': ?instance.start,
  'Cues': ?instance.cues?.map((e) => e.toJson()).toList(),
};

LyricLineCue _$LyricLineCueFromJson(Map<String, dynamic> json) => LyricLineCue(
  position: (json['Position'] as num?)?.toInt(),
  endPosition: (json['EndPosition'] as num?)?.toInt(),
  start: (json['Start'] as num?)?.toInt(),
  end: (json['End'] as num?)?.toInt(),
);

Map<String, dynamic> _$LyricLineCueToJson(LyricLineCue instance) =>
    <String, dynamic>{
      'Position': ?instance.position,
      'EndPosition': ?instance.endPosition,
      'Start': ?instance.start,
      'End': ?instance.end,
    };

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

Map<String, dynamic> _$LyricMetadataToJson(LyricMetadata instance) =>
    <String, dynamic>{
      'Artist': ?instance.artist,
      'Album': ?instance.album,
      'Title': ?instance.title,
      'Author': ?instance.author,
      'Length': ?instance.length,
      'By': ?instance.by,
      'Offset': ?instance.offset,
      'Creator': ?instance.creator,
      'Version': ?instance.version,
      'IsSynced': ?instance.isSynced,
    };

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

Map<String, dynamic> _$MediaAttachmentToJson(MediaAttachment instance) =>
    <String, dynamic>{
      'Codec': ?instance.codec,
      'CodecTag': ?instance.codecTag,
      'Comment': ?instance.comment,
      'Index': ?instance.index,
      'FileName': ?instance.fileName,
      'MimeType': ?instance.mimeType,
      'DeliveryUrl': ?instance.deliveryUrl,
    };

MediaPathDto _$MediaPathDtoFromJson(Map<String, dynamic> json) => MediaPathDto(
  name: json['Name'] as String,
  path: json['Path'] as String?,
  pathInfo: json['PathInfo'] == null
      ? null
      : MediaPathInfo.fromJson(json['PathInfo'] as Map<String, dynamic>),
);

Map<String, dynamic> _$MediaPathDtoToJson(MediaPathDto instance) =>
    <String, dynamic>{
      'Name': instance.name,
      'Path': ?instance.path,
      'PathInfo': ?instance.pathInfo?.toJson(),
    };

MediaPathInfo _$MediaPathInfoFromJson(Map<String, dynamic> json) =>
    MediaPathInfo(path: json['Path'] as String?);

Map<String, dynamic> _$MediaPathInfoToJson(MediaPathInfo instance) =>
    <String, dynamic>{'Path': ?instance.path};

MediaSegmentDto _$MediaSegmentDtoFromJson(Map<String, dynamic> json) =>
    MediaSegmentDto(
      id: json['Id'] as String?,
      itemId: json['ItemId'] as String?,
      type: MediaSegmentDto.mediaSegmentTypeTypeNullableFromJson(json['Type']),
      startTicks: (json['StartTicks'] as num?)?.toInt(),
      endTicks: (json['EndTicks'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MediaSegmentDtoToJson(MediaSegmentDto instance) =>
    <String, dynamic>{
      'Id': ?instance.id,
      'ItemId': ?instance.itemId,
      'Type': ?mediaSegmentTypeNullableToJson(instance.type),
      'StartTicks': ?instance.startTicks,
      'EndTicks': ?instance.endTicks,
    };

MediaSegmentDtoQueryResult _$MediaSegmentDtoQueryResultFromJson(
  Map<String, dynamic> json,
) => MediaSegmentDtoQueryResult(
  items:
      (json['Items'] as List<dynamic>?)
          ?.map((e) => MediaSegmentDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  totalRecordCount: (json['TotalRecordCount'] as num?)?.toInt(),
  startIndex: (json['StartIndex'] as num?)?.toInt(),
);

Map<String, dynamic> _$MediaSegmentDtoQueryResultToJson(
  MediaSegmentDtoQueryResult instance,
) => <String, dynamic>{
  'Items': ?instance.items?.map((e) => e.toJson()).toList(),
  'TotalRecordCount': ?instance.totalRecordCount,
  'StartIndex': ?instance.startIndex,
};

MediaSourceInfo _$MediaSourceInfoFromJson(
  Map<String, dynamic> json,
) => MediaSourceInfo(
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
  mediaStreams:
      (json['MediaStreams'] as List<dynamic>?)
          ?.map((e) => MediaStream.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  mediaAttachments:
      (json['MediaAttachments'] as List<dynamic>?)
          ?.map((e) => MediaAttachment.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  formats:
      (json['Formats'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      [],
  bitrate: (json['Bitrate'] as num?)?.toInt(),
  fallbackMaxStreamingBitrate: (json['FallbackMaxStreamingBitrate'] as num?)
      ?.toInt(),
  timestamp: transportStreamTimestampNullableFromJson(json['Timestamp']),
  requiredHttpHeaders: json['RequiredHttpHeaders'] as Map<String, dynamic>?,
  transcodingUrl: json['TranscodingUrl'] as String?,
  transcodingSubProtocol: mediaStreamProtocolNullableFromJson(
    json['TranscodingSubProtocol'],
  ),
  transcodingContainer: json['TranscodingContainer'] as String?,
  analyzeDurationMs: (json['AnalyzeDurationMs'] as num?)?.toInt(),
  defaultAudioStreamIndex: (json['DefaultAudioStreamIndex'] as num?)?.toInt(),
  defaultSubtitleStreamIndex: (json['DefaultSubtitleStreamIndex'] as num?)
      ?.toInt(),
  hasSegments: json['HasSegments'] as bool?,
);

Map<String, dynamic> _$MediaSourceInfoToJson(MediaSourceInfo instance) =>
    <String, dynamic>{
      'Protocol': ?mediaProtocolNullableToJson(instance.protocol),
      'Id': ?instance.id,
      'Path': ?instance.path,
      'EncoderPath': ?instance.encoderPath,
      'EncoderProtocol': ?mediaProtocolNullableToJson(instance.encoderProtocol),
      'Type': ?mediaSourceTypeNullableToJson(instance.type),
      'Container': ?instance.container,
      'Size': ?instance.size,
      'Name': ?instance.name,
      'IsRemote': ?instance.isRemote,
      'ETag': ?instance.eTag,
      'RunTimeTicks': ?instance.runTimeTicks,
      'ReadAtNativeFramerate': ?instance.readAtNativeFramerate,
      'IgnoreDts': ?instance.ignoreDts,
      'IgnoreIndex': ?instance.ignoreIndex,
      'GenPtsInput': ?instance.genPtsInput,
      'SupportsTranscoding': ?instance.supportsTranscoding,
      'SupportsDirectStream': ?instance.supportsDirectStream,
      'SupportsDirectPlay': ?instance.supportsDirectPlay,
      'IsInfiniteStream': ?instance.isInfiniteStream,
      'UseMostCompatibleTranscodingProfile':
          ?instance.useMostCompatibleTranscodingProfile,
      'RequiresOpening': ?instance.requiresOpening,
      'OpenToken': ?instance.openToken,
      'RequiresClosing': ?instance.requiresClosing,
      'LiveStreamId': ?instance.liveStreamId,
      'BufferMs': ?instance.bufferMs,
      'RequiresLooping': ?instance.requiresLooping,
      'SupportsProbing': ?instance.supportsProbing,
      'VideoType': ?videoTypeNullableToJson(instance.videoType),
      'IsoType': ?isoTypeNullableToJson(instance.isoType),
      'Video3DFormat': ?video3DFormatNullableToJson(instance.video3DFormat),
      'MediaStreams': ?instance.mediaStreams?.map((e) => e.toJson()).toList(),
      'MediaAttachments': ?instance.mediaAttachments
          ?.map((e) => e.toJson())
          .toList(),
      'Formats': ?instance.formats,
      'Bitrate': ?instance.bitrate,
      'FallbackMaxStreamingBitrate': ?instance.fallbackMaxStreamingBitrate,
      'Timestamp': ?transportStreamTimestampNullableToJson(instance.timestamp),
      'RequiredHttpHeaders': ?instance.requiredHttpHeaders,
      'TranscodingUrl': ?instance.transcodingUrl,
      'TranscodingSubProtocol': ?mediaStreamProtocolNullableToJson(
        instance.transcodingSubProtocol,
      ),
      'TranscodingContainer': ?instance.transcodingContainer,
      'AnalyzeDurationMs': ?instance.analyzeDurationMs,
      'DefaultAudioStreamIndex': ?instance.defaultAudioStreamIndex,
      'DefaultSubtitleStreamIndex': ?instance.defaultSubtitleStreamIndex,
      'HasSegments': ?instance.hasSegments,
    };

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
  dvBlSignalCompatibilityId: (json['DvBlSignalCompatibilityId'] as num?)
      ?.toInt(),
  rotation: (json['Rotation'] as num?)?.toInt(),
  comment: json['Comment'] as String?,
  timeBase: json['TimeBase'] as String?,
  codecTimeBase: json['CodecTimeBase'] as String?,
  title: json['Title'] as String?,
  hdr10PlusPresentFlag: json['Hdr10PlusPresentFlag'] as bool?,
  videoRange: MediaStream.videoRangeVideoRangeNullableFromJson(
    json['VideoRange'],
  ),
  videoRangeType: MediaStream.videoRangeTypeVideoRangeTypeNullableFromJson(
    json['VideoRangeType'],
  ),
  videoDoViTitle: json['VideoDoViTitle'] as String?,
  audioSpatialFormat:
      MediaStream.audioSpatialFormatAudioSpatialFormatNullableFromJson(
        json['AudioSpatialFormat'],
      ),
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
  deliveryMethod: subtitleDeliveryMethodNullableFromJson(
    json['DeliveryMethod'],
  ),
  deliveryUrl: json['DeliveryUrl'] as String?,
  isExternalUrl: json['IsExternalUrl'] as bool?,
  isTextSubtitleStream: json['IsTextSubtitleStream'] as bool?,
  supportsExternalStream: json['SupportsExternalStream'] as bool?,
  path: json['Path'] as String?,
  pixelFormat: json['PixelFormat'] as String?,
  level: (json['Level'] as num?)?.toDouble(),
  isAnamorphic: json['IsAnamorphic'] as bool?,
);

Map<String, dynamic> _$MediaStreamToJson(MediaStream instance) =>
    <String, dynamic>{
      'Codec': ?instance.codec,
      'CodecTag': ?instance.codecTag,
      'Language': ?instance.language,
      'ColorRange': ?instance.colorRange,
      'ColorSpace': ?instance.colorSpace,
      'ColorTransfer': ?instance.colorTransfer,
      'ColorPrimaries': ?instance.colorPrimaries,
      'DvVersionMajor': ?instance.dvVersionMajor,
      'DvVersionMinor': ?instance.dvVersionMinor,
      'DvProfile': ?instance.dvProfile,
      'DvLevel': ?instance.dvLevel,
      'RpuPresentFlag': ?instance.rpuPresentFlag,
      'ElPresentFlag': ?instance.elPresentFlag,
      'BlPresentFlag': ?instance.blPresentFlag,
      'DvBlSignalCompatibilityId': ?instance.dvBlSignalCompatibilityId,
      'Rotation': ?instance.rotation,
      'Comment': ?instance.comment,
      'TimeBase': ?instance.timeBase,
      'CodecTimeBase': ?instance.codecTimeBase,
      'Title': ?instance.title,
      'Hdr10PlusPresentFlag': ?instance.hdr10PlusPresentFlag,
      'VideoRange': ?videoRangeNullableToJson(instance.videoRange),
      'VideoRangeType': ?videoRangeTypeNullableToJson(instance.videoRangeType),
      'VideoDoViTitle': ?instance.videoDoViTitle,
      'AudioSpatialFormat': ?audioSpatialFormatNullableToJson(
        instance.audioSpatialFormat,
      ),
      'LocalizedUndefined': ?instance.localizedUndefined,
      'LocalizedDefault': ?instance.localizedDefault,
      'LocalizedForced': ?instance.localizedForced,
      'LocalizedExternal': ?instance.localizedExternal,
      'LocalizedHearingImpaired': ?instance.localizedHearingImpaired,
      'DisplayTitle': ?instance.displayTitle,
      'NalLengthSize': ?instance.nalLengthSize,
      'IsInterlaced': ?instance.isInterlaced,
      'IsAVC': ?instance.isAVC,
      'ChannelLayout': ?instance.channelLayout,
      'BitRate': ?instance.bitRate,
      'BitDepth': ?instance.bitDepth,
      'RefFrames': ?instance.refFrames,
      'PacketLength': ?instance.packetLength,
      'Channels': ?instance.channels,
      'SampleRate': ?instance.sampleRate,
      'IsDefault': ?instance.isDefault,
      'IsForced': ?instance.isForced,
      'IsHearingImpaired': ?instance.isHearingImpaired,
      'Height': ?instance.height,
      'Width': ?instance.width,
      'AverageFrameRate': ?instance.averageFrameRate,
      'RealFrameRate': ?instance.realFrameRate,
      'ReferenceFrameRate': ?instance.referenceFrameRate,
      'Profile': ?instance.profile,
      'Type': ?mediaStreamTypeNullableToJson(instance.type),
      'AspectRatio': ?instance.aspectRatio,
      'Index': ?instance.index,
      'Score': ?instance.score,
      'IsExternal': ?instance.isExternal,
      'DeliveryMethod': ?subtitleDeliveryMethodNullableToJson(
        instance.deliveryMethod,
      ),
      'DeliveryUrl': ?instance.deliveryUrl,
      'IsExternalUrl': ?instance.isExternalUrl,
      'IsTextSubtitleStream': ?instance.isTextSubtitleStream,
      'SupportsExternalStream': ?instance.supportsExternalStream,
      'Path': ?instance.path,
      'PixelFormat': ?instance.pixelFormat,
      'Level': ?instance.level,
      'IsAnamorphic': ?instance.isAnamorphic,
    };

MediaUpdateInfoDto _$MediaUpdateInfoDtoFromJson(Map<String, dynamic> json) =>
    MediaUpdateInfoDto(
      updates:
          (json['Updates'] as List<dynamic>?)
              ?.map(
                (e) =>
                    MediaUpdateInfoPathDto.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );

Map<String, dynamic> _$MediaUpdateInfoDtoToJson(MediaUpdateInfoDto instance) =>
    <String, dynamic>{
      'Updates': ?instance.updates?.map((e) => e.toJson()).toList(),
    };

MediaUpdateInfoPathDto _$MediaUpdateInfoPathDtoFromJson(
  Map<String, dynamic> json,
) => MediaUpdateInfoPathDto(
  path: json['Path'] as String?,
  updateType: json['UpdateType'] as String?,
);

Map<String, dynamic> _$MediaUpdateInfoPathDtoToJson(
  MediaUpdateInfoPathDto instance,
) => <String, dynamic>{
  'Path': ?instance.path,
  'UpdateType': ?instance.updateType,
};

MediaUrl _$MediaUrlFromJson(Map<String, dynamic> json) =>
    MediaUrl(url: json['Url'] as String?, name: json['Name'] as String?);

Map<String, dynamic> _$MediaUrlToJson(MediaUrl instance) => <String, dynamic>{
  'Url': ?instance.url,
  'Name': ?instance.name,
};

MessageCommand _$MessageCommandFromJson(Map<String, dynamic> json) =>
    MessageCommand(
      header: json['Header'] as String?,
      text: json['Text'] as String,
      timeoutMs: (json['TimeoutMs'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MessageCommandToJson(MessageCommand instance) =>
    <String, dynamic>{
      'Header': ?instance.header,
      'Text': instance.text,
      'TimeoutMs': ?instance.timeoutMs,
    };

MetadataConfiguration _$MetadataConfigurationFromJson(
  Map<String, dynamic> json,
) => MetadataConfiguration(
  useFileCreationTimeForDateAdded:
      json['UseFileCreationTimeForDateAdded'] as bool?,
);

Map<String, dynamic> _$MetadataConfigurationToJson(
  MetadataConfiguration instance,
) => <String, dynamic>{
  'UseFileCreationTimeForDateAdded': ?instance.useFileCreationTimeForDateAdded,
};

MetadataEditorInfo _$MetadataEditorInfoFromJson(Map<String, dynamic> json) =>
    MetadataEditorInfo(
      parentalRatingOptions:
          (json['ParentalRatingOptions'] as List<dynamic>?)
              ?.map((e) => ParentalRating.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      countries:
          (json['Countries'] as List<dynamic>?)
              ?.map((e) => CountryInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      cultures:
          (json['Cultures'] as List<dynamic>?)
              ?.map((e) => CultureDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      externalIdInfos:
          (json['ExternalIdInfos'] as List<dynamic>?)
              ?.map((e) => ExternalIdInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      contentType: collectionTypeNullableFromJson(json['ContentType']),
      contentTypeOptions:
          (json['ContentTypeOptions'] as List<dynamic>?)
              ?.map((e) => NameValuePair.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$MetadataEditorInfoToJson(
  MetadataEditorInfo instance,
) => <String, dynamic>{
  'ParentalRatingOptions': ?instance.parentalRatingOptions
      ?.map((e) => e.toJson())
      .toList(),
  'Countries': ?instance.countries?.map((e) => e.toJson()).toList(),
  'Cultures': ?instance.cultures?.map((e) => e.toJson()).toList(),
  'ExternalIdInfos': ?instance.externalIdInfos?.map((e) => e.toJson()).toList(),
  'ContentType': ?collectionTypeNullableToJson(instance.contentType),
  'ContentTypeOptions': ?instance.contentTypeOptions
      ?.map((e) => e.toJson())
      .toList(),
};

MetadataOptions _$MetadataOptionsFromJson(Map<String, dynamic> json) =>
    MetadataOptions(
      itemType: json['ItemType'] as String?,
      disabledMetadataSavers:
          (json['DisabledMetadataSavers'] as List<dynamic>?)
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
      metadataFetcherOrder:
          (json['MetadataFetcherOrder'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      disabledImageFetchers:
          (json['DisabledImageFetchers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      imageFetcherOrder:
          (json['ImageFetcherOrder'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$MetadataOptionsToJson(MetadataOptions instance) =>
    <String, dynamic>{
      'ItemType': ?instance.itemType,
      'DisabledMetadataSavers': ?instance.disabledMetadataSavers,
      'LocalMetadataReaderOrder': ?instance.localMetadataReaderOrder,
      'DisabledMetadataFetchers': ?instance.disabledMetadataFetchers,
      'MetadataFetcherOrder': ?instance.metadataFetcherOrder,
      'DisabledImageFetchers': ?instance.disabledImageFetchers,
      'ImageFetcherOrder': ?instance.imageFetcherOrder,
    };

MovePlaylistItemRequestDto _$MovePlaylistItemRequestDtoFromJson(
  Map<String, dynamic> json,
) => MovePlaylistItemRequestDto(
  playlistItemId: json['PlaylistItemId'] as String?,
  newIndex: (json['NewIndex'] as num?)?.toInt(),
);

Map<String, dynamic> _$MovePlaylistItemRequestDtoToJson(
  MovePlaylistItemRequestDto instance,
) => <String, dynamic>{
  'PlaylistItemId': ?instance.playlistItemId,
  'NewIndex': ?instance.newIndex,
};

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

Map<String, dynamic> _$MovieInfoToJson(MovieInfo instance) => <String, dynamic>{
  'Name': ?instance.name,
  'OriginalTitle': ?instance.originalTitle,
  'Path': ?instance.path,
  'MetadataLanguage': ?instance.metadataLanguage,
  'MetadataCountryCode': ?instance.metadataCountryCode,
  'ProviderIds': ?instance.providerIds,
  'Year': ?instance.year,
  'IndexNumber': ?instance.indexNumber,
  'ParentIndexNumber': ?instance.parentIndexNumber,
  'PremiereDate': ?instance.premiereDate?.toIso8601String(),
  'IsAutomated': ?instance.isAutomated,
};

MovieInfoRemoteSearchQuery _$MovieInfoRemoteSearchQueryFromJson(
  Map<String, dynamic> json,
) => MovieInfoRemoteSearchQuery(
  searchInfo: json['SearchInfo'] == null
      ? null
      : MovieInfo.fromJson(json['SearchInfo'] as Map<String, dynamic>),
  itemId: json['ItemId'] as String?,
  searchProviderName: json['SearchProviderName'] as String?,
  includeDisabledProviders: json['IncludeDisabledProviders'] as bool?,
);

Map<String, dynamic> _$MovieInfoRemoteSearchQueryToJson(
  MovieInfoRemoteSearchQuery instance,
) => <String, dynamic>{
  'SearchInfo': ?instance.searchInfo?.toJson(),
  'ItemId': ?instance.itemId,
  'SearchProviderName': ?instance.searchProviderName,
  'IncludeDisabledProviders': ?instance.includeDisabledProviders,
};

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
      artists:
          (json['Artists'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$MusicVideoInfoToJson(MusicVideoInfo instance) =>
    <String, dynamic>{
      'Name': ?instance.name,
      'OriginalTitle': ?instance.originalTitle,
      'Path': ?instance.path,
      'MetadataLanguage': ?instance.metadataLanguage,
      'MetadataCountryCode': ?instance.metadataCountryCode,
      'ProviderIds': ?instance.providerIds,
      'Year': ?instance.year,
      'IndexNumber': ?instance.indexNumber,
      'ParentIndexNumber': ?instance.parentIndexNumber,
      'PremiereDate': ?instance.premiereDate?.toIso8601String(),
      'IsAutomated': ?instance.isAutomated,
      'Artists': ?instance.artists,
    };

MusicVideoInfoRemoteSearchQuery _$MusicVideoInfoRemoteSearchQueryFromJson(
  Map<String, dynamic> json,
) => MusicVideoInfoRemoteSearchQuery(
  searchInfo: json['SearchInfo'] == null
      ? null
      : MusicVideoInfo.fromJson(json['SearchInfo'] as Map<String, dynamic>),
  itemId: json['ItemId'] as String?,
  searchProviderName: json['SearchProviderName'] as String?,
  includeDisabledProviders: json['IncludeDisabledProviders'] as bool?,
);

Map<String, dynamic> _$MusicVideoInfoRemoteSearchQueryToJson(
  MusicVideoInfoRemoteSearchQuery instance,
) => <String, dynamic>{
  'SearchInfo': ?instance.searchInfo?.toJson(),
  'ItemId': ?instance.itemId,
  'SearchProviderName': ?instance.searchProviderName,
  'IncludeDisabledProviders': ?instance.includeDisabledProviders,
};

NameGuidPair _$NameGuidPairFromJson(Map<String, dynamic> json) =>
    NameGuidPair(name: json['Name'] as String?, id: json['Id'] as String?);

Map<String, dynamic> _$NameGuidPairToJson(NameGuidPair instance) =>
    <String, dynamic>{'Name': ?instance.name, 'Id': ?instance.id};

NameIdPair _$NameIdPairFromJson(Map<String, dynamic> json) =>
    NameIdPair(name: json['Name'] as String?, id: json['Id'] as String?);

Map<String, dynamic> _$NameIdPairToJson(NameIdPair instance) =>
    <String, dynamic>{'Name': ?instance.name, 'Id': ?instance.id};

NameValuePair _$NameValuePairFromJson(Map<String, dynamic> json) =>
    NameValuePair(
      name: json['Name'] as String?,
      value: json['Value'] as String?,
    );

Map<String, dynamic> _$NameValuePairToJson(NameValuePair instance) =>
    <String, dynamic>{'Name': ?instance.name, 'Value': ?instance.value};

NetworkConfiguration _$NetworkConfigurationFromJson(
  Map<String, dynamic> json,
) => NetworkConfiguration(
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
  localNetworkSubnets:
      (json['LocalNetworkSubnets'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  localNetworkAddresses:
      (json['LocalNetworkAddresses'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  knownProxies:
      (json['KnownProxies'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  ignoreVirtualInterfaces: json['IgnoreVirtualInterfaces'] as bool?,
  virtualInterfaceNames:
      (json['VirtualInterfaceNames'] as List<dynamic>?)
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
  remoteIPFilter:
      (json['RemoteIPFilter'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  isRemoteIPFilterBlacklist: json['IsRemoteIPFilterBlacklist'] as bool?,
);

Map<String, dynamic> _$NetworkConfigurationToJson(
  NetworkConfiguration instance,
) => <String, dynamic>{
  'BaseUrl': ?instance.baseUrl,
  'EnableHttps': ?instance.enableHttps,
  'RequireHttps': ?instance.requireHttps,
  'CertificatePath': ?instance.certificatePath,
  'CertificatePassword': ?instance.certificatePassword,
  'InternalHttpPort': ?instance.internalHttpPort,
  'InternalHttpsPort': ?instance.internalHttpsPort,
  'PublicHttpPort': ?instance.publicHttpPort,
  'PublicHttpsPort': ?instance.publicHttpsPort,
  'AutoDiscovery': ?instance.autoDiscovery,
  'EnableUPnP': ?instance.enableUPnP,
  'EnableIPv4': ?instance.enableIPv4,
  'EnableIPv6': ?instance.enableIPv6,
  'EnableRemoteAccess': ?instance.enableRemoteAccess,
  'LocalNetworkSubnets': ?instance.localNetworkSubnets,
  'LocalNetworkAddresses': ?instance.localNetworkAddresses,
  'KnownProxies': ?instance.knownProxies,
  'IgnoreVirtualInterfaces': ?instance.ignoreVirtualInterfaces,
  'VirtualInterfaceNames': ?instance.virtualInterfaceNames,
  'EnablePublishedServerUriByRequest':
      ?instance.enablePublishedServerUriByRequest,
  'PublishedServerUriBySubnet': ?instance.publishedServerUriBySubnet,
  'RemoteIPFilter': ?instance.remoteIPFilter,
  'IsRemoteIPFilterBlacklist': ?instance.isRemoteIPFilterBlacklist,
};

NewGroupRequestDto _$NewGroupRequestDtoFromJson(Map<String, dynamic> json) =>
    NewGroupRequestDto(groupName: json['GroupName'] as String?);

Map<String, dynamic> _$NewGroupRequestDtoToJson(NewGroupRequestDto instance) =>
    <String, dynamic>{'GroupName': ?instance.groupName};

NextItemRequestDto _$NextItemRequestDtoFromJson(Map<String, dynamic> json) =>
    NextItemRequestDto(playlistItemId: json['PlaylistItemId'] as String?);

Map<String, dynamic> _$NextItemRequestDtoToJson(NextItemRequestDto instance) =>
    <String, dynamic>{'PlaylistItemId': ?instance.playlistItemId};

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
              json['DeviceProfile'] as Map<String, dynamic>,
            ),
      directPlayProtocols: mediaProtocolListFromJson(
        json['DirectPlayProtocols'] as List?,
      ),
    );

Map<String, dynamic> _$OpenLiveStreamDtoToJson(
  OpenLiveStreamDto instance,
) => <String, dynamic>{
  'OpenToken': ?instance.openToken,
  'UserId': ?instance.userId,
  'PlaySessionId': ?instance.playSessionId,
  'MaxStreamingBitrate': ?instance.maxStreamingBitrate,
  'StartTimeTicks': ?instance.startTimeTicks,
  'AudioStreamIndex': ?instance.audioStreamIndex,
  'SubtitleStreamIndex': ?instance.subtitleStreamIndex,
  'MaxAudioChannels': ?instance.maxAudioChannels,
  'ItemId': ?instance.itemId,
  'EnableDirectPlay': ?instance.enableDirectPlay,
  'EnableDirectStream': ?instance.enableDirectStream,
  'AlwaysBurnInSubtitleWhenTranscoding':
      ?instance.alwaysBurnInSubtitleWhenTranscoding,
  'DeviceProfile': ?instance.deviceProfile?.toJson(),
  'DirectPlayProtocols': mediaProtocolListToJson(instance.directPlayProtocols),
};

OutboundKeepAliveMessage _$OutboundKeepAliveMessageFromJson(
  Map<String, dynamic> json,
) => OutboundKeepAliveMessage(
  messageId: json['MessageId'] as String?,
  messageType:
      OutboundKeepAliveMessage.sessionMessageTypeMessageTypeNullableFromJson(
        json['MessageType'],
      ),
);

Map<String, dynamic> _$OutboundKeepAliveMessageToJson(
  OutboundKeepAliveMessage instance,
) => <String, dynamic>{
  'MessageId': ?instance.messageId,
  'MessageType': ?sessionMessageTypeNullableToJson(instance.messageType),
};

OutboundWebSocketMessage _$OutboundWebSocketMessageFromJson(
  Map<String, dynamic> json,
) => OutboundWebSocketMessage();

Map<String, dynamic> _$OutboundWebSocketMessageToJson(
  OutboundWebSocketMessage instance,
) => <String, dynamic>{};

PackageInfo _$PackageInfoFromJson(Map<String, dynamic> json) => PackageInfo(
  name: json['name'] as String?,
  description: json['description'] as String?,
  overview: json['overview'] as String?,
  owner: json['owner'] as String?,
  category: json['category'] as String?,
  guid: json['guid'] as String?,
  versions:
      (json['versions'] as List<dynamic>?)
          ?.map((e) => VersionInfo.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  imageUrl: json['imageUrl'] as String?,
);

Map<String, dynamic> _$PackageInfoToJson(PackageInfo instance) =>
    <String, dynamic>{
      'name': ?instance.name,
      'description': ?instance.description,
      'overview': ?instance.overview,
      'owner': ?instance.owner,
      'category': ?instance.category,
      'guid': ?instance.guid,
      'versions': ?instance.versions?.map((e) => e.toJson()).toList(),
      'imageUrl': ?instance.imageUrl,
    };

ParentalRating _$ParentalRatingFromJson(Map<String, dynamic> json) =>
    ParentalRating(
      name: json['Name'] as String?,
      value: (json['Value'] as num?)?.toInt(),
      ratingScore: json['RatingScore'] == null
          ? null
          : ParentalRatingScore.fromJson(
              json['RatingScore'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$ParentalRatingToJson(ParentalRating instance) =>
    <String, dynamic>{
      'Name': ?instance.name,
      'Value': ?instance.value,
      'RatingScore': ?instance.ratingScore?.toJson(),
    };

ParentalRatingScore _$ParentalRatingScoreFromJson(Map<String, dynamic> json) =>
    ParentalRatingScore(
      score: (json['score'] as num?)?.toInt(),
      subScore: (json['subScore'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ParentalRatingScoreToJson(
  ParentalRatingScore instance,
) => <String, dynamic>{
  'score': ?instance.score,
  'subScore': ?instance.subScore,
};

PathSubstitution _$PathSubstitutionFromJson(Map<String, dynamic> json) =>
    PathSubstitution(from: json['From'] as String?, to: json['To'] as String?);

Map<String, dynamic> _$PathSubstitutionToJson(PathSubstitution instance) =>
    <String, dynamic>{'From': ?instance.from, 'To': ?instance.to};

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

Map<String, dynamic> _$PersonLookupInfoToJson(PersonLookupInfo instance) =>
    <String, dynamic>{
      'Name': ?instance.name,
      'OriginalTitle': ?instance.originalTitle,
      'Path': ?instance.path,
      'MetadataLanguage': ?instance.metadataLanguage,
      'MetadataCountryCode': ?instance.metadataCountryCode,
      'ProviderIds': ?instance.providerIds,
      'Year': ?instance.year,
      'IndexNumber': ?instance.indexNumber,
      'ParentIndexNumber': ?instance.parentIndexNumber,
      'PremiereDate': ?instance.premiereDate?.toIso8601String(),
      'IsAutomated': ?instance.isAutomated,
    };

PersonLookupInfoRemoteSearchQuery _$PersonLookupInfoRemoteSearchQueryFromJson(
  Map<String, dynamic> json,
) => PersonLookupInfoRemoteSearchQuery(
  searchInfo: json['SearchInfo'] == null
      ? null
      : PersonLookupInfo.fromJson(json['SearchInfo'] as Map<String, dynamic>),
  itemId: json['ItemId'] as String?,
  searchProviderName: json['SearchProviderName'] as String?,
  includeDisabledProviders: json['IncludeDisabledProviders'] as bool?,
);

Map<String, dynamic> _$PersonLookupInfoRemoteSearchQueryToJson(
  PersonLookupInfoRemoteSearchQuery instance,
) => <String, dynamic>{
  'SearchInfo': ?instance.searchInfo?.toJson(),
  'ItemId': ?instance.itemId,
  'SearchProviderName': ?instance.searchProviderName,
  'IncludeDisabledProviders': ?instance.includeDisabledProviders,
};

PingRequestDto _$PingRequestDtoFromJson(Map<String, dynamic> json) =>
    PingRequestDto(ping: (json['Ping'] as num?)?.toInt());

Map<String, dynamic> _$PingRequestDtoToJson(PingRequestDto instance) =>
    <String, dynamic>{'Ping': ?instance.ping};

PinRedeemResult _$PinRedeemResultFromJson(Map<String, dynamic> json) =>
    PinRedeemResult(
      success: json['Success'] as bool?,
      usersReset:
          (json['UsersReset'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$PinRedeemResultToJson(PinRedeemResult instance) =>
    <String, dynamic>{
      'Success': ?instance.success,
      'UsersReset': ?instance.usersReset,
    };

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
              json['DeviceProfile'] as Map<String, dynamic>,
            ),
      enableDirectPlay: json['EnableDirectPlay'] as bool?,
      enableDirectStream: json['EnableDirectStream'] as bool?,
      enableTranscoding: json['EnableTranscoding'] as bool?,
      allowVideoStreamCopy: json['AllowVideoStreamCopy'] as bool?,
      allowAudioStreamCopy: json['AllowAudioStreamCopy'] as bool?,
      autoOpenLiveStream: json['AutoOpenLiveStream'] as bool?,
      alwaysBurnInSubtitleWhenTranscoding:
          json['AlwaysBurnInSubtitleWhenTranscoding'] as bool?,
    );

Map<String, dynamic> _$PlaybackInfoDtoToJson(PlaybackInfoDto instance) =>
    <String, dynamic>{
      'UserId': ?instance.userId,
      'MaxStreamingBitrate': ?instance.maxStreamingBitrate,
      'StartTimeTicks': ?instance.startTimeTicks,
      'AudioStreamIndex': ?instance.audioStreamIndex,
      'SubtitleStreamIndex': ?instance.subtitleStreamIndex,
      'MaxAudioChannels': ?instance.maxAudioChannels,
      'MediaSourceId': ?instance.mediaSourceId,
      'LiveStreamId': ?instance.liveStreamId,
      'DeviceProfile': ?instance.deviceProfile?.toJson(),
      'EnableDirectPlay': ?instance.enableDirectPlay,
      'EnableDirectStream': ?instance.enableDirectStream,
      'EnableTranscoding': ?instance.enableTranscoding,
      'AllowVideoStreamCopy': ?instance.allowVideoStreamCopy,
      'AllowAudioStreamCopy': ?instance.allowAudioStreamCopy,
      'AutoOpenLiveStream': ?instance.autoOpenLiveStream,
      'AlwaysBurnInSubtitleWhenTranscoding':
          ?instance.alwaysBurnInSubtitleWhenTranscoding,
    };

PlaybackInfoResponse _$PlaybackInfoResponseFromJson(
  Map<String, dynamic> json,
) => PlaybackInfoResponse(
  mediaSources:
      (json['MediaSources'] as List<dynamic>?)
          ?.map((e) => MediaSourceInfo.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  playSessionId: json['PlaySessionId'] as String?,
  errorCode: playbackErrorCodeNullableFromJson(json['ErrorCode']),
);

Map<String, dynamic> _$PlaybackInfoResponseToJson(
  PlaybackInfoResponse instance,
) => <String, dynamic>{
  'MediaSources': ?instance.mediaSources?.map((e) => e.toJson()).toList(),
  'PlaySessionId': ?instance.playSessionId,
  'ErrorCode': ?playbackErrorCodeNullableToJson(instance.errorCode),
};

PlaybackProgressInfo _$PlaybackProgressInfoFromJson(
  Map<String, dynamic> json,
) => PlaybackProgressInfo(
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
  nowPlayingQueue:
      (json['NowPlayingQueue'] as List<dynamic>?)
          ?.map((e) => QueueItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  playlistItemId: json['PlaylistItemId'] as String?,
);

Map<String, dynamic> _$PlaybackProgressInfoToJson(
  PlaybackProgressInfo instance,
) => <String, dynamic>{
  'CanSeek': ?instance.canSeek,
  'Item': ?instance.item?.toJson(),
  'ItemId': ?instance.itemId,
  'SessionId': ?instance.sessionId,
  'MediaSourceId': ?instance.mediaSourceId,
  'AudioStreamIndex': ?instance.audioStreamIndex,
  'SubtitleStreamIndex': ?instance.subtitleStreamIndex,
  'IsPaused': ?instance.isPaused,
  'IsMuted': ?instance.isMuted,
  'PositionTicks': ?instance.positionTicks,
  'PlaybackStartTimeTicks': ?instance.playbackStartTimeTicks,
  'VolumeLevel': ?instance.volumeLevel,
  'Brightness': ?instance.brightness,
  'AspectRatio': ?instance.aspectRatio,
  'PlayMethod': ?playMethodNullableToJson(instance.playMethod),
  'LiveStreamId': ?instance.liveStreamId,
  'PlaySessionId': ?instance.playSessionId,
  'RepeatMode': ?repeatModeNullableToJson(instance.repeatMode),
  'PlaybackOrder': ?playbackOrderNullableToJson(instance.playbackOrder),
  'NowPlayingQueue': ?instance.nowPlayingQueue?.map((e) => e.toJson()).toList(),
  'PlaylistItemId': ?instance.playlistItemId,
};

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
      nowPlayingQueue:
          (json['NowPlayingQueue'] as List<dynamic>?)
              ?.map((e) => QueueItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      playlistItemId: json['PlaylistItemId'] as String?,
    );

Map<String, dynamic> _$PlaybackStartInfoToJson(
  PlaybackStartInfo instance,
) => <String, dynamic>{
  'CanSeek': ?instance.canSeek,
  'Item': ?instance.item?.toJson(),
  'ItemId': ?instance.itemId,
  'SessionId': ?instance.sessionId,
  'MediaSourceId': ?instance.mediaSourceId,
  'AudioStreamIndex': ?instance.audioStreamIndex,
  'SubtitleStreamIndex': ?instance.subtitleStreamIndex,
  'IsPaused': ?instance.isPaused,
  'IsMuted': ?instance.isMuted,
  'PositionTicks': ?instance.positionTicks,
  'PlaybackStartTimeTicks': ?instance.playbackStartTimeTicks,
  'VolumeLevel': ?instance.volumeLevel,
  'Brightness': ?instance.brightness,
  'AspectRatio': ?instance.aspectRatio,
  'PlayMethod': ?playMethodNullableToJson(instance.playMethod),
  'LiveStreamId': ?instance.liveStreamId,
  'PlaySessionId': ?instance.playSessionId,
  'RepeatMode': ?repeatModeNullableToJson(instance.repeatMode),
  'PlaybackOrder': ?playbackOrderNullableToJson(instance.playbackOrder),
  'NowPlayingQueue': ?instance.nowPlayingQueue?.map((e) => e.toJson()).toList(),
  'PlaylistItemId': ?instance.playlistItemId,
};

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
      nowPlayingQueue:
          (json['NowPlayingQueue'] as List<dynamic>?)
              ?.map((e) => QueueItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$PlaybackStopInfoToJson(
  PlaybackStopInfo instance,
) => <String, dynamic>{
  'Item': ?instance.item?.toJson(),
  'ItemId': ?instance.itemId,
  'SessionId': ?instance.sessionId,
  'MediaSourceId': ?instance.mediaSourceId,
  'PositionTicks': ?instance.positionTicks,
  'LiveStreamId': ?instance.liveStreamId,
  'PlaySessionId': ?instance.playSessionId,
  'Failed': ?instance.failed,
  'NextMediaType': ?instance.nextMediaType,
  'PlaylistItemId': ?instance.playlistItemId,
  'NowPlayingQueue': ?instance.nowPlayingQueue?.map((e) => e.toJson()).toList(),
};

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

Map<String, dynamic> _$PlayerStateInfoToJson(PlayerStateInfo instance) =>
    <String, dynamic>{
      'PositionTicks': ?instance.positionTicks,
      'CanSeek': ?instance.canSeek,
      'IsPaused': ?instance.isPaused,
      'IsMuted': ?instance.isMuted,
      'VolumeLevel': ?instance.volumeLevel,
      'AudioStreamIndex': ?instance.audioStreamIndex,
      'SubtitleStreamIndex': ?instance.subtitleStreamIndex,
      'MediaSourceId': ?instance.mediaSourceId,
      'PlayMethod': ?playMethodNullableToJson(instance.playMethod),
      'RepeatMode': ?repeatModeNullableToJson(instance.repeatMode),
      'PlaybackOrder': ?playbackOrderNullableToJson(instance.playbackOrder),
      'LiveStreamId': ?instance.liveStreamId,
    };

PlaylistCreationResult _$PlaylistCreationResultFromJson(
  Map<String, dynamic> json,
) => PlaylistCreationResult(id: json['Id'] as String?);

Map<String, dynamic> _$PlaylistCreationResultToJson(
  PlaylistCreationResult instance,
) => <String, dynamic>{'Id': ?instance.id};

PlaylistDto _$PlaylistDtoFromJson(Map<String, dynamic> json) => PlaylistDto(
  openAccess: json['OpenAccess'] as bool?,
  shares:
      (json['Shares'] as List<dynamic>?)
          ?.map(
            (e) => PlaylistUserPermissions.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      [],
  itemIds:
      (json['ItemIds'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      [],
);

Map<String, dynamic> _$PlaylistDtoToJson(PlaylistDto instance) =>
    <String, dynamic>{
      'OpenAccess': ?instance.openAccess,
      'Shares': ?instance.shares?.map((e) => e.toJson()).toList(),
      'ItemIds': ?instance.itemIds,
    };

PlaylistUserPermissions _$PlaylistUserPermissionsFromJson(
  Map<String, dynamic> json,
) => PlaylistUserPermissions(
  userId: json['UserId'] as String?,
  canEdit: json['CanEdit'] as bool?,
);

Map<String, dynamic> _$PlaylistUserPermissionsToJson(
  PlaylistUserPermissions instance,
) => <String, dynamic>{
  'UserId': ?instance.userId,
  'CanEdit': ?instance.canEdit,
};

PlayMessage _$PlayMessageFromJson(Map<String, dynamic> json) => PlayMessage(
  data: json['Data'] == null
      ? null
      : PlayRequest.fromJson(json['Data'] as Map<String, dynamic>),
  messageId: json['MessageId'] as String?,
  messageType: PlayMessage.sessionMessageTypeMessageTypeNullableFromJson(
    json['MessageType'],
  ),
);

Map<String, dynamic> _$PlayMessageToJson(PlayMessage instance) =>
    <String, dynamic>{
      'Data': ?instance.data?.toJson(),
      'MessageId': ?instance.messageId,
      'MessageType': ?sessionMessageTypeNullableToJson(instance.messageType),
    };

PlayQueueUpdate _$PlayQueueUpdateFromJson(Map<String, dynamic> json) =>
    PlayQueueUpdate(
      reason: playQueueUpdateReasonNullableFromJson(json['Reason']),
      lastUpdate: json['LastUpdate'] == null
          ? null
          : DateTime.parse(json['LastUpdate'] as String),
      playlist:
          (json['Playlist'] as List<dynamic>?)
              ?.map(
                (e) => SyncPlayQueueItem.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      playingItemIndex: (json['PlayingItemIndex'] as num?)?.toInt(),
      startPositionTicks: (json['StartPositionTicks'] as num?)?.toInt(),
      isPlaying: json['IsPlaying'] as bool?,
      shuffleMode: groupShuffleModeNullableFromJson(json['ShuffleMode']),
      repeatMode: groupRepeatModeNullableFromJson(json['RepeatMode']),
    );

Map<String, dynamic> _$PlayQueueUpdateToJson(PlayQueueUpdate instance) =>
    <String, dynamic>{
      'Reason': ?playQueueUpdateReasonNullableToJson(instance.reason),
      'LastUpdate': ?instance.lastUpdate?.toIso8601String(),
      'Playlist': ?instance.playlist?.map((e) => e.toJson()).toList(),
      'PlayingItemIndex': ?instance.playingItemIndex,
      'StartPositionTicks': ?instance.startPositionTicks,
      'IsPlaying': ?instance.isPlaying,
      'ShuffleMode': ?groupShuffleModeNullableToJson(instance.shuffleMode),
      'RepeatMode': ?groupRepeatModeNullableToJson(instance.repeatMode),
    };

PlayRequest _$PlayRequestFromJson(Map<String, dynamic> json) => PlayRequest(
  itemIds:
      (json['ItemIds'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      [],
  startPositionTicks: (json['StartPositionTicks'] as num?)?.toInt(),
  playCommand: playCommandNullableFromJson(json['PlayCommand']),
  controllingUserId: json['ControllingUserId'] as String?,
  subtitleStreamIndex: (json['SubtitleStreamIndex'] as num?)?.toInt(),
  audioStreamIndex: (json['AudioStreamIndex'] as num?)?.toInt(),
  mediaSourceId: json['MediaSourceId'] as String?,
  startIndex: (json['StartIndex'] as num?)?.toInt(),
);

Map<String, dynamic> _$PlayRequestToJson(PlayRequest instance) =>
    <String, dynamic>{
      'ItemIds': ?instance.itemIds,
      'StartPositionTicks': ?instance.startPositionTicks,
      'PlayCommand': ?playCommandNullableToJson(instance.playCommand),
      'ControllingUserId': ?instance.controllingUserId,
      'SubtitleStreamIndex': ?instance.subtitleStreamIndex,
      'AudioStreamIndex': ?instance.audioStreamIndex,
      'MediaSourceId': ?instance.mediaSourceId,
      'StartIndex': ?instance.startIndex,
    };

PlayRequestDto _$PlayRequestDtoFromJson(Map<String, dynamic> json) =>
    PlayRequestDto(
      playingQueue:
          (json['PlayingQueue'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      playingItemPosition: (json['PlayingItemPosition'] as num?)?.toInt(),
      startPositionTicks: (json['StartPositionTicks'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PlayRequestDtoToJson(PlayRequestDto instance) =>
    <String, dynamic>{
      'PlayingQueue': ?instance.playingQueue,
      'PlayingItemPosition': ?instance.playingItemPosition,
      'StartPositionTicks': ?instance.startPositionTicks,
    };

PlaystateMessage _$PlaystateMessageFromJson(Map<String, dynamic> json) =>
    PlaystateMessage(
      data: json['Data'] == null
          ? null
          : PlaystateRequest.fromJson(json['Data'] as Map<String, dynamic>),
      messageId: json['MessageId'] as String?,
      messageType:
          PlaystateMessage.sessionMessageTypeMessageTypeNullableFromJson(
            json['MessageType'],
          ),
    );

Map<String, dynamic> _$PlaystateMessageToJson(PlaystateMessage instance) =>
    <String, dynamic>{
      'Data': ?instance.data?.toJson(),
      'MessageId': ?instance.messageId,
      'MessageType': ?sessionMessageTypeNullableToJson(instance.messageType),
    };

PlaystateRequest _$PlaystateRequestFromJson(Map<String, dynamic> json) =>
    PlaystateRequest(
      command: playstateCommandNullableFromJson(json['Command']),
      seekPositionTicks: (json['SeekPositionTicks'] as num?)?.toInt(),
      controllingUserId: json['ControllingUserId'] as String?,
    );

Map<String, dynamic> _$PlaystateRequestToJson(PlaystateRequest instance) =>
    <String, dynamic>{
      'Command': ?playstateCommandNullableToJson(instance.command),
      'SeekPositionTicks': ?instance.seekPositionTicks,
      'ControllingUserId': ?instance.controllingUserId,
    };

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

Map<String, dynamic> _$PluginInfoToJson(PluginInfo instance) =>
    <String, dynamic>{
      'Name': ?instance.name,
      'Version': ?instance.version,
      'ConfigurationFileName': ?instance.configurationFileName,
      'Description': ?instance.description,
      'Id': ?instance.id,
      'CanUninstall': ?instance.canUninstall,
      'HasImage': ?instance.hasImage,
      'Status': ?pluginStatusNullableToJson(instance.status),
    };

PluginInstallationCancelledMessage _$PluginInstallationCancelledMessageFromJson(
  Map<String, dynamic> json,
) => PluginInstallationCancelledMessage(
  data: json['Data'] == null
      ? null
      : InstallationInfo.fromJson(json['Data'] as Map<String, dynamic>),
  messageId: json['MessageId'] as String?,
  messageType:
      PluginInstallationCancelledMessage.sessionMessageTypeMessageTypeNullableFromJson(
        json['MessageType'],
      ),
);

Map<String, dynamic> _$PluginInstallationCancelledMessageToJson(
  PluginInstallationCancelledMessage instance,
) => <String, dynamic>{
  'Data': ?instance.data?.toJson(),
  'MessageId': ?instance.messageId,
  'MessageType': ?sessionMessageTypeNullableToJson(instance.messageType),
};

PluginInstallationCompletedMessage _$PluginInstallationCompletedMessageFromJson(
  Map<String, dynamic> json,
) => PluginInstallationCompletedMessage(
  data: json['Data'] == null
      ? null
      : InstallationInfo.fromJson(json['Data'] as Map<String, dynamic>),
  messageId: json['MessageId'] as String?,
  messageType:
      PluginInstallationCompletedMessage.sessionMessageTypeMessageTypeNullableFromJson(
        json['MessageType'],
      ),
);

Map<String, dynamic> _$PluginInstallationCompletedMessageToJson(
  PluginInstallationCompletedMessage instance,
) => <String, dynamic>{
  'Data': ?instance.data?.toJson(),
  'MessageId': ?instance.messageId,
  'MessageType': ?sessionMessageTypeNullableToJson(instance.messageType),
};

PluginInstallationFailedMessage _$PluginInstallationFailedMessageFromJson(
  Map<String, dynamic> json,
) => PluginInstallationFailedMessage(
  data: json['Data'] == null
      ? null
      : InstallationInfo.fromJson(json['Data'] as Map<String, dynamic>),
  messageId: json['MessageId'] as String?,
  messageType:
      PluginInstallationFailedMessage.sessionMessageTypeMessageTypeNullableFromJson(
        json['MessageType'],
      ),
);

Map<String, dynamic> _$PluginInstallationFailedMessageToJson(
  PluginInstallationFailedMessage instance,
) => <String, dynamic>{
  'Data': ?instance.data?.toJson(),
  'MessageId': ?instance.messageId,
  'MessageType': ?sessionMessageTypeNullableToJson(instance.messageType),
};

PluginInstallingMessage _$PluginInstallingMessageFromJson(
  Map<String, dynamic> json,
) => PluginInstallingMessage(
  data: json['Data'] == null
      ? null
      : InstallationInfo.fromJson(json['Data'] as Map<String, dynamic>),
  messageId: json['MessageId'] as String?,
  messageType:
      PluginInstallingMessage.sessionMessageTypeMessageTypeNullableFromJson(
        json['MessageType'],
      ),
);

Map<String, dynamic> _$PluginInstallingMessageToJson(
  PluginInstallingMessage instance,
) => <String, dynamic>{
  'Data': ?instance.data?.toJson(),
  'MessageId': ?instance.messageId,
  'MessageType': ?sessionMessageTypeNullableToJson(instance.messageType),
};

PluginUninstalledMessage _$PluginUninstalledMessageFromJson(
  Map<String, dynamic> json,
) => PluginUninstalledMessage(
  data: json['Data'] == null
      ? null
      : PluginInfo.fromJson(json['Data'] as Map<String, dynamic>),
  messageId: json['MessageId'] as String?,
  messageType:
      PluginUninstalledMessage.sessionMessageTypeMessageTypeNullableFromJson(
        json['MessageType'],
      ),
);

Map<String, dynamic> _$PluginUninstalledMessageToJson(
  PluginUninstalledMessage instance,
) => <String, dynamic>{
  'Data': ?instance.data?.toJson(),
  'MessageId': ?instance.messageId,
  'MessageType': ?sessionMessageTypeNullableToJson(instance.messageType),
};

PreviousItemRequestDto _$PreviousItemRequestDtoFromJson(
  Map<String, dynamic> json,
) => PreviousItemRequestDto(playlistItemId: json['PlaylistItemId'] as String?);

Map<String, dynamic> _$PreviousItemRequestDtoToJson(
  PreviousItemRequestDto instance,
) => <String, dynamic>{'PlaylistItemId': ?instance.playlistItemId};

ProblemDetails _$ProblemDetailsFromJson(Map<String, dynamic> json) =>
    ProblemDetails(
      type: json['type'] as String?,
      title: json['title'] as String?,
      status: (json['status'] as num?)?.toInt(),
      detail: json['detail'] as String?,
      instance: json['instance'] as String?,
    );

Map<String, dynamic> _$ProblemDetailsToJson(ProblemDetails instance) =>
    <String, dynamic>{
      'type': ?instance.type,
      'title': ?instance.title,
      'status': ?instance.status,
      'detail': ?instance.detail,
      'instance': ?instance.instance,
    };

ProfileCondition _$ProfileConditionFromJson(Map<String, dynamic> json) =>
    ProfileCondition(
      condition: profileConditionTypeNullableFromJson(json['Condition']),
      property: profileConditionValueNullableFromJson(json['Property']),
      value: json['Value'] as String?,
      isRequired: json['IsRequired'] as bool?,
    );

Map<String, dynamic> _$ProfileConditionToJson(ProfileCondition instance) =>
    <String, dynamic>{
      'Condition': ?profileConditionTypeNullableToJson(instance.condition),
      'Property': ?profileConditionValueNullableToJson(instance.property),
      'Value': ?instance.value,
      'IsRequired': ?instance.isRequired,
    };

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

Map<String, dynamic> _$PublicSystemInfoToJson(PublicSystemInfo instance) =>
    <String, dynamic>{
      'LocalAddress': ?instance.localAddress,
      'ServerName': ?instance.serverName,
      'Version': ?instance.version,
      'ProductName': ?instance.productName,
      'OperatingSystem': ?instance.operatingSystem,
      'Id': ?instance.id,
      'StartupWizardCompleted': ?instance.startupWizardCompleted,
    };

QueryFilters _$QueryFiltersFromJson(Map<String, dynamic> json) => QueryFilters(
  genres:
      (json['Genres'] as List<dynamic>?)
          ?.map((e) => NameGuidPair.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  tags:
      (json['Tags'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
);

Map<String, dynamic> _$QueryFiltersToJson(QueryFilters instance) =>
    <String, dynamic>{
      'Genres': ?instance.genres?.map((e) => e.toJson()).toList(),
      'Tags': ?instance.tags,
    };

QueryFiltersLegacy _$QueryFiltersLegacyFromJson(
  Map<String, dynamic> json,
) => QueryFiltersLegacy(
  genres:
      (json['Genres'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      [],
  tags:
      (json['Tags'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
  officialRatings:
      (json['OfficialRatings'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  years:
      (json['Years'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      [],
);

Map<String, dynamic> _$QueryFiltersLegacyToJson(QueryFiltersLegacy instance) =>
    <String, dynamic>{
      'Genres': ?instance.genres,
      'Tags': ?instance.tags,
      'OfficialRatings': ?instance.officialRatings,
      'Years': ?instance.years,
    };

QueueItem _$QueueItemFromJson(Map<String, dynamic> json) => QueueItem(
  id: json['Id'] as String?,
  playlistItemId: json['PlaylistItemId'] as String?,
);

Map<String, dynamic> _$QueueItemToJson(QueueItem instance) => <String, dynamic>{
  'Id': ?instance.id,
  'PlaylistItemId': ?instance.playlistItemId,
};

QueueRequestDto _$QueueRequestDtoFromJson(Map<String, dynamic> json) =>
    QueueRequestDto(
      itemIds:
          (json['ItemIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      mode: groupQueueModeNullableFromJson(json['Mode']),
    );

Map<String, dynamic> _$QueueRequestDtoToJson(QueueRequestDto instance) =>
    <String, dynamic>{
      'ItemIds': ?instance.itemIds,
      'Mode': ?groupQueueModeNullableToJson(instance.mode),
    };

QuickConnectDto _$QuickConnectDtoFromJson(Map<String, dynamic> json) =>
    QuickConnectDto(secret: json['Secret'] as String);

Map<String, dynamic> _$QuickConnectDtoToJson(QuickConnectDto instance) =>
    <String, dynamic>{'Secret': instance.secret};

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

Map<String, dynamic> _$QuickConnectResultToJson(QuickConnectResult instance) =>
    <String, dynamic>{
      'Authenticated': ?instance.authenticated,
      'Secret': ?instance.secret,
      'Code': ?instance.code,
      'DeviceId': ?instance.deviceId,
      'DeviceName': ?instance.deviceName,
      'AppName': ?instance.appName,
      'AppVersion': ?instance.appVersion,
      'DateAdded': ?instance.dateAdded?.toIso8601String(),
    };

ReadyRequestDto _$ReadyRequestDtoFromJson(Map<String, dynamic> json) =>
    ReadyRequestDto(
      when: json['When'] == null
          ? null
          : DateTime.parse(json['When'] as String),
      positionTicks: (json['PositionTicks'] as num?)?.toInt(),
      isPlaying: json['IsPlaying'] as bool?,
      playlistItemId: json['PlaylistItemId'] as String?,
    );

Map<String, dynamic> _$ReadyRequestDtoToJson(ReadyRequestDto instance) =>
    <String, dynamic>{
      'When': ?instance.when?.toIso8601String(),
      'PositionTicks': ?instance.positionTicks,
      'IsPlaying': ?instance.isPlaying,
      'PlaylistItemId': ?instance.playlistItemId,
    };

RecommendationDto _$RecommendationDtoFromJson(Map<String, dynamic> json) =>
    RecommendationDto(
      items:
          (json['Items'] as List<dynamic>?)
              ?.map((e) => BaseItemDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      recommendationType: recommendationTypeNullableFromJson(
        json['RecommendationType'],
      ),
      baselineItemName: json['BaselineItemName'] as String?,
      categoryId: json['CategoryId'] as String?,
    );

Map<String, dynamic> _$RecommendationDtoToJson(RecommendationDto instance) =>
    <String, dynamic>{
      'Items': ?instance.items?.map((e) => e.toJson()).toList(),
      'RecommendationType': ?recommendationTypeNullableToJson(
        instance.recommendationType,
      ),
      'BaselineItemName': ?instance.baselineItemName,
      'CategoryId': ?instance.categoryId,
    };

RefreshProgressMessage _$RefreshProgressMessageFromJson(
  Map<String, dynamic> json,
) => RefreshProgressMessage(
  data: json['Data'] as Map<String, dynamic>?,
  messageId: json['MessageId'] as String?,
  messageType:
      RefreshProgressMessage.sessionMessageTypeMessageTypeNullableFromJson(
        json['MessageType'],
      ),
);

Map<String, dynamic> _$RefreshProgressMessageToJson(
  RefreshProgressMessage instance,
) => <String, dynamic>{
  'Data': ?instance.data,
  'MessageId': ?instance.messageId,
  'MessageType': ?sessionMessageTypeNullableToJson(instance.messageType),
};

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

Map<String, dynamic> _$RemoteImageInfoToJson(RemoteImageInfo instance) =>
    <String, dynamic>{
      'ProviderName': ?instance.providerName,
      'Url': ?instance.url,
      'ThumbnailUrl': ?instance.thumbnailUrl,
      'Height': ?instance.height,
      'Width': ?instance.width,
      'CommunityRating': ?instance.communityRating,
      'VoteCount': ?instance.voteCount,
      'Language': ?instance.language,
      'Type': ?imageTypeNullableToJson(instance.type),
      'RatingType': ?ratingTypeNullableToJson(instance.ratingType),
    };

RemoteImageResult _$RemoteImageResultFromJson(Map<String, dynamic> json) =>
    RemoteImageResult(
      images:
          (json['Images'] as List<dynamic>?)
              ?.map((e) => RemoteImageInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      totalRecordCount: (json['TotalRecordCount'] as num?)?.toInt(),
      providers:
          (json['Providers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$RemoteImageResultToJson(RemoteImageResult instance) =>
    <String, dynamic>{
      'Images': ?instance.images?.map((e) => e.toJson()).toList(),
      'TotalRecordCount': ?instance.totalRecordCount,
      'Providers': ?instance.providers,
    };

RemoteLyricInfoDto _$RemoteLyricInfoDtoFromJson(Map<String, dynamic> json) =>
    RemoteLyricInfoDto(
      id: json['Id'] as String?,
      providerName: json['ProviderName'] as String?,
      lyrics: json['Lyrics'] == null
          ? null
          : LyricDto.fromJson(json['Lyrics'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RemoteLyricInfoDtoToJson(RemoteLyricInfoDto instance) =>
    <String, dynamic>{
      'Id': ?instance.id,
      'ProviderName': ?instance.providerName,
      'Lyrics': ?instance.lyrics?.toJson(),
    };

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
              json['AlbumArtist'] as Map<String, dynamic>,
            ),
      artists:
          (json['Artists'] as List<dynamic>?)
              ?.map(
                (e) => RemoteSearchResult.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );

Map<String, dynamic> _$RemoteSearchResultToJson(RemoteSearchResult instance) =>
    <String, dynamic>{
      'Name': ?instance.name,
      'ProviderIds': ?instance.providerIds,
      'ProductionYear': ?instance.productionYear,
      'IndexNumber': ?instance.indexNumber,
      'IndexNumberEnd': ?instance.indexNumberEnd,
      'ParentIndexNumber': ?instance.parentIndexNumber,
      'PremiereDate': ?instance.premiereDate?.toIso8601String(),
      'ImageUrl': ?instance.imageUrl,
      'SearchProviderName': ?instance.searchProviderName,
      'Overview': ?instance.overview,
      'AlbumArtist': ?instance.albumArtist?.toJson(),
      'Artists': ?instance.artists?.map((e) => e.toJson()).toList(),
    };

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

Map<String, dynamic> _$RemoteSubtitleInfoToJson(RemoteSubtitleInfo instance) =>
    <String, dynamic>{
      'ThreeLetterISOLanguageName': ?instance.threeLetterISOLanguageName,
      'Id': ?instance.id,
      'ProviderName': ?instance.providerName,
      'Name': ?instance.name,
      'Format': ?instance.format,
      'Author': ?instance.author,
      'Comment': ?instance.comment,
      'DateCreated': ?instance.dateCreated?.toIso8601String(),
      'CommunityRating': ?instance.communityRating,
      'FrameRate': ?instance.frameRate,
      'DownloadCount': ?instance.downloadCount,
      'IsHashMatch': ?instance.isHashMatch,
      'AiTranslated': ?instance.aiTranslated,
      'MachineTranslated': ?instance.machineTranslated,
      'Forced': ?instance.forced,
      'HearingImpaired': ?instance.hearingImpaired,
    };

RemoveFromPlaylistRequestDto _$RemoveFromPlaylistRequestDtoFromJson(
  Map<String, dynamic> json,
) => RemoveFromPlaylistRequestDto(
  playlistItemIds:
      (json['PlaylistItemIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  clearPlaylist: json['ClearPlaylist'] as bool?,
  clearPlayingItem: json['ClearPlayingItem'] as bool?,
);

Map<String, dynamic> _$RemoveFromPlaylistRequestDtoToJson(
  RemoveFromPlaylistRequestDto instance,
) => <String, dynamic>{
  'PlaylistItemIds': ?instance.playlistItemIds,
  'ClearPlaylist': ?instance.clearPlaylist,
  'ClearPlayingItem': ?instance.clearPlayingItem,
};

ReportPlaybackOptions _$ReportPlaybackOptionsFromJson(
  Map<String, dynamic> json,
) => ReportPlaybackOptions(
  maxDataAge: (json['MaxDataAge'] as num?)?.toInt(),
  backupPath: json['BackupPath'] as String?,
  maxBackupFiles: (json['MaxBackupFiles'] as num?)?.toInt(),
);

Map<String, dynamic> _$ReportPlaybackOptionsToJson(
  ReportPlaybackOptions instance,
) => <String, dynamic>{
  'MaxDataAge': ?instance.maxDataAge,
  'BackupPath': ?instance.backupPath,
  'MaxBackupFiles': ?instance.maxBackupFiles,
};

RepositoryInfo _$RepositoryInfoFromJson(Map<String, dynamic> json) =>
    RepositoryInfo(
      name: json['Name'] as String?,
      url: json['Url'] as String?,
      enabled: json['Enabled'] as bool?,
    );

Map<String, dynamic> _$RepositoryInfoToJson(RepositoryInfo instance) =>
    <String, dynamic>{
      'Name': ?instance.name,
      'Url': ?instance.url,
      'Enabled': ?instance.enabled,
    };

RestartRequiredMessage _$RestartRequiredMessageFromJson(
  Map<String, dynamic> json,
) => RestartRequiredMessage(
  messageId: json['MessageId'] as String?,
  messageType:
      RestartRequiredMessage.sessionMessageTypeMessageTypeNullableFromJson(
        json['MessageType'],
      ),
);

Map<String, dynamic> _$RestartRequiredMessageToJson(
  RestartRequiredMessage instance,
) => <String, dynamic>{
  'MessageId': ?instance.messageId,
  'MessageType': ?sessionMessageTypeNullableToJson(instance.messageType),
};

ScheduledTaskEndedMessage _$ScheduledTaskEndedMessageFromJson(
  Map<String, dynamic> json,
) => ScheduledTaskEndedMessage(
  data: json['Data'] == null
      ? null
      : TaskResult.fromJson(json['Data'] as Map<String, dynamic>),
  messageId: json['MessageId'] as String?,
  messageType:
      ScheduledTaskEndedMessage.sessionMessageTypeMessageTypeNullableFromJson(
        json['MessageType'],
      ),
);

Map<String, dynamic> _$ScheduledTaskEndedMessageToJson(
  ScheduledTaskEndedMessage instance,
) => <String, dynamic>{
  'Data': ?instance.data?.toJson(),
  'MessageId': ?instance.messageId,
  'MessageType': ?sessionMessageTypeNullableToJson(instance.messageType),
};

ScheduledTasksInfoMessage _$ScheduledTasksInfoMessageFromJson(
  Map<String, dynamic> json,
) => ScheduledTasksInfoMessage(
  data:
      (json['Data'] as List<dynamic>?)
          ?.map((e) => TaskInfo.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  messageId: json['MessageId'] as String?,
  messageType:
      ScheduledTasksInfoMessage.sessionMessageTypeMessageTypeNullableFromJson(
        json['MessageType'],
      ),
);

Map<String, dynamic> _$ScheduledTasksInfoMessageToJson(
  ScheduledTasksInfoMessage instance,
) => <String, dynamic>{
  'Data': ?instance.data?.map((e) => e.toJson()).toList(),
  'MessageId': ?instance.messageId,
  'MessageType': ?sessionMessageTypeNullableToJson(instance.messageType),
};

ScheduledTasksInfoStartMessage _$ScheduledTasksInfoStartMessageFromJson(
  Map<String, dynamic> json,
) => ScheduledTasksInfoStartMessage(
  data: json['Data'] as String?,
  messageType:
      ScheduledTasksInfoStartMessage.sessionMessageTypeMessageTypeNullableFromJson(
        json['MessageType'],
      ),
);

Map<String, dynamic> _$ScheduledTasksInfoStartMessageToJson(
  ScheduledTasksInfoStartMessage instance,
) => <String, dynamic>{
  'Data': ?instance.data,
  'MessageType': ?sessionMessageTypeNullableToJson(instance.messageType),
};

ScheduledTasksInfoStopMessage _$ScheduledTasksInfoStopMessageFromJson(
  Map<String, dynamic> json,
) => ScheduledTasksInfoStopMessage(
  messageType:
      ScheduledTasksInfoStopMessage.sessionMessageTypeMessageTypeNullableFromJson(
        json['MessageType'],
      ),
);

Map<String, dynamic> _$ScheduledTasksInfoStopMessageToJson(
  ScheduledTasksInfoStopMessage instance,
) => <String, dynamic>{
  'MessageType': ?sessionMessageTypeNullableToJson(instance.messageType),
};

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
  mediaType: SearchHint.mediaTypeMediaTypeNullableFromJson(json['MediaType']),
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
  artists:
      (json['Artists'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      [],
  songCount: (json['SongCount'] as num?)?.toInt(),
  episodeCount: (json['EpisodeCount'] as num?)?.toInt(),
  channelId: json['ChannelId'] as String?,
  channelName: json['ChannelName'] as String?,
  primaryImageAspectRatio: (json['PrimaryImageAspectRatio'] as num?)
      ?.toDouble(),
);

Map<String, dynamic> _$SearchHintToJson(SearchHint instance) =>
    <String, dynamic>{
      'ItemId': ?instance.itemId,
      'Id': ?instance.id,
      'Name': ?instance.name,
      'MatchedTerm': ?instance.matchedTerm,
      'IndexNumber': ?instance.indexNumber,
      'ProductionYear': ?instance.productionYear,
      'ParentIndexNumber': ?instance.parentIndexNumber,
      'PrimaryImageTag': ?instance.primaryImageTag,
      'ThumbImageTag': ?instance.thumbImageTag,
      'ThumbImageItemId': ?instance.thumbImageItemId,
      'BackdropImageTag': ?instance.backdropImageTag,
      'BackdropImageItemId': ?instance.backdropImageItemId,
      'Type': ?baseItemKindNullableToJson(instance.type),
      'IsFolder': ?instance.isFolder,
      'RunTimeTicks': ?instance.runTimeTicks,
      'MediaType': ?mediaTypeNullableToJson(instance.mediaType),
      'StartDate': ?instance.startDate?.toIso8601String(),
      'EndDate': ?instance.endDate?.toIso8601String(),
      'Series': ?instance.series,
      'Status': ?instance.status,
      'Album': ?instance.album,
      'AlbumId': ?instance.albumId,
      'AlbumArtist': ?instance.albumArtist,
      'Artists': ?instance.artists,
      'SongCount': ?instance.songCount,
      'EpisodeCount': ?instance.episodeCount,
      'ChannelId': ?instance.channelId,
      'ChannelName': ?instance.channelName,
      'PrimaryImageAspectRatio': ?instance.primaryImageAspectRatio,
    };

SearchHintResult _$SearchHintResultFromJson(Map<String, dynamic> json) =>
    SearchHintResult(
      searchHints:
          (json['SearchHints'] as List<dynamic>?)
              ?.map((e) => SearchHint.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      totalRecordCount: (json['TotalRecordCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SearchHintResultToJson(SearchHintResult instance) =>
    <String, dynamic>{
      'SearchHints': ?instance.searchHints?.map((e) => e.toJson()).toList(),
      'TotalRecordCount': ?instance.totalRecordCount,
    };

SeekRequestDto _$SeekRequestDtoFromJson(Map<String, dynamic> json) =>
    SeekRequestDto(positionTicks: (json['PositionTicks'] as num?)?.toInt());

Map<String, dynamic> _$SeekRequestDtoToJson(SeekRequestDto instance) =>
    <String, dynamic>{'PositionTicks': ?instance.positionTicks};

SendCommand _$SendCommandFromJson(Map<String, dynamic> json) => SendCommand(
  groupId: json['GroupId'] as String?,
  playlistItemId: json['PlaylistItemId'] as String?,
  when: json['When'] == null ? null : DateTime.parse(json['When'] as String),
  positionTicks: (json['PositionTicks'] as num?)?.toInt(),
  command: sendCommandTypeNullableFromJson(json['Command']),
  emittedAt: json['EmittedAt'] == null
      ? null
      : DateTime.parse(json['EmittedAt'] as String),
);

Map<String, dynamic> _$SendCommandToJson(SendCommand instance) =>
    <String, dynamic>{
      'GroupId': ?instance.groupId,
      'PlaylistItemId': ?instance.playlistItemId,
      'When': ?instance.when?.toIso8601String(),
      'PositionTicks': ?instance.positionTicks,
      'Command': ?sendCommandTypeNullableToJson(instance.command),
      'EmittedAt': ?instance.emittedAt?.toIso8601String(),
    };

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

Map<String, dynamic> _$SeriesInfoToJson(SeriesInfo instance) =>
    <String, dynamic>{
      'Name': ?instance.name,
      'OriginalTitle': ?instance.originalTitle,
      'Path': ?instance.path,
      'MetadataLanguage': ?instance.metadataLanguage,
      'MetadataCountryCode': ?instance.metadataCountryCode,
      'ProviderIds': ?instance.providerIds,
      'Year': ?instance.year,
      'IndexNumber': ?instance.indexNumber,
      'ParentIndexNumber': ?instance.parentIndexNumber,
      'PremiereDate': ?instance.premiereDate?.toIso8601String(),
      'IsAutomated': ?instance.isAutomated,
    };

SeriesInfoRemoteSearchQuery _$SeriesInfoRemoteSearchQueryFromJson(
  Map<String, dynamic> json,
) => SeriesInfoRemoteSearchQuery(
  searchInfo: json['SearchInfo'] == null
      ? null
      : SeriesInfo.fromJson(json['SearchInfo'] as Map<String, dynamic>),
  itemId: json['ItemId'] as String?,
  searchProviderName: json['SearchProviderName'] as String?,
  includeDisabledProviders: json['IncludeDisabledProviders'] as bool?,
);

Map<String, dynamic> _$SeriesInfoRemoteSearchQueryToJson(
  SeriesInfoRemoteSearchQuery instance,
) => <String, dynamic>{
  'SearchInfo': ?instance.searchInfo?.toJson(),
  'ItemId': ?instance.itemId,
  'SearchProviderName': ?instance.searchProviderName,
  'IncludeDisabledProviders': ?instance.includeDisabledProviders,
};

SeriesTimerCancelledMessage _$SeriesTimerCancelledMessageFromJson(
  Map<String, dynamic> json,
) => SeriesTimerCancelledMessage(
  data: json['Data'] == null
      ? null
      : TimerEventInfo.fromJson(json['Data'] as Map<String, dynamic>),
  messageId: json['MessageId'] as String?,
  messageType:
      SeriesTimerCancelledMessage.sessionMessageTypeMessageTypeNullableFromJson(
        json['MessageType'],
      ),
);

Map<String, dynamic> _$SeriesTimerCancelledMessageToJson(
  SeriesTimerCancelledMessage instance,
) => <String, dynamic>{
  'Data': ?instance.data?.toJson(),
  'MessageId': ?instance.messageId,
  'MessageType': ?sessionMessageTypeNullableToJson(instance.messageType),
};

SeriesTimerCreatedMessage _$SeriesTimerCreatedMessageFromJson(
  Map<String, dynamic> json,
) => SeriesTimerCreatedMessage(
  data: json['Data'] == null
      ? null
      : TimerEventInfo.fromJson(json['Data'] as Map<String, dynamic>),
  messageId: json['MessageId'] as String?,
  messageType:
      SeriesTimerCreatedMessage.sessionMessageTypeMessageTypeNullableFromJson(
        json['MessageType'],
      ),
);

Map<String, dynamic> _$SeriesTimerCreatedMessageToJson(
  SeriesTimerCreatedMessage instance,
) => <String, dynamic>{
  'Data': ?instance.data?.toJson(),
  'MessageId': ?instance.messageId,
  'MessageType': ?sessionMessageTypeNullableToJson(instance.messageType),
};

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

Map<String, dynamic> _$SeriesTimerInfoDtoToJson(SeriesTimerInfoDto instance) =>
    <String, dynamic>{
      'Id': ?instance.id,
      'Type': ?instance.type,
      'ServerId': ?instance.serverId,
      'ExternalId': ?instance.externalId,
      'ChannelId': ?instance.channelId,
      'ExternalChannelId': ?instance.externalChannelId,
      'ChannelName': ?instance.channelName,
      'ChannelPrimaryImageTag': ?instance.channelPrimaryImageTag,
      'ProgramId': ?instance.programId,
      'ExternalProgramId': ?instance.externalProgramId,
      'Name': ?instance.name,
      'Overview': ?instance.overview,
      'StartDate': ?instance.startDate?.toIso8601String(),
      'EndDate': ?instance.endDate?.toIso8601String(),
      'ServiceName': ?instance.serviceName,
      'Priority': ?instance.priority,
      'PrePaddingSeconds': ?instance.prePaddingSeconds,
      'PostPaddingSeconds': ?instance.postPaddingSeconds,
      'IsPrePaddingRequired': ?instance.isPrePaddingRequired,
      'ParentBackdropItemId': ?instance.parentBackdropItemId,
      'ParentBackdropImageTags': ?instance.parentBackdropImageTags,
      'IsPostPaddingRequired': ?instance.isPostPaddingRequired,
      'KeepUntil': ?keepUntilNullableToJson(instance.keepUntil),
      'RecordAnyTime': ?instance.recordAnyTime,
      'SkipEpisodesInLibrary': ?instance.skipEpisodesInLibrary,
      'RecordAnyChannel': ?instance.recordAnyChannel,
      'KeepUpTo': ?instance.keepUpTo,
      'RecordNewOnly': ?instance.recordNewOnly,
      'Days': dayOfWeekListToJson(instance.days),
      'DayPattern': ?dayPatternNullableToJson(instance.dayPattern),
      'ImageTags': ?instance.imageTags,
      'ParentThumbItemId': ?instance.parentThumbItemId,
      'ParentThumbImageTag': ?instance.parentThumbImageTag,
      'ParentPrimaryImageItemId': ?instance.parentPrimaryImageItemId,
      'ParentPrimaryImageTag': ?instance.parentPrimaryImageTag,
    };

SeriesTimerInfoDtoQueryResult _$SeriesTimerInfoDtoQueryResultFromJson(
  Map<String, dynamic> json,
) => SeriesTimerInfoDtoQueryResult(
  items:
      (json['Items'] as List<dynamic>?)
          ?.map((e) => SeriesTimerInfoDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  totalRecordCount: (json['TotalRecordCount'] as num?)?.toInt(),
  startIndex: (json['StartIndex'] as num?)?.toInt(),
);

Map<String, dynamic> _$SeriesTimerInfoDtoQueryResultToJson(
  SeriesTimerInfoDtoQueryResult instance,
) => <String, dynamic>{
  'Items': ?instance.items?.map((e) => e.toJson()).toList(),
  'TotalRecordCount': ?instance.totalRecordCount,
  'StartIndex': ?instance.startIndex,
};

ServerConfiguration _$ServerConfigurationFromJson(
  Map<String, dynamic> json,
) => ServerConfiguration(
  logFileRetentionDays: (json['LogFileRetentionDays'] as num?)?.toInt(),
  isStartupWizardCompleted: json['IsStartupWizardCompleted'] as bool?,
  cachePath: json['CachePath'] as String?,
  previousVersion: json['PreviousVersion'] as String?,
  previousVersionStr: json['PreviousVersionStr'] as String?,
  enableMetrics: json['EnableMetrics'] as bool?,
  enableNormalizedItemByNameIds: json['EnableNormalizedItemByNameIds'] as bool?,
  isPortAuthorized: json['IsPortAuthorized'] as bool?,
  quickConnectAvailable: json['QuickConnectAvailable'] as bool?,
  enableCaseSensitiveItemIds: json['EnableCaseSensitiveItemIds'] as bool?,
  disableLiveTvChannelUserDataName:
      json['DisableLiveTvChannelUserDataName'] as bool?,
  metadataPath: json['MetadataPath'] as String?,
  preferredMetadataLanguage: json['PreferredMetadataLanguage'] as String?,
  metadataCountryCode: json['MetadataCountryCode'] as String?,
  sortReplaceCharacters:
      (json['SortReplaceCharacters'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  sortRemoveCharacters:
      (json['SortRemoveCharacters'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  sortRemoveWords:
      (json['SortRemoveWords'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  minResumePct: (json['MinResumePct'] as num?)?.toInt(),
  maxResumePct: (json['MaxResumePct'] as num?)?.toInt(),
  minResumeDurationSeconds: (json['MinResumeDurationSeconds'] as num?)?.toInt(),
  minAudiobookResume: (json['MinAudiobookResume'] as num?)?.toInt(),
  maxAudiobookResume: (json['MaxAudiobookResume'] as num?)?.toInt(),
  inactiveSessionThreshold: (json['InactiveSessionThreshold'] as num?)?.toInt(),
  libraryMonitorDelay: (json['LibraryMonitorDelay'] as num?)?.toInt(),
  libraryUpdateDuration: (json['LibraryUpdateDuration'] as num?)?.toInt(),
  cacheSize: (json['CacheSize'] as num?)?.toInt(),
  imageSavingConvention: imageSavingConventionNullableFromJson(
    json['ImageSavingConvention'],
  ),
  metadataOptions:
      (json['MetadataOptions'] as List<dynamic>?)
          ?.map((e) => MetadataOptions.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  skipDeserializationForBasicTypes:
      json['SkipDeserializationForBasicTypes'] as bool?,
  serverName: json['ServerName'] as String?,
  uICulture: json['UICulture'] as String?,
  saveMetadataHidden: json['SaveMetadataHidden'] as bool?,
  contentTypes:
      (json['ContentTypes'] as List<dynamic>?)
          ?.map((e) => NameValuePair.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  remoteClientBitrateLimit: (json['RemoteClientBitrateLimit'] as num?)?.toInt(),
  enableFolderView: json['EnableFolderView'] as bool?,
  enableGroupingMoviesIntoCollections:
      json['EnableGroupingMoviesIntoCollections'] as bool?,
  enableGroupingShowsIntoCollections:
      json['EnableGroupingShowsIntoCollections'] as bool?,
  displaySpecialsWithinSeasons: json['DisplaySpecialsWithinSeasons'] as bool?,
  codecsUsed:
      (json['CodecsUsed'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  pluginRepositories:
      (json['PluginRepositories'] as List<dynamic>?)
          ?.map((e) => RepositoryInfo.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  enableExternalContentInSuggestions:
      json['EnableExternalContentInSuggestions'] as bool?,
  imageExtractionTimeoutMs: (json['ImageExtractionTimeoutMs'] as num?)?.toInt(),
  pathSubstitutions:
      (json['PathSubstitutions'] as List<dynamic>?)
          ?.map((e) => PathSubstitution.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  enableSlowResponseWarning: json['EnableSlowResponseWarning'] as bool?,
  slowResponseThresholdMs: (json['SlowResponseThresholdMs'] as num?)?.toInt(),
  corsHosts:
      (json['CorsHosts'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      [],
  activityLogRetentionDays: (json['ActivityLogRetentionDays'] as num?)?.toInt(),
  libraryScanFanoutConcurrency: (json['LibraryScanFanoutConcurrency'] as num?)
      ?.toInt(),
  libraryMetadataRefreshConcurrency:
      (json['LibraryMetadataRefreshConcurrency'] as num?)?.toInt(),
  allowClientLogUpload: json['AllowClientLogUpload'] as bool?,
  dummyChapterDuration: (json['DummyChapterDuration'] as num?)?.toInt(),
  chapterImageResolution: imageResolutionNullableFromJson(
    json['ChapterImageResolution'],
  ),
  parallelImageEncodingLimit: (json['ParallelImageEncodingLimit'] as num?)
      ?.toInt(),
  castReceiverApplications:
      (json['CastReceiverApplications'] as List<dynamic>?)
          ?.map(
            (e) => CastReceiverApplication.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      [],
  trickplayOptions: json['TrickplayOptions'] == null
      ? null
      : TrickplayOptions.fromJson(
          json['TrickplayOptions'] as Map<String, dynamic>,
        ),
  enableLegacyAuthorization: json['EnableLegacyAuthorization'] as bool?,
);

Map<String, dynamic> _$ServerConfigurationToJson(
  ServerConfiguration instance,
) => <String, dynamic>{
  'LogFileRetentionDays': ?instance.logFileRetentionDays,
  'IsStartupWizardCompleted': ?instance.isStartupWizardCompleted,
  'CachePath': ?instance.cachePath,
  'PreviousVersion': ?instance.previousVersion,
  'PreviousVersionStr': ?instance.previousVersionStr,
  'EnableMetrics': ?instance.enableMetrics,
  'EnableNormalizedItemByNameIds': ?instance.enableNormalizedItemByNameIds,
  'IsPortAuthorized': ?instance.isPortAuthorized,
  'QuickConnectAvailable': ?instance.quickConnectAvailable,
  'EnableCaseSensitiveItemIds': ?instance.enableCaseSensitiveItemIds,
  'DisableLiveTvChannelUserDataName':
      ?instance.disableLiveTvChannelUserDataName,
  'MetadataPath': ?instance.metadataPath,
  'PreferredMetadataLanguage': ?instance.preferredMetadataLanguage,
  'MetadataCountryCode': ?instance.metadataCountryCode,
  'SortReplaceCharacters': ?instance.sortReplaceCharacters,
  'SortRemoveCharacters': ?instance.sortRemoveCharacters,
  'SortRemoveWords': ?instance.sortRemoveWords,
  'MinResumePct': ?instance.minResumePct,
  'MaxResumePct': ?instance.maxResumePct,
  'MinResumeDurationSeconds': ?instance.minResumeDurationSeconds,
  'MinAudiobookResume': ?instance.minAudiobookResume,
  'MaxAudiobookResume': ?instance.maxAudiobookResume,
  'InactiveSessionThreshold': ?instance.inactiveSessionThreshold,
  'LibraryMonitorDelay': ?instance.libraryMonitorDelay,
  'LibraryUpdateDuration': ?instance.libraryUpdateDuration,
  'CacheSize': ?instance.cacheSize,
  'ImageSavingConvention': ?imageSavingConventionNullableToJson(
    instance.imageSavingConvention,
  ),
  'MetadataOptions': ?instance.metadataOptions?.map((e) => e.toJson()).toList(),
  'SkipDeserializationForBasicTypes':
      ?instance.skipDeserializationForBasicTypes,
  'ServerName': ?instance.serverName,
  'UICulture': ?instance.uICulture,
  'SaveMetadataHidden': ?instance.saveMetadataHidden,
  'ContentTypes': ?instance.contentTypes?.map((e) => e.toJson()).toList(),
  'RemoteClientBitrateLimit': ?instance.remoteClientBitrateLimit,
  'EnableFolderView': ?instance.enableFolderView,
  'EnableGroupingMoviesIntoCollections':
      ?instance.enableGroupingMoviesIntoCollections,
  'EnableGroupingShowsIntoCollections':
      ?instance.enableGroupingShowsIntoCollections,
  'DisplaySpecialsWithinSeasons': ?instance.displaySpecialsWithinSeasons,
  'CodecsUsed': ?instance.codecsUsed,
  'PluginRepositories': ?instance.pluginRepositories
      ?.map((e) => e.toJson())
      .toList(),
  'EnableExternalContentInSuggestions':
      ?instance.enableExternalContentInSuggestions,
  'ImageExtractionTimeoutMs': ?instance.imageExtractionTimeoutMs,
  'PathSubstitutions': ?instance.pathSubstitutions
      ?.map((e) => e.toJson())
      .toList(),
  'EnableSlowResponseWarning': ?instance.enableSlowResponseWarning,
  'SlowResponseThresholdMs': ?instance.slowResponseThresholdMs,
  'CorsHosts': ?instance.corsHosts,
  'ActivityLogRetentionDays': ?instance.activityLogRetentionDays,
  'LibraryScanFanoutConcurrency': ?instance.libraryScanFanoutConcurrency,
  'LibraryMetadataRefreshConcurrency':
      ?instance.libraryMetadataRefreshConcurrency,
  'AllowClientLogUpload': ?instance.allowClientLogUpload,
  'DummyChapterDuration': ?instance.dummyChapterDuration,
  'ChapterImageResolution': ?imageResolutionNullableToJson(
    instance.chapterImageResolution,
  ),
  'ParallelImageEncodingLimit': ?instance.parallelImageEncodingLimit,
  'CastReceiverApplications': ?instance.castReceiverApplications
      ?.map((e) => e.toJson())
      .toList(),
  'TrickplayOptions': ?instance.trickplayOptions?.toJson(),
  'EnableLegacyAuthorization': ?instance.enableLegacyAuthorization,
};

ServerDiscoveryInfo _$ServerDiscoveryInfoFromJson(Map<String, dynamic> json) =>
    ServerDiscoveryInfo(
      address: json['Address'] as String?,
      id: json['Id'] as String?,
      name: json['Name'] as String?,
      endpointAddress: json['EndpointAddress'] as String?,
    );

Map<String, dynamic> _$ServerDiscoveryInfoToJson(
  ServerDiscoveryInfo instance,
) => <String, dynamic>{
  'Address': ?instance.address,
  'Id': ?instance.id,
  'Name': ?instance.name,
  'EndpointAddress': ?instance.endpointAddress,
};

ServerRestartingMessage _$ServerRestartingMessageFromJson(
  Map<String, dynamic> json,
) => ServerRestartingMessage(
  messageId: json['MessageId'] as String?,
  messageType:
      ServerRestartingMessage.sessionMessageTypeMessageTypeNullableFromJson(
        json['MessageType'],
      ),
);

Map<String, dynamic> _$ServerRestartingMessageToJson(
  ServerRestartingMessage instance,
) => <String, dynamic>{
  'MessageId': ?instance.messageId,
  'MessageType': ?sessionMessageTypeNullableToJson(instance.messageType),
};

ServerShuttingDownMessage _$ServerShuttingDownMessageFromJson(
  Map<String, dynamic> json,
) => ServerShuttingDownMessage(
  messageId: json['MessageId'] as String?,
  messageType:
      ServerShuttingDownMessage.sessionMessageTypeMessageTypeNullableFromJson(
        json['MessageType'],
      ),
);

Map<String, dynamic> _$ServerShuttingDownMessageToJson(
  ServerShuttingDownMessage instance,
) => <String, dynamic>{
  'MessageId': ?instance.messageId,
  'MessageType': ?sessionMessageTypeNullableToJson(instance.messageType),
};

SessionInfoDto _$SessionInfoDtoFromJson(
  Map<String, dynamic> json,
) => SessionInfoDto(
  playState: json['PlayState'] == null
      ? null
      : PlayerStateInfo.fromJson(json['PlayState'] as Map<String, dynamic>),
  additionalUsers:
      (json['AdditionalUsers'] as List<dynamic>?)
          ?.map((e) => SessionUserInfo.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  capabilities: json['Capabilities'] == null
      ? null
      : ClientCapabilitiesDto.fromJson(
          json['Capabilities'] as Map<String, dynamic>,
        ),
  remoteEndPoint: json['RemoteEndPoint'] as String?,
  playableMediaTypes: mediaTypeListFromJson(
    json['PlayableMediaTypes'] as List?,
  ),
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
      : BaseItemDto.fromJson(json['NowPlayingItem'] as Map<String, dynamic>),
  nowViewingItem: json['NowViewingItem'] == null
      ? null
      : BaseItemDto.fromJson(json['NowViewingItem'] as Map<String, dynamic>),
  deviceId: json['DeviceId'] as String?,
  applicationVersion: json['ApplicationVersion'] as String?,
  transcodingInfo: json['TranscodingInfo'] == null
      ? null
      : TranscodingInfo.fromJson(
          json['TranscodingInfo'] as Map<String, dynamic>,
        ),
  isActive: json['IsActive'] as bool?,
  supportsMediaControl: json['SupportsMediaControl'] as bool?,
  supportsRemoteControl: json['SupportsRemoteControl'] as bool?,
  nowPlayingQueue:
      (json['NowPlayingQueue'] as List<dynamic>?)
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
  supportedCommands: generalCommandTypeListFromJson(
    json['SupportedCommands'] as List?,
  ),
);

Map<String, dynamic> _$SessionInfoDtoToJson(
  SessionInfoDto instance,
) => <String, dynamic>{
  'PlayState': ?instance.playState?.toJson(),
  'AdditionalUsers': ?instance.additionalUsers?.map((e) => e.toJson()).toList(),
  'Capabilities': ?instance.capabilities?.toJson(),
  'RemoteEndPoint': ?instance.remoteEndPoint,
  'PlayableMediaTypes': mediaTypeListToJson(instance.playableMediaTypes),
  'Id': ?instance.id,
  'UserId': ?instance.userId,
  'UserName': ?instance.userName,
  'Client': ?instance.$Client,
  'LastActivityDate': ?instance.lastActivityDate?.toIso8601String(),
  'LastPlaybackCheckIn': ?instance.lastPlaybackCheckIn?.toIso8601String(),
  'LastPausedDate': ?instance.lastPausedDate?.toIso8601String(),
  'DeviceName': ?instance.deviceName,
  'DeviceType': ?instance.deviceType,
  'NowPlayingItem': ?instance.nowPlayingItem?.toJson(),
  'NowViewingItem': ?instance.nowViewingItem?.toJson(),
  'DeviceId': ?instance.deviceId,
  'ApplicationVersion': ?instance.applicationVersion,
  'TranscodingInfo': ?instance.transcodingInfo?.toJson(),
  'IsActive': ?instance.isActive,
  'SupportsMediaControl': ?instance.supportsMediaControl,
  'SupportsRemoteControl': ?instance.supportsRemoteControl,
  'NowPlayingQueue': ?instance.nowPlayingQueue?.map((e) => e.toJson()).toList(),
  'NowPlayingQueueFullItems': ?instance.nowPlayingQueueFullItems
      ?.map((e) => e.toJson())
      .toList(),
  'HasCustomDeviceName': ?instance.hasCustomDeviceName,
  'PlaylistItemId': ?instance.playlistItemId,
  'ServerId': ?instance.serverId,
  'UserPrimaryImageTag': ?instance.userPrimaryImageTag,
  'SupportedCommands': generalCommandTypeListToJson(instance.supportedCommands),
};

SessionsMessage _$SessionsMessageFromJson(Map<String, dynamic> json) =>
    SessionsMessage(
      data:
          (json['Data'] as List<dynamic>?)
              ?.map((e) => SessionInfoDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      messageId: json['MessageId'] as String?,
      messageType:
          SessionsMessage.sessionMessageTypeMessageTypeNullableFromJson(
            json['MessageType'],
          ),
    );

Map<String, dynamic> _$SessionsMessageToJson(SessionsMessage instance) =>
    <String, dynamic>{
      'Data': ?instance.data?.map((e) => e.toJson()).toList(),
      'MessageId': ?instance.messageId,
      'MessageType': ?sessionMessageTypeNullableToJson(instance.messageType),
    };

SessionsStartMessage _$SessionsStartMessageFromJson(
  Map<String, dynamic> json,
) => SessionsStartMessage(
  data: json['Data'] as String?,
  messageType:
      SessionsStartMessage.sessionMessageTypeMessageTypeNullableFromJson(
        json['MessageType'],
      ),
);

Map<String, dynamic> _$SessionsStartMessageToJson(
  SessionsStartMessage instance,
) => <String, dynamic>{
  'Data': ?instance.data,
  'MessageType': ?sessionMessageTypeNullableToJson(instance.messageType),
};

SessionsStopMessage _$SessionsStopMessageFromJson(Map<String, dynamic> json) =>
    SessionsStopMessage(
      messageType:
          SessionsStopMessage.sessionMessageTypeMessageTypeNullableFromJson(
            json['MessageType'],
          ),
    );

Map<String, dynamic> _$SessionsStopMessageToJson(
  SessionsStopMessage instance,
) => <String, dynamic>{
  'MessageType': ?sessionMessageTypeNullableToJson(instance.messageType),
};

SessionUserInfo _$SessionUserInfoFromJson(Map<String, dynamic> json) =>
    SessionUserInfo(
      userId: json['UserId'] as String?,
      userName: json['UserName'] as String?,
    );

Map<String, dynamic> _$SessionUserInfoToJson(SessionUserInfo instance) =>
    <String, dynamic>{
      'UserId': ?instance.userId,
      'UserName': ?instance.userName,
    };

SetChannelMappingDto _$SetChannelMappingDtoFromJson(
  Map<String, dynamic> json,
) => SetChannelMappingDto(
  providerId: json['ProviderId'] as String,
  tunerChannelId: json['TunerChannelId'] as String,
  providerChannelId: json['ProviderChannelId'] as String,
);

Map<String, dynamic> _$SetChannelMappingDtoToJson(
  SetChannelMappingDto instance,
) => <String, dynamic>{
  'ProviderId': instance.providerId,
  'TunerChannelId': instance.tunerChannelId,
  'ProviderChannelId': instance.providerChannelId,
};

SetPlaylistItemRequestDto _$SetPlaylistItemRequestDtoFromJson(
  Map<String, dynamic> json,
) => SetPlaylistItemRequestDto(
  playlistItemId: json['PlaylistItemId'] as String?,
);

Map<String, dynamic> _$SetPlaylistItemRequestDtoToJson(
  SetPlaylistItemRequestDto instance,
) => <String, dynamic>{'PlaylistItemId': ?instance.playlistItemId};

SetRepeatModeRequestDto _$SetRepeatModeRequestDtoFromJson(
  Map<String, dynamic> json,
) => SetRepeatModeRequestDto(
  mode: groupRepeatModeNullableFromJson(json['Mode']),
);

Map<String, dynamic> _$SetRepeatModeRequestDtoToJson(
  SetRepeatModeRequestDto instance,
) => <String, dynamic>{'Mode': ?groupRepeatModeNullableToJson(instance.mode)};

SetShuffleModeRequestDto _$SetShuffleModeRequestDtoFromJson(
  Map<String, dynamic> json,
) => SetShuffleModeRequestDto(
  mode: groupShuffleModeNullableFromJson(json['Mode']),
);

Map<String, dynamic> _$SetShuffleModeRequestDtoToJson(
  SetShuffleModeRequestDto instance,
) => <String, dynamic>{'Mode': ?groupShuffleModeNullableToJson(instance.mode)};

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
  albumArtists:
      (json['AlbumArtists'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  album: json['Album'] as String?,
  artists:
      (json['Artists'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      [],
);

Map<String, dynamic> _$SongInfoToJson(SongInfo instance) => <String, dynamic>{
  'Name': ?instance.name,
  'OriginalTitle': ?instance.originalTitle,
  'Path': ?instance.path,
  'MetadataLanguage': ?instance.metadataLanguage,
  'MetadataCountryCode': ?instance.metadataCountryCode,
  'ProviderIds': ?instance.providerIds,
  'Year': ?instance.year,
  'IndexNumber': ?instance.indexNumber,
  'ParentIndexNumber': ?instance.parentIndexNumber,
  'PremiereDate': ?instance.premiereDate?.toIso8601String(),
  'IsAutomated': ?instance.isAutomated,
  'AlbumArtists': ?instance.albumArtists,
  'Album': ?instance.album,
  'Artists': ?instance.artists,
};

SpecialViewOptionDto _$SpecialViewOptionDtoFromJson(
  Map<String, dynamic> json,
) => SpecialViewOptionDto(
  name: json['Name'] as String?,
  id: json['Id'] as String?,
);

Map<String, dynamic> _$SpecialViewOptionDtoToJson(
  SpecialViewOptionDto instance,
) => <String, dynamic>{'Name': ?instance.name, 'Id': ?instance.id};

StartupConfigurationDto _$StartupConfigurationDtoFromJson(
  Map<String, dynamic> json,
) => StartupConfigurationDto(
  serverName: json['ServerName'] as String?,
  uICulture: json['UICulture'] as String?,
  metadataCountryCode: json['MetadataCountryCode'] as String?,
  preferredMetadataLanguage: json['PreferredMetadataLanguage'] as String?,
);

Map<String, dynamic> _$StartupConfigurationDtoToJson(
  StartupConfigurationDto instance,
) => <String, dynamic>{
  'ServerName': ?instance.serverName,
  'UICulture': ?instance.uICulture,
  'MetadataCountryCode': ?instance.metadataCountryCode,
  'PreferredMetadataLanguage': ?instance.preferredMetadataLanguage,
};

StartupRemoteAccessDto _$StartupRemoteAccessDtoFromJson(
  Map<String, dynamic> json,
) => StartupRemoteAccessDto(
  enableRemoteAccess: json['EnableRemoteAccess'] as bool,
  enableAutomaticPortMapping: json['EnableAutomaticPortMapping'] as bool,
);

Map<String, dynamic> _$StartupRemoteAccessDtoToJson(
  StartupRemoteAccessDto instance,
) => <String, dynamic>{
  'EnableRemoteAccess': instance.enableRemoteAccess,
  'EnableAutomaticPortMapping': instance.enableAutomaticPortMapping,
};

StartupUserDto _$StartupUserDtoFromJson(Map<String, dynamic> json) =>
    StartupUserDto(
      name: json['Name'] as String?,
      password: json['Password'] as String?,
    );

Map<String, dynamic> _$StartupUserDtoToJson(StartupUserDto instance) =>
    <String, dynamic>{'Name': ?instance.name, 'Password': ?instance.password};

SubtitleOptions _$SubtitleOptionsFromJson(Map<String, dynamic> json) =>
    SubtitleOptions(
      skipIfEmbeddedSubtitlesPresent:
          json['SkipIfEmbeddedSubtitlesPresent'] as bool?,
      skipIfAudioTrackMatches: json['SkipIfAudioTrackMatches'] as bool?,
      downloadLanguages:
          (json['DownloadLanguages'] as List<dynamic>?)
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

Map<String, dynamic> _$SubtitleOptionsToJson(
  SubtitleOptions instance,
) => <String, dynamic>{
  'SkipIfEmbeddedSubtitlesPresent': ?instance.skipIfEmbeddedSubtitlesPresent,
  'SkipIfAudioTrackMatches': ?instance.skipIfAudioTrackMatches,
  'DownloadLanguages': ?instance.downloadLanguages,
  'DownloadMovieSubtitles': ?instance.downloadMovieSubtitles,
  'DownloadEpisodeSubtitles': ?instance.downloadEpisodeSubtitles,
  'OpenSubtitlesUsername': ?instance.openSubtitlesUsername,
  'OpenSubtitlesPasswordHash': ?instance.openSubtitlesPasswordHash,
  'IsOpenSubtitleVipAccount': ?instance.isOpenSubtitleVipAccount,
  'RequirePerfectMatch': ?instance.requirePerfectMatch,
};

SubtitleProfile _$SubtitleProfileFromJson(Map<String, dynamic> json) =>
    SubtitleProfile(
      format: json['Format'] as String?,
      method: subtitleDeliveryMethodNullableFromJson(json['Method']),
      didlMode: json['DidlMode'] as String?,
      language: json['Language'] as String?,
      container: json['Container'] as String?,
    );

Map<String, dynamic> _$SubtitleProfileToJson(SubtitleProfile instance) =>
    <String, dynamic>{
      'Format': ?instance.format,
      'Method': ?subtitleDeliveryMethodNullableToJson(instance.method),
      'DidlMode': ?instance.didlMode,
      'Language': ?instance.language,
      'Container': ?instance.container,
    };

SyncPlayCommandMessage _$SyncPlayCommandMessageFromJson(
  Map<String, dynamic> json,
) => SyncPlayCommandMessage(
  data: json['Data'] == null
      ? null
      : SendCommand.fromJson(json['Data'] as Map<String, dynamic>),
  messageId: json['MessageId'] as String?,
  messageType:
      SyncPlayCommandMessage.sessionMessageTypeMessageTypeNullableFromJson(
        json['MessageType'],
      ),
);

Map<String, dynamic> _$SyncPlayCommandMessageToJson(
  SyncPlayCommandMessage instance,
) => <String, dynamic>{
  'Data': ?instance.data?.toJson(),
  'MessageId': ?instance.messageId,
  'MessageType': ?sessionMessageTypeNullableToJson(instance.messageType),
};

SyncPlayGroupDoesNotExistUpdate _$SyncPlayGroupDoesNotExistUpdateFromJson(
  Map<String, dynamic> json,
) => SyncPlayGroupDoesNotExistUpdate(
  groupId: json['GroupId'] as String?,
  data: json['Data'] as String?,
  type: SyncPlayGroupDoesNotExistUpdate.groupUpdateTypeTypeNullableFromJson(
    json['Type'],
  ),
);

Map<String, dynamic> _$SyncPlayGroupDoesNotExistUpdateToJson(
  SyncPlayGroupDoesNotExistUpdate instance,
) => <String, dynamic>{
  'GroupId': ?instance.groupId,
  'Data': ?instance.data,
  'Type': ?groupUpdateTypeNullableToJson(instance.type),
};

SyncPlayGroupJoinedUpdate _$SyncPlayGroupJoinedUpdateFromJson(
  Map<String, dynamic> json,
) => SyncPlayGroupJoinedUpdate(
  groupId: json['GroupId'] as String?,
  data: json['Data'] == null
      ? null
      : GroupInfoDto.fromJson(json['Data'] as Map<String, dynamic>),
  type: SyncPlayGroupJoinedUpdate.groupUpdateTypeTypeNullableFromJson(
    json['Type'],
  ),
);

Map<String, dynamic> _$SyncPlayGroupJoinedUpdateToJson(
  SyncPlayGroupJoinedUpdate instance,
) => <String, dynamic>{
  'GroupId': ?instance.groupId,
  'Data': ?instance.data?.toJson(),
  'Type': ?groupUpdateTypeNullableToJson(instance.type),
};

SyncPlayGroupLeftUpdate _$SyncPlayGroupLeftUpdateFromJson(
  Map<String, dynamic> json,
) => SyncPlayGroupLeftUpdate(
  groupId: json['GroupId'] as String?,
  data: json['Data'] as String?,
  type: SyncPlayGroupLeftUpdate.groupUpdateTypeTypeNullableFromJson(
    json['Type'],
  ),
);

Map<String, dynamic> _$SyncPlayGroupLeftUpdateToJson(
  SyncPlayGroupLeftUpdate instance,
) => <String, dynamic>{
  'GroupId': ?instance.groupId,
  'Data': ?instance.data,
  'Type': ?groupUpdateTypeNullableToJson(instance.type),
};

SyncPlayGroupUpdateMessage _$SyncPlayGroupUpdateMessageFromJson(
  Map<String, dynamic> json,
) => SyncPlayGroupUpdateMessage(
  data: json['Data'] == null
      ? null
      : GroupUpdate.fromJson(json['Data'] as Map<String, dynamic>),
  messageId: json['MessageId'] as String?,
  messageType:
      SyncPlayGroupUpdateMessage.sessionMessageTypeMessageTypeNullableFromJson(
        json['MessageType'],
      ),
);

Map<String, dynamic> _$SyncPlayGroupUpdateMessageToJson(
  SyncPlayGroupUpdateMessage instance,
) => <String, dynamic>{
  'Data': ?instance.data?.toJson(),
  'MessageId': ?instance.messageId,
  'MessageType': ?sessionMessageTypeNullableToJson(instance.messageType),
};

SyncPlayLibraryAccessDeniedUpdate _$SyncPlayLibraryAccessDeniedUpdateFromJson(
  Map<String, dynamic> json,
) => SyncPlayLibraryAccessDeniedUpdate(
  groupId: json['GroupId'] as String?,
  data: json['Data'] as String?,
  type: SyncPlayLibraryAccessDeniedUpdate.groupUpdateTypeTypeNullableFromJson(
    json['Type'],
  ),
);

Map<String, dynamic> _$SyncPlayLibraryAccessDeniedUpdateToJson(
  SyncPlayLibraryAccessDeniedUpdate instance,
) => <String, dynamic>{
  'GroupId': ?instance.groupId,
  'Data': ?instance.data,
  'Type': ?groupUpdateTypeNullableToJson(instance.type),
};

SyncPlayNotInGroupUpdate _$SyncPlayNotInGroupUpdateFromJson(
  Map<String, dynamic> json,
) => SyncPlayNotInGroupUpdate(
  groupId: json['GroupId'] as String?,
  data: json['Data'] as String?,
  type: SyncPlayNotInGroupUpdate.groupUpdateTypeTypeNullableFromJson(
    json['Type'],
  ),
);

Map<String, dynamic> _$SyncPlayNotInGroupUpdateToJson(
  SyncPlayNotInGroupUpdate instance,
) => <String, dynamic>{
  'GroupId': ?instance.groupId,
  'Data': ?instance.data,
  'Type': ?groupUpdateTypeNullableToJson(instance.type),
};

SyncPlayPlayQueueUpdate _$SyncPlayPlayQueueUpdateFromJson(
  Map<String, dynamic> json,
) => SyncPlayPlayQueueUpdate(
  groupId: json['GroupId'] as String?,
  data: json['Data'] == null
      ? null
      : PlayQueueUpdate.fromJson(json['Data'] as Map<String, dynamic>),
  type: SyncPlayPlayQueueUpdate.groupUpdateTypeTypeNullableFromJson(
    json['Type'],
  ),
);

Map<String, dynamic> _$SyncPlayPlayQueueUpdateToJson(
  SyncPlayPlayQueueUpdate instance,
) => <String, dynamic>{
  'GroupId': ?instance.groupId,
  'Data': ?instance.data?.toJson(),
  'Type': ?groupUpdateTypeNullableToJson(instance.type),
};

SyncPlayQueueItem _$SyncPlayQueueItemFromJson(Map<String, dynamic> json) =>
    SyncPlayQueueItem(
      itemId: json['ItemId'] as String?,
      playlistItemId: json['PlaylistItemId'] as String?,
    );

Map<String, dynamic> _$SyncPlayQueueItemToJson(SyncPlayQueueItem instance) =>
    <String, dynamic>{
      'ItemId': ?instance.itemId,
      'PlaylistItemId': ?instance.playlistItemId,
    };

SyncPlayStateUpdate _$SyncPlayStateUpdateFromJson(Map<String, dynamic> json) =>
    SyncPlayStateUpdate(
      groupId: json['GroupId'] as String?,
      data: json['Data'] == null
          ? null
          : GroupStateUpdate.fromJson(json['Data'] as Map<String, dynamic>),
      type: SyncPlayStateUpdate.groupUpdateTypeTypeNullableFromJson(
        json['Type'],
      ),
    );

Map<String, dynamic> _$SyncPlayStateUpdateToJson(
  SyncPlayStateUpdate instance,
) => <String, dynamic>{
  'GroupId': ?instance.groupId,
  'Data': ?instance.data?.toJson(),
  'Type': ?groupUpdateTypeNullableToJson(instance.type),
};

SyncPlayUserJoinedUpdate _$SyncPlayUserJoinedUpdateFromJson(
  Map<String, dynamic> json,
) => SyncPlayUserJoinedUpdate(
  groupId: json['GroupId'] as String?,
  data: json['Data'] as String?,
  type: SyncPlayUserJoinedUpdate.groupUpdateTypeTypeNullableFromJson(
    json['Type'],
  ),
);

Map<String, dynamic> _$SyncPlayUserJoinedUpdateToJson(
  SyncPlayUserJoinedUpdate instance,
) => <String, dynamic>{
  'GroupId': ?instance.groupId,
  'Data': ?instance.data,
  'Type': ?groupUpdateTypeNullableToJson(instance.type),
};

SyncPlayUserLeftUpdate _$SyncPlayUserLeftUpdateFromJson(
  Map<String, dynamic> json,
) => SyncPlayUserLeftUpdate(
  groupId: json['GroupId'] as String?,
  data: json['Data'] as String?,
  type: SyncPlayUserLeftUpdate.groupUpdateTypeTypeNullableFromJson(
    json['Type'],
  ),
);

Map<String, dynamic> _$SyncPlayUserLeftUpdateToJson(
  SyncPlayUserLeftUpdate instance,
) => <String, dynamic>{
  'GroupId': ?instance.groupId,
  'Data': ?instance.data,
  'Type': ?groupUpdateTypeNullableToJson(instance.type),
};

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
  completedInstallations:
      (json['CompletedInstallations'] as List<dynamic>?)
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
  castReceiverApplications:
      (json['CastReceiverApplications'] as List<dynamic>?)
          ?.map(
            (e) => CastReceiverApplication.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      [],
  hasUpdateAvailable: json['HasUpdateAvailable'] as bool? ?? false,
  encoderLocation: json['EncoderLocation'] as String?,
  systemArchitecture: json['SystemArchitecture'] as String?,
);

Map<String, dynamic> _$SystemInfoToJson(SystemInfo instance) =>
    <String, dynamic>{
      'LocalAddress': ?instance.localAddress,
      'ServerName': ?instance.serverName,
      'Version': ?instance.version,
      'ProductName': ?instance.productName,
      'OperatingSystem': ?instance.operatingSystem,
      'Id': ?instance.id,
      'StartupWizardCompleted': ?instance.startupWizardCompleted,
      'OperatingSystemDisplayName': ?instance.operatingSystemDisplayName,
      'PackageName': ?instance.packageName,
      'HasPendingRestart': ?instance.hasPendingRestart,
      'IsShuttingDown': ?instance.isShuttingDown,
      'SupportsLibraryMonitor': ?instance.supportsLibraryMonitor,
      'WebSocketPortNumber': ?instance.webSocketPortNumber,
      'CompletedInstallations': ?instance.completedInstallations
          ?.map((e) => e.toJson())
          .toList(),
      'CanSelfRestart': ?instance.canSelfRestart,
      'CanLaunchWebBrowser': ?instance.canLaunchWebBrowser,
      'ProgramDataPath': ?instance.programDataPath,
      'WebPath': ?instance.webPath,
      'ItemsByNamePath': ?instance.itemsByNamePath,
      'CachePath': ?instance.cachePath,
      'LogPath': ?instance.logPath,
      'InternalMetadataPath': ?instance.internalMetadataPath,
      'TranscodingTempPath': ?instance.transcodingTempPath,
      'CastReceiverApplications': ?instance.castReceiverApplications
          ?.map((e) => e.toJson())
          .toList(),
      'HasUpdateAvailable': ?instance.hasUpdateAvailable,
      'EncoderLocation': ?instance.encoderLocation,
      'SystemArchitecture': ?instance.systemArchitecture,
    };

SystemStorageDto _$SystemStorageDtoFromJson(
  Map<String, dynamic> json,
) => SystemStorageDto(
  programDataFolder: json['ProgramDataFolder'] == null
      ? null
      : FolderStorageDto.fromJson(
          json['ProgramDataFolder'] as Map<String, dynamic>,
        ),
  webFolder: json['WebFolder'] == null
      ? null
      : FolderStorageDto.fromJson(json['WebFolder'] as Map<String, dynamic>),
  imageCacheFolder: json['ImageCacheFolder'] == null
      ? null
      : FolderStorageDto.fromJson(
          json['ImageCacheFolder'] as Map<String, dynamic>,
        ),
  cacheFolder: json['CacheFolder'] == null
      ? null
      : FolderStorageDto.fromJson(json['CacheFolder'] as Map<String, dynamic>),
  logFolder: json['LogFolder'] == null
      ? null
      : FolderStorageDto.fromJson(json['LogFolder'] as Map<String, dynamic>),
  internalMetadataFolder: json['InternalMetadataFolder'] == null
      ? null
      : FolderStorageDto.fromJson(
          json['InternalMetadataFolder'] as Map<String, dynamic>,
        ),
  transcodingTempFolder: json['TranscodingTempFolder'] == null
      ? null
      : FolderStorageDto.fromJson(
          json['TranscodingTempFolder'] as Map<String, dynamic>,
        ),
  libraries:
      (json['Libraries'] as List<dynamic>?)
          ?.map((e) => LibraryStorageDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$SystemStorageDtoToJson(SystemStorageDto instance) =>
    <String, dynamic>{
      'ProgramDataFolder': ?instance.programDataFolder?.toJson(),
      'WebFolder': ?instance.webFolder?.toJson(),
      'ImageCacheFolder': ?instance.imageCacheFolder?.toJson(),
      'CacheFolder': ?instance.cacheFolder?.toJson(),
      'LogFolder': ?instance.logFolder?.toJson(),
      'InternalMetadataFolder': ?instance.internalMetadataFolder?.toJson(),
      'TranscodingTempFolder': ?instance.transcodingTempFolder?.toJson(),
      'Libraries': ?instance.libraries?.map((e) => e.toJson()).toList(),
    };

TaskInfo _$TaskInfoFromJson(Map<String, dynamic> json) => TaskInfo(
  name: json['Name'] as String?,
  state: taskStateNullableFromJson(json['State']),
  currentProgressPercentage: (json['CurrentProgressPercentage'] as num?)
      ?.toDouble(),
  id: json['Id'] as String?,
  lastExecutionResult: json['LastExecutionResult'] == null
      ? null
      : TaskResult.fromJson(
          json['LastExecutionResult'] as Map<String, dynamic>,
        ),
  triggers:
      (json['Triggers'] as List<dynamic>?)
          ?.map((e) => TaskTriggerInfo.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  description: json['Description'] as String?,
  category: json['Category'] as String?,
  isHidden: json['IsHidden'] as bool?,
  key: json['Key'] as String?,
);

Map<String, dynamic> _$TaskInfoToJson(TaskInfo instance) => <String, dynamic>{
  'Name': ?instance.name,
  'State': ?taskStateNullableToJson(instance.state),
  'CurrentProgressPercentage': ?instance.currentProgressPercentage,
  'Id': ?instance.id,
  'LastExecutionResult': ?instance.lastExecutionResult?.toJson(),
  'Triggers': ?instance.triggers?.map((e) => e.toJson()).toList(),
  'Description': ?instance.description,
  'Category': ?instance.category,
  'IsHidden': ?instance.isHidden,
  'Key': ?instance.key,
};

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

Map<String, dynamic> _$TaskResultToJson(TaskResult instance) =>
    <String, dynamic>{
      'StartTimeUtc': ?instance.startTimeUtc?.toIso8601String(),
      'EndTimeUtc': ?instance.endTimeUtc?.toIso8601String(),
      'Status': ?taskCompletionStatusNullableToJson(instance.status),
      'Name': ?instance.name,
      'Key': ?instance.key,
      'Id': ?instance.id,
      'ErrorMessage': ?instance.errorMessage,
      'LongErrorMessage': ?instance.longErrorMessage,
    };

TaskTriggerInfo _$TaskTriggerInfoFromJson(Map<String, dynamic> json) =>
    TaskTriggerInfo(
      type: taskTriggerInfoTypeNullableFromJson(json['Type']),
      timeOfDayTicks: (json['TimeOfDayTicks'] as num?)?.toInt(),
      intervalTicks: (json['IntervalTicks'] as num?)?.toInt(),
      dayOfWeek: dayOfWeekNullableFromJson(json['DayOfWeek']),
      maxRuntimeTicks: (json['MaxRuntimeTicks'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TaskTriggerInfoToJson(TaskTriggerInfo instance) =>
    <String, dynamic>{
      'Type': ?taskTriggerInfoTypeNullableToJson(instance.type),
      'TimeOfDayTicks': ?instance.timeOfDayTicks,
      'IntervalTicks': ?instance.intervalTicks,
      'DayOfWeek': ?dayOfWeekNullableToJson(instance.dayOfWeek),
      'MaxRuntimeTicks': ?instance.maxRuntimeTicks,
    };

ThemeMediaResult _$ThemeMediaResultFromJson(Map<String, dynamic> json) =>
    ThemeMediaResult(
      items:
          (json['Items'] as List<dynamic>?)
              ?.map((e) => BaseItemDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      totalRecordCount: (json['TotalRecordCount'] as num?)?.toInt(),
      startIndex: (json['StartIndex'] as num?)?.toInt(),
      ownerId: json['OwnerId'] as String?,
    );

Map<String, dynamic> _$ThemeMediaResultToJson(ThemeMediaResult instance) =>
    <String, dynamic>{
      'Items': ?instance.items?.map((e) => e.toJson()).toList(),
      'TotalRecordCount': ?instance.totalRecordCount,
      'StartIndex': ?instance.startIndex,
      'OwnerId': ?instance.ownerId,
    };

TimerCancelledMessage _$TimerCancelledMessageFromJson(
  Map<String, dynamic> json,
) => TimerCancelledMessage(
  data: json['Data'] == null
      ? null
      : TimerEventInfo.fromJson(json['Data'] as Map<String, dynamic>),
  messageId: json['MessageId'] as String?,
  messageType:
      TimerCancelledMessage.sessionMessageTypeMessageTypeNullableFromJson(
        json['MessageType'],
      ),
);

Map<String, dynamic> _$TimerCancelledMessageToJson(
  TimerCancelledMessage instance,
) => <String, dynamic>{
  'Data': ?instance.data?.toJson(),
  'MessageId': ?instance.messageId,
  'MessageType': ?sessionMessageTypeNullableToJson(instance.messageType),
};

TimerCreatedMessage _$TimerCreatedMessageFromJson(Map<String, dynamic> json) =>
    TimerCreatedMessage(
      data: json['Data'] == null
          ? null
          : TimerEventInfo.fromJson(json['Data'] as Map<String, dynamic>),
      messageId: json['MessageId'] as String?,
      messageType:
          TimerCreatedMessage.sessionMessageTypeMessageTypeNullableFromJson(
            json['MessageType'],
          ),
    );

Map<String, dynamic> _$TimerCreatedMessageToJson(
  TimerCreatedMessage instance,
) => <String, dynamic>{
  'Data': ?instance.data?.toJson(),
  'MessageId': ?instance.messageId,
  'MessageType': ?sessionMessageTypeNullableToJson(instance.messageType),
};

TimerEventInfo _$TimerEventInfoFromJson(Map<String, dynamic> json) =>
    TimerEventInfo(
      id: json['Id'] as String?,
      programId: json['ProgramId'] as String?,
    );

Map<String, dynamic> _$TimerEventInfoToJson(TimerEventInfo instance) =>
    <String, dynamic>{'Id': ?instance.id, 'ProgramId': ?instance.programId};

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

Map<String, dynamic> _$TimerInfoDtoToJson(TimerInfoDto instance) =>
    <String, dynamic>{
      'Id': ?instance.id,
      'Type': ?instance.type,
      'ServerId': ?instance.serverId,
      'ExternalId': ?instance.externalId,
      'ChannelId': ?instance.channelId,
      'ExternalChannelId': ?instance.externalChannelId,
      'ChannelName': ?instance.channelName,
      'ChannelPrimaryImageTag': ?instance.channelPrimaryImageTag,
      'ProgramId': ?instance.programId,
      'ExternalProgramId': ?instance.externalProgramId,
      'Name': ?instance.name,
      'Overview': ?instance.overview,
      'StartDate': ?instance.startDate?.toIso8601String(),
      'EndDate': ?instance.endDate?.toIso8601String(),
      'ServiceName': ?instance.serviceName,
      'Priority': ?instance.priority,
      'PrePaddingSeconds': ?instance.prePaddingSeconds,
      'PostPaddingSeconds': ?instance.postPaddingSeconds,
      'IsPrePaddingRequired': ?instance.isPrePaddingRequired,
      'ParentBackdropItemId': ?instance.parentBackdropItemId,
      'ParentBackdropImageTags': ?instance.parentBackdropImageTags,
      'IsPostPaddingRequired': ?instance.isPostPaddingRequired,
      'KeepUntil': ?keepUntilNullableToJson(instance.keepUntil),
      'Status': ?recordingStatusNullableToJson(instance.status),
      'SeriesTimerId': ?instance.seriesTimerId,
      'ExternalSeriesTimerId': ?instance.externalSeriesTimerId,
      'RunTimeTicks': ?instance.runTimeTicks,
      'ProgramInfo': ?instance.programInfo?.toJson(),
    };

TimerInfoDtoQueryResult _$TimerInfoDtoQueryResultFromJson(
  Map<String, dynamic> json,
) => TimerInfoDtoQueryResult(
  items:
      (json['Items'] as List<dynamic>?)
          ?.map((e) => TimerInfoDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  totalRecordCount: (json['TotalRecordCount'] as num?)?.toInt(),
  startIndex: (json['StartIndex'] as num?)?.toInt(),
);

Map<String, dynamic> _$TimerInfoDtoQueryResultToJson(
  TimerInfoDtoQueryResult instance,
) => <String, dynamic>{
  'Items': ?instance.items?.map((e) => e.toJson()).toList(),
  'TotalRecordCount': ?instance.totalRecordCount,
  'StartIndex': ?instance.startIndex,
};

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

Map<String, dynamic> _$TrailerInfoToJson(TrailerInfo instance) =>
    <String, dynamic>{
      'Name': ?instance.name,
      'OriginalTitle': ?instance.originalTitle,
      'Path': ?instance.path,
      'MetadataLanguage': ?instance.metadataLanguage,
      'MetadataCountryCode': ?instance.metadataCountryCode,
      'ProviderIds': ?instance.providerIds,
      'Year': ?instance.year,
      'IndexNumber': ?instance.indexNumber,
      'ParentIndexNumber': ?instance.parentIndexNumber,
      'PremiereDate': ?instance.premiereDate?.toIso8601String(),
      'IsAutomated': ?instance.isAutomated,
    };

TrailerInfoRemoteSearchQuery _$TrailerInfoRemoteSearchQueryFromJson(
  Map<String, dynamic> json,
) => TrailerInfoRemoteSearchQuery(
  searchInfo: json['SearchInfo'] == null
      ? null
      : TrailerInfo.fromJson(json['SearchInfo'] as Map<String, dynamic>),
  itemId: json['ItemId'] as String?,
  searchProviderName: json['SearchProviderName'] as String?,
  includeDisabledProviders: json['IncludeDisabledProviders'] as bool?,
);

Map<String, dynamic> _$TrailerInfoRemoteSearchQueryToJson(
  TrailerInfoRemoteSearchQuery instance,
) => <String, dynamic>{
  'SearchInfo': ?instance.searchInfo?.toJson(),
  'ItemId': ?instance.itemId,
  'SearchProviderName': ?instance.searchProviderName,
  'IncludeDisabledProviders': ?instance.includeDisabledProviders,
};

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
        json['HardwareAccelerationType'],
      ),
      transcodeReasons: transcodeReasonListFromJson(
        json['TranscodeReasons'] as List?,
      ),
    );

Map<String, dynamic> _$TranscodingInfoToJson(TranscodingInfo instance) =>
    <String, dynamic>{
      'AudioCodec': ?instance.audioCodec,
      'VideoCodec': ?instance.videoCodec,
      'Container': ?instance.container,
      'IsVideoDirect': ?instance.isVideoDirect,
      'IsAudioDirect': ?instance.isAudioDirect,
      'Bitrate': ?instance.bitrate,
      'Framerate': ?instance.framerate,
      'CompletionPercentage': ?instance.completionPercentage,
      'Width': ?instance.width,
      'Height': ?instance.height,
      'AudioChannels': ?instance.audioChannels,
      'HardwareAccelerationType': ?hardwareAccelerationTypeNullableToJson(
        instance.hardwareAccelerationType,
      ),
      'TranscodeReasons': transcodeReasonListToJson(instance.transcodeReasons),
    };

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
            json['TranscodeSeekInfo'],
          ),
      copyTimestamps: json['CopyTimestamps'] as bool? ?? false,
      context: TranscodingProfile.encodingContextContextNullableFromJson(
        json['Context'],
      ),
      enableSubtitlesInManifest:
          json['EnableSubtitlesInManifest'] as bool? ?? false,
      maxAudioChannels: json['MaxAudioChannels'] as String?,
      minSegments: (json['MinSegments'] as num?)?.toInt(),
      segmentLength: (json['SegmentLength'] as num?)?.toInt(),
      breakOnNonKeyFrames: json['BreakOnNonKeyFrames'] as bool? ?? false,
      conditions:
          (json['Conditions'] as List<dynamic>?)
              ?.map((e) => ProfileCondition.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      enableAudioVbrEncoding: json['EnableAudioVbrEncoding'] as bool? ?? true,
    );

Map<String, dynamic> _$TranscodingProfileToJson(TranscodingProfile instance) =>
    <String, dynamic>{
      'Container': ?instance.container,
      'Type': ?dlnaProfileTypeNullableToJson(instance.type),
      'VideoCodec': ?instance.videoCodec,
      'AudioCodec': ?instance.audioCodec,
      'Protocol': ?mediaStreamProtocolNullableToJson(instance.protocol),
      'EstimateContentLength': ?instance.estimateContentLength,
      'EnableMpegtsM2TsMode': ?instance.enableMpegtsM2TsMode,
      'TranscodeSeekInfo': ?transcodeSeekInfoNullableToJson(
        instance.transcodeSeekInfo,
      ),
      'CopyTimestamps': ?instance.copyTimestamps,
      'Context': ?encodingContextNullableToJson(instance.context),
      'EnableSubtitlesInManifest': ?instance.enableSubtitlesInManifest,
      'MaxAudioChannels': ?instance.maxAudioChannels,
      'MinSegments': ?instance.minSegments,
      'SegmentLength': ?instance.segmentLength,
      'BreakOnNonKeyFrames': ?instance.breakOnNonKeyFrames,
      'Conditions': ?instance.conditions?.map((e) => e.toJson()).toList(),
      'EnableAudioVbrEncoding': ?instance.enableAudioVbrEncoding,
    };

TrickplayInfoDto _$TrickplayInfoDtoFromJson(Map<String, dynamic> json) =>
    TrickplayInfoDto(
      width: (json['Width'] as num?)?.toInt(),
      height: (json['Height'] as num?)?.toInt(),
      tileWidth: (json['TileWidth'] as num?)?.toInt(),
      tileHeight: (json['TileHeight'] as num?)?.toInt(),
      thumbnailCount: (json['ThumbnailCount'] as num?)?.toInt(),
      interval: (json['Interval'] as num?)?.toInt(),
      bandwidth: (json['Bandwidth'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TrickplayInfoDtoToJson(TrickplayInfoDto instance) =>
    <String, dynamic>{
      'Width': ?instance.width,
      'Height': ?instance.height,
      'TileWidth': ?instance.tileWidth,
      'TileHeight': ?instance.tileHeight,
      'ThumbnailCount': ?instance.thumbnailCount,
      'Interval': ?instance.interval,
      'Bandwidth': ?instance.bandwidth,
    };

TrickplayOptions _$TrickplayOptionsFromJson(Map<String, dynamic> json) =>
    TrickplayOptions(
      enableHwAcceleration: json['EnableHwAcceleration'] as bool?,
      enableHwEncoding: json['EnableHwEncoding'] as bool?,
      enableKeyFrameOnlyExtraction:
          json['EnableKeyFrameOnlyExtraction'] as bool?,
      scanBehavior: trickplayScanBehaviorNullableFromJson(json['ScanBehavior']),
      processPriority: processPriorityClassNullableFromJson(
        json['ProcessPriority'],
      ),
      interval: (json['Interval'] as num?)?.toInt(),
      widthResolutions:
          (json['WidthResolutions'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          [],
      tileWidth: (json['TileWidth'] as num?)?.toInt(),
      tileHeight: (json['TileHeight'] as num?)?.toInt(),
      qscale: (json['Qscale'] as num?)?.toInt(),
      jpegQuality: (json['JpegQuality'] as num?)?.toInt(),
      processThreads: (json['ProcessThreads'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TrickplayOptionsToJson(
  TrickplayOptions instance,
) => <String, dynamic>{
  'EnableHwAcceleration': ?instance.enableHwAcceleration,
  'EnableHwEncoding': ?instance.enableHwEncoding,
  'EnableKeyFrameOnlyExtraction': ?instance.enableKeyFrameOnlyExtraction,
  'ScanBehavior': ?trickplayScanBehaviorNullableToJson(instance.scanBehavior),
  'ProcessPriority': ?processPriorityClassNullableToJson(
    instance.processPriority,
  ),
  'Interval': ?instance.interval,
  'WidthResolutions': ?instance.widthResolutions,
  'TileWidth': ?instance.tileWidth,
  'TileHeight': ?instance.tileHeight,
  'Qscale': ?instance.qscale,
  'JpegQuality': ?instance.jpegQuality,
  'ProcessThreads': ?instance.processThreads,
};

TunerChannelMapping _$TunerChannelMappingFromJson(Map<String, dynamic> json) =>
    TunerChannelMapping(
      name: json['Name'] as String?,
      providerChannelName: json['ProviderChannelName'] as String?,
      providerChannelId: json['ProviderChannelId'] as String?,
      id: json['Id'] as String?,
    );

Map<String, dynamic> _$TunerChannelMappingToJson(
  TunerChannelMapping instance,
) => <String, dynamic>{
  'Name': ?instance.name,
  'ProviderChannelName': ?instance.providerChannelName,
  'ProviderChannelId': ?instance.providerChannelId,
  'Id': ?instance.id,
};

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
      fallbackMaxStreamingBitrate: (json['FallbackMaxStreamingBitrate'] as num?)
          ?.toInt(),
      enableStreamLooping: json['EnableStreamLooping'] as bool?,
      source: json['Source'] as String?,
      tunerCount: (json['TunerCount'] as num?)?.toInt(),
      userAgent: json['UserAgent'] as String?,
      ignoreDts: json['IgnoreDts'] as bool?,
      readAtNativeFramerate: json['ReadAtNativeFramerate'] as bool?,
    );

Map<String, dynamic> _$TunerHostInfoToJson(TunerHostInfo instance) =>
    <String, dynamic>{
      'Id': ?instance.id,
      'Url': ?instance.url,
      'Type': ?instance.type,
      'DeviceId': ?instance.deviceId,
      'FriendlyName': ?instance.friendlyName,
      'ImportFavoritesOnly': ?instance.importFavoritesOnly,
      'AllowHWTranscoding': ?instance.allowHWTranscoding,
      'AllowFmp4TranscodingContainer': ?instance.allowFmp4TranscodingContainer,
      'AllowStreamSharing': ?instance.allowStreamSharing,
      'FallbackMaxStreamingBitrate': ?instance.fallbackMaxStreamingBitrate,
      'EnableStreamLooping': ?instance.enableStreamLooping,
      'Source': ?instance.source,
      'TunerCount': ?instance.tunerCount,
      'UserAgent': ?instance.userAgent,
      'IgnoreDts': ?instance.ignoreDts,
      'ReadAtNativeFramerate': ?instance.readAtNativeFramerate,
    };

TypeOptions _$TypeOptionsFromJson(Map<String, dynamic> json) => TypeOptions(
  type: json['Type'] as String?,
  metadataFetchers:
      (json['MetadataFetchers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  metadataFetcherOrder:
      (json['MetadataFetcherOrder'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  imageFetchers:
      (json['ImageFetchers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  imageFetcherOrder:
      (json['ImageFetcherOrder'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  imageOptions:
      (json['ImageOptions'] as List<dynamic>?)
          ?.map((e) => ImageOption.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$TypeOptionsToJson(TypeOptions instance) =>
    <String, dynamic>{
      'Type': ?instance.type,
      'MetadataFetchers': ?instance.metadataFetchers,
      'MetadataFetcherOrder': ?instance.metadataFetcherOrder,
      'ImageFetchers': ?instance.imageFetchers,
      'ImageFetcherOrder': ?instance.imageFetcherOrder,
      'ImageOptions': ?instance.imageOptions?.map((e) => e.toJson()).toList(),
    };

UpdateLibraryOptionsDto _$UpdateLibraryOptionsDtoFromJson(
  Map<String, dynamic> json,
) => UpdateLibraryOptionsDto(
  id: json['Id'] as String?,
  libraryOptions: json['LibraryOptions'] == null
      ? null
      : LibraryOptions.fromJson(json['LibraryOptions'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UpdateLibraryOptionsDtoToJson(
  UpdateLibraryOptionsDto instance,
) => <String, dynamic>{
  'Id': ?instance.id,
  'LibraryOptions': ?instance.libraryOptions?.toJson(),
};

UpdateMediaPathRequestDto _$UpdateMediaPathRequestDtoFromJson(
  Map<String, dynamic> json,
) => UpdateMediaPathRequestDto(
  name: json['Name'] as String,
  pathInfo: MediaPathInfo.fromJson(json['PathInfo'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UpdateMediaPathRequestDtoToJson(
  UpdateMediaPathRequestDto instance,
) => <String, dynamic>{
  'Name': instance.name,
  'PathInfo': instance.pathInfo.toJson(),
};

UpdatePlaylistDto _$UpdatePlaylistDtoFromJson(
  Map<String, dynamic> json,
) => UpdatePlaylistDto(
  name: json['Name'] as String?,
  ids: (json['Ids'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
  users:
      (json['Users'] as List<dynamic>?)
          ?.map(
            (e) => PlaylistUserPermissions.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      [],
  isPublic: json['IsPublic'] as bool?,
);

Map<String, dynamic> _$UpdatePlaylistDtoToJson(UpdatePlaylistDto instance) =>
    <String, dynamic>{
      'Name': ?instance.name,
      'Ids': ?instance.ids,
      'Users': ?instance.users?.map((e) => e.toJson()).toList(),
      'IsPublic': ?instance.isPublic,
    };

UpdatePlaylistUserDto _$UpdatePlaylistUserDtoFromJson(
  Map<String, dynamic> json,
) => UpdatePlaylistUserDto(canEdit: json['CanEdit'] as bool?);

Map<String, dynamic> _$UpdatePlaylistUserDtoToJson(
  UpdatePlaylistUserDto instance,
) => <String, dynamic>{'CanEdit': ?instance.canEdit};

UpdateUserItemDataDto _$UpdateUserItemDataDtoFromJson(
  Map<String, dynamic> json,
) => UpdateUserItemDataDto(
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
  UpdateUserItemDataDto instance,
) => <String, dynamic>{
  'Rating': ?instance.rating,
  'PlayedPercentage': ?instance.playedPercentage,
  'UnplayedItemCount': ?instance.unplayedItemCount,
  'PlaybackPositionTicks': ?instance.playbackPositionTicks,
  'PlayCount': ?instance.playCount,
  'IsFavorite': ?instance.isFavorite,
  'Likes': ?instance.likes,
  'LastPlayedDate': ?instance.lastPlayedDate?.toIso8601String(),
  'Played': ?instance.played,
  'Key': ?instance.key,
  'ItemId': ?instance.itemId,
};

UpdateUserPassword _$UpdateUserPasswordFromJson(Map<String, dynamic> json) =>
    UpdateUserPassword(
      currentPassword: json['CurrentPassword'] as String?,
      currentPw: json['CurrentPw'] as String?,
      newPw: json['NewPw'] as String?,
      resetPassword: json['ResetPassword'] as bool?,
    );

Map<String, dynamic> _$UpdateUserPasswordToJson(UpdateUserPassword instance) =>
    <String, dynamic>{
      'CurrentPassword': ?instance.currentPassword,
      'CurrentPw': ?instance.currentPw,
      'NewPw': ?instance.newPw,
      'ResetPassword': ?instance.resetPassword,
    };

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
      groupedFolders:
          (json['GroupedFolders'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      subtitleMode: subtitlePlaybackModeNullableFromJson(json['SubtitleMode']),
      displayCollectionsView: json['DisplayCollectionsView'] as bool?,
      enableLocalPassword: json['EnableLocalPassword'] as bool?,
      orderedViews:
          (json['OrderedViews'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      latestItemsExcludes:
          (json['LatestItemsExcludes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      myMediaExcludes:
          (json['MyMediaExcludes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      hidePlayedInLatest: json['HidePlayedInLatest'] as bool?,
      rememberAudioSelections: json['RememberAudioSelections'] as bool?,
      rememberSubtitleSelections: json['RememberSubtitleSelections'] as bool?,
      enableNextEpisodeAutoPlay: json['EnableNextEpisodeAutoPlay'] as bool?,
      castReceiverId: json['CastReceiverId'] as String?,
    );

Map<String, dynamic> _$UserConfigurationToJson(
  UserConfiguration instance,
) => <String, dynamic>{
  'AudioLanguagePreference': ?instance.audioLanguagePreference,
  'PlayDefaultAudioTrack': ?instance.playDefaultAudioTrack,
  'SubtitleLanguagePreference': ?instance.subtitleLanguagePreference,
  'DisplayMissingEpisodes': ?instance.displayMissingEpisodes,
  'GroupedFolders': ?instance.groupedFolders,
  'SubtitleMode': ?subtitlePlaybackModeNullableToJson(instance.subtitleMode),
  'DisplayCollectionsView': ?instance.displayCollectionsView,
  'EnableLocalPassword': ?instance.enableLocalPassword,
  'OrderedViews': ?instance.orderedViews,
  'LatestItemsExcludes': ?instance.latestItemsExcludes,
  'MyMediaExcludes': ?instance.myMediaExcludes,
  'HidePlayedInLatest': ?instance.hidePlayedInLatest,
  'RememberAudioSelections': ?instance.rememberAudioSelections,
  'RememberSubtitleSelections': ?instance.rememberSubtitleSelections,
  'EnableNextEpisodeAutoPlay': ?instance.enableNextEpisodeAutoPlay,
  'CastReceiverId': ?instance.castReceiverId,
};

UserDataChangedMessage _$UserDataChangedMessageFromJson(
  Map<String, dynamic> json,
) => UserDataChangedMessage(
  data: json['Data'] == null
      ? null
      : UserDataChangeInfo.fromJson(json['Data'] as Map<String, dynamic>),
  messageId: json['MessageId'] as String?,
  messageType:
      UserDataChangedMessage.sessionMessageTypeMessageTypeNullableFromJson(
        json['MessageType'],
      ),
);

Map<String, dynamic> _$UserDataChangedMessageToJson(
  UserDataChangedMessage instance,
) => <String, dynamic>{
  'Data': ?instance.data?.toJson(),
  'MessageId': ?instance.messageId,
  'MessageType': ?sessionMessageTypeNullableToJson(instance.messageType),
};

UserDataChangeInfo _$UserDataChangeInfoFromJson(Map<String, dynamic> json) =>
    UserDataChangeInfo(
      userId: json['UserId'] as String?,
      userDataList:
          (json['UserDataList'] as List<dynamic>?)
              ?.map((e) => UserItemDataDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$UserDataChangeInfoToJson(UserDataChangeInfo instance) =>
    <String, dynamic>{
      'UserId': ?instance.userId,
      'UserDataList': ?instance.userDataList?.map((e) => e.toJson()).toList(),
    };

UserDeletedMessage _$UserDeletedMessageFromJson(Map<String, dynamic> json) =>
    UserDeletedMessage(
      data: json['Data'] as String?,
      messageId: json['MessageId'] as String?,
      messageType:
          UserDeletedMessage.sessionMessageTypeMessageTypeNullableFromJson(
            json['MessageType'],
          ),
    );

Map<String, dynamic> _$UserDeletedMessageToJson(UserDeletedMessage instance) =>
    <String, dynamic>{
      'Data': ?instance.data,
      'MessageId': ?instance.messageId,
      'MessageType': ?sessionMessageTypeNullableToJson(instance.messageType),
    };

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
          json['Configuration'] as Map<String, dynamic>,
        ),
  policy: json['Policy'] == null
      ? null
      : UserPolicy.fromJson(json['Policy'] as Map<String, dynamic>),
  primaryImageAspectRatio: (json['PrimaryImageAspectRatio'] as num?)
      ?.toDouble(),
);

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
  'Name': ?instance.name,
  'ServerId': ?instance.serverId,
  'ServerName': ?instance.serverName,
  'Id': ?instance.id,
  'PrimaryImageTag': ?instance.primaryImageTag,
  'HasPassword': ?instance.hasPassword,
  'HasConfiguredPassword': ?instance.hasConfiguredPassword,
  'HasConfiguredEasyPassword': ?instance.hasConfiguredEasyPassword,
  'EnableAutoLogin': ?instance.enableAutoLogin,
  'LastLoginDate': ?instance.lastLoginDate?.toIso8601String(),
  'LastActivityDate': ?instance.lastActivityDate?.toIso8601String(),
  'Configuration': ?instance.configuration?.toJson(),
  'Policy': ?instance.policy?.toJson(),
  'PrimaryImageAspectRatio': ?instance.primaryImageAspectRatio,
};

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

Map<String, dynamic> _$UserItemDataDtoToJson(UserItemDataDto instance) =>
    <String, dynamic>{
      'Rating': ?instance.rating,
      'PlayedPercentage': ?instance.playedPercentage,
      'UnplayedItemCount': ?instance.unplayedItemCount,
      'PlaybackPositionTicks': ?instance.playbackPositionTicks,
      'PlayCount': ?instance.playCount,
      'IsFavorite': ?instance.isFavorite,
      'Likes': ?instance.likes,
      'LastPlayedDate': ?instance.lastPlayedDate?.toIso8601String(),
      'Played': ?instance.played,
      'Key': ?instance.key,
      'ItemId': ?instance.itemId,
    };

UserPolicy _$UserPolicyFromJson(Map<String, dynamic> json) => UserPolicy(
  isAdministrator: json['IsAdministrator'] as bool?,
  isHidden: json['IsHidden'] as bool?,
  enableCollectionManagement:
      json['EnableCollectionManagement'] as bool? ?? false,
  enableSubtitleManagement: json['EnableSubtitleManagement'] as bool? ?? false,
  enableLyricManagement: json['EnableLyricManagement'] as bool? ?? false,
  isDisabled: json['IsDisabled'] as bool?,
  maxParentalRating: (json['MaxParentalRating'] as num?)?.toInt(),
  maxParentalSubRating: (json['MaxParentalSubRating'] as num?)?.toInt(),
  blockedTags:
      (json['BlockedTags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  allowedTags:
      (json['AllowedTags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  enableUserPreferenceAccess: json['EnableUserPreferenceAccess'] as bool?,
  accessSchedules:
      (json['AccessSchedules'] as List<dynamic>?)
          ?.map((e) => AccessSchedule.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
  blockUnratedItems: unratedItemListFromJson(
    json['BlockUnratedItems'] as List?,
  ),
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
  forceRemoteSourceTranscoding: json['ForceRemoteSourceTranscoding'] as bool?,
  enableContentDeletion: json['EnableContentDeletion'] as bool?,
  enableContentDeletionFromFolders:
      (json['EnableContentDeletionFromFolders'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  enableContentDownloading: json['EnableContentDownloading'] as bool?,
  enableSyncTranscoding: json['EnableSyncTranscoding'] as bool?,
  enableMediaConversion: json['EnableMediaConversion'] as bool?,
  enabledDevices:
      (json['EnabledDevices'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  enableAllDevices: json['EnableAllDevices'] as bool?,
  enabledChannels:
      (json['EnabledChannels'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  enableAllChannels: json['EnableAllChannels'] as bool?,
  enabledFolders:
      (json['EnabledFolders'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  enableAllFolders: json['EnableAllFolders'] as bool?,
  invalidLoginAttemptCount: (json['InvalidLoginAttemptCount'] as num?)?.toInt(),
  loginAttemptsBeforeLockout: (json['LoginAttemptsBeforeLockout'] as num?)
      ?.toInt(),
  maxActiveSessions: (json['MaxActiveSessions'] as num?)?.toInt(),
  enablePublicSharing: json['EnablePublicSharing'] as bool?,
  blockedMediaFolders:
      (json['BlockedMediaFolders'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  blockedChannels:
      (json['BlockedChannels'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  remoteClientBitrateLimit: (json['RemoteClientBitrateLimit'] as num?)?.toInt(),
  authenticationProviderId: json['AuthenticationProviderId'] as String,
  passwordResetProviderId: json['PasswordResetProviderId'] as String,
  syncPlayAccess: syncPlayUserAccessTypeNullableFromJson(
    json['SyncPlayAccess'],
  ),
);

Map<String, dynamic> _$UserPolicyToJson(
  UserPolicy instance,
) => <String, dynamic>{
  'IsAdministrator': ?instance.isAdministrator,
  'IsHidden': ?instance.isHidden,
  'EnableCollectionManagement': ?instance.enableCollectionManagement,
  'EnableSubtitleManagement': ?instance.enableSubtitleManagement,
  'EnableLyricManagement': ?instance.enableLyricManagement,
  'IsDisabled': ?instance.isDisabled,
  'MaxParentalRating': ?instance.maxParentalRating,
  'MaxParentalSubRating': ?instance.maxParentalSubRating,
  'BlockedTags': ?instance.blockedTags,
  'AllowedTags': ?instance.allowedTags,
  'EnableUserPreferenceAccess': ?instance.enableUserPreferenceAccess,
  'AccessSchedules': ?instance.accessSchedules?.map((e) => e.toJson()).toList(),
  'BlockUnratedItems': unratedItemListToJson(instance.blockUnratedItems),
  'EnableRemoteControlOfOtherUsers': ?instance.enableRemoteControlOfOtherUsers,
  'EnableSharedDeviceControl': ?instance.enableSharedDeviceControl,
  'EnableRemoteAccess': ?instance.enableRemoteAccess,
  'EnableLiveTvManagement': ?instance.enableLiveTvManagement,
  'EnableLiveTvAccess': ?instance.enableLiveTvAccess,
  'EnableMediaPlayback': ?instance.enableMediaPlayback,
  'EnableAudioPlaybackTranscoding': ?instance.enableAudioPlaybackTranscoding,
  'EnableVideoPlaybackTranscoding': ?instance.enableVideoPlaybackTranscoding,
  'EnablePlaybackRemuxing': ?instance.enablePlaybackRemuxing,
  'ForceRemoteSourceTranscoding': ?instance.forceRemoteSourceTranscoding,
  'EnableContentDeletion': ?instance.enableContentDeletion,
  'EnableContentDeletionFromFolders':
      ?instance.enableContentDeletionFromFolders,
  'EnableContentDownloading': ?instance.enableContentDownloading,
  'EnableSyncTranscoding': ?instance.enableSyncTranscoding,
  'EnableMediaConversion': ?instance.enableMediaConversion,
  'EnabledDevices': ?instance.enabledDevices,
  'EnableAllDevices': ?instance.enableAllDevices,
  'EnabledChannels': ?instance.enabledChannels,
  'EnableAllChannels': ?instance.enableAllChannels,
  'EnabledFolders': ?instance.enabledFolders,
  'EnableAllFolders': ?instance.enableAllFolders,
  'InvalidLoginAttemptCount': ?instance.invalidLoginAttemptCount,
  'LoginAttemptsBeforeLockout': ?instance.loginAttemptsBeforeLockout,
  'MaxActiveSessions': ?instance.maxActiveSessions,
  'EnablePublicSharing': ?instance.enablePublicSharing,
  'BlockedMediaFolders': ?instance.blockedMediaFolders,
  'BlockedChannels': ?instance.blockedChannels,
  'RemoteClientBitrateLimit': ?instance.remoteClientBitrateLimit,
  'AuthenticationProviderId': instance.authenticationProviderId,
  'PasswordResetProviderId': instance.passwordResetProviderId,
  'SyncPlayAccess': ?syncPlayUserAccessTypeNullableToJson(
    instance.syncPlayAccess,
  ),
};

UserUpdatedMessage _$UserUpdatedMessageFromJson(Map<String, dynamic> json) =>
    UserUpdatedMessage(
      data: json['Data'] == null
          ? null
          : UserDto.fromJson(json['Data'] as Map<String, dynamic>),
      messageId: json['MessageId'] as String?,
      messageType:
          UserUpdatedMessage.sessionMessageTypeMessageTypeNullableFromJson(
            json['MessageType'],
          ),
    );

Map<String, dynamic> _$UserUpdatedMessageToJson(UserUpdatedMessage instance) =>
    <String, dynamic>{
      'Data': ?instance.data?.toJson(),
      'MessageId': ?instance.messageId,
      'MessageType': ?sessionMessageTypeNullableToJson(instance.messageType),
    };

UtcTimeResponse _$UtcTimeResponseFromJson(Map<String, dynamic> json) =>
    UtcTimeResponse(
      requestReceptionTime: json['RequestReceptionTime'] == null
          ? null
          : DateTime.parse(json['RequestReceptionTime'] as String),
      responseTransmissionTime: json['ResponseTransmissionTime'] == null
          ? null
          : DateTime.parse(json['ResponseTransmissionTime'] as String),
    );

Map<String, dynamic> _$UtcTimeResponseToJson(UtcTimeResponse instance) =>
    <String, dynamic>{
      'RequestReceptionTime': ?instance.requestReceptionTime?.toIso8601String(),
      'ResponseTransmissionTime': ?instance.responseTransmissionTime
          ?.toIso8601String(),
    };

ValidatePathDto _$ValidatePathDtoFromJson(Map<String, dynamic> json) =>
    ValidatePathDto(
      validateWritable: json['ValidateWritable'] as bool?,
      path: json['Path'] as String?,
      isFile: json['IsFile'] as bool?,
    );

Map<String, dynamic> _$ValidatePathDtoToJson(ValidatePathDto instance) =>
    <String, dynamic>{
      'ValidateWritable': ?instance.validateWritable,
      'Path': ?instance.path,
      'IsFile': ?instance.isFile,
    };

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

Map<String, dynamic> _$VersionInfoToJson(VersionInfo instance) =>
    <String, dynamic>{
      'version': ?instance.version,
      'VersionNumber': ?instance.versionNumber,
      'changelog': ?instance.changelog,
      'targetAbi': ?instance.targetAbi,
      'sourceUrl': ?instance.sourceUrl,
      'checksum': ?instance.checksum,
      'timestamp': ?instance.timestamp,
      'repositoryName': ?instance.repositoryName,
      'repositoryUrl': ?instance.repositoryUrl,
    };

VirtualFolderInfo _$VirtualFolderInfoFromJson(
  Map<String, dynamic> json,
) => VirtualFolderInfo(
  name: json['Name'] as String?,
  locations:
      (json['Locations'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      [],
  collectionType: collectionTypeOptionsNullableFromJson(json['CollectionType']),
  libraryOptions: json['LibraryOptions'] == null
      ? null
      : LibraryOptions.fromJson(json['LibraryOptions'] as Map<String, dynamic>),
  itemId: json['ItemId'] as String?,
  primaryImageItemId: json['PrimaryImageItemId'] as String?,
  refreshProgress: (json['RefreshProgress'] as num?)?.toDouble(),
  refreshStatus: json['RefreshStatus'] as String?,
);

Map<String, dynamic> _$VirtualFolderInfoToJson(VirtualFolderInfo instance) =>
    <String, dynamic>{
      'Name': ?instance.name,
      'Locations': ?instance.locations,
      'CollectionType': ?collectionTypeOptionsNullableToJson(
        instance.collectionType,
      ),
      'LibraryOptions': ?instance.libraryOptions?.toJson(),
      'ItemId': ?instance.itemId,
      'PrimaryImageItemId': ?instance.primaryImageItemId,
      'RefreshProgress': ?instance.refreshProgress,
      'RefreshStatus': ?instance.refreshStatus,
    };

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

Map<String, dynamic> _$XbmcMetadataOptionsToJson(
  XbmcMetadataOptions instance,
) => <String, dynamic>{
  'UserId': ?instance.userId,
  'ReleaseDateFormat': ?instance.releaseDateFormat,
  'SaveImagePathsInNfo': ?instance.saveImagePathsInNfo,
  'EnablePathSubstitution': ?instance.enablePathSubstitution,
  'EnableExtraThumbsDuplication': ?instance.enableExtraThumbsDuplication,
};

BaseItemDto$ImageBlurHashes _$BaseItemDto$ImageBlurHashesFromJson(
  Map<String, dynamic> json,
) => BaseItemDto$ImageBlurHashes(
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
  BaseItemDto$ImageBlurHashes instance,
) => <String, dynamic>{
  'Primary': ?instance.primary,
  'Art': ?instance.art,
  'Backdrop': ?instance.backdrop,
  'Banner': ?instance.banner,
  'Logo': ?instance.logo,
  'Thumb': ?instance.thumb,
  'Disc': ?instance.disc,
  'Box': ?instance.box,
  'Screenshot': ?instance.screenshot,
  'Menu': ?instance.menu,
  'Chapter': ?instance.chapter,
  'BoxRear': ?instance.boxRear,
  'Profile': ?instance.profile,
};

BaseItemPerson$ImageBlurHashes _$BaseItemPerson$ImageBlurHashesFromJson(
  Map<String, dynamic> json,
) => BaseItemPerson$ImageBlurHashes(
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
  BaseItemPerson$ImageBlurHashes instance,
) => <String, dynamic>{
  'Primary': ?instance.primary,
  'Art': ?instance.art,
  'Backdrop': ?instance.backdrop,
  'Banner': ?instance.banner,
  'Logo': ?instance.logo,
  'Thumb': ?instance.thumb,
  'Disc': ?instance.disc,
  'Box': ?instance.box,
  'Screenshot': ?instance.screenshot,
  'Menu': ?instance.menu,
  'Chapter': ?instance.chapter,
  'BoxRear': ?instance.boxRear,
  'Profile': ?instance.profile,
};
