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
      if (instance.id case final value?) 'Id': value,
      if (instance.userId case final value?) 'UserId': value,
      if (dynamicDayOfWeekNullableToJson(instance.dayOfWeek) case final value?)
        'DayOfWeek': value,
      if (instance.startHour case final value?) 'StartHour': value,
      if (instance.endHour case final value?) 'EndHour': value,
    };

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

Map<String, dynamic> _$ActivityLogEntryToJson(ActivityLogEntry instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'Id': value,
      if (instance.name case final value?) 'Name': value,
      if (instance.overview case final value?) 'Overview': value,
      if (instance.shortOverview case final value?) 'ShortOverview': value,
      if (instance.type case final value?) 'Type': value,
      if (instance.itemId case final value?) 'ItemId': value,
      if (instance.date?.toIso8601String() case final value?) 'Date': value,
      if (instance.userId case final value?) 'UserId': value,
      if (instance.userPrimaryImageTag case final value?)
        'UserPrimaryImageTag': value,
      if (logLevelNullableToJson(instance.severity) case final value?)
        'Severity': value,
    };

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
        ActivityLogEntryMessage instance) =>
    <String, dynamic>{
      if (instance.data?.map((e) => e.toJson()).toList() case final value?)
        'Data': value,
      if (instance.messageId case final value?) 'MessageId': value,
      if (sessionMessageTypeNullableToJson(instance.messageType)
          case final value?)
        'MessageType': value,
    };

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
        ActivityLogEntryQueryResult instance) =>
    <String, dynamic>{
      if (instance.items?.map((e) => e.toJson()).toList() case final value?)
        'Items': value,
      if (instance.totalRecordCount case final value?)
        'TotalRecordCount': value,
      if (instance.startIndex case final value?) 'StartIndex': value,
    };

ActivityLogEntryStartMessage _$ActivityLogEntryStartMessageFromJson(
        Map<String, dynamic> json) =>
    ActivityLogEntryStartMessage(
      data: json['Data'] as String?,
      messageType: ActivityLogEntryStartMessage
          .sessionMessageTypeMessageTypeNullableFromJson(json['MessageType']),
    );

Map<String, dynamic> _$ActivityLogEntryStartMessageToJson(
        ActivityLogEntryStartMessage instance) =>
    <String, dynamic>{
      if (instance.data case final value?) 'Data': value,
      if (sessionMessageTypeNullableToJson(instance.messageType)
          case final value?)
        'MessageType': value,
    };

ActivityLogEntryStopMessage _$ActivityLogEntryStopMessageFromJson(
        Map<String, dynamic> json) =>
    ActivityLogEntryStopMessage(
      messageType: ActivityLogEntryStopMessage
          .sessionMessageTypeMessageTypeNullableFromJson(json['MessageType']),
    );

Map<String, dynamic> _$ActivityLogEntryStopMessageToJson(
        ActivityLogEntryStopMessage instance) =>
    <String, dynamic>{
      if (sessionMessageTypeNullableToJson(instance.messageType)
          case final value?)
        'MessageType': value,
    };

AddVirtualFolderDto _$AddVirtualFolderDtoFromJson(Map<String, dynamic> json) =>
    AddVirtualFolderDto(
      libraryOptions: json['LibraryOptions'] == null
          ? null
          : LibraryOptions.fromJson(
              json['LibraryOptions'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddVirtualFolderDtoToJson(
        AddVirtualFolderDto instance) =>
    <String, dynamic>{
      if (instance.libraryOptions?.toJson() case final value?)
        'LibraryOptions': value,
    };

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

Map<String, dynamic> _$AlbumInfoToJson(AlbumInfo instance) => <String, dynamic>{
      if (instance.name case final value?) 'Name': value,
      if (instance.originalTitle case final value?) 'OriginalTitle': value,
      if (instance.path case final value?) 'Path': value,
      if (instance.metadataLanguage case final value?)
        'MetadataLanguage': value,
      if (instance.metadataCountryCode case final value?)
        'MetadataCountryCode': value,
      if (instance.providerIds case final value?) 'ProviderIds': value,
      if (instance.year case final value?) 'Year': value,
      if (instance.indexNumber case final value?) 'IndexNumber': value,
      if (instance.parentIndexNumber case final value?)
        'ParentIndexNumber': value,
      if (instance.premiereDate?.toIso8601String() case final value?)
        'PremiereDate': value,
      if (instance.isAutomated case final value?) 'IsAutomated': value,
      if (instance.albumArtists case final value?) 'AlbumArtists': value,
      if (instance.artistProviderIds case final value?)
        'ArtistProviderIds': value,
      if (instance.songInfos?.map((e) => e.toJson()).toList() case final value?)
        'SongInfos': value,
    };

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
        AlbumInfoRemoteSearchQuery instance) =>
    <String, dynamic>{
      if (instance.searchInfo?.toJson() case final value?) 'SearchInfo': value,
      if (instance.itemId case final value?) 'ItemId': value,
      if (instance.searchProviderName case final value?)
        'SearchProviderName': value,
      if (instance.includeDisabledProviders case final value?)
        'IncludeDisabledProviders': value,
    };

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

Map<String, dynamic> _$AllThemeMediaResultToJson(
        AllThemeMediaResult instance) =>
    <String, dynamic>{
      if (instance.themeVideosResult?.toJson() case final value?)
        'ThemeVideosResult': value,
      if (instance.themeSongsResult?.toJson() case final value?)
        'ThemeSongsResult': value,
      if (instance.soundtrackSongsResult?.toJson() case final value?)
        'SoundtrackSongsResult': value,
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
      songInfos: (json['SongInfos'] as List<dynamic>?)
              ?.map((e) => SongInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$ArtistInfoToJson(ArtistInfo instance) =>
    <String, dynamic>{
      if (instance.name case final value?) 'Name': value,
      if (instance.originalTitle case final value?) 'OriginalTitle': value,
      if (instance.path case final value?) 'Path': value,
      if (instance.metadataLanguage case final value?)
        'MetadataLanguage': value,
      if (instance.metadataCountryCode case final value?)
        'MetadataCountryCode': value,
      if (instance.providerIds case final value?) 'ProviderIds': value,
      if (instance.year case final value?) 'Year': value,
      if (instance.indexNumber case final value?) 'IndexNumber': value,
      if (instance.parentIndexNumber case final value?)
        'ParentIndexNumber': value,
      if (instance.premiereDate?.toIso8601String() case final value?)
        'PremiereDate': value,
      if (instance.isAutomated case final value?) 'IsAutomated': value,
      if (instance.songInfos?.map((e) => e.toJson()).toList() case final value?)
        'SongInfos': value,
    };

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
        ArtistInfoRemoteSearchQuery instance) =>
    <String, dynamic>{
      if (instance.searchInfo?.toJson() case final value?) 'SearchInfo': value,
      if (instance.itemId case final value?) 'ItemId': value,
      if (instance.searchProviderName case final value?)
        'SearchProviderName': value,
      if (instance.includeDisabledProviders case final value?)
        'IncludeDisabledProviders': value,
    };

AuthenticateUserByName _$AuthenticateUserByNameFromJson(
        Map<String, dynamic> json) =>
    AuthenticateUserByName(
      username: json['Username'] as String?,
      pw: json['Pw'] as String?,
    );

Map<String, dynamic> _$AuthenticateUserByNameToJson(
        AuthenticateUserByName instance) =>
    <String, dynamic>{
      if (instance.username case final value?) 'Username': value,
      if (instance.pw case final value?) 'Pw': value,
    };

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
      if (instance.id case final value?) 'Id': value,
      if (instance.accessToken case final value?) 'AccessToken': value,
      if (instance.deviceId case final value?) 'DeviceId': value,
      if (instance.appName case final value?) 'AppName': value,
      if (instance.appVersion case final value?) 'AppVersion': value,
      if (instance.deviceName case final value?) 'DeviceName': value,
      if (instance.userId case final value?) 'UserId': value,
      if (instance.isActive case final value?) 'IsActive': value,
      if (instance.dateCreated?.toIso8601String() case final value?)
        'DateCreated': value,
      if (instance.dateRevoked?.toIso8601String() case final value?)
        'DateRevoked': value,
      if (instance.dateLastActivity?.toIso8601String() case final value?)
        'DateLastActivity': value,
      if (instance.userName case final value?) 'UserName': value,
    };

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
        AuthenticationInfoQueryResult instance) =>
    <String, dynamic>{
      if (instance.items?.map((e) => e.toJson()).toList() case final value?)
        'Items': value,
      if (instance.totalRecordCount case final value?)
        'TotalRecordCount': value,
      if (instance.startIndex case final value?) 'StartIndex': value,
    };

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
        AuthenticationResult instance) =>
    <String, dynamic>{
      if (instance.user?.toJson() case final value?) 'User': value,
      if (instance.sessionInfo?.toJson() case final value?)
        'SessionInfo': value,
      if (instance.accessToken case final value?) 'AccessToken': value,
      if (instance.serverId case final value?) 'ServerId': value,
    };

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

Map<String, dynamic> _$BaseItemDtoToJson(BaseItemDto instance) =>
    <String, dynamic>{
      if (instance.name case final value?) 'Name': value,
      if (instance.originalTitle case final value?) 'OriginalTitle': value,
      if (instance.serverId case final value?) 'ServerId': value,
      if (instance.id case final value?) 'Id': value,
      if (instance.etag case final value?) 'Etag': value,
      if (instance.sourceType case final value?) 'SourceType': value,
      if (instance.playlistItemId case final value?) 'PlaylistItemId': value,
      if (instance.dateCreated?.toIso8601String() case final value?)
        'DateCreated': value,
      if (instance.dateLastMediaAdded?.toIso8601String() case final value?)
        'DateLastMediaAdded': value,
      if (extraTypeNullableToJson(instance.extraType) case final value?)
        'ExtraType': value,
      if (instance.airsBeforeSeasonNumber case final value?)
        'AirsBeforeSeasonNumber': value,
      if (instance.airsAfterSeasonNumber case final value?)
        'AirsAfterSeasonNumber': value,
      if (instance.airsBeforeEpisodeNumber case final value?)
        'AirsBeforeEpisodeNumber': value,
      if (instance.canDelete case final value?) 'CanDelete': value,
      if (instance.canDownload case final value?) 'CanDownload': value,
      if (instance.hasLyrics case final value?) 'HasLyrics': value,
      if (instance.hasSubtitles case final value?) 'HasSubtitles': value,
      if (instance.preferredMetadataLanguage case final value?)
        'PreferredMetadataLanguage': value,
      if (instance.preferredMetadataCountryCode case final value?)
        'PreferredMetadataCountryCode': value,
      if (instance.container case final value?) 'Container': value,
      if (instance.sortName case final value?) 'SortName': value,
      if (instance.forcedSortName case final value?) 'ForcedSortName': value,
      if (video3DFormatNullableToJson(instance.video3DFormat) case final value?)
        'Video3DFormat': value,
      if (instance.premiereDate?.toIso8601String() case final value?)
        'PremiereDate': value,
      if (instance.externalUrls?.map((e) => e.toJson()).toList()
          case final value?)
        'ExternalUrls': value,
      if (instance.mediaSources?.map((e) => e.toJson()).toList()
          case final value?)
        'MediaSources': value,
      if (instance.criticRating case final value?) 'CriticRating': value,
      if (instance.productionLocations case final value?)
        'ProductionLocations': value,
      if (instance.path case final value?) 'Path': value,
      if (instance.enableMediaSourceDisplay case final value?)
        'EnableMediaSourceDisplay': value,
      if (instance.officialRating case final value?) 'OfficialRating': value,
      if (instance.customRating case final value?) 'CustomRating': value,
      if (instance.channelId case final value?) 'ChannelId': value,
      if (instance.channelName case final value?) 'ChannelName': value,
      if (instance.overview case final value?) 'Overview': value,
      if (instance.taglines case final value?) 'Taglines': value,
      if (instance.genres case final value?) 'Genres': value,
      if (instance.communityRating case final value?) 'CommunityRating': value,
      if (instance.cumulativeRunTimeTicks case final value?)
        'CumulativeRunTimeTicks': value,
      if (instance.runTimeTicks case final value?) 'RunTimeTicks': value,
      if (playAccessNullableToJson(instance.playAccess) case final value?)
        'PlayAccess': value,
      if (instance.aspectRatio case final value?) 'AspectRatio': value,
      if (instance.productionYear case final value?) 'ProductionYear': value,
      if (instance.isPlaceHolder case final value?) 'IsPlaceHolder': value,
      if (instance.number case final value?) 'Number': value,
      if (instance.channelNumber case final value?) 'ChannelNumber': value,
      if (instance.indexNumber case final value?) 'IndexNumber': value,
      if (instance.indexNumberEnd case final value?) 'IndexNumberEnd': value,
      if (instance.parentIndexNumber case final value?)
        'ParentIndexNumber': value,
      if (instance.remoteTrailers?.map((e) => e.toJson()).toList()
          case final value?)
        'RemoteTrailers': value,
      if (instance.providerIds case final value?) 'ProviderIds': value,
      if (instance.isHD case final value?) 'IsHD': value,
      if (instance.isFolder case final value?) 'IsFolder': value,
      if (instance.parentId case final value?) 'ParentId': value,
      if (baseItemKindNullableToJson(instance.type) case final value?)
        'Type': value,
      if (instance.people?.map((e) => e.toJson()).toList() case final value?)
        'People': value,
      if (instance.studios?.map((e) => e.toJson()).toList() case final value?)
        'Studios': value,
      if (instance.genreItems?.map((e) => e.toJson()).toList()
          case final value?)
        'GenreItems': value,
      if (instance.parentLogoItemId case final value?)
        'ParentLogoItemId': value,
      if (instance.parentBackdropItemId case final value?)
        'ParentBackdropItemId': value,
      if (instance.parentBackdropImageTags case final value?)
        'ParentBackdropImageTags': value,
      if (instance.localTrailerCount case final value?)
        'LocalTrailerCount': value,
      if (instance.userData?.toJson() case final value?) 'UserData': value,
      if (instance.recursiveItemCount case final value?)
        'RecursiveItemCount': value,
      if (instance.childCount case final value?) 'ChildCount': value,
      if (instance.seriesName case final value?) 'SeriesName': value,
      if (instance.seriesId case final value?) 'SeriesId': value,
      if (instance.seasonId case final value?) 'SeasonId': value,
      if (instance.specialFeatureCount case final value?)
        'SpecialFeatureCount': value,
      if (instance.displayPreferencesId case final value?)
        'DisplayPreferencesId': value,
      if (instance.status case final value?) 'Status': value,
      if (instance.airTime case final value?) 'AirTime': value,
      'AirDays': dayOfWeekListToJson(instance.airDays),
      if (instance.tags case final value?) 'Tags': value,
      if (instance.primaryImageAspectRatio case final value?)
        'PrimaryImageAspectRatio': value,
      if (instance.artists case final value?) 'Artists': value,
      if (instance.artistItems?.map((e) => e.toJson()).toList()
          case final value?)
        'ArtistItems': value,
      if (instance.album case final value?) 'Album': value,
      if (collectionTypeNullableToJson(instance.collectionType)
          case final value?)
        'CollectionType': value,
      if (instance.displayOrder case final value?) 'DisplayOrder': value,
      if (instance.albumId case final value?) 'AlbumId': value,
      if (instance.albumPrimaryImageTag case final value?)
        'AlbumPrimaryImageTag': value,
      if (instance.seriesPrimaryImageTag case final value?)
        'SeriesPrimaryImageTag': value,
      if (instance.albumArtist case final value?) 'AlbumArtist': value,
      if (instance.albumArtists?.map((e) => e.toJson()).toList()
          case final value?)
        'AlbumArtists': value,
      if (instance.seasonName case final value?) 'SeasonName': value,
      if (instance.mediaStreams?.map((e) => e.toJson()).toList()
          case final value?)
        'MediaStreams': value,
      if (videoTypeNullableToJson(instance.videoType) case final value?)
        'VideoType': value,
      if (instance.partCount case final value?) 'PartCount': value,
      if (instance.mediaSourceCount case final value?)
        'MediaSourceCount': value,
      if (instance.imageTags case final value?) 'ImageTags': value,
      if (instance.backdropImageTags case final value?)
        'BackdropImageTags': value,
      if (instance.screenshotImageTags case final value?)
        'ScreenshotImageTags': value,
      if (instance.parentLogoImageTag case final value?)
        'ParentLogoImageTag': value,
      if (instance.parentArtItemId case final value?) 'ParentArtItemId': value,
      if (instance.parentArtImageTag case final value?)
        'ParentArtImageTag': value,
      if (instance.seriesThumbImageTag case final value?)
        'SeriesThumbImageTag': value,
      if (instance.imageBlurHashes?.toJson() case final value?)
        'ImageBlurHashes': value,
      if (instance.seriesStudio case final value?) 'SeriesStudio': value,
      if (instance.parentThumbItemId case final value?)
        'ParentThumbItemId': value,
      if (instance.parentThumbImageTag case final value?)
        'ParentThumbImageTag': value,
      if (instance.parentPrimaryImageItemId case final value?)
        'ParentPrimaryImageItemId': value,
      if (instance.parentPrimaryImageTag case final value?)
        'ParentPrimaryImageTag': value,
      if (instance.chapters?.map((e) => e.toJson()).toList() case final value?)
        'Chapters': value,
      if (instance.trickplay case final value?) 'Trickplay': value,
      if (locationTypeNullableToJson(instance.locationType) case final value?)
        'LocationType': value,
      if (isoTypeNullableToJson(instance.isoType) case final value?)
        'IsoType': value,
      if (mediaTypeNullableToJson(instance.mediaType) case final value?)
        'MediaType': value,
      if (instance.endDate?.toIso8601String() case final value?)
        'EndDate': value,
      'LockedFields': metadataFieldListToJson(instance.lockedFields),
      if (instance.trailerCount case final value?) 'TrailerCount': value,
      if (instance.movieCount case final value?) 'MovieCount': value,
      if (instance.seriesCount case final value?) 'SeriesCount': value,
      if (instance.programCount case final value?) 'ProgramCount': value,
      if (instance.episodeCount case final value?) 'EpisodeCount': value,
      if (instance.songCount case final value?) 'SongCount': value,
      if (instance.albumCount case final value?) 'AlbumCount': value,
      if (instance.artistCount case final value?) 'ArtistCount': value,
      if (instance.musicVideoCount case final value?) 'MusicVideoCount': value,
      if (instance.lockData case final value?) 'LockData': value,
      if (instance.width case final value?) 'Width': value,
      if (instance.height case final value?) 'Height': value,
      if (instance.cameraMake case final value?) 'CameraMake': value,
      if (instance.cameraModel case final value?) 'CameraModel': value,
      if (instance.software case final value?) 'Software': value,
      if (instance.exposureTime case final value?) 'ExposureTime': value,
      if (instance.focalLength case final value?) 'FocalLength': value,
      if (imageOrientationNullableToJson(instance.imageOrientation)
          case final value?)
        'ImageOrientation': value,
      if (instance.aperture case final value?) 'Aperture': value,
      if (instance.shutterSpeed case final value?) 'ShutterSpeed': value,
      if (instance.latitude case final value?) 'Latitude': value,
      if (instance.longitude case final value?) 'Longitude': value,
      if (instance.altitude case final value?) 'Altitude': value,
      if (instance.isoSpeedRating case final value?) 'IsoSpeedRating': value,
      if (instance.seriesTimerId case final value?) 'SeriesTimerId': value,
      if (instance.programId case final value?) 'ProgramId': value,
      if (instance.channelPrimaryImageTag case final value?)
        'ChannelPrimaryImageTag': value,
      if (instance.startDate?.toIso8601String() case final value?)
        'StartDate': value,
      if (instance.completionPercentage case final value?)
        'CompletionPercentage': value,
      if (instance.isRepeat case final value?) 'IsRepeat': value,
      if (instance.episodeTitle case final value?) 'EpisodeTitle': value,
      if (channelTypeNullableToJson(instance.channelType) case final value?)
        'ChannelType': value,
      if (programAudioNullableToJson(instance.audio) case final value?)
        'Audio': value,
      if (instance.isMovie case final value?) 'IsMovie': value,
      if (instance.isSports case final value?) 'IsSports': value,
      if (instance.isSeries case final value?) 'IsSeries': value,
      if (instance.isLive case final value?) 'IsLive': value,
      if (instance.isNews case final value?) 'IsNews': value,
      if (instance.isKids case final value?) 'IsKids': value,
      if (instance.isPremiere case final value?) 'IsPremiere': value,
      if (instance.timerId case final value?) 'TimerId': value,
      if (instance.normalizationGain case final value?)
        'NormalizationGain': value,
      if (instance.currentProgram?.toJson() case final value?)
        'CurrentProgram': value,
    };

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
        BaseItemDtoQueryResult instance) =>
    <String, dynamic>{
      if (instance.items?.map((e) => e.toJson()).toList() case final value?)
        'Items': value,
      if (instance.totalRecordCount case final value?)
        'TotalRecordCount': value,
      if (instance.startIndex case final value?) 'StartIndex': value,
    };

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

Map<String, dynamic> _$BaseItemPersonToJson(BaseItemPerson instance) =>
    <String, dynamic>{
      if (instance.name case final value?) 'Name': value,
      if (instance.id case final value?) 'Id': value,
      if (instance.role case final value?) 'Role': value,
      if (personKindNullableToJson(instance.type) case final value?)
        'Type': value,
      if (instance.primaryImageTag case final value?) 'PrimaryImageTag': value,
      if (instance.imageBlurHashes?.toJson() case final value?)
        'ImageBlurHashes': value,
    };

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

Map<String, dynamic> _$BookInfoToJson(BookInfo instance) => <String, dynamic>{
      if (instance.name case final value?) 'Name': value,
      if (instance.originalTitle case final value?) 'OriginalTitle': value,
      if (instance.path case final value?) 'Path': value,
      if (instance.metadataLanguage case final value?)
        'MetadataLanguage': value,
      if (instance.metadataCountryCode case final value?)
        'MetadataCountryCode': value,
      if (instance.providerIds case final value?) 'ProviderIds': value,
      if (instance.year case final value?) 'Year': value,
      if (instance.indexNumber case final value?) 'IndexNumber': value,
      if (instance.parentIndexNumber case final value?)
        'ParentIndexNumber': value,
      if (instance.premiereDate?.toIso8601String() case final value?)
        'PremiereDate': value,
      if (instance.isAutomated case final value?) 'IsAutomated': value,
      if (instance.seriesName case final value?) 'SeriesName': value,
    };

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
        BookInfoRemoteSearchQuery instance) =>
    <String, dynamic>{
      if (instance.searchInfo?.toJson() case final value?) 'SearchInfo': value,
      if (instance.itemId case final value?) 'ItemId': value,
      if (instance.searchProviderName case final value?)
        'SearchProviderName': value,
      if (instance.includeDisabledProviders case final value?)
        'IncludeDisabledProviders': value,
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
      if (instance.name case final value?) 'Name': value,
      if (instance.originalTitle case final value?) 'OriginalTitle': value,
      if (instance.path case final value?) 'Path': value,
      if (instance.metadataLanguage case final value?)
        'MetadataLanguage': value,
      if (instance.metadataCountryCode case final value?)
        'MetadataCountryCode': value,
      if (instance.providerIds case final value?) 'ProviderIds': value,
      if (instance.year case final value?) 'Year': value,
      if (instance.indexNumber case final value?) 'IndexNumber': value,
      if (instance.parentIndexNumber case final value?)
        'ParentIndexNumber': value,
      if (instance.premiereDate?.toIso8601String() case final value?)
        'PremiereDate': value,
      if (instance.isAutomated case final value?) 'IsAutomated': value,
    };

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
        BoxSetInfoRemoteSearchQuery instance) =>
    <String, dynamic>{
      if (instance.searchInfo?.toJson() case final value?) 'SearchInfo': value,
      if (instance.itemId case final value?) 'ItemId': value,
      if (instance.searchProviderName case final value?)
        'SearchProviderName': value,
      if (instance.includeDisabledProviders case final value?)
        'IncludeDisabledProviders': value,
    };

