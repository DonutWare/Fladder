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
    );
    return client.send<ActivityLogEntryQueryResult,
        ActivityLogEntryQueryResult>($request);
  }

  @override
  Future<Response<AuthenticationInfoQueryResult>> _authKeysGet() {
    final Uri $url = Uri.parse('/Auth/Keys');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<AuthenticationInfoQueryResult,
        AuthenticationInfoQueryResult>($request);
  }

  @override
  Future<Response<dynamic>> _authKeysPost({required String? app}) {
    final Uri $url = Uri.parse('/Auth/Keys');
    final Map<String, dynamic> $params = <String, dynamic>{'app': app};
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _authKeysKeyDelete({required String? key}) {
    final Uri $url = Uri.parse('/Auth/Keys/${key}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
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
    );
    return client
        .send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>($request);
  }

  @override
  Future<Response<BaseItemDto>> _artistsNameGet({
    required String? name,
    String? userId,
  }) {
    final Uri $url = Uri.parse('/Artists/${name}');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
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
    );
    return client
        .send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>($request);
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
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<BrandingOptions>> _brandingConfigurationGet() {
    final Uri $url = Uri.parse('/Branding/Configuration');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<BrandingOptions, BrandingOptions>($request);
  }

  @override
  Future<Response<String>> _brandingCssGet() {
    final Uri $url = Uri.parse('/Branding/Css');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _brandingCssCssGet() {
    final Uri $url = Uri.parse('/Branding/Css.css');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
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
    );
    return client
        .send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>($request);
  }

  @override
  Future<Response<ChannelFeatures>> _channelsChannelIdFeaturesGet(
      {required String? channelId}) {
    final Uri $url = Uri.parse('/Channels/${channelId}/Features');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
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
    );
    return client
        .send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>($request);
  }

  @override
  Future<Response<List<ChannelFeatures>>> _channelsFeaturesGet() {
    final Uri $url = Uri.parse('/Channels/Features');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
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
    );
    return client
        .send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>($request);
  }

  @override
  Future<Response<ClientLogDocumentResponseDto>> _clientLogDocumentPost(
      {required Object? body}) {
    final Uri $url = Uri.parse('/ClientLog/Document');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<ClientLogDocumentResponseDto,
        ClientLogDocumentResponseDto>($request);
  }

  @override
  Future<Response<CollectionCreationResult>> _collectionsPost({
    String? name,
    List<String>? ids,
    String? parentId,
    bool? isLocked,
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
    );
    return client
        .send<CollectionCreationResult, CollectionCreationResult>($request);
  }

  @override
  Future<Response<dynamic>> _collectionsCollectionIdItemsPost({
    required String? collectionId,
    required List<String>? ids,
  }) {
    final Uri $url = Uri.parse('/Collections/${collectionId}/Items');
    final Map<String, dynamic> $params = <String, dynamic>{'ids': ids};
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _collectionsCollectionIdItemsDelete({
    required String? collectionId,
    required List<String>? ids,
  }) {
    final Uri $url = Uri.parse('/Collections/${collectionId}/Items');
    final Map<String, dynamic> $params = <String, dynamic>{'ids': ids};
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<ServerConfiguration>> _systemConfigurationGet() {
    final Uri $url = Uri.parse('/System/Configuration');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<ServerConfiguration, ServerConfiguration>($request);
  }

  @override
  Future<Response<dynamic>> _systemConfigurationPost(
      {required ServerConfiguration? body}) {
    final Uri $url = Uri.parse('/System/Configuration');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<String>> _systemConfigurationKeyGet({required String? key}) {
    final Uri $url = Uri.parse('/System/Configuration/${key}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<dynamic>> _systemConfigurationKeyPost({
    required String? key,
    required Object? body,
  }) {
    final Uri $url = Uri.parse('/System/Configuration/${key}');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<MetadataOptions>>
      _systemConfigurationMetadataOptionsDefaultGet() {
    final Uri $url = Uri.parse('/System/Configuration/MetadataOptions/Default');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<MetadataOptions, MetadataOptions>($request);
  }

  @override
  Future<Response<String>> _webConfigurationPageGet({String? name}) {
    final Uri $url = Uri.parse('/web/ConfigurationPage');
    final Map<String, dynamic> $params = <String, dynamic>{'name': name};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<List<ConfigurationPageInfo>>> _webConfigurationPagesGet(
      {bool? enableInMainMenu}) {
    final Uri $url = Uri.parse('/web/ConfigurationPages');
    final Map<String, dynamic> $params = <String, dynamic>{
      'enableInMainMenu': enableInMainMenu
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<List<ConfigurationPageInfo>, ConfigurationPageInfo>($request);
  }

  @override
  Future<Response<DeviceInfoDtoQueryResult>> _devicesGet({String? userId}) {
    final Uri $url = Uri.parse('/Devices');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<DeviceInfoDtoQueryResult, DeviceInfoDtoQueryResult>($request);
  }

  @override
  Future<Response<dynamic>> _devicesDelete({required String? id}) {
    final Uri $url = Uri.parse('/Devices');
    final Map<String, dynamic> $params = <String, dynamic>{'id': id};
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<DeviceInfoDto>> _devicesInfoGet({required String? id}) {
    final Uri $url = Uri.parse('/Devices/Info');
    final Map<String, dynamic> $params = <String, dynamic>{'id': id};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<DeviceInfoDto, DeviceInfoDto>($request);
  }

  @override
  Future<Response<DeviceOptionsDto>> _devicesOptionsGet({required String? id}) {
    final Uri $url = Uri.parse('/Devices/Options');
    final Map<String, dynamic> $params = <String, dynamic>{'id': id};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<DeviceOptionsDto, DeviceOptionsDto>($request);
  }

  @override
  Future<Response<dynamic>> _devicesOptionsPost({
    required String? id,
    required DeviceOptionsDto? body,
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
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<DisplayPreferencesDto>>
      _displayPreferencesDisplayPreferencesIdGet({
    required String? displayPreferencesId,
    String? userId,
    required String? $client,
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
    );
    return client.send<DisplayPreferencesDto, DisplayPreferencesDto>($request);
  }

  @override
  Future<Response<dynamic>> _displayPreferencesDisplayPreferencesIdPost({
    required String? displayPreferencesId,
    String? userId,
    required String? $client,
    required DisplayPreferencesDto? body,
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
  }) {
    final Uri $url = Uri.parse(
        '/Audio/${itemId}/hls1/${playlistId}/${segmentId}.${container}');
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
  }) {
    final Uri $url = Uri.parse(
        '/Videos/${itemId}/hls1/${playlistId}/${segmentId}.${container}');
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
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<DefaultDirectoryBrowserInfoDto>>
      _environmentDefaultDirectoryBrowserGet() {
    final Uri $url = Uri.parse('/Environment/DefaultDirectoryBrowser');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<DefaultDirectoryBrowserInfoDto,
        DefaultDirectoryBrowserInfoDto>($request);
  }

  @override
  Future<Response<List<FileSystemEntryInfo>>> _environmentDirectoryContentsGet({
    required String? path,
    bool? includeFiles,
    bool? includeDirectories,
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
    );
    return client
        .send<List<FileSystemEntryInfo>, FileSystemEntryInfo>($request);
  }

  @override
  Future<Response<List<FileSystemEntryInfo>>> _environmentDrivesGet() {
    final Uri $url = Uri.parse('/Environment/Drives');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<List<FileSystemEntryInfo>, FileSystemEntryInfo>($request);
  }

  @override
  Future<Response<List<FileSystemEntryInfo>>> _environmentNetworkSharesGet() {
    final Uri $url = Uri.parse('/Environment/NetworkShares');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<List<FileSystemEntryInfo>, FileSystemEntryInfo>($request);
  }

  @override
  Future<Response<String>> _environmentParentPathGet({required String? path}) {
    final Uri $url = Uri.parse('/Environment/ParentPath');
    final Map<String, dynamic> $params = <String, dynamic>{'path': path};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<dynamic>> _environmentValidatePathPost(
      {required ValidatePathDto? body}) {
    final Uri $url = Uri.parse('/Environment/ValidatePath');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<QueryFiltersLegacy>> _itemsFiltersGet({
    String? userId,
    String? parentId,
    List<Object?>? includeItemTypes,
    List<Object?>? mediaTypes,
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
    );
    return client
        .send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>($request);
  }

  @override
  Future<Response<BaseItemDto>> _genresGenreNameGet({
    required String? genreName,
    String? userId,
  }) {
    final Uri $url = Uri.parse('/Genres/${genreName}');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<BaseItemDto, BaseItemDto>($request);
  }

  @override
  Future<Response<String>> _audioItemIdHlsSegmentIdStreamAacGet({
    required String? itemId,
    required String? segmentId,
  }) {
    final Uri $url = Uri.parse('/Audio/${itemId}/hls/${segmentId}/stream.aac');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _audioItemIdHlsSegmentIdStreamMp3Get({
    required String? itemId,
    required String? segmentId,
  }) {
    final Uri $url = Uri.parse('/Audio/${itemId}/hls/${segmentId}/stream.mp3');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
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
  }) {
    final Uri $url = Uri.parse(
        '/Videos/${itemId}/hls/${playlistId}/${segmentId}.${segmentContainer}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _videosItemIdHlsPlaylistIdStreamM3u8Get({
    required String? itemId,
    required String? playlistId,
  }) {
    final Uri $url =
        Uri.parse('/Videos/${itemId}/hls/${playlistId}/stream.m3u8');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<dynamic>> _videosActiveEncodingsDelete({
    required String? deviceId,
    required String? playSessionId,
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
  }) {
    final Uri $url =
        Uri.parse('/Artists/${name}/Images/${imageType}/${imageIndex}');
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
  }) {
    final Uri $url =
        Uri.parse('/Artists/${name}/Images/${imageType}/${imageIndex}');
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
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _brandingSplashscreenGet({
    String? tag,
    String? format,
    int? maxWidth,
    int? maxHeight,
    int? width,
    int? height,
    int? fillWidth,
    int? fillHeight,
    int? blur,
    String? backgroundColor,
    String? foregroundLayer,
    int? quality,
  }) {
    final Uri $url = Uri.parse('/Branding/Splashscreen');
    final Map<String, dynamic> $params = <String, dynamic>{
      'tag': tag,
      'format': format,
      'maxWidth': maxWidth,
      'maxHeight': maxHeight,
      'width': width,
      'height': height,
      'fillWidth': fillWidth,
      'fillHeight': fillHeight,
      'blur': blur,
      'backgroundColor': backgroundColor,
      'foregroundLayer': foregroundLayer,
      'quality': quality,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<dynamic>> _brandingSplashscreenPost({required Object? body}) {
    final Uri $url = Uri.parse('/Branding/Splashscreen');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _brandingSplashscreenDelete() {
    final Uri $url = Uri.parse('/Branding/Splashscreen');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
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
  }) {
    final Uri $url =
        Uri.parse('/Genres/${name}/Images/${imageType}/${imageIndex}');
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
  }) {
    final Uri $url =
        Uri.parse('/Genres/${name}/Images/${imageType}/${imageIndex}');
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
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<List<ImageInfo>>> _itemsItemIdImagesGet(
      {required String? itemId}) {
    final Uri $url = Uri.parse('/Items/${itemId}/Images');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<ImageInfo>, ImageInfo>($request);
  }

  @override
  Future<Response<dynamic>> _itemsItemIdImagesImageTypeDelete({
    required String? itemId,
    required String? imageType,
    int? imageIndex,
  }) {
    final Uri $url = Uri.parse('/Items/${itemId}/Images/${imageType}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'imageIndex': imageIndex
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _itemsItemIdImagesImageTypePost({
    required String? itemId,
    required String? imageType,
    required Object? body,
  }) {
    final Uri $url = Uri.parse('/Items/${itemId}/Images/${imageType}');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
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
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<dynamic>> _itemsItemIdImagesImageTypeImageIndexDelete({
    required String? itemId,
    required String? imageType,
    required int? imageIndex,
  }) {
    final Uri $url =
        Uri.parse('/Items/${itemId}/Images/${imageType}/${imageIndex}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _itemsItemIdImagesImageTypeImageIndexPost({
    required String? itemId,
    required String? imageType,
    required int? imageIndex,
    required Object? body,
  }) {
    final Uri $url =
        Uri.parse('/Items/${itemId}/Images/${imageType}/${imageIndex}');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
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
  }) {
    final Uri $url =
        Uri.parse('/Items/${itemId}/Images/${imageType}/${imageIndex}');
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
  }) {
    final Uri $url =
        Uri.parse('/Items/${itemId}/Images/${imageType}/${imageIndex}');
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
  }) {
    final Uri $url = Uri.parse(
        '/Items/${itemId}/Images/${imageType}/${imageIndex}/${tag}/${format}/${maxWidth}/${maxHeight}/${percentPlayed}/${unplayedCount}');
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
  }) {
    final Uri $url = Uri.parse(
        '/Items/${itemId}/Images/${imageType}/${imageIndex}/${tag}/${format}/${maxWidth}/${maxHeight}/${percentPlayed}/${unplayedCount}');
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
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<dynamic>> _itemsItemIdImagesImageTypeImageIndexIndexPost({
    required String? itemId,
    required String? imageType,
    required int? imageIndex,
    required int? newIndex,
  }) {
    final Uri $url =
        Uri.parse('/Items/${itemId}/Images/${imageType}/${imageIndex}/Index');
    final Map<String, dynamic> $params = <String, dynamic>{
      'newIndex': newIndex
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
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
  }) {
    final Uri $url =
        Uri.parse('/MusicGenres/${name}/Images/${imageType}/${imageIndex}');
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
  }) {
    final Uri $url =
        Uri.parse('/MusicGenres/${name}/Images/${imageType}/${imageIndex}');
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
  }) {
    final Uri $url =
        Uri.parse('/Persons/${name}/Images/${imageType}/${imageIndex}');
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
  }) {
    final Uri $url =
        Uri.parse('/Persons/${name}/Images/${imageType}/${imageIndex}');
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
  }) {
    final Uri $url =
        Uri.parse('/Studios/${name}/Images/${imageType}/${imageIndex}');
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
  }) {
    final Uri $url =
        Uri.parse('/Studios/${name}/Images/${imageType}/${imageIndex}');
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
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<dynamic>> _userImagePost({
    String? userId,
    required Object? body,
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
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _userImageDelete({String? userId}) {
    final Uri $url = Uri.parse('/UserImage');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<String>> _userImageGet({
    String? userId,
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
  }) {
    final Uri $url = Uri.parse('/UserImage');
    final Map<String, dynamic> $params = <String, dynamic>{
      'userId': userId,
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
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _userImageHead({
    String? userId,
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
  }) {
    final Uri $url = Uri.parse('/UserImage');
    final Map<String, dynamic> $params = <String, dynamic>{
      'userId': userId,
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
    );
    return client
        .send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>($request);
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
    );
    return client
        .send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>($request);
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
    );
    return client
        .send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>($request);
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
    );
    return client
        .send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>($request);
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
    );
    return client
        .send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>($request);
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
    );
    return client
        .send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>($request);
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
    );
    return client
        .send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>($request);
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
    );
    return client
        .send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>($request);
  }

  @override
  Future<Response<List<ExternalIdInfo>>> _itemsItemIdExternalIdInfosGet(
      {required String? itemId}) {
    final Uri $url = Uri.parse('/Items/${itemId}/ExternalIdInfos');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<ExternalIdInfo>, ExternalIdInfo>($request);
  }

  @override
  Future<Response<dynamic>> _itemsRemoteSearchApplyItemIdPost({
    required String? itemId,
    bool? replaceAllImages,
    required RemoteSearchResult? body,
  }) {
    final Uri $url = Uri.parse('/Items/RemoteSearch/Apply/${itemId}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'replaceAllImages': replaceAllImages
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<RemoteSearchResult>>> _itemsRemoteSearchBookPost(
      {required BookInfoRemoteSearchQuery? body}) {
    final Uri $url = Uri.parse('/Items/RemoteSearch/Book');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<List<RemoteSearchResult>, RemoteSearchResult>($request);
  }

  @override
  Future<Response<List<RemoteSearchResult>>> _itemsRemoteSearchBoxSetPost(
      {required BoxSetInfoRemoteSearchQuery? body}) {
    final Uri $url = Uri.parse('/Items/RemoteSearch/BoxSet');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<List<RemoteSearchResult>, RemoteSearchResult>($request);
  }

  @override
  Future<Response<List<RemoteSearchResult>>> _itemsRemoteSearchMoviePost(
      {required MovieInfoRemoteSearchQuery? body}) {
    final Uri $url = Uri.parse('/Items/RemoteSearch/Movie');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<List<RemoteSearchResult>, RemoteSearchResult>($request);
  }

  @override
  Future<Response<List<RemoteSearchResult>>> _itemsRemoteSearchMusicAlbumPost(
      {required AlbumInfoRemoteSearchQuery? body}) {
    final Uri $url = Uri.parse('/Items/RemoteSearch/MusicAlbum');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<List<RemoteSearchResult>, RemoteSearchResult>($request);
  }

  @override
  Future<Response<List<RemoteSearchResult>>> _itemsRemoteSearchMusicArtistPost(
      {required ArtistInfoRemoteSearchQuery? body}) {
    final Uri $url = Uri.parse('/Items/RemoteSearch/MusicArtist');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<List<RemoteSearchResult>, RemoteSearchResult>($request);
  }

  @override
  Future<Response<List<RemoteSearchResult>>> _itemsRemoteSearchMusicVideoPost(
      {required MusicVideoInfoRemoteSearchQuery? body}) {
    final Uri $url = Uri.parse('/Items/RemoteSearch/MusicVideo');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<List<RemoteSearchResult>, RemoteSearchResult>($request);
  }

  @override
  Future<Response<List<RemoteSearchResult>>> _itemsRemoteSearchPersonPost(
      {required PersonLookupInfoRemoteSearchQuery? body}) {
    final Uri $url = Uri.parse('/Items/RemoteSearch/Person');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<List<RemoteSearchResult>, RemoteSearchResult>($request);
  }

  @override
  Future<Response<List<RemoteSearchResult>>> _itemsRemoteSearchSeriesPost(
      {required SeriesInfoRemoteSearchQuery? body}) {
    final Uri $url = Uri.parse('/Items/RemoteSearch/Series');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<List<RemoteSearchResult>, RemoteSearchResult>($request);
  }

  @override
  Future<Response<List<RemoteSearchResult>>> _itemsRemoteSearchTrailerPost(
      {required TrailerInfoRemoteSearchQuery? body}) {
    final Uri $url = Uri.parse('/Items/RemoteSearch/Trailer');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
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
  }) {
    final Uri $url = Uri.parse('/Items/${itemId}/Refresh');
    final Map<String, dynamic> $params = <String, dynamic>{
      'metadataRefreshMode': metadataRefreshMode,
      'imageRefreshMode': imageRefreshMode,
      'replaceAllMetadata': replaceAllMetadata,
      'replaceAllImages': replaceAllImages,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _itemsGet({
    String? userId,
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
  }) {
    final Uri $url = Uri.parse('/Items');
    final Map<String, dynamic> $params = <String, dynamic>{
      'userId': userId,
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
    );
    return client
        .send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>($request);
  }

  @override
  Future<Response<dynamic>> _itemsDelete({List<String>? ids}) {
    final Uri $url = Uri.parse('/Items');
    final Map<String, dynamic> $params = <String, dynamic>{'ids': ids};
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<UserItemDataDto>> _userItemsItemIdUserDataGet({
    String? userId,
    required String? itemId,
  }) {
    final Uri $url = Uri.parse('/UserItems/${itemId}/UserData');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<UserItemDataDto, UserItemDataDto>($request);
  }

  @override
  Future<Response<UserItemDataDto>> _userItemsItemIdUserDataPost({
    String? userId,
    required String? itemId,
    required UpdateUserItemDataDto? body,
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
    );
    return client
        .send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>($request);
  }

  @override
  Future<Response<dynamic>> _itemsItemIdPost({
    required String? itemId,
    required BaseItemDto? body,
  }) {
    final Uri $url = Uri.parse('/Items/${itemId}');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _itemsItemIdDelete({required String? itemId}) {
    final Uri $url = Uri.parse('/Items/${itemId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<BaseItemDto>> _itemsItemIdGet({
    String? userId,
    required String? itemId,
  }) {
    final Uri $url = Uri.parse('/Items/${itemId}');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<BaseItemDto, BaseItemDto>($request);
  }

  @override
  Future<Response<dynamic>> _itemsItemIdContentTypePost({
    required String? itemId,
    String? contentType,
  }) {
    final Uri $url = Uri.parse('/Items/${itemId}/ContentType');
    final Map<String, dynamic> $params = <String, dynamic>{
      'contentType': contentType
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<MetadataEditorInfo>> _itemsItemIdMetadataEditorGet(
      {required String? itemId}) {
    final Uri $url = Uri.parse('/Items/${itemId}/MetadataEditor');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
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
    );
    return client
        .send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>($request);
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _artistsItemIdSimilarGet({
    required String? itemId,
    List<String>? excludeArtistIds,
    String? userId,
    int? limit,
    List<Object?>? fields,
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
    );
    return client
        .send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>($request);
  }

  @override
  Future<Response<List<BaseItemDto>>> _itemsItemIdAncestorsGet({
    required String? itemId,
    String? userId,
  }) {
    final Uri $url = Uri.parse('/Items/${itemId}/Ancestors');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<BaseItemDto>, BaseItemDto>($request);
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _itemsItemIdCriticReviewsGet(
      {required String? itemId}) {
    final Uri $url = Uri.parse('/Items/${itemId}/CriticReviews');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>($request);
  }

  @override
  Future<Response<String>> _itemsItemIdDownloadGet({required String? itemId}) {
    final Uri $url = Uri.parse('/Items/${itemId}/Download');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _itemsItemIdFileGet({required String? itemId}) {
    final Uri $url = Uri.parse('/Items/${itemId}/File');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
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
    );
    return client
        .send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>($request);
  }

  @override
  Future<Response<AllThemeMediaResult>> _itemsItemIdThemeMediaGet({
    required String? itemId,
    String? userId,
    bool? inheritFromParent,
    List<Object?>? sortBy,
    List<Object?>? sortOrder,
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
    );
    return client.send<ThemeMediaResult, ThemeMediaResult>($request);
  }

  @override
  Future<Response<ItemCounts>> _itemsCountsGet({
    String? userId,
    bool? isFavorite,
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
    );
    return client.send<ItemCounts, ItemCounts>($request);
  }

  @override
  Future<Response<LibraryOptionsResultDto>> _librariesAvailableOptionsGet({
    String? libraryContentType,
    bool? isNewLibrary,
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
    );
    return client
        .send<LibraryOptionsResultDto, LibraryOptionsResultDto>($request);
  }

  @override
  Future<Response<dynamic>> _libraryMediaUpdatedPost(
      {required MediaUpdateInfoDto? body}) {
    final Uri $url = Uri.parse('/Library/Media/Updated');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _libraryMediaFoldersGet(
      {bool? isHidden}) {
    final Uri $url = Uri.parse('/Library/MediaFolders');
    final Map<String, dynamic> $params = <String, dynamic>{
      'isHidden': isHidden
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>($request);
  }

  @override
  Future<Response<dynamic>> _libraryMoviesAddedPost({
    String? tmdbId,
    String? imdbId,
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
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _libraryMoviesUpdatedPost({
    String? tmdbId,
    String? imdbId,
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
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<String>>> _libraryPhysicalPathsGet() {
    final Uri $url = Uri.parse('/Library/PhysicalPaths');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<String>, String>($request);
  }

  @override
  Future<Response<dynamic>> _libraryRefreshPost() {
    final Uri $url = Uri.parse('/Library/Refresh');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _librarySeriesAddedPost({String? tvdbId}) {
    final Uri $url = Uri.parse('/Library/Series/Added');
    final Map<String, dynamic> $params = <String, dynamic>{'tvdbId': tvdbId};
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _librarySeriesUpdatedPost({String? tvdbId}) {
    final Uri $url = Uri.parse('/Library/Series/Updated');
    final Map<String, dynamic> $params = <String, dynamic>{'tvdbId': tvdbId};
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
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
    );
    return client
        .send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>($request);
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _showsItemIdSimilarGet({
    required String? itemId,
    List<String>? excludeArtistIds,
    String? userId,
    int? limit,
    List<Object?>? fields,
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
    );
    return client
        .send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>($request);
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _trailersItemIdSimilarGet({
    required String? itemId,
    List<String>? excludeArtistIds,
    String? userId,
    int? limit,
    List<Object?>? fields,
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
    );
    return client
        .send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>($request);
  }

  @override
  Future<Response<List<VirtualFolderInfo>>> _libraryVirtualFoldersGet() {
    final Uri $url = Uri.parse('/Library/VirtualFolders');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
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
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _libraryVirtualFoldersDelete({
    String? name,
    bool? refreshLibrary,
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
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _libraryVirtualFoldersLibraryOptionsPost(
      {required UpdateLibraryOptionsDto? body}) {
    final Uri $url = Uri.parse('/Library/VirtualFolders/LibraryOptions');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _libraryVirtualFoldersNamePost({
    String? name,
    String? newName,
    bool? refreshLibrary,
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
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _libraryVirtualFoldersPathsPost({
    bool? refreshLibrary,
    required MediaPathDto? body,
  }) {
    final Uri $url = Uri.parse('/Library/VirtualFolders/Paths');
    final Map<String, dynamic> $params = <String, dynamic>{
      'refreshLibrary': refreshLibrary
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _libraryVirtualFoldersPathsDelete({
    String? name,
    String? path,
    bool? refreshLibrary,
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
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _libraryVirtualFoldersPathsUpdatePost(
      {required UpdateMediaPathRequestDto? body}) {
    final Uri $url = Uri.parse('/Library/VirtualFolders/Paths/Update');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<ChannelMappingOptionsDto>> _liveTvChannelMappingOptionsGet(
      {String? providerId}) {
    final Uri $url = Uri.parse('/LiveTv/ChannelMappingOptions');
    final Map<String, dynamic> $params = <String, dynamic>{
      'providerId': providerId
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<ChannelMappingOptionsDto, ChannelMappingOptionsDto>($request);
  }

  @override
  Future<Response<TunerChannelMapping>> _liveTvChannelMappingsPost(
      {required SetChannelMappingDto? body}) {
    final Uri $url = Uri.parse('/LiveTv/ChannelMappings');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
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
    );
    return client
        .send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>($request);
  }

  @override
  Future<Response<BaseItemDto>> _liveTvChannelsChannelIdGet({
    required String? channelId,
    String? userId,
  }) {
    final Uri $url = Uri.parse('/LiveTv/Channels/${channelId}');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<BaseItemDto, BaseItemDto>($request);
  }

  @override
  Future<Response<GuideInfo>> _liveTvGuideInfoGet() {
    final Uri $url = Uri.parse('/LiveTv/GuideInfo');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<GuideInfo, GuideInfo>($request);
  }

  @override
  Future<Response<LiveTvInfo>> _liveTvInfoGet() {
    final Uri $url = Uri.parse('/LiveTv/Info');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<LiveTvInfo, LiveTvInfo>($request);
  }

  @override
  Future<Response<ListingsProviderInfo>> _liveTvListingProvidersPost({
    String? pw,
    bool? validateListings,
    bool? validateLogin,
    required ListingsProviderInfo? body,
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
    );
    return client.send<ListingsProviderInfo, ListingsProviderInfo>($request);
  }

  @override
  Future<Response<dynamic>> _liveTvListingProvidersDelete({String? id}) {
    final Uri $url = Uri.parse('/LiveTv/ListingProviders');
    final Map<String, dynamic> $params = <String, dynamic>{'id': id};
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<ListingsProviderInfo>> _liveTvListingProvidersDefaultGet() {
    final Uri $url = Uri.parse('/LiveTv/ListingProviders/Default');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<ListingsProviderInfo, ListingsProviderInfo>($request);
  }

  @override
  Future<Response<List<NameIdPair>>> _liveTvListingProvidersLineupsGet({
    String? id,
    String? type,
    String? location,
    String? country,
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
    );
    return client.send<List<NameIdPair>, NameIdPair>($request);
  }

  @override
  Future<Response<String>>
      _liveTvListingProvidersSchedulesDirectCountriesGet() {
    final Uri $url =
        Uri.parse('/LiveTv/ListingProviders/SchedulesDirect/Countries');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _liveTvLiveRecordingsRecordingIdStreamGet(
      {required String? recordingId}) {
    final Uri $url = Uri.parse('/LiveTv/LiveRecordings/${recordingId}/stream');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _liveTvLiveStreamFilesStreamIdStreamContainerGet({
    required String? streamId,
    required String? container,
  }) {
    final Uri $url =
        Uri.parse('/LiveTv/LiveStreamFiles/${streamId}/stream.${container}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
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
    );
    return client
        .send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>($request);
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _liveTvProgramsPost(
      {required GetProgramsDto? body}) {
    final Uri $url = Uri.parse('/LiveTv/Programs');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client
        .send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>($request);
  }

  @override
  Future<Response<BaseItemDto>> _liveTvProgramsProgramIdGet({
    required String? programId,
    String? userId,
  }) {
    final Uri $url = Uri.parse('/LiveTv/Programs/${programId}');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<BaseItemDto, BaseItemDto>($request);
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _liveTvProgramsRecommendedGet({
    String? userId,
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
  }) {
    final Uri $url = Uri.parse('/LiveTv/Programs/Recommended');
    final Map<String, dynamic> $params = <String, dynamic>{
      'userId': userId,
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
    );
    return client
        .send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>($request);
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
    );
    return client
        .send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>($request);
  }

  @override
  Future<Response<BaseItemDto>> _liveTvRecordingsRecordingIdGet({
    required String? recordingId,
    String? userId,
  }) {
    final Uri $url = Uri.parse('/LiveTv/Recordings/${recordingId}');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<BaseItemDto, BaseItemDto>($request);
  }

  @override
  Future<Response<dynamic>> _liveTvRecordingsRecordingIdDelete(
      {required String? recordingId}) {
    final Uri $url = Uri.parse('/LiveTv/Recordings/${recordingId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _liveTvRecordingsFoldersGet(
      {String? userId}) {
    final Uri $url = Uri.parse('/LiveTv/Recordings/Folders');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>($request);
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _liveTvRecordingsGroupsGet(
      {String? userId}) {
    final Uri $url = Uri.parse('/LiveTv/Recordings/Groups');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>($request);
  }

  @override
  Future<Response<dynamic>> _liveTvRecordingsGroupsGroupIdGet(
      {required String? groupId}) {
    final Uri $url = Uri.parse('/LiveTv/Recordings/Groups/${groupId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
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
    );
    return client
        .send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>($request);
  }

  @override
  Future<Response<SeriesTimerInfoDtoQueryResult>> _liveTvSeriesTimersGet({
    String? sortBy,
    String? sortOrder,
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
    );
    return client.send<SeriesTimerInfoDtoQueryResult,
        SeriesTimerInfoDtoQueryResult>($request);
  }

  @override
  Future<Response<dynamic>> _liveTvSeriesTimersPost(
      {required SeriesTimerInfoDto? body}) {
    final Uri $url = Uri.parse('/LiveTv/SeriesTimers');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<SeriesTimerInfoDto>> _liveTvSeriesTimersTimerIdGet(
      {required String? timerId}) {
    final Uri $url = Uri.parse('/LiveTv/SeriesTimers/${timerId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<SeriesTimerInfoDto, SeriesTimerInfoDto>($request);
  }

  @override
  Future<Response<dynamic>> _liveTvSeriesTimersTimerIdDelete(
      {required String? timerId}) {
    final Uri $url = Uri.parse('/LiveTv/SeriesTimers/${timerId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _liveTvSeriesTimersTimerIdPost({
    required String? timerId,
    required SeriesTimerInfoDto? body,
  }) {
    final Uri $url = Uri.parse('/LiveTv/SeriesTimers/${timerId}');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<TimerInfoDtoQueryResult>> _liveTvTimersGet({
    String? channelId,
    String? seriesTimerId,
    bool? isActive,
    bool? isScheduled,
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
    );
    return client
        .send<TimerInfoDtoQueryResult, TimerInfoDtoQueryResult>($request);
  }

  @override
  Future<Response<dynamic>> _liveTvTimersPost({required TimerInfoDto? body}) {
    final Uri $url = Uri.parse('/LiveTv/Timers');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<TimerInfoDto>> _liveTvTimersTimerIdGet(
      {required String? timerId}) {
    final Uri $url = Uri.parse('/LiveTv/Timers/${timerId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<TimerInfoDto, TimerInfoDto>($request);
  }

  @override
  Future<Response<dynamic>> _liveTvTimersTimerIdDelete(
      {required String? timerId}) {
    final Uri $url = Uri.parse('/LiveTv/Timers/${timerId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _liveTvTimersTimerIdPost({
    required String? timerId,
    required TimerInfoDto? body,
  }) {
    final Uri $url = Uri.parse('/LiveTv/Timers/${timerId}');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<SeriesTimerInfoDto>> _liveTvTimersDefaultsGet(
      {String? programId}) {
    final Uri $url = Uri.parse('/LiveTv/Timers/Defaults');
    final Map<String, dynamic> $params = <String, dynamic>{
      'programId': programId
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<SeriesTimerInfoDto, SeriesTimerInfoDto>($request);
  }

  @override
  Future<Response<TunerHostInfo>> _liveTvTunerHostsPost(
      {required TunerHostInfo? body}) {
    final Uri $url = Uri.parse('/LiveTv/TunerHosts');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<TunerHostInfo, TunerHostInfo>($request);
  }

  @override
  Future<Response<dynamic>> _liveTvTunerHostsDelete({String? id}) {
    final Uri $url = Uri.parse('/LiveTv/TunerHosts');
    final Map<String, dynamic> $params = <String, dynamic>{'id': id};
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<NameIdPair>>> _liveTvTunerHostsTypesGet() {
    final Uri $url = Uri.parse('/LiveTv/TunerHosts/Types');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<NameIdPair>, NameIdPair>($request);
  }

  @override
  Future<Response<dynamic>> _liveTvTunersTunerIdResetPost(
      {required String? tunerId}) {
    final Uri $url = Uri.parse('/LiveTv/Tuners/${tunerId}/Reset');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<TunerHostInfo>>> _liveTvTunersDiscoverGet(
      {bool? newDevicesOnly}) {
    final Uri $url = Uri.parse('/LiveTv/Tuners/Discover');
    final Map<String, dynamic> $params = <String, dynamic>{
      'newDevicesOnly': newDevicesOnly
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<TunerHostInfo>, TunerHostInfo>($request);
  }

  @override
  Future<Response<List<TunerHostInfo>>> _liveTvTunersDiscvoverGet(
      {bool? newDevicesOnly}) {
    final Uri $url = Uri.parse('/LiveTv/Tuners/Discvover');
    final Map<String, dynamic> $params = <String, dynamic>{
      'newDevicesOnly': newDevicesOnly
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<TunerHostInfo>, TunerHostInfo>($request);
  }

  @override
  Future<Response<List<CountryInfo>>> _localizationCountriesGet() {
    final Uri $url = Uri.parse('/Localization/Countries');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<CountryInfo>, CountryInfo>($request);
  }

  @override
  Future<Response<List<CultureDto>>> _localizationCulturesGet() {
    final Uri $url = Uri.parse('/Localization/Cultures');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<CultureDto>, CultureDto>($request);
  }

  @override
  Future<Response<List<LocalizationOption>>> _localizationOptionsGet() {
    final Uri $url = Uri.parse('/Localization/Options');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<LocalizationOption>, LocalizationOption>($request);
  }

  @override
  Future<Response<List<ParentalRating>>> _localizationParentalRatingsGet() {
    final Uri $url = Uri.parse('/Localization/ParentalRatings');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<ParentalRating>, ParentalRating>($request);
  }

  @override
  Future<Response<LyricDto>> _audioItemIdLyricsGet({required String? itemId}) {
    final Uri $url = Uri.parse('/Audio/${itemId}/Lyrics');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<LyricDto, LyricDto>($request);
  }

  @override
  Future<Response<LyricDto>> _audioItemIdLyricsPost({
    required String? itemId,
    required String? fileName,
    required Object? body,
  }) {
    final Uri $url = Uri.parse('/Audio/${itemId}/Lyrics');
    final Map<String, dynamic> $params = <String, dynamic>{
      'fileName': fileName
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client.send<LyricDto, LyricDto>($request);
  }

  @override
  Future<Response<dynamic>> _audioItemIdLyricsDelete(
      {required String? itemId}) {
    final Uri $url = Uri.parse('/Audio/${itemId}/Lyrics');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<RemoteLyricInfoDto>>> _audioItemIdRemoteSearchLyricsGet(
      {required String? itemId}) {
    final Uri $url = Uri.parse('/Audio/${itemId}/RemoteSearch/Lyrics');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<RemoteLyricInfoDto>, RemoteLyricInfoDto>($request);
  }

  @override
  Future<Response<LyricDto>> _audioItemIdRemoteSearchLyricsLyricIdPost({
    required String? itemId,
    required String? lyricId,
  }) {
    final Uri $url =
        Uri.parse('/Audio/${itemId}/RemoteSearch/Lyrics/${lyricId}');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<LyricDto, LyricDto>($request);
  }

  @override
  Future<Response<LyricDto>> _providersLyricsLyricIdGet(
      {required String? lyricId}) {
    final Uri $url = Uri.parse('/Providers/Lyrics/${lyricId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<LyricDto, LyricDto>($request);
  }

  @override
  Future<Response<PlaybackInfoResponse>> _itemsItemIdPlaybackInfoGet({
    required String? itemId,
    String? userId,
  }) {
    final Uri $url = Uri.parse('/Items/${itemId}/PlaybackInfo');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
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
    );
    return client.send<PlaybackInfoResponse, PlaybackInfoResponse>($request);
  }

  @override
  Future<Response<dynamic>> _liveStreamsClosePost(
      {required String? liveStreamId}) {
    final Uri $url = Uri.parse('/LiveStreams/Close');
    final Map<String, dynamic> $params = <String, dynamic>{
      'liveStreamId': liveStreamId
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
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
    );
    return client.send<LiveStreamResponse, LiveStreamResponse>($request);
  }

  @override
  Future<Response<String>> _playbackBitrateTestGet({int? size}) {
    final Uri $url = Uri.parse('/Playback/BitrateTest');
    final Map<String, dynamic> $params = <String, dynamic>{'size': size};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<MediaSegmentDtoQueryResult>> _mediaSegmentsItemIdGet({
    required String? itemId,
    List<Object?>? includeSegmentTypes,
  }) {
    final Uri $url = Uri.parse('/MediaSegments/${itemId}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'includeSegmentTypes': includeSegmentTypes
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<MediaSegmentDtoQueryResult, MediaSegmentDtoQueryResult>($request);
  }

  @override
  Future<Response<List<RecommendationDto>>> _moviesRecommendationsGet({
    String? userId,
    String? parentId,
    List<Object?>? fields,
    int? categoryLimit,
    int? itemLimit,
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
    );
    return client
        .send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>($request);
  }

  @override
  Future<Response<BaseItemDto>> _musicGenresGenreNameGet({
    required String? genreName,
    String? userId,
  }) {
    final Uri $url = Uri.parse('/MusicGenres/${genreName}');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<BaseItemDto, BaseItemDto>($request);
  }

  @override
  Future<Response<List<PackageInfo>>> _packagesGet() {
    final Uri $url = Uri.parse('/Packages');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<PackageInfo>, PackageInfo>($request);
  }

  @override
  Future<Response<PackageInfo>> _packagesNameGet({
    required String? name,
    String? assemblyGuid,
  }) {
    final Uri $url = Uri.parse('/Packages/${name}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'assemblyGuid': assemblyGuid
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<PackageInfo, PackageInfo>($request);
  }

  @override
  Future<Response<dynamic>> _packagesInstalledNamePost({
    required String? name,
    String? assemblyGuid,
    String? version,
    String? repositoryUrl,
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
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _packagesInstallingPackageIdDelete(
      {required String? packageId}) {
    final Uri $url = Uri.parse('/Packages/Installing/${packageId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<RepositoryInfo>>> _repositoriesGet() {
    final Uri $url = Uri.parse('/Repositories');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<RepositoryInfo>, RepositoryInfo>($request);
  }

  @override
  Future<Response<dynamic>> _repositoriesPost(
      {required List<RepositoryInfo>? body}) {
    final Uri $url = Uri.parse('/Repositories');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
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
    );
    return client
        .send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>($request);
  }

  @override
  Future<Response<BaseItemDto>> _personsNameGet({
    required String? name,
    String? userId,
  }) {
    final Uri $url = Uri.parse('/Persons/${name}');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<BaseItemDto, BaseItemDto>($request);
  }

  @override
  Future<Response<PlaylistCreationResult>> _playlistsPost({
    String? name,
    List<String>? ids,
    String? userId,
    String? mediaType,
    required CreatePlaylistDto? body,
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
    );
    return client
        .send<PlaylistCreationResult, PlaylistCreationResult>($request);
  }

  @override
  Future<Response<dynamic>> _playlistsPlaylistIdPost({
    required String? playlistId,
    required UpdatePlaylistDto? body,
  }) {
    final Uri $url = Uri.parse('/Playlists/${playlistId}');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<PlaylistDto>> _playlistsPlaylistIdGet(
      {required String? playlistId}) {
    final Uri $url = Uri.parse('/Playlists/${playlistId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<PlaylistDto, PlaylistDto>($request);
  }

  @override
  Future<Response<dynamic>> _playlistsPlaylistIdItemsPost({
    required String? playlistId,
    List<String>? ids,
    String? userId,
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
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _playlistsPlaylistIdItemsDelete({
    required String? playlistId,
    List<String>? entryIds,
  }) {
    final Uri $url = Uri.parse('/Playlists/${playlistId}/Items');
    final Map<String, dynamic> $params = <String, dynamic>{
      'entryIds': entryIds
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      parameters: $params,
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
    );
    return client
        .send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>($request);
  }

  @override
  Future<Response<dynamic>> _playlistsPlaylistIdItemsItemIdMoveNewIndexPost({
    required String? playlistId,
    required String? itemId,
    required int? newIndex,
  }) {
    final Uri $url =
        Uri.parse('/Playlists/${playlistId}/Items/${itemId}/Move/${newIndex}');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<PlaylistUserPermissions>>> _playlistsPlaylistIdUsersGet(
      {required String? playlistId}) {
    final Uri $url = Uri.parse('/Playlists/${playlistId}/Users');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<List<PlaylistUserPermissions>, PlaylistUserPermissions>($request);
  }

  @override
  Future<Response<PlaylistUserPermissions>> _playlistsPlaylistIdUsersUserIdGet({
    required String? playlistId,
    required String? userId,
  }) {
    final Uri $url = Uri.parse('/Playlists/${playlistId}/Users/${userId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<PlaylistUserPermissions, PlaylistUserPermissions>($request);
  }

  @override
  Future<Response<dynamic>> _playlistsPlaylistIdUsersUserIdPost({
    required String? playlistId,
    required String? userId,
    required UpdatePlaylistUserDto? body,
  }) {
    final Uri $url = Uri.parse('/Playlists/${playlistId}/Users/${userId}');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _playlistsPlaylistIdUsersUserIdDelete({
    required String? playlistId,
    required String? userId,
  }) {
    final Uri $url = Uri.parse('/Playlists/${playlistId}/Users/${userId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
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
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _sessionsPlayingPost(
      {required PlaybackStartInfo? body}) {
    final Uri $url = Uri.parse('/Sessions/Playing');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _sessionsPlayingPingPost(
      {required String? playSessionId}) {
    final Uri $url = Uri.parse('/Sessions/Playing/Ping');
    final Map<String, dynamic> $params = <String, dynamic>{
      'playSessionId': playSessionId
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _sessionsPlayingProgressPost(
      {required PlaybackProgressInfo? body}) {
    final Uri $url = Uri.parse('/Sessions/Playing/Progress');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _sessionsPlayingStoppedPost(
      {required PlaybackStopInfo? body}) {
    final Uri $url = Uri.parse('/Sessions/Playing/Stopped');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<UserItemDataDto>> _userPlayedItemsItemIdPost({
    String? userId,
    required String? itemId,
    DateTime? datePlayed,
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
    );
    return client.send<UserItemDataDto, UserItemDataDto>($request);
  }

  @override
  Future<Response<UserItemDataDto>> _userPlayedItemsItemIdDelete({
    String? userId,
    required String? itemId,
  }) {
    final Uri $url = Uri.parse('/UserPlayedItems/${itemId}');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<UserItemDataDto, UserItemDataDto>($request);
  }

  @override
  Future<Response<List<PluginInfo>>> _pluginsGet() {
    final Uri $url = Uri.parse('/Plugins');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<PluginInfo>, PluginInfo>($request);
  }

  @override
  Future<Response<dynamic>> _pluginsPluginIdDelete(
      {required String? pluginId}) {
    final Uri $url = Uri.parse('/Plugins/${pluginId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _pluginsPluginIdVersionDelete({
    required String? pluginId,
    required String? version,
  }) {
    final Uri $url = Uri.parse('/Plugins/${pluginId}/${version}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _pluginsPluginIdVersionDisablePost({
    required String? pluginId,
    required String? version,
  }) {
    final Uri $url = Uri.parse('/Plugins/${pluginId}/${version}/Disable');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _pluginsPluginIdVersionEnablePost({
    required String? pluginId,
    required String? version,
  }) {
    final Uri $url = Uri.parse('/Plugins/${pluginId}/${version}/Enable');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<String>> _pluginsPluginIdVersionImageGet({
    required String? pluginId,
    required String? version,
  }) {
    final Uri $url = Uri.parse('/Plugins/${pluginId}/${version}/Image');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<BasePluginConfiguration>> _pluginsPluginIdConfigurationGet(
      {required String? pluginId}) {
    final Uri $url = Uri.parse('/Plugins/${pluginId}/Configuration');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<BasePluginConfiguration, BasePluginConfiguration>($request);
  }

  @override
  Future<Response<dynamic>> _pluginsPluginIdConfigurationPost(
      {required String? pluginId}) {
    final Uri $url = Uri.parse('/Plugins/${pluginId}/Configuration');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _pluginsPluginIdManifestPost(
      {required String? pluginId}) {
    final Uri $url = Uri.parse('/Plugins/${pluginId}/Manifest');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<bool>> _quickConnectAuthorizePost({
    required String? code,
    String? userId,
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
    );
    return client.send<bool, bool>($request);
  }

  @override
  Future<Response<QuickConnectResult>> _quickConnectConnectGet(
      {required String? secret}) {
    final Uri $url = Uri.parse('/QuickConnect/Connect');
    final Map<String, dynamic> $params = <String, dynamic>{'secret': secret};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<QuickConnectResult, QuickConnectResult>($request);
  }

  @override
  Future<Response<bool>> _quickConnectEnabledGet() {
    final Uri $url = Uri.parse('/QuickConnect/Enabled');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<bool, bool>($request);
  }

  @override
  Future<Response<QuickConnectResult>> _quickConnectInitiatePost() {
    final Uri $url = Uri.parse('/QuickConnect/Initiate');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
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
    );
    return client.send<RemoteImageResult, RemoteImageResult>($request);
  }

  @override
  Future<Response<dynamic>> _itemsItemIdRemoteImagesDownloadPost({
    required String? itemId,
    required String? type,
    String? imageUrl,
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
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<ImageProviderInfo>>>
      _itemsItemIdRemoteImagesProvidersGet({required String? itemId}) {
    final Uri $url = Uri.parse('/Items/${itemId}/RemoteImages/Providers');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<ImageProviderInfo>, ImageProviderInfo>($request);
  }

  @override
  Future<Response<List<TaskInfo>>> _scheduledTasksGet({
    bool? isHidden,
    bool? isEnabled,
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
    );
    return client.send<List<TaskInfo>, TaskInfo>($request);
  }

  @override
  Future<Response<TaskInfo>> _scheduledTasksTaskIdGet(
      {required String? taskId}) {
    final Uri $url = Uri.parse('/ScheduledTasks/${taskId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<TaskInfo, TaskInfo>($request);
  }

  @override
  Future<Response<dynamic>> _scheduledTasksTaskIdTriggersPost({
    required String? taskId,
    required List<TaskTriggerInfo>? body,
  }) {
    final Uri $url = Uri.parse('/ScheduledTasks/${taskId}/Triggers');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _scheduledTasksRunningTaskIdPost(
      {required String? taskId}) {
    final Uri $url = Uri.parse('/ScheduledTasks/Running/${taskId}');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _scheduledTasksRunningTaskIdDelete(
      {required String? taskId}) {
    final Uri $url = Uri.parse('/ScheduledTasks/Running/${taskId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
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
    );
    return client.send<SearchHintResult, SearchHintResult>($request);
  }

  @override
  Future<Response<List<NameIdPair>>> _authPasswordResetProvidersGet() {
    final Uri $url = Uri.parse('/Auth/PasswordResetProviders');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<NameIdPair>, NameIdPair>($request);
  }

  @override
  Future<Response<List<NameIdPair>>> _authProvidersGet() {
    final Uri $url = Uri.parse('/Auth/Providers');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<NameIdPair>, NameIdPair>($request);
  }

  @override
  Future<Response<List<SessionInfoDto>>> _sessionsGet({
    String? controllableByUserId,
    String? deviceId,
    int? activeWithinSeconds,
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
    );
    return client.send<List<SessionInfoDto>, SessionInfoDto>($request);
  }

  @override
  Future<Response<dynamic>> _sessionsSessionIdCommandPost({
    required String? sessionId,
    required GeneralCommand? body,
  }) {
    final Uri $url = Uri.parse('/Sessions/${sessionId}/Command');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _sessionsSessionIdCommandCommandPost({
    required String? sessionId,
    required String? command,
  }) {
    final Uri $url = Uri.parse('/Sessions/${sessionId}/Command/${command}');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _sessionsSessionIdMessagePost({
    required String? sessionId,
    required MessageCommand? body,
  }) {
    final Uri $url = Uri.parse('/Sessions/${sessionId}/Message');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
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
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _sessionsSessionIdPlayingCommandPost({
    required String? sessionId,
    required String? command,
    int? seekPositionTicks,
    String? controllingUserId,
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
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _sessionsSessionIdSystemCommandPost({
    required String? sessionId,
    required String? command,
  }) {
    final Uri $url = Uri.parse('/Sessions/${sessionId}/System/${command}');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _sessionsSessionIdUserUserIdPost({
    required String? sessionId,
    required String? userId,
  }) {
    final Uri $url = Uri.parse('/Sessions/${sessionId}/User/${userId}');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _sessionsSessionIdUserUserIdDelete({
    required String? sessionId,
    required String? userId,
  }) {
    final Uri $url = Uri.parse('/Sessions/${sessionId}/User/${userId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _sessionsSessionIdViewingPost({
    required String? sessionId,
    required String? itemType,
    required String? itemId,
    required String? itemName,
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
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _sessionsCapabilitiesFullPost({
    String? id,
    required ClientCapabilitiesDto? body,
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
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _sessionsLogoutPost() {
    final Uri $url = Uri.parse('/Sessions/Logout');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _sessionsViewingPost({
    String? sessionId,
    required String? itemId,
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
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _startupCompletePost() {
    final Uri $url = Uri.parse('/Startup/Complete');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<StartupConfigurationDto>> _startupConfigurationGet() {
    final Uri $url = Uri.parse('/Startup/Configuration');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<StartupConfigurationDto, StartupConfigurationDto>($request);
  }

  @override
  Future<Response<dynamic>> _startupConfigurationPost(
      {required StartupConfigurationDto? body}) {
    final Uri $url = Uri.parse('/Startup/Configuration');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<StartupUserDto>> _startupFirstUserGet() {
    final Uri $url = Uri.parse('/Startup/FirstUser');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<StartupUserDto, StartupUserDto>($request);
  }

  @override
  Future<Response<dynamic>> _startupRemoteAccessPost(
      {required StartupRemoteAccessDto? body}) {
    final Uri $url = Uri.parse('/Startup/RemoteAccess');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<StartupUserDto>> _startupUserGet() {
    final Uri $url = Uri.parse('/Startup/User');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<StartupUserDto, StartupUserDto>($request);
  }

  @override
  Future<Response<dynamic>> _startupUserPost({required StartupUserDto? body}) {
    final Uri $url = Uri.parse('/Startup/User');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
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
    );
    return client
        .send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>($request);
  }

  @override
  Future<Response<BaseItemDto>> _studiosNameGet({
    required String? name,
    String? userId,
  }) {
    final Uri $url = Uri.parse('/Studios/${name}');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<BaseItemDto, BaseItemDto>($request);
  }

  @override
  Future<Response<List<FontFile>>> _fallbackFontFontsGet() {
    final Uri $url = Uri.parse('/FallbackFont/Fonts');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<FontFile>, FontFile>($request);
  }

  @override
  Future<Response<String>> _fallbackFontFontsNameGet({required String? name}) {
    final Uri $url = Uri.parse('/FallbackFont/Fonts/${name}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<List<RemoteSubtitleInfo>>>
      _itemsItemIdRemoteSearchSubtitlesLanguageGet({
    required String? itemId,
    required String? language,
    bool? isPerfectMatch,
  }) {
    final Uri $url =
        Uri.parse('/Items/${itemId}/RemoteSearch/Subtitles/${language}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'isPerfectMatch': isPerfectMatch
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<RemoteSubtitleInfo>, RemoteSubtitleInfo>($request);
  }

  @override
  Future<Response<dynamic>> _itemsItemIdRemoteSearchSubtitlesSubtitleIdPost({
    required String? itemId,
    required String? subtitleId,
  }) {
    final Uri $url =
        Uri.parse('/Items/${itemId}/RemoteSearch/Subtitles/${subtitleId}');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<String>> _providersSubtitlesSubtitlesSubtitleIdGet(
      {required String? subtitleId}) {
    final Uri $url = Uri.parse('/Providers/Subtitles/Subtitles/${subtitleId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
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
  }) {
    final Uri $url = Uri.parse(
        '/Videos/${itemId}/${mediaSourceId}/Subtitles/${index}/subtitles.m3u8');
    final Map<String, dynamic> $params = <String, dynamic>{
      'segmentLength': segmentLength
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<dynamic>> _videosItemIdSubtitlesPost({
    required String? itemId,
    required UploadSubtitleDto? body,
  }) {
    final Uri $url = Uri.parse('/Videos/${itemId}/Subtitles');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _videosItemIdSubtitlesIndexDelete({
    required String? itemId,
    required int? index,
  }) {
    final Uri $url = Uri.parse('/Videos/${itemId}/Subtitles/${index}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
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
  }) {
    final Uri $url = Uri.parse(
        '/Videos/${routeItemId}/${routeMediaSourceId}/Subtitles/${routeIndex}/${routeStartPositionTicks}/Stream.${routeFormat}');
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
  }) {
    final Uri $url = Uri.parse(
        '/Videos/${routeItemId}/${routeMediaSourceId}/Subtitles/${routeIndex}/Stream.${routeFormat}');
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
    );
    return client
        .send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>($request);
  }

  @override
  Future<Response<dynamic>> _syncPlayBufferingPost(
      {required BufferRequestDto? body}) {
    final Uri $url = Uri.parse('/SyncPlay/Buffering');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _syncPlayJoinPost(
      {required JoinGroupRequestDto? body}) {
    final Uri $url = Uri.parse('/SyncPlay/Join');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _syncPlayLeavePost() {
    final Uri $url = Uri.parse('/SyncPlay/Leave');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<GroupInfoDto>>> _syncPlayListGet() {
    final Uri $url = Uri.parse('/SyncPlay/List');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<GroupInfoDto>, GroupInfoDto>($request);
  }

  @override
  Future<Response<dynamic>> _syncPlayMovePlaylistItemPost(
      {required MovePlaylistItemRequestDto? body}) {
    final Uri $url = Uri.parse('/SyncPlay/MovePlaylistItem');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _syncPlayNewPost(
      {required NewGroupRequestDto? body}) {
    final Uri $url = Uri.parse('/SyncPlay/New');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _syncPlayNextItemPost(
      {required NextItemRequestDto? body}) {
    final Uri $url = Uri.parse('/SyncPlay/NextItem');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _syncPlayPausePost() {
    final Uri $url = Uri.parse('/SyncPlay/Pause');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _syncPlayPingPost({required PingRequestDto? body}) {
    final Uri $url = Uri.parse('/SyncPlay/Ping');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _syncPlayPreviousItemPost(
      {required PreviousItemRequestDto? body}) {
    final Uri $url = Uri.parse('/SyncPlay/PreviousItem');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _syncPlayQueuePost(
      {required QueueRequestDto? body}) {
    final Uri $url = Uri.parse('/SyncPlay/Queue');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _syncPlayReadyPost(
      {required ReadyRequestDto? body}) {
    final Uri $url = Uri.parse('/SyncPlay/Ready');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _syncPlayRemoveFromPlaylistPost(
      {required RemoveFromPlaylistRequestDto? body}) {
    final Uri $url = Uri.parse('/SyncPlay/RemoveFromPlaylist');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _syncPlaySeekPost({required SeekRequestDto? body}) {
    final Uri $url = Uri.parse('/SyncPlay/Seek');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _syncPlaySetIgnoreWaitPost(
      {required IgnoreWaitRequestDto? body}) {
    final Uri $url = Uri.parse('/SyncPlay/SetIgnoreWait');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _syncPlaySetNewQueuePost(
      {required PlayRequestDto? body}) {
    final Uri $url = Uri.parse('/SyncPlay/SetNewQueue');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _syncPlaySetPlaylistItemPost(
      {required SetPlaylistItemRequestDto? body}) {
    final Uri $url = Uri.parse('/SyncPlay/SetPlaylistItem');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _syncPlaySetRepeatModePost(
      {required SetRepeatModeRequestDto? body}) {
    final Uri $url = Uri.parse('/SyncPlay/SetRepeatMode');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _syncPlaySetShuffleModePost(
      {required SetShuffleModeRequestDto? body}) {
    final Uri $url = Uri.parse('/SyncPlay/SetShuffleMode');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _syncPlayStopPost() {
    final Uri $url = Uri.parse('/SyncPlay/Stop');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _syncPlayUnpausePost() {
    final Uri $url = Uri.parse('/SyncPlay/Unpause');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<EndPointInfo>> _systemEndpointGet() {
    final Uri $url = Uri.parse('/System/Endpoint');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<EndPointInfo, EndPointInfo>($request);
  }

  @override
  Future<Response<SystemInfo>> _systemInfoGet() {
    final Uri $url = Uri.parse('/System/Info');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<SystemInfo, SystemInfo>($request);
  }

  @override
  Future<Response<PublicSystemInfo>> _systemInfoPublicGet() {
    final Uri $url = Uri.parse('/System/Info/Public');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<PublicSystemInfo, PublicSystemInfo>($request);
  }

  @override
  Future<Response<List<LogFile>>> _systemLogsGet() {
    final Uri $url = Uri.parse('/System/Logs');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<LogFile>, LogFile>($request);
  }

  @override
  Future<Response<String>> _systemLogsLogGet({required String? name}) {
    final Uri $url = Uri.parse('/System/Logs/Log');
    final Map<String, dynamic> $params = <String, dynamic>{'name': name};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _systemPingGet() {
    final Uri $url = Uri.parse('/System/Ping');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _systemPingPost() {
    final Uri $url = Uri.parse('/System/Ping');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<dynamic>> _systemRestartPost() {
    final Uri $url = Uri.parse('/System/Restart');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _systemShutdownPost() {
    final Uri $url = Uri.parse('/System/Shutdown');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<WakeOnLanInfo>>> _systemWakeOnLanInfoGet() {
    final Uri $url = Uri.parse('/System/WakeOnLanInfo');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<WakeOnLanInfo>, WakeOnLanInfo>($request);
  }

  @override
  Future<Response<UtcTimeResponse>> _getUtcTimeGet() {
    final Uri $url = Uri.parse('/GetUtcTime');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<UtcTimeResponse, UtcTimeResponse>($request);
  }

  @override
  Future<Response<ConfigImageTypes>> _tmdbClientConfigurationGet() {
    final Uri $url = Uri.parse('/Tmdb/ClientConfiguration');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
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
    );
    return client
        .send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>($request);
  }

  @override
  Future<Response<String>> _videosItemIdTrickplayWidthIndexJpgGet({
    required String? itemId,
    required int? width,
    required int? index,
    String? mediaSourceId,
  }) {
    final Uri $url =
        Uri.parse('/Videos/${itemId}/Trickplay/${width}/${index}.jpg');
    final Map<String, dynamic> $params = <String, dynamic>{
      'mediaSourceId': mediaSourceId
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<String>> _videosItemIdTrickplayWidthTilesM3u8Get({
    required String? itemId,
    required int? width,
    String? mediaSourceId,
  }) {
    final Uri $url =
        Uri.parse('/Videos/${itemId}/Trickplay/${width}/tiles.m3u8');
    final Map<String, dynamic> $params = <String, dynamic>{
      'mediaSourceId': mediaSourceId
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
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
    );
    return client
        .send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>($request);
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
    );
    return client
        .send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>($request);
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
    );
    return client
        .send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>($request);
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
    );
    return client
        .send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>($request);
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
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<List<UserDto>>> _usersGet({
    bool? isHidden,
    bool? isDisabled,
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
    );
    return client.send<List<UserDto>, UserDto>($request);
  }

  @override
  Future<Response<dynamic>> _usersPost({
    String? userId,
    required UserDto? body,
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
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<UserDto>> _usersUserIdGet({required String? userId}) {
    final Uri $url = Uri.parse('/Users/${userId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<UserDto, UserDto>($request);
  }

  @override
  Future<Response<dynamic>> _usersUserIdDelete({required String? userId}) {
    final Uri $url = Uri.parse('/Users/${userId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _usersUserIdPolicyPost({
    required String? userId,
    required UserPolicy? body,
  }) {
    final Uri $url = Uri.parse('/Users/${userId}/Policy');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<AuthenticationResult>> _usersAuthenticateByNamePost(
      {required AuthenticateUserByName? body}) {
    final Uri $url = Uri.parse('/Users/AuthenticateByName');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<AuthenticationResult, AuthenticationResult>($request);
  }

  @override
  Future<Response<AuthenticationResult>> _usersAuthenticateWithQuickConnectPost(
      {required QuickConnectDto? body}) {
    final Uri $url = Uri.parse('/Users/AuthenticateWithQuickConnect');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<AuthenticationResult, AuthenticationResult>($request);
  }

  @override
  Future<Response<dynamic>> _usersConfigurationPost({
    String? userId,
    required UserConfiguration? body,
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
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<ForgotPasswordResult>> _usersForgotPasswordPost(
      {required ForgotPasswordDto? body}) {
    final Uri $url = Uri.parse('/Users/ForgotPassword');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<ForgotPasswordResult, ForgotPasswordResult>($request);
  }

  @override
  Future<Response<PinRedeemResult>> _usersForgotPasswordPinPost(
      {required ForgotPasswordPinDto? body}) {
    final Uri $url = Uri.parse('/Users/ForgotPassword/Pin');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<PinRedeemResult, PinRedeemResult>($request);
  }

  @override
  Future<Response<UserDto>> _usersMeGet() {
    final Uri $url = Uri.parse('/Users/Me');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<UserDto, UserDto>($request);
  }

  @override
  Future<Response<UserDto>> _usersNewPost({required CreateUserByName? body}) {
    final Uri $url = Uri.parse('/Users/New');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<UserDto, UserDto>($request);
  }

  @override
  Future<Response<dynamic>> _usersPasswordPost({
    String? userId,
    required UpdateUserPassword? body,
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
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<UserDto>>> _usersPublicGet() {
    final Uri $url = Uri.parse('/Users/Public');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<UserDto>, UserDto>($request);
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _itemsItemIdIntrosGet({
    String? userId,
    required String? itemId,
  }) {
    final Uri $url = Uri.parse('/Items/${itemId}/Intros');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>($request);
  }

  @override
  Future<Response<List<BaseItemDto>>> _itemsItemIdLocalTrailersGet({
    String? userId,
    required String? itemId,
  }) {
    final Uri $url = Uri.parse('/Items/${itemId}/LocalTrailers');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<BaseItemDto>, BaseItemDto>($request);
  }

  @override
  Future<Response<List<BaseItemDto>>> _itemsItemIdSpecialFeaturesGet({
    String? userId,
    required String? itemId,
  }) {
    final Uri $url = Uri.parse('/Items/${itemId}/SpecialFeatures');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<BaseItemDto>, BaseItemDto>($request);
  }

  @override
  Future<Response<List<BaseItemDto>>> _itemsLatestGet({
    String? userId,
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
  }) {
    final Uri $url = Uri.parse('/Items/Latest');
    final Map<String, dynamic> $params = <String, dynamic>{
      'userId': userId,
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
    );
    return client.send<List<BaseItemDto>, BaseItemDto>($request);
  }

  @override
  Future<Response<BaseItemDto>> _itemsRootGet({String? userId}) {
    final Uri $url = Uri.parse('/Items/Root');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<BaseItemDto, BaseItemDto>($request);
  }

  @override
  Future<Response<UserItemDataDto>> _userFavoriteItemsItemIdPost({
    String? userId,
    required String? itemId,
  }) {
    final Uri $url = Uri.parse('/UserFavoriteItems/${itemId}');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<UserItemDataDto, UserItemDataDto>($request);
  }

  @override
  Future<Response<UserItemDataDto>> _userFavoriteItemsItemIdDelete({
    String? userId,
    required String? itemId,
  }) {
    final Uri $url = Uri.parse('/UserFavoriteItems/${itemId}');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<UserItemDataDto, UserItemDataDto>($request);
  }

  @override
  Future<Response<UserItemDataDto>> _userItemsItemIdRatingDelete({
    String? userId,
    required String? itemId,
  }) {
    final Uri $url = Uri.parse('/UserItems/${itemId}/Rating');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<UserItemDataDto, UserItemDataDto>($request);
  }

  @override
  Future<Response<UserItemDataDto>> _userItemsItemIdRatingPost({
    String? userId,
    required String? itemId,
    bool? likes,
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
    );
    return client.send<UserItemDataDto, UserItemDataDto>($request);
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _userViewsGet({
    String? userId,
    bool? includeExternalContent,
    List<Object?>? presetViews,
    bool? includeHidden,
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
    );
    return client
        .send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>($request);
  }

  @override
  Future<Response<List<SpecialViewOptionDto>>> _userViewsGroupingOptionsGet(
      {String? userId}) {
    final Uri $url = Uri.parse('/UserViews/GroupingOptions');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<List<SpecialViewOptionDto>, SpecialViewOptionDto>($request);
  }

  @override
  Future<Response<String>> _videosVideoIdMediaSourceIdAttachmentsIndexGet({
    required String? videoId,
    required String? mediaSourceId,
    required int? index,
  }) {
    final Uri $url =
        Uri.parse('/Videos/${videoId}/${mediaSourceId}/Attachments/${index}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<BaseItemDtoQueryResult>> _videosItemIdAdditionalPartsGet({
    required String? itemId,
    String? userId,
  }) {
    final Uri $url = Uri.parse('/Videos/${itemId}/AdditionalParts');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>($request);
  }

  @override
  Future<Response<dynamic>> _videosItemIdAlternateSourcesDelete(
      {required String? itemId}) {
    final Uri $url = Uri.parse('/Videos/${itemId}/AlternateSources');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
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
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<dynamic>> _videosMergeVersionsPost(
      {required List<String>? ids}) {
    final Uri $url = Uri.parse('/Videos/MergeVersions');
    final Map<String, dynamic> $params = <String, dynamic>{'ids': ids};
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parameters: $params,
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
    );
    return client
        .send<BaseItemDtoQueryResult, BaseItemDtoQueryResult>($request);
  }

  @override
  Future<Response<BaseItemDto>> _yearsYearGet({
    required int? year,
    String? userId,
  }) {
    final Uri $url = Uri.parse('/Years/${year}');
    final Map<String, dynamic> $params = <String, dynamic>{'userId': userId};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<BaseItemDto, BaseItemDto>($request);
  }
}
