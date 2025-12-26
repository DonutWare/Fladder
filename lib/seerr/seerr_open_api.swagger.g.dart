// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seerr_open_api.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Blacklist _$BlacklistFromJson(Map<String, dynamic> json) => Blacklist(
      tmdbId: (json['tmdbId'] as num?)?.toDouble(),
      title: json['title'] as String?,
      media: json['media'] == null
          ? null
          : MediaInfo.fromJson(json['media'] as Map<String, dynamic>),
      userId: (json['userId'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$BlacklistToJson(Blacklist instance) => <String, dynamic>{
      if (instance.tmdbId case final value?) 'tmdbId': value,
      if (instance.title case final value?) 'title': value,
      if (instance.media?.toJson() case final value?) 'media': value,
      if (instance.userId case final value?) 'userId': value,
    };

Watchlist _$WatchlistFromJson(Map<String, dynamic> json) => Watchlist(
      id: (json['id'] as num?)?.toInt(),
      tmdbId: (json['tmdbId'] as num?)?.toDouble(),
      ratingKey: json['ratingKey'] as String?,
      type: json['type'] as String?,
      title: json['title'] as String?,
      media: json['media'] == null
          ? null
          : MediaInfo.fromJson(json['media'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      requestedBy: json['requestedBy'] == null
          ? null
          : User.fromJson(json['requestedBy'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WatchlistToJson(Watchlist instance) => <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.tmdbId case final value?) 'tmdbId': value,
      if (instance.ratingKey case final value?) 'ratingKey': value,
      if (instance.type case final value?) 'type': value,
      if (instance.title case final value?) 'title': value,
      if (instance.media?.toJson() case final value?) 'media': value,
      if (instance.createdAt case final value?) 'createdAt': value,
      if (instance.updatedAt case final value?) 'updatedAt': value,
      if (instance.requestedBy?.toJson() case final value?)
        'requestedBy': value,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num?)?.toInt(),
      email: json['email'] as String?,
      username: json['username'] as String?,
      plexUsername: json['plexUsername'] as String?,
      plexToken: json['plexToken'] as String?,
      jellyfinAuthToken: json['jellyfinAuthToken'] as String?,
      userType: (json['userType'] as num?)?.toInt(),
      permissions: (json['permissions'] as num?)?.toDouble(),
      avatar: json['avatar'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      requestCount: (json['requestCount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.email case final value?) 'email': value,
      if (instance.username case final value?) 'username': value,
      if (instance.plexUsername case final value?) 'plexUsername': value,
      if (instance.plexToken case final value?) 'plexToken': value,
      if (instance.jellyfinAuthToken case final value?)
        'jellyfinAuthToken': value,
      if (instance.userType case final value?) 'userType': value,
      if (instance.permissions case final value?) 'permissions': value,
      if (instance.avatar case final value?) 'avatar': value,
      if (instance.createdAt case final value?) 'createdAt': value,
      if (instance.updatedAt case final value?) 'updatedAt': value,
      if (instance.requestCount case final value?) 'requestCount': value,
    };

UserSettings _$UserSettingsFromJson(Map<String, dynamic> json) => UserSettings(
      username: json['username'] as String?,
      email: json['email'] as String?,
      discordId: json['discordId'] as String?,
      locale: json['locale'] as String?,
      discoverRegion: json['discoverRegion'] as String?,
      streamingRegion: json['streamingRegion'] as String?,
      originalLanguage: json['originalLanguage'] as String?,
      movieQuotaLimit: (json['movieQuotaLimit'] as num?)?.toDouble(),
      movieQuotaDays: (json['movieQuotaDays'] as num?)?.toDouble(),
      tvQuotaLimit: (json['tvQuotaLimit'] as num?)?.toDouble(),
      tvQuotaDays: (json['tvQuotaDays'] as num?)?.toDouble(),
      globalMovieQuotaDays: (json['globalMovieQuotaDays'] as num?)?.toDouble(),
      globalMovieQuotaLimit:
          (json['globalMovieQuotaLimit'] as num?)?.toDouble(),
      globalTvQuotaLimit: (json['globalTvQuotaLimit'] as num?)?.toDouble(),
      globalTvQuotaDays: (json['globalTvQuotaDays'] as num?)?.toDouble(),
      watchlistSyncMovies: json['watchlistSyncMovies'] as bool?,
      watchlistSyncTv: json['watchlistSyncTv'] as bool?,
    );

Map<String, dynamic> _$UserSettingsToJson(UserSettings instance) =>
    <String, dynamic>{
      if (instance.username case final value?) 'username': value,
      if (instance.email case final value?) 'email': value,
      if (instance.discordId case final value?) 'discordId': value,
      if (instance.locale case final value?) 'locale': value,
      if (instance.discoverRegion case final value?) 'discoverRegion': value,
      if (instance.streamingRegion case final value?) 'streamingRegion': value,
      if (instance.originalLanguage case final value?)
        'originalLanguage': value,
      if (instance.movieQuotaLimit case final value?) 'movieQuotaLimit': value,
      if (instance.movieQuotaDays case final value?) 'movieQuotaDays': value,
      if (instance.tvQuotaLimit case final value?) 'tvQuotaLimit': value,
      if (instance.tvQuotaDays case final value?) 'tvQuotaDays': value,
      if (instance.globalMovieQuotaDays case final value?)
        'globalMovieQuotaDays': value,
      if (instance.globalMovieQuotaLimit case final value?)
        'globalMovieQuotaLimit': value,
      if (instance.globalTvQuotaLimit case final value?)
        'globalTvQuotaLimit': value,
      if (instance.globalTvQuotaDays case final value?)
        'globalTvQuotaDays': value,
      if (instance.watchlistSyncMovies case final value?)
        'watchlistSyncMovies': value,
      if (instance.watchlistSyncTv case final value?) 'watchlistSyncTv': value,
    };

MainSettings _$MainSettingsFromJson(Map<String, dynamic> json) => MainSettings(
      apiKey: json['apiKey'] as String?,
      appLanguage: json['appLanguage'] as String?,
      applicationTitle: json['applicationTitle'] as String?,
      applicationUrl: json['applicationUrl'] as String?,
      hideAvailable: json['hideAvailable'] as bool?,
      partialRequestsEnabled: json['partialRequestsEnabled'] as bool?,
      localLogin: json['localLogin'] as bool?,
      mediaServerType: (json['mediaServerType'] as num?)?.toDouble(),
      newPlexLogin: json['newPlexLogin'] as bool?,
      defaultPermissions: (json['defaultPermissions'] as num?)?.toDouble(),
      enableSpecialEpisodes: json['enableSpecialEpisodes'] as bool?,
    );

Map<String, dynamic> _$MainSettingsToJson(MainSettings instance) =>
    <String, dynamic>{
      if (instance.apiKey case final value?) 'apiKey': value,
      if (instance.appLanguage case final value?) 'appLanguage': value,
      if (instance.applicationTitle case final value?)
        'applicationTitle': value,
      if (instance.applicationUrl case final value?) 'applicationUrl': value,
      if (instance.hideAvailable case final value?) 'hideAvailable': value,
      if (instance.partialRequestsEnabled case final value?)
        'partialRequestsEnabled': value,
      if (instance.localLogin case final value?) 'localLogin': value,
      if (instance.mediaServerType case final value?) 'mediaServerType': value,
      if (instance.newPlexLogin case final value?) 'newPlexLogin': value,
      if (instance.defaultPermissions case final value?)
        'defaultPermissions': value,
      if (instance.enableSpecialEpisodes case final value?)
        'enableSpecialEpisodes': value,
    };

NetworkSettings _$NetworkSettingsFromJson(Map<String, dynamic> json) =>
    NetworkSettings(
      csrfProtection: json['csrfProtection'] as bool?,
      forceIpv4First: json['forceIpv4First'] as bool?,
      trustProxy: json['trustProxy'] as bool?,
      proxy: json['proxy'] == null
          ? null
          : NetworkSettings$Proxy.fromJson(
              json['proxy'] as Map<String, dynamic>),
      dnsCache: json['dnsCache'] == null
          ? null
          : NetworkSettings$DnsCache.fromJson(
              json['dnsCache'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NetworkSettingsToJson(NetworkSettings instance) =>
    <String, dynamic>{
      if (instance.csrfProtection case final value?) 'csrfProtection': value,
      if (instance.forceIpv4First case final value?) 'forceIpv4First': value,
      if (instance.trustProxy case final value?) 'trustProxy': value,
      if (instance.proxy?.toJson() case final value?) 'proxy': value,
      if (instance.dnsCache?.toJson() case final value?) 'dnsCache': value,
    };

PlexLibrary _$PlexLibraryFromJson(Map<String, dynamic> json) => PlexLibrary(
      id: json['id'] as String,
      name: json['name'] as String,
      enabled: json['enabled'] as bool,
    );

Map<String, dynamic> _$PlexLibraryToJson(PlexLibrary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'enabled': instance.enabled,
    };

PlexSettings _$PlexSettingsFromJson(Map<String, dynamic> json) => PlexSettings(
      name: json['name'] as String?,
      machineId: json['machineId'] as String?,
      ip: json['ip'] as String,
      port: (json['port'] as num).toDouble(),
      useSsl: json['useSsl'] as bool?,
      libraries: (json['libraries'] as List<dynamic>?)
              ?.map((e) => PlexLibrary.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      webAppUrl: json['webAppUrl'] as String?,
    );

Map<String, dynamic> _$PlexSettingsToJson(PlexSettings instance) =>
    <String, dynamic>{
      if (instance.name case final value?) 'name': value,
      if (instance.machineId case final value?) 'machineId': value,
      'ip': instance.ip,
      'port': instance.port,
      if (instance.useSsl case final value?) 'useSsl': value,
      if (instance.libraries?.map((e) => e.toJson()).toList() case final value?)
        'libraries': value,
      if (instance.webAppUrl case final value?) 'webAppUrl': value,
    };

PlexConnection _$PlexConnectionFromJson(Map<String, dynamic> json) =>
    PlexConnection(
      protocol: json['protocol'] as String,
      address: json['address'] as String,
      port: (json['port'] as num).toDouble(),
      uri: json['uri'] as String,
      local: json['local'] as bool,
      status: (json['status'] as num?)?.toDouble(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$PlexConnectionToJson(PlexConnection instance) =>
    <String, dynamic>{
      'protocol': instance.protocol,
      'address': instance.address,
      'port': instance.port,
      'uri': instance.uri,
      'local': instance.local,
      if (instance.status case final value?) 'status': value,
      if (instance.message case final value?) 'message': value,
    };

PlexDevice _$PlexDeviceFromJson(Map<String, dynamic> json) => PlexDevice(
      name: json['name'] as String,
      product: json['product'] as String,
      productVersion: json['productVersion'] as String,
      platform: json['platform'] as String,
      platformVersion: json['platformVersion'] as String?,
      device: json['device'] as String,
      clientIdentifier: json['clientIdentifier'] as String,
      createdAt: json['createdAt'] as String,
      lastSeenAt: json['lastSeenAt'] as String,
      provides: (json['provides'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      owned: json['owned'] as bool,
      ownerID: json['ownerID'] as String?,
      home: json['home'] as bool?,
      sourceTitle: json['sourceTitle'] as String?,
      accessToken: json['accessToken'] as String?,
      publicAddress: json['publicAddress'] as String?,
      httpsRequired: json['httpsRequired'] as bool?,
      synced: json['synced'] as bool?,
      relay: json['relay'] as bool?,
      dnsRebindingProtection: json['dnsRebindingProtection'] as bool?,
      natLoopbackSupported: json['natLoopbackSupported'] as bool?,
      publicAddressMatches: json['publicAddressMatches'] as bool?,
      presence: json['presence'] as bool?,
      connection: (json['connection'] as List<dynamic>?)
              ?.map((e) => PlexConnection.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$PlexDeviceToJson(PlexDevice instance) =>
    <String, dynamic>{
      'name': instance.name,
      'product': instance.product,
      'productVersion': instance.productVersion,
      'platform': instance.platform,
      if (instance.platformVersion case final value?) 'platformVersion': value,
      'device': instance.device,
      'clientIdentifier': instance.clientIdentifier,
      'createdAt': instance.createdAt,
      'lastSeenAt': instance.lastSeenAt,
      'provides': instance.provides,
      'owned': instance.owned,
      if (instance.ownerID case final value?) 'ownerID': value,
      if (instance.home case final value?) 'home': value,
      if (instance.sourceTitle case final value?) 'sourceTitle': value,
      if (instance.accessToken case final value?) 'accessToken': value,
      if (instance.publicAddress case final value?) 'publicAddress': value,
      if (instance.httpsRequired case final value?) 'httpsRequired': value,
      if (instance.synced case final value?) 'synced': value,
      if (instance.relay case final value?) 'relay': value,
      if (instance.dnsRebindingProtection case final value?)
        'dnsRebindingProtection': value,
      if (instance.natLoopbackSupported case final value?)
        'natLoopbackSupported': value,
      if (instance.publicAddressMatches case final value?)
        'publicAddressMatches': value,
      if (instance.presence case final value?) 'presence': value,
      'connection': instance.connection.map((e) => e.toJson()).toList(),
    };

JellyfinLibrary _$JellyfinLibraryFromJson(Map<String, dynamic> json) =>
    JellyfinLibrary(
      id: json['id'] as String,
      name: json['name'] as String,
      enabled: json['enabled'] as bool,
    );

Map<String, dynamic> _$JellyfinLibraryToJson(JellyfinLibrary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'enabled': instance.enabled,
    };

JellyfinSettings _$JellyfinSettingsFromJson(Map<String, dynamic> json) =>
    JellyfinSettings(
      name: json['name'] as String?,
      hostname: json['hostname'] as String?,
      externalHostname: json['externalHostname'] as String?,
      jellyfinForgotPasswordUrl: json['jellyfinForgotPasswordUrl'] as String?,
      adminUser: json['adminUser'] as String?,
      adminPass: json['adminPass'] as String?,
      libraries: (json['libraries'] as List<dynamic>?)
              ?.map((e) => JellyfinLibrary.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      serverID: json['serverID'] as String?,
    );

Map<String, dynamic> _$JellyfinSettingsToJson(JellyfinSettings instance) =>
    <String, dynamic>{
      if (instance.name case final value?) 'name': value,
      if (instance.hostname case final value?) 'hostname': value,
      if (instance.externalHostname case final value?)
        'externalHostname': value,
      if (instance.jellyfinForgotPasswordUrl case final value?)
        'jellyfinForgotPasswordUrl': value,
      if (instance.adminUser case final value?) 'adminUser': value,
      if (instance.adminPass case final value?) 'adminPass': value,
      if (instance.libraries?.map((e) => e.toJson()).toList() case final value?)
        'libraries': value,
      if (instance.serverID case final value?) 'serverID': value,
    };

MetadataSettings _$MetadataSettingsFromJson(Map<String, dynamic> json) =>
    MetadataSettings(
      settings: json['settings'] == null
          ? null
          : MetadataSettings$Settings.fromJson(
              json['settings'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MetadataSettingsToJson(MetadataSettings instance) =>
    <String, dynamic>{
      if (instance.settings?.toJson() case final value?) 'settings': value,
    };

TautulliSettings _$TautulliSettingsFromJson(Map<String, dynamic> json) =>
    TautulliSettings(
      hostname: json['hostname'] as String?,
      port: (json['port'] as num?)?.toDouble(),
      useSsl: json['useSsl'] as bool?,
      apiKey: json['apiKey'] as String?,
      externalUrl: json['externalUrl'] as String?,
    );

Map<String, dynamic> _$TautulliSettingsToJson(TautulliSettings instance) =>
    <String, dynamic>{
      if (instance.hostname case final value?) 'hostname': value,
      if (instance.port case final value?) 'port': value,
      if (instance.useSsl case final value?) 'useSsl': value,
      if (instance.apiKey case final value?) 'apiKey': value,
      if (instance.externalUrl case final value?) 'externalUrl': value,
    };

RadarrSettings _$RadarrSettingsFromJson(Map<String, dynamic> json) =>
    RadarrSettings(
      id: (json['id'] as num?)?.toDouble(),
      name: json['name'] as String,
      hostname: json['hostname'] as String,
      port: (json['port'] as num).toDouble(),
      apiKey: json['apiKey'] as String,
      useSsl: json['useSsl'] as bool,
      baseUrl: json['baseUrl'] as String?,
      activeProfileId: (json['activeProfileId'] as num).toDouble(),
      activeProfileName: json['activeProfileName'] as String,
      activeDirectory: json['activeDirectory'] as String,
      is4k: json['is4k'] as bool,
      minimumAvailability: json['minimumAvailability'] as String,
      isDefault: json['isDefault'] as bool,
      externalUrl: json['externalUrl'] as String?,
      syncEnabled: json['syncEnabled'] as bool?,
      preventSearch: json['preventSearch'] as bool?,
    );

Map<String, dynamic> _$RadarrSettingsToJson(RadarrSettings instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      'name': instance.name,
      'hostname': instance.hostname,
      'port': instance.port,
      'apiKey': instance.apiKey,
      'useSsl': instance.useSsl,
      if (instance.baseUrl case final value?) 'baseUrl': value,
      'activeProfileId': instance.activeProfileId,
      'activeProfileName': instance.activeProfileName,
      'activeDirectory': instance.activeDirectory,
      'is4k': instance.is4k,
      'minimumAvailability': instance.minimumAvailability,
      'isDefault': instance.isDefault,
      if (instance.externalUrl case final value?) 'externalUrl': value,
      if (instance.syncEnabled case final value?) 'syncEnabled': value,
      if (instance.preventSearch case final value?) 'preventSearch': value,
    };

SonarrSettings _$SonarrSettingsFromJson(Map<String, dynamic> json) =>
    SonarrSettings(
      id: (json['id'] as num?)?.toDouble(),
      name: json['name'] as String,
      hostname: json['hostname'] as String,
      port: (json['port'] as num).toDouble(),
      apiKey: json['apiKey'] as String,
      useSsl: json['useSsl'] as bool,
      baseUrl: json['baseUrl'] as String?,
      activeProfileId: (json['activeProfileId'] as num).toDouble(),
      activeProfileName: json['activeProfileName'] as String,
      activeDirectory: json['activeDirectory'] as String,
      activeLanguageProfileId:
          (json['activeLanguageProfileId'] as num?)?.toDouble(),
      activeAnimeProfileId: (json['activeAnimeProfileId'] as num?)?.toDouble(),
      activeAnimeLanguageProfileId:
          (json['activeAnimeLanguageProfileId'] as num?)?.toDouble(),
      activeAnimeProfileName: json['activeAnimeProfileName'] as String?,
      activeAnimeDirectory: json['activeAnimeDirectory'] as String?,
      is4k: json['is4k'] as bool,
      enableSeasonFolders: json['enableSeasonFolders'] as bool,
      isDefault: json['isDefault'] as bool,
      externalUrl: json['externalUrl'] as String?,
      syncEnabled: json['syncEnabled'] as bool?,
      preventSearch: json['preventSearch'] as bool?,
    );

Map<String, dynamic> _$SonarrSettingsToJson(SonarrSettings instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      'name': instance.name,
      'hostname': instance.hostname,
      'port': instance.port,
      'apiKey': instance.apiKey,
      'useSsl': instance.useSsl,
      if (instance.baseUrl case final value?) 'baseUrl': value,
      'activeProfileId': instance.activeProfileId,
      'activeProfileName': instance.activeProfileName,
      'activeDirectory': instance.activeDirectory,
      if (instance.activeLanguageProfileId case final value?)
        'activeLanguageProfileId': value,
      if (instance.activeAnimeProfileId case final value?)
        'activeAnimeProfileId': value,
      if (instance.activeAnimeLanguageProfileId case final value?)
        'activeAnimeLanguageProfileId': value,
      if (instance.activeAnimeProfileName case final value?)
        'activeAnimeProfileName': value,
      if (instance.activeAnimeDirectory case final value?)
        'activeAnimeDirectory': value,
      'is4k': instance.is4k,
      'enableSeasonFolders': instance.enableSeasonFolders,
      'isDefault': instance.isDefault,
      if (instance.externalUrl case final value?) 'externalUrl': value,
      if (instance.syncEnabled case final value?) 'syncEnabled': value,
      if (instance.preventSearch case final value?) 'preventSearch': value,
    };

ServarrTag _$ServarrTagFromJson(Map<String, dynamic> json) => ServarrTag(
      id: (json['id'] as num?)?.toDouble(),
      label: json['label'] as String?,
    );

Map<String, dynamic> _$ServarrTagToJson(ServarrTag instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.label case final value?) 'label': value,
    };

PublicSettings _$PublicSettingsFromJson(Map<String, dynamic> json) =>
    PublicSettings(
      initialized: json['initialized'] as bool?,
    );

Map<String, dynamic> _$PublicSettingsToJson(PublicSettings instance) =>
    <String, dynamic>{
      if (instance.initialized case final value?) 'initialized': value,
    };

MovieResult _$MovieResultFromJson(Map<String, dynamic> json) => MovieResult(
      id: (json['id'] as num).toDouble(),
      mediaType: json['mediaType'] as String,
      popularity: (json['popularity'] as num?)?.toDouble(),
      posterPath: json['posterPath'] as String?,
      backdropPath: json['backdropPath'] as String?,
      voteCount: (json['voteCount'] as num?)?.toDouble(),
      voteAverage: (json['voteAverage'] as num?)?.toDouble(),
      genreIds: (json['genreIds'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          [],
      overview: json['overview'] as String?,
      originalLanguage: json['originalLanguage'] as String?,
      title: json['title'] as String,
      originalTitle: json['originalTitle'] as String?,
      releaseDate: json['releaseDate'] as String?,
      adult: json['adult'] as bool?,
      video: json['video'] as bool?,
      mediaInfo: json['mediaInfo'] == null
          ? null
          : MediaInfo.fromJson(json['mediaInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MovieResultToJson(MovieResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mediaType': instance.mediaType,
      if (instance.popularity case final value?) 'popularity': value,
      if (instance.posterPath case final value?) 'posterPath': value,
      if (instance.backdropPath case final value?) 'backdropPath': value,
      if (instance.voteCount case final value?) 'voteCount': value,
      if (instance.voteAverage case final value?) 'voteAverage': value,
      if (instance.genreIds case final value?) 'genreIds': value,
      if (instance.overview case final value?) 'overview': value,
      if (instance.originalLanguage case final value?)
        'originalLanguage': value,
      'title': instance.title,
      if (instance.originalTitle case final value?) 'originalTitle': value,
      if (instance.releaseDate case final value?) 'releaseDate': value,
      if (instance.adult case final value?) 'adult': value,
      if (instance.video case final value?) 'video': value,
      if (instance.mediaInfo?.toJson() case final value?) 'mediaInfo': value,
    };

TvResult _$TvResultFromJson(Map<String, dynamic> json) => TvResult(
      id: (json['id'] as num?)?.toDouble(),
      mediaType: json['mediaType'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      posterPath: json['posterPath'] as String?,
      backdropPath: json['backdropPath'] as String?,
      voteCount: (json['voteCount'] as num?)?.toDouble(),
      voteAverage: (json['voteAverage'] as num?)?.toDouble(),
      genreIds: (json['genreIds'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          [],
      overview: json['overview'] as String?,
      originalLanguage: json['originalLanguage'] as String?,
      name: json['name'] as String?,
      originalName: json['originalName'] as String?,
      originCountry: (json['originCountry'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      firstAirDate: json['firstAirDate'] as String?,
      mediaInfo: json['mediaInfo'] == null
          ? null
          : MediaInfo.fromJson(json['mediaInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TvResultToJson(TvResult instance) => <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.mediaType case final value?) 'mediaType': value,
      if (instance.popularity case final value?) 'popularity': value,
      if (instance.posterPath case final value?) 'posterPath': value,
      if (instance.backdropPath case final value?) 'backdropPath': value,
      if (instance.voteCount case final value?) 'voteCount': value,
      if (instance.voteAverage case final value?) 'voteAverage': value,
      if (instance.genreIds case final value?) 'genreIds': value,
      if (instance.overview case final value?) 'overview': value,
      if (instance.originalLanguage case final value?)
        'originalLanguage': value,
      if (instance.name case final value?) 'name': value,
      if (instance.originalName case final value?) 'originalName': value,
      if (instance.originCountry case final value?) 'originCountry': value,
      if (instance.firstAirDate case final value?) 'firstAirDate': value,
      if (instance.mediaInfo?.toJson() case final value?) 'mediaInfo': value,
    };

PersonResult _$PersonResultFromJson(Map<String, dynamic> json) => PersonResult(
      id: (json['id'] as num?)?.toDouble(),
      profilePath: json['profilePath'] as String?,
      adult: json['adult'] as bool?,
      mediaType: json['mediaType'] as String?,
      knownFor: (json['knownFor'] as List<dynamic>?)
              ?.map((e) => e as Object)
              .toList() ??
          [],
    );

Map<String, dynamic> _$PersonResultToJson(PersonResult instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.profilePath case final value?) 'profilePath': value,
      if (instance.adult case final value?) 'adult': value,
      if (instance.mediaType case final value?) 'mediaType': value,
      if (instance.knownFor case final value?) 'knownFor': value,
    };

Genre _$GenreFromJson(Map<String, dynamic> json) => Genre(
      id: (json['id'] as num?)?.toDouble(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$GenreToJson(Genre instance) => <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.name case final value?) 'name': value,
    };

Company _$CompanyFromJson(Map<String, dynamic> json) => Company(
      id: (json['id'] as num?)?.toDouble(),
      logoPath: json['logo_path'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$CompanyToJson(Company instance) => <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.logoPath case final value?) 'logo_path': value,
      if (instance.name case final value?) 'name': value,
    };

ProductionCompany _$ProductionCompanyFromJson(Map<String, dynamic> json) =>
    ProductionCompany(
      id: (json['id'] as num?)?.toDouble(),
      logoPath: json['logoPath'] as String?,
      originCountry: json['originCountry'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ProductionCompanyToJson(ProductionCompany instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.logoPath case final value?) 'logoPath': value,
      if (instance.originCountry case final value?) 'originCountry': value,
      if (instance.name case final value?) 'name': value,
    };

Network _$NetworkFromJson(Map<String, dynamic> json) => Network(
      id: (json['id'] as num?)?.toDouble(),
      logoPath: json['logoPath'] as String?,
      originCountry: json['originCountry'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$NetworkToJson(Network instance) => <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.logoPath case final value?) 'logoPath': value,
      if (instance.originCountry case final value?) 'originCountry': value,
      if (instance.name case final value?) 'name': value,
    };

RelatedVideo _$RelatedVideoFromJson(Map<String, dynamic> json) => RelatedVideo(
      url: json['url'] as String?,
      key: json['key'] as String?,
      name: json['name'] as String?,
      size: (json['size'] as num?)?.toDouble(),
      type: relatedVideoTypeNullableFromJson(json['type']),
      site: relatedVideoSiteNullableFromJson(json['site']),
    );

Map<String, dynamic> _$RelatedVideoToJson(RelatedVideo instance) =>
    <String, dynamic>{
      if (instance.url case final value?) 'url': value,
      if (instance.key case final value?) 'key': value,
      if (instance.name case final value?) 'name': value,
      if (instance.size case final value?) 'size': value,
      if (relatedVideoTypeNullableToJson(instance.type) case final value?)
        'type': value,
      if (relatedVideoSiteNullableToJson(instance.site) case final value?)
        'site': value,
    };

MovieDetails _$MovieDetailsFromJson(Map<String, dynamic> json) => MovieDetails(
      id: (json['id'] as num?)?.toDouble(),
      imdbId: json['imdbId'] as String?,
      adult: json['adult'] as bool?,
      backdropPath: json['backdropPath'] as String?,
      posterPath: json['posterPath'] as String?,
      budget: (json['budget'] as num?)?.toDouble(),
      genres: (json['genres'] as List<dynamic>?)
              ?.map((e) => Genre.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      homepage: json['homepage'] as String?,
      relatedVideos: (json['relatedVideos'] as List<dynamic>?)
              ?.map((e) => RelatedVideo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      originalLanguage: json['originalLanguage'] as String?,
      originalTitle: json['originalTitle'] as String?,
      overview: json['overview'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      productionCompanies: (json['productionCompanies'] as List<dynamic>?)
              ?.map(
                  (e) => ProductionCompany.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      productionCountries: (json['productionCountries'] as List<dynamic>?)
          ?.map((e) => MovieDetails$ProductionCountries$Item.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      releaseDate: json['releaseDate'] as String?,
      releases: json['releases'] == null
          ? null
          : MovieDetails$Releases.fromJson(
              json['releases'] as Map<String, dynamic>),
      revenue: (json['revenue'] as num?)?.toDouble(),
      runtime: (json['runtime'] as num?)?.toDouble(),
      spokenLanguages: (json['spokenLanguages'] as List<dynamic>?)
              ?.map((e) => SpokenLanguage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      status: json['status'] as String?,
      tagline: json['tagline'] as String?,
      title: json['title'] as String?,
      video: json['video'] as bool?,
      voteAverage: (json['voteAverage'] as num?)?.toDouble(),
      voteCount: (json['voteCount'] as num?)?.toDouble(),
      credits: json['credits'] == null
          ? null
          : MovieDetails$Credits.fromJson(
              json['credits'] as Map<String, dynamic>),
      collection: json['collection'] == null
          ? null
          : MovieDetails$Collection.fromJson(
              json['collection'] as Map<String, dynamic>),
      externalIds: json['externalIds'] == null
          ? null
          : ExternalIds.fromJson(json['externalIds'] as Map<String, dynamic>),
      mediaInfo: json['mediaInfo'] == null
          ? null
          : MediaInfo.fromJson(json['mediaInfo'] as Map<String, dynamic>),
      watchProviders: (json['watchProviders'] as List<dynamic>?)
              ?.map((e) => (e as List<dynamic>)
                  .map((e) =>
                      WatchProviders$Item.fromJson(e as Map<String, dynamic>))
                  .toList())
              .toList() ??
          [],
    );

Map<String, dynamic> _$MovieDetailsToJson(MovieDetails instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.imdbId case final value?) 'imdbId': value,
      if (instance.adult case final value?) 'adult': value,
      if (instance.backdropPath case final value?) 'backdropPath': value,
      if (instance.posterPath case final value?) 'posterPath': value,
      if (instance.budget case final value?) 'budget': value,
      if (instance.genres?.map((e) => e.toJson()).toList() case final value?)
        'genres': value,
      if (instance.homepage case final value?) 'homepage': value,
      if (instance.relatedVideos?.map((e) => e.toJson()).toList()
          case final value?)
        'relatedVideos': value,
      if (instance.originalLanguage case final value?)
        'originalLanguage': value,
      if (instance.originalTitle case final value?) 'originalTitle': value,
      if (instance.overview case final value?) 'overview': value,
      if (instance.popularity case final value?) 'popularity': value,
      if (instance.productionCompanies?.map((e) => e.toJson()).toList()
          case final value?)
        'productionCompanies': value,
      if (instance.productionCountries?.map((e) => e.toJson()).toList()
          case final value?)
        'productionCountries': value,
      if (instance.releaseDate case final value?) 'releaseDate': value,
      if (instance.releases?.toJson() case final value?) 'releases': value,
      if (instance.revenue case final value?) 'revenue': value,
      if (instance.runtime case final value?) 'runtime': value,
      if (instance.spokenLanguages?.map((e) => e.toJson()).toList()
          case final value?)
        'spokenLanguages': value,
      if (instance.status case final value?) 'status': value,
      if (instance.tagline case final value?) 'tagline': value,
      if (instance.title case final value?) 'title': value,
      if (instance.video case final value?) 'video': value,
      if (instance.voteAverage case final value?) 'voteAverage': value,
      if (instance.voteCount case final value?) 'voteCount': value,
      if (instance.credits?.toJson() case final value?) 'credits': value,
      if (instance.collection?.toJson() case final value?) 'collection': value,
      if (instance.externalIds?.toJson() case final value?)
        'externalIds': value,
      if (instance.mediaInfo?.toJson() case final value?) 'mediaInfo': value,
      if (instance.watchProviders
              ?.map((e) => e.map((e) => e.toJson()).toList())
              .toList()
          case final value?)
        'watchProviders': value,
    };

Episode _$EpisodeFromJson(Map<String, dynamic> json) => Episode(
      id: (json['id'] as num?)?.toDouble(),
      name: json['name'] as String?,
      airDate: json['airDate'] as String?,
      episodeNumber: (json['episodeNumber'] as num?)?.toDouble(),
      overview: json['overview'] as String?,
      productionCode: json['productionCode'] as String?,
      seasonNumber: (json['seasonNumber'] as num?)?.toDouble(),
      showId: (json['showId'] as num?)?.toDouble(),
      stillPath: json['stillPath'] as String?,
      voteAverage: (json['voteAverage'] as num?)?.toDouble(),
      voteCount: (json['voteCount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$EpisodeToJson(Episode instance) => <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.name case final value?) 'name': value,
      if (instance.airDate case final value?) 'airDate': value,
      if (instance.episodeNumber case final value?) 'episodeNumber': value,
      if (instance.overview case final value?) 'overview': value,
      if (instance.productionCode case final value?) 'productionCode': value,
      if (instance.seasonNumber case final value?) 'seasonNumber': value,
      if (instance.showId case final value?) 'showId': value,
      if (instance.stillPath case final value?) 'stillPath': value,
      if (instance.voteAverage case final value?) 'voteAverage': value,
      if (instance.voteCount case final value?) 'voteCount': value,
    };

Season _$SeasonFromJson(Map<String, dynamic> json) => Season(
      id: (json['id'] as num?)?.toDouble(),
      airDate: json['airDate'] as String?,
      episodeCount: (json['episodeCount'] as num?)?.toDouble(),
      name: json['name'] as String?,
      overview: json['overview'] as String?,
      posterPath: json['posterPath'] as String?,
      seasonNumber: (json['seasonNumber'] as num?)?.toDouble(),
      episodes: (json['episodes'] as List<dynamic>?)
              ?.map((e) => Episode.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$SeasonToJson(Season instance) => <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.airDate case final value?) 'airDate': value,
      if (instance.episodeCount case final value?) 'episodeCount': value,
      if (instance.name case final value?) 'name': value,
      if (instance.overview case final value?) 'overview': value,
      if (instance.posterPath case final value?) 'posterPath': value,
      if (instance.seasonNumber case final value?) 'seasonNumber': value,
      if (instance.episodes?.map((e) => e.toJson()).toList() case final value?)
        'episodes': value,
    };

TvDetails _$TvDetailsFromJson(Map<String, dynamic> json) => TvDetails(
      id: (json['id'] as num?)?.toDouble(),
      backdropPath: json['backdropPath'] as String?,
      posterPath: json['posterPath'] as String?,
      contentRatings: json['contentRatings'] == null
          ? null
          : TvDetails$ContentRatings.fromJson(
              json['contentRatings'] as Map<String, dynamic>),
      createdBy: (json['createdBy'] as List<dynamic>?)
          ?.map((e) =>
              TvDetails$CreatedBy$Item.fromJson(e as Map<String, dynamic>))
          .toList(),
      episodeRunTime: (json['episodeRunTime'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          [],
      firstAirDate: json['firstAirDate'] as String?,
      genres: (json['genres'] as List<dynamic>?)
              ?.map((e) => Genre.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      homepage: json['homepage'] as String?,
      inProduction: json['inProduction'] as bool?,
      languages: (json['languages'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      lastAirDate: json['lastAirDate'] as String?,
      lastEpisodeToAir: json['lastEpisodeToAir'] == null
          ? null
          : Episode.fromJson(json['lastEpisodeToAir'] as Map<String, dynamic>),
      name: json['name'] as String?,
      nextEpisodeToAir: json['nextEpisodeToAir'] == null
          ? null
          : Episode.fromJson(json['nextEpisodeToAir'] as Map<String, dynamic>),
      networks: (json['networks'] as List<dynamic>?)
              ?.map(
                  (e) => ProductionCompany.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      numberOfEpisodes: (json['numberOfEpisodes'] as num?)?.toDouble(),
      numberOfSeason: (json['numberOfSeason'] as num?)?.toDouble(),
      originCountry: (json['originCountry'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      originalLanguage: json['originalLanguage'] as String?,
      originalName: json['originalName'] as String?,
      overview: json['overview'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      productionCompanies: (json['productionCompanies'] as List<dynamic>?)
              ?.map(
                  (e) => ProductionCompany.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      productionCountries: (json['productionCountries'] as List<dynamic>?)
          ?.map((e) => TvDetails$ProductionCountries$Item.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      spokenLanguages: (json['spokenLanguages'] as List<dynamic>?)
              ?.map((e) => SpokenLanguage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      seasons: (json['seasons'] as List<dynamic>?)
              ?.map((e) => Season.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      status: json['status'] as String?,
      tagline: json['tagline'] as String?,
      type: json['type'] as String?,
      voteAverage: (json['voteAverage'] as num?)?.toDouble(),
      voteCount: (json['voteCount'] as num?)?.toDouble(),
      credits: json['credits'] == null
          ? null
          : TvDetails$Credits.fromJson(json['credits'] as Map<String, dynamic>),
      externalIds: json['externalIds'] == null
          ? null
          : ExternalIds.fromJson(json['externalIds'] as Map<String, dynamic>),
      keywords: (json['keywords'] as List<dynamic>?)
              ?.map((e) => Keyword.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      mediaInfo: json['mediaInfo'] == null
          ? null
          : MediaInfo.fromJson(json['mediaInfo'] as Map<String, dynamic>),
      watchProviders: (json['watchProviders'] as List<dynamic>?)
              ?.map((e) => (e as List<dynamic>)
                  .map((e) =>
                      WatchProviders$Item.fromJson(e as Map<String, dynamic>))
                  .toList())
              .toList() ??
          [],
    );

Map<String, dynamic> _$TvDetailsToJson(TvDetails instance) => <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.backdropPath case final value?) 'backdropPath': value,
      if (instance.posterPath case final value?) 'posterPath': value,
      if (instance.contentRatings?.toJson() case final value?)
        'contentRatings': value,
      if (instance.createdBy?.map((e) => e.toJson()).toList() case final value?)
        'createdBy': value,
      if (instance.episodeRunTime case final value?) 'episodeRunTime': value,
      if (instance.firstAirDate case final value?) 'firstAirDate': value,
      if (instance.genres?.map((e) => e.toJson()).toList() case final value?)
        'genres': value,
      if (instance.homepage case final value?) 'homepage': value,
      if (instance.inProduction case final value?) 'inProduction': value,
      if (instance.languages case final value?) 'languages': value,
      if (instance.lastAirDate case final value?) 'lastAirDate': value,
      if (instance.lastEpisodeToAir?.toJson() case final value?)
        'lastEpisodeToAir': value,
      if (instance.name case final value?) 'name': value,
      if (instance.nextEpisodeToAir?.toJson() case final value?)
        'nextEpisodeToAir': value,
      if (instance.networks?.map((e) => e.toJson()).toList() case final value?)
        'networks': value,
      if (instance.numberOfEpisodes case final value?)
        'numberOfEpisodes': value,
      if (instance.numberOfSeason case final value?) 'numberOfSeason': value,
      if (instance.originCountry case final value?) 'originCountry': value,
      if (instance.originalLanguage case final value?)
        'originalLanguage': value,
      if (instance.originalName case final value?) 'originalName': value,
      if (instance.overview case final value?) 'overview': value,
      if (instance.popularity case final value?) 'popularity': value,
      if (instance.productionCompanies?.map((e) => e.toJson()).toList()
          case final value?)
        'productionCompanies': value,
      if (instance.productionCountries?.map((e) => e.toJson()).toList()
          case final value?)
        'productionCountries': value,
      if (instance.spokenLanguages?.map((e) => e.toJson()).toList()
          case final value?)
        'spokenLanguages': value,
      if (instance.seasons?.map((e) => e.toJson()).toList() case final value?)
        'seasons': value,
      if (instance.status case final value?) 'status': value,
      if (instance.tagline case final value?) 'tagline': value,
      if (instance.type case final value?) 'type': value,
      if (instance.voteAverage case final value?) 'voteAverage': value,
      if (instance.voteCount case final value?) 'voteCount': value,
      if (instance.credits?.toJson() case final value?) 'credits': value,
      if (instance.externalIds?.toJson() case final value?)
        'externalIds': value,
      if (instance.keywords?.map((e) => e.toJson()).toList() case final value?)
        'keywords': value,
      if (instance.mediaInfo?.toJson() case final value?) 'mediaInfo': value,
      if (instance.watchProviders
              ?.map((e) => e.map((e) => e.toJson()).toList())
              .toList()
          case final value?)
        'watchProviders': value,
    };

MediaRequest _$MediaRequestFromJson(Map<String, dynamic> json) => MediaRequest(
      id: (json['id'] as num?)?.toDouble(),
      status: (json['status'] as num?)?.toDouble(),
      media: json['media'] == null
          ? null
          : MediaInfo.fromJson(json['media'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      requestedBy: json['requestedBy'] == null
          ? null
          : User.fromJson(json['requestedBy'] as Map<String, dynamic>),
      modifiedBy: json['modifiedBy'],
      is4k: json['is4k'] as bool?,
      serverId: (json['serverId'] as num?)?.toDouble(),
      profileId: (json['profileId'] as num?)?.toDouble(),
      rootFolder: json['rootFolder'] as String?,
    );

Map<String, dynamic> _$MediaRequestToJson(MediaRequest instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.status case final value?) 'status': value,
      if (instance.media?.toJson() case final value?) 'media': value,
      if (instance.createdAt case final value?) 'createdAt': value,
      if (instance.updatedAt case final value?) 'updatedAt': value,
      if (instance.requestedBy?.toJson() case final value?)
        'requestedBy': value,
      if (instance.modifiedBy case final value?) 'modifiedBy': value,
      if (instance.is4k case final value?) 'is4k': value,
      if (instance.serverId case final value?) 'serverId': value,
      if (instance.profileId case final value?) 'profileId': value,
      if (instance.rootFolder case final value?) 'rootFolder': value,
    };

MediaInfo _$MediaInfoFromJson(Map<String, dynamic> json) => MediaInfo(
      id: (json['id'] as num?)?.toDouble(),
      tmdbId: (json['tmdbId'] as num?)?.toDouble(),
      tvdbId: (json['tvdbId'] as num?)?.toDouble(),
      status: (json['status'] as num?)?.toDouble(),
      requests: (json['requests'] as List<dynamic>?)
              ?.map((e) => MediaRequest.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$MediaInfoToJson(MediaInfo instance) => <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.tmdbId case final value?) 'tmdbId': value,
      if (instance.tvdbId case final value?) 'tvdbId': value,
      if (instance.status case final value?) 'status': value,
      if (instance.requests?.map((e) => e.toJson()).toList() case final value?)
        'requests': value,
      if (instance.createdAt case final value?) 'createdAt': value,
      if (instance.updatedAt case final value?) 'updatedAt': value,
    };

Cast _$CastFromJson(Map<String, dynamic> json) => Cast(
      id: (json['id'] as num?)?.toDouble(),
      castId: (json['castId'] as num?)?.toDouble(),
      character: json['character'] as String?,
      creditId: json['creditId'] as String?,
      gender: (json['gender'] as num?)?.toDouble(),
      name: json['name'] as String?,
      order: (json['order'] as num?)?.toDouble(),
      profilePath: json['profilePath'] as String?,
    );

Map<String, dynamic> _$CastToJson(Cast instance) => <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.castId case final value?) 'castId': value,
      if (instance.character case final value?) 'character': value,
      if (instance.creditId case final value?) 'creditId': value,
      if (instance.gender case final value?) 'gender': value,
      if (instance.name case final value?) 'name': value,
      if (instance.order case final value?) 'order': value,
      if (instance.profilePath case final value?) 'profilePath': value,
    };

Crew _$CrewFromJson(Map<String, dynamic> json) => Crew(
      id: (json['id'] as num?)?.toDouble(),
      creditId: json['creditId'] as String?,
      gender: (json['gender'] as num?)?.toDouble(),
      name: json['name'] as String?,
      job: json['job'] as String?,
      department: json['department'] as String?,
      profilePath: json['profilePath'] as String?,
    );

Map<String, dynamic> _$CrewToJson(Crew instance) => <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.creditId case final value?) 'creditId': value,
      if (instance.gender case final value?) 'gender': value,
      if (instance.name case final value?) 'name': value,
      if (instance.job case final value?) 'job': value,
      if (instance.department case final value?) 'department': value,
      if (instance.profilePath case final value?) 'profilePath': value,
    };

ExternalIds _$ExternalIdsFromJson(Map<String, dynamic> json) => ExternalIds(
      facebookId: json['facebookId'] as String?,
      freebaseId: json['freebaseId'] as String?,
      freebaseMid: json['freebaseMid'] as String?,
      imdbId: json['imdbId'] as String?,
      instagramId: json['instagramId'] as String?,
      tvdbId: (json['tvdbId'] as num?)?.toDouble(),
      tvrageId: (json['tvrageId'] as num?)?.toDouble(),
      twitterId: json['twitterId'] as String?,
    );

Map<String, dynamic> _$ExternalIdsToJson(ExternalIds instance) =>
    <String, dynamic>{
      if (instance.facebookId case final value?) 'facebookId': value,
      if (instance.freebaseId case final value?) 'freebaseId': value,
      if (instance.freebaseMid case final value?) 'freebaseMid': value,
      if (instance.imdbId case final value?) 'imdbId': value,
      if (instance.instagramId case final value?) 'instagramId': value,
      if (instance.tvdbId case final value?) 'tvdbId': value,
      if (instance.tvrageId case final value?) 'tvrageId': value,
      if (instance.twitterId case final value?) 'twitterId': value,
    };

ServiceProfile _$ServiceProfileFromJson(Map<String, dynamic> json) =>
    ServiceProfile(
      id: (json['id'] as num?)?.toDouble(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ServiceProfileToJson(ServiceProfile instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.name case final value?) 'name': value,
    };

PageInfo _$PageInfoFromJson(Map<String, dynamic> json) => PageInfo(
      page: (json['page'] as num?)?.toDouble(),
      pages: (json['pages'] as num?)?.toDouble(),
      results: (json['results'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$PageInfoToJson(PageInfo instance) => <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.pages case final value?) 'pages': value,
      if (instance.results case final value?) 'results': value,
    };

DiscordSettings _$DiscordSettingsFromJson(Map<String, dynamic> json) =>
    DiscordSettings(
      enabled: json['enabled'] as bool?,
      types: (json['types'] as num?)?.toDouble(),
      options: json['options'] == null
          ? null
          : DiscordSettings$Options.fromJson(
              json['options'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DiscordSettingsToJson(DiscordSettings instance) =>
    <String, dynamic>{
      if (instance.enabled case final value?) 'enabled': value,
      if (instance.types case final value?) 'types': value,
      if (instance.options?.toJson() case final value?) 'options': value,
    };

SlackSettings _$SlackSettingsFromJson(Map<String, dynamic> json) =>
    SlackSettings(
      enabled: json['enabled'] as bool?,
      types: (json['types'] as num?)?.toDouble(),
      options: json['options'] == null
          ? null
          : SlackSettings$Options.fromJson(
              json['options'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SlackSettingsToJson(SlackSettings instance) =>
    <String, dynamic>{
      if (instance.enabled case final value?) 'enabled': value,
      if (instance.types case final value?) 'types': value,
      if (instance.options?.toJson() case final value?) 'options': value,
    };

WebPushSettings _$WebPushSettingsFromJson(Map<String, dynamic> json) =>
    WebPushSettings(
      enabled: json['enabled'] as bool?,
      types: (json['types'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$WebPushSettingsToJson(WebPushSettings instance) =>
    <String, dynamic>{
      if (instance.enabled case final value?) 'enabled': value,
      if (instance.types case final value?) 'types': value,
    };

WebhookSettings _$WebhookSettingsFromJson(Map<String, dynamic> json) =>
    WebhookSettings(
      enabled: json['enabled'] as bool?,
      types: (json['types'] as num?)?.toDouble(),
      options: json['options'] == null
          ? null
          : WebhookSettings$Options.fromJson(
              json['options'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WebhookSettingsToJson(WebhookSettings instance) =>
    <String, dynamic>{
      if (instance.enabled case final value?) 'enabled': value,
      if (instance.types case final value?) 'types': value,
      if (instance.options?.toJson() case final value?) 'options': value,
    };

TelegramSettings _$TelegramSettingsFromJson(Map<String, dynamic> json) =>
    TelegramSettings(
      enabled: json['enabled'] as bool?,
      types: (json['types'] as num?)?.toDouble(),
      options: json['options'] == null
          ? null
          : TelegramSettings$Options.fromJson(
              json['options'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TelegramSettingsToJson(TelegramSettings instance) =>
    <String, dynamic>{
      if (instance.enabled case final value?) 'enabled': value,
      if (instance.types case final value?) 'types': value,
      if (instance.options?.toJson() case final value?) 'options': value,
    };

PushbulletSettings _$PushbulletSettingsFromJson(Map<String, dynamic> json) =>
    PushbulletSettings(
      enabled: json['enabled'] as bool?,
      types: (json['types'] as num?)?.toDouble(),
      options: json['options'] == null
          ? null
          : PushbulletSettings$Options.fromJson(
              json['options'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PushbulletSettingsToJson(PushbulletSettings instance) =>
    <String, dynamic>{
      if (instance.enabled case final value?) 'enabled': value,
      if (instance.types case final value?) 'types': value,
      if (instance.options?.toJson() case final value?) 'options': value,
    };

PushoverSettings _$PushoverSettingsFromJson(Map<String, dynamic> json) =>
    PushoverSettings(
      enabled: json['enabled'] as bool?,
      types: (json['types'] as num?)?.toDouble(),
      options: json['options'] == null
          ? null
          : PushoverSettings$Options.fromJson(
              json['options'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PushoverSettingsToJson(PushoverSettings instance) =>
    <String, dynamic>{
      if (instance.enabled case final value?) 'enabled': value,
      if (instance.types case final value?) 'types': value,
      if (instance.options?.toJson() case final value?) 'options': value,
    };

GotifySettings _$GotifySettingsFromJson(Map<String, dynamic> json) =>
    GotifySettings(
      enabled: json['enabled'] as bool?,
      types: (json['types'] as num?)?.toDouble(),
      options: json['options'] == null
          ? null
          : GotifySettings$Options.fromJson(
              json['options'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GotifySettingsToJson(GotifySettings instance) =>
    <String, dynamic>{
      if (instance.enabled case final value?) 'enabled': value,
      if (instance.types case final value?) 'types': value,
      if (instance.options?.toJson() case final value?) 'options': value,
    };

NtfySettings _$NtfySettingsFromJson(Map<String, dynamic> json) => NtfySettings(
      enabled: json['enabled'] as bool?,
      types: (json['types'] as num?)?.toDouble(),
      options: json['options'] == null
          ? null
          : NtfySettings$Options.fromJson(
              json['options'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NtfySettingsToJson(NtfySettings instance) =>
    <String, dynamic>{
      if (instance.enabled case final value?) 'enabled': value,
      if (instance.types case final value?) 'types': value,
      if (instance.options?.toJson() case final value?) 'options': value,
    };

NotificationEmailSettings _$NotificationEmailSettingsFromJson(
        Map<String, dynamic> json) =>
    NotificationEmailSettings(
      enabled: json['enabled'] as bool?,
      types: (json['types'] as num?)?.toDouble(),
      options: json['options'] == null
          ? null
          : NotificationEmailSettings$Options.fromJson(
              json['options'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NotificationEmailSettingsToJson(
        NotificationEmailSettings instance) =>
    <String, dynamic>{
      if (instance.enabled case final value?) 'enabled': value,
      if (instance.types case final value?) 'types': value,
      if (instance.options?.toJson() case final value?) 'options': value,
    };

Job _$JobFromJson(Map<String, dynamic> json) => Job(
      id: json['id'] as String?,
      type: jobTypeNullableFromJson(json['type']),
      interval: jobIntervalNullableFromJson(json['interval']),
      name: json['name'] as String?,
      nextExecutionTime: json['nextExecutionTime'] as String?,
      running: json['running'] as bool?,
    );

Map<String, dynamic> _$JobToJson(Job instance) => <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (jobTypeNullableToJson(instance.type) case final value?) 'type': value,
      if (jobIntervalNullableToJson(instance.interval) case final value?)
        'interval': value,
      if (instance.name case final value?) 'name': value,
      if (instance.nextExecutionTime case final value?)
        'nextExecutionTime': value,
      if (instance.running case final value?) 'running': value,
    };

PersonDetails _$PersonDetailsFromJson(Map<String, dynamic> json) =>
    PersonDetails(
      id: (json['id'] as num?)?.toDouble(),
      name: json['name'] as String?,
      deathday: json['deathday'] as String?,
      knownForDepartment: json['knownForDepartment'] as String?,
      alsoKnownAs: (json['alsoKnownAs'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      gender: json['gender'] as String?,
      biography: json['biography'] as String?,
      popularity: json['popularity'] as String?,
      placeOfBirth: json['placeOfBirth'] as String?,
      profilePath: json['profilePath'] as String?,
      adult: json['adult'] as bool?,
      imdbId: json['imdbId'] as String?,
      homepage: json['homepage'] as String?,
    );

Map<String, dynamic> _$PersonDetailsToJson(PersonDetails instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.name case final value?) 'name': value,
      if (instance.deathday case final value?) 'deathday': value,
      if (instance.knownForDepartment case final value?)
        'knownForDepartment': value,
      if (instance.alsoKnownAs case final value?) 'alsoKnownAs': value,
      if (instance.gender case final value?) 'gender': value,
      if (instance.biography case final value?) 'biography': value,
      if (instance.popularity case final value?) 'popularity': value,
      if (instance.placeOfBirth case final value?) 'placeOfBirth': value,
      if (instance.profilePath case final value?) 'profilePath': value,
      if (instance.adult case final value?) 'adult': value,
      if (instance.imdbId case final value?) 'imdbId': value,
      if (instance.homepage case final value?) 'homepage': value,
    };

CreditCast _$CreditCastFromJson(Map<String, dynamic> json) => CreditCast(
      id: (json['id'] as num?)?.toDouble(),
      originalLanguage: json['originalLanguage'] as String?,
      episodeCount: (json['episodeCount'] as num?)?.toDouble(),
      overview: json['overview'] as String?,
      originCountry: (json['originCountry'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      originalName: json['originalName'] as String?,
      voteCount: (json['voteCount'] as num?)?.toDouble(),
      name: json['name'] as String?,
      mediaType: json['mediaType'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      creditId: json['creditId'] as String?,
      backdropPath: json['backdropPath'] as String?,
      firstAirDate: json['firstAirDate'] as String?,
      voteAverage: (json['voteAverage'] as num?)?.toDouble(),
      genreIds: (json['genreIds'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          [],
      posterPath: json['posterPath'] as String?,
      originalTitle: json['originalTitle'] as String?,
      video: json['video'] as bool?,
      title: json['title'] as String?,
      adult: json['adult'] as bool?,
      releaseDate: json['releaseDate'] as String?,
      character: json['character'] as String?,
      mediaInfo: json['mediaInfo'] == null
          ? null
          : MediaInfo.fromJson(json['mediaInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreditCastToJson(CreditCast instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.originalLanguage case final value?)
        'originalLanguage': value,
      if (instance.episodeCount case final value?) 'episodeCount': value,
      if (instance.overview case final value?) 'overview': value,
      if (instance.originCountry case final value?) 'originCountry': value,
      if (instance.originalName case final value?) 'originalName': value,
      if (instance.voteCount case final value?) 'voteCount': value,
      if (instance.name case final value?) 'name': value,
      if (instance.mediaType case final value?) 'mediaType': value,
      if (instance.popularity case final value?) 'popularity': value,
      if (instance.creditId case final value?) 'creditId': value,
      if (instance.backdropPath case final value?) 'backdropPath': value,
      if (instance.firstAirDate case final value?) 'firstAirDate': value,
      if (instance.voteAverage case final value?) 'voteAverage': value,
      if (instance.genreIds case final value?) 'genreIds': value,
      if (instance.posterPath case final value?) 'posterPath': value,
      if (instance.originalTitle case final value?) 'originalTitle': value,
      if (instance.video case final value?) 'video': value,
      if (instance.title case final value?) 'title': value,
      if (instance.adult case final value?) 'adult': value,
      if (instance.releaseDate case final value?) 'releaseDate': value,
      if (instance.character case final value?) 'character': value,
      if (instance.mediaInfo?.toJson() case final value?) 'mediaInfo': value,
    };

CreditCrew _$CreditCrewFromJson(Map<String, dynamic> json) => CreditCrew(
      id: (json['id'] as num?)?.toDouble(),
      originalLanguage: json['originalLanguage'] as String?,
      episodeCount: (json['episodeCount'] as num?)?.toDouble(),
      overview: json['overview'] as String?,
      originCountry: (json['originCountry'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      originalName: json['originalName'] as String?,
      voteCount: (json['voteCount'] as num?)?.toDouble(),
      name: json['name'] as String?,
      mediaType: json['mediaType'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      creditId: json['creditId'] as String?,
      backdropPath: json['backdropPath'] as String?,
      firstAirDate: json['firstAirDate'] as String?,
      voteAverage: (json['voteAverage'] as num?)?.toDouble(),
      genreIds: (json['genreIds'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          [],
      posterPath: json['posterPath'] as String?,
      originalTitle: json['originalTitle'] as String?,
      video: json['video'] as bool?,
      title: json['title'] as String?,
      adult: json['adult'] as bool?,
      releaseDate: json['releaseDate'] as String?,
      department: json['department'] as String?,
      job: json['job'] as String?,
      mediaInfo: json['mediaInfo'] == null
          ? null
          : MediaInfo.fromJson(json['mediaInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreditCrewToJson(CreditCrew instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.originalLanguage case final value?)
        'originalLanguage': value,
      if (instance.episodeCount case final value?) 'episodeCount': value,
      if (instance.overview case final value?) 'overview': value,
      if (instance.originCountry case final value?) 'originCountry': value,
      if (instance.originalName case final value?) 'originalName': value,
      if (instance.voteCount case final value?) 'voteCount': value,
      if (instance.name case final value?) 'name': value,
      if (instance.mediaType case final value?) 'mediaType': value,
      if (instance.popularity case final value?) 'popularity': value,
      if (instance.creditId case final value?) 'creditId': value,
      if (instance.backdropPath case final value?) 'backdropPath': value,
      if (instance.firstAirDate case final value?) 'firstAirDate': value,
      if (instance.voteAverage case final value?) 'voteAverage': value,
      if (instance.genreIds case final value?) 'genreIds': value,
      if (instance.posterPath case final value?) 'posterPath': value,
      if (instance.originalTitle case final value?) 'originalTitle': value,
      if (instance.video case final value?) 'video': value,
      if (instance.title case final value?) 'title': value,
      if (instance.adult case final value?) 'adult': value,
      if (instance.releaseDate case final value?) 'releaseDate': value,
      if (instance.department case final value?) 'department': value,
      if (instance.job case final value?) 'job': value,
      if (instance.mediaInfo?.toJson() case final value?) 'mediaInfo': value,
    };

Keyword _$KeywordFromJson(Map<String, dynamic> json) => Keyword(
      id: (json['id'] as num?)?.toDouble(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$KeywordToJson(Keyword instance) => <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.name case final value?) 'name': value,
    };

SpokenLanguage _$SpokenLanguageFromJson(Map<String, dynamic> json) =>
    SpokenLanguage(
      englishName: json['englishName'] as String?,
      iso6391: json['iso_639_1'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$SpokenLanguageToJson(SpokenLanguage instance) =>
    <String, dynamic>{
      if (instance.englishName case final value?) 'englishName': value,
      if (instance.iso6391 case final value?) 'iso_639_1': value,
      if (instance.name case final value?) 'name': value,
    };

Collection _$CollectionFromJson(Map<String, dynamic> json) => Collection(
      id: (json['id'] as num?)?.toDouble(),
      name: json['name'] as String?,
      overview: json['overview'] as String?,
      posterPath: json['posterPath'] as String?,
      backdropPath: json['backdropPath'] as String?,
      parts: (json['parts'] as List<dynamic>?)
              ?.map((e) => MovieResult.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$CollectionToJson(Collection instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.name case final value?) 'name': value,
      if (instance.overview case final value?) 'overview': value,
      if (instance.posterPath case final value?) 'posterPath': value,
      if (instance.backdropPath case final value?) 'backdropPath': value,
      if (instance.parts?.map((e) => e.toJson()).toList() case final value?)
        'parts': value,
    };

SonarrSeries _$SonarrSeriesFromJson(Map<String, dynamic> json) => SonarrSeries(
      title: json['title'] as String?,
      sortTitle: json['sortTitle'] as String?,
      seasonCount: (json['seasonCount'] as num?)?.toDouble(),
      status: json['status'] as String?,
      overview: json['overview'] as String?,
      network: json['network'] as String?,
      airTime: json['airTime'] as String?,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) =>
              SonarrSeries$Images$Item.fromJson(e as Map<String, dynamic>))
          .toList(),
      remotePoster: json['remotePoster'] as String?,
      seasons: (json['seasons'] as List<dynamic>?)
          ?.map((e) =>
              SonarrSeries$Seasons$Item.fromJson(e as Map<String, dynamic>))
          .toList(),
      year: (json['year'] as num?)?.toDouble(),
      path: json['path'] as String?,
      profileId: (json['profileId'] as num?)?.toDouble(),
      languageProfileId: (json['languageProfileId'] as num?)?.toDouble(),
      seasonFolder: json['seasonFolder'] as bool?,
      monitored: json['monitored'] as bool?,
      useSceneNumbering: json['useSceneNumbering'] as bool?,
      runtime: (json['runtime'] as num?)?.toDouble(),
      tvdbId: (json['tvdbId'] as num?)?.toDouble(),
      tvRageId: (json['tvRageId'] as num?)?.toDouble(),
      tvMazeId: (json['tvMazeId'] as num?)?.toDouble(),
      firstAired: json['firstAired'] as String?,
      lastInfoSync: json['lastInfoSync'] as String?,
      seriesType: json['seriesType'] as String?,
      cleanTitle: json['cleanTitle'] as String?,
      imdbId: json['imdbId'] as String?,
      titleSlug: json['titleSlug'] as String?,
      certification: json['certification'] as String?,
      genres: (json['genres'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      added: json['added'] as String?,
      ratings: (json['ratings'] as List<dynamic>?)
          ?.map((e) =>
              SonarrSeries$Ratings$Item.fromJson(e as Map<String, dynamic>))
          .toList(),
      qualityProfileId: (json['qualityProfileId'] as num?)?.toDouble(),
      id: (json['id'] as num?)?.toDouble(),
      rootFolderPath: json['rootFolderPath'] as String?,
      addOptions: (json['addOptions'] as List<dynamic>?)
          ?.map((e) =>
              SonarrSeries$AddOptions$Item.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SonarrSeriesToJson(SonarrSeries instance) =>
    <String, dynamic>{
      if (instance.title case final value?) 'title': value,
      if (instance.sortTitle case final value?) 'sortTitle': value,
      if (instance.seasonCount case final value?) 'seasonCount': value,
      if (instance.status case final value?) 'status': value,
      if (instance.overview case final value?) 'overview': value,
      if (instance.network case final value?) 'network': value,
      if (instance.airTime case final value?) 'airTime': value,
      if (instance.images?.map((e) => e.toJson()).toList() case final value?)
        'images': value,
      if (instance.remotePoster case final value?) 'remotePoster': value,
      if (instance.seasons?.map((e) => e.toJson()).toList() case final value?)
        'seasons': value,
      if (instance.year case final value?) 'year': value,
      if (instance.path case final value?) 'path': value,
      if (instance.profileId case final value?) 'profileId': value,
      if (instance.languageProfileId case final value?)
        'languageProfileId': value,
      if (instance.seasonFolder case final value?) 'seasonFolder': value,
      if (instance.monitored case final value?) 'monitored': value,
      if (instance.useSceneNumbering case final value?)
        'useSceneNumbering': value,
      if (instance.runtime case final value?) 'runtime': value,
      if (instance.tvdbId case final value?) 'tvdbId': value,
      if (instance.tvRageId case final value?) 'tvRageId': value,
      if (instance.tvMazeId case final value?) 'tvMazeId': value,
      if (instance.firstAired case final value?) 'firstAired': value,
      if (instance.lastInfoSync case final value?) 'lastInfoSync': value,
      if (instance.seriesType case final value?) 'seriesType': value,
      if (instance.cleanTitle case final value?) 'cleanTitle': value,
      if (instance.imdbId case final value?) 'imdbId': value,
      if (instance.titleSlug case final value?) 'titleSlug': value,
      if (instance.certification case final value?) 'certification': value,
      if (instance.genres case final value?) 'genres': value,
      if (instance.tags case final value?) 'tags': value,
      if (instance.added case final value?) 'added': value,
      if (instance.ratings?.map((e) => e.toJson()).toList() case final value?)
        'ratings': value,
      if (instance.qualityProfileId case final value?)
        'qualityProfileId': value,
      if (instance.id case final value?) 'id': value,
      if (instance.rootFolderPath case final value?) 'rootFolderPath': value,
      if (instance.addOptions?.map((e) => e.toJson()).toList()
          case final value?)
        'addOptions': value,
    };

UserSettingsNotifications _$UserSettingsNotificationsFromJson(
        Map<String, dynamic> json) =>
    UserSettingsNotifications(
      notificationTypes: json['notificationTypes'] == null
          ? null
          : NotificationAgentTypes.fromJson(
              json['notificationTypes'] as Map<String, dynamic>),
      emailEnabled: json['emailEnabled'] as bool?,
      pgpKey: json['pgpKey'] as String?,
      discordEnabled: json['discordEnabled'] as bool?,
      discordEnabledTypes: (json['discordEnabledTypes'] as num?)?.toDouble(),
      discordId: json['discordId'] as String?,
      pushbulletAccessToken: json['pushbulletAccessToken'] as String?,
      pushoverApplicationToken: json['pushoverApplicationToken'] as String?,
      pushoverUserKey: json['pushoverUserKey'] as String?,
      pushoverSound: json['pushoverSound'] as String?,
      telegramEnabled: json['telegramEnabled'] as bool?,
      telegramBotUsername: json['telegramBotUsername'] as String?,
      telegramChatId: json['telegramChatId'] as String?,
      telegramMessageThreadId: json['telegramMessageThreadId'] as String?,
      telegramSendSilently: json['telegramSendSilently'] as bool?,
    );

Map<String, dynamic> _$UserSettingsNotificationsToJson(
        UserSettingsNotifications instance) =>
    <String, dynamic>{
      if (instance.notificationTypes?.toJson() case final value?)
        'notificationTypes': value,
      if (instance.emailEnabled case final value?) 'emailEnabled': value,
      if (instance.pgpKey case final value?) 'pgpKey': value,
      if (instance.discordEnabled case final value?) 'discordEnabled': value,
      if (instance.discordEnabledTypes case final value?)
        'discordEnabledTypes': value,
      if (instance.discordId case final value?) 'discordId': value,
      if (instance.pushbulletAccessToken case final value?)
        'pushbulletAccessToken': value,
      if (instance.pushoverApplicationToken case final value?)
        'pushoverApplicationToken': value,
      if (instance.pushoverUserKey case final value?) 'pushoverUserKey': value,
      if (instance.pushoverSound case final value?) 'pushoverSound': value,
      if (instance.telegramEnabled case final value?) 'telegramEnabled': value,
      if (instance.telegramBotUsername case final value?)
        'telegramBotUsername': value,
      if (instance.telegramChatId case final value?) 'telegramChatId': value,
      if (instance.telegramMessageThreadId case final value?)
        'telegramMessageThreadId': value,
      if (instance.telegramSendSilently case final value?)
        'telegramSendSilently': value,
    };

NotificationAgentTypes _$NotificationAgentTypesFromJson(
        Map<String, dynamic> json) =>
    NotificationAgentTypes(
      discord: (json['discord'] as num?)?.toDouble(),
      email: (json['email'] as num?)?.toDouble(),
      pushbullet: (json['pushbullet'] as num?)?.toDouble(),
      pushover: (json['pushover'] as num?)?.toDouble(),
      slack: (json['slack'] as num?)?.toDouble(),
      telegram: (json['telegram'] as num?)?.toDouble(),
      webhook: (json['webhook'] as num?)?.toDouble(),
      webpush: (json['webpush'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$NotificationAgentTypesToJson(
        NotificationAgentTypes instance) =>
    <String, dynamic>{
      if (instance.discord case final value?) 'discord': value,
      if (instance.email case final value?) 'email': value,
      if (instance.pushbullet case final value?) 'pushbullet': value,
      if (instance.pushover case final value?) 'pushover': value,
      if (instance.slack case final value?) 'slack': value,
      if (instance.telegram case final value?) 'telegram': value,
      if (instance.webhook case final value?) 'webhook': value,
      if (instance.webpush case final value?) 'webpush': value,
    };

WatchProviders$Item _$WatchProviders$ItemFromJson(Map<String, dynamic> json) =>
    WatchProviders$Item(
      iso31661: json['iso_3166_1'] as String?,
      link: json['link'] as String?,
      buy: (json['buy'] as List<dynamic>?)?.map((e) => e as Object).toList() ??
          [],
      flatrate: (json['flatrate'] as List<dynamic>?)
              ?.map((e) => e as Object)
              .toList() ??
          [],
    );

Map<String, dynamic> _$WatchProviders$ItemToJson(
        WatchProviders$Item instance) =>
    <String, dynamic>{
      if (instance.iso31661 case final value?) 'iso_3166_1': value,
      if (instance.link case final value?) 'link': value,
      if (instance.buy case final value?) 'buy': value,
      if (instance.flatrate case final value?) 'flatrate': value,
    };

WatchProviderDetails _$WatchProviderDetailsFromJson(
        Map<String, dynamic> json) =>
    WatchProviderDetails(
      displayPriority: (json['displayPriority'] as num?)?.toDouble(),
      logoPath: json['logoPath'] as String?,
      id: (json['id'] as num?)?.toDouble(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$WatchProviderDetailsToJson(
        WatchProviderDetails instance) =>
    <String, dynamic>{
      if (instance.displayPriority case final value?) 'displayPriority': value,
      if (instance.logoPath case final value?) 'logoPath': value,
      if (instance.id case final value?) 'id': value,
      if (instance.name case final value?) 'name': value,
    };

Issue _$IssueFromJson(Map<String, dynamic> json) => Issue(
      id: (json['id'] as num?)?.toDouble(),
      issueType: (json['issueType'] as num?)?.toDouble(),
      media: json['media'] == null
          ? null
          : MediaInfo.fromJson(json['media'] as Map<String, dynamic>),
      createdBy: json['createdBy'] == null
          ? null
          : User.fromJson(json['createdBy'] as Map<String, dynamic>),
      modifiedBy: json['modifiedBy'] == null
          ? null
          : User.fromJson(json['modifiedBy'] as Map<String, dynamic>),
      comments: (json['comments'] as List<dynamic>?)
              ?.map((e) => IssueComment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$IssueToJson(Issue instance) => <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.issueType case final value?) 'issueType': value,
      if (instance.media?.toJson() case final value?) 'media': value,
      if (instance.createdBy?.toJson() case final value?) 'createdBy': value,
      if (instance.modifiedBy?.toJson() case final value?) 'modifiedBy': value,
      if (instance.comments?.map((e) => e.toJson()).toList() case final value?)
        'comments': value,
    };

IssueComment _$IssueCommentFromJson(Map<String, dynamic> json) => IssueComment(
      id: (json['id'] as num?)?.toDouble(),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$IssueCommentToJson(IssueComment instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.user?.toJson() case final value?) 'user': value,
      if (instance.message case final value?) 'message': value,
    };

DiscoverSlider _$DiscoverSliderFromJson(Map<String, dynamic> json) =>
    DiscoverSlider(
      id: (json['id'] as num?)?.toDouble(),
      type: (json['type'] as num).toDouble(),
      title: json['title'] as String?,
      isBuiltIn: json['isBuiltIn'] as bool?,
      enabled: json['enabled'] as bool,
      data: json['data'] as String?,
    );

Map<String, dynamic> _$DiscoverSliderToJson(DiscoverSlider instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      'type': instance.type,
      if (instance.title case final value?) 'title': value,
      if (instance.isBuiltIn case final value?) 'isBuiltIn': value,
      'enabled': instance.enabled,
      if (instance.data case final value?) 'data': value,
    };

WatchProviderRegion _$WatchProviderRegionFromJson(Map<String, dynamic> json) =>
    WatchProviderRegion(
      iso31661: json['iso_3166_1'] as String?,
      englishName: json['english_name'] as String?,
      nativeName: json['native_name'] as String?,
    );

Map<String, dynamic> _$WatchProviderRegionToJson(
        WatchProviderRegion instance) =>
    <String, dynamic>{
      if (instance.iso31661 case final value?) 'iso_3166_1': value,
      if (instance.englishName case final value?) 'english_name': value,
      if (instance.nativeName case final value?) 'native_name': value,
    };

OverrideRule _$OverrideRuleFromJson(Map<String, dynamic> json) => OverrideRule(
      id: json['id'] as String?,
    );

Map<String, dynamic> _$OverrideRuleToJson(OverrideRule instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
    };

Certification _$CertificationFromJson(Map<String, dynamic> json) =>
    Certification(
      certification: json['certification'] as String,
      meaning: json['meaning'] as String?,
      order: (json['order'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CertificationToJson(Certification instance) =>
    <String, dynamic>{
      'certification': instance.certification,
      if (instance.meaning case final value?) 'meaning': value,
      if (instance.order case final value?) 'order': value,
    };

CertificationResponse _$CertificationResponseFromJson(
        Map<String, dynamic> json) =>
    CertificationResponse(
      certifications: json['certifications'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$CertificationResponseToJson(
        CertificationResponse instance) =>
    <String, dynamic>{
      if (instance.certifications case final value?) 'certifications': value,
    };

SettingsJellyfinSyncPost$RequestBody
    _$SettingsJellyfinSyncPost$RequestBodyFromJson(Map<String, dynamic> json) =>
        SettingsJellyfinSyncPost$RequestBody(
          cancel: json['cancel'] as bool?,
          start: json['start'] as bool?,
        );

Map<String, dynamic> _$SettingsJellyfinSyncPost$RequestBodyToJson(
        SettingsJellyfinSyncPost$RequestBody instance) =>
    <String, dynamic>{
      if (instance.cancel case final value?) 'cancel': value,
      if (instance.start case final value?) 'start': value,
    };

SettingsPlexSyncPost$RequestBody _$SettingsPlexSyncPost$RequestBodyFromJson(
        Map<String, dynamic> json) =>
    SettingsPlexSyncPost$RequestBody(
      cancel: json['cancel'] as bool?,
      start: json['start'] as bool?,
    );

Map<String, dynamic> _$SettingsPlexSyncPost$RequestBodyToJson(
        SettingsPlexSyncPost$RequestBody instance) =>
    <String, dynamic>{
      if (instance.cancel case final value?) 'cancel': value,
      if (instance.start case final value?) 'start': value,
    };

SettingsMetadatasTestPost$RequestBody
    _$SettingsMetadatasTestPost$RequestBodyFromJson(
            Map<String, dynamic> json) =>
        SettingsMetadatasTestPost$RequestBody(
          tmdb: json['tmdb'] as bool?,
          tvdb: json['tvdb'] as bool?,
        );

Map<String, dynamic> _$SettingsMetadatasTestPost$RequestBodyToJson(
        SettingsMetadatasTestPost$RequestBody instance) =>
    <String, dynamic>{
      if (instance.tmdb case final value?) 'tmdb': value,
      if (instance.tvdb case final value?) 'tvdb': value,
    };

SettingsRadarrTestPost$RequestBody _$SettingsRadarrTestPost$RequestBodyFromJson(
        Map<String, dynamic> json) =>
    SettingsRadarrTestPost$RequestBody(
      hostname: json['hostname'] as String,
      port: (json['port'] as num).toDouble(),
      apiKey: json['apiKey'] as String,
      useSsl: json['useSsl'] as bool,
      baseUrl: json['baseUrl'] as String?,
    );

Map<String, dynamic> _$SettingsRadarrTestPost$RequestBodyToJson(
        SettingsRadarrTestPost$RequestBody instance) =>
    <String, dynamic>{
      'hostname': instance.hostname,
      'port': instance.port,
      'apiKey': instance.apiKey,
      'useSsl': instance.useSsl,
      if (instance.baseUrl case final value?) 'baseUrl': value,
    };

SettingsSonarrTestPost$RequestBody _$SettingsSonarrTestPost$RequestBodyFromJson(
        Map<String, dynamic> json) =>
    SettingsSonarrTestPost$RequestBody(
      hostname: json['hostname'] as String,
      port: (json['port'] as num).toDouble(),
      apiKey: json['apiKey'] as String,
      useSsl: json['useSsl'] as bool,
      baseUrl: json['baseUrl'] as String?,
    );

Map<String, dynamic> _$SettingsSonarrTestPost$RequestBodyToJson(
        SettingsSonarrTestPost$RequestBody instance) =>
    <String, dynamic>{
      'hostname': instance.hostname,
      'port': instance.port,
      'apiKey': instance.apiKey,
      'useSsl': instance.useSsl,
      if (instance.baseUrl case final value?) 'baseUrl': value,
    };

SettingsJobsJobIdSchedulePost$RequestBody
    _$SettingsJobsJobIdSchedulePost$RequestBodyFromJson(
            Map<String, dynamic> json) =>
        SettingsJobsJobIdSchedulePost$RequestBody(
          schedule: json['schedule'] as String?,
        );

Map<String, dynamic> _$SettingsJobsJobIdSchedulePost$RequestBodyToJson(
        SettingsJobsJobIdSchedulePost$RequestBody instance) =>
    <String, dynamic>{
      if (instance.schedule case final value?) 'schedule': value,
    };

SettingsDiscoverSliderIdPut$RequestBody
    _$SettingsDiscoverSliderIdPut$RequestBodyFromJson(
            Map<String, dynamic> json) =>
        SettingsDiscoverSliderIdPut$RequestBody(
          title: json['title'] as String?,
          type: (json['type'] as num?)?.toDouble(),
          data: json['data'] as String?,
        );

Map<String, dynamic> _$SettingsDiscoverSliderIdPut$RequestBodyToJson(
        SettingsDiscoverSliderIdPut$RequestBody instance) =>
    <String, dynamic>{
      if (instance.title case final value?) 'title': value,
      if (instance.type case final value?) 'type': value,
      if (instance.data case final value?) 'data': value,
    };

SettingsDiscoverAddPost$RequestBody
    _$SettingsDiscoverAddPost$RequestBodyFromJson(Map<String, dynamic> json) =>
        SettingsDiscoverAddPost$RequestBody(
          title: json['title'] as String?,
          type: (json['type'] as num?)?.toDouble(),
          data: json['data'] as String?,
        );

Map<String, dynamic> _$SettingsDiscoverAddPost$RequestBodyToJson(
        SettingsDiscoverAddPost$RequestBody instance) =>
    <String, dynamic>{
      if (instance.title case final value?) 'title': value,
      if (instance.type case final value?) 'type': value,
      if (instance.data case final value?) 'data': value,
    };

AuthPlexPost$RequestBody _$AuthPlexPost$RequestBodyFromJson(
        Map<String, dynamic> json) =>
    AuthPlexPost$RequestBody(
      authToken: json['authToken'] as String,
    );

Map<String, dynamic> _$AuthPlexPost$RequestBodyToJson(
        AuthPlexPost$RequestBody instance) =>
    <String, dynamic>{
      'authToken': instance.authToken,
    };

AuthJellyfinPost$RequestBody _$AuthJellyfinPost$RequestBodyFromJson(
        Map<String, dynamic> json) =>
    AuthJellyfinPost$RequestBody(
      username: json['username'] as String,
      password: json['password'] as String,
      hostname: json['hostname'] as String?,
      email: json['email'] as String?,
      serverType: (json['serverType'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$AuthJellyfinPost$RequestBodyToJson(
        AuthJellyfinPost$RequestBody instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      if (instance.hostname case final value?) 'hostname': value,
      if (instance.email case final value?) 'email': value,
      if (instance.serverType case final value?) 'serverType': value,
    };

AuthLocalPost$RequestBody _$AuthLocalPost$RequestBodyFromJson(
        Map<String, dynamic> json) =>
    AuthLocalPost$RequestBody(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$AuthLocalPost$RequestBodyToJson(
        AuthLocalPost$RequestBody instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };

AuthResetPasswordPost$RequestBody _$AuthResetPasswordPost$RequestBodyFromJson(
        Map<String, dynamic> json) =>
    AuthResetPasswordPost$RequestBody(
      email: json['email'] as String,
    );

Map<String, dynamic> _$AuthResetPasswordPost$RequestBodyToJson(
        AuthResetPasswordPost$RequestBody instance) =>
    <String, dynamic>{
      'email': instance.email,
    };

AuthResetPasswordGuidPost$RequestBody
    _$AuthResetPasswordGuidPost$RequestBodyFromJson(
            Map<String, dynamic> json) =>
        AuthResetPasswordGuidPost$RequestBody(
          password: json['password'] as String,
        );

Map<String, dynamic> _$AuthResetPasswordGuidPost$RequestBodyToJson(
        AuthResetPasswordGuidPost$RequestBody instance) =>
    <String, dynamic>{
      'password': instance.password,
    };

UserPut$RequestBody _$UserPut$RequestBodyFromJson(Map<String, dynamic> json) =>
    UserPut$RequestBody(
      ids: (json['ids'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          [],
      permissions: (json['permissions'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserPut$RequestBodyToJson(
        UserPut$RequestBody instance) =>
    <String, dynamic>{
      if (instance.ids case final value?) 'ids': value,
      if (instance.permissions case final value?) 'permissions': value,
    };

UserPost$RequestBody _$UserPost$RequestBodyFromJson(
        Map<String, dynamic> json) =>
    UserPost$RequestBody(
      email: json['email'] as String?,
      username: json['username'] as String?,
      permissions: (json['permissions'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$UserPost$RequestBodyToJson(
        UserPost$RequestBody instance) =>
    <String, dynamic>{
      if (instance.email case final value?) 'email': value,
      if (instance.username case final value?) 'username': value,
      if (instance.permissions case final value?) 'permissions': value,
    };

UserImportFromPlexPost$RequestBody _$UserImportFromPlexPost$RequestBodyFromJson(
        Map<String, dynamic> json) =>
    UserImportFromPlexPost$RequestBody(
      plexIds: (json['plexIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$UserImportFromPlexPost$RequestBodyToJson(
        UserImportFromPlexPost$RequestBody instance) =>
    <String, dynamic>{
      if (instance.plexIds case final value?) 'plexIds': value,
    };

UserImportFromJellyfinPost$RequestBody
    _$UserImportFromJellyfinPost$RequestBodyFromJson(
            Map<String, dynamic> json) =>
        UserImportFromJellyfinPost$RequestBody(
          jellyfinUserIds: (json['jellyfinUserIds'] as List<dynamic>?)
                  ?.map((e) => e as String)
                  .toList() ??
              [],
        );

Map<String, dynamic> _$UserImportFromJellyfinPost$RequestBodyToJson(
        UserImportFromJellyfinPost$RequestBody instance) =>
    <String, dynamic>{
      if (instance.jellyfinUserIds case final value?) 'jellyfinUserIds': value,
    };

UserRegisterPushSubscriptionPost$RequestBody
    _$UserRegisterPushSubscriptionPost$RequestBodyFromJson(
            Map<String, dynamic> json) =>
        UserRegisterPushSubscriptionPost$RequestBody(
          endpoint: json['endpoint'] as String,
          auth: json['auth'] as String,
          p256dh: json['p256dh'] as String,
          userAgent: json['userAgent'] as String?,
        );

Map<String, dynamic> _$UserRegisterPushSubscriptionPost$RequestBodyToJson(
        UserRegisterPushSubscriptionPost$RequestBody instance) =>
    <String, dynamic>{
      'endpoint': instance.endpoint,
      'auth': instance.auth,
      'p256dh': instance.p256dh,
      if (instance.userAgent case final value?) 'userAgent': value,
    };

UserUserIdSettingsPasswordPost$RequestBody
    _$UserUserIdSettingsPasswordPost$RequestBodyFromJson(
            Map<String, dynamic> json) =>
        UserUserIdSettingsPasswordPost$RequestBody(
          currentPassword: json['currentPassword'] as String?,
          newPassword: json['newPassword'] as String,
        );

Map<String, dynamic> _$UserUserIdSettingsPasswordPost$RequestBodyToJson(
        UserUserIdSettingsPasswordPost$RequestBody instance) =>
    <String, dynamic>{
      if (instance.currentPassword case final value?) 'currentPassword': value,
      'newPassword': instance.newPassword,
    };

UserUserIdSettingsLinkedAccountsPlexPost$RequestBody
    _$UserUserIdSettingsLinkedAccountsPlexPost$RequestBodyFromJson(
            Map<String, dynamic> json) =>
        UserUserIdSettingsLinkedAccountsPlexPost$RequestBody(
          authToken: json['authToken'] as String,
        );

Map<String, dynamic>
    _$UserUserIdSettingsLinkedAccountsPlexPost$RequestBodyToJson(
            UserUserIdSettingsLinkedAccountsPlexPost$RequestBody instance) =>
        <String, dynamic>{
          'authToken': instance.authToken,
        };

UserUserIdSettingsLinkedAccountsJellyfinPost$RequestBody
    _$UserUserIdSettingsLinkedAccountsJellyfinPost$RequestBodyFromJson(
            Map<String, dynamic> json) =>
        UserUserIdSettingsLinkedAccountsJellyfinPost$RequestBody(
          username: json['username'] as String?,
          password: json['password'] as String?,
        );

Map<String,
    dynamic> _$UserUserIdSettingsLinkedAccountsJellyfinPost$RequestBodyToJson(
        UserUserIdSettingsLinkedAccountsJellyfinPost$RequestBody instance) =>
    <String, dynamic>{
      if (instance.username case final value?) 'username': value,
      if (instance.password case final value?) 'password': value,
    };

UserUserIdSettingsPermissionsPost$RequestBody
    _$UserUserIdSettingsPermissionsPost$RequestBodyFromJson(
            Map<String, dynamic> json) =>
        UserUserIdSettingsPermissionsPost$RequestBody(
          permissions: (json['permissions'] as num).toDouble(),
        );

Map<String, dynamic> _$UserUserIdSettingsPermissionsPost$RequestBodyToJson(
        UserUserIdSettingsPermissionsPost$RequestBody instance) =>
    <String, dynamic>{
      'permissions': instance.permissions,
    };

RequestPost$RequestBody _$RequestPost$RequestBodyFromJson(
        Map<String, dynamic> json) =>
    RequestPost$RequestBody(
      mediaType: requestPost$RequestBodyMediaTypeFromJson(json['mediaType']),
      mediaId: (json['mediaId'] as num).toDouble(),
      tvdbId: (json['tvdbId'] as num?)?.toDouble(),
      seasons: json['seasons'],
      is4k: json['is4k'] as bool?,
      serverId: (json['serverId'] as num?)?.toDouble(),
      profileId: (json['profileId'] as num?)?.toDouble(),
      rootFolder: json['rootFolder'] as String?,
      languageProfileId: (json['languageProfileId'] as num?)?.toDouble(),
      userId: (json['userId'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$RequestPost$RequestBodyToJson(
        RequestPost$RequestBody instance) =>
    <String, dynamic>{
      if (requestPost$RequestBodyMediaTypeToJson(instance.mediaType)
          case final value?)
        'mediaType': value,
      'mediaId': instance.mediaId,
      if (instance.tvdbId case final value?) 'tvdbId': value,
      if (instance.seasons case final value?) 'seasons': value,
      if (instance.is4k case final value?) 'is4k': value,
      if (instance.serverId case final value?) 'serverId': value,
      if (instance.profileId case final value?) 'profileId': value,
      if (instance.rootFolder case final value?) 'rootFolder': value,
      if (instance.languageProfileId case final value?)
        'languageProfileId': value,
      if (instance.userId case final value?) 'userId': value,
    };

RequestRequestIdPut$RequestBody _$RequestRequestIdPut$RequestBodyFromJson(
        Map<String, dynamic> json) =>
    RequestRequestIdPut$RequestBody(
      mediaType:
          requestRequestIdPut$RequestBodyMediaTypeFromJson(json['mediaType']),
      seasons: (json['seasons'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          [],
      is4k: json['is4k'] as bool?,
      serverId: (json['serverId'] as num?)?.toDouble(),
      profileId: (json['profileId'] as num?)?.toDouble(),
      rootFolder: json['rootFolder'] as String?,
      languageProfileId: (json['languageProfileId'] as num?)?.toDouble(),
      userId: (json['userId'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$RequestRequestIdPut$RequestBodyToJson(
        RequestRequestIdPut$RequestBody instance) =>
    <String, dynamic>{
      if (requestRequestIdPut$RequestBodyMediaTypeToJson(instance.mediaType)
          case final value?)
        'mediaType': value,
      if (instance.seasons case final value?) 'seasons': value,
      if (instance.is4k case final value?) 'is4k': value,
      if (instance.serverId case final value?) 'serverId': value,
      if (instance.profileId case final value?) 'profileId': value,
      if (instance.rootFolder case final value?) 'rootFolder': value,
      if (instance.languageProfileId case final value?)
        'languageProfileId': value,
      if (instance.userId case final value?) 'userId': value,
    };

MediaMediaIdStatusPost$RequestBody _$MediaMediaIdStatusPost$RequestBodyFromJson(
        Map<String, dynamic> json) =>
    MediaMediaIdStatusPost$RequestBody(
      is4k: json['is4k'] as bool?,
    );

Map<String, dynamic> _$MediaMediaIdStatusPost$RequestBodyToJson(
        MediaMediaIdStatusPost$RequestBody instance) =>
    <String, dynamic>{
      if (instance.is4k case final value?) 'is4k': value,
    };

IssuePost$RequestBody _$IssuePost$RequestBodyFromJson(
        Map<String, dynamic> json) =>
    IssuePost$RequestBody(
      issueType: (json['issueType'] as num?)?.toDouble(),
      message: json['message'] as String?,
      mediaId: (json['mediaId'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$IssuePost$RequestBodyToJson(
        IssuePost$RequestBody instance) =>
    <String, dynamic>{
      if (instance.issueType case final value?) 'issueType': value,
      if (instance.message case final value?) 'message': value,
      if (instance.mediaId case final value?) 'mediaId': value,
    };

IssueIssueIdCommentPost$RequestBody
    _$IssueIssueIdCommentPost$RequestBodyFromJson(Map<String, dynamic> json) =>
        IssueIssueIdCommentPost$RequestBody(
          message: json['message'] as String,
        );

Map<String, dynamic> _$IssueIssueIdCommentPost$RequestBodyToJson(
        IssueIssueIdCommentPost$RequestBody instance) =>
    <String, dynamic>{
      'message': instance.message,
    };

IssueCommentCommentIdPut$RequestBody
    _$IssueCommentCommentIdPut$RequestBodyFromJson(Map<String, dynamic> json) =>
        IssueCommentCommentIdPut$RequestBody(
          message: json['message'] as String?,
        );

Map<String, dynamic> _$IssueCommentCommentIdPut$RequestBodyToJson(
        IssueCommentCommentIdPut$RequestBody instance) =>
    <String, dynamic>{
      if (instance.message case final value?) 'message': value,
    };

StatusGet$Response _$StatusGet$ResponseFromJson(Map<String, dynamic> json) =>
    StatusGet$Response(
      version: json['version'] as String?,
      commitTag: json['commitTag'] as String?,
      updateAvailable: json['updateAvailable'] as bool?,
      commitsBehind: (json['commitsBehind'] as num?)?.toDouble(),
      restartRequired: json['restartRequired'] as bool?,
    );

Map<String, dynamic> _$StatusGet$ResponseToJson(StatusGet$Response instance) =>
    <String, dynamic>{
      if (instance.version case final value?) 'version': value,
      if (instance.commitTag case final value?) 'commitTag': value,
      if (instance.updateAvailable case final value?) 'updateAvailable': value,
      if (instance.commitsBehind case final value?) 'commitsBehind': value,
      if (instance.restartRequired case final value?) 'restartRequired': value,
    };

StatusAppdataGet$Response _$StatusAppdataGet$ResponseFromJson(
        Map<String, dynamic> json) =>
    StatusAppdataGet$Response(
      appData: json['appData'] as bool?,
      appDataPath: json['appDataPath'] as String?,
      appDataPermissions: json['appDataPermissions'] as bool?,
    );

Map<String, dynamic> _$StatusAppdataGet$ResponseToJson(
        StatusAppdataGet$Response instance) =>
    <String, dynamic>{
      if (instance.appData case final value?) 'appData': value,
      if (instance.appDataPath case final value?) 'appDataPath': value,
      if (instance.appDataPermissions case final value?)
        'appDataPermissions': value,
    };

SettingsJellyfinUsersGet$Response$Item
    _$SettingsJellyfinUsersGet$Response$ItemFromJson(
            Map<String, dynamic> json) =>
        SettingsJellyfinUsersGet$Response$Item(
          username: json['username'] as String?,
          id: json['id'] as String?,
          thumb: json['thumb'] as String?,
          email: json['email'] as String?,
        );

Map<String, dynamic> _$SettingsJellyfinUsersGet$Response$ItemToJson(
        SettingsJellyfinUsersGet$Response$Item instance) =>
    <String, dynamic>{
      if (instance.username case final value?) 'username': value,
      if (instance.id case final value?) 'id': value,
      if (instance.thumb case final value?) 'thumb': value,
      if (instance.email case final value?) 'email': value,
    };

SettingsJellyfinSyncGet$Response _$SettingsJellyfinSyncGet$ResponseFromJson(
        Map<String, dynamic> json) =>
    SettingsJellyfinSyncGet$Response(
      running: json['running'] as bool?,
      progress: (json['progress'] as num?)?.toDouble(),
      total: (json['total'] as num?)?.toDouble(),
      currentLibrary: json['currentLibrary'] == null
          ? null
          : JellyfinLibrary.fromJson(
              json['currentLibrary'] as Map<String, dynamic>),
      libraries: (json['libraries'] as List<dynamic>?)
              ?.map((e) => JellyfinLibrary.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$SettingsJellyfinSyncGet$ResponseToJson(
        SettingsJellyfinSyncGet$Response instance) =>
    <String, dynamic>{
      if (instance.running case final value?) 'running': value,
      if (instance.progress case final value?) 'progress': value,
      if (instance.total case final value?) 'total': value,
      if (instance.currentLibrary?.toJson() case final value?)
        'currentLibrary': value,
      if (instance.libraries?.map((e) => e.toJson()).toList() case final value?)
        'libraries': value,
    };

SettingsJellyfinSyncPost$Response _$SettingsJellyfinSyncPost$ResponseFromJson(
        Map<String, dynamic> json) =>
    SettingsJellyfinSyncPost$Response(
      running: json['running'] as bool?,
      progress: (json['progress'] as num?)?.toDouble(),
      total: (json['total'] as num?)?.toDouble(),
      currentLibrary: json['currentLibrary'] == null
          ? null
          : JellyfinLibrary.fromJson(
              json['currentLibrary'] as Map<String, dynamic>),
      libraries: (json['libraries'] as List<dynamic>?)
              ?.map((e) => JellyfinLibrary.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$SettingsJellyfinSyncPost$ResponseToJson(
        SettingsJellyfinSyncPost$Response instance) =>
    <String, dynamic>{
      if (instance.running case final value?) 'running': value,
      if (instance.progress case final value?) 'progress': value,
      if (instance.total case final value?) 'total': value,
      if (instance.currentLibrary?.toJson() case final value?)
        'currentLibrary': value,
      if (instance.libraries?.map((e) => e.toJson()).toList() case final value?)
        'libraries': value,
    };

SettingsPlexSyncGet$Response _$SettingsPlexSyncGet$ResponseFromJson(
        Map<String, dynamic> json) =>
    SettingsPlexSyncGet$Response(
      running: json['running'] as bool?,
      progress: (json['progress'] as num?)?.toDouble(),
      total: (json['total'] as num?)?.toDouble(),
      currentLibrary: json['currentLibrary'] == null
          ? null
          : PlexLibrary.fromJson(
              json['currentLibrary'] as Map<String, dynamic>),
      libraries: (json['libraries'] as List<dynamic>?)
              ?.map((e) => PlexLibrary.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$SettingsPlexSyncGet$ResponseToJson(
        SettingsPlexSyncGet$Response instance) =>
    <String, dynamic>{
      if (instance.running case final value?) 'running': value,
      if (instance.progress case final value?) 'progress': value,
      if (instance.total case final value?) 'total': value,
      if (instance.currentLibrary?.toJson() case final value?)
        'currentLibrary': value,
      if (instance.libraries?.map((e) => e.toJson()).toList() case final value?)
        'libraries': value,
    };

SettingsPlexSyncPost$Response _$SettingsPlexSyncPost$ResponseFromJson(
        Map<String, dynamic> json) =>
    SettingsPlexSyncPost$Response(
      running: json['running'] as bool?,
      progress: (json['progress'] as num?)?.toDouble(),
      total: (json['total'] as num?)?.toDouble(),
      currentLibrary: json['currentLibrary'] == null
          ? null
          : PlexLibrary.fromJson(
              json['currentLibrary'] as Map<String, dynamic>),
      libraries: (json['libraries'] as List<dynamic>?)
              ?.map((e) => PlexLibrary.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$SettingsPlexSyncPost$ResponseToJson(
        SettingsPlexSyncPost$Response instance) =>
    <String, dynamic>{
      if (instance.running case final value?) 'running': value,
      if (instance.progress case final value?) 'progress': value,
      if (instance.total case final value?) 'total': value,
      if (instance.currentLibrary?.toJson() case final value?)
        'currentLibrary': value,
      if (instance.libraries?.map((e) => e.toJson()).toList() case final value?)
        'libraries': value,
    };

SettingsPlexUsersGet$Response$Item _$SettingsPlexUsersGet$Response$ItemFromJson(
        Map<String, dynamic> json) =>
    SettingsPlexUsersGet$Response$Item(
      id: json['id'] as String?,
      title: json['title'] as String?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      thumb: json['thumb'] as String?,
    );

Map<String, dynamic> _$SettingsPlexUsersGet$Response$ItemToJson(
        SettingsPlexUsersGet$Response$Item instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.title case final value?) 'title': value,
      if (instance.username case final value?) 'username': value,
      if (instance.email case final value?) 'email': value,
      if (instance.thumb case final value?) 'thumb': value,
    };

SettingsMetadatasTestPost$Response _$SettingsMetadatasTestPost$ResponseFromJson(
        Map<String, dynamic> json) =>
    SettingsMetadatasTestPost$Response(
      message: json['message'] as String?,
    );

Map<String, dynamic> _$SettingsMetadatasTestPost$ResponseToJson(
        SettingsMetadatasTestPost$Response instance) =>
    <String, dynamic>{
      if (instance.message case final value?) 'message': value,
    };

SettingsRadarrTestPost$Response _$SettingsRadarrTestPost$ResponseFromJson(
        Map<String, dynamic> json) =>
    SettingsRadarrTestPost$Response(
      profiles: (json['profiles'] as List<dynamic>?)
              ?.map((e) => ServiceProfile.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$SettingsRadarrTestPost$ResponseToJson(
        SettingsRadarrTestPost$Response instance) =>
    <String, dynamic>{
      if (instance.profiles?.map((e) => e.toJson()).toList() case final value?)
        'profiles': value,
    };

SettingsSonarrTestPost$Response _$SettingsSonarrTestPost$ResponseFromJson(
        Map<String, dynamic> json) =>
    SettingsSonarrTestPost$Response(
      profiles: (json['profiles'] as List<dynamic>?)
              ?.map((e) => ServiceProfile.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$SettingsSonarrTestPost$ResponseToJson(
        SettingsSonarrTestPost$Response instance) =>
    <String, dynamic>{
      if (instance.profiles?.map((e) => e.toJson()).toList() case final value?)
        'profiles': value,
    };

SettingsCacheGet$Response _$SettingsCacheGet$ResponseFromJson(
        Map<String, dynamic> json) =>
    SettingsCacheGet$Response(
      imageCache: json['imageCache'] == null
          ? null
          : SettingsCacheGet$Response$ImageCache.fromJson(
              json['imageCache'] as Map<String, dynamic>),
      dnsCache: json['dnsCache'] == null
          ? null
          : SettingsCacheGet$Response$DnsCache.fromJson(
              json['dnsCache'] as Map<String, dynamic>),
      apiCaches: (json['apiCaches'] as List<dynamic>?)
          ?.map((e) => SettingsCacheGet$Response$ApiCaches$Item.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SettingsCacheGet$ResponseToJson(
        SettingsCacheGet$Response instance) =>
    <String, dynamic>{
      if (instance.imageCache?.toJson() case final value?) 'imageCache': value,
      if (instance.dnsCache?.toJson() case final value?) 'dnsCache': value,
      if (instance.apiCaches?.map((e) => e.toJson()).toList() case final value?)
        'apiCaches': value,
    };

SettingsLogsGet$Response$Item _$SettingsLogsGet$Response$ItemFromJson(
        Map<String, dynamic> json) =>
    SettingsLogsGet$Response$Item(
      label: json['label'] as String?,
      level: json['level'] as String?,
      message: json['message'] as String?,
      timestamp: json['timestamp'] as String?,
    );

Map<String, dynamic> _$SettingsLogsGet$Response$ItemToJson(
        SettingsLogsGet$Response$Item instance) =>
    <String, dynamic>{
      if (instance.label case final value?) 'label': value,
      if (instance.level case final value?) 'level': value,
      if (instance.message case final value?) 'message': value,
      if (instance.timestamp case final value?) 'timestamp': value,
    };

SettingsNotificationsPushoverSoundsGet$Response$Item
    _$SettingsNotificationsPushoverSoundsGet$Response$ItemFromJson(
            Map<String, dynamic> json) =>
        SettingsNotificationsPushoverSoundsGet$Response$Item(
          name: json['name'] as String?,
          description: json['description'] as String?,
        );

Map<String, dynamic>
    _$SettingsNotificationsPushoverSoundsGet$Response$ItemToJson(
            SettingsNotificationsPushoverSoundsGet$Response$Item instance) =>
        <String, dynamic>{
          if (instance.name case final value?) 'name': value,
          if (instance.description case final value?) 'description': value,
        };

SettingsAboutGet$Response _$SettingsAboutGet$ResponseFromJson(
        Map<String, dynamic> json) =>
    SettingsAboutGet$Response(
      version: json['version'] as String?,
      totalRequests: (json['totalRequests'] as num?)?.toDouble(),
      totalMediaItems: (json['totalMediaItems'] as num?)?.toDouble(),
      tz: json['tz'] as String?,
      appDataPath: json['appDataPath'] as String?,
    );

Map<String, dynamic> _$SettingsAboutGet$ResponseToJson(
        SettingsAboutGet$Response instance) =>
    <String, dynamic>{
      if (instance.version case final value?) 'version': value,
      if (instance.totalRequests case final value?) 'totalRequests': value,
      if (instance.totalMediaItems case final value?) 'totalMediaItems': value,
      if (instance.tz case final value?) 'tz': value,
      if (instance.appDataPath case final value?) 'appDataPath': value,
    };

AuthLogoutPost$Response _$AuthLogoutPost$ResponseFromJson(
        Map<String, dynamic> json) =>
    AuthLogoutPost$Response(
      status: json['status'] as String?,
    );

Map<String, dynamic> _$AuthLogoutPost$ResponseToJson(
        AuthLogoutPost$Response instance) =>
    <String, dynamic>{
      if (instance.status case final value?) 'status': value,
    };

AuthResetPasswordPost$Response _$AuthResetPasswordPost$ResponseFromJson(
        Map<String, dynamic> json) =>
    AuthResetPasswordPost$Response(
      status: json['status'] as String?,
    );

Map<String, dynamic> _$AuthResetPasswordPost$ResponseToJson(
        AuthResetPasswordPost$Response instance) =>
    <String, dynamic>{
      if (instance.status case final value?) 'status': value,
    };

AuthResetPasswordGuidPost$Response _$AuthResetPasswordGuidPost$ResponseFromJson(
        Map<String, dynamic> json) =>
    AuthResetPasswordGuidPost$Response(
      status: json['status'] as String?,
    );

Map<String, dynamic> _$AuthResetPasswordGuidPost$ResponseToJson(
        AuthResetPasswordGuidPost$Response instance) =>
    <String, dynamic>{
      if (instance.status case final value?) 'status': value,
    };

UserGet$Response _$UserGet$ResponseFromJson(Map<String, dynamic> json) =>
    UserGet$Response(
      pageInfo: json['pageInfo'] == null
          ? null
          : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>),
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => User.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$UserGet$ResponseToJson(UserGet$Response instance) =>
    <String, dynamic>{
      if (instance.pageInfo?.toJson() case final value?) 'pageInfo': value,
      if (instance.results?.map((e) => e.toJson()).toList() case final value?)
        'results': value,
    };

UserUserIdPushSubscriptionsGet$Response
    _$UserUserIdPushSubscriptionsGet$ResponseFromJson(
            Map<String, dynamic> json) =>
        UserUserIdPushSubscriptionsGet$Response(
          endpoint: json['endpoint'] as String?,
          p256dh: json['p256dh'] as String?,
          auth: json['auth'] as String?,
          userAgent: json['userAgent'] as String?,
        );

Map<String, dynamic> _$UserUserIdPushSubscriptionsGet$ResponseToJson(
        UserUserIdPushSubscriptionsGet$Response instance) =>
    <String, dynamic>{
      if (instance.endpoint case final value?) 'endpoint': value,
      if (instance.p256dh case final value?) 'p256dh': value,
      if (instance.auth case final value?) 'auth': value,
      if (instance.userAgent case final value?) 'userAgent': value,
    };

UserUserIdPushSubscriptionEndpointGet$Response
    _$UserUserIdPushSubscriptionEndpointGet$ResponseFromJson(
            Map<String, dynamic> json) =>
        UserUserIdPushSubscriptionEndpointGet$Response(
          endpoint: json['endpoint'] as String?,
          p256dh: json['p256dh'] as String?,
          auth: json['auth'] as String?,
          userAgent: json['userAgent'] as String?,
        );

Map<String, dynamic> _$UserUserIdPushSubscriptionEndpointGet$ResponseToJson(
        UserUserIdPushSubscriptionEndpointGet$Response instance) =>
    <String, dynamic>{
      if (instance.endpoint case final value?) 'endpoint': value,
      if (instance.p256dh case final value?) 'p256dh': value,
      if (instance.auth case final value?) 'auth': value,
      if (instance.userAgent case final value?) 'userAgent': value,
    };

UserUserIdRequestsGet$Response _$UserUserIdRequestsGet$ResponseFromJson(
        Map<String, dynamic> json) =>
    UserUserIdRequestsGet$Response(
      pageInfo: json['pageInfo'] == null
          ? null
          : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>),
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => MediaRequest.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$UserUserIdRequestsGet$ResponseToJson(
        UserUserIdRequestsGet$Response instance) =>
    <String, dynamic>{
      if (instance.pageInfo?.toJson() case final value?) 'pageInfo': value,
      if (instance.results?.map((e) => e.toJson()).toList() case final value?)
        'results': value,
    };

UserUserIdQuotaGet$Response _$UserUserIdQuotaGet$ResponseFromJson(
        Map<String, dynamic> json) =>
    UserUserIdQuotaGet$Response(
      movie: json['movie'] == null
          ? null
          : UserUserIdQuotaGet$Response$Movie.fromJson(
              json['movie'] as Map<String, dynamic>),
      tv: json['tv'] == null
          ? null
          : UserUserIdQuotaGet$Response$Tv.fromJson(
              json['tv'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserUserIdQuotaGet$ResponseToJson(
        UserUserIdQuotaGet$Response instance) =>
    <String, dynamic>{
      if (instance.movie?.toJson() case final value?) 'movie': value,
      if (instance.tv?.toJson() case final value?) 'tv': value,
    };

BlacklistGet$Response _$BlacklistGet$ResponseFromJson(
        Map<String, dynamic> json) =>
    BlacklistGet$Response(
      pageInfo: json['pageInfo'] == null
          ? null
          : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>),
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => BlacklistGet$Response$Results$Item.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BlacklistGet$ResponseToJson(
        BlacklistGet$Response instance) =>
    <String, dynamic>{
      if (instance.pageInfo?.toJson() case final value?) 'pageInfo': value,
      if (instance.results?.map((e) => e.toJson()).toList() case final value?)
        'results': value,
    };

UserUserIdWatchlistGet$Response _$UserUserIdWatchlistGet$ResponseFromJson(
        Map<String, dynamic> json) =>
    UserUserIdWatchlistGet$Response(
      page: (json['page'] as num?)?.toDouble(),
      totalPages: (json['totalPages'] as num?)?.toDouble(),
      totalResults: (json['totalResults'] as num?)?.toDouble(),
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => UserUserIdWatchlistGet$Response$Results$Item.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserUserIdWatchlistGet$ResponseToJson(
        UserUserIdWatchlistGet$Response instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.totalPages case final value?) 'totalPages': value,
      if (instance.totalResults case final value?) 'totalResults': value,
      if (instance.results?.map((e) => e.toJson()).toList() case final value?)
        'results': value,
    };

UserUserIdSettingsPasswordGet$Response
    _$UserUserIdSettingsPasswordGet$ResponseFromJson(
            Map<String, dynamic> json) =>
        UserUserIdSettingsPasswordGet$Response(
          hasPassword: json['hasPassword'] as bool?,
        );

Map<String, dynamic> _$UserUserIdSettingsPasswordGet$ResponseToJson(
        UserUserIdSettingsPasswordGet$Response instance) =>
    <String, dynamic>{
      if (instance.hasPassword case final value?) 'hasPassword': value,
    };

UserUserIdSettingsPermissionsGet$Response
    _$UserUserIdSettingsPermissionsGet$ResponseFromJson(
            Map<String, dynamic> json) =>
        UserUserIdSettingsPermissionsGet$Response(
          permissions: (json['permissions'] as num?)?.toDouble(),
        );

Map<String, dynamic> _$UserUserIdSettingsPermissionsGet$ResponseToJson(
        UserUserIdSettingsPermissionsGet$Response instance) =>
    <String, dynamic>{
      if (instance.permissions case final value?) 'permissions': value,
    };

UserUserIdSettingsPermissionsPost$Response
    _$UserUserIdSettingsPermissionsPost$ResponseFromJson(
            Map<String, dynamic> json) =>
        UserUserIdSettingsPermissionsPost$Response(
          permissions: (json['permissions'] as num?)?.toDouble(),
        );

Map<String, dynamic> _$UserUserIdSettingsPermissionsPost$ResponseToJson(
        UserUserIdSettingsPermissionsPost$Response instance) =>
    <String, dynamic>{
      if (instance.permissions case final value?) 'permissions': value,
    };

UserUserIdWatchDataGet$Response _$UserUserIdWatchDataGet$ResponseFromJson(
        Map<String, dynamic> json) =>
    UserUserIdWatchDataGet$Response(
      recentlyWatched: (json['recentlyWatched'] as List<dynamic>?)
              ?.map((e) => MediaInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      playCount: (json['playCount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$UserUserIdWatchDataGet$ResponseToJson(
        UserUserIdWatchDataGet$Response instance) =>
    <String, dynamic>{
      if (instance.recentlyWatched?.map((e) => e.toJson()).toList()
          case final value?)
        'recentlyWatched': value,
      if (instance.playCount case final value?) 'playCount': value,
    };

SearchGet$Response _$SearchGet$ResponseFromJson(Map<String, dynamic> json) =>
    SearchGet$Response(
      page: (json['page'] as num?)?.toDouble(),
      totalPages: (json['totalPages'] as num?)?.toDouble(),
      totalResults: (json['totalResults'] as num?)?.toDouble(),
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => e as Object)
              .toList() ??
          [],
    );

Map<String, dynamic> _$SearchGet$ResponseToJson(SearchGet$Response instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.totalPages case final value?) 'totalPages': value,
      if (instance.totalResults case final value?) 'totalResults': value,
      if (instance.results case final value?) 'results': value,
    };

SearchKeywordGet$Response _$SearchKeywordGet$ResponseFromJson(
        Map<String, dynamic> json) =>
    SearchKeywordGet$Response(
      page: (json['page'] as num?)?.toDouble(),
      totalPages: (json['totalPages'] as num?)?.toDouble(),
      totalResults: (json['totalResults'] as num?)?.toDouble(),
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => Keyword.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$SearchKeywordGet$ResponseToJson(
        SearchKeywordGet$Response instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.totalPages case final value?) 'totalPages': value,
      if (instance.totalResults case final value?) 'totalResults': value,
      if (instance.results?.map((e) => e.toJson()).toList() case final value?)
        'results': value,
    };

SearchCompanyGet$Response _$SearchCompanyGet$ResponseFromJson(
        Map<String, dynamic> json) =>
    SearchCompanyGet$Response(
      page: (json['page'] as num?)?.toDouble(),
      totalPages: (json['totalPages'] as num?)?.toDouble(),
      totalResults: (json['totalResults'] as num?)?.toDouble(),
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => Company.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$SearchCompanyGet$ResponseToJson(
        SearchCompanyGet$Response instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.totalPages case final value?) 'totalPages': value,
      if (instance.totalResults case final value?) 'totalResults': value,
      if (instance.results?.map((e) => e.toJson()).toList() case final value?)
        'results': value,
    };

DiscoverMoviesGet$Response _$DiscoverMoviesGet$ResponseFromJson(
        Map<String, dynamic> json) =>
    DiscoverMoviesGet$Response(
      page: (json['page'] as num?)?.toDouble(),
      totalPages: (json['totalPages'] as num?)?.toDouble(),
      totalResults: (json['totalResults'] as num?)?.toDouble(),
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => MovieResult.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$DiscoverMoviesGet$ResponseToJson(
        DiscoverMoviesGet$Response instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.totalPages case final value?) 'totalPages': value,
      if (instance.totalResults case final value?) 'totalResults': value,
      if (instance.results?.map((e) => e.toJson()).toList() case final value?)
        'results': value,
    };

DiscoverMoviesGenreGenreIdGet$Response
    _$DiscoverMoviesGenreGenreIdGet$ResponseFromJson(
            Map<String, dynamic> json) =>
        DiscoverMoviesGenreGenreIdGet$Response(
          page: (json['page'] as num?)?.toDouble(),
          totalPages: (json['totalPages'] as num?)?.toDouble(),
          totalResults: (json['totalResults'] as num?)?.toDouble(),
          genre: json['genre'] == null
              ? null
              : Genre.fromJson(json['genre'] as Map<String, dynamic>),
          results: (json['results'] as List<dynamic>?)
                  ?.map((e) => MovieResult.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              [],
        );

Map<String, dynamic> _$DiscoverMoviesGenreGenreIdGet$ResponseToJson(
        DiscoverMoviesGenreGenreIdGet$Response instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.totalPages case final value?) 'totalPages': value,
      if (instance.totalResults case final value?) 'totalResults': value,
      if (instance.genre?.toJson() case final value?) 'genre': value,
      if (instance.results?.map((e) => e.toJson()).toList() case final value?)
        'results': value,
    };

DiscoverMoviesLanguageLanguageGet$Response
    _$DiscoverMoviesLanguageLanguageGet$ResponseFromJson(
            Map<String, dynamic> json) =>
        DiscoverMoviesLanguageLanguageGet$Response(
          page: (json['page'] as num?)?.toDouble(),
          totalPages: (json['totalPages'] as num?)?.toDouble(),
          totalResults: (json['totalResults'] as num?)?.toDouble(),
          language: json['language'] == null
              ? null
              : SpokenLanguage.fromJson(
                  json['language'] as Map<String, dynamic>),
          results: (json['results'] as List<dynamic>?)
                  ?.map((e) => MovieResult.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              [],
        );

Map<String, dynamic> _$DiscoverMoviesLanguageLanguageGet$ResponseToJson(
        DiscoverMoviesLanguageLanguageGet$Response instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.totalPages case final value?) 'totalPages': value,
      if (instance.totalResults case final value?) 'totalResults': value,
      if (instance.language?.toJson() case final value?) 'language': value,
      if (instance.results?.map((e) => e.toJson()).toList() case final value?)
        'results': value,
    };

DiscoverMoviesStudioStudioIdGet$Response
    _$DiscoverMoviesStudioStudioIdGet$ResponseFromJson(
            Map<String, dynamic> json) =>
        DiscoverMoviesStudioStudioIdGet$Response(
          page: (json['page'] as num?)?.toDouble(),
          totalPages: (json['totalPages'] as num?)?.toDouble(),
          totalResults: (json['totalResults'] as num?)?.toDouble(),
          studio: json['studio'] == null
              ? null
              : ProductionCompany.fromJson(
                  json['studio'] as Map<String, dynamic>),
          results: (json['results'] as List<dynamic>?)
                  ?.map((e) => MovieResult.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              [],
        );

Map<String, dynamic> _$DiscoverMoviesStudioStudioIdGet$ResponseToJson(
        DiscoverMoviesStudioStudioIdGet$Response instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.totalPages case final value?) 'totalPages': value,
      if (instance.totalResults case final value?) 'totalResults': value,
      if (instance.studio?.toJson() case final value?) 'studio': value,
      if (instance.results?.map((e) => e.toJson()).toList() case final value?)
        'results': value,
    };

DiscoverMoviesUpcomingGet$Response _$DiscoverMoviesUpcomingGet$ResponseFromJson(
        Map<String, dynamic> json) =>
    DiscoverMoviesUpcomingGet$Response(
      page: (json['page'] as num?)?.toDouble(),
      totalPages: (json['totalPages'] as num?)?.toDouble(),
      totalResults: (json['totalResults'] as num?)?.toDouble(),
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => MovieResult.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$DiscoverMoviesUpcomingGet$ResponseToJson(
        DiscoverMoviesUpcomingGet$Response instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.totalPages case final value?) 'totalPages': value,
      if (instance.totalResults case final value?) 'totalResults': value,
      if (instance.results?.map((e) => e.toJson()).toList() case final value?)
        'results': value,
    };

DiscoverTvGet$Response _$DiscoverTvGet$ResponseFromJson(
        Map<String, dynamic> json) =>
    DiscoverTvGet$Response(
      page: (json['page'] as num?)?.toDouble(),
      totalPages: (json['totalPages'] as num?)?.toDouble(),
      totalResults: (json['totalResults'] as num?)?.toDouble(),
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => TvResult.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$DiscoverTvGet$ResponseToJson(
        DiscoverTvGet$Response instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.totalPages case final value?) 'totalPages': value,
      if (instance.totalResults case final value?) 'totalResults': value,
      if (instance.results?.map((e) => e.toJson()).toList() case final value?)
        'results': value,
    };

DiscoverTvLanguageLanguageGet$Response
    _$DiscoverTvLanguageLanguageGet$ResponseFromJson(
            Map<String, dynamic> json) =>
        DiscoverTvLanguageLanguageGet$Response(
          page: (json['page'] as num?)?.toDouble(),
          totalPages: (json['totalPages'] as num?)?.toDouble(),
          totalResults: (json['totalResults'] as num?)?.toDouble(),
          language: json['language'] == null
              ? null
              : SpokenLanguage.fromJson(
                  json['language'] as Map<String, dynamic>),
          results: (json['results'] as List<dynamic>?)
                  ?.map((e) => TvResult.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              [],
        );

Map<String, dynamic> _$DiscoverTvLanguageLanguageGet$ResponseToJson(
        DiscoverTvLanguageLanguageGet$Response instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.totalPages case final value?) 'totalPages': value,
      if (instance.totalResults case final value?) 'totalResults': value,
      if (instance.language?.toJson() case final value?) 'language': value,
      if (instance.results?.map((e) => e.toJson()).toList() case final value?)
        'results': value,
    };

DiscoverTvGenreGenreIdGet$Response _$DiscoverTvGenreGenreIdGet$ResponseFromJson(
        Map<String, dynamic> json) =>
    DiscoverTvGenreGenreIdGet$Response(
      page: (json['page'] as num?)?.toDouble(),
      totalPages: (json['totalPages'] as num?)?.toDouble(),
      totalResults: (json['totalResults'] as num?)?.toDouble(),
      genre: json['genre'] == null
          ? null
          : Genre.fromJson(json['genre'] as Map<String, dynamic>),
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => TvResult.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$DiscoverTvGenreGenreIdGet$ResponseToJson(
        DiscoverTvGenreGenreIdGet$Response instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.totalPages case final value?) 'totalPages': value,
      if (instance.totalResults case final value?) 'totalResults': value,
      if (instance.genre?.toJson() case final value?) 'genre': value,
      if (instance.results?.map((e) => e.toJson()).toList() case final value?)
        'results': value,
    };

DiscoverTvNetworkNetworkIdGet$Response
    _$DiscoverTvNetworkNetworkIdGet$ResponseFromJson(
            Map<String, dynamic> json) =>
        DiscoverTvNetworkNetworkIdGet$Response(
          page: (json['page'] as num?)?.toDouble(),
          totalPages: (json['totalPages'] as num?)?.toDouble(),
          totalResults: (json['totalResults'] as num?)?.toDouble(),
          network: json['network'] == null
              ? null
              : Network.fromJson(json['network'] as Map<String, dynamic>),
          results: (json['results'] as List<dynamic>?)
                  ?.map((e) => TvResult.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              [],
        );

Map<String, dynamic> _$DiscoverTvNetworkNetworkIdGet$ResponseToJson(
        DiscoverTvNetworkNetworkIdGet$Response instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.totalPages case final value?) 'totalPages': value,
      if (instance.totalResults case final value?) 'totalResults': value,
      if (instance.network?.toJson() case final value?) 'network': value,
      if (instance.results?.map((e) => e.toJson()).toList() case final value?)
        'results': value,
    };

DiscoverTvUpcomingGet$Response _$DiscoverTvUpcomingGet$ResponseFromJson(
        Map<String, dynamic> json) =>
    DiscoverTvUpcomingGet$Response(
      page: (json['page'] as num?)?.toDouble(),
      totalPages: (json['totalPages'] as num?)?.toDouble(),
      totalResults: (json['totalResults'] as num?)?.toDouble(),
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => TvResult.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$DiscoverTvUpcomingGet$ResponseToJson(
        DiscoverTvUpcomingGet$Response instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.totalPages case final value?) 'totalPages': value,
      if (instance.totalResults case final value?) 'totalResults': value,
      if (instance.results?.map((e) => e.toJson()).toList() case final value?)
        'results': value,
    };

DiscoverTrendingGet$Response _$DiscoverTrendingGet$ResponseFromJson(
        Map<String, dynamic> json) =>
    DiscoverTrendingGet$Response(
      page: (json['page'] as num?)?.toDouble(),
      totalPages: (json['totalPages'] as num?)?.toDouble(),
      totalResults: (json['totalResults'] as num?)?.toDouble(),
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => e as Object)
              .toList() ??
          [],
    );

Map<String, dynamic> _$DiscoverTrendingGet$ResponseToJson(
        DiscoverTrendingGet$Response instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.totalPages case final value?) 'totalPages': value,
      if (instance.totalResults case final value?) 'totalResults': value,
      if (instance.results case final value?) 'results': value,
    };

DiscoverKeywordKeywordIdMoviesGet$Response
    _$DiscoverKeywordKeywordIdMoviesGet$ResponseFromJson(
            Map<String, dynamic> json) =>
        DiscoverKeywordKeywordIdMoviesGet$Response(
          page: (json['page'] as num?)?.toDouble(),
          totalPages: (json['totalPages'] as num?)?.toDouble(),
          totalResults: (json['totalResults'] as num?)?.toDouble(),
          results: (json['results'] as List<dynamic>?)
                  ?.map((e) => MovieResult.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              [],
        );

Map<String, dynamic> _$DiscoverKeywordKeywordIdMoviesGet$ResponseToJson(
        DiscoverKeywordKeywordIdMoviesGet$Response instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.totalPages case final value?) 'totalPages': value,
      if (instance.totalResults case final value?) 'totalResults': value,
      if (instance.results?.map((e) => e.toJson()).toList() case final value?)
        'results': value,
    };

DiscoverGenresliderMovieGet$Response$Item
    _$DiscoverGenresliderMovieGet$Response$ItemFromJson(
            Map<String, dynamic> json) =>
        DiscoverGenresliderMovieGet$Response$Item(
          id: (json['id'] as num?)?.toDouble(),
          backdrops: (json['backdrops'] as List<dynamic>?)
                  ?.map((e) => e as Object)
                  .toList() ??
              [],
          name: json['name'] as String?,
        );

Map<String, dynamic> _$DiscoverGenresliderMovieGet$Response$ItemToJson(
        DiscoverGenresliderMovieGet$Response$Item instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.backdrops case final value?) 'backdrops': value,
      if (instance.name case final value?) 'name': value,
    };

DiscoverGenresliderTvGet$Response$Item
    _$DiscoverGenresliderTvGet$Response$ItemFromJson(
            Map<String, dynamic> json) =>
        DiscoverGenresliderTvGet$Response$Item(
          id: (json['id'] as num?)?.toDouble(),
          backdrops: (json['backdrops'] as List<dynamic>?)
                  ?.map((e) => e as Object)
                  .toList() ??
              [],
          name: json['name'] as String?,
        );

Map<String, dynamic> _$DiscoverGenresliderTvGet$Response$ItemToJson(
        DiscoverGenresliderTvGet$Response$Item instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.backdrops case final value?) 'backdrops': value,
      if (instance.name case final value?) 'name': value,
    };

DiscoverWatchlistGet$Response _$DiscoverWatchlistGet$ResponseFromJson(
        Map<String, dynamic> json) =>
    DiscoverWatchlistGet$Response(
      page: (json['page'] as num?)?.toDouble(),
      totalPages: (json['totalPages'] as num?)?.toDouble(),
      totalResults: (json['totalResults'] as num?)?.toDouble(),
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => DiscoverWatchlistGet$Response$Results$Item.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DiscoverWatchlistGet$ResponseToJson(
        DiscoverWatchlistGet$Response instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.totalPages case final value?) 'totalPages': value,
      if (instance.totalResults case final value?) 'totalResults': value,
      if (instance.results?.map((e) => e.toJson()).toList() case final value?)
        'results': value,
    };

RequestGet$Response _$RequestGet$ResponseFromJson(Map<String, dynamic> json) =>
    RequestGet$Response(
      pageInfo: json['pageInfo'] == null
          ? null
          : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>),
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => MediaRequest.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$RequestGet$ResponseToJson(
        RequestGet$Response instance) =>
    <String, dynamic>{
      if (instance.pageInfo?.toJson() case final value?) 'pageInfo': value,
      if (instance.results?.map((e) => e.toJson()).toList() case final value?)
        'results': value,
    };

RequestCountGet$Response _$RequestCountGet$ResponseFromJson(
        Map<String, dynamic> json) =>
    RequestCountGet$Response(
      total: (json['total'] as num?)?.toDouble(),
      movie: (json['movie'] as num?)?.toDouble(),
      tv: (json['tv'] as num?)?.toDouble(),
      pending: (json['pending'] as num?)?.toDouble(),
      approved: (json['approved'] as num?)?.toDouble(),
      declined: (json['declined'] as num?)?.toDouble(),
      processing: (json['processing'] as num?)?.toDouble(),
      available: (json['available'] as num?)?.toDouble(),
      completed: (json['completed'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$RequestCountGet$ResponseToJson(
        RequestCountGet$Response instance) =>
    <String, dynamic>{
      if (instance.total case final value?) 'total': value,
      if (instance.movie case final value?) 'movie': value,
      if (instance.tv case final value?) 'tv': value,
      if (instance.pending case final value?) 'pending': value,
      if (instance.approved case final value?) 'approved': value,
      if (instance.declined case final value?) 'declined': value,
      if (instance.processing case final value?) 'processing': value,
      if (instance.available case final value?) 'available': value,
      if (instance.completed case final value?) 'completed': value,
    };

MovieMovieIdRecommendationsGet$Response
    _$MovieMovieIdRecommendationsGet$ResponseFromJson(
            Map<String, dynamic> json) =>
        MovieMovieIdRecommendationsGet$Response(
          page: (json['page'] as num?)?.toDouble(),
          totalPages: (json['totalPages'] as num?)?.toDouble(),
          totalResults: (json['totalResults'] as num?)?.toDouble(),
          results: (json['results'] as List<dynamic>?)
                  ?.map((e) => MovieResult.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              [],
        );

Map<String, dynamic> _$MovieMovieIdRecommendationsGet$ResponseToJson(
        MovieMovieIdRecommendationsGet$Response instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.totalPages case final value?) 'totalPages': value,
      if (instance.totalResults case final value?) 'totalResults': value,
      if (instance.results?.map((e) => e.toJson()).toList() case final value?)
        'results': value,
    };

MovieMovieIdSimilarGet$Response _$MovieMovieIdSimilarGet$ResponseFromJson(
        Map<String, dynamic> json) =>
    MovieMovieIdSimilarGet$Response(
      page: (json['page'] as num?)?.toDouble(),
      totalPages: (json['totalPages'] as num?)?.toDouble(),
      totalResults: (json['totalResults'] as num?)?.toDouble(),
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => MovieResult.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$MovieMovieIdSimilarGet$ResponseToJson(
        MovieMovieIdSimilarGet$Response instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.totalPages case final value?) 'totalPages': value,
      if (instance.totalResults case final value?) 'totalResults': value,
      if (instance.results?.map((e) => e.toJson()).toList() case final value?)
        'results': value,
    };

MovieMovieIdRatingsGet$Response _$MovieMovieIdRatingsGet$ResponseFromJson(
        Map<String, dynamic> json) =>
    MovieMovieIdRatingsGet$Response(
      title: json['title'] as String?,
      year: (json['year'] as num?)?.toDouble(),
      url: json['url'] as String?,
      criticsScore: (json['criticsScore'] as num?)?.toDouble(),
      criticsRating:
          movieMovieIdRatingsGet$ResponseCriticsRatingNullableFromJson(
              json['criticsRating']),
      audienceScore: (json['audienceScore'] as num?)?.toDouble(),
      audienceRating:
          movieMovieIdRatingsGet$ResponseAudienceRatingNullableFromJson(
              json['audienceRating']),
    );

Map<String, dynamic> _$MovieMovieIdRatingsGet$ResponseToJson(
        MovieMovieIdRatingsGet$Response instance) =>
    <String, dynamic>{
      if (instance.title case final value?) 'title': value,
      if (instance.year case final value?) 'year': value,
      if (instance.url case final value?) 'url': value,
      if (instance.criticsScore case final value?) 'criticsScore': value,
      if (movieMovieIdRatingsGet$ResponseCriticsRatingNullableToJson(
              instance.criticsRating)
          case final value?)
        'criticsRating': value,
      if (instance.audienceScore case final value?) 'audienceScore': value,
      if (movieMovieIdRatingsGet$ResponseAudienceRatingNullableToJson(
              instance.audienceRating)
          case final value?)
        'audienceRating': value,
    };

MovieMovieIdRatingscombinedGet$Response
    _$MovieMovieIdRatingscombinedGet$ResponseFromJson(
            Map<String, dynamic> json) =>
        MovieMovieIdRatingscombinedGet$Response(
          rt: json['rt'] == null
              ? null
              : MovieMovieIdRatingscombinedGet$Response$Rt.fromJson(
                  json['rt'] as Map<String, dynamic>),
          imdb: json['imdb'] == null
              ? null
              : MovieMovieIdRatingscombinedGet$Response$Imdb.fromJson(
                  json['imdb'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$MovieMovieIdRatingscombinedGet$ResponseToJson(
        MovieMovieIdRatingscombinedGet$Response instance) =>
    <String, dynamic>{
      if (instance.rt?.toJson() case final value?) 'rt': value,
      if (instance.imdb?.toJson() case final value?) 'imdb': value,
    };

TvTvIdRecommendationsGet$Response _$TvTvIdRecommendationsGet$ResponseFromJson(
        Map<String, dynamic> json) =>
    TvTvIdRecommendationsGet$Response(
      page: (json['page'] as num?)?.toDouble(),
      totalPages: (json['totalPages'] as num?)?.toDouble(),
      totalResults: (json['totalResults'] as num?)?.toDouble(),
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => TvResult.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$TvTvIdRecommendationsGet$ResponseToJson(
        TvTvIdRecommendationsGet$Response instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.totalPages case final value?) 'totalPages': value,
      if (instance.totalResults case final value?) 'totalResults': value,
      if (instance.results?.map((e) => e.toJson()).toList() case final value?)
        'results': value,
    };

TvTvIdSimilarGet$Response _$TvTvIdSimilarGet$ResponseFromJson(
        Map<String, dynamic> json) =>
    TvTvIdSimilarGet$Response(
      page: (json['page'] as num?)?.toDouble(),
      totalPages: (json['totalPages'] as num?)?.toDouble(),
      totalResults: (json['totalResults'] as num?)?.toDouble(),
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => TvResult.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$TvTvIdSimilarGet$ResponseToJson(
        TvTvIdSimilarGet$Response instance) =>
    <String, dynamic>{
      if (instance.page case final value?) 'page': value,
      if (instance.totalPages case final value?) 'totalPages': value,
      if (instance.totalResults case final value?) 'totalResults': value,
      if (instance.results?.map((e) => e.toJson()).toList() case final value?)
        'results': value,
    };

TvTvIdRatingsGet$Response _$TvTvIdRatingsGet$ResponseFromJson(
        Map<String, dynamic> json) =>
    TvTvIdRatingsGet$Response(
      title: json['title'] as String?,
      year: (json['year'] as num?)?.toDouble(),
      url: json['url'] as String?,
      criticsScore: (json['criticsScore'] as num?)?.toDouble(),
      criticsRating: tvTvIdRatingsGet$ResponseCriticsRatingNullableFromJson(
          json['criticsRating']),
    );

Map<String, dynamic> _$TvTvIdRatingsGet$ResponseToJson(
        TvTvIdRatingsGet$Response instance) =>
    <String, dynamic>{
      if (instance.title case final value?) 'title': value,
      if (instance.year case final value?) 'year': value,
      if (instance.url case final value?) 'url': value,
      if (instance.criticsScore case final value?) 'criticsScore': value,
      if (tvTvIdRatingsGet$ResponseCriticsRatingNullableToJson(
              instance.criticsRating)
          case final value?)
        'criticsRating': value,
    };

PersonPersonIdCombinedCreditsGet$Response
    _$PersonPersonIdCombinedCreditsGet$ResponseFromJson(
            Map<String, dynamic> json) =>
        PersonPersonIdCombinedCreditsGet$Response(
          cast: (json['cast'] as List<dynamic>?)
                  ?.map((e) => CreditCast.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              [],
          crew: (json['crew'] as List<dynamic>?)
                  ?.map((e) => CreditCrew.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              [],
          id: (json['id'] as num?)?.toDouble(),
        );

Map<String, dynamic> _$PersonPersonIdCombinedCreditsGet$ResponseToJson(
        PersonPersonIdCombinedCreditsGet$Response instance) =>
    <String, dynamic>{
      if (instance.cast?.map((e) => e.toJson()).toList() case final value?)
        'cast': value,
      if (instance.crew?.map((e) => e.toJson()).toList() case final value?)
        'crew': value,
      if (instance.id case final value?) 'id': value,
    };

MediaGet$Response _$MediaGet$ResponseFromJson(Map<String, dynamic> json) =>
    MediaGet$Response(
      pageInfo: json['pageInfo'] == null
          ? null
          : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>),
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => MediaInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$MediaGet$ResponseToJson(MediaGet$Response instance) =>
    <String, dynamic>{
      if (instance.pageInfo?.toJson() case final value?) 'pageInfo': value,
      if (instance.results?.map((e) => e.toJson()).toList() case final value?)
        'results': value,
    };

MediaMediaIdWatchDataGet$Response _$MediaMediaIdWatchDataGet$ResponseFromJson(
        Map<String, dynamic> json) =>
    MediaMediaIdWatchDataGet$Response(
      data: json['data'] == null
          ? null
          : MediaMediaIdWatchDataGet$Response$Data.fromJson(
              json['data'] as Map<String, dynamic>),
      data4k: json['data4k'] == null
          ? null
          : MediaMediaIdWatchDataGet$Response$Data4k.fromJson(
              json['data4k'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MediaMediaIdWatchDataGet$ResponseToJson(
        MediaMediaIdWatchDataGet$Response instance) =>
    <String, dynamic>{
      if (instance.data?.toJson() case final value?) 'data': value,
      if (instance.data4k?.toJson() case final value?) 'data4k': value,
    };

ServiceRadarrRadarrIdGet$Response _$ServiceRadarrRadarrIdGet$ResponseFromJson(
        Map<String, dynamic> json) =>
    ServiceRadarrRadarrIdGet$Response(
      server: json['server'] == null
          ? null
          : RadarrSettings.fromJson(json['server'] as Map<String, dynamic>),
      profiles: json['profiles'] == null
          ? null
          : ServiceProfile.fromJson(json['profiles'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ServiceRadarrRadarrIdGet$ResponseToJson(
        ServiceRadarrRadarrIdGet$Response instance) =>
    <String, dynamic>{
      if (instance.server?.toJson() case final value?) 'server': value,
      if (instance.profiles?.toJson() case final value?) 'profiles': value,
    };

ServiceSonarrSonarrIdGet$Response _$ServiceSonarrSonarrIdGet$ResponseFromJson(
        Map<String, dynamic> json) =>
    ServiceSonarrSonarrIdGet$Response(
      server: json['server'] == null
          ? null
          : SonarrSettings.fromJson(json['server'] as Map<String, dynamic>),
      profiles: json['profiles'] == null
          ? null
          : ServiceProfile.fromJson(json['profiles'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ServiceSonarrSonarrIdGet$ResponseToJson(
        ServiceSonarrSonarrIdGet$Response instance) =>
    <String, dynamic>{
      if (instance.server?.toJson() case final value?) 'server': value,
      if (instance.profiles?.toJson() case final value?) 'profiles': value,
    };

RegionsGet$Response$Item _$RegionsGet$Response$ItemFromJson(
        Map<String, dynamic> json) =>
    RegionsGet$Response$Item(
      iso31661: json['iso_3166_1'] as String?,
      englishName: json['english_name'] as String?,
    );

Map<String, dynamic> _$RegionsGet$Response$ItemToJson(
        RegionsGet$Response$Item instance) =>
    <String, dynamic>{
      if (instance.iso31661 case final value?) 'iso_3166_1': value,
      if (instance.englishName case final value?) 'english_name': value,
    };

LanguagesGet$Response$Item _$LanguagesGet$Response$ItemFromJson(
        Map<String, dynamic> json) =>
    LanguagesGet$Response$Item(
      iso6391: json['iso_639_1'] as String?,
      englishName: json['english_name'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$LanguagesGet$Response$ItemToJson(
        LanguagesGet$Response$Item instance) =>
    <String, dynamic>{
      if (instance.iso6391 case final value?) 'iso_639_1': value,
      if (instance.englishName case final value?) 'english_name': value,
      if (instance.name case final value?) 'name': value,
    };

GenresMovieGet$Response$Item _$GenresMovieGet$Response$ItemFromJson(
        Map<String, dynamic> json) =>
    GenresMovieGet$Response$Item(
      id: (json['id'] as num?)?.toDouble(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$GenresMovieGet$Response$ItemToJson(
        GenresMovieGet$Response$Item instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.name case final value?) 'name': value,
    };

GenresTvGet$Response$Item _$GenresTvGet$Response$ItemFromJson(
        Map<String, dynamic> json) =>
    GenresTvGet$Response$Item(
      id: (json['id'] as num?)?.toDouble(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$GenresTvGet$Response$ItemToJson(
        GenresTvGet$Response$Item instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.name case final value?) 'name': value,
    };

IssueGet$Response _$IssueGet$ResponseFromJson(Map<String, dynamic> json) =>
    IssueGet$Response(
      pageInfo: json['pageInfo'] == null
          ? null
          : PageInfo.fromJson(json['pageInfo'] as Map<String, dynamic>),
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => Issue.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$IssueGet$ResponseToJson(IssueGet$Response instance) =>
    <String, dynamic>{
      if (instance.pageInfo?.toJson() case final value?) 'pageInfo': value,
      if (instance.results?.map((e) => e.toJson()).toList() case final value?)
        'results': value,
    };

IssueCountGet$Response _$IssueCountGet$ResponseFromJson(
        Map<String, dynamic> json) =>
    IssueCountGet$Response(
      total: (json['total'] as num?)?.toDouble(),
      video: (json['video'] as num?)?.toDouble(),
      audio: (json['audio'] as num?)?.toDouble(),
      subtitles: (json['subtitles'] as num?)?.toDouble(),
      others: (json['others'] as num?)?.toDouble(),
      open: (json['open'] as num?)?.toDouble(),
      closed: (json['closed'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$IssueCountGet$ResponseToJson(
        IssueCountGet$Response instance) =>
    <String, dynamic>{
      if (instance.total case final value?) 'total': value,
      if (instance.video case final value?) 'video': value,
      if (instance.audio case final value?) 'audio': value,
      if (instance.subtitles case final value?) 'subtitles': value,
      if (instance.others case final value?) 'others': value,
      if (instance.open case final value?) 'open': value,
      if (instance.closed case final value?) 'closed': value,
    };

NetworkSettings$Proxy _$NetworkSettings$ProxyFromJson(
        Map<String, dynamic> json) =>
    NetworkSettings$Proxy(
      enabled: json['enabled'] as bool?,
      hostname: json['hostname'] as String?,
      port: (json['port'] as num?)?.toDouble(),
      useSsl: json['useSsl'] as bool?,
      user: json['user'] as String?,
      password: json['password'] as String?,
      bypassFilter: json['bypassFilter'] as String?,
      bypassLocalAddresses: json['bypassLocalAddresses'] as bool?,
    );

Map<String, dynamic> _$NetworkSettings$ProxyToJson(
        NetworkSettings$Proxy instance) =>
    <String, dynamic>{
      if (instance.enabled case final value?) 'enabled': value,
      if (instance.hostname case final value?) 'hostname': value,
      if (instance.port case final value?) 'port': value,
      if (instance.useSsl case final value?) 'useSsl': value,
      if (instance.user case final value?) 'user': value,
      if (instance.password case final value?) 'password': value,
      if (instance.bypassFilter case final value?) 'bypassFilter': value,
      if (instance.bypassLocalAddresses case final value?)
        'bypassLocalAddresses': value,
    };

NetworkSettings$DnsCache _$NetworkSettings$DnsCacheFromJson(
        Map<String, dynamic> json) =>
    NetworkSettings$DnsCache(
      enabled: json['enabled'] as bool?,
      forceMinTtl: (json['forceMinTtl'] as num?)?.toDouble(),
      forceMaxTtl: (json['forceMaxTtl'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$NetworkSettings$DnsCacheToJson(
        NetworkSettings$DnsCache instance) =>
    <String, dynamic>{
      if (instance.enabled case final value?) 'enabled': value,
      if (instance.forceMinTtl case final value?) 'forceMinTtl': value,
      if (instance.forceMaxTtl case final value?) 'forceMaxTtl': value,
    };

MetadataSettings$Settings _$MetadataSettings$SettingsFromJson(
        Map<String, dynamic> json) =>
    MetadataSettings$Settings(
      tv: metadataSettings$SettingsTvNullableFromJson(json['tv']),
      anime: metadataSettings$SettingsAnimeNullableFromJson(json['anime']),
    );

Map<String, dynamic> _$MetadataSettings$SettingsToJson(
        MetadataSettings$Settings instance) =>
    <String, dynamic>{
      if (metadataSettings$SettingsTvNullableToJson(instance.tv)
          case final value?)
        'tv': value,
      if (metadataSettings$SettingsAnimeNullableToJson(instance.anime)
          case final value?)
        'anime': value,
    };

MovieDetails$ProductionCountries$Item
    _$MovieDetails$ProductionCountries$ItemFromJson(
            Map<String, dynamic> json) =>
        MovieDetails$ProductionCountries$Item(
          iso31661: json['iso_3166_1'] as String?,
          name: json['name'] as String?,
        );

Map<String, dynamic> _$MovieDetails$ProductionCountries$ItemToJson(
        MovieDetails$ProductionCountries$Item instance) =>
    <String, dynamic>{
      if (instance.iso31661 case final value?) 'iso_3166_1': value,
      if (instance.name case final value?) 'name': value,
    };

MovieDetails$Releases _$MovieDetails$ReleasesFromJson(
        Map<String, dynamic> json) =>
    MovieDetails$Releases(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => MovieDetails$Releases$Results$Item.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieDetails$ReleasesToJson(
        MovieDetails$Releases instance) =>
    <String, dynamic>{
      if (instance.results?.map((e) => e.toJson()).toList() case final value?)
        'results': value,
    };

MovieDetails$Credits _$MovieDetails$CreditsFromJson(
        Map<String, dynamic> json) =>
    MovieDetails$Credits(
      cast: (json['cast'] as List<dynamic>?)
              ?.map((e) => Cast.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      crew: (json['crew'] as List<dynamic>?)
              ?.map((e) => Crew.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$MovieDetails$CreditsToJson(
        MovieDetails$Credits instance) =>
    <String, dynamic>{
      if (instance.cast?.map((e) => e.toJson()).toList() case final value?)
        'cast': value,
      if (instance.crew?.map((e) => e.toJson()).toList() case final value?)
        'crew': value,
    };

MovieDetails$Collection _$MovieDetails$CollectionFromJson(
        Map<String, dynamic> json) =>
    MovieDetails$Collection(
      id: (json['id'] as num?)?.toDouble(),
      name: json['name'] as String?,
      posterPath: json['posterPath'] as String?,
      backdropPath: json['backdropPath'] as String?,
    );

Map<String, dynamic> _$MovieDetails$CollectionToJson(
        MovieDetails$Collection instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.name case final value?) 'name': value,
      if (instance.posterPath case final value?) 'posterPath': value,
      if (instance.backdropPath case final value?) 'backdropPath': value,
    };

TvDetails$ContentRatings _$TvDetails$ContentRatingsFromJson(
        Map<String, dynamic> json) =>
    TvDetails$ContentRatings(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => TvDetails$ContentRatings$Results$Item.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TvDetails$ContentRatingsToJson(
        TvDetails$ContentRatings instance) =>
    <String, dynamic>{
      if (instance.results?.map((e) => e.toJson()).toList() case final value?)
        'results': value,
    };

TvDetails$CreatedBy$Item _$TvDetails$CreatedBy$ItemFromJson(
        Map<String, dynamic> json) =>
    TvDetails$CreatedBy$Item(
      id: (json['id'] as num?)?.toDouble(),
      name: json['name'] as String?,
      gender: (json['gender'] as num?)?.toDouble(),
      profilePath: json['profilePath'] as String?,
    );

Map<String, dynamic> _$TvDetails$CreatedBy$ItemToJson(
        TvDetails$CreatedBy$Item instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.name case final value?) 'name': value,
      if (instance.gender case final value?) 'gender': value,
      if (instance.profilePath case final value?) 'profilePath': value,
    };

TvDetails$ProductionCountries$Item _$TvDetails$ProductionCountries$ItemFromJson(
        Map<String, dynamic> json) =>
    TvDetails$ProductionCountries$Item(
      iso31661: json['iso_3166_1'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$TvDetails$ProductionCountries$ItemToJson(
        TvDetails$ProductionCountries$Item instance) =>
    <String, dynamic>{
      if (instance.iso31661 case final value?) 'iso_3166_1': value,
      if (instance.name case final value?) 'name': value,
    };

TvDetails$Credits _$TvDetails$CreditsFromJson(Map<String, dynamic> json) =>
    TvDetails$Credits(
      cast: (json['cast'] as List<dynamic>?)
              ?.map((e) => Cast.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      crew: (json['crew'] as List<dynamic>?)
              ?.map((e) => Crew.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$TvDetails$CreditsToJson(TvDetails$Credits instance) =>
    <String, dynamic>{
      if (instance.cast?.map((e) => e.toJson()).toList() case final value?)
        'cast': value,
      if (instance.crew?.map((e) => e.toJson()).toList() case final value?)
        'crew': value,
    };

DiscordSettings$Options _$DiscordSettings$OptionsFromJson(
        Map<String, dynamic> json) =>
    DiscordSettings$Options(
      botUsername: json['botUsername'] as String?,
      botAvatarUrl: json['botAvatarUrl'] as String?,
      webhookUrl: json['webhookUrl'] as String?,
      webhookRoleId: json['webhookRoleId'] as String?,
      enableMentions: json['enableMentions'] as bool?,
    );

Map<String, dynamic> _$DiscordSettings$OptionsToJson(
        DiscordSettings$Options instance) =>
    <String, dynamic>{
      if (instance.botUsername case final value?) 'botUsername': value,
      if (instance.botAvatarUrl case final value?) 'botAvatarUrl': value,
      if (instance.webhookUrl case final value?) 'webhookUrl': value,
      if (instance.webhookRoleId case final value?) 'webhookRoleId': value,
      if (instance.enableMentions case final value?) 'enableMentions': value,
    };

SlackSettings$Options _$SlackSettings$OptionsFromJson(
        Map<String, dynamic> json) =>
    SlackSettings$Options(
      webhookUrl: json['webhookUrl'] as String?,
    );

Map<String, dynamic> _$SlackSettings$OptionsToJson(
        SlackSettings$Options instance) =>
    <String, dynamic>{
      if (instance.webhookUrl case final value?) 'webhookUrl': value,
    };

WebhookSettings$Options _$WebhookSettings$OptionsFromJson(
        Map<String, dynamic> json) =>
    WebhookSettings$Options(
      webhookUrl: json['webhookUrl'] as String?,
      authHeader: json['authHeader'] as String?,
      jsonPayload: json['jsonPayload'] as String?,
      supportVariables: json['supportVariables'] as bool?,
    );

Map<String, dynamic> _$WebhookSettings$OptionsToJson(
        WebhookSettings$Options instance) =>
    <String, dynamic>{
      if (instance.webhookUrl case final value?) 'webhookUrl': value,
      if (instance.authHeader case final value?) 'authHeader': value,
      if (instance.jsonPayload case final value?) 'jsonPayload': value,
      if (instance.supportVariables case final value?)
        'supportVariables': value,
    };

TelegramSettings$Options _$TelegramSettings$OptionsFromJson(
        Map<String, dynamic> json) =>
    TelegramSettings$Options(
      botUsername: json['botUsername'] as String?,
      botAPI: json['botAPI'] as String?,
      chatId: json['chatId'] as String?,
      messageThreadId: json['messageThreadId'] as String?,
      sendSilently: json['sendSilently'] as bool?,
    );

Map<String, dynamic> _$TelegramSettings$OptionsToJson(
        TelegramSettings$Options instance) =>
    <String, dynamic>{
      if (instance.botUsername case final value?) 'botUsername': value,
      if (instance.botAPI case final value?) 'botAPI': value,
      if (instance.chatId case final value?) 'chatId': value,
      if (instance.messageThreadId case final value?) 'messageThreadId': value,
      if (instance.sendSilently case final value?) 'sendSilently': value,
    };

PushbulletSettings$Options _$PushbulletSettings$OptionsFromJson(
        Map<String, dynamic> json) =>
    PushbulletSettings$Options(
      accessToken: json['accessToken'] as String?,
      channelTag: json['channelTag'] as String?,
    );

Map<String, dynamic> _$PushbulletSettings$OptionsToJson(
        PushbulletSettings$Options instance) =>
    <String, dynamic>{
      if (instance.accessToken case final value?) 'accessToken': value,
      if (instance.channelTag case final value?) 'channelTag': value,
    };

PushoverSettings$Options _$PushoverSettings$OptionsFromJson(
        Map<String, dynamic> json) =>
    PushoverSettings$Options(
      accessToken: json['accessToken'] as String?,
      userToken: json['userToken'] as String?,
      sound: json['sound'] as String?,
    );

Map<String, dynamic> _$PushoverSettings$OptionsToJson(
        PushoverSettings$Options instance) =>
    <String, dynamic>{
      if (instance.accessToken case final value?) 'accessToken': value,
      if (instance.userToken case final value?) 'userToken': value,
      if (instance.sound case final value?) 'sound': value,
    };

GotifySettings$Options _$GotifySettings$OptionsFromJson(
        Map<String, dynamic> json) =>
    GotifySettings$Options(
      url: json['url'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$GotifySettings$OptionsToJson(
        GotifySettings$Options instance) =>
    <String, dynamic>{
      if (instance.url case final value?) 'url': value,
      if (instance.token case final value?) 'token': value,
    };

NtfySettings$Options _$NtfySettings$OptionsFromJson(
        Map<String, dynamic> json) =>
    NtfySettings$Options(
      url: json['url'] as String?,
      topic: json['topic'] as String?,
      authMethodUsernamePassword: json['authMethodUsernamePassword'] as bool?,
      username: json['username'] as String?,
      password: json['password'] as String?,
      authMethodToken: json['authMethodToken'] as bool?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$NtfySettings$OptionsToJson(
        NtfySettings$Options instance) =>
    <String, dynamic>{
      if (instance.url case final value?) 'url': value,
      if (instance.topic case final value?) 'topic': value,
      if (instance.authMethodUsernamePassword case final value?)
        'authMethodUsernamePassword': value,
      if (instance.username case final value?) 'username': value,
      if (instance.password case final value?) 'password': value,
      if (instance.authMethodToken case final value?) 'authMethodToken': value,
      if (instance.token case final value?) 'token': value,
    };

NotificationEmailSettings$Options _$NotificationEmailSettings$OptionsFromJson(
        Map<String, dynamic> json) =>
    NotificationEmailSettings$Options(
      emailFrom: json['emailFrom'] as String?,
      senderName: json['senderName'] as String?,
      smtpHost: json['smtpHost'] as String?,
      smtpPort: (json['smtpPort'] as num?)?.toDouble(),
      secure: json['secure'] as bool?,
      ignoreTls: json['ignoreTls'] as bool?,
      requireTls: json['requireTls'] as bool?,
      authUser: json['authUser'] as String?,
      authPass: json['authPass'] as String?,
      allowSelfSigned: json['allowSelfSigned'] as bool?,
    );

Map<String, dynamic> _$NotificationEmailSettings$OptionsToJson(
        NotificationEmailSettings$Options instance) =>
    <String, dynamic>{
      if (instance.emailFrom case final value?) 'emailFrom': value,
      if (instance.senderName case final value?) 'senderName': value,
      if (instance.smtpHost case final value?) 'smtpHost': value,
      if (instance.smtpPort case final value?) 'smtpPort': value,
      if (instance.secure case final value?) 'secure': value,
      if (instance.ignoreTls case final value?) 'ignoreTls': value,
      if (instance.requireTls case final value?) 'requireTls': value,
      if (instance.authUser case final value?) 'authUser': value,
      if (instance.authPass case final value?) 'authPass': value,
      if (instance.allowSelfSigned case final value?) 'allowSelfSigned': value,
    };

SonarrSeries$Images$Item _$SonarrSeries$Images$ItemFromJson(
        Map<String, dynamic> json) =>
    SonarrSeries$Images$Item(
      coverType: json['coverType'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$SonarrSeries$Images$ItemToJson(
        SonarrSeries$Images$Item instance) =>
    <String, dynamic>{
      if (instance.coverType case final value?) 'coverType': value,
      if (instance.url case final value?) 'url': value,
    };

SonarrSeries$Seasons$Item _$SonarrSeries$Seasons$ItemFromJson(
        Map<String, dynamic> json) =>
    SonarrSeries$Seasons$Item(
      seasonNumber: (json['seasonNumber'] as num?)?.toDouble(),
      monitored: json['monitored'] as bool?,
    );

Map<String, dynamic> _$SonarrSeries$Seasons$ItemToJson(
        SonarrSeries$Seasons$Item instance) =>
    <String, dynamic>{
      if (instance.seasonNumber case final value?) 'seasonNumber': value,
      if (instance.monitored case final value?) 'monitored': value,
    };

SonarrSeries$Ratings$Item _$SonarrSeries$Ratings$ItemFromJson(
        Map<String, dynamic> json) =>
    SonarrSeries$Ratings$Item(
      votes: (json['votes'] as num?)?.toDouble(),
      $value: (json['value'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$SonarrSeries$Ratings$ItemToJson(
        SonarrSeries$Ratings$Item instance) =>
    <String, dynamic>{
      if (instance.votes case final value?) 'votes': value,
      if (instance.$value case final value?) 'value': value,
    };

SonarrSeries$AddOptions$Item _$SonarrSeries$AddOptions$ItemFromJson(
        Map<String, dynamic> json) =>
    SonarrSeries$AddOptions$Item(
      ignoreEpisodesWithFiles: json['ignoreEpisodesWithFiles'] as bool?,
      ignoreEpisodesWithoutFiles: json['ignoreEpisodesWithoutFiles'] as bool?,
      searchForMissingEpisodes: json['searchForMissingEpisodes'] as bool?,
    );

Map<String, dynamic> _$SonarrSeries$AddOptions$ItemToJson(
        SonarrSeries$AddOptions$Item instance) =>
    <String, dynamic>{
      if (instance.ignoreEpisodesWithFiles case final value?)
        'ignoreEpisodesWithFiles': value,
      if (instance.ignoreEpisodesWithoutFiles case final value?)
        'ignoreEpisodesWithoutFiles': value,
      if (instance.searchForMissingEpisodes case final value?)
        'searchForMissingEpisodes': value,
    };

SettingsCacheGet$Response$ImageCache
    _$SettingsCacheGet$Response$ImageCacheFromJson(Map<String, dynamic> json) =>
        SettingsCacheGet$Response$ImageCache(
          tmdb: json['tmdb'] == null
              ? null
              : SettingsCacheGet$Response$ImageCache$Tmdb.fromJson(
                  json['tmdb'] as Map<String, dynamic>),
          avatar: json['avatar'] == null
              ? null
              : SettingsCacheGet$Response$ImageCache$Avatar.fromJson(
                  json['avatar'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$SettingsCacheGet$Response$ImageCacheToJson(
        SettingsCacheGet$Response$ImageCache instance) =>
    <String, dynamic>{
      if (instance.tmdb?.toJson() case final value?) 'tmdb': value,
      if (instance.avatar?.toJson() case final value?) 'avatar': value,
    };

SettingsCacheGet$Response$DnsCache _$SettingsCacheGet$Response$DnsCacheFromJson(
        Map<String, dynamic> json) =>
    SettingsCacheGet$Response$DnsCache(
      stats: json['stats'] == null
          ? null
          : SettingsCacheGet$Response$DnsCache$Stats.fromJson(
              json['stats'] as Map<String, dynamic>),
      entries: json['entries'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$SettingsCacheGet$Response$DnsCacheToJson(
        SettingsCacheGet$Response$DnsCache instance) =>
    <String, dynamic>{
      if (instance.stats?.toJson() case final value?) 'stats': value,
      if (instance.entries case final value?) 'entries': value,
    };

SettingsCacheGet$Response$ApiCaches$Item
    _$SettingsCacheGet$Response$ApiCaches$ItemFromJson(
            Map<String, dynamic> json) =>
        SettingsCacheGet$Response$ApiCaches$Item(
          id: json['id'] as String?,
          name: json['name'] as String?,
          stats: json['stats'] == null
              ? null
              : SettingsCacheGet$Response$ApiCaches$Item$Stats.fromJson(
                  json['stats'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$SettingsCacheGet$Response$ApiCaches$ItemToJson(
        SettingsCacheGet$Response$ApiCaches$Item instance) =>
    <String, dynamic>{
      if (instance.id case final value?) 'id': value,
      if (instance.name case final value?) 'name': value,
      if (instance.stats?.toJson() case final value?) 'stats': value,
    };

UserUserIdQuotaGet$Response$Movie _$UserUserIdQuotaGet$Response$MovieFromJson(
        Map<String, dynamic> json) =>
    UserUserIdQuotaGet$Response$Movie(
      days: (json['days'] as num?)?.toDouble(),
      limit: (json['limit'] as num?)?.toDouble(),
      used: (json['used'] as num?)?.toDouble(),
      remaining: (json['remaining'] as num?)?.toDouble(),
      restricted: json['restricted'] as bool?,
    );

Map<String, dynamic> _$UserUserIdQuotaGet$Response$MovieToJson(
        UserUserIdQuotaGet$Response$Movie instance) =>
    <String, dynamic>{
      if (instance.days case final value?) 'days': value,
      if (instance.limit case final value?) 'limit': value,
      if (instance.used case final value?) 'used': value,
      if (instance.remaining case final value?) 'remaining': value,
      if (instance.restricted case final value?) 'restricted': value,
    };

UserUserIdQuotaGet$Response$Tv _$UserUserIdQuotaGet$Response$TvFromJson(
        Map<String, dynamic> json) =>
    UserUserIdQuotaGet$Response$Tv(
      days: (json['days'] as num?)?.toDouble(),
      limit: (json['limit'] as num?)?.toDouble(),
      used: (json['used'] as num?)?.toDouble(),
      remaining: (json['remaining'] as num?)?.toDouble(),
      restricted: json['restricted'] as bool?,
    );

Map<String, dynamic> _$UserUserIdQuotaGet$Response$TvToJson(
        UserUserIdQuotaGet$Response$Tv instance) =>
    <String, dynamic>{
      if (instance.days case final value?) 'days': value,
      if (instance.limit case final value?) 'limit': value,
      if (instance.used case final value?) 'used': value,
      if (instance.remaining case final value?) 'remaining': value,
      if (instance.restricted case final value?) 'restricted': value,
    };

BlacklistGet$Response$Results$Item _$BlacklistGet$Response$Results$ItemFromJson(
        Map<String, dynamic> json) =>
    BlacklistGet$Response$Results$Item(
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String?,
      id: (json['id'] as num?)?.toDouble(),
      mediaType: json['mediaType'] as String?,
      title: json['title'] as String?,
      tmdbId: (json['tmdbId'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$BlacklistGet$Response$Results$ItemToJson(
        BlacklistGet$Response$Results$Item instance) =>
    <String, dynamic>{
      if (instance.user?.toJson() case final value?) 'user': value,
      if (instance.createdAt case final value?) 'createdAt': value,
      if (instance.id case final value?) 'id': value,
      if (instance.mediaType case final value?) 'mediaType': value,
      if (instance.title case final value?) 'title': value,
      if (instance.tmdbId case final value?) 'tmdbId': value,
    };

UserUserIdWatchlistGet$Response$Results$Item
    _$UserUserIdWatchlistGet$Response$Results$ItemFromJson(
            Map<String, dynamic> json) =>
        UserUserIdWatchlistGet$Response$Results$Item(
          tmdbId: (json['tmdbId'] as num?)?.toDouble(),
          ratingKey: json['ratingKey'] as String?,
          type: json['type'] as String?,
          title: json['title'] as String?,
        );

Map<String, dynamic> _$UserUserIdWatchlistGet$Response$Results$ItemToJson(
        UserUserIdWatchlistGet$Response$Results$Item instance) =>
    <String, dynamic>{
      if (instance.tmdbId case final value?) 'tmdbId': value,
      if (instance.ratingKey case final value?) 'ratingKey': value,
      if (instance.type case final value?) 'type': value,
      if (instance.title case final value?) 'title': value,
    };

DiscoverWatchlistGet$Response$Results$Item
    _$DiscoverWatchlistGet$Response$Results$ItemFromJson(
            Map<String, dynamic> json) =>
        DiscoverWatchlistGet$Response$Results$Item(
          tmdbId: (json['tmdbId'] as num?)?.toDouble(),
          ratingKey: json['ratingKey'] as String?,
          type: json['type'] as String?,
          title: json['title'] as String?,
        );

Map<String, dynamic> _$DiscoverWatchlistGet$Response$Results$ItemToJson(
        DiscoverWatchlistGet$Response$Results$Item instance) =>
    <String, dynamic>{
      if (instance.tmdbId case final value?) 'tmdbId': value,
      if (instance.ratingKey case final value?) 'ratingKey': value,
      if (instance.type case final value?) 'type': value,
      if (instance.title case final value?) 'title': value,
    };

MovieMovieIdRatingscombinedGet$Response$Rt
    _$MovieMovieIdRatingscombinedGet$Response$RtFromJson(
            Map<String, dynamic> json) =>
        MovieMovieIdRatingscombinedGet$Response$Rt(
          title: json['title'] as String?,
          year: (json['year'] as num?)?.toDouble(),
          url: json['url'] as String?,
          criticsScore: (json['criticsScore'] as num?)?.toDouble(),
          criticsRating:
              movieMovieIdRatingscombinedGet$Response$RtCriticsRatingNullableFromJson(
                  json['criticsRating']),
          audienceScore: (json['audienceScore'] as num?)?.toDouble(),
          audienceRating:
              movieMovieIdRatingscombinedGet$Response$RtAudienceRatingNullableFromJson(
                  json['audienceRating']),
        );

Map<String, dynamic> _$MovieMovieIdRatingscombinedGet$Response$RtToJson(
        MovieMovieIdRatingscombinedGet$Response$Rt instance) =>
    <String, dynamic>{
      if (instance.title case final value?) 'title': value,
      if (instance.year case final value?) 'year': value,
      if (instance.url case final value?) 'url': value,
      if (instance.criticsScore case final value?) 'criticsScore': value,
      if (movieMovieIdRatingscombinedGet$Response$RtCriticsRatingNullableToJson(
              instance.criticsRating)
          case final value?)
        'criticsRating': value,
      if (instance.audienceScore case final value?) 'audienceScore': value,
      if (movieMovieIdRatingscombinedGet$Response$RtAudienceRatingNullableToJson(
              instance.audienceRating)
          case final value?)
        'audienceRating': value,
    };

MovieMovieIdRatingscombinedGet$Response$Imdb
    _$MovieMovieIdRatingscombinedGet$Response$ImdbFromJson(
            Map<String, dynamic> json) =>
        MovieMovieIdRatingscombinedGet$Response$Imdb(
          title: json['title'] as String?,
          url: json['url'] as String?,
          criticsScore: (json['criticsScore'] as num?)?.toDouble(),
        );

Map<String, dynamic> _$MovieMovieIdRatingscombinedGet$Response$ImdbToJson(
        MovieMovieIdRatingscombinedGet$Response$Imdb instance) =>
    <String, dynamic>{
      if (instance.title case final value?) 'title': value,
      if (instance.url case final value?) 'url': value,
      if (instance.criticsScore case final value?) 'criticsScore': value,
    };

MediaMediaIdWatchDataGet$Response$Data
    _$MediaMediaIdWatchDataGet$Response$DataFromJson(
            Map<String, dynamic> json) =>
        MediaMediaIdWatchDataGet$Response$Data(
          playCount7Days: (json['playCount7Days'] as num?)?.toDouble(),
          playCount30Days: (json['playCount30Days'] as num?)?.toDouble(),
          playCount: (json['playCount'] as num?)?.toDouble(),
          users: (json['users'] as List<dynamic>?)
                  ?.map((e) => User.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              [],
        );

Map<String, dynamic> _$MediaMediaIdWatchDataGet$Response$DataToJson(
        MediaMediaIdWatchDataGet$Response$Data instance) =>
    <String, dynamic>{
      if (instance.playCount7Days case final value?) 'playCount7Days': value,
      if (instance.playCount30Days case final value?) 'playCount30Days': value,
      if (instance.playCount case final value?) 'playCount': value,
      if (instance.users?.map((e) => e.toJson()).toList() case final value?)
        'users': value,
    };

MediaMediaIdWatchDataGet$Response$Data4k
    _$MediaMediaIdWatchDataGet$Response$Data4kFromJson(
            Map<String, dynamic> json) =>
        MediaMediaIdWatchDataGet$Response$Data4k(
          playCount7Days: (json['playCount7Days'] as num?)?.toDouble(),
          playCount30Days: (json['playCount30Days'] as num?)?.toDouble(),
          playCount: (json['playCount'] as num?)?.toDouble(),
          users: (json['users'] as List<dynamic>?)
                  ?.map((e) => User.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              [],
        );

Map<String, dynamic> _$MediaMediaIdWatchDataGet$Response$Data4kToJson(
        MediaMediaIdWatchDataGet$Response$Data4k instance) =>
    <String, dynamic>{
      if (instance.playCount7Days case final value?) 'playCount7Days': value,
      if (instance.playCount30Days case final value?) 'playCount30Days': value,
      if (instance.playCount case final value?) 'playCount': value,
      if (instance.users?.map((e) => e.toJson()).toList() case final value?)
        'users': value,
    };

MovieDetails$Releases$Results$Item _$MovieDetails$Releases$Results$ItemFromJson(
        Map<String, dynamic> json) =>
    MovieDetails$Releases$Results$Item(
      iso31661: json['iso_3166_1'] as String?,
      rating: json['rating'] as String?,
      releaseDates: (json['release_dates'] as List<dynamic>?)
          ?.map((e) =>
              MovieDetails$Releases$Results$Item$ReleaseDates$Item.fromJson(
                  e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieDetails$Releases$Results$ItemToJson(
        MovieDetails$Releases$Results$Item instance) =>
    <String, dynamic>{
      if (instance.iso31661 case final value?) 'iso_3166_1': value,
      if (instance.rating case final value?) 'rating': value,
      if (instance.releaseDates?.map((e) => e.toJson()).toList()
          case final value?)
        'release_dates': value,
    };

TvDetails$ContentRatings$Results$Item
    _$TvDetails$ContentRatings$Results$ItemFromJson(
            Map<String, dynamic> json) =>
        TvDetails$ContentRatings$Results$Item(
          iso31661: json['iso_3166_1'] as String?,
          rating: json['rating'] as String?,
        );

Map<String, dynamic> _$TvDetails$ContentRatings$Results$ItemToJson(
        TvDetails$ContentRatings$Results$Item instance) =>
    <String, dynamic>{
      if (instance.iso31661 case final value?) 'iso_3166_1': value,
      if (instance.rating case final value?) 'rating': value,
    };

SettingsCacheGet$Response$ImageCache$Tmdb
    _$SettingsCacheGet$Response$ImageCache$TmdbFromJson(
            Map<String, dynamic> json) =>
        SettingsCacheGet$Response$ImageCache$Tmdb(
          size: (json['size'] as num?)?.toDouble(),
          imageCount: (json['imageCount'] as num?)?.toDouble(),
        );

Map<String, dynamic> _$SettingsCacheGet$Response$ImageCache$TmdbToJson(
        SettingsCacheGet$Response$ImageCache$Tmdb instance) =>
    <String, dynamic>{
      if (instance.size case final value?) 'size': value,
      if (instance.imageCount case final value?) 'imageCount': value,
    };

SettingsCacheGet$Response$ImageCache$Avatar
    _$SettingsCacheGet$Response$ImageCache$AvatarFromJson(
            Map<String, dynamic> json) =>
        SettingsCacheGet$Response$ImageCache$Avatar(
          size: (json['size'] as num?)?.toDouble(),
          imageCount: (json['imageCount'] as num?)?.toDouble(),
        );

Map<String, dynamic> _$SettingsCacheGet$Response$ImageCache$AvatarToJson(
        SettingsCacheGet$Response$ImageCache$Avatar instance) =>
    <String, dynamic>{
      if (instance.size case final value?) 'size': value,
      if (instance.imageCount case final value?) 'imageCount': value,
    };

SettingsCacheGet$Response$DnsCache$Stats
    _$SettingsCacheGet$Response$DnsCache$StatsFromJson(
            Map<String, dynamic> json) =>
        SettingsCacheGet$Response$DnsCache$Stats(
          size: (json['size'] as num?)?.toDouble(),
          maxSize: (json['maxSize'] as num?)?.toDouble(),
          hits: (json['hits'] as num?)?.toDouble(),
          misses: (json['misses'] as num?)?.toDouble(),
          failures: (json['failures'] as num?)?.toDouble(),
          ipv4Fallbacks: (json['ipv4Fallbacks'] as num?)?.toDouble(),
          hitRate: (json['hitRate'] as num?)?.toDouble(),
        );

Map<String, dynamic> _$SettingsCacheGet$Response$DnsCache$StatsToJson(
        SettingsCacheGet$Response$DnsCache$Stats instance) =>
    <String, dynamic>{
      if (instance.size case final value?) 'size': value,
      if (instance.maxSize case final value?) 'maxSize': value,
      if (instance.hits case final value?) 'hits': value,
      if (instance.misses case final value?) 'misses': value,
      if (instance.failures case final value?) 'failures': value,
      if (instance.ipv4Fallbacks case final value?) 'ipv4Fallbacks': value,
      if (instance.hitRate case final value?) 'hitRate': value,
    };

SettingsCacheGet$Response$ApiCaches$Item$Stats
    _$SettingsCacheGet$Response$ApiCaches$Item$StatsFromJson(
            Map<String, dynamic> json) =>
        SettingsCacheGet$Response$ApiCaches$Item$Stats(
          hits: (json['hits'] as num?)?.toDouble(),
          misses: (json['misses'] as num?)?.toDouble(),
          keys: (json['keys'] as num?)?.toDouble(),
          ksize: (json['ksize'] as num?)?.toDouble(),
          vsize: (json['vsize'] as num?)?.toDouble(),
        );

Map<String, dynamic> _$SettingsCacheGet$Response$ApiCaches$Item$StatsToJson(
        SettingsCacheGet$Response$ApiCaches$Item$Stats instance) =>
    <String, dynamic>{
      if (instance.hits case final value?) 'hits': value,
      if (instance.misses case final value?) 'misses': value,
      if (instance.keys case final value?) 'keys': value,
      if (instance.ksize case final value?) 'ksize': value,
      if (instance.vsize case final value?) 'vsize': value,
    };

MovieDetails$Releases$Results$Item$ReleaseDates$Item
    _$MovieDetails$Releases$Results$Item$ReleaseDates$ItemFromJson(
            Map<String, dynamic> json) =>
        MovieDetails$Releases$Results$Item$ReleaseDates$Item(
          certification: json['certification'] as String?,
          iso6391: json['iso_639_1'] as String?,
          note: json['note'] as String?,
          releaseDate: json['release_date'] as String?,
          type: (json['type'] as num?)?.toDouble(),
        );

Map<String, dynamic>
    _$MovieDetails$Releases$Results$Item$ReleaseDates$ItemToJson(
            MovieDetails$Releases$Results$Item$ReleaseDates$Item instance) =>
        <String, dynamic>{
          if (instance.certification case final value?) 'certification': value,
          if (instance.iso6391 case final value?) 'iso_639_1': value,
          if (instance.note case final value?) 'note': value,
          if (instance.releaseDate case final value?) 'release_date': value,
          if (instance.type case final value?) 'type': value,
        };