BrandingOptions _$BrandingOptionsFromJson(Map<String, dynamic> json) =>
    BrandingOptions(
      loginDisclaimer: json['LoginDisclaimer'] as String?,
      customCss: json['CustomCss'] as String?,
      splashscreenEnabled: json['SplashscreenEnabled'] as bool?,
    );

Map<String, dynamic> _$BrandingOptionsToJson(BrandingOptions instance) =>
    <String, dynamic>{
      if (instance.loginDisclaimer case final value?) 'LoginDisclaimer': value,
      if (instance.customCss case final value?) 'CustomCss': value,
      if (instance.splashscreenEnabled case final value?)
        'SplashscreenEnabled': value,
    };

BufferRequestDto _$BufferRequestDtoFromJson(Map<String, dynamic> json) =>
    BufferRequestDto(
      when:
          json['When'] == null ? null : DateTime.parse(json['When'] as String),
      positionTicks: (json['PositionTicks'] as num?)?.toInt(),
      isPlaying: json['IsPlaying'] as bool?,
      playlistItemId: json['PlaylistItemId'] as String?,
    );

Map<String, dynamic> _$BufferRequestDtoToJson(BufferRequestDto instance) =>
    <String, dynamic>{
      if (instance.when?.toIso8601String() case final value?) 'When': value,
      if (instance.positionTicks case final value?) 'PositionTicks': value,
      if (instance.isPlaying case final value?) 'IsPlaying': value,
      if (instance.playlistItemId case final value?) 'PlaylistItemId': value,
    };

CastReceiverApplication _$CastReceiverApplicationFromJson(
        Map<String, dynamic> json) =>
    CastReceiverApplication(
      id: json['Id'] as String?,
      name: json['Name'] as String?,
    );

Map<String, dynamic> _$CastReceiverApplicationToJson(
        CastReceiverApplication instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'Id': value,
      if (instance.name case final value?) 'Name': value,
    };

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

Map<String, dynamic> _$ChannelFeaturesToJson(ChannelFeatures instance) =>
    <String, dynamic>{
      if (instance.name case final value?) 'Name': value,
      if (instance.id case final value?) 'Id': value,
      if (instance.canSearch case final value?) 'CanSearch': value,
      'MediaTypes': channelMediaTypeListToJson(instance.mediaTypes),
      'ContentTypes': channelMediaContentTypeListToJson(instance.contentTypes),
      if (instance.maxPageSize case final value?) 'MaxPageSize': value,
      if (instance.autoRefreshLevels case final value?)
        'AutoRefreshLevels': value,
      'DefaultSortFields':
          channelItemSortFieldListToJson(instance.defaultSortFields),
      if (instance.supportsSortOrderToggle case final value?)
        'SupportsSortOrderToggle': value,
      if (instance.supportsLatestMedia case final value?)
        'SupportsLatestMedia': value,
      if (instance.canFilter case final value?) 'CanFilter': value,
      if (instance.supportsContentDownloading case final value?)
        'SupportsContentDownloading': value,
    };

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
        ChannelMappingOptionsDto instance) =>
    <String, dynamic>{
      if (instance.tunerChannels?.map((e) => e.toJson()).toList()
          case final value?)
        'TunerChannels': value,
      if (instance.providerChannels?.map((e) => e.toJson()).toList()
          case final value?)
        'ProviderChannels': value,
      if (instance.mappings?.map((e) => e.toJson()).toList() case final value?)
        'Mappings': value,
      if (instance.providerName case final value?) 'ProviderName': value,
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
      if (instance.startPositionTicks case final value?)
        'StartPositionTicks': value,
      if (instance.name case final value?) 'Name': value,
      if (instance.imagePath case final value?) 'ImagePath': value,
      if (instance.imageDateModified?.toIso8601String() case final value?)
        'ImageDateModified': value,
      if (instance.imageTag case final value?) 'ImageTag': value,
    };

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
        ClientCapabilitiesDto instance) =>
    <String, dynamic>{
      'PlayableMediaTypes': mediaTypeListToJson(instance.playableMediaTypes),
      'SupportedCommands':
          generalCommandTypeListToJson(instance.supportedCommands),
      if (instance.supportsMediaControl case final value?)
        'SupportsMediaControl': value,
      if (instance.supportsPersistentIdentifier case final value?)
        'SupportsPersistentIdentifier': value,
      if (instance.deviceProfile?.toJson() case final value?)
        'DeviceProfile': value,
      if (instance.appStoreUrl case final value?) 'AppStoreUrl': value,
      if (instance.iconUrl case final value?) 'IconUrl': value,
    };

ClientLogDocumentResponseDto _$ClientLogDocumentResponseDtoFromJson(
        Map<String, dynamic> json) =>
    ClientLogDocumentResponseDto(
      fileName: json['FileName'] as String?,
    );

Map<String, dynamic> _$ClientLogDocumentResponseDtoToJson(
        ClientLogDocumentResponseDto instance) =>
    <String, dynamic>{
      if (instance.fileName case final value?) 'FileName': value,
    };

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

Map<String, dynamic> _$CodecProfileToJson(CodecProfile instance) =>
    <String, dynamic>{
      if (codecTypeNullableToJson(instance.type) case final value?)
        'Type': value,
      if (instance.conditions?.map((e) => e.toJson()).toList()
          case final value?)
        'Conditions': value,
      if (instance.applyConditions?.map((e) => e.toJson()).toList()
          case final value?)
        'ApplyConditions': value,
      if (instance.codec case final value?) 'Codec': value,
      if (instance.container case final value?) 'Container': value,
      if (instance.subContainer case final value?) 'SubContainer': value,
    };

CollectionCreationResult _$CollectionCreationResultFromJson(
        Map<String, dynamic> json) =>
    CollectionCreationResult(
      id: json['Id'] as String?,
    );

Map<String, dynamic> _$CollectionCreationResultToJson(
        CollectionCreationResult instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'Id': value,
    };

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

Map<String, dynamic> _$ConfigImageTypesToJson(ConfigImageTypes instance) =>
    <String, dynamic>{
      if (instance.backdropSizes case final value?) 'BackdropSizes': value,
      if (instance.baseUrl case final value?) 'BaseUrl': value,
      if (instance.logoSizes case final value?) 'LogoSizes': value,
      if (instance.posterSizes case final value?) 'PosterSizes': value,
      if (instance.profileSizes case final value?) 'ProfileSizes': value,
      if (instance.secureBaseUrl case final value?) 'SecureBaseUrl': value,
      if (instance.stillSizes case final value?) 'StillSizes': value,
    };

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
        ConfigurationPageInfo instance) =>
    <String, dynamic>{
      if (instance.name case final value?) 'Name': value,
      if (instance.enableInMainMenu case final value?)
        'EnableInMainMenu': value,
      if (instance.menuSection case final value?) 'MenuSection': value,
      if (instance.menuIcon case final value?) 'MenuIcon': value,
      if (instance.displayName case final value?) 'DisplayName': value,
      if (instance.pluginId case final value?) 'PluginId': value,
    };

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

Map<String, dynamic> _$ContainerProfileToJson(ContainerProfile instance) =>
    <String, dynamic>{
      if (dlnaProfileTypeNullableToJson(instance.type) case final value?)
        'Type': value,
      if (instance.conditions?.map((e) => e.toJson()).toList()
          case final value?)
        'Conditions': value,
      if (instance.container case final value?) 'Container': value,
      if (instance.subContainer case final value?) 'SubContainer': value,
    };

CountryInfo _$CountryInfoFromJson(Map<String, dynamic> json) => CountryInfo(
      name: json['Name'] as String?,
      displayName: json['DisplayName'] as String?,
      twoLetterISORegionName: json['TwoLetterISORegionName'] as String?,
      threeLetterISORegionName: json['ThreeLetterISORegionName'] as String?,
    );

Map<String, dynamic> _$CountryInfoToJson(CountryInfo instance) =>
    <String, dynamic>{
      if (instance.name case final value?) 'Name': value,
      if (instance.displayName case final value?) 'DisplayName': value,
      if (instance.twoLetterISORegionName case final value?)
        'TwoLetterISORegionName': value,
      if (instance.threeLetterISORegionName case final value?)
        'ThreeLetterISORegionName': value,
    };

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

Map<String, dynamic> _$CreatePlaylistDtoToJson(CreatePlaylistDto instance) =>
    <String, dynamic>{
      if (instance.name case final value?) 'Name': value,
      if (instance.ids case final value?) 'Ids': value,
      if (instance.userId case final value?) 'UserId': value,
      if (mediaTypeNullableToJson(instance.mediaType) case final value?)
        'MediaType': value,
      if (instance.users?.map((e) => e.toJson()).toList() case final value?)
        'Users': value,
      if (instance.isPublic case final value?) 'IsPublic': value,
    };

CreateUserByName _$CreateUserByNameFromJson(Map<String, dynamic> json) =>
    CreateUserByName(
      name: json['Name'] as String,
      password: json['Password'] as String?,
    );

Map<String, dynamic> _$CreateUserByNameToJson(CreateUserByName instance) =>
    <String, dynamic>{
      'Name': instance.name,
      if (instance.password case final value?) 'Password': value,
    };

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
      if (instance.name case final value?) 'Name': value,
      if (instance.displayName case final value?) 'DisplayName': value,
      if (instance.twoLetterISOLanguageName case final value?)
        'TwoLetterISOLanguageName': value,
      if (instance.threeLetterISOLanguageName case final value?)
        'ThreeLetterISOLanguageName': value,
      if (instance.threeLetterISOLanguageNames case final value?)
        'ThreeLetterISOLanguageNames': value,
    };

DefaultDirectoryBrowserInfoDto _$DefaultDirectoryBrowserInfoDtoFromJson(
        Map<String, dynamic> json) =>
    DefaultDirectoryBrowserInfoDto(
      path: json['Path'] as String?,
    );

Map<String, dynamic> _$DefaultDirectoryBrowserInfoDtoToJson(
        DefaultDirectoryBrowserInfoDto instance) =>
    <String, dynamic>{
      if (instance.path case final value?) 'Path': value,
    };

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

Map<String, dynamic> _$DeviceInfoDtoToJson(DeviceInfoDto instance) =>
    <String, dynamic>{
      if (instance.name case final value?) 'Name': value,
      if (instance.customName case final value?) 'CustomName': value,
      if (instance.accessToken case final value?) 'AccessToken': value,
      if (instance.id case final value?) 'Id': value,
      if (instance.lastUserName case final value?) 'LastUserName': value,
      if (instance.appName case final value?) 'AppName': value,
      if (instance.appVersion case final value?) 'AppVersion': value,
      if (instance.lastUserId case final value?) 'LastUserId': value,
      if (instance.dateLastActivity?.toIso8601String() case final value?)
        'DateLastActivity': value,
      if (instance.capabilities?.toJson() case final value?)
        'Capabilities': value,
      if (instance.iconUrl case final value?) 'IconUrl': value,
    };

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
        DeviceInfoDtoQueryResult instance) =>
    <String, dynamic>{
      if (instance.items?.map((e) => e.toJson()).toList() case final value?)
        'Items': value,
      if (instance.totalRecordCount case final value?)
        'TotalRecordCount': value,
      if (instance.startIndex case final value?) 'StartIndex': value,
    };

DeviceOptionsDto _$DeviceOptionsDtoFromJson(Map<String, dynamic> json) =>
    DeviceOptionsDto(
      id: (json['Id'] as num?)?.toInt(),
      deviceId: json['DeviceId'] as String?,
      customName: json['CustomName'] as String?,
    );

Map<String, dynamic> _$DeviceOptionsDtoToJson(DeviceOptionsDto instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'Id': value,
      if (instance.deviceId case final value?) 'DeviceId': value,
      if (instance.customName case final value?) 'CustomName': value,
    };

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

Map<String, dynamic> _$DeviceProfileToJson(DeviceProfile instance) =>
    <String, dynamic>{
      if (instance.name case final value?) 'Name': value,
      if (instance.id case final value?) 'Id': value,
      if (instance.maxStreamingBitrate case final value?)
        'MaxStreamingBitrate': value,
      if (instance.maxStaticBitrate case final value?)
        'MaxStaticBitrate': value,
      if (instance.musicStreamingTranscodingBitrate case final value?)
        'MusicStreamingTranscodingBitrate': value,
      if (instance.maxStaticMusicBitrate case final value?)
        'MaxStaticMusicBitrate': value,
      if (instance.directPlayProfiles?.map((e) => e.toJson()).toList()
          case final value?)
        'DirectPlayProfiles': value,
      if (instance.transcodingProfiles?.map((e) => e.toJson()).toList()
          case final value?)
        'TranscodingProfiles': value,
      if (instance.containerProfiles?.map((e) => e.toJson()).toList()
          case final value?)
        'ContainerProfiles': value,
      if (instance.codecProfiles?.map((e) => e.toJson()).toList()
          case final value?)
        'CodecProfiles': value,
      if (instance.subtitleProfiles?.map((e) => e.toJson()).toList()
          case final value?)
        'SubtitleProfiles': value,
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
      if (instance.container case final value?) 'Container': value,
      if (instance.audioCodec case final value?) 'AudioCodec': value,
      if (instance.videoCodec case final value?) 'VideoCodec': value,
      if (dlnaProfileTypeNullableToJson(instance.type) case final value?)
        'Type': value,
    };

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
        DisplayPreferencesDto instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'Id': value,
      if (instance.viewType case final value?) 'ViewType': value,
      if (instance.sortBy case final value?) 'SortBy': value,
      if (instance.indexBy case final value?) 'IndexBy': value,
      if (instance.rememberIndexing case final value?)
        'RememberIndexing': value,
      if (instance.primaryImageHeight case final value?)
        'PrimaryImageHeight': value,
      if (instance.primaryImageWidth case final value?)
        'PrimaryImageWidth': value,
      if (instance.customPrefs case final value?) 'CustomPrefs': value,
      if (scrollDirectionNullableToJson(instance.scrollDirection)
          case final value?)
        'ScrollDirection': value,
      if (instance.showBackdrop case final value?) 'ShowBackdrop': value,
      if (instance.rememberSorting case final value?) 'RememberSorting': value,
      if (sortOrderNullableToJson(instance.sortOrder) case final value?)
        'SortOrder': value,
      if (instance.showSidebar case final value?) 'ShowSidebar': value,
      if (instance.$Client case final value?) 'Client': value,
    };

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

Map<String, dynamic> _$EncodingOptionsToJson(EncodingOptions instance) =>
    <String, dynamic>{
      if (instance.encodingThreadCount case final value?)
        'EncodingThreadCount': value,
      if (instance.transcodingTempPath case final value?)
        'TranscodingTempPath': value,
      if (instance.fallbackFontPath case final value?)
        'FallbackFontPath': value,
      if (instance.enableFallbackFont case final value?)
        'EnableFallbackFont': value,
      if (instance.enableAudioVbr case final value?) 'EnableAudioVbr': value,
      if (instance.downMixAudioBoost case final value?)
        'DownMixAudioBoost': value,
      if (downMixStereoAlgorithmsNullableToJson(instance.downMixStereoAlgorithm)
          case final value?)
        'DownMixStereoAlgorithm': value,
      if (instance.maxMuxingQueueSize case final value?)
        'MaxMuxingQueueSize': value,
      if (instance.enableThrottling case final value?)
        'EnableThrottling': value,
      if (instance.throttleDelaySeconds case final value?)
        'ThrottleDelaySeconds': value,
      if (instance.enableSegmentDeletion case final value?)
        'EnableSegmentDeletion': value,
      if (instance.segmentKeepSeconds case final value?)
        'SegmentKeepSeconds': value,
      if (hardwareAccelerationTypeNullableToJson(
              instance.hardwareAccelerationType)
          case final value?)
        'HardwareAccelerationType': value,
      if (instance.encoderAppPath case final value?) 'EncoderAppPath': value,
      if (instance.encoderAppPathDisplay case final value?)
        'EncoderAppPathDisplay': value,
      if (instance.vaapiDevice case final value?) 'VaapiDevice': value,
      if (instance.qsvDevice case final value?) 'QsvDevice': value,
      if (instance.enableTonemapping case final value?)
        'EnableTonemapping': value,
      if (instance.enableVppTonemapping case final value?)
        'EnableVppTonemapping': value,
      if (instance.enableVideoToolboxTonemapping case final value?)
        'EnableVideoToolboxTonemapping': value,
      if (tonemappingAlgorithmNullableToJson(instance.tonemappingAlgorithm)
          case final value?)
        'TonemappingAlgorithm': value,
      if (tonemappingModeNullableToJson(instance.tonemappingMode)
          case final value?)
        'TonemappingMode': value,
      if (tonemappingRangeNullableToJson(instance.tonemappingRange)
          case final value?)
        'TonemappingRange': value,
      if (instance.tonemappingDesat case final value?)
        'TonemappingDesat': value,
      if (instance.tonemappingPeak case final value?) 'TonemappingPeak': value,
      if (instance.tonemappingParam case final value?)
        'TonemappingParam': value,
      if (instance.vppTonemappingBrightness case final value?)
        'VppTonemappingBrightness': value,
      if (instance.vppTonemappingContrast case final value?)
        'VppTonemappingContrast': value,
      if (instance.h264Crf case final value?) 'H264Crf': value,
      if (instance.h265Crf case final value?) 'H265Crf': value,
      if (encoderPresetNullableToJson(instance.encoderPreset) case final value?)
        'EncoderPreset': value,
      if (instance.deinterlaceDoubleRate case final value?)
        'DeinterlaceDoubleRate': value,
      if (deinterlaceMethodNullableToJson(instance.deinterlaceMethod)
          case final value?)
        'DeinterlaceMethod': value,
      if (instance.enableDecodingColorDepth10Hevc case final value?)
        'EnableDecodingColorDepth10Hevc': value,
      if (instance.enableDecodingColorDepth10Vp9 case final value?)
        'EnableDecodingColorDepth10Vp9': value,
      if (instance.enableDecodingColorDepth10HevcRext case final value?)
        'EnableDecodingColorDepth10HevcRext': value,
      if (instance.enableDecodingColorDepth12HevcRext case final value?)
        'EnableDecodingColorDepth12HevcRext': value,
      if (instance.enableEnhancedNvdecDecoder case final value?)
        'EnableEnhancedNvdecDecoder': value,
      if (instance.preferSystemNativeHwDecoder case final value?)
        'PreferSystemNativeHwDecoder': value,
      if (instance.enableIntelLowPowerH264HwEncoder case final value?)
        'EnableIntelLowPowerH264HwEncoder': value,
      if (instance.enableIntelLowPowerHevcHwEncoder case final value?)
        'EnableIntelLowPowerHevcHwEncoder': value,
      if (instance.enableHardwareEncoding case final value?)
        'EnableHardwareEncoding': value,
      if (instance.allowHevcEncoding case final value?)
        'AllowHevcEncoding': value,
      if (instance.allowAv1Encoding case final value?)
        'AllowAv1Encoding': value,
      if (instance.enableSubtitleExtraction case final value?)
        'EnableSubtitleExtraction': value,
      if (instance.hardwareDecodingCodecs case final value?)
        'HardwareDecodingCodecs': value,
      if (instance.allowOnDemandMetadataBasedKeyframeExtractionForExtensions
          case final value?)
        'AllowOnDemandMetadataBasedKeyframeExtractionForExtensions': value,
    };

EndPointInfo _$EndPointInfoFromJson(Map<String, dynamic> json) => EndPointInfo(
      isLocal: json['IsLocal'] as bool?,
      isInNetwork: json['IsInNetwork'] as bool?,
    );

Map<String, dynamic> _$EndPointInfoToJson(EndPointInfo instance) =>
    <String, dynamic>{
      if (instance.isLocal case final value?) 'IsLocal': value,
      if (instance.isInNetwork case final value?) 'IsInNetwork': value,
    };

ExternalIdInfo _$ExternalIdInfoFromJson(Map<String, dynamic> json) =>
    ExternalIdInfo(
      name: json['Name'] as String?,
      key: json['Key'] as String?,
      type: externalIdMediaTypeNullableFromJson(json['Type']),
      urlFormatString: json['UrlFormatString'] as String?,
    );

Map<String, dynamic> _$ExternalIdInfoToJson(ExternalIdInfo instance) =>
    <String, dynamic>{
      if (instance.name case final value?) 'Name': value,
      if (instance.key case final value?) 'Key': value,
      if (externalIdMediaTypeNullableToJson(instance.type) case final value?)
        'Type': value,
      if (instance.urlFormatString case final value?) 'UrlFormatString': value,
    };

ExternalUrl _$ExternalUrlFromJson(Map<String, dynamic> json) => ExternalUrl(
      name: json['Name'] as String?,
      url: json['Url'] as String?,
    );

Map<String, dynamic> _$ExternalUrlToJson(ExternalUrl instance) =>
    <String, dynamic>{
      if (instance.name case final value?) 'Name': value,
      if (instance.url case final value?) 'Url': value,
    };

FileSystemEntryInfo _$FileSystemEntryInfoFromJson(Map<String, dynamic> json) =>
    FileSystemEntryInfo(
      name: json['Name'] as String?,
      path: json['Path'] as String?,
      type: fileSystemEntryTypeNullableFromJson(json['Type']),
    );

Map<String, dynamic> _$FileSystemEntryInfoToJson(
        FileSystemEntryInfo instance) =>
    <String, dynamic>{
      if (instance.name case final value?) 'Name': value,
      if (instance.path case final value?) 'Path': value,
      if (fileSystemEntryTypeNullableToJson(instance.type) case final value?)
        'Type': value,
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
      if (instance.name case final value?) 'Name': value,
      if (instance.size case final value?) 'Size': value,
      if (instance.dateCreated?.toIso8601String() case final value?)
        'DateCreated': value,
      if (instance.dateModified?.toIso8601String() case final value?)
        'DateModified': value,
    };

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
        ForceKeepAliveMessage instance) =>
    <String, dynamic>{
      if (instance.data case final value?) 'Data': value,
      if (instance.messageId case final value?) 'MessageId': value,
      if (sessionMessageTypeNullableToJson(instance.messageType)
          case final value?)
        'MessageType': value,
    };

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
        ForgotPasswordResult instance) =>
    <String, dynamic>{
      if (forgotPasswordActionNullableToJson(instance.action) case final value?)
        'Action': value,
      if (instance.pinFile case final value?) 'PinFile': value,
      if (instance.pinExpirationDate?.toIso8601String() case final value?)
        'PinExpirationDate': value,
    };

