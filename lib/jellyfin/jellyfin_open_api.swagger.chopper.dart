// dart format width=80
//Generated jellyfin api code

part of 'jellyfin_open_api.swagger.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$JellyfinOpenApi extends JellyfinOpenApi {
  _$JellyfinOpenApi([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = JellyfinOpenApi;

  @override
  Future<Response<ActivityLogEntryQueryResult>> _systemActivityLogEntriesGet({
    int? startIndex,
    int? limit,
    DateTime? minDate,
    bool? hasUserId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets activity log entries.',
      operationId: 'GetLogEntries',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["ActivityLog"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/System/ActivityLog/Entries');
    final Map<String, dynamic> $params = <String, dynamic>{
      'startIndex': startIndex,
      'limit': limit,
      'minDate': minDate,
      'hasUserId': hasUserId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client
        .send<ActivityLogEntryQueryResult, ActivityLogEntryQueryResult>(
          $request,
        );
  }

  @override
  Future<Response<AuthenticationInfoQueryResult>> _authKeysGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get all keys.',
      operationId: 'GetKeys',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["ApiKey"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Auth/Keys');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client
        .send<AuthenticationInfoQueryResult, AuthenticationInfoQueryResult>(
          $request,
        );
  }

  @override
  Future<Response<dynamic>> _authKeysPost({
    required String? app,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Create a new api key.',
      operationId: 'CreateKey',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["ApiKey"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Auth/Keys');
    final Map<String, dynamic> $params = <String, dynamic>{'app': app};
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _authKeysKeyDelete({
    required String? key,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Remove an api key.',
      operationId: 'RevokeKey',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["ApiKey"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Auth/Keys/${key}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _artistsGet({
    num? minCommunityRating,
    int? startIndex,
    int? limit,
    String? searchTerm,
    String? parentId,
    List<Object?>? fields,
    List<Object?>? excludeItemTypes,
    List<Object?>? includeItemTypes,
    List<Object?>? filters,
    bool? isFavorite,
    List<Object?>? mediaTypes,
    List<String>? genres,
    List<String>? genreIds,
    List<String>? officialRatings,
    List<String>? tags,
    List<int>? years,
    bool? enableUserData,
    int? imageTypeLimit,
    List<Object?>? enableImageTypes,
    String? person,
    List<String>? personIds,
    List<String>? personTypes,
    List<String>? studios,
    List<String>? studioIds,
    String? userId,
    String? nameStartsWithOrGreater,
    String? nameStartsWith,
    String? nameLessThan,
    List<Object?>? sortBy,
    List<Object?>? sortOrder,
    bool? enableImages,
    bool? enableTotalRecordCount,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary:
          'Gets all artists from a given item, folder, or the entire library.',
      operationId: 'GetArtists',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Artists"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Artists');
    final Map<String, dynamic> $params = <String, dynamic>{
      'minCommunityRating': minCommunityRating,
      'startIndex': startIndex,
      'limit': limit,
      'searchTerm': searchTerm,
      'parentId': parentId,
      'fields': fields,
      'excludeItemTypes': excludeItemTypes,
      'includeItemTypes': includeItemTypes,
      'filters': filters,
      'isFavorite': isFavorite,
      'mediaTypes': mediaTypes,
      'genres': genres,
      'genreIds': genreIds,
      'officialRatings': officialRatings,
      'tags': tags,
      'years': years,
      'enableUserData': enableUserData,
      'imageTypeLimit': imageTypeLimit,
      'enableImageTypes': enableImageTypes,
      'person': person,
      'personIds': personIds,
      'personTypes': personTypes,
      'studios': studios,
      'studioIds': studioIds,
      'userId': userId,
      'nameStartsWithOrGreater': nameStartsWithOrGreater,
      'nameStartsWith': nameStartsWith,
      'nameLessThan': nameLessThan,
      'sortBy': sortBy,
      'sortOrder': sortOrder,
      'enableImages': enableImages,
      'enableTotalRecordCount': enableTotalRecordCount,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<BaseItemDto>> _artistsNameGet({
    required String? name,
    String? userId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets an artist by name.',
      operationId: 'GetArtistByName',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Artists"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Artists/${name}');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDto, BaseItemDto>($request);
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _artistsAlbumArtistsGet({
    num? minCommunityRating,
    int? startIndex,
    int? limit,
    String? searchTerm,
    String? parentId,
    List<Object?>? fields,
    List<Object?>? excludeItemTypes,
    List<Object?>? includeItemTypes,
    List<Object?>? filters,
    bool? isFavorite,
    List<Object?>? mediaTypes,
    List<String>? genres,
    List<String>? genreIds,
    List<String>? officialRatings,
    List<String>? tags,
    List<int>? years,
    bool? enableUserData,
    int? imageTypeLimit,
    List<Object?>? enableImageTypes,
    String? person,
    List<String>? personIds,
    List<String>? personTypes,
    List<String>? studios,
    List<String>? studioIds,
    String? userId,
    String? nameStartsWithOrGreater,
    String? nameStartsWith,
    String? nameLessThan,
    List<Object?>? sortBy,
    List<Object?>? sortOrder,
    bool? enableImages,
    bool? enableTotalRecordCount,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary:
          'Gets all album artists from a given item, folder, or the entire library.',
      operationId: 'GetAlbumArtists',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Artists"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Artists/AlbumArtists');
    final Map<String, dynamic> $params = <String, dynamic>{
      'minCommunityRating': minCommunityRating,
      'startIndex': startIndex,
      'limit': limit,
      'searchTerm': searchTerm,
      'parentId': parentId,
      'fields': fields,
      'excludeItemTypes': excludeItemTypes,
      'includeItemTypes': includeItemTypes,
      'filters': filters,
      'isFavorite': isFavorite,
      'mediaTypes': mediaTypes,
      'genres': genres,
      'genreIds': genreIds,
      'officialRatings': officialRatings,
      'tags': tags,
      'years': years,
      'enableUserData': enableUserData,
      'imageTypeLimit': imageTypeLimit,
      'enableImageTypes': enableImageTypes,
      'person': person,
      'personIds': personIds,
      'personTypes': personTypes,
      'studios': studios,
      'studioIds': studioIds,
      'userId': userId,
      'nameStartsWithOrGreater': nameStartsWithOrGreater,
      'nameStartsWith': nameStartsWith,
      'nameLessThan': nameLessThan,
      'sortBy': sortBy,
      'sortOrder': sortOrder,
      'enableImages': enableImages,
      'enableTotalRecordCount': enableTotalRecordCount,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<String>> _audioItemIdStreamGet({
    required String? itemId,
    String? container,
    bool? $static,
    String? params,
    String? tag,
    String? deviceProfileId,
    String? playSessionId,
    String? segmentContainer,
    int? segmentLength,
    int? minSegments,
    String? mediaSourceId,
    String? deviceId,
    String? audioCodec,
    bool? enableAutoStreamCopy,
    bool? allowVideoStreamCopy,
    bool? allowAudioStreamCopy,
    bool? breakOnNonKeyFrames,
    int? audioSampleRate,
    int? maxAudioBitDepth,
    int? audioBitRate,
    int? audioChannels,
    int? maxAudioChannels,
    String? profile,
    String? level,
    num? framerate,
    num? maxFramerate,
    bool? copyTimestamps,
    int? startTimeTicks,
    int? width,
    int? height,
    int? videoBitRate,
    int? subtitleStreamIndex,
    String? subtitleMethod,
    int? maxRefFrames,
    int? maxVideoBitDepth,
    bool? requireAvc,
    bool? deInterlace,
    bool? requireNonAnamorphic,
    int? transcodingMaxAudioChannels,
    int? cpuCoreLimit,
    String? liveStreamId,
    bool? enableMpegtsM2TsMode,
    String? videoCodec,
    String? subtitleCodec,
    String? transcodeReasons,
    int? audioStreamIndex,
    int? videoStreamIndex,
    String? context,
    Object? streamOptions,
    bool? enableAudioVbrEncoding,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets an audio stream.',
      operationId: 'GetAudioStream',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Audio"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Audio/${itemId}/stream');
    final Map<String, dynamic> $params = <String, dynamic>{
      'container': container,
      'static': $static,
      'params': params,
      'tag': tag,
      'deviceProfileId': deviceProfileId,
      'playSessionId': playSessionId,
      'segmentContainer': segmentContainer,
      'segmentLength': segmentLength,
      'minSegments': minSegments,
      'mediaSourceId': mediaSourceId,
      'deviceId': deviceId,
      'audioCodec': audioCodec,
      'enableAutoStreamCopy': enableAutoStreamCopy,
      'allowVideoStreamCopy': allowVideoStreamCopy,
      'allowAudioStreamCopy': allowAudioStreamCopy,
      'breakOnNonKeyFrames': breakOnNonKeyFrames,
      'audioSampleRate': audioSampleRate,
      'maxAudioBitDepth': maxAudioBitDepth,
      'audioBitRate': audioBitRate,
      'audioChannels': audioChannels,
      'maxAudioChannels': maxAudioChannels,
      'profile': profile,
      'level': level,
      'framerate': framerate,
      'maxFramerate': maxFramerate,
      'copyTimestamps': copyTimestamps,
      'startTimeTicks': startTimeTicks,
      'width': width,
      'height': height,
      'videoBitRate': videoBitRate,
      'subtitleStreamIndex': subtitleStreamIndex,
      'subtitleMethod': subtitleMethod,
      'maxRefFrames': maxRefFrames,
      'maxVideoBitDepth': maxVideoBitDepth,
      'requireAvc': requireAvc,
      'deInterlace': deInterlace,
      'requireNonAnamorphic': requireNonAnamorphic,
      'transcodingMaxAudioChannels': transcodingMaxAudioChannels,
      'cpuCoreLimit': cpuCoreLimit,
      'liveStreamId': liveStreamId,
      'enableMpegtsM2TsMode': enableMpegtsM2TsMode,
      'videoCodec': videoCodec,
      'subtitleCodec': subtitleCodec,
      'transcodeReasons': transcodeReasons,
      'audioStreamIndex': audioStreamIndex,
      'videoStreamIndex': videoStreamIndex,
      'context': context,
      'streamOptions': streamOptions,
      'enableAudioVbrEncoding': enableAudioVbrEncoding,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _audioItemIdStreamHead({
    required String? itemId,
    String? container,
    bool? $static,
    String? params,
    String? tag,
    String? deviceProfileId,
    String? playSessionId,
    String? segmentContainer,
    int? segmentLength,
    int? minSegments,
    String? mediaSourceId,
    String? deviceId,
    String? audioCodec,
    bool? enableAutoStreamCopy,
    bool? allowVideoStreamCopy,
    bool? allowAudioStreamCopy,
    bool? breakOnNonKeyFrames,
    int? audioSampleRate,
    int? maxAudioBitDepth,
    int? audioBitRate,
    int? audioChannels,
    int? maxAudioChannels,
    String? profile,
    String? level,
    num? framerate,
    num? maxFramerate,
    bool? copyTimestamps,
    int? startTimeTicks,
    int? width,
    int? height,
    int? videoBitRate,
    int? subtitleStreamIndex,
    String? subtitleMethod,
    int? maxRefFrames,
    int? maxVideoBitDepth,
    bool? requireAvc,
    bool? deInterlace,
    bool? requireNonAnamorphic,
    int? transcodingMaxAudioChannels,
    int? cpuCoreLimit,
    String? liveStreamId,
    bool? enableMpegtsM2TsMode,
    String? videoCodec,
    String? subtitleCodec,
    String? transcodeReasons,
    int? audioStreamIndex,
    int? videoStreamIndex,
    String? context,
    Object? streamOptions,
    bool? enableAudioVbrEncoding,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets an audio stream.',
      operationId: 'HeadAudioStream',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Audio"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Audio/${itemId}/stream');
    final Map<String, dynamic> $params = <String, dynamic>{
      'container': container,
      'static': $static,
      'params': params,
      'tag': tag,
      'deviceProfileId': deviceProfileId,
      'playSessionId': playSessionId,
      'segmentContainer': segmentContainer,
      'segmentLength': segmentLength,
      'minSegments': minSegments,
      'mediaSourceId': mediaSourceId,
      'deviceId': deviceId,
      'audioCodec': audioCodec,
      'enableAutoStreamCopy': enableAutoStreamCopy,
      'allowVideoStreamCopy': allowVideoStreamCopy,
      'allowAudioStreamCopy': allowAudioStreamCopy,
      'breakOnNonKeyFrames': breakOnNonKeyFrames,
      'audioSampleRate': audioSampleRate,
      'maxAudioBitDepth': maxAudioBitDepth,
      'audioBitRate': audioBitRate,
      'audioChannels': audioChannels,
      'maxAudioChannels': maxAudioChannels,
      'profile': profile,
      'level': level,
      'framerate': framerate,
      'maxFramerate': maxFramerate,
      'copyTimestamps': copyTimestamps,
      'startTimeTicks': startTimeTicks,
      'width': width,
      'height': height,
      'videoBitRate': videoBitRate,
      'subtitleStreamIndex': subtitleStreamIndex,
      'subtitleMethod': subtitleMethod,
      'maxRefFrames': maxRefFrames,
      'maxVideoBitDepth': maxVideoBitDepth,
      'requireAvc': requireAvc,
      'deInterlace': deInterlace,
      'requireNonAnamorphic': requireNonAnamorphic,
      'transcodingMaxAudioChannels': transcodingMaxAudioChannels,
      'cpuCoreLimit': cpuCoreLimit,
      'liveStreamId': liveStreamId,
      'enableMpegtsM2TsMode': enableMpegtsM2TsMode,
      'videoCodec': videoCodec,
      'subtitleCodec': subtitleCodec,
      'transcodeReasons': transcodeReasons,
      'audioStreamIndex': audioStreamIndex,
      'videoStreamIndex': videoStreamIndex,
      'context': context,
      'streamOptions': streamOptions,
      'enableAudioVbrEncoding': enableAudioVbrEncoding,
    };
    final Request $request = Request(
      'HEAD',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _audioItemIdStreamContainerGet({
    required String? itemId,
    required String? container,
    bool? $static,
    String? params,
    String? tag,
    String? deviceProfileId,
    String? playSessionId,
    String? segmentContainer,
    int? segmentLength,
    int? minSegments,
    String? mediaSourceId,
    String? deviceId,
    String? audioCodec,
    bool? enableAutoStreamCopy,
    bool? allowVideoStreamCopy,
    bool? allowAudioStreamCopy,
    bool? breakOnNonKeyFrames,
    int? audioSampleRate,
    int? maxAudioBitDepth,
    int? audioBitRate,
    int? audioChannels,
    int? maxAudioChannels,
    String? profile,
    String? level,
    num? framerate,
    num? maxFramerate,
    bool? copyTimestamps,
    int? startTimeTicks,
    int? width,
    int? height,
    int? videoBitRate,
    int? subtitleStreamIndex,
    String? subtitleMethod,
    int? maxRefFrames,
    int? maxVideoBitDepth,
    bool? requireAvc,
    bool? deInterlace,
    bool? requireNonAnamorphic,
    int? transcodingMaxAudioChannels,
    int? cpuCoreLimit,
    String? liveStreamId,
    bool? enableMpegtsM2TsMode,
    String? videoCodec,
    String? subtitleCodec,
    String? transcodeReasons,
    int? audioStreamIndex,
    int? videoStreamIndex,
    String? context,
    Object? streamOptions,
    bool? enableAudioVbrEncoding,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets an audio stream.',
      operationId: 'GetAudioStreamByContainer',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Audio"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Audio/${itemId}/stream.${container}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'static': $static,
      'params': params,
      'tag': tag,
      'deviceProfileId': deviceProfileId,
      'playSessionId': playSessionId,
      'segmentContainer': segmentContainer,
      'segmentLength': segmentLength,
      'minSegments': minSegments,
      'mediaSourceId': mediaSourceId,
      'deviceId': deviceId,
      'audioCodec': audioCodec,
      'enableAutoStreamCopy': enableAutoStreamCopy,
      'allowVideoStreamCopy': allowVideoStreamCopy,
      'allowAudioStreamCopy': allowAudioStreamCopy,
      'breakOnNonKeyFrames': breakOnNonKeyFrames,
      'audioSampleRate': audioSampleRate,
      'maxAudioBitDepth': maxAudioBitDepth,
      'audioBitRate': audioBitRate,
      'audioChannels': audioChannels,
      'maxAudioChannels': maxAudioChannels,
      'profile': profile,
      'level': level,
      'framerate': framerate,
      'maxFramerate': maxFramerate,
      'copyTimestamps': copyTimestamps,
      'startTimeTicks': startTimeTicks,
      'width': width,
      'height': height,
      'videoBitRate': videoBitRate,
      'subtitleStreamIndex': subtitleStreamIndex,
      'subtitleMethod': subtitleMethod,
      'maxRefFrames': maxRefFrames,
      'maxVideoBitDepth': maxVideoBitDepth,
      'requireAvc': requireAvc,
      'deInterlace': deInterlace,
      'requireNonAnamorphic': requireNonAnamorphic,
      'transcodingMaxAudioChannels': transcodingMaxAudioChannels,
      'cpuCoreLimit': cpuCoreLimit,
      'liveStreamId': liveStreamId,
      'enableMpegtsM2TsMode': enableMpegtsM2TsMode,
      'videoCodec': videoCodec,
      'subtitleCodec': subtitleCodec,
      'transcodeReasons': transcodeReasons,
      'audioStreamIndex': audioStreamIndex,
      'videoStreamIndex': videoStreamIndex,
      'context': context,
      'streamOptions': streamOptions,
      'enableAudioVbrEncoding': enableAudioVbrEncoding,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _audioItemIdStreamContainerHead({
    required String? itemId,
    required String? container,
    bool? $static,
    String? params,
    String? tag,
    String? deviceProfileId,
    String? playSessionId,
    String? segmentContainer,
    int? segmentLength,
    int? minSegments,
    String? mediaSourceId,
    String? deviceId,
    String? audioCodec,
    bool? enableAutoStreamCopy,
    bool? allowVideoStreamCopy,
    bool? allowAudioStreamCopy,
    bool? breakOnNonKeyFrames,
    int? audioSampleRate,
    int? maxAudioBitDepth,
    int? audioBitRate,
    int? audioChannels,
    int? maxAudioChannels,
    String? profile,
    String? level,
    num? framerate,
    num? maxFramerate,
    bool? copyTimestamps,
    int? startTimeTicks,
    int? width,
    int? height,
    int? videoBitRate,
    int? subtitleStreamIndex,
    String? subtitleMethod,
    int? maxRefFrames,
    int? maxVideoBitDepth,
    bool? requireAvc,
    bool? deInterlace,
    bool? requireNonAnamorphic,
    int? transcodingMaxAudioChannels,
    int? cpuCoreLimit,
    String? liveStreamId,
    bool? enableMpegtsM2TsMode,
    String? videoCodec,
    String? subtitleCodec,
    String? transcodeReasons,
    int? audioStreamIndex,
    int? videoStreamIndex,
    String? context,
    Object? streamOptions,
    bool? enableAudioVbrEncoding,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets an audio stream.',
      operationId: 'HeadAudioStreamByContainer',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Audio"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Audio/${itemId}/stream.${container}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'static': $static,
      'params': params,
      'tag': tag,
      'deviceProfileId': deviceProfileId,
      'playSessionId': playSessionId,
      'segmentContainer': segmentContainer,
      'segmentLength': segmentLength,
      'minSegments': minSegments,
      'mediaSourceId': mediaSourceId,
      'deviceId': deviceId,
      'audioCodec': audioCodec,
      'enableAutoStreamCopy': enableAutoStreamCopy,
      'allowVideoStreamCopy': allowVideoStreamCopy,
      'allowAudioStreamCopy': allowAudioStreamCopy,
      'breakOnNonKeyFrames': breakOnNonKeyFrames,
      'audioSampleRate': audioSampleRate,
      'maxAudioBitDepth': maxAudioBitDepth,
      'audioBitRate': audioBitRate,
      'audioChannels': audioChannels,
      'maxAudioChannels': maxAudioChannels,
      'profile': profile,
      'level': level,
      'framerate': framerate,
      'maxFramerate': maxFramerate,
      'copyTimestamps': copyTimestamps,
      'startTimeTicks': startTimeTicks,
      'width': width,
      'height': height,
      'videoBitRate': videoBitRate,
      'subtitleStreamIndex': subtitleStreamIndex,
      'subtitleMethod': subtitleMethod,
      'maxRefFrames': maxRefFrames,
      'maxVideoBitDepth': maxVideoBitDepth,
      'requireAvc': requireAvc,
      'deInterlace': deInterlace,
      'requireNonAnamorphic': requireNonAnamorphic,
      'transcodingMaxAudioChannels': transcodingMaxAudioChannels,
      'cpuCoreLimit': cpuCoreLimit,
      'liveStreamId': liveStreamId,
      'enableMpegtsM2TsMode': enableMpegtsM2TsMode,
      'videoCodec': videoCodec,
      'subtitleCodec': subtitleCodec,
      'transcodeReasons': transcodeReasons,
      'audioStreamIndex': audioStreamIndex,
      'videoStreamIndex': videoStreamIndex,
      'context': context,
      'streamOptions': streamOptions,
      'enableAudioVbrEncoding': enableAudioVbrEncoding,
    };
    final Request $request = Request(
      'HEAD',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<List<BackupManifestDto>>> _backupGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary:
          'Gets a list of all currently present backups in the backup directory.',
      operationId: 'ListBackups',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Backup"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Backup');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<BackupManifestDto>, BackupManifestDto>($request);
  }

  @override
  Future<Response<BackupManifestDto>> _backupCreatePost({
    required BackupOptionsDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Creates a new Backup.',
      operationId: 'CreateBackup',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Backup"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Backup/Create');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<BackupManifestDto, BackupManifestDto>($request);
  }

  @override
  Future<Response<BackupManifestDto>> _backupManifestGet({
    required String? path,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets the descriptor from an existing archive is present.',
      operationId: 'GetBackup',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Backup"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Backup/Manifest');
    final Map<String, dynamic> $params = <String, dynamic>{'path': path};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BackupManifestDto, BackupManifestDto>($request);
  }

  @override
  Future<Response<dynamic>> _backupRestorePost({
    required BackupRestoreRequestDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary:
          'Restores to a backup by restarting the server and applying the backup.',
      operationId: 'StartRestoreBackup',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Backup"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Backup/Restore');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<BrandingOptionsDto>> _brandingConfigurationGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets branding configuration.',
      operationId: 'GetBrandingOptions',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Branding"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Branding/Configuration');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<BrandingOptionsDto, BrandingOptionsDto>($request);
  }

  @override
  Future<Response<String>> _brandingCssGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets branding css.',
      operationId: 'GetBrandingCss',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Branding"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Branding/Css');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _brandingCssCssGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets branding css.',
      operationId: 'GetBrandingCss_2',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Branding"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Branding/Css.css');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _channelsGet({
    String? userId,
    int? startIndex,
    int? limit,
    bool? supportsLatestItems,
    bool? supportsMediaDeletion,
    bool? isFavorite,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets available channels.',
      operationId: 'GetChannels',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Channels"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Channels');
    final Map<String, dynamic> $params = <String, dynamic>{
      'userId': userId,
      'startIndex': startIndex,
      'limit': limit,
      'supportsLatestItems': supportsLatestItems,
      'supportsMediaDeletion': supportsMediaDeletion,
      'isFavorite': isFavorite,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<ChannelFeatures>> _channelsChannelIdFeaturesGet({
    required String? channelId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get channel features.',
      operationId: 'GetChannelFeatures',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Channels"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Channels/${channelId}/Features');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<ChannelFeatures, ChannelFeatures>($request);
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _channelsChannelIdItemsGet({
    required String? channelId,
    String? folderId,
    String? userId,
    int? startIndex,
    int? limit,
    List<Object?>? sortOrder,
    List<Object?>? filters,
    List<Object?>? sortBy,
    List<Object?>? fields,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get channel items.',
      operationId: 'GetChannelItems',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Channels"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Channels/${channelId}/Items');
    final Map<String, dynamic> $params = <String, dynamic>{
      'folderId': folderId,
      'userId': userId,
      'startIndex': startIndex,
      'limit': limit,
      'sortOrder': sortOrder,
      'filters': filters,
      'sortBy': sortBy,
      'fields': fields,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<List<ChannelFeatures>>> _channelsFeaturesGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get all channel features.',
      operationId: 'GetAllChannelFeatures',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Channels"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Channels/Features');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<ChannelFeatures>, ChannelFeatures>($request);
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _channelsItemsLatestGet({
    String? userId,
    int? startIndex,
    int? limit,
    List<Object?>? filters,
    List<Object?>? fields,
    List<String>? channelIds,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets latest channel items.',
      operationId: 'GetLatestChannelItems',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Channels"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Channels/Items/Latest');
    final Map<String, dynamic> $params = <String, dynamic>{
      'userId': userId,
      'startIndex': startIndex,
      'limit': limit,
      'filters': filters,
      'fields': fields,
      'channelIds': channelIds,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<ClientLogDocumentResponseDto>> _clientLogDocumentPost({
    required Object? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Upload a document.',
      operationId: 'LogFile',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["ClientLog"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/ClientLog/Document');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client
        .send<ClientLogDocumentResponseDto, ClientLogDocumentResponseDto>(
          $request,
        );
  }

  @override
  Future<Response<CollectionCreationResult>> _collectionsPost({
    String? name,
    List<String>? ids,
    String? parentId,
    bool? isLocked,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Creates a new collection.',
      operationId: 'CreateCollection',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Collection"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Collections');
    final Map<String, dynamic> $params = <String, dynamic>{
      'name': name,
      'ids': ids,
      'parentId': parentId,
      'isLocked': isLocked,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<CollectionCreationResult, CollectionCreationResult>(
      $request,
    );
  }

  @override
  Future<Response<dynamic>> _collectionsCollectionIdItemsPost({
    required String? collectionId,
    required List<String>? ids,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Adds items to a collection.',
      operationId: 'AddToCollection',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Collection"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Collections/${collectionId}/Items');
    final Map<String, dynamic> $params = <String, dynamic>{'ids': ids};
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _collectionsCollectionIdItemsDelete({
    required String? collectionId,
    required List<String>? ids,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Removes items from a collection.',
      operationId: 'RemoveFromCollection',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Collection"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Collections/${collectionId}/Items');
    final Map<String, dynamic> $params = <String, dynamic>{'ids': ids};
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<ServerConfiguration>> _systemConfigurationGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets application configuration.',
      operationId: 'GetConfiguration',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Configuration"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/System/Configuration');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<ServerConfiguration, ServerConfiguration>($request);
  }

  @override
  Future<Response<dynamic>> _systemConfigurationPost({
    required ServerConfiguration? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Updates application configuration.',
      operationId: 'UpdateConfiguration',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Configuration"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/System/Configuration');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<String>> _systemConfigurationKeyGet({
    required String? key,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets a named configuration.',
      operationId: 'GetNamedConfiguration',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Configuration"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/System/Configuration/${key}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<dynamic>> _systemConfigurationKeyPost({
    required String? key,
    required Object? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Updates named configuration.',
      operationId: 'UpdateNamedConfiguration',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Configuration"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/System/Configuration/${key}');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _systemConfigurationBrandingPost({
    required BrandingOptionsDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Updates branding configuration.',
      operationId: 'UpdateBrandingConfiguration',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Configuration"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/System/Configuration/Branding');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<MetadataOptions>>
  _systemConfigurationMetadataOptionsDefaultGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets a default MetadataOptions object.',
      operationId: 'GetDefaultMetadataOptions',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Configuration"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/System/Configuration/MetadataOptions/Default');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<MetadataOptions, MetadataOptions>($request);
  }

  @override
  Future<Response<String>> _webConfigurationPageGet({
    String? name,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets a dashboard configuration page.',
      operationId: 'GetDashboardConfigurationPage',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Dashboard"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/web/ConfigurationPage');
    final Map<String, dynamic> $params = <String, dynamic>{'name': name};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<List<ConfigurationPageInfo>>> _webConfigurationPagesGet({
    bool? enableInMainMenu,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets the configuration pages.',
      operationId: 'GetConfigurationPages',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Dashboard"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/web/ConfigurationPages');
    final Map<String, dynamic> $params = <String, dynamic>{
      'enableInMainMenu': enableInMainMenu,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<List<ConfigurationPageInfo>, ConfigurationPageInfo>(
      $request,
    );
  }

  @override
  Future<Response<DeviceInfoDtoQueryResult>> _devicesGet({
    String? userId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get Devices.',
      operationId: 'GetDevices',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Devices"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Devices');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<DeviceInfoDtoQueryResult, DeviceInfoDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<dynamic>> _devicesDelete({
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Deletes a device.',
      operationId: 'DeleteDevice',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Devices"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Devices');
    final Map<String, dynamic> $params = <String, dynamic>{'id': id};
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<DeviceInfoDto>> _devicesInfoGet({
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get info for a device.',
      operationId: 'GetDeviceInfo',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Devices"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Devices/Info');
    final Map<String, dynamic> $params = <String, dynamic>{'id': id};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<DeviceInfoDto, DeviceInfoDto>($request);
  }

  @override
  Future<Response<DeviceOptionsDto>> _devicesOptionsGet({
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get options for a device.',
      operationId: 'GetDeviceOptions',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Devices"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Devices/Options');
    final Map<String, dynamic> $params = <String, dynamic>{'id': id};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<DeviceOptionsDto, DeviceOptionsDto>($request);
  }

  @override
  Future<Response<dynamic>> _devicesOptionsPost({
    required String? id,
    required DeviceOptionsDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Update device options.',
      operationId: 'UpdateDeviceOptions',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Devices"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Devices/Options');
    final Map<String, dynamic> $params = <String, dynamic>{'id': id};
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<DisplayPreferencesDto>>
  _displayPreferencesDisplayPreferencesIdGet({
    required String? displayPreferencesId,
    String? userId,
    required String? $client,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get Display Preferences.',
      operationId: 'GetDisplayPreferences',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["DisplayPreferences"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/DisplayPreferences/${displayPreferencesId}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'userId': userId,
      'client': $client,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<DisplayPreferencesDto, DisplayPreferencesDto>($request);
  }

  @override
  Future<Response<dynamic>> _displayPreferencesDisplayPreferencesIdPost({
    required String? displayPreferencesId,
    String? userId,
    required String? $client,
    required DisplayPreferencesDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Update Display Preferences.',
      operationId: 'UpdateDisplayPreferences',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["DisplayPreferences"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/DisplayPreferences/${displayPreferencesId}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'userId': userId,
      'client': $client,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<String>> _audioItemIdHls1PlaylistIdSegmentIdContainerGet({
    required String? itemId,
    required String? playlistId,
    required int? segmentId,
    required String? container,
    required int? runtimeTicks,
    required int? actualSegmentLengthTicks,
    bool? $static,
    String? params,
    String? tag,
    String? deviceProfileId,
    String? playSessionId,
    String? segmentContainer,
    int? segmentLength,
    int? minSegments,
    String? mediaSourceId,
    String? deviceId,
    String? audioCodec,
    bool? enableAutoStreamCopy,
    bool? allowVideoStreamCopy,
    bool? allowAudioStreamCopy,
    bool? breakOnNonKeyFrames,
    int? audioSampleRate,
    int? maxAudioBitDepth,
    int? maxStreamingBitrate,
    int? audioBitRate,
    int? audioChannels,
    int? maxAudioChannels,
    String? profile,
    String? level,
    num? framerate,
    num? maxFramerate,
    bool? copyTimestamps,
    int? startTimeTicks,
    int? width,
    int? height,
    int? videoBitRate,
    int? subtitleStreamIndex,
    String? subtitleMethod,
    int? maxRefFrames,
    int? maxVideoBitDepth,
    bool? requireAvc,
    bool? deInterlace,
    bool? requireNonAnamorphic,
    int? transcodingMaxAudioChannels,
    int? cpuCoreLimit,
    String? liveStreamId,
    bool? enableMpegtsM2TsMode,
    String? videoCodec,
    String? subtitleCodec,
    String? transcodeReasons,
    int? audioStreamIndex,
    int? videoStreamIndex,
    String? context,
    Object? streamOptions,
    bool? enableAudioVbrEncoding,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets a video stream using HTTP live streaming.',
      operationId: 'GetHlsAudioSegment',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["DynamicHls"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse(
      '/Audio/${itemId}/hls1/${playlistId}/${segmentId}.${container}',
    );
    final Map<String, dynamic> $params = <String, dynamic>{
      'runtimeTicks': runtimeTicks,
      'actualSegmentLengthTicks': actualSegmentLengthTicks,
      'static': $static,
      'params': params,
      'tag': tag,
      'deviceProfileId': deviceProfileId,
      'playSessionId': playSessionId,
      'segmentContainer': segmentContainer,
      'segmentLength': segmentLength,
      'minSegments': minSegments,
      'mediaSourceId': mediaSourceId,
      'deviceId': deviceId,
      'audioCodec': audioCodec,
      'enableAutoStreamCopy': enableAutoStreamCopy,
      'allowVideoStreamCopy': allowVideoStreamCopy,
      'allowAudioStreamCopy': allowAudioStreamCopy,
      'breakOnNonKeyFrames': breakOnNonKeyFrames,
      'audioSampleRate': audioSampleRate,
      'maxAudioBitDepth': maxAudioBitDepth,
      'maxStreamingBitrate': maxStreamingBitrate,
      'audioBitRate': audioBitRate,
      'audioChannels': audioChannels,
      'maxAudioChannels': maxAudioChannels,
      'profile': profile,
      'level': level,
      'framerate': framerate,
      'maxFramerate': maxFramerate,
      'copyTimestamps': copyTimestamps,
      'startTimeTicks': startTimeTicks,
      'width': width,
      'height': height,
      'videoBitRate': videoBitRate,
      'subtitleStreamIndex': subtitleStreamIndex,
      'subtitleMethod': subtitleMethod,
      'maxRefFrames': maxRefFrames,
      'maxVideoBitDepth': maxVideoBitDepth,
      'requireAvc': requireAvc,
      'deInterlace': deInterlace,
      'requireNonAnamorphic': requireNonAnamorphic,
      'transcodingMaxAudioChannels': transcodingMaxAudioChannels,
      'cpuCoreLimit': cpuCoreLimit,
      'liveStreamId': liveStreamId,
      'enableMpegtsM2TsMode': enableMpegtsM2TsMode,
      'videoCodec': videoCodec,
      'subtitleCodec': subtitleCodec,
      'transcodeReasons': transcodeReasons,
      'audioStreamIndex': audioStreamIndex,
      'videoStreamIndex': videoStreamIndex,
      'context': context,
      'streamOptions': streamOptions,
      'enableAudioVbrEncoding': enableAudioVbrEncoding,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _audioItemIdMainM3u8Get({
    required String? itemId,
    bool? $static,
    String? params,
    String? tag,
    String? deviceProfileId,
    String? playSessionId,
    String? segmentContainer,
    int? segmentLength,
    int? minSegments,
    String? mediaSourceId,
    String? deviceId,
    String? audioCodec,
    bool? enableAutoStreamCopy,
    bool? allowVideoStreamCopy,
    bool? allowAudioStreamCopy,
    bool? breakOnNonKeyFrames,
    int? audioSampleRate,
    int? maxAudioBitDepth,
    int? maxStreamingBitrate,
    int? audioBitRate,
    int? audioChannels,
    int? maxAudioChannels,
    String? profile,
    String? level,
    num? framerate,
    num? maxFramerate,
    bool? copyTimestamps,
    int? startTimeTicks,
    int? width,
    int? height,
    int? videoBitRate,
    int? subtitleStreamIndex,
    String? subtitleMethod,
    int? maxRefFrames,
    int? maxVideoBitDepth,
    bool? requireAvc,
    bool? deInterlace,
    bool? requireNonAnamorphic,
    int? transcodingMaxAudioChannels,
    int? cpuCoreLimit,
    String? liveStreamId,
    bool? enableMpegtsM2TsMode,
    String? videoCodec,
    String? subtitleCodec,
    String? transcodeReasons,
    int? audioStreamIndex,
    int? videoStreamIndex,
    String? context,
    Object? streamOptions,
    bool? enableAudioVbrEncoding,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets an audio stream using HTTP live streaming.',
      operationId: 'GetVariantHlsAudioPlaylist',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["DynamicHls"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Audio/${itemId}/main.m3u8');
    final Map<String, dynamic> $params = <String, dynamic>{
      'static': $static,
      'params': params,
      'tag': tag,
      'deviceProfileId': deviceProfileId,
      'playSessionId': playSessionId,
      'segmentContainer': segmentContainer,
      'segmentLength': segmentLength,
      'minSegments': minSegments,
      'mediaSourceId': mediaSourceId,
      'deviceId': deviceId,
      'audioCodec': audioCodec,
      'enableAutoStreamCopy': enableAutoStreamCopy,
      'allowVideoStreamCopy': allowVideoStreamCopy,
      'allowAudioStreamCopy': allowAudioStreamCopy,
      'breakOnNonKeyFrames': breakOnNonKeyFrames,
      'audioSampleRate': audioSampleRate,
      'maxAudioBitDepth': maxAudioBitDepth,
      'maxStreamingBitrate': maxStreamingBitrate,
      'audioBitRate': audioBitRate,
      'audioChannels': audioChannels,
      'maxAudioChannels': maxAudioChannels,
      'profile': profile,
      'level': level,
      'framerate': framerate,
      'maxFramerate': maxFramerate,
      'copyTimestamps': copyTimestamps,
      'startTimeTicks': startTimeTicks,
      'width': width,
      'height': height,
      'videoBitRate': videoBitRate,
      'subtitleStreamIndex': subtitleStreamIndex,
      'subtitleMethod': subtitleMethod,
      'maxRefFrames': maxRefFrames,
      'maxVideoBitDepth': maxVideoBitDepth,
      'requireAvc': requireAvc,
      'deInterlace': deInterlace,
      'requireNonAnamorphic': requireNonAnamorphic,
      'transcodingMaxAudioChannels': transcodingMaxAudioChannels,
      'cpuCoreLimit': cpuCoreLimit,
      'liveStreamId': liveStreamId,
      'enableMpegtsM2TsMode': enableMpegtsM2TsMode,
      'videoCodec': videoCodec,
      'subtitleCodec': subtitleCodec,
      'transcodeReasons': transcodeReasons,
      'audioStreamIndex': audioStreamIndex,
      'videoStreamIndex': videoStreamIndex,
      'context': context,
      'streamOptions': streamOptions,
      'enableAudioVbrEncoding': enableAudioVbrEncoding,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _audioItemIdMasterM3u8Get({
    required String? itemId,
    bool? $static,
    String? params,
    String? tag,
    String? deviceProfileId,
    String? playSessionId,
    String? segmentContainer,
    int? segmentLength,
    int? minSegments,
    required String? mediaSourceId,
    String? deviceId,
    String? audioCodec,
    bool? enableAutoStreamCopy,
    bool? allowVideoStreamCopy,
    bool? allowAudioStreamCopy,
    bool? breakOnNonKeyFrames,
    int? audioSampleRate,
    int? maxAudioBitDepth,
    int? maxStreamingBitrate,
    int? audioBitRate,
    int? audioChannels,
    int? maxAudioChannels,
    String? profile,
    String? level,
    num? framerate,
    num? maxFramerate,
    bool? copyTimestamps,
    int? startTimeTicks,
    int? width,
    int? height,
    int? videoBitRate,
    int? subtitleStreamIndex,
    String? subtitleMethod,
    int? maxRefFrames,
    int? maxVideoBitDepth,
    bool? requireAvc,
    bool? deInterlace,
    bool? requireNonAnamorphic,
    int? transcodingMaxAudioChannels,
    int? cpuCoreLimit,
    String? liveStreamId,
    bool? enableMpegtsM2TsMode,
    String? videoCodec,
    String? subtitleCodec,
    String? transcodeReasons,
    int? audioStreamIndex,
    int? videoStreamIndex,
    String? context,
    Object? streamOptions,
    bool? enableAdaptiveBitrateStreaming,
    bool? enableAudioVbrEncoding,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets an audio hls playlist stream.',
      operationId: 'GetMasterHlsAudioPlaylist',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["DynamicHls"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Audio/${itemId}/master.m3u8');
    final Map<String, dynamic> $params = <String, dynamic>{
      'static': $static,
      'params': params,
      'tag': tag,
      'deviceProfileId': deviceProfileId,
      'playSessionId': playSessionId,
      'segmentContainer': segmentContainer,
      'segmentLength': segmentLength,
      'minSegments': minSegments,
      'mediaSourceId': mediaSourceId,
      'deviceId': deviceId,
      'audioCodec': audioCodec,
      'enableAutoStreamCopy': enableAutoStreamCopy,
      'allowVideoStreamCopy': allowVideoStreamCopy,
      'allowAudioStreamCopy': allowAudioStreamCopy,
      'breakOnNonKeyFrames': breakOnNonKeyFrames,
      'audioSampleRate': audioSampleRate,
      'maxAudioBitDepth': maxAudioBitDepth,
      'maxStreamingBitrate': maxStreamingBitrate,
      'audioBitRate': audioBitRate,
      'audioChannels': audioChannels,
      'maxAudioChannels': maxAudioChannels,
      'profile': profile,
      'level': level,
      'framerate': framerate,
      'maxFramerate': maxFramerate,
      'copyTimestamps': copyTimestamps,
      'startTimeTicks': startTimeTicks,
      'width': width,
      'height': height,
      'videoBitRate': videoBitRate,
      'subtitleStreamIndex': subtitleStreamIndex,
      'subtitleMethod': subtitleMethod,
      'maxRefFrames': maxRefFrames,
      'maxVideoBitDepth': maxVideoBitDepth,
      'requireAvc': requireAvc,
      'deInterlace': deInterlace,
      'requireNonAnamorphic': requireNonAnamorphic,
      'transcodingMaxAudioChannels': transcodingMaxAudioChannels,
      'cpuCoreLimit': cpuCoreLimit,
      'liveStreamId': liveStreamId,
      'enableMpegtsM2TsMode': enableMpegtsM2TsMode,
      'videoCodec': videoCodec,
      'subtitleCodec': subtitleCodec,
      'transcodeReasons': transcodeReasons,
      'audioStreamIndex': audioStreamIndex,
      'videoStreamIndex': videoStreamIndex,
      'context': context,
      'streamOptions': streamOptions,
      'enableAdaptiveBitrateStreaming': enableAdaptiveBitrateStreaming,
      'enableAudioVbrEncoding': enableAudioVbrEncoding,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _audioItemIdMasterM3u8Head({
    required String? itemId,
    bool? $static,
    String? params,
    String? tag,
    String? deviceProfileId,
    String? playSessionId,
    String? segmentContainer,
    int? segmentLength,
    int? minSegments,
    required String? mediaSourceId,
    String? deviceId,
    String? audioCodec,
    bool? enableAutoStreamCopy,
    bool? allowVideoStreamCopy,
    bool? allowAudioStreamCopy,
    bool? breakOnNonKeyFrames,
    int? audioSampleRate,
    int? maxAudioBitDepth,
    int? maxStreamingBitrate,
    int? audioBitRate,
    int? audioChannels,
    int? maxAudioChannels,
    String? profile,
    String? level,
    num? framerate,
    num? maxFramerate,
    bool? copyTimestamps,
    int? startTimeTicks,
    int? width,
    int? height,
    int? videoBitRate,
    int? subtitleStreamIndex,
    String? subtitleMethod,
    int? maxRefFrames,
    int? maxVideoBitDepth,
    bool? requireAvc,
    bool? deInterlace,
    bool? requireNonAnamorphic,
    int? transcodingMaxAudioChannels,
    int? cpuCoreLimit,
    String? liveStreamId,
    bool? enableMpegtsM2TsMode,
    String? videoCodec,
    String? subtitleCodec,
    String? transcodeReasons,
    int? audioStreamIndex,
    int? videoStreamIndex,
    String? context,
    Object? streamOptions,
    bool? enableAdaptiveBitrateStreaming,
    bool? enableAudioVbrEncoding,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets an audio hls playlist stream.',
      operationId: 'HeadMasterHlsAudioPlaylist',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["DynamicHls"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Audio/${itemId}/master.m3u8');
    final Map<String, dynamic> $params = <String, dynamic>{
      'static': $static,
      'params': params,
      'tag': tag,
      'deviceProfileId': deviceProfileId,
      'playSessionId': playSessionId,
      'segmentContainer': segmentContainer,
      'segmentLength': segmentLength,
      'minSegments': minSegments,
      'mediaSourceId': mediaSourceId,
      'deviceId': deviceId,
      'audioCodec': audioCodec,
      'enableAutoStreamCopy': enableAutoStreamCopy,
      'allowVideoStreamCopy': allowVideoStreamCopy,
      'allowAudioStreamCopy': allowAudioStreamCopy,
      'breakOnNonKeyFrames': breakOnNonKeyFrames,
      'audioSampleRate': audioSampleRate,
      'maxAudioBitDepth': maxAudioBitDepth,
      'maxStreamingBitrate': maxStreamingBitrate,
      'audioBitRate': audioBitRate,
      'audioChannels': audioChannels,
      'maxAudioChannels': maxAudioChannels,
      'profile': profile,
      'level': level,
      'framerate': framerate,
      'maxFramerate': maxFramerate,
      'copyTimestamps': copyTimestamps,
      'startTimeTicks': startTimeTicks,
      'width': width,
      'height': height,
      'videoBitRate': videoBitRate,
      'subtitleStreamIndex': subtitleStreamIndex,
      'subtitleMethod': subtitleMethod,
      'maxRefFrames': maxRefFrames,
      'maxVideoBitDepth': maxVideoBitDepth,
      'requireAvc': requireAvc,
      'deInterlace': deInterlace,
      'requireNonAnamorphic': requireNonAnamorphic,
      'transcodingMaxAudioChannels': transcodingMaxAudioChannels,
      'cpuCoreLimit': cpuCoreLimit,
      'liveStreamId': liveStreamId,
      'enableMpegtsM2TsMode': enableMpegtsM2TsMode,
      'videoCodec': videoCodec,
      'subtitleCodec': subtitleCodec,
      'transcodeReasons': transcodeReasons,
      'audioStreamIndex': audioStreamIndex,
      'videoStreamIndex': videoStreamIndex,
      'context': context,
      'streamOptions': streamOptions,
      'enableAdaptiveBitrateStreaming': enableAdaptiveBitrateStreaming,
      'enableAudioVbrEncoding': enableAudioVbrEncoding,
    };
    final Request $request = Request(
      'HEAD',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _videosItemIdHls1PlaylistIdSegmentIdContainerGet({
    required String? itemId,
    required String? playlistId,
    required int? segmentId,
    required String? container,
    required int? runtimeTicks,
    required int? actualSegmentLengthTicks,
    bool? $static,
    String? params,
    String? tag,
    String? deviceProfileId,
    String? playSessionId,
    String? segmentContainer,
    int? segmentLength,
    int? minSegments,
    String? mediaSourceId,
    String? deviceId,
    String? audioCodec,
    bool? enableAutoStreamCopy,
    bool? allowVideoStreamCopy,
    bool? allowAudioStreamCopy,
    bool? breakOnNonKeyFrames,
    int? audioSampleRate,
    int? maxAudioBitDepth,
    int? audioBitRate,
    int? audioChannels,
    int? maxAudioChannels,
    String? profile,
    String? level,
    num? framerate,
    num? maxFramerate,
    bool? copyTimestamps,
    int? startTimeTicks,
    int? width,
    int? height,
    int? maxWidth,
    int? maxHeight,
    int? videoBitRate,
    int? subtitleStreamIndex,
    String? subtitleMethod,
    int? maxRefFrames,
    int? maxVideoBitDepth,
    bool? requireAvc,
    bool? deInterlace,
    bool? requireNonAnamorphic,
    int? transcodingMaxAudioChannels,
    int? cpuCoreLimit,
    String? liveStreamId,
    bool? enableMpegtsM2TsMode,
    String? videoCodec,
    String? subtitleCodec,
    String? transcodeReasons,
    int? audioStreamIndex,
    int? videoStreamIndex,
    String? context,
    Object? streamOptions,
    bool? enableAudioVbrEncoding,
    bool? alwaysBurnInSubtitleWhenTranscoding,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets a video stream using HTTP live streaming.',
      operationId: 'GetHlsVideoSegment',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["DynamicHls"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse(
      '/Videos/${itemId}/hls1/${playlistId}/${segmentId}.${container}',
    );
    final Map<String, dynamic> $params = <String, dynamic>{
      'runtimeTicks': runtimeTicks,
      'actualSegmentLengthTicks': actualSegmentLengthTicks,
      'static': $static,
      'params': params,
      'tag': tag,
      'deviceProfileId': deviceProfileId,
      'playSessionId': playSessionId,
      'segmentContainer': segmentContainer,
      'segmentLength': segmentLength,
      'minSegments': minSegments,
      'mediaSourceId': mediaSourceId,
      'deviceId': deviceId,
      'audioCodec': audioCodec,
      'enableAutoStreamCopy': enableAutoStreamCopy,
      'allowVideoStreamCopy': allowVideoStreamCopy,
      'allowAudioStreamCopy': allowAudioStreamCopy,
      'breakOnNonKeyFrames': breakOnNonKeyFrames,
      'audioSampleRate': audioSampleRate,
      'maxAudioBitDepth': maxAudioBitDepth,
      'audioBitRate': audioBitRate,
      'audioChannels': audioChannels,
      'maxAudioChannels': maxAudioChannels,
      'profile': profile,
      'level': level,
      'framerate': framerate,
      'maxFramerate': maxFramerate,
      'copyTimestamps': copyTimestamps,
      'startTimeTicks': startTimeTicks,
      'width': width,
      'height': height,
      'maxWidth': maxWidth,
      'maxHeight': maxHeight,
      'videoBitRate': videoBitRate,
      'subtitleStreamIndex': subtitleStreamIndex,
      'subtitleMethod': subtitleMethod,
      'maxRefFrames': maxRefFrames,
      'maxVideoBitDepth': maxVideoBitDepth,
      'requireAvc': requireAvc,
      'deInterlace': deInterlace,
      'requireNonAnamorphic': requireNonAnamorphic,
      'transcodingMaxAudioChannels': transcodingMaxAudioChannels,
      'cpuCoreLimit': cpuCoreLimit,
      'liveStreamId': liveStreamId,
      'enableMpegtsM2TsMode': enableMpegtsM2TsMode,
      'videoCodec': videoCodec,
      'subtitleCodec': subtitleCodec,
      'transcodeReasons': transcodeReasons,
      'audioStreamIndex': audioStreamIndex,
      'videoStreamIndex': videoStreamIndex,
      'context': context,
      'streamOptions': streamOptions,
      'enableAudioVbrEncoding': enableAudioVbrEncoding,
      'alwaysBurnInSubtitleWhenTranscoding':
          alwaysBurnInSubtitleWhenTranscoding,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _videosItemIdLiveM3u8Get({
    required String? itemId,
    String? container,
    bool? $static,
    String? params,
    String? tag,
    String? deviceProfileId,
    String? playSessionId,
    String? segmentContainer,
    int? segmentLength,
    int? minSegments,
    String? mediaSourceId,
    String? deviceId,
    String? audioCodec,
    bool? enableAutoStreamCopy,
    bool? allowVideoStreamCopy,
    bool? allowAudioStreamCopy,
    bool? breakOnNonKeyFrames,
    int? audioSampleRate,
    int? maxAudioBitDepth,
    int? audioBitRate,
    int? audioChannels,
    int? maxAudioChannels,
    String? profile,
    String? level,
    num? framerate,
    num? maxFramerate,
    bool? copyTimestamps,
    int? startTimeTicks,
    int? width,
    int? height,
    int? videoBitRate,
    int? subtitleStreamIndex,
    String? subtitleMethod,
    int? maxRefFrames,
    int? maxVideoBitDepth,
    bool? requireAvc,
    bool? deInterlace,
    bool? requireNonAnamorphic,
    int? transcodingMaxAudioChannels,
    int? cpuCoreLimit,
    String? liveStreamId,
    bool? enableMpegtsM2TsMode,
    String? videoCodec,
    String? subtitleCodec,
    String? transcodeReasons,
    int? audioStreamIndex,
    int? videoStreamIndex,
    String? context,
    Object? streamOptions,
    int? maxWidth,
    int? maxHeight,
    bool? enableSubtitlesInManifest,
    bool? enableAudioVbrEncoding,
    bool? alwaysBurnInSubtitleWhenTranscoding,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets a hls live stream.',
      operationId: 'GetLiveHlsStream',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["DynamicHls"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Videos/${itemId}/live.m3u8');
    final Map<String, dynamic> $params = <String, dynamic>{
      'container': container,
      'static': $static,
      'params': params,
      'tag': tag,
      'deviceProfileId': deviceProfileId,
      'playSessionId': playSessionId,
      'segmentContainer': segmentContainer,
      'segmentLength': segmentLength,
      'minSegments': minSegments,
      'mediaSourceId': mediaSourceId,
      'deviceId': deviceId,
      'audioCodec': audioCodec,
      'enableAutoStreamCopy': enableAutoStreamCopy,
      'allowVideoStreamCopy': allowVideoStreamCopy,
      'allowAudioStreamCopy': allowAudioStreamCopy,
      'breakOnNonKeyFrames': breakOnNonKeyFrames,
      'audioSampleRate': audioSampleRate,
      'maxAudioBitDepth': maxAudioBitDepth,
      'audioBitRate': audioBitRate,
      'audioChannels': audioChannels,
      'maxAudioChannels': maxAudioChannels,
      'profile': profile,
      'level': level,
      'framerate': framerate,
      'maxFramerate': maxFramerate,
      'copyTimestamps': copyTimestamps,
      'startTimeTicks': startTimeTicks,
      'width': width,
      'height': height,
      'videoBitRate': videoBitRate,
      'subtitleStreamIndex': subtitleStreamIndex,
      'subtitleMethod': subtitleMethod,
      'maxRefFrames': maxRefFrames,
      'maxVideoBitDepth': maxVideoBitDepth,
      'requireAvc': requireAvc,
      'deInterlace': deInterlace,
      'requireNonAnamorphic': requireNonAnamorphic,
      'transcodingMaxAudioChannels': transcodingMaxAudioChannels,
      'cpuCoreLimit': cpuCoreLimit,
      'liveStreamId': liveStreamId,
      'enableMpegtsM2TsMode': enableMpegtsM2TsMode,
      'videoCodec': videoCodec,
      'subtitleCodec': subtitleCodec,
      'transcodeReasons': transcodeReasons,
      'audioStreamIndex': audioStreamIndex,
      'videoStreamIndex': videoStreamIndex,
      'context': context,
      'streamOptions': streamOptions,
      'maxWidth': maxWidth,
      'maxHeight': maxHeight,
      'enableSubtitlesInManifest': enableSubtitlesInManifest,
      'enableAudioVbrEncoding': enableAudioVbrEncoding,
      'alwaysBurnInSubtitleWhenTranscoding':
          alwaysBurnInSubtitleWhenTranscoding,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _videosItemIdMainM3u8Get({
    required String? itemId,
    bool? $static,
    String? params,
    String? tag,
    String? deviceProfileId,
    String? playSessionId,
    String? segmentContainer,
    int? segmentLength,
    int? minSegments,
    String? mediaSourceId,
    String? deviceId,
    String? audioCodec,
    bool? enableAutoStreamCopy,
    bool? allowVideoStreamCopy,
    bool? allowAudioStreamCopy,
    bool? breakOnNonKeyFrames,
    int? audioSampleRate,
    int? maxAudioBitDepth,
    int? audioBitRate,
    int? audioChannels,
    int? maxAudioChannels,
    String? profile,
    String? level,
    num? framerate,
    num? maxFramerate,
    bool? copyTimestamps,
    int? startTimeTicks,
    int? width,
    int? height,
    int? maxWidth,
    int? maxHeight,
    int? videoBitRate,
    int? subtitleStreamIndex,
    String? subtitleMethod,
    int? maxRefFrames,
    int? maxVideoBitDepth,
    bool? requireAvc,
    bool? deInterlace,
    bool? requireNonAnamorphic,
    int? transcodingMaxAudioChannels,
    int? cpuCoreLimit,
    String? liveStreamId,
    bool? enableMpegtsM2TsMode,
    String? videoCodec,
    String? subtitleCodec,
    String? transcodeReasons,
    int? audioStreamIndex,
    int? videoStreamIndex,
    String? context,
    Object? streamOptions,
    bool? enableAudioVbrEncoding,
    bool? alwaysBurnInSubtitleWhenTranscoding,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets a video stream using HTTP live streaming.',
      operationId: 'GetVariantHlsVideoPlaylist',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["DynamicHls"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Videos/${itemId}/main.m3u8');
    final Map<String, dynamic> $params = <String, dynamic>{
      'static': $static,
      'params': params,
      'tag': tag,
      'deviceProfileId': deviceProfileId,
      'playSessionId': playSessionId,
      'segmentContainer': segmentContainer,
      'segmentLength': segmentLength,
      'minSegments': minSegments,
      'mediaSourceId': mediaSourceId,
      'deviceId': deviceId,
      'audioCodec': audioCodec,
      'enableAutoStreamCopy': enableAutoStreamCopy,
      'allowVideoStreamCopy': allowVideoStreamCopy,
      'allowAudioStreamCopy': allowAudioStreamCopy,
      'breakOnNonKeyFrames': breakOnNonKeyFrames,
      'audioSampleRate': audioSampleRate,
      'maxAudioBitDepth': maxAudioBitDepth,
      'audioBitRate': audioBitRate,
      'audioChannels': audioChannels,
      'maxAudioChannels': maxAudioChannels,
      'profile': profile,
      'level': level,
      'framerate': framerate,
      'maxFramerate': maxFramerate,
      'copyTimestamps': copyTimestamps,
      'startTimeTicks': startTimeTicks,
      'width': width,
      'height': height,
      'maxWidth': maxWidth,
      'maxHeight': maxHeight,
      'videoBitRate': videoBitRate,
      'subtitleStreamIndex': subtitleStreamIndex,
      'subtitleMethod': subtitleMethod,
      'maxRefFrames': maxRefFrames,
      'maxVideoBitDepth': maxVideoBitDepth,
      'requireAvc': requireAvc,
      'deInterlace': deInterlace,
      'requireNonAnamorphic': requireNonAnamorphic,
      'transcodingMaxAudioChannels': transcodingMaxAudioChannels,
      'cpuCoreLimit': cpuCoreLimit,
      'liveStreamId': liveStreamId,
      'enableMpegtsM2TsMode': enableMpegtsM2TsMode,
      'videoCodec': videoCodec,
      'subtitleCodec': subtitleCodec,
      'transcodeReasons': transcodeReasons,
      'audioStreamIndex': audioStreamIndex,
      'videoStreamIndex': videoStreamIndex,
      'context': context,
      'streamOptions': streamOptions,
      'enableAudioVbrEncoding': enableAudioVbrEncoding,
      'alwaysBurnInSubtitleWhenTranscoding':
          alwaysBurnInSubtitleWhenTranscoding,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _videosItemIdMasterM3u8Get({
    required String? itemId,
    bool? $static,
    String? params,
    String? tag,
    String? deviceProfileId,
    String? playSessionId,
    String? segmentContainer,
    int? segmentLength,
    int? minSegments,
    required String? mediaSourceId,
    String? deviceId,
    String? audioCodec,
    bool? enableAutoStreamCopy,
    bool? allowVideoStreamCopy,
    bool? allowAudioStreamCopy,
    bool? breakOnNonKeyFrames,
    int? audioSampleRate,
    int? maxAudioBitDepth,
    int? audioBitRate,
    int? audioChannels,
    int? maxAudioChannels,
    String? profile,
    String? level,
    num? framerate,
    num? maxFramerate,
    bool? copyTimestamps,
    int? startTimeTicks,
    int? width,
    int? height,
    int? maxWidth,
    int? maxHeight,
    int? videoBitRate,
    int? subtitleStreamIndex,
    String? subtitleMethod,
    int? maxRefFrames,
    int? maxVideoBitDepth,
    bool? requireAvc,
    bool? deInterlace,
    bool? requireNonAnamorphic,
    int? transcodingMaxAudioChannels,
    int? cpuCoreLimit,
    String? liveStreamId,
    bool? enableMpegtsM2TsMode,
    String? videoCodec,
    String? subtitleCodec,
    String? transcodeReasons,
    int? audioStreamIndex,
    int? videoStreamIndex,
    String? context,
    Object? streamOptions,
    bool? enableAdaptiveBitrateStreaming,
    bool? enableTrickplay,
    bool? enableAudioVbrEncoding,
    bool? alwaysBurnInSubtitleWhenTranscoding,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets a video hls playlist stream.',
      operationId: 'GetMasterHlsVideoPlaylist',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["DynamicHls"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Videos/${itemId}/master.m3u8');
    final Map<String, dynamic> $params = <String, dynamic>{
      'static': $static,
      'params': params,
      'tag': tag,
      'deviceProfileId': deviceProfileId,
      'playSessionId': playSessionId,
      'segmentContainer': segmentContainer,
      'segmentLength': segmentLength,
      'minSegments': minSegments,
      'mediaSourceId': mediaSourceId,
      'deviceId': deviceId,
      'audioCodec': audioCodec,
      'enableAutoStreamCopy': enableAutoStreamCopy,
      'allowVideoStreamCopy': allowVideoStreamCopy,
      'allowAudioStreamCopy': allowAudioStreamCopy,
      'breakOnNonKeyFrames': breakOnNonKeyFrames,
      'audioSampleRate': audioSampleRate,
      'maxAudioBitDepth': maxAudioBitDepth,
      'audioBitRate': audioBitRate,
      'audioChannels': audioChannels,
      'maxAudioChannels': maxAudioChannels,
      'profile': profile,
      'level': level,
      'framerate': framerate,
      'maxFramerate': maxFramerate,
      'copyTimestamps': copyTimestamps,
      'startTimeTicks': startTimeTicks,
      'width': width,
      'height': height,
      'maxWidth': maxWidth,
      'maxHeight': maxHeight,
      'videoBitRate': videoBitRate,
      'subtitleStreamIndex': subtitleStreamIndex,
      'subtitleMethod': subtitleMethod,
      'maxRefFrames': maxRefFrames,
      'maxVideoBitDepth': maxVideoBitDepth,
      'requireAvc': requireAvc,
      'deInterlace': deInterlace,
      'requireNonAnamorphic': requireNonAnamorphic,
      'transcodingMaxAudioChannels': transcodingMaxAudioChannels,
      'cpuCoreLimit': cpuCoreLimit,
      'liveStreamId': liveStreamId,
      'enableMpegtsM2TsMode': enableMpegtsM2TsMode,
      'videoCodec': videoCodec,
      'subtitleCodec': subtitleCodec,
      'transcodeReasons': transcodeReasons,
      'audioStreamIndex': audioStreamIndex,
      'videoStreamIndex': videoStreamIndex,
      'context': context,
      'streamOptions': streamOptions,
      'enableAdaptiveBitrateStreaming': enableAdaptiveBitrateStreaming,
      'enableTrickplay': enableTrickplay,
      'enableAudioVbrEncoding': enableAudioVbrEncoding,
      'alwaysBurnInSubtitleWhenTranscoding':
          alwaysBurnInSubtitleWhenTranscoding,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _videosItemIdMasterM3u8Head({
    required String? itemId,
    bool? $static,
    String? params,
    String? tag,
    String? deviceProfileId,
    String? playSessionId,
    String? segmentContainer,
    int? segmentLength,
    int? minSegments,
    required String? mediaSourceId,
    String? deviceId,
    String? audioCodec,
    bool? enableAutoStreamCopy,
    bool? allowVideoStreamCopy,
    bool? allowAudioStreamCopy,
    bool? breakOnNonKeyFrames,
    int? audioSampleRate,
    int? maxAudioBitDepth,
    int? audioBitRate,
    int? audioChannels,
    int? maxAudioChannels,
    String? profile,
    String? level,
    num? framerate,
    num? maxFramerate,
    bool? copyTimestamps,
    int? startTimeTicks,
    int? width,
    int? height,
    int? maxWidth,
    int? maxHeight,
    int? videoBitRate,
    int? subtitleStreamIndex,
    String? subtitleMethod,
    int? maxRefFrames,
    int? maxVideoBitDepth,
    bool? requireAvc,
    bool? deInterlace,
    bool? requireNonAnamorphic,
    int? transcodingMaxAudioChannels,
    int? cpuCoreLimit,
    String? liveStreamId,
    bool? enableMpegtsM2TsMode,
    String? videoCodec,
    String? subtitleCodec,
    String? transcodeReasons,
    int? audioStreamIndex,
    int? videoStreamIndex,
    String? context,
    Object? streamOptions,
    bool? enableAdaptiveBitrateStreaming,
    bool? enableTrickplay,
    bool? enableAudioVbrEncoding,
    bool? alwaysBurnInSubtitleWhenTranscoding,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets a video hls playlist stream.',
      operationId: 'HeadMasterHlsVideoPlaylist',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["DynamicHls"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Videos/${itemId}/master.m3u8');
    final Map<String, dynamic> $params = <String, dynamic>{
      'static': $static,
      'params': params,
      'tag': tag,
      'deviceProfileId': deviceProfileId,
      'playSessionId': playSessionId,
      'segmentContainer': segmentContainer,
      'segmentLength': segmentLength,
      'minSegments': minSegments,
      'mediaSourceId': mediaSourceId,
      'deviceId': deviceId,
      'audioCodec': audioCodec,
      'enableAutoStreamCopy': enableAutoStreamCopy,
      'allowVideoStreamCopy': allowVideoStreamCopy,
      'allowAudioStreamCopy': allowAudioStreamCopy,
      'breakOnNonKeyFrames': breakOnNonKeyFrames,
      'audioSampleRate': audioSampleRate,
      'maxAudioBitDepth': maxAudioBitDepth,
      'audioBitRate': audioBitRate,
      'audioChannels': audioChannels,
      'maxAudioChannels': maxAudioChannels,
      'profile': profile,
      'level': level,
      'framerate': framerate,
      'maxFramerate': maxFramerate,
      'copyTimestamps': copyTimestamps,
      'startTimeTicks': startTimeTicks,
      'width': width,
      'height': height,
      'maxWidth': maxWidth,
      'maxHeight': maxHeight,
      'videoBitRate': videoBitRate,
      'subtitleStreamIndex': subtitleStreamIndex,
      'subtitleMethod': subtitleMethod,
      'maxRefFrames': maxRefFrames,
      'maxVideoBitDepth': maxVideoBitDepth,
      'requireAvc': requireAvc,
      'deInterlace': deInterlace,
      'requireNonAnamorphic': requireNonAnamorphic,
      'transcodingMaxAudioChannels': transcodingMaxAudioChannels,
      'cpuCoreLimit': cpuCoreLimit,
      'liveStreamId': liveStreamId,
      'enableMpegtsM2TsMode': enableMpegtsM2TsMode,
      'videoCodec': videoCodec,
      'subtitleCodec': subtitleCodec,
      'transcodeReasons': transcodeReasons,
      'audioStreamIndex': audioStreamIndex,
      'videoStreamIndex': videoStreamIndex,
      'context': context,
      'streamOptions': streamOptions,
      'enableAdaptiveBitrateStreaming': enableAdaptiveBitrateStreaming,
      'enableTrickplay': enableTrickplay,
      'enableAudioVbrEncoding': enableAudioVbrEncoding,
      'alwaysBurnInSubtitleWhenTranscoding':
          alwaysBurnInSubtitleWhenTranscoding,
    };
    final Request $request = Request(
      'HEAD',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<DefaultDirectoryBrowserInfoDto>>
  _environmentDefaultDirectoryBrowserGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get Default directory browser.',
      operationId: 'GetDefaultDirectoryBrowser',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Environment"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Environment/DefaultDirectoryBrowser');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client
        .send<DefaultDirectoryBrowserInfoDto, DefaultDirectoryBrowserInfoDto>(
          $request,
        );
  }

  @override
  Future<Response<List<FileSystemEntryInfo>>> _environmentDirectoryContentsGet({
    required String? path,
    bool? includeFiles,
    bool? includeDirectories,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets the contents of a given directory in the file system.',
      operationId: 'GetDirectoryContents',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Environment"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Environment/DirectoryContents');
    final Map<String, dynamic> $params = <String, dynamic>{
      'path': path,
      'includeFiles': includeFiles,
      'includeDirectories': includeDirectories,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<List<FileSystemEntryInfo>, FileSystemEntryInfo>(
      $request,
    );
  }

  @override
  Future<Response<List<FileSystemEntryInfo>>> _environmentDrivesGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets available drives from the server\'s file system.',
      operationId: 'GetDrives',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Environment"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Environment/Drives');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<FileSystemEntryInfo>, FileSystemEntryInfo>(
      $request,
    );
  }

  @override
  Future<Response<List<FileSystemEntryInfo>>> _environmentNetworkSharesGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets network paths.',
      operationId: 'GetNetworkShares',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Environment"],
      deprecated: true,
    ),
  }) {
    final Uri $url = Uri.parse('/Environment/NetworkShares');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<FileSystemEntryInfo>, FileSystemEntryInfo>(
      $request,
    );
  }

  @override
  Future<Response<String>> _environmentParentPathGet({
    required String? path,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets the parent path of a given path.',
      operationId: 'GetParentPath',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Environment"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Environment/ParentPath');
    final Map<String, dynamic> $params = <String, dynamic>{'path': path};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<dynamic>> _environmentValidatePathPost({
    required ValidatePathDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Validates path.',
      operationId: 'ValidatePath',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Environment"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Environment/ValidatePath');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<QueryFiltersLegacy>> _itemsFiltersGet({
    String? userId,
    String? parentId,
    List<Object?>? includeItemTypes,
    List<Object?>? mediaTypes,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets legacy query filters.',
      operationId: 'GetQueryFiltersLegacy',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Filter"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Items/Filters');
    final Map<String, dynamic> $params = <String, dynamic>{
      'userId': userId,
      'parentId': parentId,
      'includeItemTypes': includeItemTypes,
      'mediaTypes': mediaTypes,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<QueryFiltersLegacy, QueryFiltersLegacy>($request);
  }

  @override
  Future<Response<QueryFilters>> _itemsFilters2Get({
    String? userId,
    String? parentId,
    List<Object?>? includeItemTypes,
    bool? isAiring,
    bool? isMovie,
    bool? isSports,
    bool? isKids,
    bool? isNews,
    bool? isSeries,
    bool? recursive,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets query filters.',
      operationId: 'GetQueryFilters',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Filter"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Items/Filters2');
    final Map<String, dynamic> $params = <String, dynamic>{
      'userId': userId,
      'parentId': parentId,
      'includeItemTypes': includeItemTypes,
      'isAiring': isAiring,
      'isMovie': isMovie,
      'isSports': isSports,
      'isKids': isKids,
      'isNews': isNews,
      'isSeries': isSeries,
      'recursive': recursive,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<QueryFilters, QueryFilters>($request);
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _genresGet({
    int? startIndex,
    int? limit,
    String? searchTerm,
    String? parentId,
    List<Object?>? fields,
    List<Object?>? excludeItemTypes,
    List<Object?>? includeItemTypes,
    bool? isFavorite,
    int? imageTypeLimit,
    List<Object?>? enableImageTypes,
    String? userId,
    String? nameStartsWithOrGreater,
    String? nameStartsWith,
    String? nameLessThan,
    List<Object?>? sortBy,
    List<Object?>? sortOrder,
    bool? enableImages,
    bool? enableTotalRecordCount,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary:
          'Gets all genres from a given item, folder, or the entire library.',
      operationId: 'GetGenres',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Genres"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Genres');
    final Map<String, dynamic> $params = <String, dynamic>{
      'startIndex': startIndex,
      'limit': limit,
      'searchTerm': searchTerm,
      'parentId': parentId,
      'fields': fields,
      'excludeItemTypes': excludeItemTypes,
      'includeItemTypes': includeItemTypes,
      'isFavorite': isFavorite,
      'imageTypeLimit': imageTypeLimit,
      'enableImageTypes': enableImageTypes,
      'userId': userId,
      'nameStartsWithOrGreater': nameStartsWithOrGreater,
      'nameStartsWith': nameStartsWith,
      'nameLessThan': nameLessThan,
      'sortBy': sortBy,
      'sortOrder': sortOrder,
      'enableImages': enableImages,
      'enableTotalRecordCount': enableTotalRecordCount,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<BaseItemDto>> _genresGenreNameGet({
    required String? genreName,
    String? userId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets a genre, by name.',
      operationId: 'GetGenre',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Genres"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Genres/${genreName}');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDto, BaseItemDto>($request);
  }

  @override
  Future<Response<String>> _audioItemIdHlsSegmentIdStreamAacGet({
    required String? itemId,
    required String? segmentId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets the specified audio segment for an audio item.',
      operationId: 'GetHlsAudioSegmentLegacyAac',
      consumes: [],
      produces: [],
      security: [],
      tags: ["HlsSegment"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Audio/${itemId}/hls/${segmentId}/stream.aac');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _audioItemIdHlsSegmentIdStreamMp3Get({
    required String? itemId,
    required String? segmentId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets the specified audio segment for an audio item.',
      operationId: 'GetHlsAudioSegmentLegacyMp3',
      consumes: [],
      produces: [],
      security: [],
      tags: ["HlsSegment"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Audio/${itemId}/hls/${segmentId}/stream.mp3');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>>
  _videosItemIdHlsPlaylistIdSegmentIdSegmentContainerGet({
    required String? itemId,
    required String? playlistId,
    required String? segmentId,
    required String? segmentContainer,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets a hls video segment.',
      operationId: 'GetHlsVideoSegmentLegacy',
      consumes: [],
      produces: [],
      security: [],
      tags: ["HlsSegment"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse(
      '/Videos/${itemId}/hls/${playlistId}/${segmentId}.${segmentContainer}',
    );
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _videosItemIdHlsPlaylistIdStreamM3u8Get({
    required String? itemId,
    required String? playlistId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets a hls video playlist.',
      operationId: 'GetHlsPlaylistLegacy',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["HlsSegment"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse(
      '/Videos/${itemId}/hls/${playlistId}/stream.m3u8',
    );
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<dynamic>> _videosActiveEncodingsDelete({
    required String? deviceId,
    required String? playSessionId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Stops an active encoding.',
      operationId: 'StopEncodingProcess',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["HlsSegment"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Videos/ActiveEncodings');
    final Map<String, dynamic> $params = <String, dynamic>{
      'deviceId': deviceId,
      'playSessionId': playSessionId,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<String>> _artistsNameImagesImageTypeImageIndexGet({
    required String? name,
    required String? imageType,
    String? tag,
    String? format,
    int? maxWidth,
    int? maxHeight,
    num? percentPlayed,
    int? unplayedCount,
    int? width,
    int? height,
    int? quality,
    int? fillWidth,
    int? fillHeight,
    int? blur,
    String? backgroundColor,
    String? foregroundLayer,
    required int? imageIndex,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get artist image by name.',
      operationId: 'GetArtistImage',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Image"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse(
      '/Artists/${name}/Images/${imageType}/${imageIndex}',
    );
    final Map<String, dynamic> $params = <String, dynamic>{
      'tag': tag,
      'format': format,
      'maxWidth': maxWidth,
      'maxHeight': maxHeight,
      'percentPlayed': percentPlayed,
      'unplayedCount': unplayedCount,
      'width': width,
      'height': height,
      'quality': quality,
      'fillWidth': fillWidth,
      'fillHeight': fillHeight,
      'blur': blur,
      'backgroundColor': backgroundColor,
      'foregroundLayer': foregroundLayer,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _artistsNameImagesImageTypeImageIndexHead({
    required String? name,
    required String? imageType,
    String? tag,
    String? format,
    int? maxWidth,
    int? maxHeight,
    num? percentPlayed,
    int? unplayedCount,
    int? width,
    int? height,
    int? quality,
    int? fillWidth,
    int? fillHeight,
    int? blur,
    String? backgroundColor,
    String? foregroundLayer,
    required int? imageIndex,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get artist image by name.',
      operationId: 'HeadArtistImage',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Image"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse(
      '/Artists/${name}/Images/${imageType}/${imageIndex}',
    );
    final Map<String, dynamic> $params = <String, dynamic>{
      'tag': tag,
      'format': format,
      'maxWidth': maxWidth,
      'maxHeight': maxHeight,
      'percentPlayed': percentPlayed,
      'unplayedCount': unplayedCount,
      'width': width,
      'height': height,
      'quality': quality,
      'fillWidth': fillWidth,
      'fillHeight': fillHeight,
      'blur': blur,
      'backgroundColor': backgroundColor,
      'foregroundLayer': foregroundLayer,
    };
    final Request $request = Request(
      'HEAD',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _brandingSplashscreenGet({
    String? tag,
    String? format,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Generates or gets the splashscreen.',
      operationId: 'GetSplashscreen',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Image"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Branding/Splashscreen');
    final Map<String, dynamic> $params = <String, dynamic>{
      'tag': tag,
      'format': format,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<dynamic>> _brandingSplashscreenPost({
    required Object? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: '''Uploads a custom splashscreen.
The body is expected to the image contents base64 encoded.''',
      operationId: 'UploadCustomSplashscreen',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Image"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Branding/Splashscreen');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _brandingSplashscreenDelete({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Delete a custom splashscreen.',
      operationId: 'DeleteCustomSplashscreen',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Image"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Branding/Splashscreen');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<String>> _genresNameImagesImageTypeGet({
    required String? name,
    required String? imageType,
    String? tag,
    String? format,
    int? maxWidth,
    int? maxHeight,
    num? percentPlayed,
    int? unplayedCount,
    int? width,
    int? height,
    int? quality,
    int? fillWidth,
    int? fillHeight,
    int? blur,
    String? backgroundColor,
    String? foregroundLayer,
    int? imageIndex,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get genre image by name.',
      operationId: 'GetGenreImage',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Image"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Genres/${name}/Images/${imageType}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'tag': tag,
      'format': format,
      'maxWidth': maxWidth,
      'maxHeight': maxHeight,
      'percentPlayed': percentPlayed,
      'unplayedCount': unplayedCount,
      'width': width,
      'height': height,
      'quality': quality,
      'fillWidth': fillWidth,
      'fillHeight': fillHeight,
      'blur': blur,
      'backgroundColor': backgroundColor,
      'foregroundLayer': foregroundLayer,
      'imageIndex': imageIndex,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _genresNameImagesImageTypeHead({
    required String? name,
    required String? imageType,
    String? tag,
    String? format,
    int? maxWidth,
    int? maxHeight,
    num? percentPlayed,
    int? unplayedCount,
    int? width,
    int? height,
    int? quality,
    int? fillWidth,
    int? fillHeight,
    int? blur,
    String? backgroundColor,
    String? foregroundLayer,
    int? imageIndex,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get genre image by name.',
      operationId: 'HeadGenreImage',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Image"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Genres/${name}/Images/${imageType}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'tag': tag,
      'format': format,
      'maxWidth': maxWidth,
      'maxHeight': maxHeight,
      'percentPlayed': percentPlayed,
      'unplayedCount': unplayedCount,
      'width': width,
      'height': height,
      'quality': quality,
      'fillWidth': fillWidth,
      'fillHeight': fillHeight,
      'blur': blur,
      'backgroundColor': backgroundColor,
      'foregroundLayer': foregroundLayer,
      'imageIndex': imageIndex,
    };
    final Request $request = Request(
      'HEAD',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _genresNameImagesImageTypeImageIndexGet({
    required String? name,
    required String? imageType,
    required int? imageIndex,
    String? tag,
    String? format,
    int? maxWidth,
    int? maxHeight,
    num? percentPlayed,
    int? unplayedCount,
    int? width,
    int? height,
    int? quality,
    int? fillWidth,
    int? fillHeight,
    int? blur,
    String? backgroundColor,
    String? foregroundLayer,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get genre image by name.',
      operationId: 'GetGenreImageByIndex',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Image"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse(
      '/Genres/${name}/Images/${imageType}/${imageIndex}',
    );
    final Map<String, dynamic> $params = <String, dynamic>{
      'tag': tag,
      'format': format,
      'maxWidth': maxWidth,
      'maxHeight': maxHeight,
      'percentPlayed': percentPlayed,
      'unplayedCount': unplayedCount,
      'width': width,
      'height': height,
      'quality': quality,
      'fillWidth': fillWidth,
      'fillHeight': fillHeight,
      'blur': blur,
      'backgroundColor': backgroundColor,
      'foregroundLayer': foregroundLayer,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _genresNameImagesImageTypeImageIndexHead({
    required String? name,
    required String? imageType,
    required int? imageIndex,
    String? tag,
    String? format,
    int? maxWidth,
    int? maxHeight,
    num? percentPlayed,
    int? unplayedCount,
    int? width,
    int? height,
    int? quality,
    int? fillWidth,
    int? fillHeight,
    int? blur,
    String? backgroundColor,
    String? foregroundLayer,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get genre image by name.',
      operationId: 'HeadGenreImageByIndex',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Image"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse(
      '/Genres/${name}/Images/${imageType}/${imageIndex}',
    );
    final Map<String, dynamic> $params = <String, dynamic>{
      'tag': tag,
      'format': format,
      'maxWidth': maxWidth,
      'maxHeight': maxHeight,
      'percentPlayed': percentPlayed,
      'unplayedCount': unplayedCount,
      'width': width,
      'height': height,
      'quality': quality,
      'fillWidth': fillWidth,
      'fillHeight': fillHeight,
      'blur': blur,
      'backgroundColor': backgroundColor,
      'foregroundLayer': foregroundLayer,
    };
    final Request $request = Request(
      'HEAD',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<List<ImageInfo>>> _itemsItemIdImagesGet({
    required String? itemId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get item image infos.',
      operationId: 'GetItemImageInfos',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Image"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Items/${itemId}/Images');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<ImageInfo>, ImageInfo>($request);
  }

  @override
  Future<Response<dynamic>> _itemsItemIdImagesImageTypeDelete({
    required String? itemId,
    required String? imageType,
    int? imageIndex,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Delete an item\'s image.',
      operationId: 'DeleteItemImage',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Image"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Items/${itemId}/Images/${imageType}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'imageIndex': imageIndex,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _itemsItemIdImagesImageTypePost({
    required String? itemId,
    required String? imageType,
    required Object? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Set item image.',
      operationId: 'SetItemImage',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Image"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Items/${itemId}/Images/${imageType}');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<String>> _itemsItemIdImagesImageTypeGet({
    required String? itemId,
    required String? imageType,
    int? maxWidth,
    int? maxHeight,
    int? width,
    int? height,
    int? quality,
    int? fillWidth,
    int? fillHeight,
    String? tag,
    String? format,
    num? percentPlayed,
    int? unplayedCount,
    int? blur,
    String? backgroundColor,
    String? foregroundLayer,
    int? imageIndex,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets the item\'s image.',
      operationId: 'GetItemImage',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Image"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Items/${itemId}/Images/${imageType}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'maxWidth': maxWidth,
      'maxHeight': maxHeight,
      'width': width,
      'height': height,
      'quality': quality,
      'fillWidth': fillWidth,
      'fillHeight': fillHeight,
      'tag': tag,
      'format': format,
      'percentPlayed': percentPlayed,
      'unplayedCount': unplayedCount,
      'blur': blur,
      'backgroundColor': backgroundColor,
      'foregroundLayer': foregroundLayer,
      'imageIndex': imageIndex,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _itemsItemIdImagesImageTypeHead({
    required String? itemId,
    required String? imageType,
    int? maxWidth,
    int? maxHeight,
    int? width,
    int? height,
    int? quality,
    int? fillWidth,
    int? fillHeight,
    String? tag,
    String? format,
    num? percentPlayed,
    int? unplayedCount,
    int? blur,
    String? backgroundColor,
    String? foregroundLayer,
    int? imageIndex,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets the item\'s image.',
      operationId: 'HeadItemImage',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Image"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Items/${itemId}/Images/${imageType}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'maxWidth': maxWidth,
      'maxHeight': maxHeight,
      'width': width,
      'height': height,
      'quality': quality,
      'fillWidth': fillWidth,
      'fillHeight': fillHeight,
      'tag': tag,
      'format': format,
      'percentPlayed': percentPlayed,
      'unplayedCount': unplayedCount,
      'blur': blur,
      'backgroundColor': backgroundColor,
      'foregroundLayer': foregroundLayer,
      'imageIndex': imageIndex,
    };
    final Request $request = Request(
      'HEAD',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<dynamic>> _itemsItemIdImagesImageTypeImageIndexDelete({
    required String? itemId,
    required String? imageType,
    required int? imageIndex,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Delete an item\'s image.',
      operationId: 'DeleteItemImageByIndex',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Image"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse(
      '/Items/${itemId}/Images/${imageType}/${imageIndex}',
    );
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _itemsItemIdImagesImageTypeImageIndexPost({
    required String? itemId,
    required String? imageType,
    required int? imageIndex,
    required Object? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Set item image.',
      operationId: 'SetItemImageByIndex',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Image"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse(
      '/Items/${itemId}/Images/${imageType}/${imageIndex}',
    );
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<String>> _itemsItemIdImagesImageTypeImageIndexGet({
    required String? itemId,
    required String? imageType,
    required int? imageIndex,
    int? maxWidth,
    int? maxHeight,
    int? width,
    int? height,
    int? quality,
    int? fillWidth,
    int? fillHeight,
    String? tag,
    String? format,
    num? percentPlayed,
    int? unplayedCount,
    int? blur,
    String? backgroundColor,
    String? foregroundLayer,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets the item\'s image.',
      operationId: 'GetItemImageByIndex',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Image"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse(
      '/Items/${itemId}/Images/${imageType}/${imageIndex}',
    );
    final Map<String, dynamic> $params = <String, dynamic>{
      'maxWidth': maxWidth,
      'maxHeight': maxHeight,
      'width': width,
      'height': height,
      'quality': quality,
      'fillWidth': fillWidth,
      'fillHeight': fillHeight,
      'tag': tag,
      'format': format,
      'percentPlayed': percentPlayed,
      'unplayedCount': unplayedCount,
      'blur': blur,
      'backgroundColor': backgroundColor,
      'foregroundLayer': foregroundLayer,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _itemsItemIdImagesImageTypeImageIndexHead({
    required String? itemId,
    required String? imageType,
    required int? imageIndex,
    int? maxWidth,
    int? maxHeight,
    int? width,
    int? height,
    int? quality,
    int? fillWidth,
    int? fillHeight,
    String? tag,
    String? format,
    num? percentPlayed,
    int? unplayedCount,
    int? blur,
    String? backgroundColor,
    String? foregroundLayer,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets the item\'s image.',
      operationId: 'HeadItemImageByIndex',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Image"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse(
      '/Items/${itemId}/Images/${imageType}/${imageIndex}',
    );
    final Map<String, dynamic> $params = <String, dynamic>{
      'maxWidth': maxWidth,
      'maxHeight': maxHeight,
      'width': width,
      'height': height,
      'quality': quality,
      'fillWidth': fillWidth,
      'fillHeight': fillHeight,
      'tag': tag,
      'format': format,
      'percentPlayed': percentPlayed,
      'unplayedCount': unplayedCount,
      'blur': blur,
      'backgroundColor': backgroundColor,
      'foregroundLayer': foregroundLayer,
    };
    final Request $request = Request(
      'HEAD',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>>
  _itemsItemIdImagesImageTypeImageIndexTagFormatMaxWidthMaxHeightPercentPlayedUnplayedCountGet({
    required String? itemId,
    required String? imageType,
    required int? maxWidth,
    required int? maxHeight,
    int? width,
    int? height,
    int? quality,
    int? fillWidth,
    int? fillHeight,
    required String? tag,
    required String? format,
    required num? percentPlayed,
    required int? unplayedCount,
    int? blur,
    String? backgroundColor,
    String? foregroundLayer,
    required int? imageIndex,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets the item\'s image.',
      operationId: 'GetItemImage2',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Image"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse(
      '/Items/${itemId}/Images/${imageType}/${imageIndex}/${tag}/${format}/${maxWidth}/${maxHeight}/${percentPlayed}/${unplayedCount}',
    );
    final Map<String, dynamic> $params = <String, dynamic>{
      'width': width,
      'height': height,
      'quality': quality,
      'fillWidth': fillWidth,
      'fillHeight': fillHeight,
      'blur': blur,
      'backgroundColor': backgroundColor,
      'foregroundLayer': foregroundLayer,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>>
  _itemsItemIdImagesImageTypeImageIndexTagFormatMaxWidthMaxHeightPercentPlayedUnplayedCountHead({
    required String? itemId,
    required String? imageType,
    required int? maxWidth,
    required int? maxHeight,
    int? width,
    int? height,
    int? quality,
    int? fillWidth,
    int? fillHeight,
    required String? tag,
    required String? format,
    required num? percentPlayed,
    required int? unplayedCount,
    int? blur,
    String? backgroundColor,
    String? foregroundLayer,
    required int? imageIndex,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets the item\'s image.',
      operationId: 'HeadItemImage2',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Image"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse(
      '/Items/${itemId}/Images/${imageType}/${imageIndex}/${tag}/${format}/${maxWidth}/${maxHeight}/${percentPlayed}/${unplayedCount}',
    );
    final Map<String, dynamic> $params = <String, dynamic>{
      'width': width,
      'height': height,
      'quality': quality,
      'fillWidth': fillWidth,
      'fillHeight': fillHeight,
      'blur': blur,
      'backgroundColor': backgroundColor,
      'foregroundLayer': foregroundLayer,
    };
    final Request $request = Request(
      'HEAD',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<dynamic>> _itemsItemIdImagesImageTypeImageIndexIndexPost({
    required String? itemId,
    required String? imageType,
    required int? imageIndex,
    required int? newIndex,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Updates the index for an item image.',
      operationId: 'UpdateItemImageIndex',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Image"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse(
      '/Items/${itemId}/Images/${imageType}/${imageIndex}/Index',
    );
    final Map<String, dynamic> $params = <String, dynamic>{
      'newIndex': newIndex,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<String>> _musicGenresNameImagesImageTypeGet({
    required String? name,
    required String? imageType,
    String? tag,
    String? format,
    int? maxWidth,
    int? maxHeight,
    num? percentPlayed,
    int? unplayedCount,
    int? width,
    int? height,
    int? quality,
    int? fillWidth,
    int? fillHeight,
    int? blur,
    String? backgroundColor,
    String? foregroundLayer,
    int? imageIndex,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get music genre image by name.',
      operationId: 'GetMusicGenreImage',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Image"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/MusicGenres/${name}/Images/${imageType}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'tag': tag,
      'format': format,
      'maxWidth': maxWidth,
      'maxHeight': maxHeight,
      'percentPlayed': percentPlayed,
      'unplayedCount': unplayedCount,
      'width': width,
      'height': height,
      'quality': quality,
      'fillWidth': fillWidth,
      'fillHeight': fillHeight,
      'blur': blur,
      'backgroundColor': backgroundColor,
      'foregroundLayer': foregroundLayer,
      'imageIndex': imageIndex,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _musicGenresNameImagesImageTypeHead({
    required String? name,
    required String? imageType,
    String? tag,
    String? format,
    int? maxWidth,
    int? maxHeight,
    num? percentPlayed,
    int? unplayedCount,
    int? width,
    int? height,
    int? quality,
    int? fillWidth,
    int? fillHeight,
    int? blur,
    String? backgroundColor,
    String? foregroundLayer,
    int? imageIndex,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get music genre image by name.',
      operationId: 'HeadMusicGenreImage',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Image"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/MusicGenres/${name}/Images/${imageType}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'tag': tag,
      'format': format,
      'maxWidth': maxWidth,
      'maxHeight': maxHeight,
      'percentPlayed': percentPlayed,
      'unplayedCount': unplayedCount,
      'width': width,
      'height': height,
      'quality': quality,
      'fillWidth': fillWidth,
      'fillHeight': fillHeight,
      'blur': blur,
      'backgroundColor': backgroundColor,
      'foregroundLayer': foregroundLayer,
      'imageIndex': imageIndex,
    };
    final Request $request = Request(
      'HEAD',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _musicGenresNameImagesImageTypeImageIndexGet({
    required String? name,
    required String? imageType,
    required int? imageIndex,
    String? tag,
    String? format,
    int? maxWidth,
    int? maxHeight,
    num? percentPlayed,
    int? unplayedCount,
    int? width,
    int? height,
    int? quality,
    int? fillWidth,
    int? fillHeight,
    int? blur,
    String? backgroundColor,
    String? foregroundLayer,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get music genre image by name.',
      operationId: 'GetMusicGenreImageByIndex',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Image"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse(
      '/MusicGenres/${name}/Images/${imageType}/${imageIndex}',
    );
    final Map<String, dynamic> $params = <String, dynamic>{
      'tag': tag,
      'format': format,
      'maxWidth': maxWidth,
      'maxHeight': maxHeight,
      'percentPlayed': percentPlayed,
      'unplayedCount': unplayedCount,
      'width': width,
      'height': height,
      'quality': quality,
      'fillWidth': fillWidth,
      'fillHeight': fillHeight,
      'blur': blur,
      'backgroundColor': backgroundColor,
      'foregroundLayer': foregroundLayer,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _musicGenresNameImagesImageTypeImageIndexHead({
    required String? name,
    required String? imageType,
    required int? imageIndex,
    String? tag,
    String? format,
    int? maxWidth,
    int? maxHeight,
    num? percentPlayed,
    int? unplayedCount,
    int? width,
    int? height,
    int? quality,
    int? fillWidth,
    int? fillHeight,
    int? blur,
    String? backgroundColor,
    String? foregroundLayer,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get music genre image by name.',
      operationId: 'HeadMusicGenreImageByIndex',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Image"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse(
      '/MusicGenres/${name}/Images/${imageType}/${imageIndex}',
    );
    final Map<String, dynamic> $params = <String, dynamic>{
      'tag': tag,
      'format': format,
      'maxWidth': maxWidth,
      'maxHeight': maxHeight,
      'percentPlayed': percentPlayed,
      'unplayedCount': unplayedCount,
      'width': width,
      'height': height,
      'quality': quality,
      'fillWidth': fillWidth,
      'fillHeight': fillHeight,
      'blur': blur,
      'backgroundColor': backgroundColor,
      'foregroundLayer': foregroundLayer,
    };
    final Request $request = Request(
      'HEAD',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _personsNameImagesImageTypeGet({
    required String? name,
    required String? imageType,
    String? tag,
    String? format,
    int? maxWidth,
    int? maxHeight,
    num? percentPlayed,
    int? unplayedCount,
    int? width,
    int? height,
    int? quality,
    int? fillWidth,
    int? fillHeight,
    int? blur,
    String? backgroundColor,
    String? foregroundLayer,
    int? imageIndex,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get person image by name.',
      operationId: 'GetPersonImage',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Image"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Persons/${name}/Images/${imageType}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'tag': tag,
      'format': format,
      'maxWidth': maxWidth,
      'maxHeight': maxHeight,
      'percentPlayed': percentPlayed,
      'unplayedCount': unplayedCount,
      'width': width,
      'height': height,
      'quality': quality,
      'fillWidth': fillWidth,
      'fillHeight': fillHeight,
      'blur': blur,
      'backgroundColor': backgroundColor,
      'foregroundLayer': foregroundLayer,
      'imageIndex': imageIndex,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _personsNameImagesImageTypeHead({
    required String? name,
    required String? imageType,
    String? tag,
    String? format,
    int? maxWidth,
    int? maxHeight,
    num? percentPlayed,
    int? unplayedCount,
    int? width,
    int? height,
    int? quality,
    int? fillWidth,
    int? fillHeight,
    int? blur,
    String? backgroundColor,
    String? foregroundLayer,
    int? imageIndex,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get person image by name.',
      operationId: 'HeadPersonImage',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Image"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Persons/${name}/Images/${imageType}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'tag': tag,
      'format': format,
      'maxWidth': maxWidth,
      'maxHeight': maxHeight,
      'percentPlayed': percentPlayed,
      'unplayedCount': unplayedCount,
      'width': width,
      'height': height,
      'quality': quality,
      'fillWidth': fillWidth,
      'fillHeight': fillHeight,
      'blur': blur,
      'backgroundColor': backgroundColor,
      'foregroundLayer': foregroundLayer,
      'imageIndex': imageIndex,
    };
    final Request $request = Request(
      'HEAD',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _personsNameImagesImageTypeImageIndexGet({
    required String? name,
    required String? imageType,
    required int? imageIndex,
    String? tag,
    String? format,
    int? maxWidth,
    int? maxHeight,
    num? percentPlayed,
    int? unplayedCount,
    int? width,
    int? height,
    int? quality,
    int? fillWidth,
    int? fillHeight,
    int? blur,
    String? backgroundColor,
    String? foregroundLayer,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get person image by name.',
      operationId: 'GetPersonImageByIndex',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Image"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse(
      '/Persons/${name}/Images/${imageType}/${imageIndex}',
    );
    final Map<String, dynamic> $params = <String, dynamic>{
      'tag': tag,
      'format': format,
      'maxWidth': maxWidth,
      'maxHeight': maxHeight,
      'percentPlayed': percentPlayed,
      'unplayedCount': unplayedCount,
      'width': width,
      'height': height,
      'quality': quality,
      'fillWidth': fillWidth,
      'fillHeight': fillHeight,
      'blur': blur,
      'backgroundColor': backgroundColor,
      'foregroundLayer': foregroundLayer,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _personsNameImagesImageTypeImageIndexHead({
    required String? name,
    required String? imageType,
    required int? imageIndex,
    String? tag,
    String? format,
    int? maxWidth,
    int? maxHeight,
    num? percentPlayed,
    int? unplayedCount,
    int? width,
    int? height,
    int? quality,
    int? fillWidth,
    int? fillHeight,
    int? blur,
    String? backgroundColor,
    String? foregroundLayer,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get person image by name.',
      operationId: 'HeadPersonImageByIndex',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Image"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse(
      '/Persons/${name}/Images/${imageType}/${imageIndex}',
    );
    final Map<String, dynamic> $params = <String, dynamic>{
      'tag': tag,
      'format': format,
      'maxWidth': maxWidth,
      'maxHeight': maxHeight,
      'percentPlayed': percentPlayed,
      'unplayedCount': unplayedCount,
      'width': width,
      'height': height,
      'quality': quality,
      'fillWidth': fillWidth,
      'fillHeight': fillHeight,
      'blur': blur,
      'backgroundColor': backgroundColor,
      'foregroundLayer': foregroundLayer,
    };
    final Request $request = Request(
      'HEAD',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _studiosNameImagesImageTypeGet({
    required String? name,
    required String? imageType,
    String? tag,
    String? format,
    int? maxWidth,
    int? maxHeight,
    num? percentPlayed,
    int? unplayedCount,
    int? width,
    int? height,
    int? quality,
    int? fillWidth,
    int? fillHeight,
    int? blur,
    String? backgroundColor,
    String? foregroundLayer,
    int? imageIndex,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get studio image by name.',
      operationId: 'GetStudioImage',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Image"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Studios/${name}/Images/${imageType}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'tag': tag,
      'format': format,
      'maxWidth': maxWidth,
      'maxHeight': maxHeight,
      'percentPlayed': percentPlayed,
      'unplayedCount': unplayedCount,
      'width': width,
      'height': height,
      'quality': quality,
      'fillWidth': fillWidth,
      'fillHeight': fillHeight,
      'blur': blur,
      'backgroundColor': backgroundColor,
      'foregroundLayer': foregroundLayer,
      'imageIndex': imageIndex,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _studiosNameImagesImageTypeHead({
    required String? name,
    required String? imageType,
    String? tag,
    String? format,
    int? maxWidth,
    int? maxHeight,
    num? percentPlayed,
    int? unplayedCount,
    int? width,
    int? height,
    int? quality,
    int? fillWidth,
    int? fillHeight,
    int? blur,
    String? backgroundColor,
    String? foregroundLayer,
    int? imageIndex,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get studio image by name.',
      operationId: 'HeadStudioImage',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Image"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Studios/${name}/Images/${imageType}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'tag': tag,
      'format': format,
      'maxWidth': maxWidth,
      'maxHeight': maxHeight,
      'percentPlayed': percentPlayed,
      'unplayedCount': unplayedCount,
      'width': width,
      'height': height,
      'quality': quality,
      'fillWidth': fillWidth,
      'fillHeight': fillHeight,
      'blur': blur,
      'backgroundColor': backgroundColor,
      'foregroundLayer': foregroundLayer,
      'imageIndex': imageIndex,
    };
    final Request $request = Request(
      'HEAD',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _studiosNameImagesImageTypeImageIndexGet({
    required String? name,
    required String? imageType,
    required int? imageIndex,
    String? tag,
    String? format,
    int? maxWidth,
    int? maxHeight,
    num? percentPlayed,
    int? unplayedCount,
    int? width,
    int? height,
    int? quality,
    int? fillWidth,
    int? fillHeight,
    int? blur,
    String? backgroundColor,
    String? foregroundLayer,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get studio image by name.',
      operationId: 'GetStudioImageByIndex',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Image"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse(
      '/Studios/${name}/Images/${imageType}/${imageIndex}',
    );
    final Map<String, dynamic> $params = <String, dynamic>{
      'tag': tag,
      'format': format,
      'maxWidth': maxWidth,
      'maxHeight': maxHeight,
      'percentPlayed': percentPlayed,
      'unplayedCount': unplayedCount,
      'width': width,
      'height': height,
      'quality': quality,
      'fillWidth': fillWidth,
      'fillHeight': fillHeight,
      'blur': blur,
      'backgroundColor': backgroundColor,
      'foregroundLayer': foregroundLayer,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _studiosNameImagesImageTypeImageIndexHead({
    required String? name,
    required String? imageType,
    required int? imageIndex,
    String? tag,
    String? format,
    int? maxWidth,
    int? maxHeight,
    num? percentPlayed,
    int? unplayedCount,
    int? width,
    int? height,
    int? quality,
    int? fillWidth,
    int? fillHeight,
    int? blur,
    String? backgroundColor,
    String? foregroundLayer,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get studio image by name.',
      operationId: 'HeadStudioImageByIndex',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Image"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse(
      '/Studios/${name}/Images/${imageType}/${imageIndex}',
    );
    final Map<String, dynamic> $params = <String, dynamic>{
      'tag': tag,
      'format': format,
      'maxWidth': maxWidth,
      'maxHeight': maxHeight,
      'percentPlayed': percentPlayed,
      'unplayedCount': unplayedCount,
      'width': width,
      'height': height,
      'quality': quality,
      'fillWidth': fillWidth,
      'fillHeight': fillHeight,
      'blur': blur,
      'backgroundColor': backgroundColor,
      'foregroundLayer': foregroundLayer,
    };
    final Request $request = Request(
      'HEAD',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<dynamic>> _userImagePost({
    String? userId,
    required Object? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Sets the user image.',
      operationId: 'PostUserImage',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Image"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/UserImage');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _userImageDelete({
    String? userId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Delete the user\'s image.',
      operationId: 'DeleteUserImage',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Image"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/UserImage');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<String>> _userImageGet({
    String? userId,
    String? tag,
    String? format,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get user profile image.',
      operationId: 'GetUserImage',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Image"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/UserImage');
    final Map<String, dynamic> $params = <String, dynamic>{
      'userId': userId,
      'tag': tag,
      'format': format,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _userImageHead({
    String? userId,
    String? tag,
    String? format,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get user profile image.',
      operationId: 'HeadUserImage',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Image"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/UserImage');
    final Map<String, dynamic> $params = <String, dynamic>{
      'userId': userId,
      'tag': tag,
      'format': format,
    };
    final Request $request = Request(
      'HEAD',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _albumsItemIdInstantMixGet({
    required String? itemId,
    String? userId,
    int? limit,
    List<Object?>? fields,
    bool? enableImages,
    bool? enableUserData,
    int? imageTypeLimit,
    List<Object?>? enableImageTypes,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Creates an instant playlist based on a given album.',
      operationId: 'GetInstantMixFromAlbum',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["InstantMix"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Albums/${itemId}/InstantMix');
    final Map<String, dynamic> $params = <String, dynamic>{
      'userId': userId,
      'limit': limit,
      'fields': fields,
      'enableImages': enableImages,
      'enableUserData': enableUserData,
      'imageTypeLimit': imageTypeLimit,
      'enableImageTypes': enableImageTypes,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _artistsItemIdInstantMixGet({
    required String? itemId,
    String? userId,
    int? limit,
    List<Object?>? fields,
    bool? enableImages,
    bool? enableUserData,
    int? imageTypeLimit,
    List<Object?>? enableImageTypes,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Creates an instant playlist based on a given artist.',
      operationId: 'GetInstantMixFromArtists',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["InstantMix"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Artists/${itemId}/InstantMix');
    final Map<String, dynamic> $params = <String, dynamic>{
      'userId': userId,
      'limit': limit,
      'fields': fields,
      'enableImages': enableImages,
      'enableUserData': enableUserData,
      'imageTypeLimit': imageTypeLimit,
      'enableImageTypes': enableImageTypes,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _artistsInstantMixGet({
    required String? id,
    String? userId,
    int? limit,
    List<Object?>? fields,
    bool? enableImages,
    bool? enableUserData,
    int? imageTypeLimit,
    List<Object?>? enableImageTypes,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Creates an instant playlist based on a given artist.',
      operationId: 'GetInstantMixFromArtists2',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["InstantMix"],
      deprecated: true,
    ),
  }) {
    final Uri $url = Uri.parse('/Artists/InstantMix');
    final Map<String, dynamic> $params = <String, dynamic>{
      'id': id,
      'userId': userId,
      'limit': limit,
      'fields': fields,
      'enableImages': enableImages,
      'enableUserData': enableUserData,
      'imageTypeLimit': imageTypeLimit,
      'enableImageTypes': enableImageTypes,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _itemsItemIdInstantMixGet({
    required String? itemId,
    String? userId,
    int? limit,
    List<Object?>? fields,
    bool? enableImages,
    bool? enableUserData,
    int? imageTypeLimit,
    List<Object?>? enableImageTypes,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Creates an instant playlist based on a given item.',
      operationId: 'GetInstantMixFromItem',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["InstantMix"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Items/${itemId}/InstantMix');
    final Map<String, dynamic> $params = <String, dynamic>{
      'userId': userId,
      'limit': limit,
      'fields': fields,
      'enableImages': enableImages,
      'enableUserData': enableUserData,
      'imageTypeLimit': imageTypeLimit,
      'enableImageTypes': enableImageTypes,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _musicGenresNameInstantMixGet({
    required String? name,
    String? userId,
    int? limit,
    List<Object?>? fields,
    bool? enableImages,
    bool? enableUserData,
    int? imageTypeLimit,
    List<Object?>? enableImageTypes,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Creates an instant playlist based on a given genre.',
      operationId: 'GetInstantMixFromMusicGenreByName',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["InstantMix"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/MusicGenres/${name}/InstantMix');
    final Map<String, dynamic> $params = <String, dynamic>{
      'userId': userId,
      'limit': limit,
      'fields': fields,
      'enableImages': enableImages,
      'enableUserData': enableUserData,
      'imageTypeLimit': imageTypeLimit,
      'enableImageTypes': enableImageTypes,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _musicGenresInstantMixGet({
    required String? id,
    String? userId,
    int? limit,
    List<Object?>? fields,
    bool? enableImages,
    bool? enableUserData,
    int? imageTypeLimit,
    List<Object?>? enableImageTypes,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Creates an instant playlist based on a given genre.',
      operationId: 'GetInstantMixFromMusicGenreById',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["InstantMix"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/MusicGenres/InstantMix');
    final Map<String, dynamic> $params = <String, dynamic>{
      'id': id,
      'userId': userId,
      'limit': limit,
      'fields': fields,
      'enableImages': enableImages,
      'enableUserData': enableUserData,
      'imageTypeLimit': imageTypeLimit,
      'enableImageTypes': enableImageTypes,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _playlistsItemIdInstantMixGet({
    required String? itemId,
    String? userId,
    int? limit,
    List<Object?>? fields,
    bool? enableImages,
    bool? enableUserData,
    int? imageTypeLimit,
    List<Object?>? enableImageTypes,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Creates an instant playlist based on a given playlist.',
      operationId: 'GetInstantMixFromPlaylist',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["InstantMix"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Playlists/${itemId}/InstantMix');
    final Map<String, dynamic> $params = <String, dynamic>{
      'userId': userId,
      'limit': limit,
      'fields': fields,
      'enableImages': enableImages,
      'enableUserData': enableUserData,
      'imageTypeLimit': imageTypeLimit,
      'enableImageTypes': enableImageTypes,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _songsItemIdInstantMixGet({
    required String? itemId,
    String? userId,
    int? limit,
    List<Object?>? fields,
    bool? enableImages,
    bool? enableUserData,
    int? imageTypeLimit,
    List<Object?>? enableImageTypes,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Creates an instant playlist based on a given song.',
      operationId: 'GetInstantMixFromSong',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["InstantMix"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Songs/${itemId}/InstantMix');
    final Map<String, dynamic> $params = <String, dynamic>{
      'userId': userId,
      'limit': limit,
      'fields': fields,
      'enableImages': enableImages,
      'enableUserData': enableUserData,
      'imageTypeLimit': imageTypeLimit,
      'enableImageTypes': enableImageTypes,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<List<ExternalIdInfo>>> _itemsItemIdExternalIdInfosGet({
    required String? itemId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get the item\'s external id info.',
      operationId: 'GetExternalIdInfos',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["ItemLookup"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Items/${itemId}/ExternalIdInfos');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<ExternalIdInfo>, ExternalIdInfo>($request);
  }

  @override
  Future<Response<dynamic>> _itemsRemoteSearchApplyItemIdPost({
    required String? itemId,
    bool? replaceAllImages,
    required RemoteSearchResult? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Applies search criteria to an item and refreshes metadata.',
      operationId: 'ApplySearchCriteria',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["ItemLookup"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Items/RemoteSearch/Apply/${itemId}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'replaceAllImages': replaceAllImages,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<RemoteSearchResult>>> _itemsRemoteSearchBookPost({
    required BookInfoRemoteSearchQuery? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get book remote search.',
      operationId: 'GetBookRemoteSearchResults',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["ItemLookup"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Items/RemoteSearch/Book');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<List<RemoteSearchResult>, RemoteSearchResult>($request);
  }

  @override
  Future<Response<List<RemoteSearchResult>>> _itemsRemoteSearchBoxSetPost({
    required BoxSetInfoRemoteSearchQuery? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get box set remote search.',
      operationId: 'GetBoxSetRemoteSearchResults',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["ItemLookup"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Items/RemoteSearch/BoxSet');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<List<RemoteSearchResult>, RemoteSearchResult>($request);
  }

  @override
  Future<Response<List<RemoteSearchResult>>> _itemsRemoteSearchMoviePost({
    required MovieInfoRemoteSearchQuery? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get movie remote search.',
      operationId: 'GetMovieRemoteSearchResults',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["ItemLookup"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Items/RemoteSearch/Movie');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<List<RemoteSearchResult>, RemoteSearchResult>($request);
  }

  @override
  Future<Response<List<RemoteSearchResult>>> _itemsRemoteSearchMusicAlbumPost({
    required AlbumInfoRemoteSearchQuery? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get music album remote search.',
      operationId: 'GetMusicAlbumRemoteSearchResults',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["ItemLookup"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Items/RemoteSearch/MusicAlbum');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<List<RemoteSearchResult>, RemoteSearchResult>($request);
  }

  @override
  Future<Response<List<RemoteSearchResult>>> _itemsRemoteSearchMusicArtistPost({
    required ArtistInfoRemoteSearchQuery? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get music artist remote search.',
      operationId: 'GetMusicArtistRemoteSearchResults',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["ItemLookup"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Items/RemoteSearch/MusicArtist');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<List<RemoteSearchResult>, RemoteSearchResult>($request);
  }

  @override
  Future<Response<List<RemoteSearchResult>>> _itemsRemoteSearchMusicVideoPost({
    required MusicVideoInfoRemoteSearchQuery? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get music video remote search.',
      operationId: 'GetMusicVideoRemoteSearchResults',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["ItemLookup"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Items/RemoteSearch/MusicVideo');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<List<RemoteSearchResult>, RemoteSearchResult>($request);
  }

  @override
  Future<Response<List<RemoteSearchResult>>> _itemsRemoteSearchPersonPost({
    required PersonLookupInfoRemoteSearchQuery? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get person remote search.',
      operationId: 'GetPersonRemoteSearchResults',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["ItemLookup"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Items/RemoteSearch/Person');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<List<RemoteSearchResult>, RemoteSearchResult>($request);
  }

  @override
  Future<Response<List<RemoteSearchResult>>> _itemsRemoteSearchSeriesPost({
    required SeriesInfoRemoteSearchQuery? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get series remote search.',
      operationId: 'GetSeriesRemoteSearchResults',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["ItemLookup"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Items/RemoteSearch/Series');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<List<RemoteSearchResult>, RemoteSearchResult>($request);
  }

  @override
  Future<Response<List<RemoteSearchResult>>> _itemsRemoteSearchTrailerPost({
    required TrailerInfoRemoteSearchQuery? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get trailer remote search.',
      operationId: 'GetTrailerRemoteSearchResults',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["ItemLookup"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Items/RemoteSearch/Trailer');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<List<RemoteSearchResult>, RemoteSearchResult>($request);
  }

  @override
  Future<Response<dynamic>> _itemsItemIdRefreshPost({
    required String? itemId,
    String? metadataRefreshMode,
    String? imageRefreshMode,
    bool? replaceAllMetadata,
    bool? replaceAllImages,
    bool? regenerateTrickplay,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Refreshes metadata for an item.',
      operationId: 'RefreshItem',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["ItemRefresh"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Items/${itemId}/Refresh');
    final Map<String, dynamic> $params = <String, dynamic>{
      'metadataRefreshMode': metadataRefreshMode,
      'imageRefreshMode': imageRefreshMode,
      'replaceAllMetadata': replaceAllMetadata,
      'replaceAllImages': replaceAllImages,
      'regenerateTrickplay': regenerateTrickplay,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _usersUserIdItemsGet({
    required String? userId,
    String? maxOfficialRating,
    bool? hasThemeSong,
    bool? hasThemeVideo,
    bool? hasSubtitles,
    bool? hasSpecialFeature,
    bool? hasTrailer,
    String? adjacentTo,
    int? indexNumber,
    int? parentIndexNumber,
    bool? hasParentalRating,
    bool? isHd,
    bool? is4K,
    List<Object?>? locationTypes,
    List<Object?>? excludeLocationTypes,
    bool? isMissing,
    bool? isUnaired,
    num? minCommunityRating,
    num? minCriticRating,
    DateTime? minPremiereDate,
    DateTime? minDateLastSaved,
    DateTime? minDateLastSavedForUser,
    DateTime? maxPremiereDate,
    bool? hasOverview,
    bool? hasImdbId,
    bool? hasTmdbId,
    bool? hasTvdbId,
    bool? isMovie,
    bool? isSeries,
    bool? isNews,
    bool? isKids,
    bool? isSports,
    List<String>? excludeItemIds,
    int? startIndex,
    int? limit,
    bool? recursive,
    String? searchTerm,
    List<Object?>? sortOrder,
    String? parentId,
    List<Object?>? fields,
    List<Object?>? excludeItemTypes,
    List<Object?>? includeItemTypes,
    List<Object?>? filters,
    bool? isFavorite,
    List<Object?>? mediaTypes,
    List<Object?>? imageTypes,
    List<Object?>? sortBy,
    bool? isPlayed,
    List<String>? genres,
    List<String>? officialRatings,
    List<String>? tags,
    List<int>? years,
    bool? enableUserData,
    int? imageTypeLimit,
    List<Object?>? enableImageTypes,
    String? person,
    List<String>? personIds,
    List<String>? personTypes,
    List<String>? studios,
    List<String>? artists,
    List<String>? excludeArtistIds,
    List<String>? artistIds,
    List<String>? albumArtistIds,
    List<String>? contributingArtistIds,
    List<String>? albums,
    List<String>? albumIds,
    List<String>? ids,
    List<Object?>? videoTypes,
    String? minOfficialRating,
    bool? isLocked,
    bool? isPlaceHolder,
    bool? hasOfficialRating,
    bool? collapseBoxSetItems,
    int? minWidth,
    int? minHeight,
    int? maxWidth,
    int? maxHeight,
    bool? is3D,
    List<Object?>? seriesStatus,
    String? nameStartsWithOrGreater,
    String? nameStartsWith,
    String? nameLessThan,
    List<String>? studioIds,
    List<String>? genreIds,
    bool? enableTotalRecordCount,
    bool? enableImages,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets items based on a query.',
      operationId: 'GetItems',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Items"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Users/${userId}/Items');
    final Map<String, dynamic> $params = <String, dynamic>{
      'maxOfficialRating': maxOfficialRating,
      'hasThemeSong': hasThemeSong,
      'hasThemeVideo': hasThemeVideo,
      'hasSubtitles': hasSubtitles,
      'hasSpecialFeature': hasSpecialFeature,
      'hasTrailer': hasTrailer,
      'adjacentTo': adjacentTo,
      'indexNumber': indexNumber,
      'parentIndexNumber': parentIndexNumber,
      'hasParentalRating': hasParentalRating,
      'isHd': isHd,
      'is4K': is4K,
      'locationTypes': locationTypes,
      'excludeLocationTypes': excludeLocationTypes,
      'isMissing': isMissing,
      'isUnaired': isUnaired,
      'minCommunityRating': minCommunityRating,
      'minCriticRating': minCriticRating,
      'minPremiereDate': minPremiereDate,
      'minDateLastSaved': minDateLastSaved,
      'minDateLastSavedForUser': minDateLastSavedForUser,
      'maxPremiereDate': maxPremiereDate,
      'hasOverview': hasOverview,
      'hasImdbId': hasImdbId,
      'hasTmdbId': hasTmdbId,
      'hasTvdbId': hasTvdbId,
      'isMovie': isMovie,
      'isSeries': isSeries,
      'isNews': isNews,
      'isKids': isKids,
      'isSports': isSports,
      'excludeItemIds': excludeItemIds,
      'startIndex': startIndex,
      'limit': limit,
      'recursive': recursive,
      'searchTerm': searchTerm,
      'sortOrder': sortOrder,
      'parentId': parentId,
      'fields': fields,
      'excludeItemTypes': excludeItemTypes,
      'includeItemTypes': includeItemTypes,
      'filters': filters,
      'isFavorite': isFavorite,
      'mediaTypes': mediaTypes,
      'imageTypes': imageTypes,
      'sortBy': sortBy,
      'isPlayed': isPlayed,
      'genres': genres,
      'officialRatings': officialRatings,
      'tags': tags,
      'years': years,
      'enableUserData': enableUserData,
      'imageTypeLimit': imageTypeLimit,
      'enableImageTypes': enableImageTypes,
      'person': person,
      'personIds': personIds,
      'personTypes': personTypes,
      'studios': studios,
      'artists': artists,
      'excludeArtistIds': excludeArtistIds,
      'artistIds': artistIds,
      'albumArtistIds': albumArtistIds,
      'contributingArtistIds': contributingArtistIds,
      'albums': albums,
      'albumIds': albumIds,
      'ids': ids,
      'videoTypes': videoTypes,
      'minOfficialRating': minOfficialRating,
      'isLocked': isLocked,
      'isPlaceHolder': isPlaceHolder,
      'hasOfficialRating': hasOfficialRating,
      'collapseBoxSetItems': collapseBoxSetItems,
      'minWidth': minWidth,
      'minHeight': minHeight,
      'maxWidth': maxWidth,
      'maxHeight': maxHeight,
      'is3D': is3D,
      'seriesStatus': seriesStatus,
      'nameStartsWithOrGreater': nameStartsWithOrGreater,
      'nameStartsWith': nameStartsWith,
      'nameLessThan': nameLessThan,
      'studioIds': studioIds,
      'genreIds': genreIds,
      'enableTotalRecordCount': enableTotalRecordCount,
      'enableImages': enableImages,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<dynamic>> _usersUserIdItemsDelete({
    List<String>? ids,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Deletes items from the library and filesystem.',
      operationId: 'DeleteItems',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Library"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Users/{userId}/Items');
    final Map<String, dynamic> $params = <String, dynamic>{'ids': ids};
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<UserItemDataDto>> _userItemsItemIdUserDataGet({
    String? userId,
    required String? itemId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get Item User Data.',
      operationId: 'GetItemUserData',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Items"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/UserItems/${itemId}/UserData');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<UserItemDataDto, UserItemDataDto>($request);
  }

  @override
  Future<Response<UserItemDataDto>> _userItemsItemIdUserDataPost({
    String? userId,
    required String? itemId,
    required UpdateUserItemDataDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Update Item User Data.',
      operationId: 'UpdateItemUserData',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Items"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/UserItems/${itemId}/UserData');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<UserItemDataDto, UserItemDataDto>($request);
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _userItemsResumeGet({
    String? userId,
    int? startIndex,
    int? limit,
    String? searchTerm,
    String? parentId,
    List<Object?>? fields,
    List<Object?>? mediaTypes,
    bool? enableUserData,
    int? imageTypeLimit,
    List<Object?>? enableImageTypes,
    List<Object?>? excludeItemTypes,
    List<Object?>? includeItemTypes,
    bool? enableTotalRecordCount,
    bool? enableImages,
    bool? excludeActiveSessions,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets items based on a query.',
      operationId: 'GetResumeItems',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Items"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/UserItems/Resume');
    final Map<String, dynamic> $params = <String, dynamic>{
      'userId': userId,
      'startIndex': startIndex,
      'limit': limit,
      'searchTerm': searchTerm,
      'parentId': parentId,
      'fields': fields,
      'mediaTypes': mediaTypes,
      'enableUserData': enableUserData,
      'imageTypeLimit': imageTypeLimit,
      'enableImageTypes': enableImageTypes,
      'excludeItemTypes': excludeItemTypes,
      'includeItemTypes': includeItemTypes,
      'enableTotalRecordCount': enableTotalRecordCount,
      'enableImages': enableImages,
      'excludeActiveSessions': excludeActiveSessions,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<dynamic>> _itemsItemIdPost({
    required String? itemId,
    required BaseItemDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Updates an item.',
      operationId: 'UpdateItem',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["ItemUpdate"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Items/${itemId}');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _itemsItemIdDelete({
    required String? itemId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Deletes an item from the library and filesystem.',
      operationId: 'DeleteItem',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Library"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Items/${itemId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<BaseItemDto>> _itemsItemIdGet({
    String? userId,
    required String? itemId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets an item from a user\'s library.',
      operationId: 'GetItem',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["UserLibrary"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Items/${itemId}');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDto, BaseItemDto>($request);
  }

  @override
  Future<Response<dynamic>> _itemsItemIdContentTypePost({
    required String? itemId,
    String? contentType,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Updates an item\'s content type.',
      operationId: 'UpdateItemContentType',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["ItemUpdate"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Items/${itemId}/ContentType');
    final Map<String, dynamic> $params = <String, dynamic>{
      'contentType': contentType,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<MetadataEditorInfo>> _itemsItemIdMetadataEditorGet({
    required String? itemId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets metadata editor info for an item.',
      operationId: 'GetMetadataEditorInfo',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["ItemUpdate"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Items/${itemId}/MetadataEditor');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<MetadataEditorInfo, MetadataEditorInfo>($request);
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _albumsItemIdSimilarGet({
    required String? itemId,
    List<String>? excludeArtistIds,
    String? userId,
    int? limit,
    List<Object?>? fields,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets similar items.',
      operationId: 'GetSimilarAlbums',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Library"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Albums/${itemId}/Similar');
    final Map<String, dynamic> $params = <String, dynamic>{
      'excludeArtistIds': excludeArtistIds,
      'userId': userId,
      'limit': limit,
      'fields': fields,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _artistsItemIdSimilarGet({
    required String? itemId,
    List<String>? excludeArtistIds,
    String? userId,
    int? limit,
    List<Object?>? fields,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets similar items.',
      operationId: 'GetSimilarArtists',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Library"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Artists/${itemId}/Similar');
    final Map<String, dynamic> $params = <String, dynamic>{
      'excludeArtistIds': excludeArtistIds,
      'userId': userId,
      'limit': limit,
      'fields': fields,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<List<BaseItemDto>>> _itemsItemIdAncestorsGet({
    required String? itemId,
    String? userId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets all parents of an item.',
      operationId: 'GetAncestors',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Library"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Items/${itemId}/Ancestors');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<List<BaseItemDto>, BaseItemDto>($request);
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _itemsItemIdCriticReviewsGet({
    required String? itemId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets critic review for an item.',
      operationId: 'GetCriticReviews',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Library"],
      deprecated: true,
    ),
  }) {
    final Uri $url = Uri.parse('/Items/${itemId}/CriticReviews');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<String>> _itemsItemIdDownloadGet({
    required String? itemId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Downloads item media.',
      operationId: 'GetDownload',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Library"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Items/${itemId}/Download');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _itemsItemIdFileGet({
    required String? itemId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get the original file of an item.',
      operationId: 'GetFile',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Library"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Items/${itemId}/File');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _itemsItemIdSimilarGet({
    required String? itemId,
    List<String>? excludeArtistIds,
    String? userId,
    int? limit,
    List<Object?>? fields,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets similar items.',
      operationId: 'GetSimilarItems',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Library"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Items/${itemId}/Similar');
    final Map<String, dynamic> $params = <String, dynamic>{
      'excludeArtistIds': excludeArtistIds,
      'userId': userId,
      'limit': limit,
      'fields': fields,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<AllThemeMediaResult>> _itemsItemIdThemeMediaGet({
    required String? itemId,
    String? userId,
    bool? inheritFromParent,
    List<Object?>? sortBy,
    List<Object?>? sortOrder,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get theme songs and videos for an item.',
      operationId: 'GetThemeMedia',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Library"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Items/${itemId}/ThemeMedia');
    final Map<String, dynamic> $params = <String, dynamic>{
      'userId': userId,
      'inheritFromParent': inheritFromParent,
      'sortBy': sortBy,
      'sortOrder': sortOrder,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<AllThemeMediaResult, AllThemeMediaResult>($request);
  }

  @override
  Future<Response<ThemeMediaResult>> _itemsItemIdThemeSongsGet({
    required String? itemId,
    String? userId,
    bool? inheritFromParent,
    List<Object?>? sortBy,
    List<Object?>? sortOrder,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get theme songs for an item.',
      operationId: 'GetThemeSongs',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Library"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Items/${itemId}/ThemeSongs');
    final Map<String, dynamic> $params = <String, dynamic>{
      'userId': userId,
      'inheritFromParent': inheritFromParent,
      'sortBy': sortBy,
      'sortOrder': sortOrder,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<ThemeMediaResult, ThemeMediaResult>($request);
  }

  @override
  Future<Response<ThemeMediaResult>> _itemsItemIdThemeVideosGet({
    required String? itemId,
    String? userId,
    bool? inheritFromParent,
    List<Object?>? sortBy,
    List<Object?>? sortOrder,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get theme videos for an item.',
      operationId: 'GetThemeVideos',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Library"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Items/${itemId}/ThemeVideos');
    final Map<String, dynamic> $params = <String, dynamic>{
      'userId': userId,
      'inheritFromParent': inheritFromParent,
      'sortBy': sortBy,
      'sortOrder': sortOrder,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<ThemeMediaResult, ThemeMediaResult>($request);
  }

  @override
  Future<Response<ItemCounts>> _itemsCountsGet({
    String? userId,
    bool? isFavorite,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get item counts.',
      operationId: 'GetItemCounts',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Library"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Items/Counts');
    final Map<String, dynamic> $params = <String, dynamic>{
      'userId': userId,
      'isFavorite': isFavorite,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<ItemCounts, ItemCounts>($request);
  }

  @override
  Future<Response<LibraryOptionsResultDto>> _librariesAvailableOptionsGet({
    String? libraryContentType,
    bool? isNewLibrary,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets the library options info.',
      operationId: 'GetLibraryOptionsInfo',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Library"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Libraries/AvailableOptions');
    final Map<String, dynamic> $params = <String, dynamic>{
      'libraryContentType': libraryContentType,
      'isNewLibrary': isNewLibrary,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<LibraryOptionsResultDto, LibraryOptionsResultDto>(
      $request,
    );
  }

  @override
  Future<Response<dynamic>> _libraryMediaUpdatedPost({
    required MediaUpdateInfoDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Reports that new movies have been added by an external source.',
      operationId: 'PostUpdatedMedia',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Library"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Library/Media/Updated');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _libraryMediaFoldersGet({
    bool? isHidden,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets all user media folders.',
      operationId: 'GetMediaFolders',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Library"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Library/MediaFolders');
    final Map<String, dynamic> $params = <String, dynamic>{
      'isHidden': isHidden,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<dynamic>> _libraryMoviesAddedPost({
    String? tmdbId,
    String? imdbId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Reports that new movies have been added by an external source.',
      operationId: 'PostAddedMovies',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Library"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Library/Movies/Added');
    final Map<String, dynamic> $params = <String, dynamic>{
      'tmdbId': tmdbId,
      'imdbId': imdbId,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _libraryMoviesUpdatedPost({
    String? tmdbId,
    String? imdbId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Reports that new movies have been added by an external source.',
      operationId: 'PostUpdatedMovies',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Library"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Library/Movies/Updated');
    final Map<String, dynamic> $params = <String, dynamic>{
      'tmdbId': tmdbId,
      'imdbId': imdbId,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<String>>> _libraryPhysicalPathsGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets a list of physical paths from virtual folders.',
      operationId: 'GetPhysicalPaths',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Library"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Library/PhysicalPaths');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<String>, String>($request);
  }

  @override
  Future<Response<dynamic>> _libraryRefreshPost({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Starts a library scan.',
      operationId: 'RefreshLibrary',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Library"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Library/Refresh');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _librarySeriesAddedPost({
    String? tvdbId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary:
          'Reports that new episodes of a series have been added by an external source.',
      operationId: 'PostAddedSeries',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Library"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Library/Series/Added');
    final Map<String, dynamic> $params = <String, dynamic>{'tvdbId': tvdbId};
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _librarySeriesUpdatedPost({
    String? tvdbId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary:
          'Reports that new episodes of a series have been added by an external source.',
      operationId: 'PostUpdatedSeries',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Library"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Library/Series/Updated');
    final Map<String, dynamic> $params = <String, dynamic>{'tvdbId': tvdbId};
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _moviesItemIdSimilarGet({
    required String? itemId,
    List<String>? excludeArtistIds,
    String? userId,
    int? limit,
    List<Object?>? fields,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets similar items.',
      operationId: 'GetSimilarMovies',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Library"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Movies/${itemId}/Similar');
    final Map<String, dynamic> $params = <String, dynamic>{
      'excludeArtistIds': excludeArtistIds,
      'userId': userId,
      'limit': limit,
      'fields': fields,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _showsItemIdSimilarGet({
    required String? itemId,
    List<String>? excludeArtistIds,
    String? userId,
    int? limit,
    List<Object?>? fields,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets similar items.',
      operationId: 'GetSimilarShows',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Library"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Shows/${itemId}/Similar');
    final Map<String, dynamic> $params = <String, dynamic>{
      'excludeArtistIds': excludeArtistIds,
      'userId': userId,
      'limit': limit,
      'fields': fields,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _trailersItemIdSimilarGet({
    required String? itemId,
    List<String>? excludeArtistIds,
    String? userId,
    int? limit,
    List<Object?>? fields,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets similar items.',
      operationId: 'GetSimilarTrailers',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Library"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Trailers/${itemId}/Similar');
    final Map<String, dynamic> $params = <String, dynamic>{
      'excludeArtistIds': excludeArtistIds,
      'userId': userId,
      'limit': limit,
      'fields': fields,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<List<VirtualFolderInfo>>> _libraryVirtualFoldersGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets all virtual folders.',
      operationId: 'GetVirtualFolders',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LibraryStructure"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Library/VirtualFolders');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<VirtualFolderInfo>, VirtualFolderInfo>($request);
  }

  @override
  Future<Response<dynamic>> _libraryVirtualFoldersPost({
    String? name,
    String? collectionType,
    List<String>? paths,
    bool? refreshLibrary,
    required AddVirtualFolderDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Adds a virtual folder.',
      operationId: 'AddVirtualFolder',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LibraryStructure"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Library/VirtualFolders');
    final Map<String, dynamic> $params = <String, dynamic>{
      'name': name,
      'collectionType': collectionType,
      'paths': paths,
      'refreshLibrary': refreshLibrary,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _libraryVirtualFoldersDelete({
    String? name,
    bool? refreshLibrary,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Removes a virtual folder.',
      operationId: 'RemoveVirtualFolder',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LibraryStructure"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Library/VirtualFolders');
    final Map<String, dynamic> $params = <String, dynamic>{
      'name': name,
      'refreshLibrary': refreshLibrary,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _libraryVirtualFoldersLibraryOptionsPost({
    required UpdateLibraryOptionsDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Update library options.',
      operationId: 'UpdateLibraryOptions',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LibraryStructure"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Library/VirtualFolders/LibraryOptions');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _libraryVirtualFoldersNamePost({
    String? name,
    String? newName,
    bool? refreshLibrary,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Renames a virtual folder.',
      operationId: 'RenameVirtualFolder',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LibraryStructure"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Library/VirtualFolders/Name');
    final Map<String, dynamic> $params = <String, dynamic>{
      'name': name,
      'newName': newName,
      'refreshLibrary': refreshLibrary,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _libraryVirtualFoldersPathsPost({
    bool? refreshLibrary,
    required MediaPathDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Add a media path to a library.',
      operationId: 'AddMediaPath',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LibraryStructure"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Library/VirtualFolders/Paths');
    final Map<String, dynamic> $params = <String, dynamic>{
      'refreshLibrary': refreshLibrary,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _libraryVirtualFoldersPathsDelete({
    String? name,
    String? path,
    bool? refreshLibrary,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Remove a media path.',
      operationId: 'RemoveMediaPath',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LibraryStructure"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Library/VirtualFolders/Paths');
    final Map<String, dynamic> $params = <String, dynamic>{
      'name': name,
      'path': path,
      'refreshLibrary': refreshLibrary,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _libraryVirtualFoldersPathsUpdatePost({
    required UpdateMediaPathRequestDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Updates a media path.',
      operationId: 'UpdateMediaPath',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LibraryStructure"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Library/VirtualFolders/Paths/Update');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<ChannelMappingOptionsDto>> _liveTvChannelMappingOptionsGet({
    String? providerId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get channel mapping options.',
      operationId: 'GetChannelMappingOptions',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LiveTv"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/LiveTv/ChannelMappingOptions');
    final Map<String, dynamic> $params = <String, dynamic>{
      'providerId': providerId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<ChannelMappingOptionsDto, ChannelMappingOptionsDto>(
      $request,
    );
  }

  @override
  Future<Response<TunerChannelMapping>> _liveTvChannelMappingsPost({
    required SetChannelMappingDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Set channel mappings.',
      operationId: 'SetChannelMapping',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LiveTv"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/LiveTv/ChannelMappings');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<TunerChannelMapping, TunerChannelMapping>($request);
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _liveTvChannelsGet({
    String? type,
    String? userId,
    int? startIndex,
    bool? isMovie,
    bool? isSeries,
    bool? isNews,
    bool? isKids,
    bool? isSports,
    int? limit,
    bool? isFavorite,
    bool? isLiked,
    bool? isDisliked,
    bool? enableImages,
    int? imageTypeLimit,
    List<Object?>? enableImageTypes,
    List<Object?>? fields,
    bool? enableUserData,
    List<Object?>? sortBy,
    String? sortOrder,
    bool? enableFavoriteSorting,
    bool? addCurrentProgram,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets available live tv channels.',
      operationId: 'GetLiveTvChannels',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LiveTv"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/LiveTv/Channels');
    final Map<String, dynamic> $params = <String, dynamic>{
      'type': type,
      'userId': userId,
      'startIndex': startIndex,
      'isMovie': isMovie,
      'isSeries': isSeries,
      'isNews': isNews,
      'isKids': isKids,
      'isSports': isSports,
      'limit': limit,
      'isFavorite': isFavorite,
      'isLiked': isLiked,
      'isDisliked': isDisliked,
      'enableImages': enableImages,
      'imageTypeLimit': imageTypeLimit,
      'enableImageTypes': enableImageTypes,
      'fields': fields,
      'enableUserData': enableUserData,
      'sortBy': sortBy,
      'sortOrder': sortOrder,
      'enableFavoriteSorting': enableFavoriteSorting,
      'addCurrentProgram': addCurrentProgram,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<BaseItemDto>> _liveTvChannelsChannelIdGet({
    required String? channelId,
    String? userId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets a live tv channel.',
      operationId: 'GetChannel',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LiveTv"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/LiveTv/Channels/${channelId}');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDto, BaseItemDto>($request);
  }

  @override
  Future<Response<GuideInfo>> _liveTvGuideInfoGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get guide info.',
      operationId: 'GetGuideInfo',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LiveTv"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/LiveTv/GuideInfo');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<GuideInfo, GuideInfo>($request);
  }

  @override
  Future<Response<LiveTvInfo>> _liveTvInfoGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets available live tv services.',
      operationId: 'GetLiveTvInfo',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LiveTv"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/LiveTv/Info');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<LiveTvInfo, LiveTvInfo>($request);
  }

  @override
  Future<Response<ListingsProviderInfo>> _liveTvListingProvidersPost({
    String? pw,
    bool? validateListings,
    bool? validateLogin,
    required ListingsProviderInfo? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Adds a listings provider.',
      operationId: 'AddListingProvider',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LiveTv"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/LiveTv/ListingProviders');
    final Map<String, dynamic> $params = <String, dynamic>{
      'pw': pw,
      'validateListings': validateListings,
      'validateLogin': validateLogin,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<ListingsProviderInfo, ListingsProviderInfo>($request);
  }

  @override
  Future<Response<dynamic>> _liveTvListingProvidersDelete({
    String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Delete listing provider.',
      operationId: 'DeleteListingProvider',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LiveTv"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/LiveTv/ListingProviders');
    final Map<String, dynamic> $params = <String, dynamic>{'id': id};
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<ListingsProviderInfo>> _liveTvListingProvidersDefaultGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets default listings provider info.',
      operationId: 'GetDefaultListingProvider',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LiveTv"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/LiveTv/ListingProviders/Default');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<ListingsProviderInfo, ListingsProviderInfo>($request);
  }

  @override
  Future<Response<List<NameIdPair>>> _liveTvListingProvidersLineupsGet({
    String? id,
    String? type,
    String? location,
    String? country,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets available lineups.',
      operationId: 'GetLineups',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LiveTv"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/LiveTv/ListingProviders/Lineups');
    final Map<String, dynamic> $params = <String, dynamic>{
      'id': id,
      'type': type,
      'location': location,
      'country': country,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<List<NameIdPair>, NameIdPair>($request);
  }

  @override
  Future<Response<String>> _liveTvListingProvidersSchedulesDirectCountriesGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets available countries.',
      operationId: 'GetSchedulesDirectCountries',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LiveTv"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse(
      '/LiveTv/ListingProviders/SchedulesDirect/Countries',
    );
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _liveTvLiveRecordingsRecordingIdStreamGet({
    required String? recordingId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets a live tv recording stream.',
      operationId: 'GetLiveRecordingFile',
      consumes: [],
      produces: [],
      security: [],
      tags: ["LiveTv"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/LiveTv/LiveRecordings/${recordingId}/stream');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _liveTvLiveStreamFilesStreamIdStreamContainerGet({
    required String? streamId,
    required String? container,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets a live tv channel stream.',
      operationId: 'GetLiveStreamFile',
      consumes: [],
      produces: [],
      security: [],
      tags: ["LiveTv"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse(
      '/LiveTv/LiveStreamFiles/${streamId}/stream.${container}',
    );
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _liveTvProgramsGet({
    List<String>? channelIds,
    String? userId,
    DateTime? minStartDate,
    bool? hasAired,
    bool? isAiring,
    DateTime? maxStartDate,
    DateTime? minEndDate,
    DateTime? maxEndDate,
    bool? isMovie,
    bool? isSeries,
    bool? isNews,
    bool? isKids,
    bool? isSports,
    int? startIndex,
    int? limit,
    List<Object?>? sortBy,
    List<Object?>? sortOrder,
    List<String>? genres,
    List<String>? genreIds,
    bool? enableImages,
    int? imageTypeLimit,
    List<Object?>? enableImageTypes,
    bool? enableUserData,
    String? seriesTimerId,
    String? librarySeriesId,
    List<Object?>? fields,
    bool? enableTotalRecordCount,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets available live tv epgs.',
      operationId: 'GetLiveTvPrograms',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LiveTv"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/LiveTv/Programs');
    final Map<String, dynamic> $params = <String, dynamic>{
      'channelIds': channelIds,
      'userId': userId,
      'minStartDate': minStartDate,
      'hasAired': hasAired,
      'isAiring': isAiring,
      'maxStartDate': maxStartDate,
      'minEndDate': minEndDate,
      'maxEndDate': maxEndDate,
      'isMovie': isMovie,
      'isSeries': isSeries,
      'isNews': isNews,
      'isKids': isKids,
      'isSports': isSports,
      'startIndex': startIndex,
      'limit': limit,
      'sortBy': sortBy,
      'sortOrder': sortOrder,
      'genres': genres,
      'genreIds': genreIds,
      'enableImages': enableImages,
      'imageTypeLimit': imageTypeLimit,
      'enableImageTypes': enableImageTypes,
      'enableUserData': enableUserData,
      'seriesTimerId': seriesTimerId,
      'librarySeriesId': librarySeriesId,
      'fields': fields,
      'enableTotalRecordCount': enableTotalRecordCount,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _liveTvProgramsPost({
    required GetProgramsDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets available live tv epgs.',
      operationId: 'GetPrograms',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LiveTv"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/LiveTv/Programs');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<BaseItemDto>> _liveTvProgramsProgramIdGet({
    required String? programId,
    String? userId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets a live tv program.',
      operationId: 'GetProgram',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LiveTv"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/LiveTv/Programs/${programId}');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDto, BaseItemDto>($request);
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _liveTvProgramsRecommendedGet({
    String? userId,
    int? startIndex,
    int? limit,
    bool? isAiring,
    bool? hasAired,
    bool? isSeries,
    bool? isMovie,
    bool? isNews,
    bool? isKids,
    bool? isSports,
    bool? enableImages,
    int? imageTypeLimit,
    List<Object?>? enableImageTypes,
    List<String>? genreIds,
    List<Object?>? fields,
    bool? enableUserData,
    bool? enableTotalRecordCount,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets recommended live tv epgs.',
      operationId: 'GetRecommendedPrograms',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LiveTv"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/LiveTv/Programs/Recommended');
    final Map<String, dynamic> $params = <String, dynamic>{
      'userId': userId,
      'startIndex': startIndex,
      'limit': limit,
      'isAiring': isAiring,
      'hasAired': hasAired,
      'isSeries': isSeries,
      'isMovie': isMovie,
      'isNews': isNews,
      'isKids': isKids,
      'isSports': isSports,
      'enableImages': enableImages,
      'imageTypeLimit': imageTypeLimit,
      'enableImageTypes': enableImageTypes,
      'genreIds': genreIds,
      'fields': fields,
      'enableUserData': enableUserData,
      'enableTotalRecordCount': enableTotalRecordCount,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _liveTvRecordingsGet({
    String? channelId,
    String? userId,
    int? startIndex,
    int? limit,
    String? status,
    bool? isInProgress,
    String? seriesTimerId,
    bool? enableImages,
    int? imageTypeLimit,
    List<Object?>? enableImageTypes,
    List<Object?>? fields,
    bool? enableUserData,
    bool? isMovie,
    bool? isSeries,
    bool? isKids,
    bool? isSports,
    bool? isNews,
    bool? isLibraryItem,
    bool? enableTotalRecordCount,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets live tv recordings.',
      operationId: 'GetRecordings',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LiveTv"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/LiveTv/Recordings');
    final Map<String, dynamic> $params = <String, dynamic>{
      'channelId': channelId,
      'userId': userId,
      'startIndex': startIndex,
      'limit': limit,
      'status': status,
      'isInProgress': isInProgress,
      'seriesTimerId': seriesTimerId,
      'enableImages': enableImages,
      'imageTypeLimit': imageTypeLimit,
      'enableImageTypes': enableImageTypes,
      'fields': fields,
      'enableUserData': enableUserData,
      'isMovie': isMovie,
      'isSeries': isSeries,
      'isKids': isKids,
      'isSports': isSports,
      'isNews': isNews,
      'isLibraryItem': isLibraryItem,
      'enableTotalRecordCount': enableTotalRecordCount,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<BaseItemDto>> _liveTvRecordingsRecordingIdGet({
    required String? recordingId,
    String? userId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets a live tv recording.',
      operationId: 'GetRecording',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LiveTv"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/LiveTv/Recordings/${recordingId}');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDto, BaseItemDto>($request);
  }

  @override
  Future<Response<dynamic>> _liveTvRecordingsRecordingIdDelete({
    required String? recordingId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Deletes a live tv recording.',
      operationId: 'DeleteRecording',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LiveTv"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/LiveTv/Recordings/${recordingId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _liveTvRecordingsFoldersGet({
    String? userId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets recording folders.',
      operationId: 'GetRecordingFolders',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LiveTv"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/LiveTv/Recordings/Folders');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _liveTvRecordingsGroupsGet({
    String? userId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets live tv recording groups.',
      operationId: 'GetRecordingGroups',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LiveTv"],
      deprecated: true,
    ),
  }) {
    final Uri $url = Uri.parse('/LiveTv/Recordings/Groups');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<dynamic>> _liveTvRecordingsGroupsGroupIdGet({
    required String? groupId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get recording group.',
      operationId: 'GetRecordingGroup',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LiveTv"],
      deprecated: true,
    ),
  }) {
    final Uri $url = Uri.parse('/LiveTv/Recordings/Groups/${groupId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _liveTvRecordingsSeriesGet({
    String? channelId,
    String? userId,
    String? groupId,
    int? startIndex,
    int? limit,
    String? status,
    bool? isInProgress,
    String? seriesTimerId,
    bool? enableImages,
    int? imageTypeLimit,
    List<Object?>? enableImageTypes,
    List<Object?>? fields,
    bool? enableUserData,
    bool? enableTotalRecordCount,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets live tv recording series.',
      operationId: 'GetRecordingsSeries',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LiveTv"],
      deprecated: true,
    ),
  }) {
    final Uri $url = Uri.parse('/LiveTv/Recordings/Series');
    final Map<String, dynamic> $params = <String, dynamic>{
      'channelId': channelId,
      'userId': userId,
      'groupId': groupId,
      'startIndex': startIndex,
      'limit': limit,
      'status': status,
      'isInProgress': isInProgress,
      'seriesTimerId': seriesTimerId,
      'enableImages': enableImages,
      'imageTypeLimit': imageTypeLimit,
      'enableImageTypes': enableImageTypes,
      'fields': fields,
      'enableUserData': enableUserData,
      'enableTotalRecordCount': enableTotalRecordCount,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<SeriesTimerInfoDtoQueryResult>> _liveTvSeriesTimersGet({
    String? sortBy,
    String? sortOrder,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets live tv series timers.',
      operationId: 'GetSeriesTimers',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LiveTv"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/LiveTv/SeriesTimers');
    final Map<String, dynamic> $params = <String, dynamic>{
      'sortBy': sortBy,
      'sortOrder': sortOrder,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client
        .send<SeriesTimerInfoDtoQueryResult, SeriesTimerInfoDtoQueryResult>(
          $request,
        );
  }

  @override
  Future<Response<dynamic>> _liveTvSeriesTimersPost({
    required SeriesTimerInfoDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Creates a live tv series timer.',
      operationId: 'CreateSeriesTimer',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LiveTv"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/LiveTv/SeriesTimers');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<SeriesTimerInfoDto>> _liveTvSeriesTimersTimerIdGet({
    required String? timerId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets a live tv series timer.',
      operationId: 'GetSeriesTimer',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LiveTv"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/LiveTv/SeriesTimers/${timerId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<SeriesTimerInfoDto, SeriesTimerInfoDto>($request);
  }

  @override
  Future<Response<dynamic>> _liveTvSeriesTimersTimerIdDelete({
    required String? timerId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Cancels a live tv series timer.',
      operationId: 'CancelSeriesTimer',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LiveTv"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/LiveTv/SeriesTimers/${timerId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _liveTvSeriesTimersTimerIdPost({
    required String? timerId,
    required SeriesTimerInfoDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Updates a live tv series timer.',
      operationId: 'UpdateSeriesTimer',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LiveTv"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/LiveTv/SeriesTimers/${timerId}');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<TimerInfoDtoQueryResult>> _liveTvTimersGet({
    String? channelId,
    String? seriesTimerId,
    bool? isActive,
    bool? isScheduled,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets the live tv timers.',
      operationId: 'GetTimers',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LiveTv"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/LiveTv/Timers');
    final Map<String, dynamic> $params = <String, dynamic>{
      'channelId': channelId,
      'seriesTimerId': seriesTimerId,
      'isActive': isActive,
      'isScheduled': isScheduled,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<TimerInfoDtoQueryResult, TimerInfoDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<dynamic>> _liveTvTimersPost({
    required TimerInfoDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Creates a live tv timer.',
      operationId: 'CreateTimer',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LiveTv"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/LiveTv/Timers');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<TimerInfoDto>> _liveTvTimersTimerIdGet({
    required String? timerId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets a timer.',
      operationId: 'GetTimer',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LiveTv"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/LiveTv/Timers/${timerId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<TimerInfoDto, TimerInfoDto>($request);
  }

  @override
  Future<Response<dynamic>> _liveTvTimersTimerIdDelete({
    required String? timerId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Cancels a live tv timer.',
      operationId: 'CancelTimer',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LiveTv"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/LiveTv/Timers/${timerId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _liveTvTimersTimerIdPost({
    required String? timerId,
    required TimerInfoDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Updates a live tv timer.',
      operationId: 'UpdateTimer',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LiveTv"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/LiveTv/Timers/${timerId}');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<SeriesTimerInfoDto>> _liveTvTimersDefaultsGet({
    String? programId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets the default values for a new timer.',
      operationId: 'GetDefaultTimer',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LiveTv"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/LiveTv/Timers/Defaults');
    final Map<String, dynamic> $params = <String, dynamic>{
      'programId': programId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<SeriesTimerInfoDto, SeriesTimerInfoDto>($request);
  }

  @override
  Future<Response<TunerHostInfo>> _liveTvTunerHostsPost({
    required TunerHostInfo? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Adds a tuner host.',
      operationId: 'AddTunerHost',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LiveTv"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/LiveTv/TunerHosts');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<TunerHostInfo, TunerHostInfo>($request);
  }

  @override
  Future<Response<dynamic>> _liveTvTunerHostsDelete({
    String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Deletes a tuner host.',
      operationId: 'DeleteTunerHost',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LiveTv"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/LiveTv/TunerHosts');
    final Map<String, dynamic> $params = <String, dynamic>{'id': id};
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<NameIdPair>>> _liveTvTunerHostsTypesGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get tuner host types.',
      operationId: 'GetTunerHostTypes',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LiveTv"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/LiveTv/TunerHosts/Types');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<NameIdPair>, NameIdPair>($request);
  }

  @override
  Future<Response<dynamic>> _liveTvTunersTunerIdResetPost({
    required String? tunerId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Resets a tv tuner.',
      operationId: 'ResetTuner',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LiveTv"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/LiveTv/Tuners/${tunerId}/Reset');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<TunerHostInfo>>> _liveTvTunersDiscoverGet({
    bool? newDevicesOnly,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Discover tuners.',
      operationId: 'DiscoverTuners',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LiveTv"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/LiveTv/Tuners/Discover');
    final Map<String, dynamic> $params = <String, dynamic>{
      'newDevicesOnly': newDevicesOnly,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<List<TunerHostInfo>, TunerHostInfo>($request);
  }

  @override
  Future<Response<List<TunerHostInfo>>> _liveTvTunersDiscvoverGet({
    bool? newDevicesOnly,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Discover tuners.',
      operationId: 'DiscvoverTuners',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["LiveTv"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/LiveTv/Tuners/Discvover');
    final Map<String, dynamic> $params = <String, dynamic>{
      'newDevicesOnly': newDevicesOnly,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<List<TunerHostInfo>, TunerHostInfo>($request);
  }

  @override
  Future<Response<List<CountryInfo>>> _localizationCountriesGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets known countries.',
      operationId: 'GetCountries',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Localization"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Localization/Countries');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<CountryInfo>, CountryInfo>($request);
  }

  @override
  Future<Response<List<CultureDto>>> _localizationCulturesGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets known cultures.',
      operationId: 'GetCultures',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Localization"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Localization/Cultures');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<CultureDto>, CultureDto>($request);
  }

  @override
  Future<Response<List<LocalizationOption>>> _localizationOptionsGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets localization options.',
      operationId: 'GetLocalizationOptions',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Localization"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Localization/Options');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<LocalizationOption>, LocalizationOption>($request);
  }

  @override
  Future<Response<List<ParentalRating>>> _localizationParentalRatingsGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets known parental ratings.',
      operationId: 'GetParentalRatings',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Localization"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Localization/ParentalRatings');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<ParentalRating>, ParentalRating>($request);
  }

  @override
  Future<Response<LyricDto>> _audioItemIdLyricsGet({
    required String? itemId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets an item\'s lyrics.',
      operationId: 'GetLyrics',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Lyrics"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Audio/${itemId}/Lyrics');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<LyricDto, LyricDto>($request);
  }

  @override
  Future<Response<LyricDto>> _audioItemIdLyricsPost({
    required String? itemId,
    required String? fileName,
    required Object? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Upload an external lyric file.',
      operationId: 'UploadLyrics',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Lyrics"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Audio/${itemId}/Lyrics');
    final Map<String, dynamic> $params = <String, dynamic>{
      'fileName': fileName,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<LyricDto, LyricDto>($request);
  }

  @override
  Future<Response<dynamic>> _audioItemIdLyricsDelete({
    required String? itemId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Deletes an external lyric file.',
      operationId: 'DeleteLyrics',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Lyrics"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Audio/${itemId}/Lyrics');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<RemoteLyricInfoDto>>> _audioItemIdRemoteSearchLyricsGet({
    required String? itemId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Search remote lyrics.',
      operationId: 'SearchRemoteLyrics',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Lyrics"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Audio/${itemId}/RemoteSearch/Lyrics');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<RemoteLyricInfoDto>, RemoteLyricInfoDto>($request);
  }

  @override
  Future<Response<LyricDto>> _audioItemIdRemoteSearchLyricsLyricIdPost({
    required String? itemId,
    required String? lyricId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Downloads a remote lyric.',
      operationId: 'DownloadRemoteLyrics',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Lyrics"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse(
      '/Audio/${itemId}/RemoteSearch/Lyrics/${lyricId}',
    );
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<LyricDto, LyricDto>($request);
  }

  @override
  Future<Response<LyricDto>> _providersLyricsLyricIdGet({
    required String? lyricId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets the remote lyrics.',
      operationId: 'GetRemoteLyrics',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Lyrics"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Providers/Lyrics/${lyricId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<LyricDto, LyricDto>($request);
  }

  @override
  Future<Response<PlaybackInfoResponse>> _itemsItemIdPlaybackInfoGet({
    required String? itemId,
    String? userId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets live playback media info for an item.',
      operationId: 'GetPlaybackInfo',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["MediaInfo"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Items/${itemId}/PlaybackInfo');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<PlaybackInfoResponse, PlaybackInfoResponse>($request);
  }

  @override
  Future<Response<PlaybackInfoResponse>> _itemsItemIdPlaybackInfoPost({
    required String? itemId,
    String? userId,
    int? maxStreamingBitrate,
    int? startTimeTicks,
    int? audioStreamIndex,
    int? subtitleStreamIndex,
    int? maxAudioChannels,
    String? mediaSourceId,
    String? liveStreamId,
    bool? autoOpenLiveStream,
    bool? enableDirectPlay,
    bool? enableDirectStream,
    bool? enableTranscoding,
    bool? allowVideoStreamCopy,
    bool? allowAudioStreamCopy,
    required PlaybackInfoDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''For backwards compatibility parameters can be sent via Query or Body, with Query having higher precedence.
Query parameters are obsolete.''',
      summary: 'Gets live playback media info for an item.',
      operationId: 'GetPostedPlaybackInfo',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["MediaInfo"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Items/${itemId}/PlaybackInfo');
    final Map<String, dynamic> $params = <String, dynamic>{
      'userId': userId,
      'maxStreamingBitrate': maxStreamingBitrate,
      'startTimeTicks': startTimeTicks,
      'audioStreamIndex': audioStreamIndex,
      'subtitleStreamIndex': subtitleStreamIndex,
      'maxAudioChannels': maxAudioChannels,
      'mediaSourceId': mediaSourceId,
      'liveStreamId': liveStreamId,
      'autoOpenLiveStream': autoOpenLiveStream,
      'enableDirectPlay': enableDirectPlay,
      'enableDirectStream': enableDirectStream,
      'enableTranscoding': enableTranscoding,
      'allowVideoStreamCopy': allowVideoStreamCopy,
      'allowAudioStreamCopy': allowAudioStreamCopy,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<PlaybackInfoResponse, PlaybackInfoResponse>($request);
  }

  @override
  Future<Response<dynamic>> _liveStreamsClosePost({
    required String? liveStreamId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Closes a media source.',
      operationId: 'CloseLiveStream',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["MediaInfo"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/LiveStreams/Close');
    final Map<String, dynamic> $params = <String, dynamic>{
      'liveStreamId': liveStreamId,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<LiveStreamResponse>> _liveStreamsOpenPost({
    String? openToken,
    String? userId,
    String? playSessionId,
    int? maxStreamingBitrate,
    int? startTimeTicks,
    int? audioStreamIndex,
    int? subtitleStreamIndex,
    int? maxAudioChannels,
    String? itemId,
    bool? enableDirectPlay,
    bool? enableDirectStream,
    bool? alwaysBurnInSubtitleWhenTranscoding,
    required OpenLiveStreamDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Opens a media source.',
      operationId: 'OpenLiveStream',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["MediaInfo"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/LiveStreams/Open');
    final Map<String, dynamic> $params = <String, dynamic>{
      'openToken': openToken,
      'userId': userId,
      'playSessionId': playSessionId,
      'maxStreamingBitrate': maxStreamingBitrate,
      'startTimeTicks': startTimeTicks,
      'audioStreamIndex': audioStreamIndex,
      'subtitleStreamIndex': subtitleStreamIndex,
      'maxAudioChannels': maxAudioChannels,
      'itemId': itemId,
      'enableDirectPlay': enableDirectPlay,
      'enableDirectStream': enableDirectStream,
      'alwaysBurnInSubtitleWhenTranscoding':
          alwaysBurnInSubtitleWhenTranscoding,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<LiveStreamResponse, LiveStreamResponse>($request);
  }

  @override
  Future<Response<String>> _playbackBitrateTestGet({
    int? size,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Tests the network with a request with the size of the bitrate.',
      operationId: 'GetBitrateTestBytes',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["MediaInfo"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Playback/BitrateTest');
    final Map<String, dynamic> $params = <String, dynamic>{'size': size};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<MediaSegmentDtoQueryResult>> _mediaSegmentsItemIdGet({
    required String? itemId,
    List<Object?>? includeSegmentTypes,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets all media segments based on an itemId.',
      operationId: 'GetItemSegments',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["MediaSegments"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/MediaSegments/${itemId}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'includeSegmentTypes': includeSegmentTypes,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<MediaSegmentDtoQueryResult, MediaSegmentDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<List<RecommendationDto>>> _moviesRecommendationsGet({
    String? userId,
    String? parentId,
    List<Object?>? fields,
    int? categoryLimit,
    int? itemLimit,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets movie recommendations.',
      operationId: 'GetMovieRecommendations',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Movies"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Movies/Recommendations');
    final Map<String, dynamic> $params = <String, dynamic>{
      'userId': userId,
      'parentId': parentId,
      'fields': fields,
      'categoryLimit': categoryLimit,
      'itemLimit': itemLimit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<List<RecommendationDto>, RecommendationDto>($request);
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _musicGenresGet({
    int? startIndex,
    int? limit,
    String? searchTerm,
    String? parentId,
    List<Object?>? fields,
    List<Object?>? excludeItemTypes,
    List<Object?>? includeItemTypes,
    bool? isFavorite,
    int? imageTypeLimit,
    List<Object?>? enableImageTypes,
    String? userId,
    String? nameStartsWithOrGreater,
    String? nameStartsWith,
    String? nameLessThan,
    List<Object?>? sortBy,
    List<Object?>? sortOrder,
    bool? enableImages,
    bool? enableTotalRecordCount,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary:
          'Gets all music genres from a given item, folder, or the entire library.',
      operationId: 'GetMusicGenres',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["MusicGenres"],
      deprecated: true,
    ),
  }) {
    final Uri $url = Uri.parse('/MusicGenres');
    final Map<String, dynamic> $params = <String, dynamic>{
      'startIndex': startIndex,
      'limit': limit,
      'searchTerm': searchTerm,
      'parentId': parentId,
      'fields': fields,
      'excludeItemTypes': excludeItemTypes,
      'includeItemTypes': includeItemTypes,
      'isFavorite': isFavorite,
      'imageTypeLimit': imageTypeLimit,
      'enableImageTypes': enableImageTypes,
      'userId': userId,
      'nameStartsWithOrGreater': nameStartsWithOrGreater,
      'nameStartsWith': nameStartsWith,
      'nameLessThan': nameLessThan,
      'sortBy': sortBy,
      'sortOrder': sortOrder,
      'enableImages': enableImages,
      'enableTotalRecordCount': enableTotalRecordCount,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<BaseItemDto>> _musicGenresGenreNameGet({
    required String? genreName,
    String? userId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets a music genre, by name.',
      operationId: 'GetMusicGenre',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["MusicGenres"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/MusicGenres/${genreName}');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDto, BaseItemDto>($request);
  }

  @override
  Future<Response<dynamic>> _jellyfinPluginOpenSubtitlesValidateLoginInfoPost({
    required LoginInfoInput? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: '',
      operationId: 'ValidateLoginInfo',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["OpenSubtitles"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse(
      '/Jellyfin.Plugin.OpenSubtitles/ValidateLoginInfo',
    );
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<PackageInfo>>> _packagesGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets available packages.',
      operationId: 'GetPackages',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Package"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Packages');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<PackageInfo>, PackageInfo>($request);
  }

  @override
  Future<Response<PackageInfo>> _packagesNameGet({
    required String? name,
    String? assemblyGuid,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets a package by name or assembly GUID.',
      operationId: 'GetPackageInfo',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Package"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Packages/${name}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'assemblyGuid': assemblyGuid,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<PackageInfo, PackageInfo>($request);
  }

  @override
  Future<Response<dynamic>> _packagesInstalledNamePost({
    required String? name,
    String? assemblyGuid,
    String? version,
    String? repositoryUrl,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Installs a package.',
      operationId: 'InstallPackage',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Package"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Packages/Installed/${name}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'assemblyGuid': assemblyGuid,
      'version': version,
      'repositoryUrl': repositoryUrl,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _packagesInstallingPackageIdDelete({
    required String? packageId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Cancels a package installation.',
      operationId: 'CancelPackageInstallation',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Package"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Packages/Installing/${packageId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<RepositoryInfo>>> _repositoriesGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets all package repositories.',
      operationId: 'GetRepositories',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Package"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Repositories');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<RepositoryInfo>, RepositoryInfo>($request);
  }

  @override
  Future<Response<dynamic>> _repositoriesPost({
    required List<RepositoryInfo>? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Sets the enabled and existing package repositories.',
      operationId: 'SetRepositories',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Package"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Repositories');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _personsGet({
    int? limit,
    String? searchTerm,
    List<Object?>? fields,
    List<Object?>? filters,
    bool? isFavorite,
    bool? enableUserData,
    int? imageTypeLimit,
    List<Object?>? enableImageTypes,
    List<String>? excludePersonTypes,
    List<String>? personTypes,
    String? appearsInItemId,
    String? userId,
    bool? enableImages,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets all persons.',
      operationId: 'GetPersons',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Persons"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Persons');
    final Map<String, dynamic> $params = <String, dynamic>{
      'limit': limit,
      'searchTerm': searchTerm,
      'fields': fields,
      'filters': filters,
      'isFavorite': isFavorite,
      'enableUserData': enableUserData,
      'imageTypeLimit': imageTypeLimit,
      'enableImageTypes': enableImageTypes,
      'excludePersonTypes': excludePersonTypes,
      'personTypes': personTypes,
      'appearsInItemId': appearsInItemId,
      'userId': userId,
      'enableImages': enableImages,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<BaseItemDto>> _personsNameGet({
    required String? name,
    String? userId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get person by name.',
      operationId: 'GetPerson',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Persons"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Persons/${name}');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDto, BaseItemDto>($request);
  }

  @override
  Future<Response<dynamic>> _userUsageStatsBreakdownTypeBreakdownReportGet({
    required String? breakdownType,
    int? days,
    DateTime? endDate,
    num? timezoneOffset,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: '',
      operationId: 'GetBreakdownReport',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["PlaybackReportingActivity"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse(
      '/user_usage_stats/${breakdownType}/BreakdownReport',
    );
    final Map<String, dynamic> $params = <String, dynamic>{
      'days': days,
      'endDate': endDate,
      'timezoneOffset': timezoneOffset,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _userUsageStatsUserIdDateGetItemsGet({
    required String? userId,
    required String? date,
    String? filter,
    num? timezoneOffset,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: '',
      operationId: 'GetUserReportData',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["PlaybackReportingActivity"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/user_usage_stats/${userId}/${date}/GetItems');
    final Map<String, dynamic> $params = <String, dynamic>{
      'filter': filter,
      'timezoneOffset': timezoneOffset,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _userUsageStatsDurationHistogramReportGet({
    int? days,
    DateTime? endDate,
    String? filter,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: '',
      operationId: 'GetDurationHistogramReport',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["PlaybackReportingActivity"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/user_usage_stats/DurationHistogramReport');
    final Map<String, dynamic> $params = <String, dynamic>{
      'days': days,
      'endDate': endDate,
      'filter': filter,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _userUsageStatsGetTvShowsReportGet({
    int? days,
    DateTime? endDate,
    num? timezoneOffset,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: '',
      operationId: 'GetTvShowsReport',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["PlaybackReportingActivity"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/user_usage_stats/GetTvShowsReport');
    final Map<String, dynamic> $params = <String, dynamic>{
      'days': days,
      'endDate': endDate,
      'timezoneOffset': timezoneOffset,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _userUsageStatsHourlyReportGet({
    int? days,
    DateTime? endDate,
    String? filter,
    num? timezoneOffset,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: '',
      operationId: 'GetHourlyReport',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["PlaybackReportingActivity"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/user_usage_stats/HourlyReport');
    final Map<String, dynamic> $params = <String, dynamic>{
      'days': days,
      'endDate': endDate,
      'filter': filter,
      'timezoneOffset': timezoneOffset,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<String>>> _userUsageStatsLoadBackupGet({
    String? backupFilePath,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: '',
      operationId: 'LoadBackup',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["PlaybackReportingActivity"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/user_usage_stats/load_backup');
    final Map<String, dynamic> $params = <String, dynamic>{
      'backupFilePath': backupFilePath,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<List<String>, String>($request);
  }

  @override
  Future<Response<dynamic>> _userUsageStatsMoviesReportGet({
    int? days,
    DateTime? endDate,
    num? timezoneOffset,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: '',
      operationId: 'GetMovieReport',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["PlaybackReportingActivity"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/user_usage_stats/MoviesReport');
    final Map<String, dynamic> $params = <String, dynamic>{
      'days': days,
      'endDate': endDate,
      'timezoneOffset': timezoneOffset,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _userUsageStatsPlayActivityGet({
    int? days,
    DateTime? endDate,
    String? filter,
    String? dataType,
    num? timezoneOffset,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: '',
      operationId: 'GetUsageStats',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["PlaybackReportingActivity"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/user_usage_stats/PlayActivity');
    final Map<String, dynamic> $params = <String, dynamic>{
      'days': days,
      'endDate': endDate,
      'filter': filter,
      'dataType': dataType,
      'timezoneOffset': timezoneOffset,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<String>>> _userUsageStatsSaveBackupGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: '',
      operationId: 'SaveBackup',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["PlaybackReportingActivity"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/user_usage_stats/save_backup');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<String>, String>($request);
  }

  @override
  Future<Response<Object>> _userUsageStatsSubmitCustomQueryPost({
    required CustomQueryData? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: '',
      operationId: 'CustomQuery',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["PlaybackReportingActivity"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/user_usage_stats/submit_custom_query');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<Object, Object>($request);
  }

  @override
  Future<Response<dynamic>> _userUsageStatsTypeFilterListGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: '',
      operationId: 'GetTypeFilterList',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["PlaybackReportingActivity"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/user_usage_stats/type_filter_list');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _userUsageStatsUserActivityGet({
    int? days,
    DateTime? endDate,
    num? timezoneOffset,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: '',
      operationId: 'GetUserReport',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["PlaybackReportingActivity"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/user_usage_stats/user_activity');
    final Map<String, dynamic> $params = <String, dynamic>{
      'days': days,
      'endDate': endDate,
      'timezoneOffset': timezoneOffset,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _userUsageStatsUserListGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: '',
      operationId: 'GetJellyfinUsers',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["PlaybackReportingActivity"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/user_usage_stats/user_list');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<bool>> _userUsageStatsUserManageAddGet({
    String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: '',
      operationId: 'IgnoreListAdd',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["PlaybackReportingActivity"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/user_usage_stats/user_manage/add');
    final Map<String, dynamic> $params = <String, dynamic>{'id': id};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<bool, bool>($request);
  }

  @override
  Future<Response<bool>> _userUsageStatsUserManagePruneGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: '',
      operationId: 'PruneUnknownUsers',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["PlaybackReportingActivity"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/user_usage_stats/user_manage/prune');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<bool, bool>($request);
  }

  @override
  Future<Response<bool>> _userUsageStatsUserManageRemoveGet({
    String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: '',
      operationId: 'IgnoreListRemove',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["PlaybackReportingActivity"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/user_usage_stats/user_manage/remove');
    final Map<String, dynamic> $params = <String, dynamic>{'id': id};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<bool, bool>($request);
  }

  @override
  Future<Response<PlaylistCreationResult>> _playlistsPost({
    String? name,
    List<String>? ids,
    String? userId,
    String? mediaType,
    required CreatePlaylistDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''For backwards compatibility parameters can be sent via Query or Body, with Query having higher precedence.
Query parameters are obsolete.''',
      summary: 'Creates a new playlist.',
      operationId: 'CreatePlaylist',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Playlists"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Playlists');
    final Map<String, dynamic> $params = <String, dynamic>{
      'name': name,
      'ids': ids,
      'userId': userId,
      'mediaType': mediaType,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<PlaylistCreationResult, PlaylistCreationResult>(
      $request,
    );
  }

  @override
  Future<Response<dynamic>> _playlistsPlaylistIdPost({
    required String? playlistId,
    required UpdatePlaylistDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Updates a playlist.',
      operationId: 'UpdatePlaylist',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Playlists"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Playlists/${playlistId}');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<PlaylistDto>> _playlistsPlaylistIdGet({
    required String? playlistId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get a playlist.',
      operationId: 'GetPlaylist',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Playlists"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Playlists/${playlistId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<PlaylistDto, PlaylistDto>($request);
  }

  @override
  Future<Response<dynamic>> _playlistsPlaylistIdItemsPost({
    required String? playlistId,
    List<String>? ids,
    String? userId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Adds items to a playlist.',
      operationId: 'AddItemToPlaylist',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Playlists"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Playlists/${playlistId}/Items');
    final Map<String, dynamic> $params = <String, dynamic>{
      'ids': ids,
      'userId': userId,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _playlistsPlaylistIdItemsDelete({
    required String? playlistId,
    List<String>? entryIds,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Removes items from a playlist.',
      operationId: 'RemoveItemFromPlaylist',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Playlists"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Playlists/${playlistId}/Items');
    final Map<String, dynamic> $params = <String, dynamic>{
      'entryIds': entryIds,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _playlistsPlaylistIdItemsGet({
    required String? playlistId,
    String? userId,
    int? startIndex,
    int? limit,
    List<Object?>? fields,
    bool? enableImages,
    bool? enableUserData,
    int? imageTypeLimit,
    List<Object?>? enableImageTypes,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets the original items of a playlist.',
      operationId: 'GetPlaylistItems',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Playlists"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Playlists/${playlistId}/Items');
    final Map<String, dynamic> $params = <String, dynamic>{
      'userId': userId,
      'startIndex': startIndex,
      'limit': limit,
      'fields': fields,
      'enableImages': enableImages,
      'enableUserData': enableUserData,
      'imageTypeLimit': imageTypeLimit,
      'enableImageTypes': enableImageTypes,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<dynamic>> _playlistsPlaylistIdItemsItemIdMoveNewIndexPost({
    required String? playlistId,
    required String? itemId,
    required int? newIndex,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Moves a playlist item.',
      operationId: 'MoveItem',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Playlists"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse(
      '/Playlists/${playlistId}/Items/${itemId}/Move/${newIndex}',
    );
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<PlaylistUserPermissions>>> _playlistsPlaylistIdUsersGet({
    required String? playlistId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get a playlist\'s users.',
      operationId: 'GetPlaylistUsers',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Playlists"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Playlists/${playlistId}/Users');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<PlaylistUserPermissions>, PlaylistUserPermissions>(
      $request,
    );
  }

  @override
  Future<Response<PlaylistUserPermissions>> _playlistsPlaylistIdUsersUserIdGet({
    required String? playlistId,
    required String? userId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get a playlist user.',
      operationId: 'GetPlaylistUser',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Playlists"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Playlists/${playlistId}/Users/${userId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<PlaylistUserPermissions, PlaylistUserPermissions>(
      $request,
    );
  }

  @override
  Future<Response<dynamic>> _playlistsPlaylistIdUsersUserIdPost({
    required String? playlistId,
    required String? userId,
    required UpdatePlaylistUserDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Modify a user of a playlist\'s users.',
      operationId: 'UpdatePlaylistUser',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Playlists"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Playlists/${playlistId}/Users/${userId}');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _playlistsPlaylistIdUsersUserIdDelete({
    required String? playlistId,
    required String? userId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Remove a user from a playlist\'s users.',
      operationId: 'RemoveUserFromPlaylist',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Playlists"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Playlists/${playlistId}/Users/${userId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _playingItemsItemIdPost({
    required String? itemId,
    String? mediaSourceId,
    int? audioStreamIndex,
    int? subtitleStreamIndex,
    String? playMethod,
    String? liveStreamId,
    String? playSessionId,
    bool? canSeek,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Reports that a session has begun playing an item.',
      operationId: 'OnPlaybackStart',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Playstate"],
      deprecated: true,
    ),
  }) {
    final Uri $url = Uri.parse('/PlayingItems/${itemId}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'mediaSourceId': mediaSourceId,
      'audioStreamIndex': audioStreamIndex,
      'subtitleStreamIndex': subtitleStreamIndex,
      'playMethod': playMethod,
      'liveStreamId': liveStreamId,
      'playSessionId': playSessionId,
      'canSeek': canSeek,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _playingItemsItemIdDelete({
    required String? itemId,
    String? mediaSourceId,
    String? nextMediaType,
    int? positionTicks,
    String? liveStreamId,
    String? playSessionId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Reports that a session has stopped playing an item.',
      operationId: 'OnPlaybackStopped',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Playstate"],
      deprecated: true,
    ),
  }) {
    final Uri $url = Uri.parse('/PlayingItems/${itemId}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'mediaSourceId': mediaSourceId,
      'nextMediaType': nextMediaType,
      'positionTicks': positionTicks,
      'liveStreamId': liveStreamId,
      'playSessionId': playSessionId,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _playingItemsItemIdProgressPost({
    required String? itemId,
    String? mediaSourceId,
    int? positionTicks,
    int? audioStreamIndex,
    int? subtitleStreamIndex,
    int? volumeLevel,
    String? playMethod,
    String? liveStreamId,
    String? playSessionId,
    String? repeatMode,
    bool? isPaused,
    bool? isMuted,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Reports a session\'s playback progress.',
      operationId: 'OnPlaybackProgress',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Playstate"],
      deprecated: true,
    ),
  }) {
    final Uri $url = Uri.parse('/PlayingItems/${itemId}/Progress');
    final Map<String, dynamic> $params = <String, dynamic>{
      'mediaSourceId': mediaSourceId,
      'positionTicks': positionTicks,
      'audioStreamIndex': audioStreamIndex,
      'subtitleStreamIndex': subtitleStreamIndex,
      'volumeLevel': volumeLevel,
      'playMethod': playMethod,
      'liveStreamId': liveStreamId,
      'playSessionId': playSessionId,
      'repeatMode': repeatMode,
      'isPaused': isPaused,
      'isMuted': isMuted,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _sessionsPlayingPost({
    required PlaybackStartInfo? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Reports playback has started within a session.',
      operationId: 'ReportPlaybackStart',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Playstate"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Sessions/Playing');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _sessionsPlayingPingPost({
    required String? playSessionId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Pings a playback session.',
      operationId: 'PingPlaybackSession',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Playstate"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Sessions/Playing/Ping');
    final Map<String, dynamic> $params = <String, dynamic>{
      'playSessionId': playSessionId,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _sessionsPlayingProgressPost({
    required PlaybackProgressInfo? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Reports playback progress within a session.',
      operationId: 'ReportPlaybackProgress',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Playstate"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Sessions/Playing/Progress');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _sessionsPlayingStoppedPost({
    required PlaybackStopInfo? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Reports playback has stopped within a session.',
      operationId: 'ReportPlaybackStopped',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Playstate"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Sessions/Playing/Stopped');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<UserItemDataDto>> _userPlayedItemsItemIdPost({
    String? userId,
    required String? itemId,
    DateTime? datePlayed,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Marks an item as played for user.',
      operationId: 'MarkPlayedItem',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Playstate"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/UserPlayedItems/${itemId}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'userId': userId,
      'datePlayed': datePlayed,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<UserItemDataDto, UserItemDataDto>($request);
  }

  @override
  Future<Response<UserItemDataDto>> _userPlayedItemsItemIdDelete({
    String? userId,
    required String? itemId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Marks an item as unplayed for user.',
      operationId: 'MarkUnplayedItem',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Playstate"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/UserPlayedItems/${itemId}');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<UserItemDataDto, UserItemDataDto>($request);
  }

  @override
  Future<Response<List<PluginInfo>>> _pluginsGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets a list of currently installed plugins.',
      operationId: 'GetPlugins',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Plugins"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Plugins');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<PluginInfo>, PluginInfo>($request);
  }

  @override
  Future<Response<dynamic>> _pluginsPluginIdDelete({
    required String? pluginId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Uninstalls a plugin.',
      operationId: 'UninstallPlugin',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Plugins"],
      deprecated: true,
    ),
  }) {
    final Uri $url = Uri.parse('/Plugins/${pluginId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _pluginsPluginIdVersionDelete({
    required String? pluginId,
    required String? version,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Uninstalls a plugin by version.',
      operationId: 'UninstallPluginByVersion',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Plugins"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Plugins/${pluginId}/${version}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _pluginsPluginIdVersionDisablePost({
    required String? pluginId,
    required String? version,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Disable a plugin.',
      operationId: 'DisablePlugin',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Plugins"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Plugins/${pluginId}/${version}/Disable');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _pluginsPluginIdVersionEnablePost({
    required String? pluginId,
    required String? version,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Enables a disabled plugin.',
      operationId: 'EnablePlugin',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Plugins"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Plugins/${pluginId}/${version}/Enable');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<String>> _pluginsPluginIdVersionImageGet({
    required String? pluginId,
    required String? version,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets a plugin\'s image.',
      operationId: 'GetPluginImage',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Plugins"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Plugins/${pluginId}/${version}/Image');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<BasePluginConfiguration>> _pluginsPluginIdConfigurationGet({
    required String? pluginId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets plugin configuration.',
      operationId: 'GetPluginConfiguration',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Plugins"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Plugins/${pluginId}/Configuration');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<BasePluginConfiguration, BasePluginConfiguration>(
      $request,
    );
  }

  @override
  Future<Response<dynamic>> _pluginsPluginIdConfigurationPost({
    required String? pluginId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: 'Accepts plugin configuration as JSON body.',
      summary: 'Updates plugin configuration.',
      operationId: 'UpdatePluginConfiguration',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Plugins"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Plugins/${pluginId}/Configuration');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _pluginsPluginIdManifestPost({
    required String? pluginId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets a plugin\'s manifest.',
      operationId: 'GetPluginManifest',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Plugins"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Plugins/${pluginId}/Manifest');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<bool>> _quickConnectAuthorizePost({
    required String? code,
    String? userId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Authorizes a pending quick connect request.',
      operationId: 'AuthorizeQuickConnect',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["QuickConnect"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/QuickConnect/Authorize');
    final Map<String, dynamic> $params = <String, dynamic>{
      'code': code,
      'userId': userId,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<bool, bool>($request);
  }

  @override
  Future<Response<QuickConnectResult>> _quickConnectConnectGet({
    required String? secret,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Attempts to retrieve authentication information.',
      operationId: 'GetQuickConnectState',
      consumes: [],
      produces: [],
      security: [],
      tags: ["QuickConnect"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/QuickConnect/Connect');
    final Map<String, dynamic> $params = <String, dynamic>{'secret': secret};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<QuickConnectResult, QuickConnectResult>($request);
  }

  @override
  Future<Response<bool>> _quickConnectEnabledGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets the current quick connect state.',
      operationId: 'GetQuickConnectEnabled',
      consumes: [],
      produces: [],
      security: [],
      tags: ["QuickConnect"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/QuickConnect/Enabled');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<bool, bool>($request);
  }

  @override
  Future<Response<QuickConnectResult>> _quickConnectInitiatePost({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Initiate a new quick connect request.',
      operationId: 'InitiateQuickConnect',
      consumes: [],
      produces: [],
      security: [],
      tags: ["QuickConnect"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/QuickConnect/Initiate');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<QuickConnectResult, QuickConnectResult>($request);
  }

  @override
  Future<Response<RemoteImageResult>> _itemsItemIdRemoteImagesGet({
    required String? itemId,
    String? type,
    int? startIndex,
    int? limit,
    String? providerName,
    bool? includeAllLanguages,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets available remote images for an item.',
      operationId: 'GetRemoteImages',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["RemoteImage"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Items/${itemId}/RemoteImages');
    final Map<String, dynamic> $params = <String, dynamic>{
      'type': type,
      'startIndex': startIndex,
      'limit': limit,
      'providerName': providerName,
      'includeAllLanguages': includeAllLanguages,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<RemoteImageResult, RemoteImageResult>($request);
  }

  @override
  Future<Response<dynamic>> _itemsItemIdRemoteImagesDownloadPost({
    required String? itemId,
    required String? type,
    String? imageUrl,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Downloads a remote image for an item.',
      operationId: 'DownloadRemoteImage',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["RemoteImage"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Items/${itemId}/RemoteImages/Download');
    final Map<String, dynamic> $params = <String, dynamic>{
      'type': type,
      'imageUrl': imageUrl,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<ImageProviderInfo>>>
  _itemsItemIdRemoteImagesProvidersGet({
    required String? itemId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets available remote image providers for an item.',
      operationId: 'GetRemoteImageProviders',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["RemoteImage"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Items/${itemId}/RemoteImages/Providers');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<ImageProviderInfo>, ImageProviderInfo>($request);
  }

  @override
  Future<Response<List<TaskInfo>>> _scheduledTasksGet({
    bool? isHidden,
    bool? isEnabled,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get tasks.',
      operationId: 'GetTasks',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["ScheduledTasks"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/ScheduledTasks');
    final Map<String, dynamic> $params = <String, dynamic>{
      'isHidden': isHidden,
      'isEnabled': isEnabled,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<List<TaskInfo>, TaskInfo>($request);
  }

  @override
  Future<Response<TaskInfo>> _scheduledTasksTaskIdGet({
    required String? taskId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get task by id.',
      operationId: 'GetTask',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["ScheduledTasks"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/ScheduledTasks/${taskId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<TaskInfo, TaskInfo>($request);
  }

  @override
  Future<Response<dynamic>> _scheduledTasksTaskIdTriggersPost({
    required String? taskId,
    required List<TaskTriggerInfo>? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Update specified task triggers.',
      operationId: 'UpdateTask',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["ScheduledTasks"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/ScheduledTasks/${taskId}/Triggers');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _scheduledTasksRunningTaskIdPost({
    required String? taskId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Start specified task.',
      operationId: 'StartTask',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["ScheduledTasks"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/ScheduledTasks/Running/${taskId}');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _scheduledTasksRunningTaskIdDelete({
    required String? taskId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Stop specified task.',
      operationId: 'StopTask',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["ScheduledTasks"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/ScheduledTasks/Running/${taskId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<SearchHintResult>> _searchHintsGet({
    int? startIndex,
    int? limit,
    String? userId,
    required String? searchTerm,
    List<Object?>? includeItemTypes,
    List<Object?>? excludeItemTypes,
    List<Object?>? mediaTypes,
    String? parentId,
    bool? isMovie,
    bool? isSeries,
    bool? isNews,
    bool? isKids,
    bool? isSports,
    bool? includePeople,
    bool? includeMedia,
    bool? includeGenres,
    bool? includeStudios,
    bool? includeArtists,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets the search hint result.',
      operationId: 'GetSearchHints',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Search"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Search/Hints');
    final Map<String, dynamic> $params = <String, dynamic>{
      'startIndex': startIndex,
      'limit': limit,
      'userId': userId,
      'searchTerm': searchTerm,
      'includeItemTypes': includeItemTypes,
      'excludeItemTypes': excludeItemTypes,
      'mediaTypes': mediaTypes,
      'parentId': parentId,
      'isMovie': isMovie,
      'isSeries': isSeries,
      'isNews': isNews,
      'isKids': isKids,
      'isSports': isSports,
      'includePeople': includePeople,
      'includeMedia': includeMedia,
      'includeGenres': includeGenres,
      'includeStudios': includeStudios,
      'includeArtists': includeArtists,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<SearchHintResult, SearchHintResult>($request);
  }

  @override
  Future<Response<List<NameIdPair>>> _authPasswordResetProvidersGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get all password reset providers.',
      operationId: 'GetPasswordResetProviders',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Session"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Auth/PasswordResetProviders');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<NameIdPair>, NameIdPair>($request);
  }

  @override
  Future<Response<List<NameIdPair>>> _authProvidersGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get all auth providers.',
      operationId: 'GetAuthProviders',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Session"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Auth/Providers');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<NameIdPair>, NameIdPair>($request);
  }

  @override
  Future<Response<List<SessionInfoDto>>> _sessionsGet({
    String? controllableByUserId,
    String? deviceId,
    int? activeWithinSeconds,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets a list of sessions.',
      operationId: 'GetSessions',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Session"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Sessions');
    final Map<String, dynamic> $params = <String, dynamic>{
      'controllableByUserId': controllableByUserId,
      'deviceId': deviceId,
      'activeWithinSeconds': activeWithinSeconds,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<List<SessionInfoDto>, SessionInfoDto>($request);
  }

  @override
  Future<Response<dynamic>> _sessionsSessionIdCommandPost({
    required String? sessionId,
    required GeneralCommand? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Issues a full general command to a client.',
      operationId: 'SendFullGeneralCommand',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Session"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Sessions/${sessionId}/Command');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _sessionsSessionIdCommandCommandPost({
    required String? sessionId,
    required String? command,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Issues a general command to a client.',
      operationId: 'SendGeneralCommand',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Session"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Sessions/${sessionId}/Command/${command}');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _sessionsSessionIdMessagePost({
    required String? sessionId,
    required MessageCommand? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Issues a command to a client to display a message to the user.',
      operationId: 'SendMessageCommand',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Session"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Sessions/${sessionId}/Message');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _sessionsSessionIdPlayingPost({
    required String? sessionId,
    required String? playCommand,
    required List<String>? itemIds,
    int? startPositionTicks,
    String? mediaSourceId,
    int? audioStreamIndex,
    int? subtitleStreamIndex,
    int? startIndex,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Instructs a session to play an item.',
      operationId: 'Play',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Session"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Sessions/${sessionId}/Playing');
    final Map<String, dynamic> $params = <String, dynamic>{
      'playCommand': playCommand,
      'itemIds': itemIds,
      'startPositionTicks': startPositionTicks,
      'mediaSourceId': mediaSourceId,
      'audioStreamIndex': audioStreamIndex,
      'subtitleStreamIndex': subtitleStreamIndex,
      'startIndex': startIndex,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _sessionsSessionIdPlayingCommandPost({
    required String? sessionId,
    required String? command,
    int? seekPositionTicks,
    String? controllingUserId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Issues a playstate command to a client.',
      operationId: 'SendPlaystateCommand',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Session"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Sessions/${sessionId}/Playing/${command}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'seekPositionTicks': seekPositionTicks,
      'controllingUserId': controllingUserId,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _sessionsSessionIdSystemCommandPost({
    required String? sessionId,
    required String? command,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Issues a system command to a client.',
      operationId: 'SendSystemCommand',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Session"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Sessions/${sessionId}/System/${command}');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _sessionsSessionIdUserUserIdPost({
    required String? sessionId,
    required String? userId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Adds an additional user to a session.',
      operationId: 'AddUserToSession',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Session"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Sessions/${sessionId}/User/${userId}');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _sessionsSessionIdUserUserIdDelete({
    required String? sessionId,
    required String? userId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Removes an additional user from a session.',
      operationId: 'RemoveUserFromSession',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Session"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Sessions/${sessionId}/User/${userId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _sessionsSessionIdViewingPost({
    required String? sessionId,
    required String? itemType,
    required String? itemId,
    required String? itemName,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Instructs a session to browse to an item or view.',
      operationId: 'DisplayContent',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Session"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Sessions/${sessionId}/Viewing');
    final Map<String, dynamic> $params = <String, dynamic>{
      'itemType': itemType,
      'itemId': itemId,
      'itemName': itemName,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _sessionsCapabilitiesPost({
    String? id,
    List<Object?>? playableMediaTypes,
    List<Object?>? supportedCommands,
    bool? supportsMediaControl,
    bool? supportsPersistentIdentifier,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Updates capabilities for a device.',
      operationId: 'PostCapabilities',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Session"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Sessions/Capabilities');
    final Map<String, dynamic> $params = <String, dynamic>{
      'id': id,
      'playableMediaTypes': playableMediaTypes,
      'supportedCommands': supportedCommands,
      'supportsMediaControl': supportsMediaControl,
      'supportsPersistentIdentifier': supportsPersistentIdentifier,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _sessionsCapabilitiesFullPost({
    String? id,
    required ClientCapabilitiesDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Updates capabilities for a device.',
      operationId: 'PostFullCapabilities',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Session"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Sessions/Capabilities/Full');
    final Map<String, dynamic> $params = <String, dynamic>{'id': id};
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _sessionsLogoutPost({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Reports that a session has ended.',
      operationId: 'ReportSessionEnded',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Session"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Sessions/Logout');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _sessionsViewingPost({
    String? sessionId,
    required String? itemId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Reports that a session is viewing an item.',
      operationId: 'ReportViewing',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Session"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Sessions/Viewing');
    final Map<String, dynamic> $params = <String, dynamic>{
      'sessionId': sessionId,
      'itemId': itemId,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _startupCompletePost({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Completes the startup wizard.',
      operationId: 'CompleteWizard',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Startup"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Startup/Complete');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<StartupConfigurationDto>> _startupConfigurationGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets the initial startup wizard configuration.',
      operationId: 'GetStartupConfiguration',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Startup"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Startup/Configuration');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<StartupConfigurationDto, StartupConfigurationDto>(
      $request,
    );
  }

  @override
  Future<Response<dynamic>> _startupConfigurationPost({
    required StartupConfigurationDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Sets the initial startup wizard configuration.',
      operationId: 'UpdateInitialConfiguration',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Startup"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Startup/Configuration');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<StartupUserDto>> _startupFirstUserGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets the first user.',
      operationId: 'GetFirstUser_2',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Startup"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Startup/FirstUser');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<StartupUserDto, StartupUserDto>($request);
  }

  @override
  Future<Response<dynamic>> _startupRemoteAccessPost({
    required StartupRemoteAccessDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Sets remote access and UPnP.',
      operationId: 'SetRemoteAccess',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Startup"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Startup/RemoteAccess');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<StartupUserDto>> _startupUserGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets the first user.',
      operationId: 'GetFirstUser',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Startup"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Startup/User');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<StartupUserDto, StartupUserDto>($request);
  }

  @override
  Future<Response<dynamic>> _startupUserPost({
    required StartupUserDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Sets the user name and password.',
      operationId: 'UpdateStartupUser',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Startup"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Startup/User');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _studiosGet({
    int? startIndex,
    int? limit,
    String? searchTerm,
    String? parentId,
    List<Object?>? fields,
    List<Object?>? excludeItemTypes,
    List<Object?>? includeItemTypes,
    bool? isFavorite,
    bool? enableUserData,
    int? imageTypeLimit,
    List<Object?>? enableImageTypes,
    String? userId,
    String? nameStartsWithOrGreater,
    String? nameStartsWith,
    String? nameLessThan,
    bool? enableImages,
    bool? enableTotalRecordCount,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary:
          'Gets all studios from a given item, folder, or the entire library.',
      operationId: 'GetStudios',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Studios"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Studios');
    final Map<String, dynamic> $params = <String, dynamic>{
      'startIndex': startIndex,
      'limit': limit,
      'searchTerm': searchTerm,
      'parentId': parentId,
      'fields': fields,
      'excludeItemTypes': excludeItemTypes,
      'includeItemTypes': includeItemTypes,
      'isFavorite': isFavorite,
      'enableUserData': enableUserData,
      'imageTypeLimit': imageTypeLimit,
      'enableImageTypes': enableImageTypes,
      'userId': userId,
      'nameStartsWithOrGreater': nameStartsWithOrGreater,
      'nameStartsWith': nameStartsWith,
      'nameLessThan': nameLessThan,
      'enableImages': enableImages,
      'enableTotalRecordCount': enableTotalRecordCount,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<BaseItemDto>> _studiosNameGet({
    required String? name,
    String? userId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets a studio by name.',
      operationId: 'GetStudio',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Studios"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Studios/${name}');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDto, BaseItemDto>($request);
  }

  @override
  Future<Response<List<FontFile>>> _fallbackFontFontsGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets a list of available fallback font files.',
      operationId: 'GetFallbackFontList',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Subtitle"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/FallbackFont/Fonts');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<FontFile>, FontFile>($request);
  }

  @override
  Future<Response<String>> _fallbackFontFontsNameGet({
    required String? name,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets a fallback font file.',
      operationId: 'GetFallbackFont',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Subtitle"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/FallbackFont/Fonts/${name}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<List<RemoteSubtitleInfo>>>
  _itemsItemIdRemoteSearchSubtitlesLanguageGet({
    required String? itemId,
    required String? language,
    bool? isPerfectMatch,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Search remote subtitles.',
      operationId: 'SearchRemoteSubtitles',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Subtitle"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse(
      '/Items/${itemId}/RemoteSearch/Subtitles/${language}',
    );
    final Map<String, dynamic> $params = <String, dynamic>{
      'isPerfectMatch': isPerfectMatch,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<List<RemoteSubtitleInfo>, RemoteSubtitleInfo>($request);
  }

  @override
  Future<Response<dynamic>> _itemsItemIdRemoteSearchSubtitlesSubtitleIdPost({
    required String? itemId,
    required String? subtitleId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Downloads a remote subtitle.',
      operationId: 'DownloadRemoteSubtitles',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Subtitle"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse(
      '/Items/${itemId}/RemoteSearch/Subtitles/${subtitleId}',
    );
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<String>> _providersSubtitlesSubtitlesSubtitleIdGet({
    required String? subtitleId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets the remote subtitles.',
      operationId: 'GetRemoteSubtitles',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Subtitle"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Providers/Subtitles/Subtitles/${subtitleId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>>
  _videosItemIdMediaSourceIdSubtitlesIndexSubtitlesM3u8Get({
    required String? itemId,
    required int? index,
    required String? mediaSourceId,
    required int? segmentLength,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets an HLS subtitle playlist.',
      operationId: 'GetSubtitlePlaylist',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Subtitle"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse(
      '/Videos/${itemId}/${mediaSourceId}/Subtitles/${index}/subtitles.m3u8',
    );
    final Map<String, dynamic> $params = <String, dynamic>{
      'segmentLength': segmentLength,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<dynamic>> _videosItemIdSubtitlesPost({
    required String? itemId,
    required UploadSubtitleDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Upload an external subtitle file.',
      operationId: 'UploadSubtitle',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Subtitle"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Videos/${itemId}/Subtitles');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _videosItemIdSubtitlesIndexDelete({
    required String? itemId,
    required int? index,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Deletes an external subtitle file.',
      operationId: 'DeleteSubtitle',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Subtitle"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Videos/${itemId}/Subtitles/${index}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<String>>
  _videosRouteItemIdRouteMediaSourceIdSubtitlesRouteIndexRouteStartPositionTicksStreamRouteFormatGet({
    required String? routeItemId,
    required String? routeMediaSourceId,
    required int? routeIndex,
    required int? routeStartPositionTicks,
    required String? routeFormat,
    String? itemId,
    String? mediaSourceId,
    int? index,
    int? startPositionTicks,
    String? format,
    int? endPositionTicks,
    bool? copyTimestamps,
    bool? addVttTimeMap,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets subtitles in a specified format.',
      operationId: 'GetSubtitleWithTicks',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Subtitle"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse(
      '/Videos/${routeItemId}/${routeMediaSourceId}/Subtitles/${routeIndex}/${routeStartPositionTicks}/Stream.${routeFormat}',
    );
    final Map<String, dynamic> $params = <String, dynamic>{
      'itemId': itemId,
      'mediaSourceId': mediaSourceId,
      'index': index,
      'startPositionTicks': startPositionTicks,
      'format': format,
      'endPositionTicks': endPositionTicks,
      'copyTimestamps': copyTimestamps,
      'addVttTimeMap': addVttTimeMap,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>>
  _videosRouteItemIdRouteMediaSourceIdSubtitlesRouteIndexStreamRouteFormatGet({
    required String? routeItemId,
    required String? routeMediaSourceId,
    required int? routeIndex,
    required String? routeFormat,
    String? itemId,
    String? mediaSourceId,
    int? index,
    String? format,
    int? endPositionTicks,
    bool? copyTimestamps,
    bool? addVttTimeMap,
    int? startPositionTicks,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets subtitles in a specified format.',
      operationId: 'GetSubtitle',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Subtitle"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse(
      '/Videos/${routeItemId}/${routeMediaSourceId}/Subtitles/${routeIndex}/Stream.${routeFormat}',
    );
    final Map<String, dynamic> $params = <String, dynamic>{
      'itemId': itemId,
      'mediaSourceId': mediaSourceId,
      'index': index,
      'format': format,
      'endPositionTicks': endPositionTicks,
      'copyTimestamps': copyTimestamps,
      'addVttTimeMap': addVttTimeMap,
      'startPositionTicks': startPositionTicks,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _itemsSuggestionsGet({
    String? userId,
    List<Object?>? mediaType,
    List<Object?>? type,
    int? startIndex,
    int? limit,
    bool? enableTotalRecordCount,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets suggestions.',
      operationId: 'GetSuggestions',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Suggestions"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Items/Suggestions');
    final Map<String, dynamic> $params = <String, dynamic>{
      'userId': userId,
      'mediaType': mediaType,
      'type': type,
      'startIndex': startIndex,
      'limit': limit,
      'enableTotalRecordCount': enableTotalRecordCount,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<GroupInfoDto>> _syncPlayIdGet({
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets a SyncPlay group by id.',
      operationId: 'SyncPlayGetGroup',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["SyncPlay"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/SyncPlay/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<GroupInfoDto, GroupInfoDto>($request);
  }

  @override
  Future<Response<dynamic>> _syncPlayBufferingPost({
    required BufferRequestDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Notify SyncPlay group that member is buffering.',
      operationId: 'SyncPlayBuffering',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["SyncPlay"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/SyncPlay/Buffering');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _syncPlayJoinPost({
    required JoinGroupRequestDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Join an existing SyncPlay group.',
      operationId: 'SyncPlayJoinGroup',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["SyncPlay"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/SyncPlay/Join');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _syncPlayLeavePost({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Leave the joined SyncPlay group.',
      operationId: 'SyncPlayLeaveGroup',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["SyncPlay"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/SyncPlay/Leave');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<GroupInfoDto>>> _syncPlayListGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets all SyncPlay groups.',
      operationId: 'SyncPlayGetGroups',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["SyncPlay"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/SyncPlay/List');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<GroupInfoDto>, GroupInfoDto>($request);
  }

  @override
  Future<Response<dynamic>> _syncPlayMovePlaylistItemPost({
    required MovePlaylistItemRequestDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Request to move an item in the playlist in SyncPlay group.',
      operationId: 'SyncPlayMovePlaylistItem',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["SyncPlay"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/SyncPlay/MovePlaylistItem');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<GroupInfoDto>> _syncPlayNewPost({
    required NewGroupRequestDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Create a new SyncPlay group.',
      operationId: 'SyncPlayCreateGroup',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["SyncPlay"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/SyncPlay/New');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<GroupInfoDto, GroupInfoDto>($request);
  }

  @override
  Future<Response<dynamic>> _syncPlayNextItemPost({
    required NextItemRequestDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Request next item in SyncPlay group.',
      operationId: 'SyncPlayNextItem',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["SyncPlay"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/SyncPlay/NextItem');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _syncPlayPausePost({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Request pause in SyncPlay group.',
      operationId: 'SyncPlayPause',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["SyncPlay"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/SyncPlay/Pause');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _syncPlayPingPost({
    required PingRequestDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Update session ping.',
      operationId: 'SyncPlayPing',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["SyncPlay"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/SyncPlay/Ping');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _syncPlayPreviousItemPost({
    required PreviousItemRequestDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Request previous item in SyncPlay group.',
      operationId: 'SyncPlayPreviousItem',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["SyncPlay"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/SyncPlay/PreviousItem');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _syncPlayQueuePost({
    required QueueRequestDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Request to queue items to the playlist of a SyncPlay group.',
      operationId: 'SyncPlayQueue',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["SyncPlay"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/SyncPlay/Queue');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _syncPlayReadyPost({
    required ReadyRequestDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Notify SyncPlay group that member is ready for playback.',
      operationId: 'SyncPlayReady',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["SyncPlay"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/SyncPlay/Ready');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _syncPlayRemoveFromPlaylistPost({
    required RemoveFromPlaylistRequestDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Request to remove items from the playlist in SyncPlay group.',
      operationId: 'SyncPlayRemoveFromPlaylist',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["SyncPlay"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/SyncPlay/RemoveFromPlaylist');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _syncPlaySeekPost({
    required SeekRequestDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Request seek in SyncPlay group.',
      operationId: 'SyncPlaySeek',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["SyncPlay"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/SyncPlay/Seek');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _syncPlaySetIgnoreWaitPost({
    required IgnoreWaitRequestDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Request SyncPlay group to ignore member during group-wait.',
      operationId: 'SyncPlaySetIgnoreWait',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["SyncPlay"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/SyncPlay/SetIgnoreWait');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _syncPlaySetNewQueuePost({
    required PlayRequestDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Request to set new playlist in SyncPlay group.',
      operationId: 'SyncPlaySetNewQueue',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["SyncPlay"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/SyncPlay/SetNewQueue');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _syncPlaySetPlaylistItemPost({
    required SetPlaylistItemRequestDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Request to change playlist item in SyncPlay group.',
      operationId: 'SyncPlaySetPlaylistItem',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["SyncPlay"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/SyncPlay/SetPlaylistItem');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _syncPlaySetRepeatModePost({
    required SetRepeatModeRequestDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Request to set repeat mode in SyncPlay group.',
      operationId: 'SyncPlaySetRepeatMode',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["SyncPlay"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/SyncPlay/SetRepeatMode');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _syncPlaySetShuffleModePost({
    required SetShuffleModeRequestDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Request to set shuffle mode in SyncPlay group.',
      operationId: 'SyncPlaySetShuffleMode',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["SyncPlay"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/SyncPlay/SetShuffleMode');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _syncPlayStopPost({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Request stop in SyncPlay group.',
      operationId: 'SyncPlayStop',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["SyncPlay"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/SyncPlay/Stop');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _syncPlayUnpausePost({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Request unpause in SyncPlay group.',
      operationId: 'SyncPlayUnpause',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["SyncPlay"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/SyncPlay/Unpause');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<EndPointInfo>> _systemEndpointGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets information about the request endpoint.',
      operationId: 'GetEndpointInfo',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["System"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/System/Endpoint');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<EndPointInfo, EndPointInfo>($request);
  }

  @override
  Future<Response<SystemInfo>> _systemInfoGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets information about the server.',
      operationId: 'GetSystemInfo',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["System"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/System/Info');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<SystemInfo, SystemInfo>($request);
  }

  @override
  Future<Response<PublicSystemInfo>> _systemInfoPublicGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets public information about the server.',
      operationId: 'GetPublicSystemInfo',
      consumes: [],
      produces: [],
      security: [],
      tags: ["System"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/System/Info/Public');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<PublicSystemInfo, PublicSystemInfo>($request);
  }

  @override
  Future<Response<SystemStorageDto>> _systemInfoStorageGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets information about the server.',
      operationId: 'GetSystemStorage',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["System"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/System/Info/Storage');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<SystemStorageDto, SystemStorageDto>($request);
  }

  @override
  Future<Response<List<LogFile>>> _systemLogsGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets a list of available server log files.',
      operationId: 'GetServerLogs',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["System"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/System/Logs');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<LogFile>, LogFile>($request);
  }

  @override
  Future<Response<String>> _systemLogsLogGet({
    required String? name,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets a log file.',
      operationId: 'GetLogFile',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["System"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/System/Logs/Log');
    final Map<String, dynamic> $params = <String, dynamic>{'name': name};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _systemPingGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Pings the system.',
      operationId: 'GetPingSystem',
      consumes: [],
      produces: [],
      security: [],
      tags: ["System"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/System/Ping');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _systemPingPost({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Pings the system.',
      operationId: 'PostPingSystem',
      consumes: [],
      produces: [],
      security: [],
      tags: ["System"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/System/Ping');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<dynamic>> _systemRestartPost({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Restarts the application.',
      operationId: 'RestartApplication',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["System"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/System/Restart');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _systemShutdownPost({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Shuts down the application.',
      operationId: 'ShutdownApplication',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["System"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/System/Shutdown');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<UtcTimeResponse>> _getUtcTimeGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets the current UTC time.',
      operationId: 'GetUtcTime',
      consumes: [],
      produces: [],
      security: [],
      tags: ["TimeSync"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/GetUtcTime');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<UtcTimeResponse, UtcTimeResponse>($request);
  }

  @override
  Future<Response<ConfigImageTypes>> _tmdbClientConfigurationGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets the TMDb image configuration options.',
      operationId: 'TmdbClientConfiguration',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Tmdb"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Tmdb/ClientConfiguration');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<ConfigImageTypes, ConfigImageTypes>($request);
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _trailersGet({
    String? userId,
    String? maxOfficialRating,
    bool? hasThemeSong,
    bool? hasThemeVideo,
    bool? hasSubtitles,
    bool? hasSpecialFeature,
    bool? hasTrailer,
    String? adjacentTo,
    int? parentIndexNumber,
    bool? hasParentalRating,
    bool? isHd,
    bool? is4K,
    List<Object?>? locationTypes,
    List<Object?>? excludeLocationTypes,
    bool? isMissing,
    bool? isUnaired,
    num? minCommunityRating,
    num? minCriticRating,
    DateTime? minPremiereDate,
    DateTime? minDateLastSaved,
    DateTime? minDateLastSavedForUser,
    DateTime? maxPremiereDate,
    bool? hasOverview,
    bool? hasImdbId,
    bool? hasTmdbId,
    bool? hasTvdbId,
    bool? isMovie,
    bool? isSeries,
    bool? isNews,
    bool? isKids,
    bool? isSports,
    List<String>? excludeItemIds,
    int? startIndex,
    int? limit,
    bool? recursive,
    String? searchTerm,
    List<Object?>? sortOrder,
    String? parentId,
    List<Object?>? fields,
    List<Object?>? excludeItemTypes,
    List<Object?>? filters,
    bool? isFavorite,
    List<Object?>? mediaTypes,
    List<Object?>? imageTypes,
    List<Object?>? sortBy,
    bool? isPlayed,
    List<String>? genres,
    List<String>? officialRatings,
    List<String>? tags,
    List<int>? years,
    bool? enableUserData,
    int? imageTypeLimit,
    List<Object?>? enableImageTypes,
    String? person,
    List<String>? personIds,
    List<String>? personTypes,
    List<String>? studios,
    List<String>? artists,
    List<String>? excludeArtistIds,
    List<String>? artistIds,
    List<String>? albumArtistIds,
    List<String>? contributingArtistIds,
    List<String>? albums,
    List<String>? albumIds,
    List<String>? ids,
    List<Object?>? videoTypes,
    String? minOfficialRating,
    bool? isLocked,
    bool? isPlaceHolder,
    bool? hasOfficialRating,
    bool? collapseBoxSetItems,
    int? minWidth,
    int? minHeight,
    int? maxWidth,
    int? maxHeight,
    bool? is3D,
    List<Object?>? seriesStatus,
    String? nameStartsWithOrGreater,
    String? nameStartsWith,
    String? nameLessThan,
    List<String>? studioIds,
    List<String>? genreIds,
    bool? enableTotalRecordCount,
    bool? enableImages,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Finds movies and trailers similar to a given trailer.',
      operationId: 'GetTrailers',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Trailers"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Trailers');
    final Map<String, dynamic> $params = <String, dynamic>{
      'userId': userId,
      'maxOfficialRating': maxOfficialRating,
      'hasThemeSong': hasThemeSong,
      'hasThemeVideo': hasThemeVideo,
      'hasSubtitles': hasSubtitles,
      'hasSpecialFeature': hasSpecialFeature,
      'hasTrailer': hasTrailer,
      'adjacentTo': adjacentTo,
      'parentIndexNumber': parentIndexNumber,
      'hasParentalRating': hasParentalRating,
      'isHd': isHd,
      'is4K': is4K,
      'locationTypes': locationTypes,
      'excludeLocationTypes': excludeLocationTypes,
      'isMissing': isMissing,
      'isUnaired': isUnaired,
      'minCommunityRating': minCommunityRating,
      'minCriticRating': minCriticRating,
      'minPremiereDate': minPremiereDate,
      'minDateLastSaved': minDateLastSaved,
      'minDateLastSavedForUser': minDateLastSavedForUser,
      'maxPremiereDate': maxPremiereDate,
      'hasOverview': hasOverview,
      'hasImdbId': hasImdbId,
      'hasTmdbId': hasTmdbId,
      'hasTvdbId': hasTvdbId,
      'isMovie': isMovie,
      'isSeries': isSeries,
      'isNews': isNews,
      'isKids': isKids,
      'isSports': isSports,
      'excludeItemIds': excludeItemIds,
      'startIndex': startIndex,
      'limit': limit,
      'recursive': recursive,
      'searchTerm': searchTerm,
      'sortOrder': sortOrder,
      'parentId': parentId,
      'fields': fields,
      'excludeItemTypes': excludeItemTypes,
      'filters': filters,
      'isFavorite': isFavorite,
      'mediaTypes': mediaTypes,
      'imageTypes': imageTypes,
      'sortBy': sortBy,
      'isPlayed': isPlayed,
      'genres': genres,
      'officialRatings': officialRatings,
      'tags': tags,
      'years': years,
      'enableUserData': enableUserData,
      'imageTypeLimit': imageTypeLimit,
      'enableImageTypes': enableImageTypes,
      'person': person,
      'personIds': personIds,
      'personTypes': personTypes,
      'studios': studios,
      'artists': artists,
      'excludeArtistIds': excludeArtistIds,
      'artistIds': artistIds,
      'albumArtistIds': albumArtistIds,
      'contributingArtistIds': contributingArtistIds,
      'albums': albums,
      'albumIds': albumIds,
      'ids': ids,
      'videoTypes': videoTypes,
      'minOfficialRating': minOfficialRating,
      'isLocked': isLocked,
      'isPlaceHolder': isPlaceHolder,
      'hasOfficialRating': hasOfficialRating,
      'collapseBoxSetItems': collapseBoxSetItems,
      'minWidth': minWidth,
      'minHeight': minHeight,
      'maxWidth': maxWidth,
      'maxHeight': maxHeight,
      'is3D': is3D,
      'seriesStatus': seriesStatus,
      'nameStartsWithOrGreater': nameStartsWithOrGreater,
      'nameStartsWith': nameStartsWith,
      'nameLessThan': nameLessThan,
      'studioIds': studioIds,
      'genreIds': genreIds,
      'enableTotalRecordCount': enableTotalRecordCount,
      'enableImages': enableImages,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<String>> _videosItemIdTrickplayWidthIndexJpgGet({
    required String? itemId,
    required int? width,
    required int? index,
    String? mediaSourceId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets a trickplay tile image.',
      operationId: 'GetTrickplayTileImage',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Trickplay"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse(
      '/Videos/${itemId}/Trickplay/${width}/${index}.jpg',
    );
    final Map<String, dynamic> $params = <String, dynamic>{
      'mediaSourceId': mediaSourceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _videosItemIdTrickplayWidthTilesM3u8Get({
    required String? itemId,
    required int? width,
    String? mediaSourceId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets an image tiles playlist for trickplay.',
      operationId: 'GetTrickplayHlsPlaylist',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Trickplay"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse(
      '/Videos/${itemId}/Trickplay/${width}/tiles.m3u8',
    );
    final Map<String, dynamic> $params = <String, dynamic>{
      'mediaSourceId': mediaSourceId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _showsSeriesIdEpisodesGet({
    required String? seriesId,
    String? userId,
    List<Object?>? fields,
    int? season,
    String? seasonId,
    bool? isMissing,
    String? adjacentTo,
    String? startItemId,
    int? startIndex,
    int? limit,
    bool? enableImages,
    int? imageTypeLimit,
    List<Object?>? enableImageTypes,
    bool? enableUserData,
    String? sortBy,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets episodes for a tv season.',
      operationId: 'GetEpisodes',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["TvShows"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Shows/${seriesId}/Episodes');
    final Map<String, dynamic> $params = <String, dynamic>{
      'userId': userId,
      'fields': fields,
      'season': season,
      'seasonId': seasonId,
      'isMissing': isMissing,
      'adjacentTo': adjacentTo,
      'startItemId': startItemId,
      'startIndex': startIndex,
      'limit': limit,
      'enableImages': enableImages,
      'imageTypeLimit': imageTypeLimit,
      'enableImageTypes': enableImageTypes,
      'enableUserData': enableUserData,
      'sortBy': sortBy,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _showsSeriesIdSeasonsGet({
    required String? seriesId,
    String? userId,
    List<Object?>? fields,
    bool? isSpecialSeason,
    bool? isMissing,
    String? adjacentTo,
    bool? enableImages,
    int? imageTypeLimit,
    List<Object?>? enableImageTypes,
    bool? enableUserData,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets seasons for a tv series.',
      operationId: 'GetSeasons',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["TvShows"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Shows/${seriesId}/Seasons');
    final Map<String, dynamic> $params = <String, dynamic>{
      'userId': userId,
      'fields': fields,
      'isSpecialSeason': isSpecialSeason,
      'isMissing': isMissing,
      'adjacentTo': adjacentTo,
      'enableImages': enableImages,
      'imageTypeLimit': imageTypeLimit,
      'enableImageTypes': enableImageTypes,
      'enableUserData': enableUserData,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _showsNextUpGet({
    String? userId,
    int? startIndex,
    int? limit,
    List<Object?>? fields,
    String? seriesId,
    String? parentId,
    bool? enableImages,
    int? imageTypeLimit,
    List<Object?>? enableImageTypes,
    bool? enableUserData,
    DateTime? nextUpDateCutoff,
    bool? enableTotalRecordCount,
    bool? disableFirstEpisode,
    bool? enableResumable,
    bool? enableRewatching,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets a list of next up episodes.',
      operationId: 'GetNextUp',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["TvShows"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Shows/NextUp');
    final Map<String, dynamic> $params = <String, dynamic>{
      'userId': userId,
      'startIndex': startIndex,
      'limit': limit,
      'fields': fields,
      'seriesId': seriesId,
      'parentId': parentId,
      'enableImages': enableImages,
      'imageTypeLimit': imageTypeLimit,
      'enableImageTypes': enableImageTypes,
      'enableUserData': enableUserData,
      'nextUpDateCutoff': nextUpDateCutoff,
      'enableTotalRecordCount': enableTotalRecordCount,
      'disableFirstEpisode': disableFirstEpisode,
      'enableResumable': enableResumable,
      'enableRewatching': enableRewatching,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _showsUpcomingGet({
    String? userId,
    int? startIndex,
    int? limit,
    List<Object?>? fields,
    String? parentId,
    bool? enableImages,
    int? imageTypeLimit,
    List<Object?>? enableImageTypes,
    bool? enableUserData,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets a list of upcoming episodes.',
      operationId: 'GetUpcomingEpisodes',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["TvShows"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Shows/Upcoming');
    final Map<String, dynamic> $params = <String, dynamic>{
      'userId': userId,
      'startIndex': startIndex,
      'limit': limit,
      'fields': fields,
      'parentId': parentId,
      'enableImages': enableImages,
      'imageTypeLimit': imageTypeLimit,
      'enableImageTypes': enableImageTypes,
      'enableUserData': enableUserData,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<String>> _audioItemIdUniversalGet({
    required String? itemId,
    List<String>? container,
    String? mediaSourceId,
    String? deviceId,
    String? userId,
    String? audioCodec,
    int? maxAudioChannels,
    int? transcodingAudioChannels,
    int? maxStreamingBitrate,
    int? audioBitRate,
    int? startTimeTicks,
    String? transcodingContainer,
    String? transcodingProtocol,
    int? maxAudioSampleRate,
    int? maxAudioBitDepth,
    bool? enableRemoteMedia,
    bool? enableAudioVbrEncoding,
    bool? breakOnNonKeyFrames,
    bool? enableRedirection,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets an audio stream.',
      operationId: 'GetUniversalAudioStream',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["UniversalAudio"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Audio/${itemId}/universal');
    final Map<String, dynamic> $params = <String, dynamic>{
      'container': container,
      'mediaSourceId': mediaSourceId,
      'deviceId': deviceId,
      'userId': userId,
      'audioCodec': audioCodec,
      'maxAudioChannels': maxAudioChannels,
      'transcodingAudioChannels': transcodingAudioChannels,
      'maxStreamingBitrate': maxStreamingBitrate,
      'audioBitRate': audioBitRate,
      'startTimeTicks': startTimeTicks,
      'transcodingContainer': transcodingContainer,
      'transcodingProtocol': transcodingProtocol,
      'maxAudioSampleRate': maxAudioSampleRate,
      'maxAudioBitDepth': maxAudioBitDepth,
      'enableRemoteMedia': enableRemoteMedia,
      'enableAudioVbrEncoding': enableAudioVbrEncoding,
      'breakOnNonKeyFrames': breakOnNonKeyFrames,
      'enableRedirection': enableRedirection,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _audioItemIdUniversalHead({
    required String? itemId,
    List<String>? container,
    String? mediaSourceId,
    String? deviceId,
    String? userId,
    String? audioCodec,
    int? maxAudioChannels,
    int? transcodingAudioChannels,
    int? maxStreamingBitrate,
    int? audioBitRate,
    int? startTimeTicks,
    String? transcodingContainer,
    String? transcodingProtocol,
    int? maxAudioSampleRate,
    int? maxAudioBitDepth,
    bool? enableRemoteMedia,
    bool? enableAudioVbrEncoding,
    bool? breakOnNonKeyFrames,
    bool? enableRedirection,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets an audio stream.',
      operationId: 'HeadUniversalAudioStream',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["UniversalAudio"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Audio/${itemId}/universal');
    final Map<String, dynamic> $params = <String, dynamic>{
      'container': container,
      'mediaSourceId': mediaSourceId,
      'deviceId': deviceId,
      'userId': userId,
      'audioCodec': audioCodec,
      'maxAudioChannels': maxAudioChannels,
      'transcodingAudioChannels': transcodingAudioChannels,
      'maxStreamingBitrate': maxStreamingBitrate,
      'audioBitRate': audioBitRate,
      'startTimeTicks': startTimeTicks,
      'transcodingContainer': transcodingContainer,
      'transcodingProtocol': transcodingProtocol,
      'maxAudioSampleRate': maxAudioSampleRate,
      'maxAudioBitDepth': maxAudioBitDepth,
      'enableRemoteMedia': enableRemoteMedia,
      'enableAudioVbrEncoding': enableAudioVbrEncoding,
      'breakOnNonKeyFrames': breakOnNonKeyFrames,
      'enableRedirection': enableRedirection,
    };
    final Request $request = Request(
      'HEAD',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<List<UserDto>>> _usersGet({
    bool? isHidden,
    bool? isDisabled,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets a list of users.',
      operationId: 'GetUsers',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["User"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Users');
    final Map<String, dynamic> $params = <String, dynamic>{
      'isHidden': isHidden,
      'isDisabled': isDisabled,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<List<UserDto>, UserDto>($request);
  }

  @override
  Future<Response<dynamic>> _usersPost({
    String? userId,
    required UserDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Updates a user.',
      operationId: 'UpdateUser',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["User"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Users');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<UserDto>> _usersUserIdGet({
    required String? userId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets a user by Id.',
      operationId: 'GetUserById',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["User"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Users/${userId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<UserDto, UserDto>($request);
  }

  @override
  Future<Response<dynamic>> _usersUserIdDelete({
    required String? userId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Deletes a user.',
      operationId: 'DeleteUser',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["User"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Users/${userId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _usersUserIdPolicyPost({
    required String? userId,
    required UserPolicy? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Updates a user policy.',
      operationId: 'UpdateUserPolicy',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["User"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Users/${userId}/Policy');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<AuthenticationResult>> _usersAuthenticateByNamePost({
    required AuthenticateUserByName? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Authenticates a user by name.',
      operationId: 'AuthenticateUserByName',
      consumes: [],
      produces: [],
      security: [],
      tags: ["User"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Users/AuthenticateByName');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<AuthenticationResult, AuthenticationResult>($request);
  }

  @override
  Future<Response<AuthenticationResult>>
  _usersAuthenticateWithQuickConnectPost({
    required QuickConnectDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Authenticates a user with quick connect.',
      operationId: 'AuthenticateWithQuickConnect',
      consumes: [],
      produces: [],
      security: [],
      tags: ["User"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Users/AuthenticateWithQuickConnect');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<AuthenticationResult, AuthenticationResult>($request);
  }

  @override
  Future<Response<dynamic>> _usersConfigurationPost({
    String? userId,
    required UserConfiguration? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Updates a user configuration.',
      operationId: 'UpdateUserConfiguration',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["User"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Users/Configuration');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<ForgotPasswordResult>> _usersForgotPasswordPost({
    required ForgotPasswordDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Initiates the forgot password process for a local user.',
      operationId: 'ForgotPassword',
      consumes: [],
      produces: [],
      security: [],
      tags: ["User"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Users/ForgotPassword');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<ForgotPasswordResult, ForgotPasswordResult>($request);
  }

  @override
  Future<Response<PinRedeemResult>> _usersForgotPasswordPinPost({
    required ForgotPasswordPinDto? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Redeems a forgot password pin.',
      operationId: 'ForgotPasswordPin',
      consumes: [],
      produces: [],
      security: [],
      tags: ["User"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Users/ForgotPassword/Pin');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<PinRedeemResult, PinRedeemResult>($request);
  }

  @override
  Future<Response<UserDto>> _usersMeGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets the user based on auth token.',
      operationId: 'GetCurrentUser',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["User"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Users/Me');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<UserDto, UserDto>($request);
  }

  @override
  Future<Response<UserDto>> _usersNewPost({
    required CreateUserByName? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Creates a user.',
      operationId: 'CreateUserByName',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["User"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Users/New');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<UserDto, UserDto>($request);
  }

  @override
  Future<Response<dynamic>> _usersPasswordPost({
    String? userId,
    required UpdateUserPassword? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Updates a user\'s password.',
      operationId: 'UpdateUserPassword',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["User"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Users/Password');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<UserDto>>> _usersPublicGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary:
          'Gets a list of publicly visible users for display on a login screen.',
      operationId: 'GetPublicUsers',
      consumes: [],
      produces: [],
      security: [],
      tags: ["User"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Users/Public');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<List<UserDto>, UserDto>($request);
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _itemsItemIdIntrosGet({
    String? userId,
    required String? itemId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets intros to play before the main media item plays.',
      operationId: 'GetIntros',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["UserLibrary"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Items/${itemId}/Intros');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<List<BaseItemDto>>> _itemsItemIdLocalTrailersGet({
    String? userId,
    required String? itemId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets local trailers for an item.',
      operationId: 'GetLocalTrailers',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["UserLibrary"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Items/${itemId}/LocalTrailers');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<List<BaseItemDto>, BaseItemDto>($request);
  }

  @override
  Future<Response<List<BaseItemDto>>> _itemsItemIdSpecialFeaturesGet({
    String? userId,
    required String? itemId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets special features for an item.',
      operationId: 'GetSpecialFeatures',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["UserLibrary"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Items/${itemId}/SpecialFeatures');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<List<BaseItemDto>, BaseItemDto>($request);
  }

  @override
  Future<Response<List<BaseItemDto>>> _usersUserIdItemsLatestGet({
    required String? userId,
    String? parentId,
    List<Object?>? fields,
    List<Object?>? includeItemTypes,
    bool? isPlayed,
    bool? enableImages,
    int? imageTypeLimit,
    List<Object?>? enableImageTypes,
    bool? enableUserData,
    int? limit,
    bool? groupItems,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets latest media.',
      operationId: 'GetLatestMedia',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["UserLibrary"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('Users/${userId}/Items/Latest');
    final Map<String, dynamic> $params = <String, dynamic>{
      'parentId': parentId,
      'fields': fields,
      'includeItemTypes': includeItemTypes,
      'isPlayed': isPlayed,
      'enableImages': enableImages,
      'imageTypeLimit': imageTypeLimit,
      'enableImageTypes': enableImageTypes,
      'enableUserData': enableUserData,
      'limit': limit,
      'groupItems': groupItems,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<List<BaseItemDto>, BaseItemDto>($request);
  }

  @override
  Future<Response<BaseItemDto>> _itemsRootGet({
    String? userId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets the root folder from a user\'s library.',
      operationId: 'GetRootFolder',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["UserLibrary"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Items/Root');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDto, BaseItemDto>($request);
  }

  @override
  Future<Response<UserItemDataDto>> _userFavoriteItemsItemIdPost({
    String? userId,
    required String? itemId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Marks an item as a favorite.',
      operationId: 'MarkFavoriteItem',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["UserLibrary"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/UserFavoriteItems/${itemId}');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<UserItemDataDto, UserItemDataDto>($request);
  }

  @override
  Future<Response<UserItemDataDto>> _userFavoriteItemsItemIdDelete({
    String? userId,
    required String? itemId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Unmarks item as a favorite.',
      operationId: 'UnmarkFavoriteItem',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["UserLibrary"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/UserFavoriteItems/${itemId}');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<UserItemDataDto, UserItemDataDto>($request);
  }

  @override
  Future<Response<UserItemDataDto>> _userItemsItemIdRatingDelete({
    String? userId,
    required String? itemId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Deletes a user\'s saved personal rating for an item.',
      operationId: 'DeleteUserItemRating',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["UserLibrary"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/UserItems/${itemId}/Rating');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<UserItemDataDto, UserItemDataDto>($request);
  }

  @override
  Future<Response<UserItemDataDto>> _userItemsItemIdRatingPost({
    String? userId,
    required String? itemId,
    bool? likes,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Updates a user\'s rating for an item.',
      operationId: 'UpdateUserItemRating',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["UserLibrary"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/UserItems/${itemId}/Rating');
    final Map<String, dynamic> $params = <String, dynamic>{
      'userId': userId,
      'likes': likes,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<UserItemDataDto, UserItemDataDto>($request);
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _userViewsGet({
    String? userId,
    bool? includeExternalContent,
    List<Object?>? presetViews,
    bool? includeHidden,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get user views.',
      operationId: 'GetUserViews',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["UserViews"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/UserViews');
    final Map<String, dynamic> $params = <String, dynamic>{
      'userId': userId,
      'includeExternalContent': includeExternalContent,
      'presetViews': presetViews,
      'includeHidden': includeHidden,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<List<SpecialViewOptionDto>>> _userViewsGroupingOptionsGet({
    String? userId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get user view grouping options.',
      operationId: 'GetGroupingOptions',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["UserViews"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/UserViews/GroupingOptions');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<List<SpecialViewOptionDto>, SpecialViewOptionDto>(
      $request,
    );
  }

  @override
  Future<Response<String>> _videosVideoIdMediaSourceIdAttachmentsIndexGet({
    required String? videoId,
    required String? mediaSourceId,
    required int? index,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get video attachment.',
      operationId: 'GetAttachment',
      consumes: [],
      produces: [],
      security: [],
      tags: ["VideoAttachments"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse(
      '/Videos/${videoId}/${mediaSourceId}/Attachments/${index}',
    );
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _videosItemIdAdditionalPartsGet({
    required String? itemId,
    String? userId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets additional parts for a video.',
      operationId: 'GetAdditionalPart',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Videos"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Videos/${itemId}/AdditionalParts');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<dynamic>> _videosItemIdAlternateSourcesDelete({
    required String? itemId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Removes alternate video sources.',
      operationId: 'DeleteAlternateSources',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Videos"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Videos/${itemId}/AlternateSources');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<String>> _videosItemIdStreamGet({
    required String? itemId,
    String? container,
    bool? $static,
    String? params,
    String? tag,
    String? deviceProfileId,
    String? playSessionId,
    String? segmentContainer,
    int? segmentLength,
    int? minSegments,
    String? mediaSourceId,
    String? deviceId,
    String? audioCodec,
    bool? enableAutoStreamCopy,
    bool? allowVideoStreamCopy,
    bool? allowAudioStreamCopy,
    bool? breakOnNonKeyFrames,
    int? audioSampleRate,
    int? maxAudioBitDepth,
    int? audioBitRate,
    int? audioChannels,
    int? maxAudioChannels,
    String? profile,
    String? level,
    num? framerate,
    num? maxFramerate,
    bool? copyTimestamps,
    int? startTimeTicks,
    int? width,
    int? height,
    int? maxWidth,
    int? maxHeight,
    int? videoBitRate,
    int? subtitleStreamIndex,
    String? subtitleMethod,
    int? maxRefFrames,
    int? maxVideoBitDepth,
    bool? requireAvc,
    bool? deInterlace,
    bool? requireNonAnamorphic,
    int? transcodingMaxAudioChannels,
    int? cpuCoreLimit,
    String? liveStreamId,
    bool? enableMpegtsM2TsMode,
    String? videoCodec,
    String? subtitleCodec,
    String? transcodeReasons,
    int? audioStreamIndex,
    int? videoStreamIndex,
    String? context,
    Object? streamOptions,
    bool? enableAudioVbrEncoding,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets a video stream.',
      operationId: 'GetVideoStream',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Videos"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Videos/${itemId}/stream');
    final Map<String, dynamic> $params = <String, dynamic>{
      'container': container,
      'static': $static,
      'params': params,
      'tag': tag,
      'deviceProfileId': deviceProfileId,
      'playSessionId': playSessionId,
      'segmentContainer': segmentContainer,
      'segmentLength': segmentLength,
      'minSegments': minSegments,
      'mediaSourceId': mediaSourceId,
      'deviceId': deviceId,
      'audioCodec': audioCodec,
      'enableAutoStreamCopy': enableAutoStreamCopy,
      'allowVideoStreamCopy': allowVideoStreamCopy,
      'allowAudioStreamCopy': allowAudioStreamCopy,
      'breakOnNonKeyFrames': breakOnNonKeyFrames,
      'audioSampleRate': audioSampleRate,
      'maxAudioBitDepth': maxAudioBitDepth,
      'audioBitRate': audioBitRate,
      'audioChannels': audioChannels,
      'maxAudioChannels': maxAudioChannels,
      'profile': profile,
      'level': level,
      'framerate': framerate,
      'maxFramerate': maxFramerate,
      'copyTimestamps': copyTimestamps,
      'startTimeTicks': startTimeTicks,
      'width': width,
      'height': height,
      'maxWidth': maxWidth,
      'maxHeight': maxHeight,
      'videoBitRate': videoBitRate,
      'subtitleStreamIndex': subtitleStreamIndex,
      'subtitleMethod': subtitleMethod,
      'maxRefFrames': maxRefFrames,
      'maxVideoBitDepth': maxVideoBitDepth,
      'requireAvc': requireAvc,
      'deInterlace': deInterlace,
      'requireNonAnamorphic': requireNonAnamorphic,
      'transcodingMaxAudioChannels': transcodingMaxAudioChannels,
      'cpuCoreLimit': cpuCoreLimit,
      'liveStreamId': liveStreamId,
      'enableMpegtsM2TsMode': enableMpegtsM2TsMode,
      'videoCodec': videoCodec,
      'subtitleCodec': subtitleCodec,
      'transcodeReasons': transcodeReasons,
      'audioStreamIndex': audioStreamIndex,
      'videoStreamIndex': videoStreamIndex,
      'context': context,
      'streamOptions': streamOptions,
      'enableAudioVbrEncoding': enableAudioVbrEncoding,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _videosItemIdStreamHead({
    required String? itemId,
    String? container,
    bool? $static,
    String? params,
    String? tag,
    String? deviceProfileId,
    String? playSessionId,
    String? segmentContainer,
    int? segmentLength,
    int? minSegments,
    String? mediaSourceId,
    String? deviceId,
    String? audioCodec,
    bool? enableAutoStreamCopy,
    bool? allowVideoStreamCopy,
    bool? allowAudioStreamCopy,
    bool? breakOnNonKeyFrames,
    int? audioSampleRate,
    int? maxAudioBitDepth,
    int? audioBitRate,
    int? audioChannels,
    int? maxAudioChannels,
    String? profile,
    String? level,
    num? framerate,
    num? maxFramerate,
    bool? copyTimestamps,
    int? startTimeTicks,
    int? width,
    int? height,
    int? maxWidth,
    int? maxHeight,
    int? videoBitRate,
    int? subtitleStreamIndex,
    String? subtitleMethod,
    int? maxRefFrames,
    int? maxVideoBitDepth,
    bool? requireAvc,
    bool? deInterlace,
    bool? requireNonAnamorphic,
    int? transcodingMaxAudioChannels,
    int? cpuCoreLimit,
    String? liveStreamId,
    bool? enableMpegtsM2TsMode,
    String? videoCodec,
    String? subtitleCodec,
    String? transcodeReasons,
    int? audioStreamIndex,
    int? videoStreamIndex,
    String? context,
    Object? streamOptions,
    bool? enableAudioVbrEncoding,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets a video stream.',
      operationId: 'HeadVideoStream',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Videos"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Videos/${itemId}/stream');
    final Map<String, dynamic> $params = <String, dynamic>{
      'container': container,
      'static': $static,
      'params': params,
      'tag': tag,
      'deviceProfileId': deviceProfileId,
      'playSessionId': playSessionId,
      'segmentContainer': segmentContainer,
      'segmentLength': segmentLength,
      'minSegments': minSegments,
      'mediaSourceId': mediaSourceId,
      'deviceId': deviceId,
      'audioCodec': audioCodec,
      'enableAutoStreamCopy': enableAutoStreamCopy,
      'allowVideoStreamCopy': allowVideoStreamCopy,
      'allowAudioStreamCopy': allowAudioStreamCopy,
      'breakOnNonKeyFrames': breakOnNonKeyFrames,
      'audioSampleRate': audioSampleRate,
      'maxAudioBitDepth': maxAudioBitDepth,
      'audioBitRate': audioBitRate,
      'audioChannels': audioChannels,
      'maxAudioChannels': maxAudioChannels,
      'profile': profile,
      'level': level,
      'framerate': framerate,
      'maxFramerate': maxFramerate,
      'copyTimestamps': copyTimestamps,
      'startTimeTicks': startTimeTicks,
      'width': width,
      'height': height,
      'maxWidth': maxWidth,
      'maxHeight': maxHeight,
      'videoBitRate': videoBitRate,
      'subtitleStreamIndex': subtitleStreamIndex,
      'subtitleMethod': subtitleMethod,
      'maxRefFrames': maxRefFrames,
      'maxVideoBitDepth': maxVideoBitDepth,
      'requireAvc': requireAvc,
      'deInterlace': deInterlace,
      'requireNonAnamorphic': requireNonAnamorphic,
      'transcodingMaxAudioChannels': transcodingMaxAudioChannels,
      'cpuCoreLimit': cpuCoreLimit,
      'liveStreamId': liveStreamId,
      'enableMpegtsM2TsMode': enableMpegtsM2TsMode,
      'videoCodec': videoCodec,
      'subtitleCodec': subtitleCodec,
      'transcodeReasons': transcodeReasons,
      'audioStreamIndex': audioStreamIndex,
      'videoStreamIndex': videoStreamIndex,
      'context': context,
      'streamOptions': streamOptions,
      'enableAudioVbrEncoding': enableAudioVbrEncoding,
    };
    final Request $request = Request(
      'HEAD',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _videosItemIdStreamContainerGet({
    required String? itemId,
    required String? container,
    bool? $static,
    String? params,
    String? tag,
    String? deviceProfileId,
    String? playSessionId,
    String? segmentContainer,
    int? segmentLength,
    int? minSegments,
    String? mediaSourceId,
    String? deviceId,
    String? audioCodec,
    bool? enableAutoStreamCopy,
    bool? allowVideoStreamCopy,
    bool? allowAudioStreamCopy,
    bool? breakOnNonKeyFrames,
    int? audioSampleRate,
    int? maxAudioBitDepth,
    int? audioBitRate,
    int? audioChannels,
    int? maxAudioChannels,
    String? profile,
    String? level,
    num? framerate,
    num? maxFramerate,
    bool? copyTimestamps,
    int? startTimeTicks,
    int? width,
    int? height,
    int? maxWidth,
    int? maxHeight,
    int? videoBitRate,
    int? subtitleStreamIndex,
    String? subtitleMethod,
    int? maxRefFrames,
    int? maxVideoBitDepth,
    bool? requireAvc,
    bool? deInterlace,
    bool? requireNonAnamorphic,
    int? transcodingMaxAudioChannels,
    int? cpuCoreLimit,
    String? liveStreamId,
    bool? enableMpegtsM2TsMode,
    String? videoCodec,
    String? subtitleCodec,
    String? transcodeReasons,
    int? audioStreamIndex,
    int? videoStreamIndex,
    String? context,
    Object? streamOptions,
    bool? enableAudioVbrEncoding,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets a video stream.',
      operationId: 'GetVideoStreamByContainer',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Videos"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Videos/${itemId}/stream.${container}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'static': $static,
      'params': params,
      'tag': tag,
      'deviceProfileId': deviceProfileId,
      'playSessionId': playSessionId,
      'segmentContainer': segmentContainer,
      'segmentLength': segmentLength,
      'minSegments': minSegments,
      'mediaSourceId': mediaSourceId,
      'deviceId': deviceId,
      'audioCodec': audioCodec,
      'enableAutoStreamCopy': enableAutoStreamCopy,
      'allowVideoStreamCopy': allowVideoStreamCopy,
      'allowAudioStreamCopy': allowAudioStreamCopy,
      'breakOnNonKeyFrames': breakOnNonKeyFrames,
      'audioSampleRate': audioSampleRate,
      'maxAudioBitDepth': maxAudioBitDepth,
      'audioBitRate': audioBitRate,
      'audioChannels': audioChannels,
      'maxAudioChannels': maxAudioChannels,
      'profile': profile,
      'level': level,
      'framerate': framerate,
      'maxFramerate': maxFramerate,
      'copyTimestamps': copyTimestamps,
      'startTimeTicks': startTimeTicks,
      'width': width,
      'height': height,
      'maxWidth': maxWidth,
      'maxHeight': maxHeight,
      'videoBitRate': videoBitRate,
      'subtitleStreamIndex': subtitleStreamIndex,
      'subtitleMethod': subtitleMethod,
      'maxRefFrames': maxRefFrames,
      'maxVideoBitDepth': maxVideoBitDepth,
      'requireAvc': requireAvc,
      'deInterlace': deInterlace,
      'requireNonAnamorphic': requireNonAnamorphic,
      'transcodingMaxAudioChannels': transcodingMaxAudioChannels,
      'cpuCoreLimit': cpuCoreLimit,
      'liveStreamId': liveStreamId,
      'enableMpegtsM2TsMode': enableMpegtsM2TsMode,
      'videoCodec': videoCodec,
      'subtitleCodec': subtitleCodec,
      'transcodeReasons': transcodeReasons,
      'audioStreamIndex': audioStreamIndex,
      'videoStreamIndex': videoStreamIndex,
      'context': context,
      'streamOptions': streamOptions,
      'enableAudioVbrEncoding': enableAudioVbrEncoding,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _videosItemIdStreamContainerHead({
    required String? itemId,
    required String? container,
    bool? $static,
    String? params,
    String? tag,
    String? deviceProfileId,
    String? playSessionId,
    String? segmentContainer,
    int? segmentLength,
    int? minSegments,
    String? mediaSourceId,
    String? deviceId,
    String? audioCodec,
    bool? enableAutoStreamCopy,
    bool? allowVideoStreamCopy,
    bool? allowAudioStreamCopy,
    bool? breakOnNonKeyFrames,
    int? audioSampleRate,
    int? maxAudioBitDepth,
    int? audioBitRate,
    int? audioChannels,
    int? maxAudioChannels,
    String? profile,
    String? level,
    num? framerate,
    num? maxFramerate,
    bool? copyTimestamps,
    int? startTimeTicks,
    int? width,
    int? height,
    int? maxWidth,
    int? maxHeight,
    int? videoBitRate,
    int? subtitleStreamIndex,
    String? subtitleMethod,
    int? maxRefFrames,
    int? maxVideoBitDepth,
    bool? requireAvc,
    bool? deInterlace,
    bool? requireNonAnamorphic,
    int? transcodingMaxAudioChannels,
    int? cpuCoreLimit,
    String? liveStreamId,
    bool? enableMpegtsM2TsMode,
    String? videoCodec,
    String? subtitleCodec,
    String? transcodeReasons,
    int? audioStreamIndex,
    int? videoStreamIndex,
    String? context,
    Object? streamOptions,
    bool? enableAudioVbrEncoding,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets a video stream.',
      operationId: 'HeadVideoStreamByContainer',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Videos"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Videos/${itemId}/stream.${container}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'static': $static,
      'params': params,
      'tag': tag,
      'deviceProfileId': deviceProfileId,
      'playSessionId': playSessionId,
      'segmentContainer': segmentContainer,
      'segmentLength': segmentLength,
      'minSegments': minSegments,
      'mediaSourceId': mediaSourceId,
      'deviceId': deviceId,
      'audioCodec': audioCodec,
      'enableAutoStreamCopy': enableAutoStreamCopy,
      'allowVideoStreamCopy': allowVideoStreamCopy,
      'allowAudioStreamCopy': allowAudioStreamCopy,
      'breakOnNonKeyFrames': breakOnNonKeyFrames,
      'audioSampleRate': audioSampleRate,
      'maxAudioBitDepth': maxAudioBitDepth,
      'audioBitRate': audioBitRate,
      'audioChannels': audioChannels,
      'maxAudioChannels': maxAudioChannels,
      'profile': profile,
      'level': level,
      'framerate': framerate,
      'maxFramerate': maxFramerate,
      'copyTimestamps': copyTimestamps,
      'startTimeTicks': startTimeTicks,
      'width': width,
      'height': height,
      'maxWidth': maxWidth,
      'maxHeight': maxHeight,
      'videoBitRate': videoBitRate,
      'subtitleStreamIndex': subtitleStreamIndex,
      'subtitleMethod': subtitleMethod,
      'maxRefFrames': maxRefFrames,
      'maxVideoBitDepth': maxVideoBitDepth,
      'requireAvc': requireAvc,
      'deInterlace': deInterlace,
      'requireNonAnamorphic': requireNonAnamorphic,
      'transcodingMaxAudioChannels': transcodingMaxAudioChannels,
      'cpuCoreLimit': cpuCoreLimit,
      'liveStreamId': liveStreamId,
      'enableMpegtsM2TsMode': enableMpegtsM2TsMode,
      'videoCodec': videoCodec,
      'subtitleCodec': subtitleCodec,
      'transcodeReasons': transcodeReasons,
      'audioStreamIndex': audioStreamIndex,
      'videoStreamIndex': videoStreamIndex,
      'context': context,
      'streamOptions': streamOptions,
      'enableAudioVbrEncoding': enableAudioVbrEncoding,
    };
    final Request $request = Request(
      'HEAD',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<dynamic>> _videosMergeVersionsPost({
    required List<String>? ids,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Merges videos into a single record.',
      operationId: 'MergeVersions',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Videos"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Videos/MergeVersions');
    final Map<String, dynamic> $params = <String, dynamic>{'ids': ids};
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _yearsGet({
    int? startIndex,
    int? limit,
    List<Object?>? sortOrder,
    String? parentId,
    List<Object?>? fields,
    List<Object?>? excludeItemTypes,
    List<Object?>? includeItemTypes,
    List<Object?>? mediaTypes,
    List<Object?>? sortBy,
    bool? enableUserData,
    int? imageTypeLimit,
    List<Object?>? enableImageTypes,
    String? userId,
    bool? recursive,
    bool? enableImages,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Get years.',
      operationId: 'GetYears',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Years"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Years');
    final Map<String, dynamic> $params = <String, dynamic>{
      'startIndex': startIndex,
      'limit': limit,
      'sortOrder': sortOrder,
      'parentId': parentId,
      'fields': fields,
      'excludeItemTypes': excludeItemTypes,
      'includeItemTypes': includeItemTypes,
      'mediaTypes': mediaTypes,
      'sortBy': sortBy,
      'enableUserData': enableUserData,
      'imageTypeLimit': imageTypeLimit,
      'enableImageTypes': enableImageTypes,
      'userId': userId,
      'recursive': recursive,
      'enableImages': enableImages,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>(
      $request,
    );
  }

  @override
  Future<Response<BaseItemDto>> _yearsYearGet({
    required int? year,
    String? userId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Gets a year.',
      operationId: 'GetYear',
      consumes: [],
      produces: [],
      security: ["CustomAuthentication"],
      tags: ["Years"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/Years/${year}');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      tag: swaggerMetaData,
    );
    return client.send<BaseItemDto, BaseItemDto>($request);
  }
}