GeneralCommand _$GeneralCommandFromJson(Map<String, dynamic> json) =>
    GeneralCommand(
      name: generalCommandTypeNullableFromJson(json['Name']),
      controllingUserId: json['ControllingUserId'] as String?,
      arguments: json['Arguments'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$GeneralCommandToJson(GeneralCommand instance) =>
    <String, dynamic>{
      if (generalCommandTypeNullableToJson(instance.name) case final value?)
        'Name': value,
      if (instance.controllingUserId case final value?)
        'ControllingUserId': value,
      if (instance.arguments case final value?) 'Arguments': value,
    };

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
        GeneralCommandMessage instance) =>
    <String, dynamic>{
      if (instance.data?.toJson() case final value?) 'Data': value,
      if (instance.messageId case final value?) 'MessageId': value,
      if (sessionMessageTypeNullableToJson(instance.messageType)
          case final value?)
        'MessageType': value,
    };

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

Map<String, dynamic> _$GetProgramsDtoToJson(GetProgramsDto instance) =>
    <String, dynamic>{
      if (instance.channelIds case final value?) 'ChannelIds': value,
      if (instance.userId case final value?) 'UserId': value,
      if (instance.minStartDate?.toIso8601String() case final value?)
        'MinStartDate': value,
      if (instance.hasAired case final value?) 'HasAired': value,
      if (instance.isAiring case final value?) 'IsAiring': value,
      if (instance.maxStartDate?.toIso8601String() case final value?)
        'MaxStartDate': value,
      if (instance.minEndDate?.toIso8601String() case final value?)
        'MinEndDate': value,
      if (instance.maxEndDate?.toIso8601String() case final value?)
        'MaxEndDate': value,
      if (instance.isMovie case final value?) 'IsMovie': value,
      if (instance.isSeries case final value?) 'IsSeries': value,
      if (instance.isNews case final value?) 'IsNews': value,
      if (instance.isKids case final value?) 'IsKids': value,
      if (instance.isSports case final value?) 'IsSports': value,
      if (instance.startIndex case final value?) 'StartIndex': value,
      if (instance.limit case final value?) 'Limit': value,
      'SortBy': itemSortByListToJson(instance.sortBy),
      'SortOrder': sortOrderListToJson(instance.sortOrder),
      if (instance.genres case final value?) 'Genres': value,
      if (instance.genreIds case final value?) 'GenreIds': value,
      if (instance.enableImages case final value?) 'EnableImages': value,
      if (instance.enableTotalRecordCount case final value?)
        'EnableTotalRecordCount': value,
      if (instance.imageTypeLimit case final value?) 'ImageTypeLimit': value,
      'EnableImageTypes': imageTypeListToJson(instance.enableImageTypes),
      if (instance.enableUserData case final value?) 'EnableUserData': value,
      if (instance.seriesTimerId case final value?) 'SeriesTimerId': value,
      if (instance.librarySeriesId case final value?) 'LibrarySeriesId': value,
      'Fields': itemFieldsListToJson(instance.fields),
    };

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

Map<String, dynamic> _$GroupInfoDtoToJson(GroupInfoDto instance) =>
    <String, dynamic>{
      if (instance.groupId case final value?) 'GroupId': value,
      if (instance.groupName case final value?) 'GroupName': value,
      if (groupStateTypeNullableToJson(instance.state) case final value?)
        'State': value,
      if (instance.participants case final value?) 'Participants': value,
      if (instance.lastUpdatedAt?.toIso8601String() case final value?)
        'LastUpdatedAt': value,
    };

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
        GroupInfoDtoGroupUpdate instance) =>
    <String, dynamic>{
      if (instance.groupId case final value?) 'GroupId': value,
      if (groupUpdateTypeNullableToJson(instance.type) case final value?)
        'Type': value,
      if (instance.data?.toJson() case final value?) 'Data': value,
    };

GroupStateUpdate _$GroupStateUpdateFromJson(Map<String, dynamic> json) =>
    GroupStateUpdate(
      state: groupStateTypeNullableFromJson(json['State']),
      reason: playbackRequestTypeNullableFromJson(json['Reason']),
    );

Map<String, dynamic> _$GroupStateUpdateToJson(GroupStateUpdate instance) =>
    <String, dynamic>{
      if (groupStateTypeNullableToJson(instance.state) case final value?)
        'State': value,
      if (playbackRequestTypeNullableToJson(instance.reason) case final value?)
        'Reason': value,
    };

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
        GroupStateUpdateGroupUpdate instance) =>
    <String, dynamic>{
      if (instance.groupId case final value?) 'GroupId': value,
      if (groupUpdateTypeNullableToJson(instance.type) case final value?)
        'Type': value,
      if (instance.data?.toJson() case final value?) 'Data': value,
    };

GroupUpdate _$GroupUpdateFromJson(Map<String, dynamic> json) => GroupUpdate(
      groupId: json['GroupId'] as String?,
      type: groupUpdateTypeNullableFromJson(json['Type']),
    );

Map<String, dynamic> _$GroupUpdateToJson(GroupUpdate instance) =>
    <String, dynamic>{
      if (instance.groupId case final value?) 'GroupId': value,
      if (groupUpdateTypeNullableToJson(instance.type) case final value?)
        'Type': value,
    };

GuideInfo _$GuideInfoFromJson(Map<String, dynamic> json) => GuideInfo(
      startDate: json['StartDate'] == null
          ? null
          : DateTime.parse(json['StartDate'] as String),
      endDate: json['EndDate'] == null
          ? null
          : DateTime.parse(json['EndDate'] as String),
    );

Map<String, dynamic> _$GuideInfoToJson(GuideInfo instance) => <String, dynamic>{
      if (instance.startDate?.toIso8601String() case final value?)
        'StartDate': value,
      if (instance.endDate?.toIso8601String() case final value?)
        'EndDate': value,
    };

IgnoreWaitRequestDto _$IgnoreWaitRequestDtoFromJson(
        Map<String, dynamic> json) =>
    IgnoreWaitRequestDto(
      ignoreWait: json['IgnoreWait'] as bool?,
    );

Map<String, dynamic> _$IgnoreWaitRequestDtoToJson(
        IgnoreWaitRequestDto instance) =>
    <String, dynamic>{
      if (instance.ignoreWait case final value?) 'IgnoreWait': value,
    };

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
      if (imageTypeNullableToJson(instance.imageType) case final value?)
        'ImageType': value,
      if (instance.imageIndex case final value?) 'ImageIndex': value,
      if (instance.imageTag case final value?) 'ImageTag': value,
      if (instance.path case final value?) 'Path': value,
      if (instance.blurHash case final value?) 'BlurHash': value,
      if (instance.height case final value?) 'Height': value,
      if (instance.width case final value?) 'Width': value,
      if (instance.size case final value?) 'Size': value,
    };

ImageOption _$ImageOptionFromJson(Map<String, dynamic> json) => ImageOption(
      type: imageTypeNullableFromJson(json['Type']),
      limit: (json['Limit'] as num?)?.toInt(),
      minWidth: (json['MinWidth'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ImageOptionToJson(ImageOption instance) =>
    <String, dynamic>{
      if (imageTypeNullableToJson(instance.type) case final value?)
        'Type': value,
      if (instance.limit case final value?) 'Limit': value,
      if (instance.minWidth case final value?) 'MinWidth': value,
    };

ImageProviderInfo _$ImageProviderInfoFromJson(Map<String, dynamic> json) =>
    ImageProviderInfo(
      name: json['Name'] as String?,
      supportedImages: imageTypeListFromJson(json['SupportedImages'] as List?),
    );

Map<String, dynamic> _$ImageProviderInfoToJson(ImageProviderInfo instance) =>
    <String, dynamic>{
      if (instance.name case final value?) 'Name': value,
      'SupportedImages': imageTypeListToJson(instance.supportedImages),
    };

InboundKeepAliveMessage _$InboundKeepAliveMessageFromJson(
        Map<String, dynamic> json) =>
    InboundKeepAliveMessage(
      messageType:
          InboundKeepAliveMessage.sessionMessageTypeMessageTypeNullableFromJson(
              json['MessageType']),
    );

Map<String, dynamic> _$InboundKeepAliveMessageToJson(
        InboundKeepAliveMessage instance) =>
    <String, dynamic>{
      if (sessionMessageTypeNullableToJson(instance.messageType)
          case final value?)
        'MessageType': value,
    };

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

Map<String, dynamic> _$InstallationInfoToJson(InstallationInfo instance) =>
    <String, dynamic>{
      if (instance.guid case final value?) 'Guid': value,
      if (instance.name case final value?) 'Name': value,
      if (instance.version case final value?) 'Version': value,
      if (instance.changelog case final value?) 'Changelog': value,
      if (instance.sourceUrl case final value?) 'SourceUrl': value,
      if (instance.checksum case final value?) 'Checksum': value,
      if (instance.packageInfo?.toJson() case final value?)
        'PackageInfo': value,
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
      if (instance.name case final value?) 'Name': value,
      if (instance.description case final value?) 'Description': value,
      if (instance.id case final value?) 'Id': value,
      if (instance.version case final value?) 'Version': value,
      if (instance.assemblyFilePath case final value?)
        'AssemblyFilePath': value,
      if (instance.canUninstall case final value?) 'CanUninstall': value,
      if (instance.dataFolderPath case final value?) 'DataFolderPath': value,
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
      if (instance.movieCount case final value?) 'MovieCount': value,
      if (instance.seriesCount case final value?) 'SeriesCount': value,
      if (instance.episodeCount case final value?) 'EpisodeCount': value,
      if (instance.artistCount case final value?) 'ArtistCount': value,
      if (instance.programCount case final value?) 'ProgramCount': value,
      if (instance.trailerCount case final value?) 'TrailerCount': value,
      if (instance.songCount case final value?) 'SongCount': value,
      if (instance.albumCount case final value?) 'AlbumCount': value,
      if (instance.musicVideoCount case final value?) 'MusicVideoCount': value,
      if (instance.boxSetCount case final value?) 'BoxSetCount': value,
      if (instance.bookCount case final value?) 'BookCount': value,
      if (instance.itemCount case final value?) 'ItemCount': value,
    };

JoinGroupRequestDto _$JoinGroupRequestDtoFromJson(Map<String, dynamic> json) =>
    JoinGroupRequestDto(
      groupId: json['GroupId'] as String?,
    );

Map<String, dynamic> _$JoinGroupRequestDtoToJson(
        JoinGroupRequestDto instance) =>
    <String, dynamic>{
      if (instance.groupId case final value?) 'GroupId': value,
    };

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
        LibraryChangedMessage instance) =>
    <String, dynamic>{
      if (instance.data?.toJson() case final value?) 'Data': value,
      if (instance.messageId case final value?) 'MessageId': value,
      if (sessionMessageTypeNullableToJson(instance.messageType)
          case final value?)
        'MessageType': value,
    };

LibraryOptionInfoDto _$LibraryOptionInfoDtoFromJson(
        Map<String, dynamic> json) =>
    LibraryOptionInfoDto(
      name: json['Name'] as String?,
      defaultEnabled: json['DefaultEnabled'] as bool?,
    );

Map<String, dynamic> _$LibraryOptionInfoDtoToJson(
        LibraryOptionInfoDto instance) =>
    <String, dynamic>{
      if (instance.name case final value?) 'Name': value,
      if (instance.defaultEnabled case final value?) 'DefaultEnabled': value,
    };

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

Map<String, dynamic> _$LibraryOptionsToJson(LibraryOptions instance) =>
    <String, dynamic>{
      if (instance.enabled case final value?) 'Enabled': value,
      if (instance.enablePhotos case final value?) 'EnablePhotos': value,
      if (instance.enableRealtimeMonitor case final value?)
        'EnableRealtimeMonitor': value,
      if (instance.enableLUFSScan case final value?) 'EnableLUFSScan': value,
      if (instance.enableChapterImageExtraction case final value?)
        'EnableChapterImageExtraction': value,
      if (instance.extractChapterImagesDuringLibraryScan case final value?)
        'ExtractChapterImagesDuringLibraryScan': value,
      if (instance.enableTrickplayImageExtraction case final value?)
        'EnableTrickplayImageExtraction': value,
      if (instance.extractTrickplayImagesDuringLibraryScan case final value?)
        'ExtractTrickplayImagesDuringLibraryScan': value,
      if (instance.pathInfos?.map((e) => e.toJson()).toList() case final value?)
        'PathInfos': value,
      if (instance.saveLocalMetadata case final value?)
        'SaveLocalMetadata': value,
      if (instance.enableInternetProviders case final value?)
        'EnableInternetProviders': value,
      if (instance.enableAutomaticSeriesGrouping case final value?)
        'EnableAutomaticSeriesGrouping': value,
      if (instance.enableEmbeddedTitles case final value?)
        'EnableEmbeddedTitles': value,
      if (instance.enableEmbeddedExtrasTitles case final value?)
        'EnableEmbeddedExtrasTitles': value,
      if (instance.enableEmbeddedEpisodeInfos case final value?)
        'EnableEmbeddedEpisodeInfos': value,
      if (instance.automaticRefreshIntervalDays case final value?)
        'AutomaticRefreshIntervalDays': value,
      if (instance.preferredMetadataLanguage case final value?)
        'PreferredMetadataLanguage': value,
      if (instance.metadataCountryCode case final value?)
        'MetadataCountryCode': value,
      if (instance.seasonZeroDisplayName case final value?)
        'SeasonZeroDisplayName': value,
      if (instance.metadataSavers case final value?) 'MetadataSavers': value,
      if (instance.disabledLocalMetadataReaders case final value?)
        'DisabledLocalMetadataReaders': value,
      if (instance.localMetadataReaderOrder case final value?)
        'LocalMetadataReaderOrder': value,
      if (instance.disabledSubtitleFetchers case final value?)
        'DisabledSubtitleFetchers': value,
      if (instance.subtitleFetcherOrder case final value?)
        'SubtitleFetcherOrder': value,
      if (instance.disabledMediaSegmentProviders case final value?)
        'DisabledMediaSegmentProviders': value,
      if (instance.mediaSegmentProvideOrder case final value?)
        'MediaSegmentProvideOrder': value,
      if (instance.skipSubtitlesIfEmbeddedSubtitlesPresent case final value?)
        'SkipSubtitlesIfEmbeddedSubtitlesPresent': value,
      if (instance.skipSubtitlesIfAudioTrackMatches case final value?)
        'SkipSubtitlesIfAudioTrackMatches': value,
      if (instance.subtitleDownloadLanguages case final value?)
        'SubtitleDownloadLanguages': value,
      if (instance.requirePerfectSubtitleMatch case final value?)
        'RequirePerfectSubtitleMatch': value,
      if (instance.saveSubtitlesWithMedia case final value?)
        'SaveSubtitlesWithMedia': value,
      if (instance.saveLyricsWithMedia case final value?)
        'SaveLyricsWithMedia': value,
      if (instance.saveTrickplayWithMedia case final value?)
        'SaveTrickplayWithMedia': value,
      if (instance.disabledLyricFetchers case final value?)
        'DisabledLyricFetchers': value,
      if (instance.lyricFetcherOrder case final value?)
        'LyricFetcherOrder': value,
      if (instance.preferNonstandardArtistsTag case final value?)
        'PreferNonstandardArtistsTag': value,
      if (instance.useCustomTagDelimiters case final value?)
        'UseCustomTagDelimiters': value,
      if (instance.customTagDelimiters case final value?)
        'CustomTagDelimiters': value,
      if (instance.delimiterWhitelist case final value?)
        'DelimiterWhitelist': value,
      if (instance.automaticallyAddToCollection case final value?)
        'AutomaticallyAddToCollection': value,
      if (embeddedSubtitleOptionsNullableToJson(instance.allowEmbeddedSubtitles)
          case final value?)
        'AllowEmbeddedSubtitles': value,
      if (instance.typeOptions?.map((e) => e.toJson()).toList()
          case final value?)
        'TypeOptions': value,
    };

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
        LibraryOptionsResultDto instance) =>
    <String, dynamic>{
      if (instance.metadataSavers?.map((e) => e.toJson()).toList()
          case final value?)
        'MetadataSavers': value,
      if (instance.metadataReaders?.map((e) => e.toJson()).toList()
          case final value?)
        'MetadataReaders': value,
      if (instance.subtitleFetchers?.map((e) => e.toJson()).toList()
          case final value?)
        'SubtitleFetchers': value,
      if (instance.lyricFetchers?.map((e) => e.toJson()).toList()
          case final value?)
        'LyricFetchers': value,
      if (instance.typeOptions?.map((e) => e.toJson()).toList()
          case final value?)
        'TypeOptions': value,
    };

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
        LibraryTypeOptionsDto instance) =>
    <String, dynamic>{
      if (instance.type case final value?) 'Type': value,
      if (instance.metadataFetchers?.map((e) => e.toJson()).toList()
          case final value?)
        'MetadataFetchers': value,
      if (instance.imageFetchers?.map((e) => e.toJson()).toList()
          case final value?)
        'ImageFetchers': value,
      'SupportedImageTypes': imageTypeListToJson(instance.supportedImageTypes),
      if (instance.defaultImageOptions?.map((e) => e.toJson()).toList()
          case final value?)
        'DefaultImageOptions': value,
    };

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

Map<String, dynamic> _$LibraryUpdateInfoToJson(LibraryUpdateInfo instance) =>
    <String, dynamic>{
      if (instance.foldersAddedTo case final value?) 'FoldersAddedTo': value,
      if (instance.foldersRemovedFrom case final value?)
        'FoldersRemovedFrom': value,
      if (instance.itemsAdded case final value?) 'ItemsAdded': value,
      if (instance.itemsRemoved case final value?) 'ItemsRemoved': value,
      if (instance.itemsUpdated case final value?) 'ItemsUpdated': value,
      if (instance.collectionFolders case final value?)
        'CollectionFolders': value,
      if (instance.isEmpty case final value?) 'IsEmpty': value,
    };

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
        ListingsProviderInfo instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'Id': value,
      if (instance.type case final value?) 'Type': value,
      if (instance.username case final value?) 'Username': value,
      if (instance.password case final value?) 'Password': value,
      if (instance.listingsId case final value?) 'ListingsId': value,
      if (instance.zipCode case final value?) 'ZipCode': value,
      if (instance.country case final value?) 'Country': value,
      if (instance.path case final value?) 'Path': value,
      if (instance.enabledTuners case final value?) 'EnabledTuners': value,
      if (instance.enableAllTuners case final value?) 'EnableAllTuners': value,
      if (instance.newsCategories case final value?) 'NewsCategories': value,
      if (instance.sportsCategories case final value?)
        'SportsCategories': value,
      if (instance.kidsCategories case final value?) 'KidsCategories': value,
      if (instance.movieCategories case final value?) 'MovieCategories': value,
      if (instance.channelMappings?.map((e) => e.toJson()).toList()
          case final value?)
        'ChannelMappings': value,
      if (instance.moviePrefix case final value?) 'MoviePrefix': value,
      if (instance.preferredLanguage case final value?)
        'PreferredLanguage': value,
      if (instance.userAgent case final value?) 'UserAgent': value,
    };

LiveStreamResponse _$LiveStreamResponseFromJson(Map<String, dynamic> json) =>
    LiveStreamResponse(
      mediaSource: json['MediaSource'] == null
          ? null
          : MediaSourceInfo.fromJson(
              json['MediaSource'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LiveStreamResponseToJson(LiveStreamResponse instance) =>
    <String, dynamic>{
      if (instance.mediaSource?.toJson() case final value?)
        'MediaSource': value,
    };

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

Map<String, dynamic> _$LiveTvInfoToJson(LiveTvInfo instance) =>
    <String, dynamic>{
      if (instance.services?.map((e) => e.toJson()).toList() case final value?)
        'Services': value,
      if (instance.isEnabled case final value?) 'IsEnabled': value,
      if (instance.enabledUsers case final value?) 'EnabledUsers': value,
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

Map<String, dynamic> _$LiveTvOptionsToJson(LiveTvOptions instance) =>
    <String, dynamic>{
      if (instance.guideDays case final value?) 'GuideDays': value,
      if (instance.recordingPath case final value?) 'RecordingPath': value,
      if (instance.movieRecordingPath case final value?)
        'MovieRecordingPath': value,
      if (instance.seriesRecordingPath case final value?)
        'SeriesRecordingPath': value,
      if (instance.enableRecordingSubfolders case final value?)
        'EnableRecordingSubfolders': value,
      if (instance.enableOriginalAudioWithEncodedRecordings case final value?)
        'EnableOriginalAudioWithEncodedRecordings': value,
      if (instance.tunerHosts?.map((e) => e.toJson()).toList()
          case final value?)
        'TunerHosts': value,
      if (instance.listingProviders?.map((e) => e.toJson()).toList()
          case final value?)
        'ListingProviders': value,
      if (instance.prePaddingSeconds case final value?)
        'PrePaddingSeconds': value,
      if (instance.postPaddingSeconds case final value?)
        'PostPaddingSeconds': value,
      if (instance.mediaLocationsCreated case final value?)
        'MediaLocationsCreated': value,
      if (instance.recordingPostProcessor case final value?)
        'RecordingPostProcessor': value,
      if (instance.recordingPostProcessorArguments case final value?)
        'RecordingPostProcessorArguments': value,
      if (instance.saveRecordingNFO case final value?)
        'SaveRecordingNFO': value,
      if (instance.saveRecordingImages case final value?)
        'SaveRecordingImages': value,
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
      tuners: (json['Tuners'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$LiveTvServiceInfoToJson(LiveTvServiceInfo instance) =>
    <String, dynamic>{
      if (instance.name case final value?) 'Name': value,
      if (instance.homePageUrl case final value?) 'HomePageUrl': value,
      if (liveTvServiceStatusNullableToJson(instance.status) case final value?)
        'Status': value,
      if (instance.statusMessage case final value?) 'StatusMessage': value,
      if (instance.version case final value?) 'Version': value,
      if (instance.hasUpdateAvailable case final value?)
        'HasUpdateAvailable': value,
      if (instance.isVisible case final value?) 'IsVisible': value,
      if (instance.tuners case final value?) 'Tuners': value,
    };

LocalizationOption _$LocalizationOptionFromJson(Map<String, dynamic> json) =>
    LocalizationOption(
      name: json['Name'] as String?,
      $Value: json['Value'] as String?,
    );

Map<String, dynamic> _$LocalizationOptionToJson(LocalizationOption instance) =>
    <String, dynamic>{
      if (instance.name case final value?) 'Name': value,
      if (instance.$Value case final value?) 'Value': value,
    };

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
      if (instance.dateCreated?.toIso8601String() case final value?)
        'DateCreated': value,
      if (instance.dateModified?.toIso8601String() case final value?)
        'DateModified': value,
      if (instance.size case final value?) 'Size': value,
      if (instance.name case final value?) 'Name': value,
    };

LyricDto _$LyricDtoFromJson(Map<String, dynamic> json) => LyricDto(
      metadata: json['Metadata'] == null
          ? null
          : LyricMetadata.fromJson(json['Metadata'] as Map<String, dynamic>),
      lyrics: (json['Lyrics'] as List<dynamic>?)
              ?.map((e) => LyricLine.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$LyricDtoToJson(LyricDto instance) => <String, dynamic>{
      if (instance.metadata?.toJson() case final value?) 'Metadata': value,
      if (instance.lyrics?.map((e) => e.toJson()).toList() case final value?)
        'Lyrics': value,
    };

LyricLine _$LyricLineFromJson(Map<String, dynamic> json) => LyricLine(
      text: json['Text'] as String?,
      start: (json['Start'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LyricLineToJson(LyricLine instance) => <String, dynamic>{
      if (instance.text case final value?) 'Text': value,
      if (instance.start case final value?) 'Start': value,
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
      if (instance.artist case final value?) 'Artist': value,
      if (instance.album case final value?) 'Album': value,
      if (instance.title case final value?) 'Title': value,
      if (instance.author case final value?) 'Author': value,
      if (instance.length case final value?) 'Length': value,
      if (instance.by case final value?) 'By': value,
      if (instance.offset case final value?) 'Offset': value,
      if (instance.creator case final value?) 'Creator': value,
      if (instance.version case final value?) 'Version': value,
      if (instance.isSynced case final value?) 'IsSynced': value,
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
      if (instance.codec case final value?) 'Codec': value,
      if (instance.codecTag case final value?) 'CodecTag': value,
      if (instance.comment case final value?) 'Comment': value,
      if (instance.index case final value?) 'Index': value,
      if (instance.fileName case final value?) 'FileName': value,
      if (instance.mimeType case final value?) 'MimeType': value,
      if (instance.deliveryUrl case final value?) 'DeliveryUrl': value,
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
      if (instance.path case final value?) 'Path': value,
      if (instance.pathInfo?.toJson() case final value?) 'PathInfo': value,
    };

MediaPathInfo _$MediaPathInfoFromJson(Map<String, dynamic> json) =>
    MediaPathInfo(
      path: json['Path'] as String?,
    );

Map<String, dynamic> _$MediaPathInfoToJson(MediaPathInfo instance) =>
    <String, dynamic>{
      if (instance.path case final value?) 'Path': value,
    };

MediaSegmentDto _$MediaSegmentDtoFromJson(Map<String, dynamic> json) =>
    MediaSegmentDto(
      id: json['Id'] as String?,
      itemId: json['ItemId'] as String?,
      type: mediaSegmentTypeNullableFromJson(json['Type']),
      startTicks: (json['StartTicks'] as num?)?.toInt(),
      endTicks: (json['EndTicks'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MediaSegmentDtoToJson(MediaSegmentDto instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'Id': value,
      if (instance.itemId case final value?) 'ItemId': value,
      if (mediaSegmentTypeNullableToJson(instance.type) case final value?)
        'Type': value,
      if (instance.startTicks case final value?) 'StartTicks': value,
      if (instance.endTicks case final value?) 'EndTicks': value,
    };

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
        MediaSegmentDtoQueryResult instance) =>
    <String, dynamic>{
      if (instance.items?.map((e) => e.toJson()).toList() case final value?)
        'Items': value,
      if (instance.totalRecordCount case final value?)
        'TotalRecordCount': value,
      if (instance.startIndex case final value?) 'StartIndex': value,
    };

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

Map<String, dynamic> _$MediaSourceInfoToJson(MediaSourceInfo instance) =>
    <String, dynamic>{
      if (mediaProtocolNullableToJson(instance.protocol) case final value?)
        'Protocol': value,
      if (instance.id case final value?) 'Id': value,
      if (instance.path case final value?) 'Path': value,
      if (instance.encoderPath case final value?) 'EncoderPath': value,
      if (mediaProtocolNullableToJson(instance.encoderProtocol)
          case final value?)
        'EncoderProtocol': value,
      if (mediaSourceTypeNullableToJson(instance.type) case final value?)
        'Type': value,
      if (instance.container case final value?) 'Container': value,
      if (instance.size case final value?) 'Size': value,
      if (instance.name case final value?) 'Name': value,
      if (instance.isRemote case final value?) 'IsRemote': value,
      if (instance.eTag case final value?) 'ETag': value,
      if (instance.runTimeTicks case final value?) 'RunTimeTicks': value,
      if (instance.readAtNativeFramerate case final value?)
        'ReadAtNativeFramerate': value,
      if (instance.ignoreDts case final value?) 'IgnoreDts': value,
      if (instance.ignoreIndex case final value?) 'IgnoreIndex': value,
      if (instance.genPtsInput case final value?) 'GenPtsInput': value,
      if (instance.supportsTranscoding case final value?)
        'SupportsTranscoding': value,
      if (instance.supportsDirectStream case final value?)
        'SupportsDirectStream': value,
      if (instance.supportsDirectPlay case final value?)
        'SupportsDirectPlay': value,
      if (instance.isInfiniteStream case final value?)
        'IsInfiniteStream': value,
      if (instance.useMostCompatibleTranscodingProfile case final value?)
        'UseMostCompatibleTranscodingProfile': value,
      if (instance.requiresOpening case final value?) 'RequiresOpening': value,
      if (instance.openToken case final value?) 'OpenToken': value,
      if (instance.requiresClosing case final value?) 'RequiresClosing': value,
      if (instance.liveStreamId case final value?) 'LiveStreamId': value,
      if (instance.bufferMs case final value?) 'BufferMs': value,
      if (instance.requiresLooping case final value?) 'RequiresLooping': value,
      if (instance.supportsProbing case final value?) 'SupportsProbing': value,
      if (videoTypeNullableToJson(instance.videoType) case final value?)
        'VideoType': value,
      if (isoTypeNullableToJson(instance.isoType) case final value?)
        'IsoType': value,
      if (video3DFormatNullableToJson(instance.video3DFormat) case final value?)
        'Video3DFormat': value,
      if (instance.mediaStreams?.map((e) => e.toJson()).toList()
          case final value?)
        'MediaStreams': value,
      if (instance.mediaAttachments?.map((e) => e.toJson()).toList()
          case final value?)
        'MediaAttachments': value,
      if (instance.formats case final value?) 'Formats': value,
      if (instance.bitrate case final value?) 'Bitrate': value,
      if (instance.fallbackMaxStreamingBitrate case final value?)
        'FallbackMaxStreamingBitrate': value,
      if (transportStreamTimestampNullableToJson(instance.timestamp)
          case final value?)
        'Timestamp': value,
      if (instance.requiredHttpHeaders case final value?)
        'RequiredHttpHeaders': value,
      if (instance.transcodingUrl case final value?) 'TranscodingUrl': value,
      if (mediaStreamProtocolNullableToJson(instance.transcodingSubProtocol)
          case final value?)
        'TranscodingSubProtocol': value,
      if (instance.transcodingContainer case final value?)
        'TranscodingContainer': value,
      if (instance.analyzeDurationMs case final value?)
        'AnalyzeDurationMs': value,
      if (instance.defaultAudioStreamIndex case final value?)
        'DefaultAudioStreamIndex': value,
      if (instance.defaultSubtitleStreamIndex case final value?)
        'DefaultSubtitleStreamIndex': value,
      if (instance.hasSegments case final value?) 'HasSegments': value,
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

Map<String, dynamic> _$MediaStreamToJson(MediaStream instance) =>
    <String, dynamic>{
      if (instance.codec case final value?) 'Codec': value,
      if (instance.codecTag case final value?) 'CodecTag': value,
      if (instance.language case final value?) 'Language': value,
      if (instance.colorRange case final value?) 'ColorRange': value,
      if (instance.colorSpace case final value?) 'ColorSpace': value,
      if (instance.colorTransfer case final value?) 'ColorTransfer': value,
      if (instance.colorPrimaries case final value?) 'ColorPrimaries': value,
      if (instance.dvVersionMajor case final value?) 'DvVersionMajor': value,
      if (instance.dvVersionMinor case final value?) 'DvVersionMinor': value,
      if (instance.dvProfile case final value?) 'DvProfile': value,
      if (instance.dvLevel case final value?) 'DvLevel': value,
      if (instance.rpuPresentFlag case final value?) 'RpuPresentFlag': value,
      if (instance.elPresentFlag case final value?) 'ElPresentFlag': value,
      if (instance.blPresentFlag case final value?) 'BlPresentFlag': value,
      if (instance.dvBlSignalCompatibilityId case final value?)
        'DvBlSignalCompatibilityId': value,
      if (instance.rotation case final value?) 'Rotation': value,
      if (instance.comment case final value?) 'Comment': value,
      if (instance.timeBase case final value?) 'TimeBase': value,
      if (instance.codecTimeBase case final value?) 'CodecTimeBase': value,
      if (instance.title case final value?) 'Title': value,
      if (videoRangeNullableToJson(instance.videoRange) case final value?)
        'VideoRange': value,
      if (videoRangeTypeNullableToJson(instance.videoRangeType)
          case final value?)
        'VideoRangeType': value,
      if (instance.videoDoViTitle case final value?) 'VideoDoViTitle': value,
      if (audioSpatialFormatNullableToJson(instance.audioSpatialFormat)
          case final value?)
        'AudioSpatialFormat': value,
      if (instance.localizedUndefined case final value?)
        'LocalizedUndefined': value,
      if (instance.localizedDefault case final value?)
        'LocalizedDefault': value,
      if (instance.localizedForced case final value?) 'LocalizedForced': value,
      if (instance.localizedExternal case final value?)
        'LocalizedExternal': value,
      if (instance.localizedHearingImpaired case final value?)
        'LocalizedHearingImpaired': value,
      if (instance.displayTitle case final value?) 'DisplayTitle': value,
      if (instance.nalLengthSize case final value?) 'NalLengthSize': value,
      if (instance.isInterlaced case final value?) 'IsInterlaced': value,
      if (instance.isAVC case final value?) 'IsAVC': value,
      if (instance.channelLayout case final value?) 'ChannelLayout': value,
      if (instance.bitRate case final value?) 'BitRate': value,
      if (instance.bitDepth case final value?) 'BitDepth': value,
      if (instance.refFrames case final value?) 'RefFrames': value,
      if (instance.packetLength case final value?) 'PacketLength': value,
      if (instance.channels case final value?) 'Channels': value,
      if (instance.sampleRate case final value?) 'SampleRate': value,
      if (instance.isDefault case final value?) 'IsDefault': value,
      if (instance.isForced case final value?) 'IsForced': value,
      if (instance.isHearingImpaired case final value?)
        'IsHearingImpaired': value,
      if (instance.height case final value?) 'Height': value,
      if (instance.width case final value?) 'Width': value,
      if (instance.averageFrameRate case final value?)
        'AverageFrameRate': value,
      if (instance.realFrameRate case final value?) 'RealFrameRate': value,
      if (instance.referenceFrameRate case final value?)
        'ReferenceFrameRate': value,
      if (instance.profile case final value?) 'Profile': value,
      if (mediaStreamTypeNullableToJson(instance.type) case final value?)
        'Type': value,
      if (instance.aspectRatio case final value?) 'AspectRatio': value,
      if (instance.index case final value?) 'Index': value,
      if (instance.score case final value?) 'Score': value,
      if (instance.isExternal case final value?) 'IsExternal': value,
      if (subtitleDeliveryMethodNullableToJson(instance.deliveryMethod)
          case final value?)
        'DeliveryMethod': value,
      if (instance.deliveryUrl case final value?) 'DeliveryUrl': value,
      if (instance.isExternalUrl case final value?) 'IsExternalUrl': value,
      if (instance.isTextSubtitleStream case final value?)
        'IsTextSubtitleStream': value,
      if (instance.supportsExternalStream case final value?)
        'SupportsExternalStream': value,
      if (instance.path case final value?) 'Path': value,
      if (instance.pixelFormat case final value?) 'PixelFormat': value,
      if (instance.level case final value?) 'Level': value,
      if (instance.isAnamorphic case final value?) 'IsAnamorphic': value,
    };

MediaUpdateInfoDto _$MediaUpdateInfoDtoFromJson(Map<String, dynamic> json) =>
    MediaUpdateInfoDto(
      updates: (json['Updates'] as List<dynamic>?)
              ?.map((e) =>
                  MediaUpdateInfoPathDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$MediaUpdateInfoDtoToJson(MediaUpdateInfoDto instance) =>
    <String, dynamic>{
      if (instance.updates?.map((e) => e.toJson()).toList() case final value?)
        'Updates': value,
    };

MediaUpdateInfoPathDto _$MediaUpdateInfoPathDtoFromJson(
        Map<String, dynamic> json) =>
    MediaUpdateInfoPathDto(
      path: json['Path'] as String?,
      updateType: json['UpdateType'] as String?,
    );

Map<String, dynamic> _$MediaUpdateInfoPathDtoToJson(
        MediaUpdateInfoPathDto instance) =>
    <String, dynamic>{
      if (instance.path case final value?) 'Path': value,
      if (instance.updateType case final value?) 'UpdateType': value,
    };

MediaUrl _$MediaUrlFromJson(Map<String, dynamic> json) => MediaUrl(
      url: json['Url'] as String?,
      name: json['Name'] as String?,
    );

Map<String, dynamic> _$MediaUrlToJson(MediaUrl instance) => <String, dynamic>{
      if (instance.url case final value?) 'Url': value,
      if (instance.name case final value?) 'Name': value,
    };

MessageCommand _$MessageCommandFromJson(Map<String, dynamic> json) =>
    MessageCommand(
      header: json['Header'] as String?,
      text: json['Text'] as String,
      timeoutMs: (json['TimeoutMs'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MessageCommandToJson(MessageCommand instance) =>
    <String, dynamic>{
      if (instance.header case final value?) 'Header': value,
      'Text': instance.text,
      if (instance.timeoutMs case final value?) 'TimeoutMs': value,
    };

MetadataConfiguration _$MetadataConfigurationFromJson(
        Map<String, dynamic> json) =>
    MetadataConfiguration(
      useFileCreationTimeForDateAdded:
          json['UseFileCreationTimeForDateAdded'] as bool?,
    );

Map<String, dynamic> _$MetadataConfigurationToJson(
        MetadataConfiguration instance) =>
    <String, dynamic>{
      if (instance.useFileCreationTimeForDateAdded case final value?)
        'UseFileCreationTimeForDateAdded': value,
    };

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

Map<String, dynamic> _$MetadataEditorInfoToJson(MetadataEditorInfo instance) =>
    <String, dynamic>{
      if (instance.parentalRatingOptions?.map((e) => e.toJson()).toList()
          case final value?)
        'ParentalRatingOptions': value,
      if (instance.countries?.map((e) => e.toJson()).toList() case final value?)
        'Countries': value,
      if (instance.cultures?.map((e) => e.toJson()).toList() case final value?)
        'Cultures': value,
      if (instance.externalIdInfos?.map((e) => e.toJson()).toList()
          case final value?)
        'ExternalIdInfos': value,
      if (collectionTypeNullableToJson(instance.contentType) case final value?)
        'ContentType': value,
      if (instance.contentTypeOptions?.map((e) => e.toJson()).toList()
          case final value?)
        'ContentTypeOptions': value,
    };

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

Map<String, dynamic> _$MetadataOptionsToJson(MetadataOptions instance) =>
    <String, dynamic>{
      if (instance.itemType case final value?) 'ItemType': value,
      if (instance.disabledMetadataSavers case final value?)
        'DisabledMetadataSavers': value,
      if (instance.localMetadataReaderOrder case final value?)
        'LocalMetadataReaderOrder': value,
      if (instance.disabledMetadataFetchers case final value?)
        'DisabledMetadataFetchers': value,
      if (instance.metadataFetcherOrder case final value?)
        'MetadataFetcherOrder': value,
      if (instance.disabledImageFetchers case final value?)
        'DisabledImageFetchers': value,
      if (instance.imageFetcherOrder case final value?)
        'ImageFetcherOrder': value,
    };

MovePlaylistItemRequestDto _$MovePlaylistItemRequestDtoFromJson(
        Map<String, dynamic> json) =>
    MovePlaylistItemRequestDto(
      playlistItemId: json['PlaylistItemId'] as String?,
      newIndex: (json['NewIndex'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MovePlaylistItemRequestDtoToJson(
        MovePlaylistItemRequestDto instance) =>
    <String, dynamic>{
      if (instance.playlistItemId case final value?) 'PlaylistItemId': value,
      if (instance.newIndex case final value?) 'NewIndex': value,
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
      if (instance.name case final value?) 'Name': value,
      if (instance.originalTitle case final value?) 'OriginalTitle': value,
      if (instance.path case final value?) 'Path': value,
      if (instance.metadataLanguage case final value?)
        'MetadataLanguage': value,
      if (instance.metadataCountryCode case final value?)
        'MetadataCountryCode': value,
      if (instance.providerIds case final value?) 'ProviderIds': value,
      if (instance.year case final value?) 'Year': value,
      if (instance.indexNumber case final value?) 'IndexNumber': value,
      if (instance.parentIndexNumber case final value?)
        'ParentIndexNumber': value,
      if (instance.premiereDate?.toIso8601String() case final value?)
        'PremiereDate': value,
      if (instance.isAutomated case final value?) 'IsAutomated': value,
    };

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
        MovieInfoRemoteSearchQuery instance) =>
    <String, dynamic>{
      if (instance.searchInfo?.toJson() case final value?) 'SearchInfo': value,
      if (instance.itemId case final value?) 'ItemId': value,
      if (instance.searchProviderName case final value?)
        'SearchProviderName': value,
      if (instance.includeDisabledProviders case final value?)
        'IncludeDisabledProviders': value,
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
      artists: (json['Artists'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$MusicVideoInfoToJson(MusicVideoInfo instance) =>
    <String, dynamic>{
      if (instance.name case final value?) 'Name': value,
      if (instance.originalTitle case final value?) 'OriginalTitle': value,
      if (instance.path case final value?) 'Path': value,
      if (instance.metadataLanguage case final value?)
        'MetadataLanguage': value,
      if (instance.metadataCountryCode case final value?)
        'MetadataCountryCode': value,
      if (instance.providerIds case final value?) 'ProviderIds': value,
      if (instance.year case final value?) 'Year': value,
      if (instance.indexNumber case final value?) 'IndexNumber': value,
      if (instance.parentIndexNumber case final value?)
        'ParentIndexNumber': value,
      if (instance.premiereDate?.toIso8601String() case final value?)
        'PremiereDate': value,
      if (instance.isAutomated case final value?) 'IsAutomated': value,
      if (instance.artists case final value?) 'Artists': value,
    };

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
        MusicVideoInfoRemoteSearchQuery instance) =>
    <String, dynamic>{
      if (instance.searchInfo?.toJson() case final value?) 'SearchInfo': value,
      if (instance.itemId case final value?) 'ItemId': value,
      if (instance.searchProviderName case final value?)
        'SearchProviderName': value,
      if (instance.includeDisabledProviders case final value?)
        'IncludeDisabledProviders': value,
    };

NameGuidPair _$NameGuidPairFromJson(Map<String, dynamic> json) => NameGuidPair(
      name: json['Name'] as String?,
      id: json['Id'] as String?,
    );

Map<String, dynamic> _$NameGuidPairToJson(NameGuidPair instance) =>
    <String, dynamic>{
      if (instance.name case final value?) 'Name': value,
      if (instance.id case final value?) 'Id': value,
    };

NameIdPair _$NameIdPairFromJson(Map<String, dynamic> json) => NameIdPair(
      name: json['Name'] as String?,
      id: json['Id'] as String?,
    );

Map<String, dynamic> _$NameIdPairToJson(NameIdPair instance) =>
    <String, dynamic>{
      if (instance.name case final value?) 'Name': value,
      if (instance.id case final value?) 'Id': value,
    };

NameValuePair _$NameValuePairFromJson(Map<String, dynamic> json) =>
    NameValuePair(
      name: json['Name'] as String?,
      $Value: json['Value'] as String?,
    );

Map<String, dynamic> _$NameValuePairToJson(NameValuePair instance) =>
    <String, dynamic>{
      if (instance.name case final value?) 'Name': value,
      if (instance.$Value case final value?) 'Value': value,
    };

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
        NetworkConfiguration instance) =>
    <String, dynamic>{
      if (instance.baseUrl case final value?) 'BaseUrl': value,
      if (instance.enableHttps case final value?) 'EnableHttps': value,
      if (instance.requireHttps case final value?) 'RequireHttps': value,
      if (instance.certificatePath case final value?) 'CertificatePath': value,
      if (instance.certificatePassword case final value?)
        'CertificatePassword': value,
      if (instance.internalHttpPort case final value?)
        'InternalHttpPort': value,
      if (instance.internalHttpsPort case final value?)
        'InternalHttpsPort': value,
      if (instance.publicHttpPort case final value?) 'PublicHttpPort': value,
      if (instance.publicHttpsPort case final value?) 'PublicHttpsPort': value,
      if (instance.autoDiscovery case final value?) 'AutoDiscovery': value,
      if (instance.enableUPnP case final value?) 'EnableUPnP': value,
      if (instance.enableIPv4 case final value?) 'EnableIPv4': value,
      if (instance.enableIPv6 case final value?) 'EnableIPv6': value,
      if (instance.enableRemoteAccess case final value?)
        'EnableRemoteAccess': value,
      if (instance.localNetworkSubnets case final value?)
        'LocalNetworkSubnets': value,
      if (instance.localNetworkAddresses case final value?)
        'LocalNetworkAddresses': value,
      if (instance.knownProxies case final value?) 'KnownProxies': value,
      if (instance.ignoreVirtualInterfaces case final value?)
        'IgnoreVirtualInterfaces': value,
      if (instance.virtualInterfaceNames case final value?)
        'VirtualInterfaceNames': value,
      if (instance.enablePublishedServerUriByRequest case final value?)
        'EnablePublishedServerUriByRequest': value,
      if (instance.publishedServerUriBySubnet case final value?)
        'PublishedServerUriBySubnet': value,
      if (instance.remoteIPFilter case final value?) 'RemoteIPFilter': value,
      if (instance.isRemoteIPFilterBlacklist case final value?)
        'IsRemoteIPFilterBlacklist': value,
    };

NewGroupRequestDto _$NewGroupRequestDtoFromJson(Map<String, dynamic> json) =>
    NewGroupRequestDto(
      groupName: json['GroupName'] as String?,
    );

Map<String, dynamic> _$NewGroupRequestDtoToJson(NewGroupRequestDto instance) =>
    <String, dynamic>{
      if (instance.groupName case final value?) 'GroupName': value,
    };

NextItemRequestDto _$NextItemRequestDtoFromJson(Map<String, dynamic> json) =>
    NextItemRequestDto(
      playlistItemId: json['PlaylistItemId'] as String?,
    );

Map<String, dynamic> _$NextItemRequestDtoToJson(NextItemRequestDto instance) =>
    <String, dynamic>{
      if (instance.playlistItemId case final value?) 'PlaylistItemId': value,
    };

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

Map<String, dynamic> _$OpenLiveStreamDtoToJson(OpenLiveStreamDto instance) =>
    <String, dynamic>{
      if (instance.openToken case final value?) 'OpenToken': value,
      if (instance.userId case final value?) 'UserId': value,
      if (instance.playSessionId case final value?) 'PlaySessionId': value,
      if (instance.maxStreamingBitrate case final value?)
        'MaxStreamingBitrate': value,
      if (instance.startTimeTicks case final value?) 'StartTimeTicks': value,
      if (instance.audioStreamIndex case final value?)
        'AudioStreamIndex': value,
      if (instance.subtitleStreamIndex case final value?)
        'SubtitleStreamIndex': value,
      if (instance.maxAudioChannels case final value?)
        'MaxAudioChannels': value,
      if (instance.itemId case final value?) 'ItemId': value,
      if (instance.enableDirectPlay case final value?)
        'EnableDirectPlay': value,
      if (instance.enableDirectStream case final value?)
        'EnableDirectStream': value,
      if (instance.alwaysBurnInSubtitleWhenTranscoding case final value?)
        'AlwaysBurnInSubtitleWhenTranscoding': value,
      if (instance.deviceProfile?.toJson() case final value?)
        'DeviceProfile': value,
      'DirectPlayProtocols':
          mediaProtocolListToJson(instance.directPlayProtocols),
    };

OutboundKeepAliveMessage _$OutboundKeepAliveMessageFromJson(
        Map<String, dynamic> json) =>
    OutboundKeepAliveMessage(
      messageId: json['MessageId'] as String?,
      messageType: OutboundKeepAliveMessage
          .sessionMessageTypeMessageTypeNullableFromJson(json['MessageType']),
    );

Map<String, dynamic> _$OutboundKeepAliveMessageToJson(
        OutboundKeepAliveMessage instance) =>
    <String, dynamic>{
      if (instance.messageId case final value?) 'MessageId': value,
      if (sessionMessageTypeNullableToJson(instance.messageType)
          case final value?)
        'MessageType': value,
    };

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

Map<String, dynamic> _$PackageInfoToJson(PackageInfo instance) =>
    <String, dynamic>{
      if (instance.name case final value?) 'name': value,
      if (instance.description case final value?) 'description': value,
      if (instance.overview case final value?) 'overview': value,
      if (instance.owner case final value?) 'owner': value,
      if (instance.category case final value?) 'category': value,
      if (instance.guid case final value?) 'guid': value,
      if (instance.versions?.map((e) => e.toJson()).toList() case final value?)
        'versions': value,
      if (instance.imageUrl case final value?) 'imageUrl': value,
    };

ParentalRating _$ParentalRatingFromJson(Map<String, dynamic> json) =>
    ParentalRating(
      name: json['Name'] as String?,
      $Value: (json['Value'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ParentalRatingToJson(ParentalRating instance) =>
    <String, dynamic>{
      if (instance.name case final value?) 'Name': value,
      if (instance.$Value case final value?) 'Value': value,
    };

PathSubstitution _$PathSubstitutionFromJson(Map<String, dynamic> json) =>
    PathSubstitution(
      from: json['From'] as String?,
      to: json['To'] as String?,
    );

Map<String, dynamic> _$PathSubstitutionToJson(PathSubstitution instance) =>
    <String, dynamic>{
      if (instance.from case final value?) 'From': value,
      if (instance.to case final value?) 'To': value,
    };

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
      if (instance.name case final value?) 'Name': value,
      if (instance.originalTitle case final value?) 'OriginalTitle': value,
      if (instance.path case final value?) 'Path': value,
      if (instance.metadataLanguage case final value?)
        'MetadataLanguage': value,
      if (instance.metadataCountryCode case final value?)
        'MetadataCountryCode': value,
      if (instance.providerIds case final value?) 'ProviderIds': value,
      if (instance.year case final value?) 'Year': value,
      if (instance.indexNumber case final value?) 'IndexNumber': value,
      if (instance.parentIndexNumber case final value?)
        'ParentIndexNumber': value,
      if (instance.premiereDate?.toIso8601String() case final value?)
        'PremiereDate': value,
      if (instance.isAutomated case final value?) 'IsAutomated': value,
    };

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
        PersonLookupInfoRemoteSearchQuery instance) =>
    <String, dynamic>{
      if (instance.searchInfo?.toJson() case final value?) 'SearchInfo': value,
      if (instance.itemId case final value?) 'ItemId': value,
      if (instance.searchProviderName case final value?)
        'SearchProviderName': value,
      if (instance.includeDisabledProviders case final value?)
        'IncludeDisabledProviders': value,
    };

PingRequestDto _$PingRequestDtoFromJson(Map<String, dynamic> json) =>
    PingRequestDto(
      ping: (json['Ping'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PingRequestDtoToJson(PingRequestDto instance) =>
    <String, dynamic>{
      if (instance.ping case final value?) 'Ping': value,
    };

PinRedeemResult _$PinRedeemResultFromJson(Map<String, dynamic> json) =>
    PinRedeemResult(
      success: json['Success'] as bool?,
      usersReset: (json['UsersReset'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$PinRedeemResultToJson(PinRedeemResult instance) =>
    <String, dynamic>{
      if (instance.success case final value?) 'Success': value,
      if (instance.usersReset case final value?) 'UsersReset': value,
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

Map<String, dynamic> _$PlaybackInfoDtoToJson(PlaybackInfoDto instance) =>
    <String, dynamic>{
      if (instance.userId case final value?) 'UserId': value,
      if (instance.maxStreamingBitrate case final value?)
        'MaxStreamingBitrate': value,
      if (instance.startTimeTicks case final value?) 'StartTimeTicks': value,
      if (instance.audioStreamIndex case final value?)
        'AudioStreamIndex': value,
      if (instance.subtitleStreamIndex case final value?)
        'SubtitleStreamIndex': value,
      if (instance.maxAudioChannels case final value?)
        'MaxAudioChannels': value,
      if (instance.mediaSourceId case final value?) 'MediaSourceId': value,
      if (instance.liveStreamId case final value?) 'LiveStreamId': value,
      if (instance.deviceProfile?.toJson() case final value?)
        'DeviceProfile': value,
      if (instance.enableDirectPlay case final value?)
        'EnableDirectPlay': value,
      if (instance.enableDirectStream case final value?)
        'EnableDirectStream': value,
      if (instance.enableTranscoding case final value?)
        'EnableTranscoding': value,
      if (instance.allowVideoStreamCopy case final value?)
        'AllowVideoStreamCopy': value,
      if (instance.allowAudioStreamCopy case final value?)
        'AllowAudioStreamCopy': value,
      if (instance.autoOpenLiveStream case final value?)
        'AutoOpenLiveStream': value,
      if (instance.alwaysBurnInSubtitleWhenTranscoding case final value?)
        'AlwaysBurnInSubtitleWhenTranscoding': value,
    };

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
        PlaybackInfoResponse instance) =>
    <String, dynamic>{
      if (instance.mediaSources?.map((e) => e.toJson()).toList()
          case final value?)
        'MediaSources': value,
      if (instance.playSessionId case final value?) 'PlaySessionId': value,
      if (playbackErrorCodeNullableToJson(instance.errorCode) case final value?)
        'ErrorCode': value,
    };

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
        PlaybackProgressInfo instance) =>
    <String, dynamic>{
      if (instance.canSeek case final value?) 'CanSeek': value,
      if (instance.item?.toJson() case final value?) 'Item': value,
      if (instance.itemId case final value?) 'ItemId': value,
      if (instance.sessionId case final value?) 'SessionId': value,
      if (instance.mediaSourceId case final value?) 'MediaSourceId': value,
      if (instance.audioStreamIndex case final value?)
        'AudioStreamIndex': value,
      if (instance.subtitleStreamIndex case final value?)
        'SubtitleStreamIndex': value,
      if (instance.isPaused case final value?) 'IsPaused': value,
      if (instance.isMuted case final value?) 'IsMuted': value,
      if (instance.positionTicks case final value?) 'PositionTicks': value,
      if (instance.playbackStartTimeTicks case final value?)
        'PlaybackStartTimeTicks': value,
      if (instance.volumeLevel case final value?) 'VolumeLevel': value,
      if (instance.brightness case final value?) 'Brightness': value,
      if (instance.aspectRatio case final value?) 'AspectRatio': value,
      if (playMethodNullableToJson(instance.playMethod) case final value?)
        'PlayMethod': value,
      if (instance.liveStreamId case final value?) 'LiveStreamId': value,
      if (instance.playSessionId case final value?) 'PlaySessionId': value,
      if (repeatModeNullableToJson(instance.repeatMode) case final value?)
        'RepeatMode': value,
      if (playbackOrderNullableToJson(instance.playbackOrder) case final value?)
        'PlaybackOrder': value,
      if (instance.nowPlayingQueue?.map((e) => e.toJson()).toList()
          case final value?)
        'NowPlayingQueue': value,
      if (instance.playlistItemId case final value?) 'PlaylistItemId': value,
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
      nowPlayingQueue: (json['NowPlayingQueue'] as List<dynamic>?)
              ?.map((e) => QueueItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      playlistItemId: json['PlaylistItemId'] as String?,
    );

Map<String, dynamic> _$PlaybackStartInfoToJson(PlaybackStartInfo instance) =>
    <String, dynamic>{
      if (instance.canSeek case final value?) 'CanSeek': value,
      if (instance.item?.toJson() case final value?) 'Item': value,
      if (instance.itemId case final value?) 'ItemId': value,
      if (instance.sessionId case final value?) 'SessionId': value,
      if (instance.mediaSourceId case final value?) 'MediaSourceId': value,
      if (instance.audioStreamIndex case final value?)
        'AudioStreamIndex': value,
      if (instance.subtitleStreamIndex case final value?)
        'SubtitleStreamIndex': value,
      if (instance.isPaused case final value?) 'IsPaused': value,
      if (instance.isMuted case final value?) 'IsMuted': value,
      if (instance.positionTicks case final value?) 'PositionTicks': value,
      if (instance.playbackStartTimeTicks case final value?)
        'PlaybackStartTimeTicks': value,
      if (instance.volumeLevel case final value?) 'VolumeLevel': value,
      if (instance.brightness case final value?) 'Brightness': value,
      if (instance.aspectRatio case final value?) 'AspectRatio': value,
      if (playMethodNullableToJson(instance.playMethod) case final value?)
        'PlayMethod': value,
      if (instance.liveStreamId case final value?) 'LiveStreamId': value,
      if (instance.playSessionId case final value?) 'PlaySessionId': value,
      if (repeatModeNullableToJson(instance.repeatMode) case final value?)
        'RepeatMode': value,
      if (playbackOrderNullableToJson(instance.playbackOrder) case final value?)
        'PlaybackOrder': value,
      if (instance.nowPlayingQueue?.map((e) => e.toJson()).toList()
          case final value?)
        'NowPlayingQueue': value,
      if (instance.playlistItemId case final value?) 'PlaylistItemId': value,
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
      nowPlayingQueue: (json['NowPlayingQueue'] as List<dynamic>?)
              ?.map((e) => QueueItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$PlaybackStopInfoToJson(PlaybackStopInfo instance) =>
    <String, dynamic>{
      if (instance.item?.toJson() case final value?) 'Item': value,
      if (instance.itemId case final value?) 'ItemId': value,
      if (instance.sessionId case final value?) 'SessionId': value,
      if (instance.mediaSourceId case final value?) 'MediaSourceId': value,
      if (instance.positionTicks case final value?) 'PositionTicks': value,
      if (instance.liveStreamId case final value?) 'LiveStreamId': value,
      if (instance.playSessionId case final value?) 'PlaySessionId': value,
      if (instance.failed case final value?) 'Failed': value,
      if (instance.nextMediaType case final value?) 'NextMediaType': value,
      if (instance.playlistItemId case final value?) 'PlaylistItemId': value,
      if (instance.nowPlayingQueue?.map((e) => e.toJson()).toList()
          case final value?)
        'NowPlayingQueue': value,
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
      if (instance.positionTicks case final value?) 'PositionTicks': value,
      if (instance.canSeek case final value?) 'CanSeek': value,
      if (instance.isPaused case final value?) 'IsPaused': value,
      if (instance.isMuted case final value?) 'IsMuted': value,
      if (instance.volumeLevel case final value?) 'VolumeLevel': value,
      if (instance.audioStreamIndex case final value?)
        'AudioStreamIndex': value,
      if (instance.subtitleStreamIndex case final value?)
        'SubtitleStreamIndex': value,
      if (instance.mediaSourceId case final value?) 'MediaSourceId': value,
      if (playMethodNullableToJson(instance.playMethod) case final value?)
        'PlayMethod': value,
      if (repeatModeNullableToJson(instance.repeatMode) case final value?)
        'RepeatMode': value,
      if (playbackOrderNullableToJson(instance.playbackOrder) case final value?)
        'PlaybackOrder': value,
      if (instance.liveStreamId case final value?) 'LiveStreamId': value,
    };

PlaylistCreationResult _$PlaylistCreationResultFromJson(
        Map<String, dynamic> json) =>
    PlaylistCreationResult(
      id: json['Id'] as String?,
    );

Map<String, dynamic> _$PlaylistCreationResultToJson(
        PlaylistCreationResult instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'Id': value,
    };

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

Map<String, dynamic> _$PlaylistDtoToJson(PlaylistDto instance) =>
    <String, dynamic>{
      if (instance.openAccess case final value?) 'OpenAccess': value,
      if (instance.shares?.map((e) => e.toJson()).toList() case final value?)
        'Shares': value,
      if (instance.itemIds case final value?) 'ItemIds': value,
    };

PlaylistUserPermissions _$PlaylistUserPermissionsFromJson(
        Map<String, dynamic> json) =>
    PlaylistUserPermissions(
      userId: json['UserId'] as String?,
      canEdit: json['CanEdit'] as bool?,
    );

Map<String, dynamic> _$PlaylistUserPermissionsToJson(
        PlaylistUserPermissions instance) =>
    <String, dynamic>{
      if (instance.userId case final value?) 'UserId': value,
      if (instance.canEdit case final value?) 'CanEdit': value,
    };

PlayMessage _$PlayMessageFromJson(Map<String, dynamic> json) => PlayMessage(
      data: json['Data'] == null
          ? null
          : PlayRequest.fromJson(json['Data'] as Map<String, dynamic>),
      messageId: json['MessageId'] as String?,
      messageType: PlayMessage.sessionMessageTypeMessageTypeNullableFromJson(
          json['MessageType']),
    );

Map<String, dynamic> _$PlayMessageToJson(PlayMessage instance) =>
    <String, dynamic>{
      if (instance.data?.toJson() case final value?) 'Data': value,
      if (instance.messageId case final value?) 'MessageId': value,
      if (sessionMessageTypeNullableToJson(instance.messageType)
          case final value?)
        'MessageType': value,
    };

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

Map<String, dynamic> _$PlayQueueUpdateToJson(PlayQueueUpdate instance) =>
    <String, dynamic>{
      if (playQueueUpdateReasonNullableToJson(instance.reason)
          case final value?)
        'Reason': value,
      if (instance.lastUpdate?.toIso8601String() case final value?)
        'LastUpdate': value,
      if (instance.playlist?.map((e) => e.toJson()).toList() case final value?)
        'Playlist': value,
      if (instance.playingItemIndex case final value?)
        'PlayingItemIndex': value,
      if (instance.startPositionTicks case final value?)
        'StartPositionTicks': value,
      if (instance.isPlaying case final value?) 'IsPlaying': value,
      if (groupShuffleModeNullableToJson(instance.shuffleMode)
          case final value?)
        'ShuffleMode': value,
      if (groupRepeatModeNullableToJson(instance.repeatMode) case final value?)
        'RepeatMode': value,
    };

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
        PlayQueueUpdateGroupUpdate instance) =>
    <String, dynamic>{
      if (instance.groupId case final value?) 'GroupId': value,
      if (groupUpdateTypeNullableToJson(instance.type) case final value?)
        'Type': value,
      if (instance.data?.toJson() case final value?) 'Data': value,
    };

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

Map<String, dynamic> _$PlayRequestToJson(PlayRequest instance) =>
    <String, dynamic>{
      if (instance.itemIds case final value?) 'ItemIds': value,
      if (instance.startPositionTicks case final value?)
        'StartPositionTicks': value,
      if (playCommandNullableToJson(instance.playCommand) case final value?)
        'PlayCommand': value,
      if (instance.controllingUserId case final value?)
        'ControllingUserId': value,
      if (instance.subtitleStreamIndex case final value?)
        'SubtitleStreamIndex': value,
      if (instance.audioStreamIndex case final value?)
        'AudioStreamIndex': value,
      if (instance.mediaSourceId case final value?) 'MediaSourceId': value,
      if (instance.startIndex case final value?) 'StartIndex': value,
    };

PlayRequestDto _$PlayRequestDtoFromJson(Map<String, dynamic> json) =>
    PlayRequestDto(
      playingQueue: (json['PlayingQueue'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      playingItemPosition: (json['PlayingItemPosition'] as num?)?.toInt(),
      startPositionTicks: (json['StartPositionTicks'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PlayRequestDtoToJson(PlayRequestDto instance) =>
    <String, dynamic>{
      if (instance.playingQueue case final value?) 'PlayingQueue': value,
      if (instance.playingItemPosition case final value?)
        'PlayingItemPosition': value,
      if (instance.startPositionTicks case final value?)
        'StartPositionTicks': value,
    };

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

Map<String, dynamic> _$PlaystateMessageToJson(PlaystateMessage instance) =>
    <String, dynamic>{
      if (instance.data?.toJson() case final value?) 'Data': value,
      if (instance.messageId case final value?) 'MessageId': value,
      if (sessionMessageTypeNullableToJson(instance.messageType)
          case final value?)
        'MessageType': value,
    };

PlaystateRequest _$PlaystateRequestFromJson(Map<String, dynamic> json) =>
    PlaystateRequest(
      command: playstateCommandNullableFromJson(json['Command']),
      seekPositionTicks: (json['SeekPositionTicks'] as num?)?.toInt(),
      controllingUserId: json['ControllingUserId'] as String?,
    );

Map<String, dynamic> _$PlaystateRequestToJson(PlaystateRequest instance) =>
    <String, dynamic>{
      if (playstateCommandNullableToJson(instance.command) case final value?)
        'Command': value,
      if (instance.seekPositionTicks case final value?)
        'SeekPositionTicks': value,
      if (instance.controllingUserId case final value?)
        'ControllingUserId': value,
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
      if (instance.name case final value?) 'Name': value,
      if (instance.version case final value?) 'Version': value,
      if (instance.configurationFileName case final value?)
        'ConfigurationFileName': value,
      if (instance.description case final value?) 'Description': value,
      if (instance.id case final value?) 'Id': value,
      if (instance.canUninstall case final value?) 'CanUninstall': value,
      if (instance.hasImage case final value?) 'HasImage': value,
      if (pluginStatusNullableToJson(instance.status) case final value?)
        'Status': value,
    };

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
        PluginInstallationCancelledMessage instance) =>
    <String, dynamic>{
      if (instance.data?.toJson() case final value?) 'Data': value,
      if (instance.messageId case final value?) 'MessageId': value,
      if (sessionMessageTypeNullableToJson(instance.messageType)
          case final value?)
        'MessageType': value,
    };

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
        PluginInstallationCompletedMessage instance) =>
    <String, dynamic>{
      if (instance.data?.toJson() case final value?) 'Data': value,
      if (instance.messageId case final value?) 'MessageId': value,
      if (sessionMessageTypeNullableToJson(instance.messageType)
          case final value?)
        'MessageType': value,
    };

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
        PluginInstallationFailedMessage instance) =>
    <String, dynamic>{
      if (instance.data?.toJson() case final value?) 'Data': value,
      if (instance.messageId case final value?) 'MessageId': value,
      if (sessionMessageTypeNullableToJson(instance.messageType)
          case final value?)
        'MessageType': value,
    };

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
        PluginInstallingMessage instance) =>
    <String, dynamic>{
      if (instance.data?.toJson() case final value?) 'Data': value,
      if (instance.messageId case final value?) 'MessageId': value,
      if (sessionMessageTypeNullableToJson(instance.messageType)
          case final value?)
        'MessageType': value,
    };

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
        PluginUninstalledMessage instance) =>
    <String, dynamic>{
      if (instance.data?.toJson() case final value?) 'Data': value,
      if (instance.messageId case final value?) 'MessageId': value,
      if (sessionMessageTypeNullableToJson(instance.messageType)
          case final value?)
        'MessageType': value,
    };

PreviousItemRequestDto _$PreviousItemRequestDtoFromJson(
        Map<String, dynamic> json) =>
    PreviousItemRequestDto(
      playlistItemId: json['PlaylistItemId'] as String?,
    );

Map<String, dynamic> _$PreviousItemRequestDtoToJson(
        PreviousItemRequestDto instance) =>
    <String, dynamic>{
      if (instance.playlistItemId case final value?) 'PlaylistItemId': value,
    };

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
      if (instance.type case final value?) 'type': value,
      if (instance.title case final value?) 'title': value,
      if (instance.status case final value?) 'status': value,
      if (instance.detail case final value?) 'detail': value,
      if (instance.instance case final value?) 'instance': value,
    };

ProfileCondition _$ProfileConditionFromJson(Map<String, dynamic> json) =>
    ProfileCondition(
      condition: profileConditionTypeNullableFromJson(json['Condition']),
      property: profileConditionValueNullableFromJson(json['Property']),
      $Value: json['Value'] as String?,
      isRequired: json['IsRequired'] as bool?,
    );

Map<String, dynamic> _$ProfileConditionToJson(ProfileCondition instance) =>
    <String, dynamic>{
      if (profileConditionTypeNullableToJson(instance.condition)
          case final value?)
        'Condition': value,
      if (profileConditionValueNullableToJson(instance.property)
          case final value?)
        'Property': value,
      if (instance.$Value case final value?) 'Value': value,
      if (instance.isRequired case final value?) 'IsRequired': value,
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
      if (instance.localAddress case final value?) 'LocalAddress': value,
      if (instance.serverName case final value?) 'ServerName': value,
      if (instance.version case final value?) 'Version': value,
      if (instance.productName case final value?) 'ProductName': value,
      if (instance.operatingSystem case final value?) 'OperatingSystem': value,
      if (instance.id case final value?) 'Id': value,
      if (instance.startupWizardCompleted case final value?)
        'StartupWizardCompleted': value,
    };

QueryFilters _$QueryFiltersFromJson(Map<String, dynamic> json) => QueryFilters(
      genres: (json['Genres'] as List<dynamic>?)
              ?.map((e) => NameGuidPair.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      tags:
          (json['Tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
    );

Map<String, dynamic> _$QueryFiltersToJson(QueryFilters instance) =>
    <String, dynamic>{
      if (instance.genres?.map((e) => e.toJson()).toList() case final value?)
        'Genres': value,
      if (instance.tags case final value?) 'Tags': value,
    };

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

Map<String, dynamic> _$QueryFiltersLegacyToJson(QueryFiltersLegacy instance) =>
    <String, dynamic>{
      if (instance.genres case final value?) 'Genres': value,
      if (instance.tags case final value?) 'Tags': value,
      if (instance.officialRatings case final value?) 'OfficialRatings': value,
      if (instance.years case final value?) 'Years': value,
    };

QueueItem _$QueueItemFromJson(Map<String, dynamic> json) => QueueItem(
      id: json['Id'] as String?,
      playlistItemId: json['PlaylistItemId'] as String?,
    );

Map<String, dynamic> _$QueueItemToJson(QueueItem instance) => <String, dynamic>{
      if (instance.id case final value?) 'Id': value,
      if (instance.playlistItemId case final value?) 'PlaylistItemId': value,
    };

QueueRequestDto _$QueueRequestDtoFromJson(Map<String, dynamic> json) =>
    QueueRequestDto(
      itemIds: (json['ItemIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      mode: groupQueueModeNullableFromJson(json['Mode']),
    );

Map<String, dynamic> _$QueueRequestDtoToJson(QueueRequestDto instance) =>
    <String, dynamic>{
      if (instance.itemIds case final value?) 'ItemIds': value,
      if (groupQueueModeNullableToJson(instance.mode) case final value?)
        'Mode': value,
    };

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

Map<String, dynamic> _$QuickConnectResultToJson(QuickConnectResult instance) =>
    <String, dynamic>{
      if (instance.authenticated case final value?) 'Authenticated': value,
      if (instance.secret case final value?) 'Secret': value,
      if (instance.code case final value?) 'Code': value,
      if (instance.deviceId case final value?) 'DeviceId': value,
      if (instance.deviceName case final value?) 'DeviceName': value,
      if (instance.appName case final value?) 'AppName': value,
      if (instance.appVersion case final value?) 'AppVersion': value,
      if (instance.dateAdded?.toIso8601String() case final value?)
        'DateAdded': value,
    };

ReadyRequestDto _$ReadyRequestDtoFromJson(Map<String, dynamic> json) =>
    ReadyRequestDto(
      when:
          json['When'] == null ? null : DateTime.parse(json['When'] as String),
      positionTicks: (json['PositionTicks'] as num?)?.toInt(),
      isPlaying: json['IsPlaying'] as bool?,
      playlistItemId: json['PlaylistItemId'] as String?,
    );

Map<String, dynamic> _$ReadyRequestDtoToJson(ReadyRequestDto instance) =>
    <String, dynamic>{
      if (instance.when?.toIso8601String() case final value?) 'When': value,
      if (instance.positionTicks case final value?) 'PositionTicks': value,
      if (instance.isPlaying case final value?) 'IsPlaying': value,
      if (instance.playlistItemId case final value?) 'PlaylistItemId': value,
    };

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

Map<String, dynamic> _$RecommendationDtoToJson(RecommendationDto instance) =>
    <String, dynamic>{
      if (instance.items?.map((e) => e.toJson()).toList() case final value?)
        'Items': value,
      if (recommendationTypeNullableToJson(instance.recommendationType)
          case final value?)
        'RecommendationType': value,
      if (instance.baselineItemName case final value?)
        'BaselineItemName': value,
      if (instance.categoryId case final value?) 'CategoryId': value,
    };

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
        RefreshProgressMessage instance) =>
    <String, dynamic>{
      if (instance.data case final value?) 'Data': value,
      if (instance.messageId case final value?) 'MessageId': value,
      if (sessionMessageTypeNullableToJson(instance.messageType)
          case final value?)
        'MessageType': value,
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
      if (instance.providerName case final value?) 'ProviderName': value,
      if (instance.url case final value?) 'Url': value,
      if (instance.thumbnailUrl case final value?) 'ThumbnailUrl': value,
      if (instance.height case final value?) 'Height': value,
      if (instance.width case final value?) 'Width': value,
      if (instance.communityRating case final value?) 'CommunityRating': value,
      if (instance.voteCount case final value?) 'VoteCount': value,
      if (instance.language case final value?) 'Language': value,
      if (imageTypeNullableToJson(instance.type) case final value?)
        'Type': value,
      if (ratingTypeNullableToJson(instance.ratingType) case final value?)
        'RatingType': value,
    };

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

Map<String, dynamic> _$RemoteImageResultToJson(RemoteImageResult instance) =>
    <String, dynamic>{
      if (instance.images?.map((e) => e.toJson()).toList() case final value?)
        'Images': value,
      if (instance.totalRecordCount case final value?)
        'TotalRecordCount': value,
      if (instance.providers case final value?) 'Providers': value,
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
      if (instance.id case final value?) 'Id': value,
      if (instance.providerName case final value?) 'ProviderName': value,
      if (instance.lyrics?.toJson() case final value?) 'Lyrics': value,
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
              json['AlbumArtist'] as Map<String, dynamic>),
      artists: (json['Artists'] as List<dynamic>?)
              ?.map(
                  (e) => RemoteSearchResult.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$RemoteSearchResultToJson(RemoteSearchResult instance) =>
    <String, dynamic>{
      if (instance.name case final value?) 'Name': value,
      if (instance.providerIds case final value?) 'ProviderIds': value,
      if (instance.productionYear case final value?) 'ProductionYear': value,
      if (instance.indexNumber case final value?) 'IndexNumber': value,
      if (instance.indexNumberEnd case final value?) 'IndexNumberEnd': value,
      if (instance.parentIndexNumber case final value?)
        'ParentIndexNumber': value,
      if (instance.premiereDate?.toIso8601String() case final value?)
        'PremiereDate': value,
      if (instance.imageUrl case final value?) 'ImageUrl': value,
      if (instance.searchProviderName case final value?)
        'SearchProviderName': value,
      if (instance.overview case final value?) 'Overview': value,
      if (instance.albumArtist?.toJson() case final value?)
        'AlbumArtist': value,
      if (instance.artists?.map((e) => e.toJson()).toList() case final value?)
        'Artists': value,
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
      if (instance.threeLetterISOLanguageName case final value?)
        'ThreeLetterISOLanguageName': value,
      if (instance.id case final value?) 'Id': value,
      if (instance.providerName case final value?) 'ProviderName': value,
      if (instance.name case final value?) 'Name': value,
      if (instance.format case final value?) 'Format': value,
      if (instance.author case final value?) 'Author': value,
      if (instance.comment case final value?) 'Comment': value,
      if (instance.dateCreated?.toIso8601String() case final value?)
        'DateCreated': value,
      if (instance.communityRating case final value?) 'CommunityRating': value,
      if (instance.frameRate case final value?) 'FrameRate': value,
      if (instance.downloadCount case final value?) 'DownloadCount': value,
      if (instance.isHashMatch case final value?) 'IsHashMatch': value,
      if (instance.aiTranslated case final value?) 'AiTranslated': value,
      if (instance.machineTranslated case final value?)
        'MachineTranslated': value,
      if (instance.forced case final value?) 'Forced': value,
      if (instance.hearingImpaired case final value?) 'HearingImpaired': value,
    };

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
        RemoveFromPlaylistRequestDto instance) =>
    <String, dynamic>{
      if (instance.playlistItemIds case final value?) 'PlaylistItemIds': value,
      if (instance.clearPlaylist case final value?) 'ClearPlaylist': value,
      if (instance.clearPlayingItem case final value?)
        'ClearPlayingItem': value,
    };

RepositoryInfo _$RepositoryInfoFromJson(Map<String, dynamic> json) =>
    RepositoryInfo(
      name: json['Name'] as String?,
      url: json['Url'] as String?,
      enabled: json['Enabled'] as bool?,
    );

Map<String, dynamic> _$RepositoryInfoToJson(RepositoryInfo instance) =>
    <String, dynamic>{
      if (instance.name case final value?) 'Name': value,
      if (instance.url case final value?) 'Url': value,
      if (instance.enabled case final value?) 'Enabled': value,
    };

RestartRequiredMessage _$RestartRequiredMessageFromJson(
        Map<String, dynamic> json) =>
    RestartRequiredMessage(
      messageId: json['MessageId'] as String?,
      messageType:
          RestartRequiredMessage.sessionMessageTypeMessageTypeNullableFromJson(
              json['MessageType']),
    );

Map<String, dynamic> _$RestartRequiredMessageToJson(
        RestartRequiredMessage instance) =>
    <String, dynamic>{
      if (instance.messageId case final value?) 'MessageId': value,
      if (sessionMessageTypeNullableToJson(instance.messageType)
          case final value?)
        'MessageType': value,
    };

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
        ScheduledTaskEndedMessage instance) =>
    <String, dynamic>{
      if (instance.data?.toJson() case final value?) 'Data': value,
      if (instance.messageId case final value?) 'MessageId': value,
      if (sessionMessageTypeNullableToJson(instance.messageType)
          case final value?)
        'MessageType': value,
    };

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
        ScheduledTasksInfoMessage instance) =>
    <String, dynamic>{
      if (instance.data?.map((e) => e.toJson()).toList() case final value?)
        'Data': value,
      if (instance.messageId case final value?) 'MessageId': value,
      if (sessionMessageTypeNullableToJson(instance.messageType)
          case final value?)
        'MessageType': value,
    };

ScheduledTasksInfoStartMessage _$ScheduledTasksInfoStartMessageFromJson(
        Map<String, dynamic> json) =>
    ScheduledTasksInfoStartMessage(
      data: json['Data'] as String?,
      messageType: ScheduledTasksInfoStartMessage
          .sessionMessageTypeMessageTypeNullableFromJson(json['MessageType']),
    );

Map<String, dynamic> _$ScheduledTasksInfoStartMessageToJson(
        ScheduledTasksInfoStartMessage instance) =>
    <String, dynamic>{
      if (instance.data case final value?) 'Data': value,
      if (sessionMessageTypeNullableToJson(instance.messageType)
          case final value?)
        'MessageType': value,
    };

ScheduledTasksInfoStopMessage _$ScheduledTasksInfoStopMessageFromJson(
        Map<String, dynamic> json) =>
    ScheduledTasksInfoStopMessage(
      messageType: ScheduledTasksInfoStopMessage
          .sessionMessageTypeMessageTypeNullableFromJson(json['MessageType']),
    );

Map<String, dynamic> _$ScheduledTasksInfoStopMessageToJson(
        ScheduledTasksInfoStopMessage instance) =>
    <String, dynamic>{
      if (sessionMessageTypeNullableToJson(instance.messageType)
          case final value?)
        'MessageType': value,
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

Map<String, dynamic> _$SearchHintToJson(SearchHint instance) =>
    <String, dynamic>{
      if (instance.itemId case final value?) 'ItemId': value,
      if (instance.id case final value?) 'Id': value,
      if (instance.name case final value?) 'Name': value,
      if (instance.matchedTerm case final value?) 'MatchedTerm': value,
      if (instance.indexNumber case final value?) 'IndexNumber': value,
      if (instance.productionYear case final value?) 'ProductionYear': value,
      if (instance.parentIndexNumber case final value?)
        'ParentIndexNumber': value,
      if (instance.primaryImageTag case final value?) 'PrimaryImageTag': value,
      if (instance.thumbImageTag case final value?) 'ThumbImageTag': value,
      if (instance.thumbImageItemId case final value?)
        'ThumbImageItemId': value,
      if (instance.backdropImageTag case final value?)
        'BackdropImageTag': value,
      if (instance.backdropImageItemId case final value?)
        'BackdropImageItemId': value,
      if (baseItemKindNullableToJson(instance.type) case final value?)
        'Type': value,
      if (instance.isFolder case final value?) 'IsFolder': value,
      if (instance.runTimeTicks case final value?) 'RunTimeTicks': value,
      if (mediaTypeNullableToJson(instance.mediaType) case final value?)
        'MediaType': value,
      if (instance.startDate?.toIso8601String() case final value?)
        'StartDate': value,
      if (instance.endDate?.toIso8601String() case final value?)
        'EndDate': value,
      if (instance.series case final value?) 'Series': value,
      if (instance.status case final value?) 'Status': value,
      if (instance.album case final value?) 'Album': value,
      if (instance.albumId case final value?) 'AlbumId': value,
      if (instance.albumArtist case final value?) 'AlbumArtist': value,
      if (instance.artists case final value?) 'Artists': value,
      if (instance.songCount case final value?) 'SongCount': value,
      if (instance.episodeCount case final value?) 'EpisodeCount': value,
      if (instance.channelId case final value?) 'ChannelId': value,
      if (instance.channelName case final value?) 'ChannelName': value,
      if (instance.primaryImageAspectRatio case final value?)
        'PrimaryImageAspectRatio': value,
    };

SearchHintResult _$SearchHintResultFromJson(Map<String, dynamic> json) =>
    SearchHintResult(
      searchHints: (json['SearchHints'] as List<dynamic>?)
              ?.map((e) => SearchHint.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      totalRecordCount: (json['TotalRecordCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SearchHintResultToJson(SearchHintResult instance) =>
    <String, dynamic>{
      if (instance.searchHints?.map((e) => e.toJson()).toList()
          case final value?)
        'SearchHints': value,
      if (instance.totalRecordCount case final value?)
        'TotalRecordCount': value,
    };

SeekRequestDto _$SeekRequestDtoFromJson(Map<String, dynamic> json) =>
    SeekRequestDto(
      positionTicks: (json['PositionTicks'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SeekRequestDtoToJson(SeekRequestDto instance) =>
    <String, dynamic>{
      if (instance.positionTicks case final value?) 'PositionTicks': value,
    };

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

Map<String, dynamic> _$SendCommandToJson(SendCommand instance) =>
    <String, dynamic>{
      if (instance.groupId case final value?) 'GroupId': value,
      if (instance.playlistItemId case final value?) 'PlaylistItemId': value,
      if (instance.when?.toIso8601String() case final value?) 'When': value,
      if (instance.positionTicks case final value?) 'PositionTicks': value,
      if (sendCommandTypeNullableToJson(instance.command) case final value?)
        'Command': value,
      if (instance.emittedAt?.toIso8601String() case final value?)
        'EmittedAt': value,
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
      if (instance.name case final value?) 'Name': value,
      if (instance.originalTitle case final value?) 'OriginalTitle': value,
      if (instance.path case final value?) 'Path': value,
      if (instance.metadataLanguage case final value?)
        'MetadataLanguage': value,
      if (instance.metadataCountryCode case final value?)
        'MetadataCountryCode': value,
      if (instance.providerIds case final value?) 'ProviderIds': value,
      if (instance.year case final value?) 'Year': value,
      if (instance.indexNumber case final value?) 'IndexNumber': value,
      if (instance.parentIndexNumber case final value?)
        'ParentIndexNumber': value,
      if (instance.premiereDate?.toIso8601String() case final value?)
        'PremiereDate': value,
      if (instance.isAutomated case final value?) 'IsAutomated': value,
    };

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
        SeriesInfoRemoteSearchQuery instance) =>
    <String, dynamic>{
      if (instance.searchInfo?.toJson() case final value?) 'SearchInfo': value,
      if (instance.itemId case final value?) 'ItemId': value,
      if (instance.searchProviderName case final value?)
        'SearchProviderName': value,
      if (instance.includeDisabledProviders case final value?)
        'IncludeDisabledProviders': value,
    };

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
        SeriesTimerCancelledMessage instance) =>
    <String, dynamic>{
      if (instance.data?.toJson() case final value?) 'Data': value,
      if (instance.messageId case final value?) 'MessageId': value,
      if (sessionMessageTypeNullableToJson(instance.messageType)
          case final value?)
        'MessageType': value,
    };

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
        SeriesTimerCreatedMessage instance) =>
    <String, dynamic>{
      if (instance.data?.toJson() case final value?) 'Data': value,
      if (instance.messageId case final value?) 'MessageId': value,
      if (sessionMessageTypeNullableToJson(instance.messageType)
          case final value?)
        'MessageType': value,
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
      if (instance.id case final value?) 'Id': value,
      if (instance.type case final value?) 'Type': value,
      if (instance.serverId case final value?) 'ServerId': value,
      if (instance.externalId case final value?) 'ExternalId': value,
      if (instance.channelId case final value?) 'ChannelId': value,
      if (instance.externalChannelId case final value?)
        'ExternalChannelId': value,
      if (instance.channelName case final value?) 'ChannelName': value,
      if (instance.channelPrimaryImageTag case final value?)
        'ChannelPrimaryImageTag': value,
      if (instance.programId case final value?) 'ProgramId': value,
      if (instance.externalProgramId case final value?)
        'ExternalProgramId': value,
      if (instance.name case final value?) 'Name': value,
      if (instance.overview case final value?) 'Overview': value,
      if (instance.startDate?.toIso8601String() case final value?)
        'StartDate': value,
      if (instance.endDate?.toIso8601String() case final value?)
        'EndDate': value,
      if (instance.serviceName case final value?) 'ServiceName': value,
      if (instance.priority case final value?) 'Priority': value,
      if (instance.prePaddingSeconds case final value?)
        'PrePaddingSeconds': value,
      if (instance.postPaddingSeconds case final value?)
        'PostPaddingSeconds': value,
      if (instance.isPrePaddingRequired case final value?)
        'IsPrePaddingRequired': value,
      if (instance.parentBackdropItemId case final value?)
        'ParentBackdropItemId': value,
      if (instance.parentBackdropImageTags case final value?)
        'ParentBackdropImageTags': value,
      if (instance.isPostPaddingRequired case final value?)
        'IsPostPaddingRequired': value,
      if (keepUntilNullableToJson(instance.keepUntil) case final value?)
        'KeepUntil': value,
      if (instance.recordAnyTime case final value?) 'RecordAnyTime': value,
      if (instance.skipEpisodesInLibrary case final value?)
        'SkipEpisodesInLibrary': value,
      if (instance.recordAnyChannel case final value?)
        'RecordAnyChannel': value,
      if (instance.keepUpTo case final value?) 'KeepUpTo': value,
      if (instance.recordNewOnly case final value?) 'RecordNewOnly': value,
      'Days': dayOfWeekListToJson(instance.days),
      if (dayPatternNullableToJson(instance.dayPattern) case final value?)
        'DayPattern': value,
      if (instance.imageTags case final value?) 'ImageTags': value,
      if (instance.parentThumbItemId case final value?)
        'ParentThumbItemId': value,
      if (instance.parentThumbImageTag case final value?)
        'ParentThumbImageTag': value,
      if (instance.parentPrimaryImageItemId case final value?)
        'ParentPrimaryImageItemId': value,
      if (instance.parentPrimaryImageTag case final value?)
        'ParentPrimaryImageTag': value,
    };

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
        SeriesTimerInfoDtoQueryResult instance) =>
    <String, dynamic>{
      if (instance.items?.map((e) => e.toJson()).toList() case final value?)
        'Items': value,
      if (instance.totalRecordCount case final value?)
        'TotalRecordCount': value,
      if (instance.startIndex case final value?) 'StartIndex': value,
    };

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

Map<String, dynamic> _$ServerConfigurationToJson(
        ServerConfiguration instance) =>
    <String, dynamic>{
      if (instance.logFileRetentionDays case final value?)
        'LogFileRetentionDays': value,
      if (instance.isStartupWizardCompleted case final value?)
        'IsStartupWizardCompleted': value,
      if (instance.cachePath case final value?) 'CachePath': value,
      if (instance.previousVersion case final value?) 'PreviousVersion': value,
      if (instance.previousVersionStr case final value?)
        'PreviousVersionStr': value,
      if (instance.enableMetrics case final value?) 'EnableMetrics': value,
      if (instance.enableNormalizedItemByNameIds case final value?)
        'EnableNormalizedItemByNameIds': value,
      if (instance.isPortAuthorized case final value?)
        'IsPortAuthorized': value,
      if (instance.quickConnectAvailable case final value?)
        'QuickConnectAvailable': value,
      if (instance.enableCaseSensitiveItemIds case final value?)
        'EnableCaseSensitiveItemIds': value,
      if (instance.disableLiveTvChannelUserDataName case final value?)
        'DisableLiveTvChannelUserDataName': value,
      if (instance.metadataPath case final value?) 'MetadataPath': value,
      if (instance.preferredMetadataLanguage case final value?)
        'PreferredMetadataLanguage': value,
      if (instance.metadataCountryCode case final value?)
        'MetadataCountryCode': value,
      if (instance.sortReplaceCharacters case final value?)
        'SortReplaceCharacters': value,
      if (instance.sortRemoveCharacters case final value?)
        'SortRemoveCharacters': value,
      if (instance.sortRemoveWords case final value?) 'SortRemoveWords': value,
      if (instance.minResumePct case final value?) 'MinResumePct': value,
      if (instance.maxResumePct case final value?) 'MaxResumePct': value,
      if (instance.minResumeDurationSeconds case final value?)
        'MinResumeDurationSeconds': value,
      if (instance.minAudiobookResume case final value?)
        'MinAudiobookResume': value,
      if (instance.maxAudiobookResume case final value?)
        'MaxAudiobookResume': value,
      if (instance.inactiveSessionThreshold case final value?)
        'InactiveSessionThreshold': value,
      if (instance.libraryMonitorDelay case final value?)
        'LibraryMonitorDelay': value,
      if (instance.libraryUpdateDuration case final value?)
        'LibraryUpdateDuration': value,
      if (imageSavingConventionNullableToJson(instance.imageSavingConvention)
          case final value?)
        'ImageSavingConvention': value,
      if (instance.metadataOptions?.map((e) => e.toJson()).toList()
          case final value?)
        'MetadataOptions': value,
      if (instance.skipDeserializationForBasicTypes case final value?)
        'SkipDeserializationForBasicTypes': value,
      if (instance.serverName case final value?) 'ServerName': value,
      if (instance.uICulture case final value?) 'UICulture': value,
      if (instance.saveMetadataHidden case final value?)
        'SaveMetadataHidden': value,
      if (instance.contentTypes?.map((e) => e.toJson()).toList()
          case final value?)
        'ContentTypes': value,
      if (instance.remoteClientBitrateLimit case final value?)
        'RemoteClientBitrateLimit': value,
      if (instance.enableFolderView case final value?)
        'EnableFolderView': value,
      if (instance.enableGroupingIntoCollections case final value?)
        'EnableGroupingIntoCollections': value,
      if (instance.displaySpecialsWithinSeasons case final value?)
        'DisplaySpecialsWithinSeasons': value,
      if (instance.codecsUsed case final value?) 'CodecsUsed': value,
      if (instance.pluginRepositories?.map((e) => e.toJson()).toList()
          case final value?)
        'PluginRepositories': value,
      if (instance.enableExternalContentInSuggestions case final value?)
        'EnableExternalContentInSuggestions': value,
      if (instance.imageExtractionTimeoutMs case final value?)
        'ImageExtractionTimeoutMs': value,
      if (instance.pathSubstitutions?.map((e) => e.toJson()).toList()
          case final value?)
        'PathSubstitutions': value,
      if (instance.enableSlowResponseWarning case final value?)
        'EnableSlowResponseWarning': value,
      if (instance.slowResponseThresholdMs case final value?)
        'SlowResponseThresholdMs': value,
      if (instance.corsHosts case final value?) 'CorsHosts': value,
      if (instance.activityLogRetentionDays case final value?)
        'ActivityLogRetentionDays': value,
      if (instance.libraryScanFanoutConcurrency case final value?)
        'LibraryScanFanoutConcurrency': value,
      if (instance.libraryMetadataRefreshConcurrency case final value?)
        'LibraryMetadataRefreshConcurrency': value,
      if (instance.removeOldPlugins case final value?)
        'RemoveOldPlugins': value,
      if (instance.allowClientLogUpload case final value?)
        'AllowClientLogUpload': value,
      if (instance.dummyChapterDuration case final value?)
        'DummyChapterDuration': value,
      if (imageResolutionNullableToJson(instance.chapterImageResolution)
          case final value?)
        'ChapterImageResolution': value,
      if (instance.parallelImageEncodingLimit case final value?)
        'ParallelImageEncodingLimit': value,
      if (instance.castReceiverApplications?.map((e) => e.toJson()).toList()
          case final value?)
        'CastReceiverApplications': value,
      if (instance.trickplayOptions?.toJson() case final value?)
        'TrickplayOptions': value,
    };

ServerDiscoveryInfo _$ServerDiscoveryInfoFromJson(Map<String, dynamic> json) =>
    ServerDiscoveryInfo(
      address: json['Address'] as String?,
      id: json['Id'] as String?,
      name: json['Name'] as String?,
      endpointAddress: json['EndpointAddress'] as String?,
    );

Map<String, dynamic> _$ServerDiscoveryInfoToJson(
        ServerDiscoveryInfo instance) =>
    <String, dynamic>{
      if (instance.address case final value?) 'Address': value,
      if (instance.id case final value?) 'Id': value,
      if (instance.name case final value?) 'Name': value,
      if (instance.endpointAddress case final value?) 'EndpointAddress': value,
    };

ServerRestartingMessage _$ServerRestartingMessageFromJson(
        Map<String, dynamic> json) =>
    ServerRestartingMessage(
      messageId: json['MessageId'] as String?,
      messageType:
          ServerRestartingMessage.sessionMessageTypeMessageTypeNullableFromJson(
              json['MessageType']),
    );

Map<String, dynamic> _$ServerRestartingMessageToJson(
        ServerRestartingMessage instance) =>
    <String, dynamic>{
      if (instance.messageId case final value?) 'MessageId': value,
      if (sessionMessageTypeNullableToJson(instance.messageType)
          case final value?)
        'MessageType': value,
    };

ServerShuttingDownMessage _$ServerShuttingDownMessageFromJson(
        Map<String, dynamic> json) =>
    ServerShuttingDownMessage(
      messageId: json['MessageId'] as String?,
      messageType: ServerShuttingDownMessage
          .sessionMessageTypeMessageTypeNullableFromJson(json['MessageType']),
    );

Map<String, dynamic> _$ServerShuttingDownMessageToJson(
        ServerShuttingDownMessage instance) =>
    <String, dynamic>{
      if (instance.messageId case final value?) 'MessageId': value,
      if (sessionMessageTypeNullableToJson(instance.messageType)
          case final value?)
        'MessageType': value,
    };

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

Map<String, dynamic> _$SessionInfoDtoToJson(SessionInfoDto instance) =>
    <String, dynamic>{
      if (instance.playState?.toJson() case final value?) 'PlayState': value,
      if (instance.additionalUsers?.map((e) => e.toJson()).toList()
          case final value?)
        'AdditionalUsers': value,
      if (instance.capabilities?.toJson() case final value?)
        'Capabilities': value,
      if (instance.remoteEndPoint case final value?) 'RemoteEndPoint': value,
      'PlayableMediaTypes': mediaTypeListToJson(instance.playableMediaTypes),
      if (instance.id case final value?) 'Id': value,
      if (instance.userId case final value?) 'UserId': value,
      if (instance.userName case final value?) 'UserName': value,
      if (instance.$Client case final value?) 'Client': value,
      if (instance.lastActivityDate?.toIso8601String() case final value?)
        'LastActivityDate': value,
      if (instance.lastPlaybackCheckIn?.toIso8601String() case final value?)
        'LastPlaybackCheckIn': value,
      if (instance.lastPausedDate?.toIso8601String() case final value?)
        'LastPausedDate': value,
      if (instance.deviceName case final value?) 'DeviceName': value,
      if (instance.deviceType case final value?) 'DeviceType': value,
      if (instance.nowPlayingItem?.toJson() case final value?)
        'NowPlayingItem': value,
      if (instance.nowViewingItem?.toJson() case final value?)
        'NowViewingItem': value,
      if (instance.deviceId case final value?) 'DeviceId': value,
      if (instance.applicationVersion case final value?)
        'ApplicationVersion': value,
      if (instance.transcodingInfo?.toJson() case final value?)
        'TranscodingInfo': value,
      if (instance.isActive case final value?) 'IsActive': value,
      if (instance.supportsMediaControl case final value?)
        'SupportsMediaControl': value,
      if (instance.supportsRemoteControl case final value?)
        'SupportsRemoteControl': value,
      if (instance.nowPlayingQueue?.map((e) => e.toJson()).toList()
          case final value?)
        'NowPlayingQueue': value,
      if (instance.nowPlayingQueueFullItems?.map((e) => e.toJson()).toList()
          case final value?)
        'NowPlayingQueueFullItems': value,
      if (instance.hasCustomDeviceName case final value?)
        'HasCustomDeviceName': value,
      if (instance.playlistItemId case final value?) 'PlaylistItemId': value,
      if (instance.serverId case final value?) 'ServerId': value,
      if (instance.userPrimaryImageTag case final value?)
        'UserPrimaryImageTag': value,
      'SupportedCommands':
          generalCommandTypeListToJson(instance.supportedCommands),
    };

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

Map<String, dynamic> _$SessionsMessageToJson(SessionsMessage instance) =>
    <String, dynamic>{
      if (instance.data?.map((e) => e.toJson()).toList() case final value?)
        'Data': value,
      if (instance.messageId case final value?) 'MessageId': value,
      if (sessionMessageTypeNullableToJson(instance.messageType)
          case final value?)
        'MessageType': value,
    };

SessionsStartMessage _$SessionsStartMessageFromJson(
        Map<String, dynamic> json) =>
    SessionsStartMessage(
      data: json['Data'] as String?,
      messageType:
          SessionsStartMessage.sessionMessageTypeMessageTypeNullableFromJson(
              json['MessageType']),
    );

Map<String, dynamic> _$SessionsStartMessageToJson(
        SessionsStartMessage instance) =>
    <String, dynamic>{
      if (instance.data case final value?) 'Data': value,
      if (sessionMessageTypeNullableToJson(instance.messageType)
          case final value?)
        'MessageType': value,
    };

SessionsStopMessage _$SessionsStopMessageFromJson(Map<String, dynamic> json) =>
    SessionsStopMessage(
      messageType:
          SessionsStopMessage.sessionMessageTypeMessageTypeNullableFromJson(
              json['MessageType']),
    );

Map<String, dynamic> _$SessionsStopMessageToJson(
        SessionsStopMessage instance) =>
    <String, dynamic>{
      if (sessionMessageTypeNullableToJson(instance.messageType)
          case final value?)
        'MessageType': value,
    };

SessionUserInfo _$SessionUserInfoFromJson(Map<String, dynamic> json) =>
    SessionUserInfo(
      userId: json['UserId'] as String?,
      userName: json['UserName'] as String?,
    );

Map<String, dynamic> _$SessionUserInfoToJson(SessionUserInfo instance) =>
    <String, dynamic>{
      if (instance.userId case final value?) 'UserId': value,
      if (instance.userName case final value?) 'UserName': value,
    };

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
        SetPlaylistItemRequestDto instance) =>
    <String, dynamic>{
      if (instance.playlistItemId case final value?) 'PlaylistItemId': value,
    };

SetRepeatModeRequestDto _$SetRepeatModeRequestDtoFromJson(
        Map<String, dynamic> json) =>
    SetRepeatModeRequestDto(
      mode: groupRepeatModeNullableFromJson(json['Mode']),
    );

Map<String, dynamic> _$SetRepeatModeRequestDtoToJson(
        SetRepeatModeRequestDto instance) =>
    <String, dynamic>{
      if (groupRepeatModeNullableToJson(instance.mode) case final value?)
        'Mode': value,
    };

SetShuffleModeRequestDto _$SetShuffleModeRequestDtoFromJson(
        Map<String, dynamic> json) =>
    SetShuffleModeRequestDto(
      mode: groupShuffleModeNullableFromJson(json['Mode']),
    );

Map<String, dynamic> _$SetShuffleModeRequestDtoToJson(
        SetShuffleModeRequestDto instance) =>
    <String, dynamic>{
      if (groupShuffleModeNullableToJson(instance.mode) case final value?)
        'Mode': value,
    };

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

Map<String, dynamic> _$SongInfoToJson(SongInfo instance) => <String, dynamic>{
      if (instance.name case final value?) 'Name': value,
      if (instance.originalTitle case final value?) 'OriginalTitle': value,
      if (instance.path case final value?) 'Path': value,
      if (instance.metadataLanguage case final value?)
        'MetadataLanguage': value,
      if (instance.metadataCountryCode case final value?)
        'MetadataCountryCode': value,
      if (instance.providerIds case final value?) 'ProviderIds': value,
      if (instance.year case final value?) 'Year': value,
      if (instance.indexNumber case final value?) 'IndexNumber': value,
      if (instance.parentIndexNumber case final value?)
        'ParentIndexNumber': value,
      if (instance.premiereDate?.toIso8601String() case final value?)
        'PremiereDate': value,
      if (instance.isAutomated case final value?) 'IsAutomated': value,
      if (instance.albumArtists case final value?) 'AlbumArtists': value,
      if (instance.album case final value?) 'Album': value,
      if (instance.artists case final value?) 'Artists': value,
    };

SpecialViewOptionDto _$SpecialViewOptionDtoFromJson(
        Map<String, dynamic> json) =>
    SpecialViewOptionDto(
      name: json['Name'] as String?,
      id: json['Id'] as String?,
    );

Map<String, dynamic> _$SpecialViewOptionDtoToJson(
        SpecialViewOptionDto instance) =>
    <String, dynamic>{
      if (instance.name case final value?) 'Name': value,
      if (instance.id case final value?) 'Id': value,
    };

StartupConfigurationDto _$StartupConfigurationDtoFromJson(
        Map<String, dynamic> json) =>
    StartupConfigurationDto(
      uICulture: json['UICulture'] as String?,
      metadataCountryCode: json['MetadataCountryCode'] as String?,
      preferredMetadataLanguage: json['PreferredMetadataLanguage'] as String?,
    );

Map<String, dynamic> _$StartupConfigurationDtoToJson(
        StartupConfigurationDto instance) =>
    <String, dynamic>{
      if (instance.uICulture case final value?) 'UICulture': value,
      if (instance.metadataCountryCode case final value?)
        'MetadataCountryCode': value,
      if (instance.preferredMetadataLanguage case final value?)
        'PreferredMetadataLanguage': value,
    };

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

Map<String, dynamic> _$StartupUserDtoToJson(StartupUserDto instance) =>
    <String, dynamic>{
      if (instance.name case final value?) 'Name': value,
      if (instance.password case final value?) 'Password': value,
    };

StringGroupUpdate _$StringGroupUpdateFromJson(Map<String, dynamic> json) =>
    StringGroupUpdate(
      groupId: json['GroupId'] as String?,
      type: groupUpdateTypeNullableFromJson(json['Type']),
      data: json['Data'] as String?,
    );

Map<String, dynamic> _$StringGroupUpdateToJson(StringGroupUpdate instance) =>
    <String, dynamic>{
      if (instance.groupId case final value?) 'GroupId': value,
      if (groupUpdateTypeNullableToJson(instance.type) case final value?)
        'Type': value,
      if (instance.data case final value?) 'Data': value,
    };

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

Map<String, dynamic> _$SubtitleOptionsToJson(SubtitleOptions instance) =>
    <String, dynamic>{
      if (instance.skipIfEmbeddedSubtitlesPresent case final value?)
        'SkipIfEmbeddedSubtitlesPresent': value,
      if (instance.skipIfAudioTrackMatches case final value?)
        'SkipIfAudioTrackMatches': value,
      if (instance.downloadLanguages case final value?)
        'DownloadLanguages': value,
      if (instance.downloadMovieSubtitles case final value?)
        'DownloadMovieSubtitles': value,
      if (instance.downloadEpisodeSubtitles case final value?)
        'DownloadEpisodeSubtitles': value,
      if (instance.openSubtitlesUsername case final value?)
        'OpenSubtitlesUsername': value,
      if (instance.openSubtitlesPasswordHash case final value?)
        'OpenSubtitlesPasswordHash': value,
      if (instance.isOpenSubtitleVipAccount case final value?)
        'IsOpenSubtitleVipAccount': value,
      if (instance.requirePerfectMatch case final value?)
        'RequirePerfectMatch': value,
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
      if (instance.format case final value?) 'Format': value,
      if (subtitleDeliveryMethodNullableToJson(instance.method)
          case final value?)
        'Method': value,
      if (instance.didlMode case final value?) 'DidlMode': value,
      if (instance.language case final value?) 'Language': value,
      if (instance.container case final value?) 'Container': value,
    };

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
        SyncPlayCommandMessage instance) =>
    <String, dynamic>{
      if (instance.data?.toJson() case final value?) 'Data': value,
      if (instance.messageId case final value?) 'MessageId': value,
      if (sessionMessageTypeNullableToJson(instance.messageType)
          case final value?)
        'MessageType': value,
    };

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
        SyncPlayGroupUpdateCommandMessage instance) =>
    <String, dynamic>{
      if (instance.data?.toJson() case final value?) 'Data': value,
      if (instance.messageId case final value?) 'MessageId': value,
      if (sessionMessageTypeNullableToJson(instance.messageType)
          case final value?)
        'MessageType': value,
    };

SyncPlayQueueItem _$SyncPlayQueueItemFromJson(Map<String, dynamic> json) =>
    SyncPlayQueueItem(
      itemId: json['ItemId'] as String?,
      playlistItemId: json['PlaylistItemId'] as String?,
    );

Map<String, dynamic> _$SyncPlayQueueItemToJson(SyncPlayQueueItem instance) =>
    <String, dynamic>{
      if (instance.itemId case final value?) 'ItemId': value,
      if (instance.playlistItemId case final value?) 'PlaylistItemId': value,
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

Map<String, dynamic> _$SystemInfoToJson(SystemInfo instance) =>
    <String, dynamic>{
      if (instance.localAddress case final value?) 'LocalAddress': value,
      if (instance.serverName case final value?) 'ServerName': value,
      if (instance.version case final value?) 'Version': value,
      if (instance.productName case final value?) 'ProductName': value,
      if (instance.operatingSystem case final value?) 'OperatingSystem': value,
      if (instance.id case final value?) 'Id': value,
      if (instance.startupWizardCompleted case final value?)
        'StartupWizardCompleted': value,
      if (instance.operatingSystemDisplayName case final value?)
        'OperatingSystemDisplayName': value,
      if (instance.packageName case final value?) 'PackageName': value,
      if (instance.hasPendingRestart case final value?)
        'HasPendingRestart': value,
      if (instance.isShuttingDown case final value?) 'IsShuttingDown': value,
      if (instance.supportsLibraryMonitor case final value?)
        'SupportsLibraryMonitor': value,
      if (instance.webSocketPortNumber case final value?)
        'WebSocketPortNumber': value,
      if (instance.completedInstallations?.map((e) => e.toJson()).toList()
          case final value?)
        'CompletedInstallations': value,
      if (instance.canSelfRestart case final value?) 'CanSelfRestart': value,
      if (instance.canLaunchWebBrowser case final value?)
        'CanLaunchWebBrowser': value,
      if (instance.programDataPath case final value?) 'ProgramDataPath': value,
      if (instance.webPath case final value?) 'WebPath': value,
      if (instance.itemsByNamePath case final value?) 'ItemsByNamePath': value,
      if (instance.cachePath case final value?) 'CachePath': value,
      if (instance.logPath case final value?) 'LogPath': value,
      if (instance.internalMetadataPath case final value?)
        'InternalMetadataPath': value,
      if (instance.transcodingTempPath case final value?)
        'TranscodingTempPath': value,
      if (instance.castReceiverApplications?.map((e) => e.toJson()).toList()
          case final value?)
        'CastReceiverApplications': value,
      if (instance.hasUpdateAvailable case final value?)
        'HasUpdateAvailable': value,
      if (instance.encoderLocation case final value?) 'EncoderLocation': value,
      if (instance.systemArchitecture case final value?)
        'SystemArchitecture': value,
    };

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

Map<String, dynamic> _$TaskInfoToJson(TaskInfo instance) => <String, dynamic>{
      if (instance.name case final value?) 'Name': value,
      if (taskStateNullableToJson(instance.state) case final value?)
        'State': value,
      if (instance.currentProgressPercentage case final value?)
        'CurrentProgressPercentage': value,
      if (instance.id case final value?) 'Id': value,
      if (instance.lastExecutionResult?.toJson() case final value?)
        'LastExecutionResult': value,
      if (instance.triggers?.map((e) => e.toJson()).toList() case final value?)
        'Triggers': value,
      if (instance.description case final value?) 'Description': value,
      if (instance.category case final value?) 'Category': value,
      if (instance.isHidden case final value?) 'IsHidden': value,
      if (instance.key case final value?) 'Key': value,
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
      if (instance.startTimeUtc?.toIso8601String() case final value?)
        'StartTimeUtc': value,
      if (instance.endTimeUtc?.toIso8601String() case final value?)
        'EndTimeUtc': value,
      if (taskCompletionStatusNullableToJson(instance.status) case final value?)
        'Status': value,
      if (instance.name case final value?) 'Name': value,
      if (instance.key case final value?) 'Key': value,
      if (instance.id case final value?) 'Id': value,
      if (instance.errorMessage case final value?) 'ErrorMessage': value,
      if (instance.longErrorMessage case final value?)
        'LongErrorMessage': value,
    };

TaskTriggerInfo _$TaskTriggerInfoFromJson(Map<String, dynamic> json) =>
    TaskTriggerInfo(
      type: json['Type'] as String?,
      timeOfDayTicks: (json['TimeOfDayTicks'] as num?)?.toInt(),
      intervalTicks: (json['IntervalTicks'] as num?)?.toInt(),
      dayOfWeek: dayOfWeekNullableFromJson(json['DayOfWeek']),
      maxRuntimeTicks: (json['MaxRuntimeTicks'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TaskTriggerInfoToJson(TaskTriggerInfo instance) =>
    <String, dynamic>{
      if (instance.type case final value?) 'Type': value,
      if (instance.timeOfDayTicks case final value?) 'TimeOfDayTicks': value,
      if (instance.intervalTicks case final value?) 'IntervalTicks': value,
      if (dayOfWeekNullableToJson(instance.dayOfWeek) case final value?)
        'DayOfWeek': value,
      if (instance.maxRuntimeTicks case final value?) 'MaxRuntimeTicks': value,
    };

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

Map<String, dynamic> _$ThemeMediaResultToJson(ThemeMediaResult instance) =>
    <String, dynamic>{
      if (instance.items?.map((e) => e.toJson()).toList() case final value?)
        'Items': value,
      if (instance.totalRecordCount case final value?)
        'TotalRecordCount': value,
      if (instance.startIndex case final value?) 'StartIndex': value,
      if (instance.ownerId case final value?) 'OwnerId': value,
    };

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
        TimerCancelledMessage instance) =>
    <String, dynamic>{
      if (instance.data?.toJson() case final value?) 'Data': value,
      if (instance.messageId case final value?) 'MessageId': value,
      if (sessionMessageTypeNullableToJson(instance.messageType)
          case final value?)
        'MessageType': value,
    };

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

Map<String, dynamic> _$TimerCreatedMessageToJson(
        TimerCreatedMessage instance) =>
    <String, dynamic>{
      if (instance.data?.toJson() case final value?) 'Data': value,
      if (instance.messageId case final value?) 'MessageId': value,
      if (sessionMessageTypeNullableToJson(instance.messageType)
          case final value?)
        'MessageType': value,
    };

TimerEventInfo _$TimerEventInfoFromJson(Map<String, dynamic> json) =>
    TimerEventInfo(
      id: json['Id'] as String?,
      programId: json['ProgramId'] as String?,
    );

Map<String, dynamic> _$TimerEventInfoToJson(TimerEventInfo instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'Id': value,
      if (instance.programId case final value?) 'ProgramId': value,
    };

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
      if (instance.id case final value?) 'Id': value,
      if (instance.type case final value?) 'Type': value,
      if (instance.serverId case final value?) 'ServerId': value,
      if (instance.externalId case final value?) 'ExternalId': value,
      if (instance.channelId case final value?) 'ChannelId': value,
      if (instance.externalChannelId case final value?)
        'ExternalChannelId': value,
      if (instance.channelName case final value?) 'ChannelName': value,
      if (instance.channelPrimaryImageTag case final value?)
        'ChannelPrimaryImageTag': value,
      if (instance.programId case final value?) 'ProgramId': value,
      if (instance.externalProgramId case final value?)
        'ExternalProgramId': value,
      if (instance.name case final value?) 'Name': value,
      if (instance.overview case final value?) 'Overview': value,
      if (instance.startDate?.toIso8601String() case final value?)
        'StartDate': value,
      if (instance.endDate?.toIso8601String() case final value?)
        'EndDate': value,
      if (instance.serviceName case final value?) 'ServiceName': value,
      if (instance.priority case final value?) 'Priority': value,
      if (instance.prePaddingSeconds case final value?)
        'PrePaddingSeconds': value,
      if (instance.postPaddingSeconds case final value?)
        'PostPaddingSeconds': value,
      if (instance.isPrePaddingRequired case final value?)
        'IsPrePaddingRequired': value,
      if (instance.parentBackdropItemId case final value?)
        'ParentBackdropItemId': value,
      if (instance.parentBackdropImageTags case final value?)
        'ParentBackdropImageTags': value,
      if (instance.isPostPaddingRequired case final value?)
        'IsPostPaddingRequired': value,
      if (keepUntilNullableToJson(instance.keepUntil) case final value?)
        'KeepUntil': value,
      if (recordingStatusNullableToJson(instance.status) case final value?)
        'Status': value,
      if (instance.seriesTimerId case final value?) 'SeriesTimerId': value,
      if (instance.externalSeriesTimerId case final value?)
        'ExternalSeriesTimerId': value,
      if (instance.runTimeTicks case final value?) 'RunTimeTicks': value,
      if (instance.programInfo?.toJson() case final value?)
        'ProgramInfo': value,
    };

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
        TimerInfoDtoQueryResult instance) =>
    <String, dynamic>{
      if (instance.items?.map((e) => e.toJson()).toList() case final value?)
        'Items': value,
      if (instance.totalRecordCount case final value?)
        'TotalRecordCount': value,
      if (instance.startIndex case final value?) 'StartIndex': value,
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
      if (instance.name case final value?) 'Name': value,
      if (instance.originalTitle case final value?) 'OriginalTitle': value,
      if (instance.path case final value?) 'Path': value,
      if (instance.metadataLanguage case final value?)
        'MetadataLanguage': value,
      if (instance.metadataCountryCode case final value?)
        'MetadataCountryCode': value,
      if (instance.providerIds case final value?) 'ProviderIds': value,
      if (instance.year case final value?) 'Year': value,
      if (instance.indexNumber case final value?) 'IndexNumber': value,
      if (instance.parentIndexNumber case final value?)
        'ParentIndexNumber': value,
      if (instance.premiereDate?.toIso8601String() case final value?)
        'PremiereDate': value,
      if (instance.isAutomated case final value?) 'IsAutomated': value,
    };

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
        TrailerInfoRemoteSearchQuery instance) =>
    <String, dynamic>{
      if (instance.searchInfo?.toJson() case final value?) 'SearchInfo': value,
      if (instance.itemId case final value?) 'ItemId': value,
      if (instance.searchProviderName case final value?)
        'SearchProviderName': value,
      if (instance.includeDisabledProviders case final value?)
        'IncludeDisabledProviders': value,
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
          json['HardwareAccelerationType']),
      transcodeReasons:
          transcodeReasonListFromJson(json['TranscodeReasons'] as List?),
    );

Map<String, dynamic> _$TranscodingInfoToJson(TranscodingInfo instance) =>
    <String, dynamic>{
      if (instance.audioCodec case final value?) 'AudioCodec': value,
      if (instance.videoCodec case final value?) 'VideoCodec': value,
      if (instance.container case final value?) 'Container': value,
      if (instance.isVideoDirect case final value?) 'IsVideoDirect': value,
      if (instance.isAudioDirect case final value?) 'IsAudioDirect': value,
      if (instance.bitrate case final value?) 'Bitrate': value,
      if (instance.framerate case final value?) 'Framerate': value,
      if (instance.completionPercentage case final value?)
        'CompletionPercentage': value,
      if (instance.width case final value?) 'Width': value,
      if (instance.height case final value?) 'Height': value,
      if (instance.audioChannels case final value?) 'AudioChannels': value,
      if (hardwareAccelerationTypeNullableToJson(
              instance.hardwareAccelerationType)
          case final value?)
        'HardwareAccelerationType': value,
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

Map<String, dynamic> _$TranscodingProfileToJson(TranscodingProfile instance) =>
    <String, dynamic>{
      if (instance.container case final value?) 'Container': value,
      if (dlnaProfileTypeNullableToJson(instance.type) case final value?)
        'Type': value,
      if (instance.videoCodec case final value?) 'VideoCodec': value,
      if (instance.audioCodec case final value?) 'AudioCodec': value,
      if (mediaStreamProtocolNullableToJson(instance.protocol)
          case final value?)
        'Protocol': value,
      if (instance.estimateContentLength case final value?)
        'EstimateContentLength': value,
      if (instance.enableMpegtsM2TsMode case final value?)
        'EnableMpegtsM2TsMode': value,
      if (transcodeSeekInfoNullableToJson(instance.transcodeSeekInfo)
          case final value?)
        'TranscodeSeekInfo': value,
      if (instance.copyTimestamps case final value?) 'CopyTimestamps': value,
      if (encodingContextNullableToJson(instance.context) case final value?)
        'Context': value,
      if (instance.enableSubtitlesInManifest case final value?)
        'EnableSubtitlesInManifest': value,
      if (instance.maxAudioChannels case final value?)
        'MaxAudioChannels': value,
      if (instance.minSegments case final value?) 'MinSegments': value,
      if (instance.segmentLength case final value?) 'SegmentLength': value,
      if (instance.breakOnNonKeyFrames case final value?)
        'BreakOnNonKeyFrames': value,
      if (instance.conditions?.map((e) => e.toJson()).toList()
          case final value?)
        'Conditions': value,
      if (instance.enableAudioVbrEncoding case final value?)
        'EnableAudioVbrEncoding': value,
    };

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

Map<String, dynamic> _$TrickplayInfoToJson(TrickplayInfo instance) =>
    <String, dynamic>{
      if (instance.width case final value?) 'Width': value,
      if (instance.height case final value?) 'Height': value,
      if (instance.tileWidth case final value?) 'TileWidth': value,
      if (instance.tileHeight case final value?) 'TileHeight': value,
      if (instance.thumbnailCount case final value?) 'ThumbnailCount': value,
      if (instance.interval case final value?) 'Interval': value,
      if (instance.bandwidth case final value?) 'Bandwidth': value,
    };

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

Map<String, dynamic> _$TrickplayOptionsToJson(TrickplayOptions instance) =>
    <String, dynamic>{
      if (instance.enableHwAcceleration case final value?)
        'EnableHwAcceleration': value,
      if (instance.enableHwEncoding case final value?)
        'EnableHwEncoding': value,
      if (instance.enableKeyFrameOnlyExtraction case final value?)
        'EnableKeyFrameOnlyExtraction': value,
      if (trickplayScanBehaviorNullableToJson(instance.scanBehavior)
          case final value?)
        'ScanBehavior': value,
      if (processPriorityClassNullableToJson(instance.processPriority)
          case final value?)
        'ProcessPriority': value,
      if (instance.interval case final value?) 'Interval': value,
      if (instance.widthResolutions case final value?)
        'WidthResolutions': value,
      if (instance.tileWidth case final value?) 'TileWidth': value,
      if (instance.tileHeight case final value?) 'TileHeight': value,
      if (instance.qscale case final value?) 'Qscale': value,
      if (instance.jpegQuality case final value?) 'JpegQuality': value,
      if (instance.processThreads case final value?) 'ProcessThreads': value,
    };

TunerChannelMapping _$TunerChannelMappingFromJson(Map<String, dynamic> json) =>
    TunerChannelMapping(
      name: json['Name'] as String?,
      providerChannelName: json['ProviderChannelName'] as String?,
      providerChannelId: json['ProviderChannelId'] as String?,
      id: json['Id'] as String?,
    );

Map<String, dynamic> _$TunerChannelMappingToJson(
        TunerChannelMapping instance) =>
    <String, dynamic>{
      if (instance.name case final value?) 'Name': value,
      if (instance.providerChannelName case final value?)
        'ProviderChannelName': value,
      if (instance.providerChannelId case final value?)
        'ProviderChannelId': value,
      if (instance.id case final value?) 'Id': value,
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
      fallbackMaxStreamingBitrate:
          (json['FallbackMaxStreamingBitrate'] as num?)?.toInt(),
      enableStreamLooping: json['EnableStreamLooping'] as bool?,
      source: json['Source'] as String?,
      tunerCount: (json['TunerCount'] as num?)?.toInt(),
      userAgent: json['UserAgent'] as String?,
      ignoreDts: json['IgnoreDts'] as bool?,
    );

Map<String, dynamic> _$TunerHostInfoToJson(TunerHostInfo instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'Id': value,
      if (instance.url case final value?) 'Url': value,
      if (instance.type case final value?) 'Type': value,
      if (instance.deviceId case final value?) 'DeviceId': value,
      if (instance.friendlyName case final value?) 'FriendlyName': value,
      if (instance.importFavoritesOnly case final value?)
        'ImportFavoritesOnly': value,
      if (instance.allowHWTranscoding case final value?)
        'AllowHWTranscoding': value,
      if (instance.allowFmp4TranscodingContainer case final value?)
        'AllowFmp4TranscodingContainer': value,
      if (instance.allowStreamSharing case final value?)
        'AllowStreamSharing': value,
      if (instance.fallbackMaxStreamingBitrate case final value?)
        'FallbackMaxStreamingBitrate': value,
      if (instance.enableStreamLooping case final value?)
        'EnableStreamLooping': value,
      if (instance.source case final value?) 'Source': value,
      if (instance.tunerCount case final value?) 'TunerCount': value,
      if (instance.userAgent case final value?) 'UserAgent': value,
      if (instance.ignoreDts case final value?) 'IgnoreDts': value,
    };

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

Map<String, dynamic> _$TypeOptionsToJson(TypeOptions instance) =>
    <String, dynamic>{
      if (instance.type case final value?) 'Type': value,
      if (instance.metadataFetchers case final value?)
        'MetadataFetchers': value,
      if (instance.metadataFetcherOrder case final value?)
        'MetadataFetcherOrder': value,
      if (instance.imageFetchers case final value?) 'ImageFetchers': value,
      if (instance.imageFetcherOrder case final value?)
        'ImageFetcherOrder': value,
      if (instance.imageOptions?.map((e) => e.toJson()).toList()
          case final value?)
        'ImageOptions': value,
    };

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
        UpdateLibraryOptionsDto instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'Id': value,
      if (instance.libraryOptions?.toJson() case final value?)
        'LibraryOptions': value,
    };

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

Map<String, dynamic> _$UpdatePlaylistDtoToJson(UpdatePlaylistDto instance) =>
    <String, dynamic>{
      if (instance.name case final value?) 'Name': value,
      if (instance.ids case final value?) 'Ids': value,
      if (instance.users?.map((e) => e.toJson()).toList() case final value?)
        'Users': value,
      if (instance.isPublic case final value?) 'IsPublic': value,
    };

UpdatePlaylistUserDto _$UpdatePlaylistUserDtoFromJson(
        Map<String, dynamic> json) =>
    UpdatePlaylistUserDto(
      canEdit: json['CanEdit'] as bool?,
    );

Map<String, dynamic> _$UpdatePlaylistUserDtoToJson(
        UpdatePlaylistUserDto instance) =>
    <String, dynamic>{
      if (instance.canEdit case final value?) 'CanEdit': value,
    };

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
        UpdateUserItemDataDto instance) =>
    <String, dynamic>{
      if (instance.rating case final value?) 'Rating': value,
      if (instance.playedPercentage case final value?)
        'PlayedPercentage': value,
      if (instance.unplayedItemCount case final value?)
        'UnplayedItemCount': value,
      if (instance.playbackPositionTicks case final value?)
        'PlaybackPositionTicks': value,
      if (instance.playCount case final value?) 'PlayCount': value,
      if (instance.isFavorite case final value?) 'IsFavorite': value,
      if (instance.likes case final value?) 'Likes': value,
      if (instance.lastPlayedDate?.toIso8601String() case final value?)
        'LastPlayedDate': value,
      if (instance.played case final value?) 'Played': value,
      if (instance.key case final value?) 'Key': value,
      if (instance.itemId case final value?) 'ItemId': value,
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
      if (instance.currentPassword case final value?) 'CurrentPassword': value,
      if (instance.currentPw case final value?) 'CurrentPw': value,
      if (instance.newPw case final value?) 'NewPw': value,
      if (instance.resetPassword case final value?) 'ResetPassword': value,
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

Map<String, dynamic> _$UserConfigurationToJson(UserConfiguration instance) =>
    <String, dynamic>{
      if (instance.audioLanguagePreference case final value?)
        'AudioLanguagePreference': value,
      if (instance.playDefaultAudioTrack case final value?)
        'PlayDefaultAudioTrack': value,
      if (instance.subtitleLanguagePreference case final value?)
        'SubtitleLanguagePreference': value,
      if (instance.displayMissingEpisodes case final value?)
        'DisplayMissingEpisodes': value,
      if (instance.groupedFolders case final value?) 'GroupedFolders': value,
      if (subtitlePlaybackModeNullableToJson(instance.subtitleMode)
          case final value?)
        'SubtitleMode': value,
      if (instance.displayCollectionsView case final value?)
        'DisplayCollectionsView': value,
      if (instance.enableLocalPassword case final value?)
        'EnableLocalPassword': value,
      if (instance.orderedViews case final value?) 'OrderedViews': value,
      if (instance.latestItemsExcludes case final value?)
        'LatestItemsExcludes': value,
      if (instance.myMediaExcludes case final value?) 'MyMediaExcludes': value,
      if (instance.hidePlayedInLatest case final value?)
        'HidePlayedInLatest': value,
      if (instance.rememberAudioSelections case final value?)
        'RememberAudioSelections': value,
      if (instance.rememberSubtitleSelections case final value?)
        'RememberSubtitleSelections': value,
      if (instance.enableNextEpisodeAutoPlay case final value?)
        'EnableNextEpisodeAutoPlay': value,
      if (instance.castReceiverId case final value?) 'CastReceiverId': value,
    };

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
        UserDataChangedMessage instance) =>
    <String, dynamic>{
      if (instance.data?.toJson() case final value?) 'Data': value,
      if (instance.messageId case final value?) 'MessageId': value,
      if (sessionMessageTypeNullableToJson(instance.messageType)
          case final value?)
        'MessageType': value,
    };

UserDataChangeInfo _$UserDataChangeInfoFromJson(Map<String, dynamic> json) =>
    UserDataChangeInfo(
      userId: json['UserId'] as String?,
      userDataList: (json['UserDataList'] as List<dynamic>?)
              ?.map((e) => UserItemDataDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$UserDataChangeInfoToJson(UserDataChangeInfo instance) =>
    <String, dynamic>{
      if (instance.userId case final value?) 'UserId': value,
      if (instance.userDataList?.map((e) => e.toJson()).toList()
          case final value?)
        'UserDataList': value,
    };

UserDeletedMessage _$UserDeletedMessageFromJson(Map<String, dynamic> json) =>
    UserDeletedMessage(
      data: json['Data'] as String?,
      messageId: json['MessageId'] as String?,
      messageType:
          UserDeletedMessage.sessionMessageTypeMessageTypeNullableFromJson(
              json['MessageType']),
    );

Map<String, dynamic> _$UserDeletedMessageToJson(UserDeletedMessage instance) =>
    <String, dynamic>{
      if (instance.data case final value?) 'Data': value,
      if (instance.messageId case final value?) 'MessageId': value,
      if (sessionMessageTypeNullableToJson(instance.messageType)
          case final value?)
        'MessageType': value,
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
              json['Configuration'] as Map<String, dynamic>),
      policy: json['Policy'] == null
          ? null
          : UserPolicy.fromJson(json['Policy'] as Map<String, dynamic>),
      primaryImageAspectRatio:
          (json['PrimaryImageAspectRatio'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
      if (instance.name case final value?) 'Name': value,
      if (instance.serverId case final value?) 'ServerId': value,
      if (instance.serverName case final value?) 'ServerName': value,
      if (instance.id case final value?) 'Id': value,
      if (instance.primaryImageTag case final value?) 'PrimaryImageTag': value,
      if (instance.hasPassword case final value?) 'HasPassword': value,
      if (instance.hasConfiguredPassword case final value?)
        'HasConfiguredPassword': value,
      if (instance.hasConfiguredEasyPassword case final value?)
        'HasConfiguredEasyPassword': value,
      if (instance.enableAutoLogin case final value?) 'EnableAutoLogin': value,
      if (instance.lastLoginDate?.toIso8601String() case final value?)
        'LastLoginDate': value,
      if (instance.lastActivityDate?.toIso8601String() case final value?)
        'LastActivityDate': value,
      if (instance.configuration?.toJson() case final value?)
        'Configuration': value,
      if (instance.policy?.toJson() case final value?) 'Policy': value,
      if (instance.primaryImageAspectRatio case final value?)
        'PrimaryImageAspectRatio': value,
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
      if (instance.rating case final value?) 'Rating': value,
      if (instance.playedPercentage case final value?)
        'PlayedPercentage': value,
      if (instance.unplayedItemCount case final value?)
        'UnplayedItemCount': value,
      if (instance.playbackPositionTicks case final value?)
        'PlaybackPositionTicks': value,
      if (instance.playCount case final value?) 'PlayCount': value,
      if (instance.isFavorite case final value?) 'IsFavorite': value,
      if (instance.likes case final value?) 'Likes': value,
      if (instance.lastPlayedDate?.toIso8601String() case final value?)
        'LastPlayedDate': value,
      if (instance.played case final value?) 'Played': value,
      if (instance.key case final value?) 'Key': value,
      if (instance.itemId case final value?) 'ItemId': value,
    };

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

Map<String, dynamic> _$UserPolicyToJson(UserPolicy instance) =>
    <String, dynamic>{
      if (instance.isAdministrator case final value?) 'IsAdministrator': value,
      if (instance.isHidden case final value?) 'IsHidden': value,
      if (instance.enableCollectionManagement case final value?)
        'EnableCollectionManagement': value,
      if (instance.enableSubtitleManagement case final value?)
        'EnableSubtitleManagement': value,
      if (instance.enableLyricManagement case final value?)
        'EnableLyricManagement': value,
      if (instance.isDisabled case final value?) 'IsDisabled': value,
      if (instance.maxParentalRating case final value?)
        'MaxParentalRating': value,
      if (instance.blockedTags case final value?) 'BlockedTags': value,
      if (instance.allowedTags case final value?) 'AllowedTags': value,
      if (instance.enableUserPreferenceAccess case final value?)
        'EnableUserPreferenceAccess': value,
      if (instance.accessSchedules?.map((e) => e.toJson()).toList()
          case final value?)
        'AccessSchedules': value,
      'BlockUnratedItems': unratedItemListToJson(instance.blockUnratedItems),
      if (instance.enableRemoteControlOfOtherUsers case final value?)
        'EnableRemoteControlOfOtherUsers': value,
      if (instance.enableSharedDeviceControl case final value?)
        'EnableSharedDeviceControl': value,
      if (instance.enableRemoteAccess case final value?)
        'EnableRemoteAccess': value,
      if (instance.enableLiveTvManagement case final value?)
        'EnableLiveTvManagement': value,
      if (instance.enableLiveTvAccess case final value?)
        'EnableLiveTvAccess': value,
      if (instance.enableMediaPlayback case final value?)
        'EnableMediaPlayback': value,
      if (instance.enableAudioPlaybackTranscoding case final value?)
        'EnableAudioPlaybackTranscoding': value,
      if (instance.enableVideoPlaybackTranscoding case final value?)
        'EnableVideoPlaybackTranscoding': value,
      if (instance.enablePlaybackRemuxing case final value?)
        'EnablePlaybackRemuxing': value,
      if (instance.forceRemoteSourceTranscoding case final value?)
        'ForceRemoteSourceTranscoding': value,
      if (instance.enableContentDeletion case final value?)
        'EnableContentDeletion': value,
      if (instance.enableContentDeletionFromFolders case final value?)
        'EnableContentDeletionFromFolders': value,
      if (instance.enableContentDownloading case final value?)
        'EnableContentDownloading': value,
      if (instance.enableSyncTranscoding case final value?)
        'EnableSyncTranscoding': value,
      if (instance.enableMediaConversion case final value?)
        'EnableMediaConversion': value,
      if (instance.enabledDevices case final value?) 'EnabledDevices': value,
      if (instance.enableAllDevices case final value?)
        'EnableAllDevices': value,
      if (instance.enabledChannels case final value?) 'EnabledChannels': value,
      if (instance.enableAllChannels case final value?)
        'EnableAllChannels': value,
      if (instance.enabledFolders case final value?) 'EnabledFolders': value,
      if (instance.enableAllFolders case final value?)
        'EnableAllFolders': value,
      if (instance.invalidLoginAttemptCount case final value?)
        'InvalidLoginAttemptCount': value,
      if (instance.loginAttemptsBeforeLockout case final value?)
        'LoginAttemptsBeforeLockout': value,
      if (instance.maxActiveSessions case final value?)
        'MaxActiveSessions': value,
      if (instance.enablePublicSharing case final value?)
        'EnablePublicSharing': value,
      if (instance.blockedMediaFolders case final value?)
        'BlockedMediaFolders': value,
      if (instance.blockedChannels case final value?) 'BlockedChannels': value,
      if (instance.remoteClientBitrateLimit case final value?)
        'RemoteClientBitrateLimit': value,
      'AuthenticationProviderId': instance.authenticationProviderId,
      'PasswordResetProviderId': instance.passwordResetProviderId,
      if (syncPlayUserAccessTypeNullableToJson(instance.syncPlayAccess)
          case final value?)
        'SyncPlayAccess': value,
    };

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

Map<String, dynamic> _$UserUpdatedMessageToJson(UserUpdatedMessage instance) =>
    <String, dynamic>{
      if (instance.data?.toJson() case final value?) 'Data': value,
      if (instance.messageId case final value?) 'MessageId': value,
      if (sessionMessageTypeNullableToJson(instance.messageType)
          case final value?)
        'MessageType': value,
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
      if (instance.requestReceptionTime?.toIso8601String() case final value?)
        'RequestReceptionTime': value,
      if (instance.responseTransmissionTime?.toIso8601String()
          case final value?)
        'ResponseTransmissionTime': value,
    };

ValidatePathDto _$ValidatePathDtoFromJson(Map<String, dynamic> json) =>
    ValidatePathDto(
      validateWritable: json['ValidateWritable'] as bool?,
      path: json['Path'] as String?,
      isFile: json['IsFile'] as bool?,
    );

Map<String, dynamic> _$ValidatePathDtoToJson(ValidatePathDto instance) =>
    <String, dynamic>{
      if (instance.validateWritable case final value?)
        'ValidateWritable': value,
      if (instance.path case final value?) 'Path': value,
      if (instance.isFile case final value?) 'IsFile': value,
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
      if (instance.version case final value?) 'version': value,
      if (instance.versionNumber case final value?) 'VersionNumber': value,
      if (instance.changelog case final value?) 'changelog': value,
      if (instance.targetAbi case final value?) 'targetAbi': value,
      if (instance.sourceUrl case final value?) 'sourceUrl': value,
      if (instance.checksum case final value?) 'checksum': value,
      if (instance.timestamp case final value?) 'timestamp': value,
      if (instance.repositoryName case final value?) 'repositoryName': value,
      if (instance.repositoryUrl case final value?) 'repositoryUrl': value,
    };

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

Map<String, dynamic> _$VirtualFolderInfoToJson(VirtualFolderInfo instance) =>
    <String, dynamic>{
      if (instance.name case final value?) 'Name': value,
      if (instance.locations case final value?) 'Locations': value,
      if (collectionTypeOptionsNullableToJson(instance.collectionType)
          case final value?)
        'CollectionType': value,
      if (instance.libraryOptions?.toJson() case final value?)
        'LibraryOptions': value,
      if (instance.itemId case final value?) 'ItemId': value,
      if (instance.primaryImageItemId case final value?)
        'PrimaryImageItemId': value,
      if (instance.refreshProgress case final value?) 'RefreshProgress': value,
      if (instance.refreshStatus case final value?) 'RefreshStatus': value,
    };

WakeOnLanInfo _$WakeOnLanInfoFromJson(Map<String, dynamic> json) =>
    WakeOnLanInfo(
      macAddress: json['MacAddress'] as String?,
      port: (json['Port'] as num?)?.toInt(),
    );

Map<String, dynamic> _$WakeOnLanInfoToJson(WakeOnLanInfo instance) =>
    <String, dynamic>{
      if (instance.macAddress case final value?) 'MacAddress': value,
      if (instance.port case final value?) 'Port': value,
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
        XbmcMetadataOptions instance) =>
    <String, dynamic>{
      if (instance.userId case final value?) 'UserId': value,
      if (instance.releaseDateFormat case final value?)
        'ReleaseDateFormat': value,
      if (instance.saveImagePathsInNfo case final value?)
        'SaveImagePathsInNfo': value,
      if (instance.enablePathSubstitution case final value?)
        'EnablePathSubstitution': value,
      if (instance.enableExtraThumbsDuplication case final value?)
        'EnableExtraThumbsDuplication': value,
    };

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
        BaseItemDto$ImageBlurHashes instance) =>
    <String, dynamic>{
      if (instance.primary case final value?) 'Primary': value,
      if (instance.art case final value?) 'Art': value,
      if (instance.backdrop case final value?) 'Backdrop': value,
      if (instance.banner case final value?) 'Banner': value,
      if (instance.logo case final value?) 'Logo': value,
      if (instance.thumb case final value?) 'Thumb': value,
      if (instance.disc case final value?) 'Disc': value,
      if (instance.box case final value?) 'Box': value,
      if (instance.screenshot case final value?) 'Screenshot': value,
      if (instance.menu case final value?) 'Menu': value,
      if (instance.chapter case final value?) 'Chapter': value,
      if (instance.boxRear case final value?) 'BoxRear': value,
      if (instance.profile case final value?) 'Profile': value,
    };

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
        BaseItemPerson$ImageBlurHashes instance) =>
    <String, dynamic>{
      if (instance.primary case final value?) 'Primary': value,
      if (instance.art case final value?) 'Art': value,
      if (instance.backdrop case final value?) 'Backdrop': value,
      if (instance.banner case final value?) 'Banner': value,
      if (instance.logo case final value?) 'Logo': value,
      if (instance.thumb case final value?) 'Thumb': value,
      if (instance.disc case final value?) 'Disc': value,
      if (instance.box case final value?) 'Box': value,
      if (instance.screenshot case final value?) 'Screenshot': value,
      if (instance.menu case final value?) 'Menu': value,
      if (instance.chapter case final value?) 'Chapter': value,
      if (instance.boxRear case final value?) 'BoxRear': value,
      if (instance.profile case final value?) 'Profile': value,
    };
