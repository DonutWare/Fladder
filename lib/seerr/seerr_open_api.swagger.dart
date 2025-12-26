// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:collection/collection.dart';
import 'dart:convert';

import 'package:chopper/chopper.dart';

import 'client_mapping.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show MultipartFile;
import 'package:chopper/chopper.dart' as chopper;
import 'seerr_open_api.enums.swagger.dart' as enums;
export 'seerr_open_api.enums.swagger.dart';

part 'seerr_open_api.swagger.chopper.dart';
part 'seerr_open_api.swagger.g.dart';

// **************************************************************************
// SwaggerChopperGenerator
// **************************************************************************

@ChopperApi()
abstract class SeerrOpenApi extends ChopperService {
  static SeerrOpenApi create({
    ChopperClient? client,
    http.Client? httpClient,
    Authenticator? authenticator,
    ErrorConverter? errorConverter,
    Converter? converter,
    Uri? baseUrl,
    List<Interceptor>? interceptors,
  }) {
    if (client != null) {
      return _$SeerrOpenApi(client);
    }

    final newClient = ChopperClient(
      services: [_$SeerrOpenApi()],
      converter: converter ?? $JsonSerializableConverter(),
      interceptors: interceptors ?? [],
      client: httpClient,
      authenticator: authenticator,
      errorConverter: errorConverter,
      baseUrl: baseUrl,
    );
    return _$SeerrOpenApi(newClient);
  }

  ///Get Seerr status
  Future<chopper.Response<StatusGet$Response>> statusGet() {
    generatedMapping.putIfAbsent(
      StatusGet$Response,
      () => StatusGet$Response.fromJsonFactory,
    );

    return _statusGet();
  }

  ///Get Seerr status
  @GET(path: '/status')
  Future<chopper.Response<StatusGet$Response>> _statusGet();

  ///Get application data volume status
  Future<chopper.Response<StatusAppdataGet$Response>> statusAppdataGet() {
    generatedMapping.putIfAbsent(
      StatusAppdataGet$Response,
      () => StatusAppdataGet$Response.fromJsonFactory,
    );

    return _statusAppdataGet();
  }

  ///Get application data volume status
  @GET(path: '/status/appdata')
  Future<chopper.Response<StatusAppdataGet$Response>> _statusAppdataGet();

  ///Get main settings
  Future<chopper.Response<MainSettings>> settingsMainGet() {
    generatedMapping.putIfAbsent(
      MainSettings,
      () => MainSettings.fromJsonFactory,
    );

    return _settingsMainGet();
  }

  ///Get main settings
  @GET(path: '/settings/main')
  Future<chopper.Response<MainSettings>> _settingsMainGet();

  ///Update main settings
  Future<chopper.Response<MainSettings>> settingsMainPost({
    required MainSettings? body,
  }) {
    generatedMapping.putIfAbsent(
      MainSettings,
      () => MainSettings.fromJsonFactory,
    );

    return _settingsMainPost(body: body);
  }

  ///Update main settings
  @POST(path: '/settings/main', optionalBody: true)
  Future<chopper.Response<MainSettings>> _settingsMainPost({
    @Body() required MainSettings? body,
  });

  ///Get network settings
  Future<chopper.Response<MainSettings>> settingsNetworkGet() {
    generatedMapping.putIfAbsent(
      MainSettings,
      () => MainSettings.fromJsonFactory,
    );

    return _settingsNetworkGet();
  }

  ///Get network settings
  @GET(path: '/settings/network')
  Future<chopper.Response<MainSettings>> _settingsNetworkGet();

  ///Update network settings
  Future<chopper.Response<NetworkSettings>> settingsNetworkPost({
    required NetworkSettings? body,
  }) {
    generatedMapping.putIfAbsent(
      NetworkSettings,
      () => NetworkSettings.fromJsonFactory,
    );

    return _settingsNetworkPost(body: body);
  }

  ///Update network settings
  @POST(path: '/settings/network', optionalBody: true)
  Future<chopper.Response<NetworkSettings>> _settingsNetworkPost({
    @Body() required NetworkSettings? body,
  });

  ///Get main settings with newly-generated API key
  Future<chopper.Response<MainSettings>> settingsMainRegeneratePost() {
    generatedMapping.putIfAbsent(
      MainSettings,
      () => MainSettings.fromJsonFactory,
    );

    return _settingsMainRegeneratePost();
  }

  ///Get main settings with newly-generated API key
  @POST(path: '/settings/main/regenerate', optionalBody: true)
  Future<chopper.Response<MainSettings>> _settingsMainRegeneratePost();

  ///Get Jellyfin settings
  Future<chopper.Response<JellyfinSettings>> settingsJellyfinGet() {
    generatedMapping.putIfAbsent(
      JellyfinSettings,
      () => JellyfinSettings.fromJsonFactory,
    );

    return _settingsJellyfinGet();
  }

  ///Get Jellyfin settings
  @GET(path: '/settings/jellyfin')
  Future<chopper.Response<JellyfinSettings>> _settingsJellyfinGet();

  ///Update Jellyfin settings
  Future<chopper.Response<JellyfinSettings>> settingsJellyfinPost({
    required JellyfinSettings? body,
  }) {
    generatedMapping.putIfAbsent(
      JellyfinSettings,
      () => JellyfinSettings.fromJsonFactory,
    );

    return _settingsJellyfinPost(body: body);
  }

  ///Update Jellyfin settings
  @POST(path: '/settings/jellyfin', optionalBody: true)
  Future<chopper.Response<JellyfinSettings>> _settingsJellyfinPost({
    @Body() required JellyfinSettings? body,
  });

  ///Get Jellyfin libraries
  ///@param sync Syncs the current libraries with the current Jellyfin server
  ///@param enable Comma separated list of libraries to enable. Any libraries not passed will be disabled!
  Future<chopper.Response<List<JellyfinLibrary>>> settingsJellyfinLibraryGet({
    String? $sync,
    String? enable,
  }) {
    generatedMapping.putIfAbsent(
      JellyfinLibrary,
      () => JellyfinLibrary.fromJsonFactory,
    );

    return _settingsJellyfinLibraryGet($sync: $sync, enable: enable);
  }

  ///Get Jellyfin libraries
  ///@param sync Syncs the current libraries with the current Jellyfin server
  ///@param enable Comma separated list of libraries to enable. Any libraries not passed will be disabled!
  @GET(path: '/settings/jellyfin/library')
  Future<chopper.Response<List<JellyfinLibrary>>> _settingsJellyfinLibraryGet({
    @Query('sync') String? $sync,
    @Query('enable') String? enable,
  });

  ///Get Jellyfin Users
  Future<chopper.Response<List<SettingsJellyfinUsersGet$Response>>>
  settingsJellyfinUsersGet() {
    return _settingsJellyfinUsersGet();
  }

  ///Get Jellyfin Users
  @GET(path: '/settings/jellyfin/users')
  Future<chopper.Response<List<SettingsJellyfinUsersGet$Response>>>
  _settingsJellyfinUsersGet();

  ///Get status of full Jellyfin library sync
  Future<chopper.Response<SettingsJellyfinSyncGet$Response>>
  settingsJellyfinSyncGet() {
    generatedMapping.putIfAbsent(
      SettingsJellyfinSyncGet$Response,
      () => SettingsJellyfinSyncGet$Response.fromJsonFactory,
    );

    return _settingsJellyfinSyncGet();
  }

  ///Get status of full Jellyfin library sync
  @GET(path: '/settings/jellyfin/sync')
  Future<chopper.Response<SettingsJellyfinSyncGet$Response>>
  _settingsJellyfinSyncGet();

  ///Start full Jellyfin library sync
  Future<chopper.Response<SettingsJellyfinSyncPost$Response>>
  settingsJellyfinSyncPost({
    required SettingsJellyfinSyncPost$RequestBody? body,
  }) {
    generatedMapping.putIfAbsent(
      SettingsJellyfinSyncPost$Response,
      () => SettingsJellyfinSyncPost$Response.fromJsonFactory,
    );

    return _settingsJellyfinSyncPost(body: body);
  }

  ///Start full Jellyfin library sync
  @POST(path: '/settings/jellyfin/sync', optionalBody: true)
  Future<chopper.Response<SettingsJellyfinSyncPost$Response>>
  _settingsJellyfinSyncPost({
    @Body() required SettingsJellyfinSyncPost$RequestBody? body,
  });

  ///Get Plex settings
  Future<chopper.Response<PlexSettings>> settingsPlexGet() {
    generatedMapping.putIfAbsent(
      PlexSettings,
      () => PlexSettings.fromJsonFactory,
    );

    return _settingsPlexGet();
  }

  ///Get Plex settings
  @GET(path: '/settings/plex')
  Future<chopper.Response<PlexSettings>> _settingsPlexGet();

  ///Update Plex settings
  Future<chopper.Response<PlexSettings>> settingsPlexPost({
    required PlexSettings? body,
  }) {
    generatedMapping.putIfAbsent(
      PlexSettings,
      () => PlexSettings.fromJsonFactory,
    );

    return _settingsPlexPost(body: body);
  }

  ///Update Plex settings
  @POST(path: '/settings/plex', optionalBody: true)
  Future<chopper.Response<PlexSettings>> _settingsPlexPost({
    @Body() required PlexSettings? body,
  });

  ///Get Plex libraries
  ///@param sync Syncs the current libraries with the current Plex server
  ///@param enable Comma separated list of libraries to enable. Any libraries not passed will be disabled!
  Future<chopper.Response<List<PlexLibrary>>> settingsPlexLibraryGet({
    String? $sync,
    String? enable,
  }) {
    generatedMapping.putIfAbsent(
      PlexLibrary,
      () => PlexLibrary.fromJsonFactory,
    );

    return _settingsPlexLibraryGet($sync: $sync, enable: enable);
  }

  ///Get Plex libraries
  ///@param sync Syncs the current libraries with the current Plex server
  ///@param enable Comma separated list of libraries to enable. Any libraries not passed will be disabled!
  @GET(path: '/settings/plex/library')
  Future<chopper.Response<List<PlexLibrary>>> _settingsPlexLibraryGet({
    @Query('sync') String? $sync,
    @Query('enable') String? enable,
  });

  ///Get status of full Plex library scan
  Future<chopper.Response<SettingsPlexSyncGet$Response>> settingsPlexSyncGet() {
    generatedMapping.putIfAbsent(
      SettingsPlexSyncGet$Response,
      () => SettingsPlexSyncGet$Response.fromJsonFactory,
    );

    return _settingsPlexSyncGet();
  }

  ///Get status of full Plex library scan
  @GET(path: '/settings/plex/sync')
  Future<chopper.Response<SettingsPlexSyncGet$Response>> _settingsPlexSyncGet();

  ///Start full Plex library scan
  Future<chopper.Response<SettingsPlexSyncPost$Response>> settingsPlexSyncPost({
    required SettingsPlexSyncPost$RequestBody? body,
  }) {
    generatedMapping.putIfAbsent(
      SettingsPlexSyncPost$Response,
      () => SettingsPlexSyncPost$Response.fromJsonFactory,
    );

    return _settingsPlexSyncPost(body: body);
  }

  ///Start full Plex library scan
  @POST(path: '/settings/plex/sync', optionalBody: true)
  Future<chopper.Response<SettingsPlexSyncPost$Response>>
  _settingsPlexSyncPost({
    @Body() required SettingsPlexSyncPost$RequestBody? body,
  });

  ///Gets the user's available Plex servers
  Future<chopper.Response<List<PlexDevice>>> settingsPlexDevicesServersGet() {
    generatedMapping.putIfAbsent(PlexDevice, () => PlexDevice.fromJsonFactory);

    return _settingsPlexDevicesServersGet();
  }

  ///Gets the user's available Plex servers
  @GET(path: '/settings/plex/devices/servers')
  Future<chopper.Response<List<PlexDevice>>> _settingsPlexDevicesServersGet();

  ///Get Plex users
  Future<chopper.Response<List<SettingsPlexUsersGet$Response>>>
  settingsPlexUsersGet() {
    return _settingsPlexUsersGet();
  }

  ///Get Plex users
  @GET(path: '/settings/plex/users')
  Future<chopper.Response<List<SettingsPlexUsersGet$Response>>>
  _settingsPlexUsersGet();

  ///Get Metadata settings
  Future<chopper.Response<MetadataSettings>> settingsMetadatasGet() {
    generatedMapping.putIfAbsent(
      MetadataSettings,
      () => MetadataSettings.fromJsonFactory,
    );

    return _settingsMetadatasGet();
  }

  ///Get Metadata settings
  @GET(path: '/settings/metadatas')
  Future<chopper.Response<MetadataSettings>> _settingsMetadatasGet();

  ///Update Metadata settings
  Future<chopper.Response<MetadataSettings>> settingsMetadatasPut({
    required MetadataSettings? body,
  }) {
    generatedMapping.putIfAbsent(
      MetadataSettings,
      () => MetadataSettings.fromJsonFactory,
    );

    return _settingsMetadatasPut(body: body);
  }

  ///Update Metadata settings
  @PUT(path: '/settings/metadatas', optionalBody: true)
  Future<chopper.Response<MetadataSettings>> _settingsMetadatasPut({
    @Body() required MetadataSettings? body,
  });

  ///Test Provider configuration
  Future<chopper.Response<SettingsMetadatasTestPost$Response>>
  settingsMetadatasTestPost({
    required SettingsMetadatasTestPost$RequestBody? body,
  }) {
    generatedMapping.putIfAbsent(
      SettingsMetadatasTestPost$Response,
      () => SettingsMetadatasTestPost$Response.fromJsonFactory,
    );

    return _settingsMetadatasTestPost(body: body);
  }

  ///Test Provider configuration
  @POST(path: '/settings/metadatas/test', optionalBody: true)
  Future<chopper.Response<SettingsMetadatasTestPost$Response>>
  _settingsMetadatasTestPost({
    @Body() required SettingsMetadatasTestPost$RequestBody? body,
  });

  ///Get Tautulli settings
  Future<chopper.Response<TautulliSettings>> settingsTautulliGet() {
    generatedMapping.putIfAbsent(
      TautulliSettings,
      () => TautulliSettings.fromJsonFactory,
    );

    return _settingsTautulliGet();
  }

  ///Get Tautulli settings
  @GET(path: '/settings/tautulli')
  Future<chopper.Response<TautulliSettings>> _settingsTautulliGet();

  ///Update Tautulli settings
  Future<chopper.Response<TautulliSettings>> settingsTautulliPost({
    required TautulliSettings? body,
  }) {
    generatedMapping.putIfAbsent(
      TautulliSettings,
      () => TautulliSettings.fromJsonFactory,
    );

    return _settingsTautulliPost(body: body);
  }

  ///Update Tautulli settings
  @POST(path: '/settings/tautulli', optionalBody: true)
  Future<chopper.Response<TautulliSettings>> _settingsTautulliPost({
    @Body() required TautulliSettings? body,
  });

  ///Get Radarr settings
  Future<chopper.Response<List<RadarrSettings>>> settingsRadarrGet() {
    generatedMapping.putIfAbsent(
      RadarrSettings,
      () => RadarrSettings.fromJsonFactory,
    );

    return _settingsRadarrGet();
  }

  ///Get Radarr settings
  @GET(path: '/settings/radarr')
  Future<chopper.Response<List<RadarrSettings>>> _settingsRadarrGet();

  ///Create Radarr instance
  Future<chopper.Response<RadarrSettings>> settingsRadarrPost({
    required RadarrSettings? body,
  }) {
    generatedMapping.putIfAbsent(
      RadarrSettings,
      () => RadarrSettings.fromJsonFactory,
    );

    return _settingsRadarrPost(body: body);
  }

  ///Create Radarr instance
  @POST(path: '/settings/radarr', optionalBody: true)
  Future<chopper.Response<RadarrSettings>> _settingsRadarrPost({
    @Body() required RadarrSettings? body,
  });

  ///Test Radarr configuration
  Future<chopper.Response<SettingsRadarrTestPost$Response>>
  settingsRadarrTestPost({required SettingsRadarrTestPost$RequestBody? body}) {
    generatedMapping.putIfAbsent(
      SettingsRadarrTestPost$Response,
      () => SettingsRadarrTestPost$Response.fromJsonFactory,
    );

    return _settingsRadarrTestPost(body: body);
  }

  ///Test Radarr configuration
  @POST(path: '/settings/radarr/test', optionalBody: true)
  Future<chopper.Response<SettingsRadarrTestPost$Response>>
  _settingsRadarrTestPost({
    @Body() required SettingsRadarrTestPost$RequestBody? body,
  });

  ///Update Radarr instance
  ///@param radarrId Radarr instance ID
  Future<chopper.Response<RadarrSettings>> settingsRadarrRadarrIdPut({
    required int? radarrId,
    required RadarrSettings? body,
  }) {
    generatedMapping.putIfAbsent(
      RadarrSettings,
      () => RadarrSettings.fromJsonFactory,
    );

    return _settingsRadarrRadarrIdPut(radarrId: radarrId, body: body);
  }

  ///Update Radarr instance
  ///@param radarrId Radarr instance ID
  @PUT(path: '/settings/radarr/{radarrId}', optionalBody: true)
  Future<chopper.Response<RadarrSettings>> _settingsRadarrRadarrIdPut({
    @Path('radarrId') required int? radarrId,
    @Body() required RadarrSettings? body,
  });

  ///Delete Radarr instance
  ///@param radarrId Radarr instance ID
  Future<chopper.Response<RadarrSettings>> settingsRadarrRadarrIdDelete({
    required int? radarrId,
  }) {
    generatedMapping.putIfAbsent(
      RadarrSettings,
      () => RadarrSettings.fromJsonFactory,
    );

    return _settingsRadarrRadarrIdDelete(radarrId: radarrId);
  }

  ///Delete Radarr instance
  ///@param radarrId Radarr instance ID
  @DELETE(path: '/settings/radarr/{radarrId}')
  Future<chopper.Response<RadarrSettings>> _settingsRadarrRadarrIdDelete({
    @Path('radarrId') required int? radarrId,
  });

  ///Get available Radarr profiles
  ///@param radarrId Radarr instance ID
  Future<chopper.Response<List<ServiceProfile>>>
  settingsRadarrRadarrIdProfilesGet({required int? radarrId}) {
    generatedMapping.putIfAbsent(
      ServiceProfile,
      () => ServiceProfile.fromJsonFactory,
    );

    return _settingsRadarrRadarrIdProfilesGet(radarrId: radarrId);
  }

  ///Get available Radarr profiles
  ///@param radarrId Radarr instance ID
  @GET(path: '/settings/radarr/{radarrId}/profiles')
  Future<chopper.Response<List<ServiceProfile>>>
  _settingsRadarrRadarrIdProfilesGet({
    @Path('radarrId') required int? radarrId,
  });

  ///Get Sonarr settings
  Future<chopper.Response<List<SonarrSettings>>> settingsSonarrGet() {
    generatedMapping.putIfAbsent(
      SonarrSettings,
      () => SonarrSettings.fromJsonFactory,
    );

    return _settingsSonarrGet();
  }

  ///Get Sonarr settings
  @GET(path: '/settings/sonarr')
  Future<chopper.Response<List<SonarrSettings>>> _settingsSonarrGet();

  ///Create Sonarr instance
  Future<chopper.Response<SonarrSettings>> settingsSonarrPost({
    required SonarrSettings? body,
  }) {
    generatedMapping.putIfAbsent(
      SonarrSettings,
      () => SonarrSettings.fromJsonFactory,
    );

    return _settingsSonarrPost(body: body);
  }

  ///Create Sonarr instance
  @POST(path: '/settings/sonarr', optionalBody: true)
  Future<chopper.Response<SonarrSettings>> _settingsSonarrPost({
    @Body() required SonarrSettings? body,
  });

  ///Test Sonarr configuration
  Future<chopper.Response<SettingsSonarrTestPost$Response>>
  settingsSonarrTestPost({required SettingsSonarrTestPost$RequestBody? body}) {
    generatedMapping.putIfAbsent(
      SettingsSonarrTestPost$Response,
      () => SettingsSonarrTestPost$Response.fromJsonFactory,
    );

    return _settingsSonarrTestPost(body: body);
  }

  ///Test Sonarr configuration
  @POST(path: '/settings/sonarr/test', optionalBody: true)
  Future<chopper.Response<SettingsSonarrTestPost$Response>>
  _settingsSonarrTestPost({
    @Body() required SettingsSonarrTestPost$RequestBody? body,
  });

  ///Update Sonarr instance
  ///@param sonarrId Sonarr instance ID
  Future<chopper.Response<SonarrSettings>> settingsSonarrSonarrIdPut({
    required int? sonarrId,
    required SonarrSettings? body,
  }) {
    generatedMapping.putIfAbsent(
      SonarrSettings,
      () => SonarrSettings.fromJsonFactory,
    );

    return _settingsSonarrSonarrIdPut(sonarrId: sonarrId, body: body);
  }

  ///Update Sonarr instance
  ///@param sonarrId Sonarr instance ID
  @PUT(path: '/settings/sonarr/{sonarrId}', optionalBody: true)
  Future<chopper.Response<SonarrSettings>> _settingsSonarrSonarrIdPut({
    @Path('sonarrId') required int? sonarrId,
    @Body() required SonarrSettings? body,
  });

  ///Delete Sonarr instance
  ///@param sonarrId Sonarr instance ID
  Future<chopper.Response<SonarrSettings>> settingsSonarrSonarrIdDelete({
    required int? sonarrId,
  }) {
    generatedMapping.putIfAbsent(
      SonarrSettings,
      () => SonarrSettings.fromJsonFactory,
    );

    return _settingsSonarrSonarrIdDelete(sonarrId: sonarrId);
  }

  ///Delete Sonarr instance
  ///@param sonarrId Sonarr instance ID
  @DELETE(path: '/settings/sonarr/{sonarrId}')
  Future<chopper.Response<SonarrSettings>> _settingsSonarrSonarrIdDelete({
    @Path('sonarrId') required int? sonarrId,
  });

  ///Get public settings
  Future<chopper.Response<PublicSettings>> settingsPublicGet() {
    generatedMapping.putIfAbsent(
      PublicSettings,
      () => PublicSettings.fromJsonFactory,
    );

    return _settingsPublicGet();
  }

  ///Get public settings
  @GET(path: '/settings/public')
  Future<chopper.Response<PublicSettings>> _settingsPublicGet();

  ///Initialize application
  Future<chopper.Response<PublicSettings>> settingsInitializePost() {
    generatedMapping.putIfAbsent(
      PublicSettings,
      () => PublicSettings.fromJsonFactory,
    );

    return _settingsInitializePost();
  }

  ///Initialize application
  @POST(path: '/settings/initialize', optionalBody: true)
  Future<chopper.Response<PublicSettings>> _settingsInitializePost();

  ///Get scheduled jobs
  Future<chopper.Response<List<Job>>> settingsJobsGet() {
    generatedMapping.putIfAbsent(Job, () => Job.fromJsonFactory);

    return _settingsJobsGet();
  }

  ///Get scheduled jobs
  @GET(path: '/settings/jobs')
  Future<chopper.Response<List<Job>>> _settingsJobsGet();

  ///Invoke a specific job
  ///@param jobId
  Future<chopper.Response<Job>> settingsJobsJobIdRunPost({
    required String? jobId,
  }) {
    generatedMapping.putIfAbsent(Job, () => Job.fromJsonFactory);

    return _settingsJobsJobIdRunPost(jobId: jobId);
  }

  ///Invoke a specific job
  ///@param jobId
  @POST(path: '/settings/jobs/{jobId}/run', optionalBody: true)
  Future<chopper.Response<Job>> _settingsJobsJobIdRunPost({
    @Path('jobId') required String? jobId,
  });

  ///Cancel a specific job
  ///@param jobId
  Future<chopper.Response<Job>> settingsJobsJobIdCancelPost({
    required String? jobId,
  }) {
    generatedMapping.putIfAbsent(Job, () => Job.fromJsonFactory);

    return _settingsJobsJobIdCancelPost(jobId: jobId);
  }

  ///Cancel a specific job
  ///@param jobId
  @POST(path: '/settings/jobs/{jobId}/cancel', optionalBody: true)
  Future<chopper.Response<Job>> _settingsJobsJobIdCancelPost({
    @Path('jobId') required String? jobId,
  });

  ///Modify job schedule
  ///@param jobId
  Future<chopper.Response<Job>> settingsJobsJobIdSchedulePost({
    required String? jobId,
    required SettingsJobsJobIdSchedulePost$RequestBody? body,
  }) {
    generatedMapping.putIfAbsent(Job, () => Job.fromJsonFactory);

    return _settingsJobsJobIdSchedulePost(jobId: jobId, body: body);
  }

  ///Modify job schedule
  ///@param jobId
  @POST(path: '/settings/jobs/{jobId}/schedule', optionalBody: true)
  Future<chopper.Response<Job>> _settingsJobsJobIdSchedulePost({
    @Path('jobId') required String? jobId,
    @Body() required SettingsJobsJobIdSchedulePost$RequestBody? body,
  });

  ///Get a list of active caches
  Future<chopper.Response<SettingsCacheGet$Response>> settingsCacheGet() {
    generatedMapping.putIfAbsent(
      SettingsCacheGet$Response,
      () => SettingsCacheGet$Response.fromJsonFactory,
    );

    return _settingsCacheGet();
  }

  ///Get a list of active caches
  @GET(path: '/settings/cache')
  Future<chopper.Response<SettingsCacheGet$Response>> _settingsCacheGet();

  ///Flush a specific cache
  ///@param cacheId
  Future<chopper.Response> settingsCacheCacheIdFlushPost({
    required String? cacheId,
  }) {
    return _settingsCacheCacheIdFlushPost(cacheId: cacheId);
  }

  ///Flush a specific cache
  ///@param cacheId
  @POST(path: '/settings/cache/{cacheId}/flush', optionalBody: true)
  Future<chopper.Response> _settingsCacheCacheIdFlushPost({
    @Path('cacheId') required String? cacheId,
  });

  ///Flush a specific DNS cache entry
  ///@param dnsEntry
  Future<chopper.Response> settingsCacheDnsDnsEntryFlushPost({
    required String? dnsEntry,
  }) {
    return _settingsCacheDnsDnsEntryFlushPost(dnsEntry: dnsEntry);
  }

  ///Flush a specific DNS cache entry
  ///@param dnsEntry
  @POST(path: '/settings/cache/dns/{dnsEntry}/flush', optionalBody: true)
  Future<chopper.Response> _settingsCacheDnsDnsEntryFlushPost({
    @Path('dnsEntry') required String? dnsEntry,
  });

  ///Returns logs
  ///@param take
  ///@param skip
  ///@param filter
  ///@param search
  Future<chopper.Response<List<SettingsLogsGet$Response>>> settingsLogsGet({
    num? take,
    num? skip,
    enums.SettingsLogsGetFilter? filter,
    String? search,
  }) {
    return _settingsLogsGet(
      take: take,
      skip: skip,
      filter: filter?.value?.toString(),
      search: search,
    );
  }

  ///Returns logs
  ///@param take
  ///@param skip
  ///@param filter
  ///@param search
  @GET(path: '/settings/logs')
  Future<chopper.Response<List<SettingsLogsGet$Response>>> _settingsLogsGet({
    @Query('take') num? take,
    @Query('skip') num? skip,
    @Query('filter') String? filter,
    @Query('search') String? search,
  });

  ///Get email notification settings
  Future<chopper.Response<NotificationEmailSettings>>
  settingsNotificationsEmailGet() {
    generatedMapping.putIfAbsent(
      NotificationEmailSettings,
      () => NotificationEmailSettings.fromJsonFactory,
    );

    return _settingsNotificationsEmailGet();
  }

  ///Get email notification settings
  @GET(path: '/settings/notifications/email')
  Future<chopper.Response<NotificationEmailSettings>>
  _settingsNotificationsEmailGet();

  ///Update email notification settings
  Future<chopper.Response<NotificationEmailSettings>>
  settingsNotificationsEmailPost({required NotificationEmailSettings? body}) {
    generatedMapping.putIfAbsent(
      NotificationEmailSettings,
      () => NotificationEmailSettings.fromJsonFactory,
    );

    return _settingsNotificationsEmailPost(body: body);
  }

  ///Update email notification settings
  @POST(path: '/settings/notifications/email', optionalBody: true)
  Future<chopper.Response<NotificationEmailSettings>>
  _settingsNotificationsEmailPost({
    @Body() required NotificationEmailSettings? body,
  });

  ///Test email settings
  Future<chopper.Response> settingsNotificationsEmailTestPost({
    required NotificationEmailSettings? body,
  }) {
    return _settingsNotificationsEmailTestPost(body: body);
  }

  ///Test email settings
  @POST(path: '/settings/notifications/email/test', optionalBody: true)
  Future<chopper.Response> _settingsNotificationsEmailTestPost({
    @Body() required NotificationEmailSettings? body,
  });

  ///Get Discord notification settings
  Future<chopper.Response<DiscordSettings>> settingsNotificationsDiscordGet() {
    generatedMapping.putIfAbsent(
      DiscordSettings,
      () => DiscordSettings.fromJsonFactory,
    );

    return _settingsNotificationsDiscordGet();
  }

  ///Get Discord notification settings
  @GET(path: '/settings/notifications/discord')
  Future<chopper.Response<DiscordSettings>> _settingsNotificationsDiscordGet();

  ///Update Discord notification settings
  Future<chopper.Response<DiscordSettings>> settingsNotificationsDiscordPost({
    required DiscordSettings? body,
  }) {
    generatedMapping.putIfAbsent(
      DiscordSettings,
      () => DiscordSettings.fromJsonFactory,
    );

    return _settingsNotificationsDiscordPost(body: body);
  }

  ///Update Discord notification settings
  @POST(path: '/settings/notifications/discord', optionalBody: true)
  Future<chopper.Response<DiscordSettings>> _settingsNotificationsDiscordPost({
    @Body() required DiscordSettings? body,
  });

  ///Test Discord settings
  Future<chopper.Response> settingsNotificationsDiscordTestPost({
    required DiscordSettings? body,
  }) {
    return _settingsNotificationsDiscordTestPost(body: body);
  }

  ///Test Discord settings
  @POST(path: '/settings/notifications/discord/test', optionalBody: true)
  Future<chopper.Response> _settingsNotificationsDiscordTestPost({
    @Body() required DiscordSettings? body,
  });

  ///Get Pushbullet notification settings
  Future<chopper.Response<PushbulletSettings>>
  settingsNotificationsPushbulletGet() {
    generatedMapping.putIfAbsent(
      PushbulletSettings,
      () => PushbulletSettings.fromJsonFactory,
    );

    return _settingsNotificationsPushbulletGet();
  }

  ///Get Pushbullet notification settings
  @GET(path: '/settings/notifications/pushbullet')
  Future<chopper.Response<PushbulletSettings>>
  _settingsNotificationsPushbulletGet();

  ///Update Pushbullet notification settings
  Future<chopper.Response<PushbulletSettings>>
  settingsNotificationsPushbulletPost({required PushbulletSettings? body}) {
    generatedMapping.putIfAbsent(
      PushbulletSettings,
      () => PushbulletSettings.fromJsonFactory,
    );

    return _settingsNotificationsPushbulletPost(body: body);
  }

  ///Update Pushbullet notification settings
  @POST(path: '/settings/notifications/pushbullet', optionalBody: true)
  Future<chopper.Response<PushbulletSettings>>
  _settingsNotificationsPushbulletPost({
    @Body() required PushbulletSettings? body,
  });

  ///Test Pushbullet settings
  Future<chopper.Response> settingsNotificationsPushbulletTestPost({
    required PushbulletSettings? body,
  }) {
    return _settingsNotificationsPushbulletTestPost(body: body);
  }

  ///Test Pushbullet settings
  @POST(path: '/settings/notifications/pushbullet/test', optionalBody: true)
  Future<chopper.Response> _settingsNotificationsPushbulletTestPost({
    @Body() required PushbulletSettings? body,
  });

  ///Get Pushover notification settings
  Future<chopper.Response<PushoverSettings>>
  settingsNotificationsPushoverGet() {
    generatedMapping.putIfAbsent(
      PushoverSettings,
      () => PushoverSettings.fromJsonFactory,
    );

    return _settingsNotificationsPushoverGet();
  }

  ///Get Pushover notification settings
  @GET(path: '/settings/notifications/pushover')
  Future<chopper.Response<PushoverSettings>>
  _settingsNotificationsPushoverGet();

  ///Update Pushover notification settings
  Future<chopper.Response<PushoverSettings>> settingsNotificationsPushoverPost({
    required PushoverSettings? body,
  }) {
    generatedMapping.putIfAbsent(
      PushoverSettings,
      () => PushoverSettings.fromJsonFactory,
    );

    return _settingsNotificationsPushoverPost(body: body);
  }

  ///Update Pushover notification settings
  @POST(path: '/settings/notifications/pushover', optionalBody: true)
  Future<chopper.Response<PushoverSettings>>
  _settingsNotificationsPushoverPost({@Body() required PushoverSettings? body});

  ///Test Pushover settings
  Future<chopper.Response> settingsNotificationsPushoverTestPost({
    required PushoverSettings? body,
  }) {
    return _settingsNotificationsPushoverTestPost(body: body);
  }

  ///Test Pushover settings
  @POST(path: '/settings/notifications/pushover/test', optionalBody: true)
  Future<chopper.Response> _settingsNotificationsPushoverTestPost({
    @Body() required PushoverSettings? body,
  });

  ///Get Pushover sounds
  ///@param token
  Future<
    chopper.Response<List<SettingsNotificationsPushoverSoundsGet$Response>>
  >
  settingsNotificationsPushoverSoundsGet({required String? token}) {
    return _settingsNotificationsPushoverSoundsGet(token: token);
  }

  ///Get Pushover sounds
  ///@param token
  @GET(path: '/settings/notifications/pushover/sounds')
  Future<
    chopper.Response<List<SettingsNotificationsPushoverSoundsGet$Response>>
  >
  _settingsNotificationsPushoverSoundsGet({
    @Query('token') required String? token,
  });

  ///Get Gotify notification settings
  Future<chopper.Response<GotifySettings>> settingsNotificationsGotifyGet() {
    generatedMapping.putIfAbsent(
      GotifySettings,
      () => GotifySettings.fromJsonFactory,
    );

    return _settingsNotificationsGotifyGet();
  }

  ///Get Gotify notification settings
  @GET(path: '/settings/notifications/gotify')
  Future<chopper.Response<GotifySettings>> _settingsNotificationsGotifyGet();

  ///Update Gotify notification settings
  Future<chopper.Response<GotifySettings>> settingsNotificationsGotifyPost({
    required GotifySettings? body,
  }) {
    generatedMapping.putIfAbsent(
      GotifySettings,
      () => GotifySettings.fromJsonFactory,
    );

    return _settingsNotificationsGotifyPost(body: body);
  }

  ///Update Gotify notification settings
  @POST(path: '/settings/notifications/gotify', optionalBody: true)
  Future<chopper.Response<GotifySettings>> _settingsNotificationsGotifyPost({
    @Body() required GotifySettings? body,
  });

  ///Test Gotify settings
  Future<chopper.Response> settingsNotificationsGotifyTestPost({
    required GotifySettings? body,
  }) {
    return _settingsNotificationsGotifyTestPost(body: body);
  }

  ///Test Gotify settings
  @POST(path: '/settings/notifications/gotify/test', optionalBody: true)
  Future<chopper.Response> _settingsNotificationsGotifyTestPost({
    @Body() required GotifySettings? body,
  });

  ///Get ntfy.sh notification settings
  Future<chopper.Response<NtfySettings>> settingsNotificationsNtfyGet() {
    generatedMapping.putIfAbsent(
      NtfySettings,
      () => NtfySettings.fromJsonFactory,
    );

    return _settingsNotificationsNtfyGet();
  }

  ///Get ntfy.sh notification settings
  @GET(path: '/settings/notifications/ntfy')
  Future<chopper.Response<NtfySettings>> _settingsNotificationsNtfyGet();

  ///Update ntfy.sh notification settings
  Future<chopper.Response<NtfySettings>> settingsNotificationsNtfyPost({
    required NtfySettings? body,
  }) {
    generatedMapping.putIfAbsent(
      NtfySettings,
      () => NtfySettings.fromJsonFactory,
    );

    return _settingsNotificationsNtfyPost(body: body);
  }

  ///Update ntfy.sh notification settings
  @POST(path: '/settings/notifications/ntfy', optionalBody: true)
  Future<chopper.Response<NtfySettings>> _settingsNotificationsNtfyPost({
    @Body() required NtfySettings? body,
  });

  ///Test ntfy.sh settings
  Future<chopper.Response> settingsNotificationsNtfyTestPost({
    required NtfySettings? body,
  }) {
    return _settingsNotificationsNtfyTestPost(body: body);
  }

  ///Test ntfy.sh settings
  @POST(path: '/settings/notifications/ntfy/test', optionalBody: true)
  Future<chopper.Response> _settingsNotificationsNtfyTestPost({
    @Body() required NtfySettings? body,
  });

  ///Get Slack notification settings
  Future<chopper.Response<SlackSettings>> settingsNotificationsSlackGet() {
    generatedMapping.putIfAbsent(
      SlackSettings,
      () => SlackSettings.fromJsonFactory,
    );

    return _settingsNotificationsSlackGet();
  }

  ///Get Slack notification settings
  @GET(path: '/settings/notifications/slack')
  Future<chopper.Response<SlackSettings>> _settingsNotificationsSlackGet();

  ///Update Slack notification settings
  Future<chopper.Response<SlackSettings>> settingsNotificationsSlackPost({
    required SlackSettings? body,
  }) {
    generatedMapping.putIfAbsent(
      SlackSettings,
      () => SlackSettings.fromJsonFactory,
    );

    return _settingsNotificationsSlackPost(body: body);
  }

  ///Update Slack notification settings
  @POST(path: '/settings/notifications/slack', optionalBody: true)
  Future<chopper.Response<SlackSettings>> _settingsNotificationsSlackPost({
    @Body() required SlackSettings? body,
  });

  ///Test Slack settings
  Future<chopper.Response> settingsNotificationsSlackTestPost({
    required SlackSettings? body,
  }) {
    return _settingsNotificationsSlackTestPost(body: body);
  }

  ///Test Slack settings
  @POST(path: '/settings/notifications/slack/test', optionalBody: true)
  Future<chopper.Response> _settingsNotificationsSlackTestPost({
    @Body() required SlackSettings? body,
  });

  ///Get Telegram notification settings
  Future<chopper.Response<TelegramSettings>>
  settingsNotificationsTelegramGet() {
    generatedMapping.putIfAbsent(
      TelegramSettings,
      () => TelegramSettings.fromJsonFactory,
    );

    return _settingsNotificationsTelegramGet();
  }

  ///Get Telegram notification settings
  @GET(path: '/settings/notifications/telegram')
  Future<chopper.Response<TelegramSettings>>
  _settingsNotificationsTelegramGet();

  ///Update Telegram notification settings
  Future<chopper.Response<TelegramSettings>> settingsNotificationsTelegramPost({
    required TelegramSettings? body,
  }) {
    generatedMapping.putIfAbsent(
      TelegramSettings,
      () => TelegramSettings.fromJsonFactory,
    );

    return _settingsNotificationsTelegramPost(body: body);
  }

  ///Update Telegram notification settings
  @POST(path: '/settings/notifications/telegram', optionalBody: true)
  Future<chopper.Response<TelegramSettings>>
  _settingsNotificationsTelegramPost({@Body() required TelegramSettings? body});

  ///Test Telegram settings
  Future<chopper.Response> settingsNotificationsTelegramTestPost({
    required TelegramSettings? body,
  }) {
    return _settingsNotificationsTelegramTestPost(body: body);
  }

  ///Test Telegram settings
  @POST(path: '/settings/notifications/telegram/test', optionalBody: true)
  Future<chopper.Response> _settingsNotificationsTelegramTestPost({
    @Body() required TelegramSettings? body,
  });

  ///Get Web Push notification settings
  Future<chopper.Response<WebPushSettings>> settingsNotificationsWebpushGet() {
    generatedMapping.putIfAbsent(
      WebPushSettings,
      () => WebPushSettings.fromJsonFactory,
    );

    return _settingsNotificationsWebpushGet();
  }

  ///Get Web Push notification settings
  @GET(path: '/settings/notifications/webpush')
  Future<chopper.Response<WebPushSettings>> _settingsNotificationsWebpushGet();

  ///Update Web Push notification settings
  Future<chopper.Response<WebPushSettings>> settingsNotificationsWebpushPost({
    required WebPushSettings? body,
  }) {
    generatedMapping.putIfAbsent(
      WebPushSettings,
      () => WebPushSettings.fromJsonFactory,
    );

    return _settingsNotificationsWebpushPost(body: body);
  }

  ///Update Web Push notification settings
  @POST(path: '/settings/notifications/webpush', optionalBody: true)
  Future<chopper.Response<WebPushSettings>> _settingsNotificationsWebpushPost({
    @Body() required WebPushSettings? body,
  });

  ///Test Web Push settings
  Future<chopper.Response> settingsNotificationsWebpushTestPost({
    required WebPushSettings? body,
  }) {
    return _settingsNotificationsWebpushTestPost(body: body);
  }

  ///Test Web Push settings
  @POST(path: '/settings/notifications/webpush/test', optionalBody: true)
  Future<chopper.Response> _settingsNotificationsWebpushTestPost({
    @Body() required WebPushSettings? body,
  });

  ///Get webhook notification settings
  Future<chopper.Response<WebhookSettings>> settingsNotificationsWebhookGet() {
    generatedMapping.putIfAbsent(
      WebhookSettings,
      () => WebhookSettings.fromJsonFactory,
    );

    return _settingsNotificationsWebhookGet();
  }

  ///Get webhook notification settings
  @GET(path: '/settings/notifications/webhook')
  Future<chopper.Response<WebhookSettings>> _settingsNotificationsWebhookGet();

  ///Update webhook notification settings
  Future<chopper.Response<WebhookSettings>> settingsNotificationsWebhookPost({
    required WebhookSettings? body,
  }) {
    generatedMapping.putIfAbsent(
      WebhookSettings,
      () => WebhookSettings.fromJsonFactory,
    );

    return _settingsNotificationsWebhookPost(body: body);
  }

  ///Update webhook notification settings
  @POST(path: '/settings/notifications/webhook', optionalBody: true)
  Future<chopper.Response<WebhookSettings>> _settingsNotificationsWebhookPost({
    @Body() required WebhookSettings? body,
  });

  ///Test webhook settings
  Future<chopper.Response> settingsNotificationsWebhookTestPost({
    required WebhookSettings? body,
  }) {
    return _settingsNotificationsWebhookTestPost(body: body);
  }

  ///Test webhook settings
  @POST(path: '/settings/notifications/webhook/test', optionalBody: true)
  Future<chopper.Response> _settingsNotificationsWebhookTestPost({
    @Body() required WebhookSettings? body,
  });

  ///Get all discover sliders
  Future<chopper.Response<List<DiscoverSlider>>> settingsDiscoverGet() {
    generatedMapping.putIfAbsent(
      DiscoverSlider,
      () => DiscoverSlider.fromJsonFactory,
    );

    return _settingsDiscoverGet();
  }

  ///Get all discover sliders
  @GET(path: '/settings/discover')
  Future<chopper.Response<List<DiscoverSlider>>> _settingsDiscoverGet();

  ///Batch update all sliders.
  Future<chopper.Response<List<DiscoverSlider>>> settingsDiscoverPost({
    required List<DiscoverSlider>? body,
  }) {
    generatedMapping.putIfAbsent(
      DiscoverSlider,
      () => DiscoverSlider.fromJsonFactory,
    );

    return _settingsDiscoverPost(body: body);
  }

  ///Batch update all sliders.
  @POST(path: '/settings/discover', optionalBody: true)
  Future<chopper.Response<List<DiscoverSlider>>> _settingsDiscoverPost({
    @Body() required List<DiscoverSlider>? body,
  });

  ///Update a single slider
  ///@param sliderId
  Future<chopper.Response<DiscoverSlider>> settingsDiscoverSliderIdPut({
    required num? sliderId,
    required SettingsDiscoverSliderIdPut$RequestBody? body,
  }) {
    generatedMapping.putIfAbsent(
      DiscoverSlider,
      () => DiscoverSlider.fromJsonFactory,
    );

    return _settingsDiscoverSliderIdPut(sliderId: sliderId, body: body);
  }

  ///Update a single slider
  ///@param sliderId
  @PUT(path: '/settings/discover/{sliderId}', optionalBody: true)
  Future<chopper.Response<DiscoverSlider>> _settingsDiscoverSliderIdPut({
    @Path('sliderId') required num? sliderId,
    @Body() required SettingsDiscoverSliderIdPut$RequestBody? body,
  });

  ///Delete slider by ID
  ///@param sliderId
  Future<chopper.Response<DiscoverSlider>> settingsDiscoverSliderIdDelete({
    required num? sliderId,
  }) {
    generatedMapping.putIfAbsent(
      DiscoverSlider,
      () => DiscoverSlider.fromJsonFactory,
    );

    return _settingsDiscoverSliderIdDelete(sliderId: sliderId);
  }

  ///Delete slider by ID
  ///@param sliderId
  @DELETE(path: '/settings/discover/{sliderId}')
  Future<chopper.Response<DiscoverSlider>> _settingsDiscoverSliderIdDelete({
    @Path('sliderId') required num? sliderId,
  });

  ///Add a new slider
  Future<chopper.Response<DiscoverSlider>> settingsDiscoverAddPost({
    required SettingsDiscoverAddPost$RequestBody? body,
  }) {
    generatedMapping.putIfAbsent(
      DiscoverSlider,
      () => DiscoverSlider.fromJsonFactory,
    );

    return _settingsDiscoverAddPost(body: body);
  }

  ///Add a new slider
  @POST(path: '/settings/discover/add', optionalBody: true)
  Future<chopper.Response<DiscoverSlider>> _settingsDiscoverAddPost({
    @Body() required SettingsDiscoverAddPost$RequestBody? body,
  });

  ///Reset all discover sliders
  Future<chopper.Response> settingsDiscoverResetGet() {
    return _settingsDiscoverResetGet();
  }

  ///Reset all discover sliders
  @GET(path: '/settings/discover/reset')
  Future<chopper.Response> _settingsDiscoverResetGet();

  ///Get server stats
  Future<chopper.Response<SettingsAboutGet$Response>> settingsAboutGet() {
    generatedMapping.putIfAbsent(
      SettingsAboutGet$Response,
      () => SettingsAboutGet$Response.fromJsonFactory,
    );

    return _settingsAboutGet();
  }

  ///Get server stats
  @GET(path: '/settings/about')
  Future<chopper.Response<SettingsAboutGet$Response>> _settingsAboutGet();

  ///Get logged-in user
  Future<chopper.Response<User>> authMeGet() {
    generatedMapping.putIfAbsent(User, () => User.fromJsonFactory);

    return _authMeGet();
  }

  ///Get logged-in user
  @GET(path: '/auth/me')
  Future<chopper.Response<User>> _authMeGet();

  ///Sign in using a Plex token
  Future<chopper.Response<User>> authPlexPost({
    required AuthPlexPost$RequestBody? body,
  }) {
    generatedMapping.putIfAbsent(User, () => User.fromJsonFactory);

    return _authPlexPost(body: body);
  }

  ///Sign in using a Plex token
  @POST(path: '/auth/plex', optionalBody: true)
  Future<chopper.Response<User>> _authPlexPost({
    @Body() required AuthPlexPost$RequestBody? body,
  });

  ///Sign in using a Jellyfin username and password
  Future<chopper.Response<User>> authJellyfinPost({
    required AuthJellyfinPost$RequestBody? body,
  }) {
    generatedMapping.putIfAbsent(User, () => User.fromJsonFactory);

    return _authJellyfinPost(body: body);
  }

  ///Sign in using a Jellyfin username and password
  @POST(path: '/auth/jellyfin', optionalBody: true)
  Future<chopper.Response<User>> _authJellyfinPost({
    @Body() required AuthJellyfinPost$RequestBody? body,
  });

  ///Sign in using a local account
  Future<chopper.Response<User>> authLocalPost({
    required AuthLocalPost$RequestBody? body,
  }) {
    generatedMapping.putIfAbsent(User, () => User.fromJsonFactory);

    return _authLocalPost(body: body);
  }

  ///Sign in using a local account
  @POST(path: '/auth/local', optionalBody: true)
  Future<chopper.Response<User>> _authLocalPost({
    @Body() required AuthLocalPost$RequestBody? body,
  });

  ///Sign out and clear session cookie
  Future<chopper.Response<AuthLogoutPost$Response>> authLogoutPost() {
    generatedMapping.putIfAbsent(
      AuthLogoutPost$Response,
      () => AuthLogoutPost$Response.fromJsonFactory,
    );

    return _authLogoutPost();
  }

  ///Sign out and clear session cookie
  @POST(path: '/auth/logout', optionalBody: true)
  Future<chopper.Response<AuthLogoutPost$Response>> _authLogoutPost();

  ///Send a reset password email
  Future<chopper.Response<AuthResetPasswordPost$Response>>
  authResetPasswordPost({required AuthResetPasswordPost$RequestBody? body}) {
    generatedMapping.putIfAbsent(
      AuthResetPasswordPost$Response,
      () => AuthResetPasswordPost$Response.fromJsonFactory,
    );

    return _authResetPasswordPost(body: body);
  }

  ///Send a reset password email
  @POST(path: '/auth/reset-password', optionalBody: true)
  Future<chopper.Response<AuthResetPasswordPost$Response>>
  _authResetPasswordPost({
    @Body() required AuthResetPasswordPost$RequestBody? body,
  });

  ///Reset the password for a user
  ///@param guid
  Future<chopper.Response<AuthResetPasswordGuidPost$Response>>
  authResetPasswordGuidPost({
    required String? guid,
    required AuthResetPasswordGuidPost$RequestBody? body,
  }) {
    generatedMapping.putIfAbsent(
      AuthResetPasswordGuidPost$Response,
      () => AuthResetPasswordGuidPost$Response.fromJsonFactory,
    );

    return _authResetPasswordGuidPost(guid: guid, body: body);
  }

  ///Reset the password for a user
  ///@param guid
  @POST(path: '/auth/reset-password/{guid}', optionalBody: true)
  Future<chopper.Response<AuthResetPasswordGuidPost$Response>>
  _authResetPasswordGuidPost({
    @Path('guid') required String? guid,
    @Body() required AuthResetPasswordGuidPost$RequestBody? body,
  });

  ///Get all users
  ///@param take
  ///@param skip
  ///@param sort
  ///@param q
  ///@param includeIds
  Future<chopper.Response<UserGet$Response>> userGet({
    num? take,
    num? skip,
    enums.UserGetSort? sort,
    String? q,
    String? includeIds,
  }) {
    generatedMapping.putIfAbsent(
      UserGet$Response,
      () => UserGet$Response.fromJsonFactory,
    );

    return _userGet(
      take: take,
      skip: skip,
      sort: sort?.value?.toString(),
      q: q,
      includeIds: includeIds,
    );
  }

  ///Get all users
  ///@param take
  ///@param skip
  ///@param sort
  ///@param q
  ///@param includeIds
  @GET(path: '/user')
  Future<chopper.Response<UserGet$Response>> _userGet({
    @Query('take') num? take,
    @Query('skip') num? skip,
    @Query('sort') String? sort,
    @Query('q') String? q,
    @Query('includeIds') String? includeIds,
  });

  ///Update batch of users
  Future<chopper.Response<List<User>>> userPut({
    required UserPut$RequestBody? body,
  }) {
    generatedMapping.putIfAbsent(User, () => User.fromJsonFactory);

    return _userPut(body: body);
  }

  ///Update batch of users
  @PUT(path: '/user', optionalBody: true)
  Future<chopper.Response<List<User>>> _userPut({
    @Body() required UserPut$RequestBody? body,
  });

  ///Create new user
  Future<chopper.Response<User>> userPost({
    required UserPost$RequestBody? body,
  }) {
    generatedMapping.putIfAbsent(User, () => User.fromJsonFactory);

    return _userPost(body: body);
  }

  ///Create new user
  @POST(path: '/user', optionalBody: true)
  Future<chopper.Response<User>> _userPost({
    @Body() required UserPost$RequestBody? body,
  });

  ///Import all users from Plex
  Future<chopper.Response<List<User>>> userImportFromPlexPost({
    required UserImportFromPlexPost$RequestBody? body,
  }) {
    generatedMapping.putIfAbsent(User, () => User.fromJsonFactory);

    return _userImportFromPlexPost(body: body);
  }

  ///Import all users from Plex
  @POST(path: '/user/import-from-plex', optionalBody: true)
  Future<chopper.Response<List<User>>> _userImportFromPlexPost({
    @Body() required UserImportFromPlexPost$RequestBody? body,
  });

  ///Import all users from Jellyfin
  Future<chopper.Response<List<User>>> userImportFromJellyfinPost({
    required UserImportFromJellyfinPost$RequestBody? body,
  }) {
    generatedMapping.putIfAbsent(User, () => User.fromJsonFactory);

    return _userImportFromJellyfinPost(body: body);
  }

  ///Import all users from Jellyfin
  @POST(path: '/user/import-from-jellyfin', optionalBody: true)
  Future<chopper.Response<List<User>>> _userImportFromJellyfinPost({
    @Body() required UserImportFromJellyfinPost$RequestBody? body,
  });

  ///Register a web push /user/registerPushSubscription
  Future<chopper.Response> userRegisterPushSubscriptionPost({
    required UserRegisterPushSubscriptionPost$RequestBody? body,
  }) {
    return _userRegisterPushSubscriptionPost(body: body);
  }

  ///Register a web push /user/registerPushSubscription
  @POST(path: '/user/registerPushSubscription', optionalBody: true)
  Future<chopper.Response> _userRegisterPushSubscriptionPost({
    @Body() required UserRegisterPushSubscriptionPost$RequestBody? body,
  });

  ///Get all web push notification settings for a user
  ///@param userId
  Future<chopper.Response<UserUserIdPushSubscriptionsGet$Response>>
  userUserIdPushSubscriptionsGet({required num? userId}) {
    generatedMapping.putIfAbsent(
      UserUserIdPushSubscriptionsGet$Response,
      () => UserUserIdPushSubscriptionsGet$Response.fromJsonFactory,
    );

    return _userUserIdPushSubscriptionsGet(userId: userId);
  }

  ///Get all web push notification settings for a user
  ///@param userId
  @GET(path: '/user/{userId}/pushSubscriptions')
  Future<chopper.Response<UserUserIdPushSubscriptionsGet$Response>>
  _userUserIdPushSubscriptionsGet({@Path('userId') required num? userId});

  ///Get web push notification settings for a user
  ///@param userId
  ///@param endpoint
  Future<chopper.Response<UserUserIdPushSubscriptionEndpointGet$Response>>
  userUserIdPushSubscriptionEndpointGet({
    required num? userId,
    required String? endpoint,
  }) {
    generatedMapping.putIfAbsent(
      UserUserIdPushSubscriptionEndpointGet$Response,
      () => UserUserIdPushSubscriptionEndpointGet$Response.fromJsonFactory,
    );

    return _userUserIdPushSubscriptionEndpointGet(
      userId: userId,
      endpoint: endpoint,
    );
  }

  ///Get web push notification settings for a user
  ///@param userId
  ///@param endpoint
  @GET(path: '/user/{userId}/pushSubscription/{endpoint}')
  Future<chopper.Response<UserUserIdPushSubscriptionEndpointGet$Response>>
  _userUserIdPushSubscriptionEndpointGet({
    @Path('userId') required num? userId,
    @Path('endpoint') required String? endpoint,
  });

  ///Delete user push subscription by key
  ///@param userId
  ///@param endpoint
  Future<chopper.Response> userUserIdPushSubscriptionEndpointDelete({
    required num? userId,
    required String? endpoint,
  }) {
    return _userUserIdPushSubscriptionEndpointDelete(
      userId: userId,
      endpoint: endpoint,
    );
  }

  ///Delete user push subscription by key
  ///@param userId
  ///@param endpoint
  @DELETE(path: '/user/{userId}/pushSubscription/{endpoint}')
  Future<chopper.Response> _userUserIdPushSubscriptionEndpointDelete({
    @Path('userId') required num? userId,
    @Path('endpoint') required String? endpoint,
  });

  ///Get user by ID
  ///@param userId
  Future<chopper.Response<User>> userUserIdGet({required num? userId}) {
    generatedMapping.putIfAbsent(User, () => User.fromJsonFactory);

    return _userUserIdGet(userId: userId);
  }

  ///Get user by ID
  ///@param userId
  @GET(path: '/user/{userId}')
  Future<chopper.Response<User>> _userUserIdGet({
    @Path('userId') required num? userId,
  });

  ///Update a user by user ID
  ///@param userId
  Future<chopper.Response<User>> userUserIdPut({
    required num? userId,
    required User? body,
  }) {
    generatedMapping.putIfAbsent(User, () => User.fromJsonFactory);

    return _userUserIdPut(userId: userId, body: body);
  }

  ///Update a user by user ID
  ///@param userId
  @PUT(path: '/user/{userId}', optionalBody: true)
  Future<chopper.Response<User>> _userUserIdPut({
    @Path('userId') required num? userId,
    @Body() required User? body,
  });

  ///Delete user by ID
  ///@param userId
  Future<chopper.Response<User>> userUserIdDelete({required num? userId}) {
    generatedMapping.putIfAbsent(User, () => User.fromJsonFactory);

    return _userUserIdDelete(userId: userId);
  }

  ///Delete user by ID
  ///@param userId
  @DELETE(path: '/user/{userId}')
  Future<chopper.Response<User>> _userUserIdDelete({
    @Path('userId') required num? userId,
  });

  ///Get requests for a specific user
  ///@param userId
  ///@param take
  ///@param skip
  Future<chopper.Response<UserUserIdRequestsGet$Response>>
  userUserIdRequestsGet({required num? userId, num? take, num? skip}) {
    generatedMapping.putIfAbsent(
      UserUserIdRequestsGet$Response,
      () => UserUserIdRequestsGet$Response.fromJsonFactory,
    );

    return _userUserIdRequestsGet(userId: userId, take: take, skip: skip);
  }

  ///Get requests for a specific user
  ///@param userId
  ///@param take
  ///@param skip
  @GET(path: '/user/{userId}/requests')
  Future<chopper.Response<UserUserIdRequestsGet$Response>>
  _userUserIdRequestsGet({
    @Path('userId') required num? userId,
    @Query('take') num? take,
    @Query('skip') num? skip,
  });

  ///Get quotas for a specific user
  ///@param userId
  Future<chopper.Response<UserUserIdQuotaGet$Response>> userUserIdQuotaGet({
    required num? userId,
  }) {
    generatedMapping.putIfAbsent(
      UserUserIdQuotaGet$Response,
      () => UserUserIdQuotaGet$Response.fromJsonFactory,
    );

    return _userUserIdQuotaGet(userId: userId);
  }

  ///Get quotas for a specific user
  ///@param userId
  @GET(path: '/user/{userId}/quota')
  Future<chopper.Response<UserUserIdQuotaGet$Response>> _userUserIdQuotaGet({
    @Path('userId') required num? userId,
  });

  ///Returns blacklisted items
  ///@param take
  ///@param skip
  ///@param search
  ///@param filter
  Future<chopper.Response<BlacklistGet$Response>> blacklistGet({
    num? take,
    num? skip,
    String? search,
    enums.BlacklistGetFilter? filter,
  }) {
    generatedMapping.putIfAbsent(
      BlacklistGet$Response,
      () => BlacklistGet$Response.fromJsonFactory,
    );

    return _blacklistGet(
      take: take,
      skip: skip,
      search: search,
      filter: filter?.value?.toString(),
    );
  }

  ///Returns blacklisted items
  ///@param take
  ///@param skip
  ///@param search
  ///@param filter
  @GET(path: '/blacklist')
  Future<chopper.Response<BlacklistGet$Response>> _blacklistGet({
    @Query('take') num? take,
    @Query('skip') num? skip,
    @Query('search') String? search,
    @Query('filter') String? filter,
  });

  ///Add media to blacklist
  Future<chopper.Response> blacklistPost({required Blacklist? body}) {
    return _blacklistPost(body: body);
  }

  ///Add media to blacklist
  @POST(path: '/blacklist', optionalBody: true)
  Future<chopper.Response> _blacklistPost({@Body() required Blacklist? body});

  ///Get media from blacklist
  ///@param tmdbId tmdbId ID
  Future<chopper.Response> blacklistTmdbIdGet({required String? tmdbId}) {
    return _blacklistTmdbIdGet(tmdbId: tmdbId);
  }

  ///Get media from blacklist
  ///@param tmdbId tmdbId ID
  @GET(path: '/blacklist/{tmdbId}')
  Future<chopper.Response> _blacklistTmdbIdGet({
    @Path('tmdbId') required String? tmdbId,
  });

  ///Remove media from blacklist
  ///@param tmdbId tmdbId ID
  Future<chopper.Response> blacklistTmdbIdDelete({required String? tmdbId}) {
    return _blacklistTmdbIdDelete(tmdbId: tmdbId);
  }

  ///Remove media from blacklist
  ///@param tmdbId tmdbId ID
  @DELETE(path: '/blacklist/{tmdbId}')
  Future<chopper.Response> _blacklistTmdbIdDelete({
    @Path('tmdbId') required String? tmdbId,
  });

  ///Add media to watchlist
  Future<chopper.Response<Watchlist>> watchlistPost({
    required Watchlist? body,
  }) {
    generatedMapping.putIfAbsent(Watchlist, () => Watchlist.fromJsonFactory);

    return _watchlistPost(body: body);
  }

  ///Add media to watchlist
  @POST(path: '/watchlist', optionalBody: true)
  Future<chopper.Response<Watchlist>> _watchlistPost({
    @Body() required Watchlist? body,
  });

  ///Delete watchlist item
  ///@param tmdbId tmdbId ID
  Future<chopper.Response> watchlistTmdbIdDelete({required String? tmdbId}) {
    return _watchlistTmdbIdDelete(tmdbId: tmdbId);
  }

  ///Delete watchlist item
  ///@param tmdbId tmdbId ID
  @DELETE(path: '/watchlist/{tmdbId}')
  Future<chopper.Response> _watchlistTmdbIdDelete({
    @Path('tmdbId') required String? tmdbId,
  });

  ///Get the Plex watchlist for a specific user
  ///@param userId
  ///@param page
  Future<chopper.Response<UserUserIdWatchlistGet$Response>>
  userUserIdWatchlistGet({required num? userId, num? page}) {
    generatedMapping.putIfAbsent(
      UserUserIdWatchlistGet$Response,
      () => UserUserIdWatchlistGet$Response.fromJsonFactory,
    );

    return _userUserIdWatchlistGet(userId: userId, page: page);
  }

  ///Get the Plex watchlist for a specific user
  ///@param userId
  ///@param page
  @GET(path: '/user/{userId}/watchlist')
  Future<chopper.Response<UserUserIdWatchlistGet$Response>>
  _userUserIdWatchlistGet({
    @Path('userId') required num? userId,
    @Query('page') num? page,
  });

  ///Get general settings for a user
  ///@param userId
  Future<chopper.Response<UserSettings>> userUserIdSettingsMainGet({
    required num? userId,
  }) {
    generatedMapping.putIfAbsent(
      UserSettings,
      () => UserSettings.fromJsonFactory,
    );

    return _userUserIdSettingsMainGet(userId: userId);
  }

  ///Get general settings for a user
  ///@param userId
  @GET(path: '/user/{userId}/settings/main')
  Future<chopper.Response<UserSettings>> _userUserIdSettingsMainGet({
    @Path('userId') required num? userId,
  });

  ///Update general settings for a user
  ///@param userId
  Future<chopper.Response<UserSettings>> userUserIdSettingsMainPost({
    required num? userId,
    required UserSettings? body,
  }) {
    generatedMapping.putIfAbsent(
      UserSettings,
      () => UserSettings.fromJsonFactory,
    );

    return _userUserIdSettingsMainPost(userId: userId, body: body);
  }

  ///Update general settings for a user
  ///@param userId
  @POST(path: '/user/{userId}/settings/main', optionalBody: true)
  Future<chopper.Response<UserSettings>> _userUserIdSettingsMainPost({
    @Path('userId') required num? userId,
    @Body() required UserSettings? body,
  });

  ///Get password page informatiom
  ///@param userId
  Future<chopper.Response<UserUserIdSettingsPasswordGet$Response>>
  userUserIdSettingsPasswordGet({required num? userId}) {
    generatedMapping.putIfAbsent(
      UserUserIdSettingsPasswordGet$Response,
      () => UserUserIdSettingsPasswordGet$Response.fromJsonFactory,
    );

    return _userUserIdSettingsPasswordGet(userId: userId);
  }

  ///Get password page informatiom
  ///@param userId
  @GET(path: '/user/{userId}/settings/password')
  Future<chopper.Response<UserUserIdSettingsPasswordGet$Response>>
  _userUserIdSettingsPasswordGet({@Path('userId') required num? userId});

  ///Update password for a user
  ///@param userId
  Future<chopper.Response> userUserIdSettingsPasswordPost({
    required num? userId,
    required UserUserIdSettingsPasswordPost$RequestBody? body,
  }) {
    return _userUserIdSettingsPasswordPost(userId: userId, body: body);
  }

  ///Update password for a user
  ///@param userId
  @POST(path: '/user/{userId}/settings/password', optionalBody: true)
  Future<chopper.Response> _userUserIdSettingsPasswordPost({
    @Path('userId') required num? userId,
    @Body() required UserUserIdSettingsPasswordPost$RequestBody? body,
  });

  ///Link the provided Plex account to the current user
  ///@param userId
  Future<chopper.Response> userUserIdSettingsLinkedAccountsPlexPost({
    required num? userId,
    required UserUserIdSettingsLinkedAccountsPlexPost$RequestBody? body,
  }) {
    return _userUserIdSettingsLinkedAccountsPlexPost(
      userId: userId,
      body: body,
    );
  }

  ///Link the provided Plex account to the current user
  ///@param userId
  @POST(
    path: '/user/{userId}/settings/linked-accounts/plex',
    optionalBody: true,
  )
  Future<chopper.Response> _userUserIdSettingsLinkedAccountsPlexPost({
    @Path('userId') required num? userId,
    @Body() required UserUserIdSettingsLinkedAccountsPlexPost$RequestBody? body,
  });

  ///Remove the linked Plex account for a user
  ///@param userId
  Future<chopper.Response> userUserIdSettingsLinkedAccountsPlexDelete({
    required num? userId,
  }) {
    return _userUserIdSettingsLinkedAccountsPlexDelete(userId: userId);
  }

  ///Remove the linked Plex account for a user
  ///@param userId
  @DELETE(path: '/user/{userId}/settings/linked-accounts/plex')
  Future<chopper.Response> _userUserIdSettingsLinkedAccountsPlexDelete({
    @Path('userId') required num? userId,
  });

  ///Link the provided Jellyfin account to the current user
  ///@param userId
  Future<chopper.Response> userUserIdSettingsLinkedAccountsJellyfinPost({
    required num? userId,
    required UserUserIdSettingsLinkedAccountsJellyfinPost$RequestBody? body,
  }) {
    return _userUserIdSettingsLinkedAccountsJellyfinPost(
      userId: userId,
      body: body,
    );
  }

  ///Link the provided Jellyfin account to the current user
  ///@param userId
  @POST(
    path: '/user/{userId}/settings/linked-accounts/jellyfin',
    optionalBody: true,
  )
  Future<chopper.Response> _userUserIdSettingsLinkedAccountsJellyfinPost({
    @Path('userId') required num? userId,
    @Body()
    required UserUserIdSettingsLinkedAccountsJellyfinPost$RequestBody? body,
  });

  ///Remove the linked Jellyfin account for a user
  ///@param userId
  Future<chopper.Response> userUserIdSettingsLinkedAccountsJellyfinDelete({
    required num? userId,
  }) {
    return _userUserIdSettingsLinkedAccountsJellyfinDelete(userId: userId);
  }

  ///Remove the linked Jellyfin account for a user
  ///@param userId
  @DELETE(path: '/user/{userId}/settings/linked-accounts/jellyfin')
  Future<chopper.Response> _userUserIdSettingsLinkedAccountsJellyfinDelete({
    @Path('userId') required num? userId,
  });

  ///Get notification settings for a user
  ///@param userId
  Future<chopper.Response<UserSettingsNotifications>>
  userUserIdSettingsNotificationsGet({required num? userId}) {
    generatedMapping.putIfAbsent(
      UserSettingsNotifications,
      () => UserSettingsNotifications.fromJsonFactory,
    );

    return _userUserIdSettingsNotificationsGet(userId: userId);
  }

  ///Get notification settings for a user
  ///@param userId
  @GET(path: '/user/{userId}/settings/notifications')
  Future<chopper.Response<UserSettingsNotifications>>
  _userUserIdSettingsNotificationsGet({@Path('userId') required num? userId});

  ///Update notification settings for a user
  ///@param userId
  Future<chopper.Response<UserSettingsNotifications>>
  userUserIdSettingsNotificationsPost({
    required num? userId,
    required UserSettingsNotifications? body,
  }) {
    generatedMapping.putIfAbsent(
      UserSettingsNotifications,
      () => UserSettingsNotifications.fromJsonFactory,
    );

    return _userUserIdSettingsNotificationsPost(userId: userId, body: body);
  }

  ///Update notification settings for a user
  ///@param userId
  @POST(path: '/user/{userId}/settings/notifications', optionalBody: true)
  Future<chopper.Response<UserSettingsNotifications>>
  _userUserIdSettingsNotificationsPost({
    @Path('userId') required num? userId,
    @Body() required UserSettingsNotifications? body,
  });

  ///Get permission settings for a user
  ///@param userId
  Future<chopper.Response<UserUserIdSettingsPermissionsGet$Response>>
  userUserIdSettingsPermissionsGet({required num? userId}) {
    generatedMapping.putIfAbsent(
      UserUserIdSettingsPermissionsGet$Response,
      () => UserUserIdSettingsPermissionsGet$Response.fromJsonFactory,
    );

    return _userUserIdSettingsPermissionsGet(userId: userId);
  }

  ///Get permission settings for a user
  ///@param userId
  @GET(path: '/user/{userId}/settings/permissions')
  Future<chopper.Response<UserUserIdSettingsPermissionsGet$Response>>
  _userUserIdSettingsPermissionsGet({@Path('userId') required num? userId});

  ///Update permission settings for a user
  ///@param userId
  Future<chopper.Response<UserUserIdSettingsPermissionsPost$Response>>
  userUserIdSettingsPermissionsPost({
    required num? userId,
    required UserUserIdSettingsPermissionsPost$RequestBody? body,
  }) {
    generatedMapping.putIfAbsent(
      UserUserIdSettingsPermissionsPost$Response,
      () => UserUserIdSettingsPermissionsPost$Response.fromJsonFactory,
    );

    return _userUserIdSettingsPermissionsPost(userId: userId, body: body);
  }

  ///Update permission settings for a user
  ///@param userId
  @POST(path: '/user/{userId}/settings/permissions', optionalBody: true)
  Future<chopper.Response<UserUserIdSettingsPermissionsPost$Response>>
  _userUserIdSettingsPermissionsPost({
    @Path('userId') required num? userId,
    @Body() required UserUserIdSettingsPermissionsPost$RequestBody? body,
  });

  ///Get watch data
  ///@param userId
  Future<chopper.Response<UserUserIdWatchDataGet$Response>>
  userUserIdWatchDataGet({required num? userId}) {
    generatedMapping.putIfAbsent(
      UserUserIdWatchDataGet$Response,
      () => UserUserIdWatchDataGet$Response.fromJsonFactory,
    );

    return _userUserIdWatchDataGet(userId: userId);
  }

  ///Get watch data
  ///@param userId
  @GET(path: '/user/{userId}/watch_data')
  Future<chopper.Response<UserUserIdWatchDataGet$Response>>
  _userUserIdWatchDataGet({@Path('userId') required num? userId});

  ///Search for movies, TV shows, or people
  ///@param query
  ///@param page
  ///@param language
  Future<chopper.Response<SearchGet$Response>> searchGet({
    required String? query,
    num? page,
    String? language,
  }) {
    generatedMapping.putIfAbsent(
      SearchGet$Response,
      () => SearchGet$Response.fromJsonFactory,
    );

    return _searchGet(query: query, page: page, language: language);
  }

  ///Search for movies, TV shows, or people
  ///@param query
  ///@param page
  ///@param language
  @GET(path: '/search')
  Future<chopper.Response<SearchGet$Response>> _searchGet({
    @Query('query') required String? query,
    @Query('page') num? page,
    @Query('language') String? language,
  });

  ///Search for keywords
  ///@param query
  ///@param page
  Future<chopper.Response<SearchKeywordGet$Response>> searchKeywordGet({
    required String? query,
    num? page,
  }) {
    generatedMapping.putIfAbsent(
      SearchKeywordGet$Response,
      () => SearchKeywordGet$Response.fromJsonFactory,
    );

    return _searchKeywordGet(query: query, page: page);
  }

  ///Search for keywords
  ///@param query
  ///@param page
  @GET(path: '/search/keyword')
  Future<chopper.Response<SearchKeywordGet$Response>> _searchKeywordGet({
    @Query('query') required String? query,
    @Query('page') num? page,
  });

  ///Search for companies
  ///@param query
  ///@param page
  Future<chopper.Response<SearchCompanyGet$Response>> searchCompanyGet({
    required String? query,
    num? page,
  }) {
    generatedMapping.putIfAbsent(
      SearchCompanyGet$Response,
      () => SearchCompanyGet$Response.fromJsonFactory,
    );

    return _searchCompanyGet(query: query, page: page);
  }

  ///Search for companies
  ///@param query
  ///@param page
  @GET(path: '/search/company')
  Future<chopper.Response<SearchCompanyGet$Response>> _searchCompanyGet({
    @Query('query') required String? query,
    @Query('page') num? page,
  });

  ///Discover movies
  ///@param page
  ///@param language
  ///@param genre
  ///@param studio
  ///@param keywords
  ///@param excludeKeywords Comma-separated list of keyword IDs to exclude from results
  ///@param sortBy
  ///@param primaryReleaseDateGte
  ///@param primaryReleaseDateLte
  ///@param withRuntimeGte
  ///@param withRuntimeLte
  ///@param voteAverageGte
  ///@param voteAverageLte
  ///@param voteCountGte
  ///@param voteCountLte
  ///@param watchRegion
  ///@param watchProviders
  ///@param certification Exact certification to filter by (used when certificationMode is 'exact')
  ///@param certificationGte Minimum certification to filter by (used when certificationMode is 'range')
  ///@param certificationLte Maximum certification to filter by (used when certificationMode is 'range')
  ///@param certificationCountry Country code for the certification system (e.g., US, GB, CA)
  ///@param certificationMode Determines whether to use exact certification matching or a certification range (internal use only, not sent to TMDB API)
  Future<chopper.Response<DiscoverMoviesGet$Response>> discoverMoviesGet({
    num? page,
    String? language,
    String? genre,
    num? studio,
    String? keywords,
    String? excludeKeywords,
    String? sortBy,
    String? primaryReleaseDateGte,
    String? primaryReleaseDateLte,
    num? withRuntimeGte,
    num? withRuntimeLte,
    num? voteAverageGte,
    num? voteAverageLte,
    num? voteCountGte,
    num? voteCountLte,
    String? watchRegion,
    String? watchProviders,
    String? certification,
    String? certificationGte,
    String? certificationLte,
    String? certificationCountry,
    enums.DiscoverMoviesGetCertificationMode? certificationMode,
  }) {
    generatedMapping.putIfAbsent(
      DiscoverMoviesGet$Response,
      () => DiscoverMoviesGet$Response.fromJsonFactory,
    );

    return _discoverMoviesGet(
      page: page,
      language: language,
      genre: genre,
      studio: studio,
      keywords: keywords,
      excludeKeywords: excludeKeywords,
      sortBy: sortBy,
      primaryReleaseDateGte: primaryReleaseDateGte,
      primaryReleaseDateLte: primaryReleaseDateLte,
      withRuntimeGte: withRuntimeGte,
      withRuntimeLte: withRuntimeLte,
      voteAverageGte: voteAverageGte,
      voteAverageLte: voteAverageLte,
      voteCountGte: voteCountGte,
      voteCountLte: voteCountLte,
      watchRegion: watchRegion,
      watchProviders: watchProviders,
      certification: certification,
      certificationGte: certificationGte,
      certificationLte: certificationLte,
      certificationCountry: certificationCountry,
      certificationMode: certificationMode?.value?.toString(),
    );
  }

  ///Discover movies
  ///@param page
  ///@param language
  ///@param genre
  ///@param studio
  ///@param keywords
  ///@param excludeKeywords Comma-separated list of keyword IDs to exclude from results
  ///@param sortBy
  ///@param primaryReleaseDateGte
  ///@param primaryReleaseDateLte
  ///@param withRuntimeGte
  ///@param withRuntimeLte
  ///@param voteAverageGte
  ///@param voteAverageLte
  ///@param voteCountGte
  ///@param voteCountLte
  ///@param watchRegion
  ///@param watchProviders
  ///@param certification Exact certification to filter by (used when certificationMode is 'exact')
  ///@param certificationGte Minimum certification to filter by (used when certificationMode is 'range')
  ///@param certificationLte Maximum certification to filter by (used when certificationMode is 'range')
  ///@param certificationCountry Country code for the certification system (e.g., US, GB, CA)
  ///@param certificationMode Determines whether to use exact certification matching or a certification range (internal use only, not sent to TMDB API)
  @GET(path: '/discover/movies')
  Future<chopper.Response<DiscoverMoviesGet$Response>> _discoverMoviesGet({
    @Query('page') num? page,
    @Query('language') String? language,
    @Query('genre') String? genre,
    @Query('studio') num? studio,
    @Query('keywords') String? keywords,
    @Query('excludeKeywords') String? excludeKeywords,
    @Query('sortBy') String? sortBy,
    @Query('primaryReleaseDateGte') String? primaryReleaseDateGte,
    @Query('primaryReleaseDateLte') String? primaryReleaseDateLte,
    @Query('withRuntimeGte') num? withRuntimeGte,
    @Query('withRuntimeLte') num? withRuntimeLte,
    @Query('voteAverageGte') num? voteAverageGte,
    @Query('voteAverageLte') num? voteAverageLte,
    @Query('voteCountGte') num? voteCountGte,
    @Query('voteCountLte') num? voteCountLte,
    @Query('watchRegion') String? watchRegion,
    @Query('watchProviders') String? watchProviders,
    @Query('certification') String? certification,
    @Query('certificationGte') String? certificationGte,
    @Query('certificationLte') String? certificationLte,
    @Query('certificationCountry') String? certificationCountry,
    @Query('certificationMode') String? certificationMode,
  });

  ///Discover movies by genre
  ///@param genreId
  ///@param page
  ///@param language
  Future<chopper.Response<DiscoverMoviesGenreGenreIdGet$Response>>
  discoverMoviesGenreGenreIdGet({
    required String? genreId,
    num? page,
    String? language,
  }) {
    generatedMapping.putIfAbsent(
      DiscoverMoviesGenreGenreIdGet$Response,
      () => DiscoverMoviesGenreGenreIdGet$Response.fromJsonFactory,
    );

    return _discoverMoviesGenreGenreIdGet(
      genreId: genreId,
      page: page,
      language: language,
    );
  }

  ///Discover movies by genre
  ///@param genreId
  ///@param page
  ///@param language
  @GET(path: '/discover/movies/genre/{genreId}')
  Future<chopper.Response<DiscoverMoviesGenreGenreIdGet$Response>>
  _discoverMoviesGenreGenreIdGet({
    @Path('genreId') required String? genreId,
    @Query('page') num? page,
    @Query('language') String? language,
  });

  ///Discover movies by original language
  ///@param language
  ///@param page
  ///@param language
  Future<chopper.Response<DiscoverMoviesLanguageLanguageGet$Response>>
  discoverMoviesLanguageLanguageGet({
    required String? language,
    num? page,
    String? language$,
  }) {
    generatedMapping.putIfAbsent(
      DiscoverMoviesLanguageLanguageGet$Response,
      () => DiscoverMoviesLanguageLanguageGet$Response.fromJsonFactory,
    );

    return _discoverMoviesLanguageLanguageGet(
      language: language,
      page: page,
      language$: language$,
    );
  }

  ///Discover movies by original language
  ///@param language
  ///@param page
  ///@param language
  @GET(path: '/discover/movies/language/{language}')
  Future<chopper.Response<DiscoverMoviesLanguageLanguageGet$Response>>
  _discoverMoviesLanguageLanguageGet({
    @Path('language') required String? language,
    @Query('page') num? page,
    @Query('language') String? language$,
  });

  ///Discover movies by studio
  ///@param studioId
  ///@param page
  ///@param language
  Future<chopper.Response<DiscoverMoviesStudioStudioIdGet$Response>>
  discoverMoviesStudioStudioIdGet({
    required String? studioId,
    num? page,
    String? language,
  }) {
    generatedMapping.putIfAbsent(
      DiscoverMoviesStudioStudioIdGet$Response,
      () => DiscoverMoviesStudioStudioIdGet$Response.fromJsonFactory,
    );

    return _discoverMoviesStudioStudioIdGet(
      studioId: studioId,
      page: page,
      language: language,
    );
  }

  ///Discover movies by studio
  ///@param studioId
  ///@param page
  ///@param language
  @GET(path: '/discover/movies/studio/{studioId}')
  Future<chopper.Response<DiscoverMoviesStudioStudioIdGet$Response>>
  _discoverMoviesStudioStudioIdGet({
    @Path('studioId') required String? studioId,
    @Query('page') num? page,
    @Query('language') String? language,
  });

  ///Upcoming movies
  ///@param page
  ///@param language
  Future<chopper.Response<DiscoverMoviesUpcomingGet$Response>>
  discoverMoviesUpcomingGet({num? page, String? language}) {
    generatedMapping.putIfAbsent(
      DiscoverMoviesUpcomingGet$Response,
      () => DiscoverMoviesUpcomingGet$Response.fromJsonFactory,
    );

    return _discoverMoviesUpcomingGet(page: page, language: language);
  }

  ///Upcoming movies
  ///@param page
  ///@param language
  @GET(path: '/discover/movies/upcoming')
  Future<chopper.Response<DiscoverMoviesUpcomingGet$Response>>
  _discoverMoviesUpcomingGet({
    @Query('page') num? page,
    @Query('language') String? language,
  });

  ///Discover TV shows
  ///@param page
  ///@param language
  ///@param genre
  ///@param network
  ///@param keywords
  ///@param excludeKeywords Comma-separated list of keyword IDs to exclude from results
  ///@param sortBy
  ///@param firstAirDateGte
  ///@param firstAirDateLte
  ///@param withRuntimeGte
  ///@param withRuntimeLte
  ///@param voteAverageGte
  ///@param voteAverageLte
  ///@param voteCountGte
  ///@param voteCountLte
  ///@param watchRegion
  ///@param watchProviders
  ///@param status
  ///@param certification Exact certification to filter by (used when certificationMode is 'exact')
  ///@param certificationGte Minimum certification to filter by (used when certificationMode is 'range')
  ///@param certificationLte Maximum certification to filter by (used when certificationMode is 'range')
  ///@param certificationCountry Country code for the certification system (e.g., US, GB, CA)
  ///@param certificationMode Determines whether to use exact certification matching or a certification range (internal use only, not sent to TMDB API)
  Future<chopper.Response<DiscoverTvGet$Response>> discoverTvGet({
    num? page,
    String? language,
    String? genre,
    num? network,
    String? keywords,
    String? excludeKeywords,
    String? sortBy,
    String? firstAirDateGte,
    String? firstAirDateLte,
    num? withRuntimeGte,
    num? withRuntimeLte,
    num? voteAverageGte,
    num? voteAverageLte,
    num? voteCountGte,
    num? voteCountLte,
    String? watchRegion,
    String? watchProviders,
    String? status,
    String? certification,
    String? certificationGte,
    String? certificationLte,
    String? certificationCountry,
    enums.DiscoverTvGetCertificationMode? certificationMode,
  }) {
    generatedMapping.putIfAbsent(
      DiscoverTvGet$Response,
      () => DiscoverTvGet$Response.fromJsonFactory,
    );

    return _discoverTvGet(
      page: page,
      language: language,
      genre: genre,
      network: network,
      keywords: keywords,
      excludeKeywords: excludeKeywords,
      sortBy: sortBy,
      firstAirDateGte: firstAirDateGte,
      firstAirDateLte: firstAirDateLte,
      withRuntimeGte: withRuntimeGte,
      withRuntimeLte: withRuntimeLte,
      voteAverageGte: voteAverageGte,
      voteAverageLte: voteAverageLte,
      voteCountGte: voteCountGte,
      voteCountLte: voteCountLte,
      watchRegion: watchRegion,
      watchProviders: watchProviders,
      status: status,
      certification: certification,
      certificationGte: certificationGte,
      certificationLte: certificationLte,
      certificationCountry: certificationCountry,
      certificationMode: certificationMode?.value?.toString(),
    );
  }

  ///Discover TV shows
  ///@param page
  ///@param language
  ///@param genre
  ///@param network
  ///@param keywords
  ///@param excludeKeywords Comma-separated list of keyword IDs to exclude from results
  ///@param sortBy
  ///@param firstAirDateGte
  ///@param firstAirDateLte
  ///@param withRuntimeGte
  ///@param withRuntimeLte
  ///@param voteAverageGte
  ///@param voteAverageLte
  ///@param voteCountGte
  ///@param voteCountLte
  ///@param watchRegion
  ///@param watchProviders
  ///@param status
  ///@param certification Exact certification to filter by (used when certificationMode is 'exact')
  ///@param certificationGte Minimum certification to filter by (used when certificationMode is 'range')
  ///@param certificationLte Maximum certification to filter by (used when certificationMode is 'range')
  ///@param certificationCountry Country code for the certification system (e.g., US, GB, CA)
  ///@param certificationMode Determines whether to use exact certification matching or a certification range (internal use only, not sent to TMDB API)
  @GET(path: '/discover/tv')
  Future<chopper.Response<DiscoverTvGet$Response>> _discoverTvGet({
    @Query('page') num? page,
    @Query('language') String? language,
    @Query('genre') String? genre,
    @Query('network') num? network,
    @Query('keywords') String? keywords,
    @Query('excludeKeywords') String? excludeKeywords,
    @Query('sortBy') String? sortBy,
    @Query('firstAirDateGte') String? firstAirDateGte,
    @Query('firstAirDateLte') String? firstAirDateLte,
    @Query('withRuntimeGte') num? withRuntimeGte,
    @Query('withRuntimeLte') num? withRuntimeLte,
    @Query('voteAverageGte') num? voteAverageGte,
    @Query('voteAverageLte') num? voteAverageLte,
    @Query('voteCountGte') num? voteCountGte,
    @Query('voteCountLte') num? voteCountLte,
    @Query('watchRegion') String? watchRegion,
    @Query('watchProviders') String? watchProviders,
    @Query('status') String? status,
    @Query('certification') String? certification,
    @Query('certificationGte') String? certificationGte,
    @Query('certificationLte') String? certificationLte,
    @Query('certificationCountry') String? certificationCountry,
    @Query('certificationMode') String? certificationMode,
  });

  ///Discover TV shows by original language
  ///@param language
  ///@param page
  ///@param language
  Future<chopper.Response<DiscoverTvLanguageLanguageGet$Response>>
  discoverTvLanguageLanguageGet({
    required String? language,
    num? page,
    String? language$,
  }) {
    generatedMapping.putIfAbsent(
      DiscoverTvLanguageLanguageGet$Response,
      () => DiscoverTvLanguageLanguageGet$Response.fromJsonFactory,
    );

    return _discoverTvLanguageLanguageGet(
      language: language,
      page: page,
      language$: language$,
    );
  }

  ///Discover TV shows by original language
  ///@param language
  ///@param page
  ///@param language
  @GET(path: '/discover/tv/language/{language}')
  Future<chopper.Response<DiscoverTvLanguageLanguageGet$Response>>
  _discoverTvLanguageLanguageGet({
    @Path('language') required String? language,
    @Query('page') num? page,
    @Query('language') String? language$,
  });

  ///Discover TV shows by genre
  ///@param genreId
  ///@param page
  ///@param language
  Future<chopper.Response<DiscoverTvGenreGenreIdGet$Response>>
  discoverTvGenreGenreIdGet({
    required String? genreId,
    num? page,
    String? language,
  }) {
    generatedMapping.putIfAbsent(
      DiscoverTvGenreGenreIdGet$Response,
      () => DiscoverTvGenreGenreIdGet$Response.fromJsonFactory,
    );

    return _discoverTvGenreGenreIdGet(
      genreId: genreId,
      page: page,
      language: language,
    );
  }

  ///Discover TV shows by genre
  ///@param genreId
  ///@param page
  ///@param language
  @GET(path: '/discover/tv/genre/{genreId}')
  Future<chopper.Response<DiscoverTvGenreGenreIdGet$Response>>
  _discoverTvGenreGenreIdGet({
    @Path('genreId') required String? genreId,
    @Query('page') num? page,
    @Query('language') String? language,
  });

  ///Discover TV shows by network
  ///@param networkId
  ///@param page
  ///@param language
  Future<chopper.Response<DiscoverTvNetworkNetworkIdGet$Response>>
  discoverTvNetworkNetworkIdGet({
    required String? networkId,
    num? page,
    String? language,
  }) {
    generatedMapping.putIfAbsent(
      DiscoverTvNetworkNetworkIdGet$Response,
      () => DiscoverTvNetworkNetworkIdGet$Response.fromJsonFactory,
    );

    return _discoverTvNetworkNetworkIdGet(
      networkId: networkId,
      page: page,
      language: language,
    );
  }

  ///Discover TV shows by network
  ///@param networkId
  ///@param page
  ///@param language
  @GET(path: '/discover/tv/network/{networkId}')
  Future<chopper.Response<DiscoverTvNetworkNetworkIdGet$Response>>
  _discoverTvNetworkNetworkIdGet({
    @Path('networkId') required String? networkId,
    @Query('page') num? page,
    @Query('language') String? language,
  });

  ///Discover Upcoming TV shows
  ///@param page
  ///@param language
  Future<chopper.Response<DiscoverTvUpcomingGet$Response>>
  discoverTvUpcomingGet({num? page, String? language}) {
    generatedMapping.putIfAbsent(
      DiscoverTvUpcomingGet$Response,
      () => DiscoverTvUpcomingGet$Response.fromJsonFactory,
    );

    return _discoverTvUpcomingGet(page: page, language: language);
  }

  ///Discover Upcoming TV shows
  ///@param page
  ///@param language
  @GET(path: '/discover/tv/upcoming')
  Future<chopper.Response<DiscoverTvUpcomingGet$Response>>
  _discoverTvUpcomingGet({
    @Query('page') num? page,
    @Query('language') String? language,
  });

  ///Trending movies and TV
  ///@param page
  ///@param language
  Future<chopper.Response<DiscoverTrendingGet$Response>> discoverTrendingGet({
    num? page,
    String? language,
  }) {
    generatedMapping.putIfAbsent(
      DiscoverTrendingGet$Response,
      () => DiscoverTrendingGet$Response.fromJsonFactory,
    );

    return _discoverTrendingGet(page: page, language: language);
  }

  ///Trending movies and TV
  ///@param page
  ///@param language
  @GET(path: '/discover/trending')
  Future<chopper.Response<DiscoverTrendingGet$Response>> _discoverTrendingGet({
    @Query('page') num? page,
    @Query('language') String? language,
  });

  ///Get movies from keyword
  ///@param keywordId
  ///@param page
  ///@param language
  Future<chopper.Response<DiscoverKeywordKeywordIdMoviesGet$Response>>
  discoverKeywordKeywordIdMoviesGet({
    required num? keywordId,
    num? page,
    String? language,
  }) {
    generatedMapping.putIfAbsent(
      DiscoverKeywordKeywordIdMoviesGet$Response,
      () => DiscoverKeywordKeywordIdMoviesGet$Response.fromJsonFactory,
    );

    return _discoverKeywordKeywordIdMoviesGet(
      keywordId: keywordId,
      page: page,
      language: language,
    );
  }

  ///Get movies from keyword
  ///@param keywordId
  ///@param page
  ///@param language
  @GET(path: '/discover/keyword/{keywordId}/movies')
  Future<chopper.Response<DiscoverKeywordKeywordIdMoviesGet$Response>>
  _discoverKeywordKeywordIdMoviesGet({
    @Path('keywordId') required num? keywordId,
    @Query('page') num? page,
    @Query('language') String? language,
  });

  ///Get genre slider data for movies
  ///@param language
  Future<chopper.Response<List<DiscoverGenresliderMovieGet$Response>>>
  discoverGenresliderMovieGet({String? language}) {
    return _discoverGenresliderMovieGet(language: language);
  }

  ///Get genre slider data for movies
  ///@param language
  @GET(path: '/discover/genreslider/movie')
  Future<chopper.Response<List<DiscoverGenresliderMovieGet$Response>>>
  _discoverGenresliderMovieGet({@Query('language') String? language});

  ///Get genre slider data for TV series
  ///@param language
  Future<chopper.Response<List<DiscoverGenresliderTvGet$Response>>>
  discoverGenresliderTvGet({String? language}) {
    return _discoverGenresliderTvGet(language: language);
  }

  ///Get genre slider data for TV series
  ///@param language
  @GET(path: '/discover/genreslider/tv')
  Future<chopper.Response<List<DiscoverGenresliderTvGet$Response>>>
  _discoverGenresliderTvGet({@Query('language') String? language});

  ///Get the Plex watchlist.
  ///@param page
  Future<chopper.Response<DiscoverWatchlistGet$Response>> discoverWatchlistGet({
    num? page,
  }) {
    generatedMapping.putIfAbsent(
      DiscoverWatchlistGet$Response,
      () => DiscoverWatchlistGet$Response.fromJsonFactory,
    );

    return _discoverWatchlistGet(page: page);
  }

  ///Get the Plex watchlist.
  ///@param page
  @GET(path: '/discover/watchlist')
  Future<chopper.Response<DiscoverWatchlistGet$Response>>
  _discoverWatchlistGet({@Query('page') num? page});

  ///Get all requests
  ///@param take
  ///@param skip
  ///@param filter
  ///@param sort
  ///@param sortDirection
  ///@param requestedBy
  ///@param mediaType
  Future<chopper.Response<RequestGet$Response>> request$Get({
    num? take,
    num? skip,
    enums.RequestGetFilter? filter,
    enums.RequestGetSort? sort,
    enums.RequestGetSortDirection? sortDirection,
    num? requestedBy,
    enums.RequestGetMediaType? mediaType,
  }) {
    generatedMapping.putIfAbsent(
      RequestGet$Response,
      () => RequestGet$Response.fromJsonFactory,
    );

    return _request$Get(
      take: take,
      skip: skip,
      filter: filter?.value?.toString(),
      sort: sort?.value?.toString(),
      sortDirection: sortDirection?.value?.toString(),
      requestedBy: requestedBy,
      mediaType: mediaType?.value?.toString(),
    );
  }

  ///Get all requests
  ///@param take
  ///@param skip
  ///@param filter
  ///@param sort
  ///@param sortDirection
  ///@param requestedBy
  ///@param mediaType
  @GET(path: '/request')
  Future<chopper.Response<RequestGet$Response>> _request$Get({
    @Query('take') num? take,
    @Query('skip') num? skip,
    @Query('filter') String? filter,
    @Query('sort') String? sort,
    @Query('sortDirection') String? sortDirection,
    @Query('requestedBy') num? requestedBy,
    @Query('mediaType') String? mediaType,
  });

  ///Create new request
  Future<chopper.Response<MediaRequest>> request$Post({
    required RequestPost$RequestBody? body,
  }) {
    generatedMapping.putIfAbsent(
      MediaRequest,
      () => MediaRequest.fromJsonFactory,
    );

    return _request$Post(body: body);
  }

  ///Create new request
  @POST(path: '/request', optionalBody: true)
  Future<chopper.Response<MediaRequest>> _request$Post({
    @Body() required RequestPost$RequestBody? body,
  });

  ///Gets request counts
  Future<chopper.Response<RequestCountGet$Response>> requestCountGet() {
    generatedMapping.putIfAbsent(
      RequestCountGet$Response,
      () => RequestCountGet$Response.fromJsonFactory,
    );

    return _requestCountGet();
  }

  ///Gets request counts
  @GET(path: '/request/count')
  Future<chopper.Response<RequestCountGet$Response>> _requestCountGet();

  ///Get MediaRequest
  ///@param requestId Request ID
  Future<chopper.Response<MediaRequest>> requestRequestIdGet({
    required String? requestId,
  }) {
    generatedMapping.putIfAbsent(
      MediaRequest,
      () => MediaRequest.fromJsonFactory,
    );

    return _requestRequestIdGet(requestId: requestId);
  }

  ///Get MediaRequest
  ///@param requestId Request ID
  @GET(path: '/request/{requestId}')
  Future<chopper.Response<MediaRequest>> _requestRequestIdGet({
    @Path('requestId') required String? requestId,
  });

  ///Update MediaRequest
  ///@param requestId Request ID
  Future<chopper.Response<MediaRequest>> requestRequestIdPut({
    required String? requestId,
    required RequestRequestIdPut$RequestBody? body,
  }) {
    generatedMapping.putIfAbsent(
      MediaRequest,
      () => MediaRequest.fromJsonFactory,
    );

    return _requestRequestIdPut(requestId: requestId, body: body);
  }

  ///Update MediaRequest
  ///@param requestId Request ID
  @PUT(path: '/request/{requestId}', optionalBody: true)
  Future<chopper.Response<MediaRequest>> _requestRequestIdPut({
    @Path('requestId') required String? requestId,
    @Body() required RequestRequestIdPut$RequestBody? body,
  });

  ///Delete request
  ///@param requestId Request ID
  Future<chopper.Response> requestRequestIdDelete({
    required String? requestId,
  }) {
    return _requestRequestIdDelete(requestId: requestId);
  }

  ///Delete request
  ///@param requestId Request ID
  @DELETE(path: '/request/{requestId}')
  Future<chopper.Response> _requestRequestIdDelete({
    @Path('requestId') required String? requestId,
  });

  ///Retry failed request
  ///@param requestId Request ID
  Future<chopper.Response<MediaRequest>> requestRequestIdRetryPost({
    required String? requestId,
  }) {
    generatedMapping.putIfAbsent(
      MediaRequest,
      () => MediaRequest.fromJsonFactory,
    );

    return _requestRequestIdRetryPost(requestId: requestId);
  }

  ///Retry failed request
  ///@param requestId Request ID
  @POST(path: '/request/{requestId}/retry', optionalBody: true)
  Future<chopper.Response<MediaRequest>> _requestRequestIdRetryPost({
    @Path('requestId') required String? requestId,
  });

  ///Update a request's status
  ///@param requestId Request ID
  ///@param status New status
  Future<chopper.Response<MediaRequest>> requestRequestIdStatusPost({
    required String? requestId,
    required enums.RequestRequestIdStatusPostStatus? status,
  }) {
    generatedMapping.putIfAbsent(
      MediaRequest,
      () => MediaRequest.fromJsonFactory,
    );

    return _requestRequestIdStatusPost(
      requestId: requestId,
      status: status?.value?.toString(),
    );
  }

  ///Update a request's status
  ///@param requestId Request ID
  ///@param status New status
  @POST(path: '/request/{requestId}/{status}', optionalBody: true)
  Future<chopper.Response<MediaRequest>> _requestRequestIdStatusPost({
    @Path('requestId') required String? requestId,
    @Path('status') required String? status,
  });

  ///Get movie details
  ///@param movieId
  ///@param language
  Future<chopper.Response<MovieDetails>> movieMovieIdGet({
    required num? movieId,
    String? language,
  }) {
    generatedMapping.putIfAbsent(
      MovieDetails,
      () => MovieDetails.fromJsonFactory,
    );

    return _movieMovieIdGet(movieId: movieId, language: language);
  }

  ///Get movie details
  ///@param movieId
  ///@param language
  @GET(path: '/movie/{movieId}')
  Future<chopper.Response<MovieDetails>> _movieMovieIdGet({
    @Path('movieId') required num? movieId,
    @Query('language') String? language,
  });

  ///Get recommended movies
  ///@param movieId
  ///@param page
  ///@param language
  Future<chopper.Response<MovieMovieIdRecommendationsGet$Response>>
  movieMovieIdRecommendationsGet({
    required num? movieId,
    num? page,
    String? language,
  }) {
    generatedMapping.putIfAbsent(
      MovieMovieIdRecommendationsGet$Response,
      () => MovieMovieIdRecommendationsGet$Response.fromJsonFactory,
    );

    return _movieMovieIdRecommendationsGet(
      movieId: movieId,
      page: page,
      language: language,
    );
  }

  ///Get recommended movies
  ///@param movieId
  ///@param page
  ///@param language
  @GET(path: '/movie/{movieId}/recommendations')
  Future<chopper.Response<MovieMovieIdRecommendationsGet$Response>>
  _movieMovieIdRecommendationsGet({
    @Path('movieId') required num? movieId,
    @Query('page') num? page,
    @Query('language') String? language,
  });

  ///Get similar movies
  ///@param movieId
  ///@param page
  ///@param language
  Future<chopper.Response<MovieMovieIdSimilarGet$Response>>
  movieMovieIdSimilarGet({required num? movieId, num? page, String? language}) {
    generatedMapping.putIfAbsent(
      MovieMovieIdSimilarGet$Response,
      () => MovieMovieIdSimilarGet$Response.fromJsonFactory,
    );

    return _movieMovieIdSimilarGet(
      movieId: movieId,
      page: page,
      language: language,
    );
  }

  ///Get similar movies
  ///@param movieId
  ///@param page
  ///@param language
  @GET(path: '/movie/{movieId}/similar')
  Future<chopper.Response<MovieMovieIdSimilarGet$Response>>
  _movieMovieIdSimilarGet({
    @Path('movieId') required num? movieId,
    @Query('page') num? page,
    @Query('language') String? language,
  });

  ///Get movie ratings
  ///@param movieId
  Future<chopper.Response<MovieMovieIdRatingsGet$Response>>
  movieMovieIdRatingsGet({required num? movieId}) {
    generatedMapping.putIfAbsent(
      MovieMovieIdRatingsGet$Response,
      () => MovieMovieIdRatingsGet$Response.fromJsonFactory,
    );

    return _movieMovieIdRatingsGet(movieId: movieId);
  }

  ///Get movie ratings
  ///@param movieId
  @GET(path: '/movie/{movieId}/ratings')
  Future<chopper.Response<MovieMovieIdRatingsGet$Response>>
  _movieMovieIdRatingsGet({@Path('movieId') required num? movieId});

  ///Get RT and IMDB movie ratings combined
  ///@param movieId
  Future<chopper.Response<MovieMovieIdRatingscombinedGet$Response>>
  movieMovieIdRatingscombinedGet({required num? movieId}) {
    generatedMapping.putIfAbsent(
      MovieMovieIdRatingscombinedGet$Response,
      () => MovieMovieIdRatingscombinedGet$Response.fromJsonFactory,
    );

    return _movieMovieIdRatingscombinedGet(movieId: movieId);
  }

  ///Get RT and IMDB movie ratings combined
  ///@param movieId
  @GET(path: '/movie/{movieId}/ratingscombined')
  Future<chopper.Response<MovieMovieIdRatingscombinedGet$Response>>
  _movieMovieIdRatingscombinedGet({@Path('movieId') required num? movieId});

  ///Get TV details
  ///@param tvId
  ///@param language
  Future<chopper.Response<TvDetails>> tvTvIdGet({
    required num? tvId,
    String? language,
  }) {
    generatedMapping.putIfAbsent(TvDetails, () => TvDetails.fromJsonFactory);

    return _tvTvIdGet(tvId: tvId, language: language);
  }

  ///Get TV details
  ///@param tvId
  ///@param language
  @GET(path: '/tv/{tvId}')
  Future<chopper.Response<TvDetails>> _tvTvIdGet({
    @Path('tvId') required num? tvId,
    @Query('language') String? language,
  });

  ///Get season details and episode list
  ///@param tvId
  ///@param seasonNumber
  ///@param language
  Future<chopper.Response<Season>> tvTvIdSeasonSeasonNumberGet({
    required num? tvId,
    required num? seasonNumber,
    String? language,
  }) {
    generatedMapping.putIfAbsent(Season, () => Season.fromJsonFactory);

    return _tvTvIdSeasonSeasonNumberGet(
      tvId: tvId,
      seasonNumber: seasonNumber,
      language: language,
    );
  }

  ///Get season details and episode list
  ///@param tvId
  ///@param seasonNumber
  ///@param language
  @GET(path: '/tv/{tvId}/season/{seasonNumber}')
  Future<chopper.Response<Season>> _tvTvIdSeasonSeasonNumberGet({
    @Path('tvId') required num? tvId,
    @Path('seasonNumber') required num? seasonNumber,
    @Query('language') String? language,
  });

  ///Get recommended TV series
  ///@param tvId
  ///@param page
  ///@param language
  Future<chopper.Response<TvTvIdRecommendationsGet$Response>>
  tvTvIdRecommendationsGet({required num? tvId, num? page, String? language}) {
    generatedMapping.putIfAbsent(
      TvTvIdRecommendationsGet$Response,
      () => TvTvIdRecommendationsGet$Response.fromJsonFactory,
    );

    return _tvTvIdRecommendationsGet(
      tvId: tvId,
      page: page,
      language: language,
    );
  }

  ///Get recommended TV series
  ///@param tvId
  ///@param page
  ///@param language
  @GET(path: '/tv/{tvId}/recommendations')
  Future<chopper.Response<TvTvIdRecommendationsGet$Response>>
  _tvTvIdRecommendationsGet({
    @Path('tvId') required num? tvId,
    @Query('page') num? page,
    @Query('language') String? language,
  });

  ///Get similar TV series
  ///@param tvId
  ///@param page
  ///@param language
  Future<chopper.Response<TvTvIdSimilarGet$Response>> tvTvIdSimilarGet({
    required num? tvId,
    num? page,
    String? language,
  }) {
    generatedMapping.putIfAbsent(
      TvTvIdSimilarGet$Response,
      () => TvTvIdSimilarGet$Response.fromJsonFactory,
    );

    return _tvTvIdSimilarGet(tvId: tvId, page: page, language: language);
  }

  ///Get similar TV series
  ///@param tvId
  ///@param page
  ///@param language
  @GET(path: '/tv/{tvId}/similar')
  Future<chopper.Response<TvTvIdSimilarGet$Response>> _tvTvIdSimilarGet({
    @Path('tvId') required num? tvId,
    @Query('page') num? page,
    @Query('language') String? language,
  });

  ///Get TV ratings
  ///@param tvId
  Future<chopper.Response<TvTvIdRatingsGet$Response>> tvTvIdRatingsGet({
    required num? tvId,
  }) {
    generatedMapping.putIfAbsent(
      TvTvIdRatingsGet$Response,
      () => TvTvIdRatingsGet$Response.fromJsonFactory,
    );

    return _tvTvIdRatingsGet(tvId: tvId);
  }

  ///Get TV ratings
  ///@param tvId
  @GET(path: '/tv/{tvId}/ratings')
  Future<chopper.Response<TvTvIdRatingsGet$Response>> _tvTvIdRatingsGet({
    @Path('tvId') required num? tvId,
  });

  ///Get person details
  ///@param personId
  ///@param language
  Future<chopper.Response<PersonDetails>> personPersonIdGet({
    required num? personId,
    String? language,
  }) {
    generatedMapping.putIfAbsent(
      PersonDetails,
      () => PersonDetails.fromJsonFactory,
    );

    return _personPersonIdGet(personId: personId, language: language);
  }

  ///Get person details
  ///@param personId
  ///@param language
  @GET(path: '/person/{personId}')
  Future<chopper.Response<PersonDetails>> _personPersonIdGet({
    @Path('personId') required num? personId,
    @Query('language') String? language,
  });

  ///Get combined credits
  ///@param personId
  ///@param language
  Future<chopper.Response<PersonPersonIdCombinedCreditsGet$Response>>
  personPersonIdCombinedCreditsGet({required num? personId, String? language}) {
    generatedMapping.putIfAbsent(
      PersonPersonIdCombinedCreditsGet$Response,
      () => PersonPersonIdCombinedCreditsGet$Response.fromJsonFactory,
    );

    return _personPersonIdCombinedCreditsGet(
      personId: personId,
      language: language,
    );
  }

  ///Get combined credits
  ///@param personId
  ///@param language
  @GET(path: '/person/{personId}/combined_credits')
  Future<chopper.Response<PersonPersonIdCombinedCreditsGet$Response>>
  _personPersonIdCombinedCreditsGet({
    @Path('personId') required num? personId,
    @Query('language') String? language,
  });

  ///Get media
  ///@param take
  ///@param skip
  ///@param filter
  ///@param sort
  Future<chopper.Response<MediaGet$Response>> mediaGet({
    num? take,
    num? skip,
    enums.MediaGetFilter? filter,
    enums.MediaGetSort? sort,
  }) {
    generatedMapping.putIfAbsent(
      MediaGet$Response,
      () => MediaGet$Response.fromJsonFactory,
    );

    return _mediaGet(
      take: take,
      skip: skip,
      filter: filter?.value?.toString(),
      sort: sort?.value?.toString(),
    );
  }

  ///Get media
  ///@param take
  ///@param skip
  ///@param filter
  ///@param sort
  @GET(path: '/media')
  Future<chopper.Response<MediaGet$Response>> _mediaGet({
    @Query('take') num? take,
    @Query('skip') num? skip,
    @Query('filter') String? filter,
    @Query('sort') String? sort,
  });

  ///Delete media item
  ///@param mediaId Media ID
  Future<chopper.Response> mediaMediaIdDelete({required String? mediaId}) {
    return _mediaMediaIdDelete(mediaId: mediaId);
  }

  ///Delete media item
  ///@param mediaId Media ID
  @DELETE(path: '/media/{mediaId}')
  Future<chopper.Response> _mediaMediaIdDelete({
    @Path('mediaId') required String? mediaId,
  });

  ///Delete media file
  ///@param mediaId Media ID
  ///@param is4k Whether to remove from 4K service instance (true) or regular service instance (false)
  Future<chopper.Response> mediaMediaIdFileDelete({
    required String? mediaId,
    bool? is4k,
  }) {
    return _mediaMediaIdFileDelete(mediaId: mediaId, is4k: is4k);
  }

  ///Delete media file
  ///@param mediaId Media ID
  ///@param is4k Whether to remove from 4K service instance (true) or regular service instance (false)
  @DELETE(path: '/media/{mediaId}/file')
  Future<chopper.Response> _mediaMediaIdFileDelete({
    @Path('mediaId') required String? mediaId,
    @Query('is4k') bool? is4k,
  });

  ///Update media status
  ///@param mediaId Media ID
  ///@param status New status
  Future<chopper.Response<MediaInfo>> mediaMediaIdStatusPost({
    required String? mediaId,
    required enums.MediaMediaIdStatusPostStatus? status,
    required MediaMediaIdStatusPost$RequestBody? body,
  }) {
    generatedMapping.putIfAbsent(MediaInfo, () => MediaInfo.fromJsonFactory);

    return _mediaMediaIdStatusPost(
      mediaId: mediaId,
      status: status?.value?.toString(),
      body: body,
    );
  }

  ///Update media status
  ///@param mediaId Media ID
  ///@param status New status
  @POST(path: '/media/{mediaId}/{status}', optionalBody: true)
  Future<chopper.Response<MediaInfo>> _mediaMediaIdStatusPost({
    @Path('mediaId') required String? mediaId,
    @Path('status') required String? status,
    @Body() required MediaMediaIdStatusPost$RequestBody? body,
  });

  ///Get watch data
  ///@param mediaId Media ID
  Future<chopper.Response<MediaMediaIdWatchDataGet$Response>>
  mediaMediaIdWatchDataGet({required String? mediaId}) {
    generatedMapping.putIfAbsent(
      MediaMediaIdWatchDataGet$Response,
      () => MediaMediaIdWatchDataGet$Response.fromJsonFactory,
    );

    return _mediaMediaIdWatchDataGet(mediaId: mediaId);
  }

  ///Get watch data
  ///@param mediaId Media ID
  @GET(path: '/media/{mediaId}/watch_data')
  Future<chopper.Response<MediaMediaIdWatchDataGet$Response>>
  _mediaMediaIdWatchDataGet({@Path('mediaId') required String? mediaId});

  ///Get collection details
  ///@param collectionId
  ///@param language
  Future<chopper.Response<Collection>> collectionCollectionIdGet({
    required num? collectionId,
    String? language,
  }) {
    generatedMapping.putIfAbsent(Collection, () => Collection.fromJsonFactory);

    return _collectionCollectionIdGet(
      collectionId: collectionId,
      language: language,
    );
  }

  ///Get collection details
  ///@param collectionId
  ///@param language
  @GET(path: '/collection/{collectionId}')
  Future<chopper.Response<Collection>> _collectionCollectionIdGet({
    @Path('collectionId') required num? collectionId,
    @Query('language') String? language,
  });

  ///Get non-sensitive Radarr server list
  Future<chopper.Response<List<RadarrSettings>>> serviceRadarrGet() {
    generatedMapping.putIfAbsent(
      RadarrSettings,
      () => RadarrSettings.fromJsonFactory,
    );

    return _serviceRadarrGet();
  }

  ///Get non-sensitive Radarr server list
  @GET(path: '/service/radarr')
  Future<chopper.Response<List<RadarrSettings>>> _serviceRadarrGet();

  ///Get Radarr server quality profiles and root folders
  ///@param radarrId
  Future<chopper.Response<ServiceRadarrRadarrIdGet$Response>>
  serviceRadarrRadarrIdGet({required num? radarrId}) {
    generatedMapping.putIfAbsent(
      ServiceRadarrRadarrIdGet$Response,
      () => ServiceRadarrRadarrIdGet$Response.fromJsonFactory,
    );

    return _serviceRadarrRadarrIdGet(radarrId: radarrId);
  }

  ///Get Radarr server quality profiles and root folders
  ///@param radarrId
  @GET(path: '/service/radarr/{radarrId}')
  Future<chopper.Response<ServiceRadarrRadarrIdGet$Response>>
  _serviceRadarrRadarrIdGet({@Path('radarrId') required num? radarrId});

  ///Get non-sensitive Sonarr server list
  Future<chopper.Response<List<SonarrSettings>>> serviceSonarrGet() {
    generatedMapping.putIfAbsent(
      SonarrSettings,
      () => SonarrSettings.fromJsonFactory,
    );

    return _serviceSonarrGet();
  }

  ///Get non-sensitive Sonarr server list
  @GET(path: '/service/sonarr')
  Future<chopper.Response<List<SonarrSettings>>> _serviceSonarrGet();

  ///Get Sonarr server quality profiles and root folders
  ///@param sonarrId
  Future<chopper.Response<ServiceSonarrSonarrIdGet$Response>>
  serviceSonarrSonarrIdGet({required num? sonarrId}) {
    generatedMapping.putIfAbsent(
      ServiceSonarrSonarrIdGet$Response,
      () => ServiceSonarrSonarrIdGet$Response.fromJsonFactory,
    );

    return _serviceSonarrSonarrIdGet(sonarrId: sonarrId);
  }

  ///Get Sonarr server quality profiles and root folders
  ///@param sonarrId
  @GET(path: '/service/sonarr/{sonarrId}')
  Future<chopper.Response<ServiceSonarrSonarrIdGet$Response>>
  _serviceSonarrSonarrIdGet({@Path('sonarrId') required num? sonarrId});

  ///Get series from Sonarr
  ///@param tmdbId
  Future<chopper.Response<List<SonarrSeries>>> serviceSonarrLookupTmdbIdGet({
    required num? tmdbId,
  }) {
    generatedMapping.putIfAbsent(
      SonarrSeries,
      () => SonarrSeries.fromJsonFactory,
    );

    return _serviceSonarrLookupTmdbIdGet(tmdbId: tmdbId);
  }

  ///Get series from Sonarr
  ///@param tmdbId
  @GET(path: '/service/sonarr/lookup/{tmdbId}')
  Future<chopper.Response<List<SonarrSeries>>> _serviceSonarrLookupTmdbIdGet({
    @Path('tmdbId') required num? tmdbId,
  });

  ///Regions supported by TMDB
  Future<chopper.Response<List<RegionsGet$Response>>> regionsGet() {
    return _regionsGet();
  }

  ///Regions supported by TMDB
  @GET(path: '/regions')
  Future<chopper.Response<List<RegionsGet$Response>>> _regionsGet();

  ///Languages supported by TMDB
  Future<chopper.Response<List<LanguagesGet$Response>>> languagesGet() {
    return _languagesGet();
  }

  ///Languages supported by TMDB
  @GET(path: '/languages')
  Future<chopper.Response<List<LanguagesGet$Response>>> _languagesGet();

  ///Get movie studio details
  ///@param studioId
  Future<chopper.Response<ProductionCompany>> studioStudioIdGet({
    required num? studioId,
  }) {
    generatedMapping.putIfAbsent(
      ProductionCompany,
      () => ProductionCompany.fromJsonFactory,
    );

    return _studioStudioIdGet(studioId: studioId);
  }

  ///Get movie studio details
  ///@param studioId
  @GET(path: '/studio/{studioId}')
  Future<chopper.Response<ProductionCompany>> _studioStudioIdGet({
    @Path('studioId') required num? studioId,
  });

  ///Get TV network details
  ///@param networkId
  Future<chopper.Response<ProductionCompany>> networkNetworkIdGet({
    required num? networkId,
  }) {
    generatedMapping.putIfAbsent(
      ProductionCompany,
      () => ProductionCompany.fromJsonFactory,
    );

    return _networkNetworkIdGet(networkId: networkId);
  }

  ///Get TV network details
  ///@param networkId
  @GET(path: '/network/{networkId}')
  Future<chopper.Response<ProductionCompany>> _networkNetworkIdGet({
    @Path('networkId') required num? networkId,
  });

  ///Get list of official TMDB movie genres
  ///@param language
  Future<chopper.Response<List<GenresMovieGet$Response>>> genresMovieGet({
    String? language,
  }) {
    return _genresMovieGet(language: language);
  }

  ///Get list of official TMDB movie genres
  ///@param language
  @GET(path: '/genres/movie')
  Future<chopper.Response<List<GenresMovieGet$Response>>> _genresMovieGet({
    @Query('language') String? language,
  });

  ///Get list of official TMDB movie genres
  ///@param language
  Future<chopper.Response<List<GenresTvGet$Response>>> genresTvGet({
    String? language,
  }) {
    return _genresTvGet(language: language);
  }

  ///Get list of official TMDB movie genres
  ///@param language
  @GET(path: '/genres/tv')
  Future<chopper.Response<List<GenresTvGet$Response>>> _genresTvGet({
    @Query('language') String? language,
  });

  ///Get backdrops of trending items
  Future<chopper.Response<List<String>>> backdropsGet() {
    return _backdropsGet();
  }

  ///Get backdrops of trending items
  @GET(path: '/backdrops')
  Future<chopper.Response<List<String>>> _backdropsGet();

  ///Get all issues
  ///@param take
  ///@param skip
  ///@param sort
  ///@param filter
  ///@param requestedBy
  Future<chopper.Response<IssueGet$Response>> issueGet({
    num? take,
    num? skip,
    enums.IssueGetSort? sort,
    enums.IssueGetFilter? filter,
    num? requestedBy,
  }) {
    generatedMapping.putIfAbsent(
      IssueGet$Response,
      () => IssueGet$Response.fromJsonFactory,
    );

    return _issueGet(
      take: take,
      skip: skip,
      sort: sort?.value?.toString(),
      filter: filter?.value?.toString(),
      requestedBy: requestedBy,
    );
  }

  ///Get all issues
  ///@param take
  ///@param skip
  ///@param sort
  ///@param filter
  ///@param requestedBy
  @GET(path: '/issue')
  Future<chopper.Response<IssueGet$Response>> _issueGet({
    @Query('take') num? take,
    @Query('skip') num? skip,
    @Query('sort') String? sort,
    @Query('filter') String? filter,
    @Query('requestedBy') num? requestedBy,
  });

  ///Create new issue
  Future<chopper.Response<Issue>> issuePost({
    required IssuePost$RequestBody? body,
  }) {
    generatedMapping.putIfAbsent(Issue, () => Issue.fromJsonFactory);

    return _issuePost(body: body);
  }

  ///Create new issue
  @POST(path: '/issue', optionalBody: true)
  Future<chopper.Response<Issue>> _issuePost({
    @Body() required IssuePost$RequestBody? body,
  });

  ///Gets issue counts
  Future<chopper.Response<IssueCountGet$Response>> issueCountGet() {
    generatedMapping.putIfAbsent(
      IssueCountGet$Response,
      () => IssueCountGet$Response.fromJsonFactory,
    );

    return _issueCountGet();
  }

  ///Gets issue counts
  @GET(path: '/issue/count')
  Future<chopper.Response<IssueCountGet$Response>> _issueCountGet();

  ///Get issue
  ///@param issueId
  Future<chopper.Response<Issue>> issueIssueIdGet({required num? issueId}) {
    generatedMapping.putIfAbsent(Issue, () => Issue.fromJsonFactory);

    return _issueIssueIdGet(issueId: issueId);
  }

  ///Get issue
  ///@param issueId
  @GET(path: '/issue/{issueId}')
  Future<chopper.Response<Issue>> _issueIssueIdGet({
    @Path('issueId') required num? issueId,
  });

  ///Delete issue
  ///@param issueId Issue ID
  Future<chopper.Response> issueIssueIdDelete({required String? issueId}) {
    return _issueIssueIdDelete(issueId: issueId);
  }

  ///Delete issue
  ///@param issueId Issue ID
  @DELETE(path: '/issue/{issueId}')
  Future<chopper.Response> _issueIssueIdDelete({
    @Path('issueId') required String? issueId,
  });

  ///Create a comment
  ///@param issueId
  Future<chopper.Response<Issue>> issueIssueIdCommentPost({
    required num? issueId,
    required IssueIssueIdCommentPost$RequestBody? body,
  }) {
    generatedMapping.putIfAbsent(Issue, () => Issue.fromJsonFactory);

    return _issueIssueIdCommentPost(issueId: issueId, body: body);
  }

  ///Create a comment
  ///@param issueId
  @POST(path: '/issue/{issueId}/comment', optionalBody: true)
  Future<chopper.Response<Issue>> _issueIssueIdCommentPost({
    @Path('issueId') required num? issueId,
    @Body() required IssueIssueIdCommentPost$RequestBody? body,
  });

  ///Get issue comment
  ///@param commentId
  Future<chopper.Response<IssueComment>> issueCommentCommentIdGet({
    required String? commentId,
  }) {
    generatedMapping.putIfAbsent(
      IssueComment,
      () => IssueComment.fromJsonFactory,
    );

    return _issueCommentCommentIdGet(commentId: commentId);
  }

  ///Get issue comment
  ///@param commentId
  @GET(path: '/issueComment/{commentId}')
  Future<chopper.Response<IssueComment>> _issueCommentCommentIdGet({
    @Path('commentId') required String? commentId,
  });

  ///Update issue comment
  ///@param commentId
  Future<chopper.Response<IssueComment>> issueCommentCommentIdPut({
    required String? commentId,
    required IssueCommentCommentIdPut$RequestBody? body,
  }) {
    generatedMapping.putIfAbsent(
      IssueComment,
      () => IssueComment.fromJsonFactory,
    );

    return _issueCommentCommentIdPut(commentId: commentId, body: body);
  }

  ///Update issue comment
  ///@param commentId
  @PUT(path: '/issueComment/{commentId}', optionalBody: true)
  Future<chopper.Response<IssueComment>> _issueCommentCommentIdPut({
    @Path('commentId') required String? commentId,
    @Body() required IssueCommentCommentIdPut$RequestBody? body,
  });

  ///Delete issue comment
  ///@param commentId Issue Comment ID
  Future<chopper.Response> issueCommentCommentIdDelete({
    required String? commentId,
  }) {
    return _issueCommentCommentIdDelete(commentId: commentId);
  }

  ///Delete issue comment
  ///@param commentId Issue Comment ID
  @DELETE(path: '/issueComment/{commentId}')
  Future<chopper.Response> _issueCommentCommentIdDelete({
    @Path('commentId') required String? commentId,
  });

  ///Update an issue's status
  ///@param issueId Issue ID
  ///@param status New status
  Future<chopper.Response<Issue>> issueIssueIdStatusPost({
    required String? issueId,
    required enums.IssueIssueIdStatusPostStatus? status,
  }) {
    generatedMapping.putIfAbsent(Issue, () => Issue.fromJsonFactory);

    return _issueIssueIdStatusPost(
      issueId: issueId,
      status: status?.value?.toString(),
    );
  }

  ///Update an issue's status
  ///@param issueId Issue ID
  ///@param status New status
  @POST(path: '/issue/{issueId}/{status}', optionalBody: true)
  Future<chopper.Response<Issue>> _issueIssueIdStatusPost({
    @Path('issueId') required String? issueId,
    @Path('status') required String? status,
  });

  ///Get keyword
  ///@param keywordId
  Future<chopper.Response<Keyword>> keywordKeywordIdGet({
    required num? keywordId,
  }) {
    generatedMapping.putIfAbsent(Keyword, () => Keyword.fromJsonFactory);

    return _keywordKeywordIdGet(keywordId: keywordId);
  }

  ///Get keyword
  ///@param keywordId
  @GET(path: '/keyword/{keywordId}')
  Future<chopper.Response<Keyword>> _keywordKeywordIdGet({
    @Path('keywordId') required num? keywordId,
  });

  ///Get watch provider regions
  Future<chopper.Response<List<WatchProviderRegion>>>
  watchprovidersRegionsGet() {
    generatedMapping.putIfAbsent(
      WatchProviderRegion,
      () => WatchProviderRegion.fromJsonFactory,
    );

    return _watchprovidersRegionsGet();
  }

  ///Get watch provider regions
  @GET(path: '/watchproviders/regions')
  Future<chopper.Response<List<WatchProviderRegion>>>
  _watchprovidersRegionsGet();

  ///Get watch provider movies
  ///@param watchRegion
  Future<chopper.Response<List<WatchProviderDetails>>> watchprovidersMoviesGet({
    required String? watchRegion,
  }) {
    generatedMapping.putIfAbsent(
      WatchProviderDetails,
      () => WatchProviderDetails.fromJsonFactory,
    );

    return _watchprovidersMoviesGet(watchRegion: watchRegion);
  }

  ///Get watch provider movies
  ///@param watchRegion
  @GET(path: '/watchproviders/movies')
  Future<chopper.Response<List<WatchProviderDetails>>>
  _watchprovidersMoviesGet({
    @Query('watchRegion') required String? watchRegion,
  });

  ///Get watch provider series
  ///@param watchRegion
  Future<chopper.Response<List<WatchProviderDetails>>> watchprovidersTvGet({
    required String? watchRegion,
  }) {
    generatedMapping.putIfAbsent(
      WatchProviderDetails,
      () => WatchProviderDetails.fromJsonFactory,
    );

    return _watchprovidersTvGet(watchRegion: watchRegion);
  }

  ///Get watch provider series
  ///@param watchRegion
  @GET(path: '/watchproviders/tv')
  Future<chopper.Response<List<WatchProviderDetails>>> _watchprovidersTvGet({
    @Query('watchRegion') required String? watchRegion,
  });

  ///Get movie certifications
  Future<chopper.Response<CertificationResponse>> certificationsMovieGet() {
    generatedMapping.putIfAbsent(
      CertificationResponse,
      () => CertificationResponse.fromJsonFactory,
    );

    return _certificationsMovieGet();
  }

  ///Get movie certifications
  @GET(path: '/certifications/movie')
  Future<chopper.Response<CertificationResponse>> _certificationsMovieGet();

  ///Get TV certifications
  Future<chopper.Response<CertificationResponse>> certificationsTvGet() {
    generatedMapping.putIfAbsent(
      CertificationResponse,
      () => CertificationResponse.fromJsonFactory,
    );

    return _certificationsTvGet();
  }

  ///Get TV certifications
  @GET(path: '/certifications/tv')
  Future<chopper.Response<CertificationResponse>> _certificationsTvGet();

  ///Get override rules
  Future<chopper.Response<List<OverrideRule>>> overrideRuleGet() {
    generatedMapping.putIfAbsent(
      OverrideRule,
      () => OverrideRule.fromJsonFactory,
    );

    return _overrideRuleGet();
  }

  ///Get override rules
  @GET(path: '/overrideRule')
  Future<chopper.Response<List<OverrideRule>>> _overrideRuleGet();

  ///Create override rule
  Future<chopper.Response<List<OverrideRule>>> overrideRulePost() {
    generatedMapping.putIfAbsent(
      OverrideRule,
      () => OverrideRule.fromJsonFactory,
    );

    return _overrideRulePost();
  }

  ///Create override rule
  @POST(path: '/overrideRule', optionalBody: true)
  Future<chopper.Response<List<OverrideRule>>> _overrideRulePost();

  ///Update override rule
  ///@param ruleId
  Future<chopper.Response<List<OverrideRule>>> overrideRuleRuleIdPut({
    required num? ruleId,
  }) {
    generatedMapping.putIfAbsent(
      OverrideRule,
      () => OverrideRule.fromJsonFactory,
    );

    return _overrideRuleRuleIdPut(ruleId: ruleId);
  }

  ///Update override rule
  ///@param ruleId
  @PUT(path: '/overrideRule/{ruleId}', optionalBody: true)
  Future<chopper.Response<List<OverrideRule>>> _overrideRuleRuleIdPut({
    @Path('ruleId') required num? ruleId,
  });

  ///Delete override rule by ID
  ///@param ruleId
  Future<chopper.Response<OverrideRule>> overrideRuleRuleIdDelete({
    required num? ruleId,
  }) {
    generatedMapping.putIfAbsent(
      OverrideRule,
      () => OverrideRule.fromJsonFactory,
    );

    return _overrideRuleRuleIdDelete(ruleId: ruleId);
  }

  ///Delete override rule by ID
  ///@param ruleId
  @DELETE(path: '/overrideRule/{ruleId}')
  Future<chopper.Response<OverrideRule>> _overrideRuleRuleIdDelete({
    @Path('ruleId') required num? ruleId,
  });
}

@JsonSerializable(explicitToJson: true)
class Blacklist {
  const Blacklist({this.tmdbId, this.title, this.media, this.userId});

  factory Blacklist.fromJson(Map<String, dynamic> json) =>
      _$BlacklistFromJson(json);

  static const toJsonFactory = _$BlacklistToJson;
  Map<String, dynamic> toJson() => _$BlacklistToJson(this);

  @JsonKey(name: 'tmdbId', includeIfNull: false)
  final double? tmdbId;
  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;
  @JsonKey(name: 'media', includeIfNull: false)
  final MediaInfo? media;
  @JsonKey(name: 'userId', includeIfNull: false)
  final double? userId;
  static const fromJsonFactory = _$BlacklistFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Blacklist &&
            (identical(other.tmdbId, tmdbId) ||
                const DeepCollectionEquality().equals(other.tmdbId, tmdbId)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.media, media) ||
                const DeepCollectionEquality().equals(other.media, media)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(tmdbId) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(media) ^
      const DeepCollectionEquality().hash(userId) ^
      runtimeType.hashCode;
}

extension $BlacklistExtension on Blacklist {
  Blacklist copyWith({
    double? tmdbId,
    String? title,
    MediaInfo? media,
    double? userId,
  }) {
    return Blacklist(
      tmdbId: tmdbId ?? this.tmdbId,
      title: title ?? this.title,
      media: media ?? this.media,
      userId: userId ?? this.userId,
    );
  }

  Blacklist copyWithWrapped({
    Wrapped<double?>? tmdbId,
    Wrapped<String?>? title,
    Wrapped<MediaInfo?>? media,
    Wrapped<double?>? userId,
  }) {
    return Blacklist(
      tmdbId: (tmdbId != null ? tmdbId.value : this.tmdbId),
      title: (title != null ? title.value : this.title),
      media: (media != null ? media.value : this.media),
      userId: (userId != null ? userId.value : this.userId),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Watchlist {
  const Watchlist({
    this.id,
    this.tmdbId,
    this.ratingKey,
    this.type,
    this.title,
    this.media,
    this.createdAt,
    this.updatedAt,
    this.requestedBy,
  });

  factory Watchlist.fromJson(Map<String, dynamic> json) =>
      _$WatchlistFromJson(json);

  static const toJsonFactory = _$WatchlistToJson;
  Map<String, dynamic> toJson() => _$WatchlistToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final int? id;
  @JsonKey(name: 'tmdbId', includeIfNull: false)
  final double? tmdbId;
  @JsonKey(name: 'ratingKey', includeIfNull: false)
  final String? ratingKey;
  @JsonKey(name: 'type', includeIfNull: false)
  final String? type;
  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;
  @JsonKey(name: 'media', includeIfNull: false)
  final MediaInfo? media;
  @JsonKey(name: 'createdAt', includeIfNull: false)
  final String? createdAt;
  @JsonKey(name: 'updatedAt', includeIfNull: false)
  final String? updatedAt;
  @JsonKey(name: 'requestedBy', includeIfNull: false)
  final User? requestedBy;
  static const fromJsonFactory = _$WatchlistFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Watchlist &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.tmdbId, tmdbId) ||
                const DeepCollectionEquality().equals(other.tmdbId, tmdbId)) &&
            (identical(other.ratingKey, ratingKey) ||
                const DeepCollectionEquality().equals(
                  other.ratingKey,
                  ratingKey,
                )) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.media, media) ||
                const DeepCollectionEquality().equals(other.media, media)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(
                  other.createdAt,
                  createdAt,
                )) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality().equals(
                  other.updatedAt,
                  updatedAt,
                )) &&
            (identical(other.requestedBy, requestedBy) ||
                const DeepCollectionEquality().equals(
                  other.requestedBy,
                  requestedBy,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(tmdbId) ^
      const DeepCollectionEquality().hash(ratingKey) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(media) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(requestedBy) ^
      runtimeType.hashCode;
}

extension $WatchlistExtension on Watchlist {
  Watchlist copyWith({
    int? id,
    double? tmdbId,
    String? ratingKey,
    String? type,
    String? title,
    MediaInfo? media,
    String? createdAt,
    String? updatedAt,
    User? requestedBy,
  }) {
    return Watchlist(
      id: id ?? this.id,
      tmdbId: tmdbId ?? this.tmdbId,
      ratingKey: ratingKey ?? this.ratingKey,
      type: type ?? this.type,
      title: title ?? this.title,
      media: media ?? this.media,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      requestedBy: requestedBy ?? this.requestedBy,
    );
  }

  Watchlist copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<double?>? tmdbId,
    Wrapped<String?>? ratingKey,
    Wrapped<String?>? type,
    Wrapped<String?>? title,
    Wrapped<MediaInfo?>? media,
    Wrapped<String?>? createdAt,
    Wrapped<String?>? updatedAt,
    Wrapped<User?>? requestedBy,
  }) {
    return Watchlist(
      id: (id != null ? id.value : this.id),
      tmdbId: (tmdbId != null ? tmdbId.value : this.tmdbId),
      ratingKey: (ratingKey != null ? ratingKey.value : this.ratingKey),
      type: (type != null ? type.value : this.type),
      title: (title != null ? title.value : this.title),
      media: (media != null ? media.value : this.media),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      requestedBy: (requestedBy != null ? requestedBy.value : this.requestedBy),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class User {
  const User({
    this.id,
    this.email,
    this.username,
    this.plexUsername,
    this.plexToken,
    this.jellyfinAuthToken,
    this.userType,
    this.permissions,
    this.avatar,
    this.createdAt,
    this.updatedAt,
    this.requestCount,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  static const toJsonFactory = _$UserToJson;
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final int? id;
  @JsonKey(name: 'email', includeIfNull: false)
  final String? email;
  @JsonKey(name: 'username', includeIfNull: false)
  final String? username;
  @JsonKey(name: 'plexUsername', includeIfNull: false)
  final String? plexUsername;
  @JsonKey(name: 'plexToken', includeIfNull: false)
  final String? plexToken;
  @JsonKey(name: 'jellyfinAuthToken', includeIfNull: false)
  final String? jellyfinAuthToken;
  @JsonKey(name: 'userType', includeIfNull: false)
  final int? userType;
  @JsonKey(name: 'permissions', includeIfNull: false)
  final double? permissions;
  @JsonKey(name: 'avatar', includeIfNull: false)
  final String? avatar;
  @JsonKey(name: 'createdAt', includeIfNull: false)
  final String? createdAt;
  @JsonKey(name: 'updatedAt', includeIfNull: false)
  final String? updatedAt;
  @JsonKey(name: 'requestCount', includeIfNull: false)
  final double? requestCount;
  static const fromJsonFactory = _$UserFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is User &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.username, username) ||
                const DeepCollectionEquality().equals(
                  other.username,
                  username,
                )) &&
            (identical(other.plexUsername, plexUsername) ||
                const DeepCollectionEquality().equals(
                  other.plexUsername,
                  plexUsername,
                )) &&
            (identical(other.plexToken, plexToken) ||
                const DeepCollectionEquality().equals(
                  other.plexToken,
                  plexToken,
                )) &&
            (identical(other.jellyfinAuthToken, jellyfinAuthToken) ||
                const DeepCollectionEquality().equals(
                  other.jellyfinAuthToken,
                  jellyfinAuthToken,
                )) &&
            (identical(other.userType, userType) ||
                const DeepCollectionEquality().equals(
                  other.userType,
                  userType,
                )) &&
            (identical(other.permissions, permissions) ||
                const DeepCollectionEquality().equals(
                  other.permissions,
                  permissions,
                )) &&
            (identical(other.avatar, avatar) ||
                const DeepCollectionEquality().equals(other.avatar, avatar)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(
                  other.createdAt,
                  createdAt,
                )) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality().equals(
                  other.updatedAt,
                  updatedAt,
                )) &&
            (identical(other.requestCount, requestCount) ||
                const DeepCollectionEquality().equals(
                  other.requestCount,
                  requestCount,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(plexUsername) ^
      const DeepCollectionEquality().hash(plexToken) ^
      const DeepCollectionEquality().hash(jellyfinAuthToken) ^
      const DeepCollectionEquality().hash(userType) ^
      const DeepCollectionEquality().hash(permissions) ^
      const DeepCollectionEquality().hash(avatar) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(requestCount) ^
      runtimeType.hashCode;
}

extension $UserExtension on User {
  User copyWith({
    int? id,
    String? email,
    String? username,
    String? plexUsername,
    String? plexToken,
    String? jellyfinAuthToken,
    int? userType,
    double? permissions,
    String? avatar,
    String? createdAt,
    String? updatedAt,
    double? requestCount,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      plexUsername: plexUsername ?? this.plexUsername,
      plexToken: plexToken ?? this.plexToken,
      jellyfinAuthToken: jellyfinAuthToken ?? this.jellyfinAuthToken,
      userType: userType ?? this.userType,
      permissions: permissions ?? this.permissions,
      avatar: avatar ?? this.avatar,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      requestCount: requestCount ?? this.requestCount,
    );
  }

  User copyWithWrapped({
    Wrapped<int?>? id,
    Wrapped<String?>? email,
    Wrapped<String?>? username,
    Wrapped<String?>? plexUsername,
    Wrapped<String?>? plexToken,
    Wrapped<String?>? jellyfinAuthToken,
    Wrapped<int?>? userType,
    Wrapped<double?>? permissions,
    Wrapped<String?>? avatar,
    Wrapped<String?>? createdAt,
    Wrapped<String?>? updatedAt,
    Wrapped<double?>? requestCount,
  }) {
    return User(
      id: (id != null ? id.value : this.id),
      email: (email != null ? email.value : this.email),
      username: (username != null ? username.value : this.username),
      plexUsername: (plexUsername != null
          ? plexUsername.value
          : this.plexUsername),
      plexToken: (plexToken != null ? plexToken.value : this.plexToken),
      jellyfinAuthToken: (jellyfinAuthToken != null
          ? jellyfinAuthToken.value
          : this.jellyfinAuthToken),
      userType: (userType != null ? userType.value : this.userType),
      permissions: (permissions != null ? permissions.value : this.permissions),
      avatar: (avatar != null ? avatar.value : this.avatar),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      requestCount: (requestCount != null
          ? requestCount.value
          : this.requestCount),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserSettings {
  const UserSettings({
    this.username,
    this.email,
    this.discordId,
    this.locale,
    this.discoverRegion,
    this.streamingRegion,
    this.originalLanguage,
    this.movieQuotaLimit,
    this.movieQuotaDays,
    this.tvQuotaLimit,
    this.tvQuotaDays,
    this.globalMovieQuotaDays,
    this.globalMovieQuotaLimit,
    this.globalTvQuotaLimit,
    this.globalTvQuotaDays,
    this.watchlistSyncMovies,
    this.watchlistSyncTv,
  });

  factory UserSettings.fromJson(Map<String, dynamic> json) =>
      _$UserSettingsFromJson(json);

  static const toJsonFactory = _$UserSettingsToJson;
  Map<String, dynamic> toJson() => _$UserSettingsToJson(this);

  @JsonKey(name: 'username', includeIfNull: false)
  final String? username;
  @JsonKey(name: 'email', includeIfNull: false)
  final String? email;
  @JsonKey(name: 'discordId', includeIfNull: false)
  final String? discordId;
  @JsonKey(name: 'locale', includeIfNull: false)
  final String? locale;
  @JsonKey(name: 'discoverRegion', includeIfNull: false)
  final String? discoverRegion;
  @JsonKey(name: 'streamingRegion', includeIfNull: false)
  final String? streamingRegion;
  @JsonKey(name: 'originalLanguage', includeIfNull: false)
  final String? originalLanguage;
  @JsonKey(name: 'movieQuotaLimit', includeIfNull: false)
  final double? movieQuotaLimit;
  @JsonKey(name: 'movieQuotaDays', includeIfNull: false)
  final double? movieQuotaDays;
  @JsonKey(name: 'tvQuotaLimit', includeIfNull: false)
  final double? tvQuotaLimit;
  @JsonKey(name: 'tvQuotaDays', includeIfNull: false)
  final double? tvQuotaDays;
  @JsonKey(name: 'globalMovieQuotaDays', includeIfNull: false)
  final double? globalMovieQuotaDays;
  @JsonKey(name: 'globalMovieQuotaLimit', includeIfNull: false)
  final double? globalMovieQuotaLimit;
  @JsonKey(name: 'globalTvQuotaLimit', includeIfNull: false)
  final double? globalTvQuotaLimit;
  @JsonKey(name: 'globalTvQuotaDays', includeIfNull: false)
  final double? globalTvQuotaDays;
  @JsonKey(name: 'watchlistSyncMovies', includeIfNull: false)
  final bool? watchlistSyncMovies;
  @JsonKey(name: 'watchlistSyncTv', includeIfNull: false)
  final bool? watchlistSyncTv;
  static const fromJsonFactory = _$UserSettingsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserSettings &&
            (identical(other.username, username) ||
                const DeepCollectionEquality().equals(
                  other.username,
                  username,
                )) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.discordId, discordId) ||
                const DeepCollectionEquality().equals(
                  other.discordId,
                  discordId,
                )) &&
            (identical(other.locale, locale) ||
                const DeepCollectionEquality().equals(other.locale, locale)) &&
            (identical(other.discoverRegion, discoverRegion) ||
                const DeepCollectionEquality().equals(
                  other.discoverRegion,
                  discoverRegion,
                )) &&
            (identical(other.streamingRegion, streamingRegion) ||
                const DeepCollectionEquality().equals(
                  other.streamingRegion,
                  streamingRegion,
                )) &&
            (identical(other.originalLanguage, originalLanguage) ||
                const DeepCollectionEquality().equals(
                  other.originalLanguage,
                  originalLanguage,
                )) &&
            (identical(other.movieQuotaLimit, movieQuotaLimit) ||
                const DeepCollectionEquality().equals(
                  other.movieQuotaLimit,
                  movieQuotaLimit,
                )) &&
            (identical(other.movieQuotaDays, movieQuotaDays) ||
                const DeepCollectionEquality().equals(
                  other.movieQuotaDays,
                  movieQuotaDays,
                )) &&
            (identical(other.tvQuotaLimit, tvQuotaLimit) ||
                const DeepCollectionEquality().equals(
                  other.tvQuotaLimit,
                  tvQuotaLimit,
                )) &&
            (identical(other.tvQuotaDays, tvQuotaDays) ||
                const DeepCollectionEquality().equals(
                  other.tvQuotaDays,
                  tvQuotaDays,
                )) &&
            (identical(other.globalMovieQuotaDays, globalMovieQuotaDays) ||
                const DeepCollectionEquality().equals(
                  other.globalMovieQuotaDays,
                  globalMovieQuotaDays,
                )) &&
            (identical(other.globalMovieQuotaLimit, globalMovieQuotaLimit) ||
                const DeepCollectionEquality().equals(
                  other.globalMovieQuotaLimit,
                  globalMovieQuotaLimit,
                )) &&
            (identical(other.globalTvQuotaLimit, globalTvQuotaLimit) ||
                const DeepCollectionEquality().equals(
                  other.globalTvQuotaLimit,
                  globalTvQuotaLimit,
                )) &&
            (identical(other.globalTvQuotaDays, globalTvQuotaDays) ||
                const DeepCollectionEquality().equals(
                  other.globalTvQuotaDays,
                  globalTvQuotaDays,
                )) &&
            (identical(other.watchlistSyncMovies, watchlistSyncMovies) ||
                const DeepCollectionEquality().equals(
                  other.watchlistSyncMovies,
                  watchlistSyncMovies,
                )) &&
            (identical(other.watchlistSyncTv, watchlistSyncTv) ||
                const DeepCollectionEquality().equals(
                  other.watchlistSyncTv,
                  watchlistSyncTv,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(discordId) ^
      const DeepCollectionEquality().hash(locale) ^
      const DeepCollectionEquality().hash(discoverRegion) ^
      const DeepCollectionEquality().hash(streamingRegion) ^
      const DeepCollectionEquality().hash(originalLanguage) ^
      const DeepCollectionEquality().hash(movieQuotaLimit) ^
      const DeepCollectionEquality().hash(movieQuotaDays) ^
      const DeepCollectionEquality().hash(tvQuotaLimit) ^
      const DeepCollectionEquality().hash(tvQuotaDays) ^
      const DeepCollectionEquality().hash(globalMovieQuotaDays) ^
      const DeepCollectionEquality().hash(globalMovieQuotaLimit) ^
      const DeepCollectionEquality().hash(globalTvQuotaLimit) ^
      const DeepCollectionEquality().hash(globalTvQuotaDays) ^
      const DeepCollectionEquality().hash(watchlistSyncMovies) ^
      const DeepCollectionEquality().hash(watchlistSyncTv) ^
      runtimeType.hashCode;
}

extension $UserSettingsExtension on UserSettings {
  UserSettings copyWith({
    String? username,
    String? email,
    String? discordId,
    String? locale,
    String? discoverRegion,
    String? streamingRegion,
    String? originalLanguage,
    double? movieQuotaLimit,
    double? movieQuotaDays,
    double? tvQuotaLimit,
    double? tvQuotaDays,
    double? globalMovieQuotaDays,
    double? globalMovieQuotaLimit,
    double? globalTvQuotaLimit,
    double? globalTvQuotaDays,
    bool? watchlistSyncMovies,
    bool? watchlistSyncTv,
  }) {
    return UserSettings(
      username: username ?? this.username,
      email: email ?? this.email,
      discordId: discordId ?? this.discordId,
      locale: locale ?? this.locale,
      discoverRegion: discoverRegion ?? this.discoverRegion,
      streamingRegion: streamingRegion ?? this.streamingRegion,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      movieQuotaLimit: movieQuotaLimit ?? this.movieQuotaLimit,
      movieQuotaDays: movieQuotaDays ?? this.movieQuotaDays,
      tvQuotaLimit: tvQuotaLimit ?? this.tvQuotaLimit,
      tvQuotaDays: tvQuotaDays ?? this.tvQuotaDays,
      globalMovieQuotaDays: globalMovieQuotaDays ?? this.globalMovieQuotaDays,
      globalMovieQuotaLimit:
          globalMovieQuotaLimit ?? this.globalMovieQuotaLimit,
      globalTvQuotaLimit: globalTvQuotaLimit ?? this.globalTvQuotaLimit,
      globalTvQuotaDays: globalTvQuotaDays ?? this.globalTvQuotaDays,
      watchlistSyncMovies: watchlistSyncMovies ?? this.watchlistSyncMovies,
      watchlistSyncTv: watchlistSyncTv ?? this.watchlistSyncTv,
    );
  }

  UserSettings copyWithWrapped({
    Wrapped<String?>? username,
    Wrapped<String?>? email,
    Wrapped<String?>? discordId,
    Wrapped<String?>? locale,
    Wrapped<String?>? discoverRegion,
    Wrapped<String?>? streamingRegion,
    Wrapped<String?>? originalLanguage,
    Wrapped<double?>? movieQuotaLimit,
    Wrapped<double?>? movieQuotaDays,
    Wrapped<double?>? tvQuotaLimit,
    Wrapped<double?>? tvQuotaDays,
    Wrapped<double?>? globalMovieQuotaDays,
    Wrapped<double?>? globalMovieQuotaLimit,
    Wrapped<double?>? globalTvQuotaLimit,
    Wrapped<double?>? globalTvQuotaDays,
    Wrapped<bool?>? watchlistSyncMovies,
    Wrapped<bool?>? watchlistSyncTv,
  }) {
    return UserSettings(
      username: (username != null ? username.value : this.username),
      email: (email != null ? email.value : this.email),
      discordId: (discordId != null ? discordId.value : this.discordId),
      locale: (locale != null ? locale.value : this.locale),
      discoverRegion: (discoverRegion != null
          ? discoverRegion.value
          : this.discoverRegion),
      streamingRegion: (streamingRegion != null
          ? streamingRegion.value
          : this.streamingRegion),
      originalLanguage: (originalLanguage != null
          ? originalLanguage.value
          : this.originalLanguage),
      movieQuotaLimit: (movieQuotaLimit != null
          ? movieQuotaLimit.value
          : this.movieQuotaLimit),
      movieQuotaDays: (movieQuotaDays != null
          ? movieQuotaDays.value
          : this.movieQuotaDays),
      tvQuotaLimit: (tvQuotaLimit != null
          ? tvQuotaLimit.value
          : this.tvQuotaLimit),
      tvQuotaDays: (tvQuotaDays != null ? tvQuotaDays.value : this.tvQuotaDays),
      globalMovieQuotaDays: (globalMovieQuotaDays != null
          ? globalMovieQuotaDays.value
          : this.globalMovieQuotaDays),
      globalMovieQuotaLimit: (globalMovieQuotaLimit != null
          ? globalMovieQuotaLimit.value
          : this.globalMovieQuotaLimit),
      globalTvQuotaLimit: (globalTvQuotaLimit != null
          ? globalTvQuotaLimit.value
          : this.globalTvQuotaLimit),
      globalTvQuotaDays: (globalTvQuotaDays != null
          ? globalTvQuotaDays.value
          : this.globalTvQuotaDays),
      watchlistSyncMovies: (watchlistSyncMovies != null
          ? watchlistSyncMovies.value
          : this.watchlistSyncMovies),
      watchlistSyncTv: (watchlistSyncTv != null
          ? watchlistSyncTv.value
          : this.watchlistSyncTv),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class MainSettings {
  const MainSettings({
    this.apiKey,
    this.appLanguage,
    this.applicationTitle,
    this.applicationUrl,
    this.hideAvailable,
    this.partialRequestsEnabled,
    this.localLogin,
    this.mediaServerType,
    this.newPlexLogin,
    this.defaultPermissions,
    this.enableSpecialEpisodes,
  });

  factory MainSettings.fromJson(Map<String, dynamic> json) =>
      _$MainSettingsFromJson(json);

  static const toJsonFactory = _$MainSettingsToJson;
  Map<String, dynamic> toJson() => _$MainSettingsToJson(this);

  @JsonKey(name: 'apiKey', includeIfNull: false)
  final String? apiKey;
  @JsonKey(name: 'appLanguage', includeIfNull: false)
  final String? appLanguage;
  @JsonKey(name: 'applicationTitle', includeIfNull: false)
  final String? applicationTitle;
  @JsonKey(name: 'applicationUrl', includeIfNull: false)
  final String? applicationUrl;
  @JsonKey(name: 'hideAvailable', includeIfNull: false)
  final bool? hideAvailable;
  @JsonKey(name: 'partialRequestsEnabled', includeIfNull: false)
  final bool? partialRequestsEnabled;
  @JsonKey(name: 'localLogin', includeIfNull: false)
  final bool? localLogin;
  @JsonKey(name: 'mediaServerType', includeIfNull: false)
  final double? mediaServerType;
  @JsonKey(name: 'newPlexLogin', includeIfNull: false)
  final bool? newPlexLogin;
  @JsonKey(name: 'defaultPermissions', includeIfNull: false)
  final double? defaultPermissions;
  @JsonKey(name: 'enableSpecialEpisodes', includeIfNull: false)
  final bool? enableSpecialEpisodes;
  static const fromJsonFactory = _$MainSettingsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MainSettings &&
            (identical(other.apiKey, apiKey) ||
                const DeepCollectionEquality().equals(other.apiKey, apiKey)) &&
            (identical(other.appLanguage, appLanguage) ||
                const DeepCollectionEquality().equals(
                  other.appLanguage,
                  appLanguage,
                )) &&
            (identical(other.applicationTitle, applicationTitle) ||
                const DeepCollectionEquality().equals(
                  other.applicationTitle,
                  applicationTitle,
                )) &&
            (identical(other.applicationUrl, applicationUrl) ||
                const DeepCollectionEquality().equals(
                  other.applicationUrl,
                  applicationUrl,
                )) &&
            (identical(other.hideAvailable, hideAvailable) ||
                const DeepCollectionEquality().equals(
                  other.hideAvailable,
                  hideAvailable,
                )) &&
            (identical(other.partialRequestsEnabled, partialRequestsEnabled) ||
                const DeepCollectionEquality().equals(
                  other.partialRequestsEnabled,
                  partialRequestsEnabled,
                )) &&
            (identical(other.localLogin, localLogin) ||
                const DeepCollectionEquality().equals(
                  other.localLogin,
                  localLogin,
                )) &&
            (identical(other.mediaServerType, mediaServerType) ||
                const DeepCollectionEquality().equals(
                  other.mediaServerType,
                  mediaServerType,
                )) &&
            (identical(other.newPlexLogin, newPlexLogin) ||
                const DeepCollectionEquality().equals(
                  other.newPlexLogin,
                  newPlexLogin,
                )) &&
            (identical(other.defaultPermissions, defaultPermissions) ||
                const DeepCollectionEquality().equals(
                  other.defaultPermissions,
                  defaultPermissions,
                )) &&
            (identical(other.enableSpecialEpisodes, enableSpecialEpisodes) ||
                const DeepCollectionEquality().equals(
                  other.enableSpecialEpisodes,
                  enableSpecialEpisodes,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(apiKey) ^
      const DeepCollectionEquality().hash(appLanguage) ^
      const DeepCollectionEquality().hash(applicationTitle) ^
      const DeepCollectionEquality().hash(applicationUrl) ^
      const DeepCollectionEquality().hash(hideAvailable) ^
      const DeepCollectionEquality().hash(partialRequestsEnabled) ^
      const DeepCollectionEquality().hash(localLogin) ^
      const DeepCollectionEquality().hash(mediaServerType) ^
      const DeepCollectionEquality().hash(newPlexLogin) ^
      const DeepCollectionEquality().hash(defaultPermissions) ^
      const DeepCollectionEquality().hash(enableSpecialEpisodes) ^
      runtimeType.hashCode;
}

extension $MainSettingsExtension on MainSettings {
  MainSettings copyWith({
    String? apiKey,
    String? appLanguage,
    String? applicationTitle,
    String? applicationUrl,
    bool? hideAvailable,
    bool? partialRequestsEnabled,
    bool? localLogin,
    double? mediaServerType,
    bool? newPlexLogin,
    double? defaultPermissions,
    bool? enableSpecialEpisodes,
  }) {
    return MainSettings(
      apiKey: apiKey ?? this.apiKey,
      appLanguage: appLanguage ?? this.appLanguage,
      applicationTitle: applicationTitle ?? this.applicationTitle,
      applicationUrl: applicationUrl ?? this.applicationUrl,
      hideAvailable: hideAvailable ?? this.hideAvailable,
      partialRequestsEnabled:
          partialRequestsEnabled ?? this.partialRequestsEnabled,
      localLogin: localLogin ?? this.localLogin,
      mediaServerType: mediaServerType ?? this.mediaServerType,
      newPlexLogin: newPlexLogin ?? this.newPlexLogin,
      defaultPermissions: defaultPermissions ?? this.defaultPermissions,
      enableSpecialEpisodes:
          enableSpecialEpisodes ?? this.enableSpecialEpisodes,
    );
  }

  MainSettings copyWithWrapped({
    Wrapped<String?>? apiKey,
    Wrapped<String?>? appLanguage,
    Wrapped<String?>? applicationTitle,
    Wrapped<String?>? applicationUrl,
    Wrapped<bool?>? hideAvailable,
    Wrapped<bool?>? partialRequestsEnabled,
    Wrapped<bool?>? localLogin,
    Wrapped<double?>? mediaServerType,
    Wrapped<bool?>? newPlexLogin,
    Wrapped<double?>? defaultPermissions,
    Wrapped<bool?>? enableSpecialEpisodes,
  }) {
    return MainSettings(
      apiKey: (apiKey != null ? apiKey.value : this.apiKey),
      appLanguage: (appLanguage != null ? appLanguage.value : this.appLanguage),
      applicationTitle: (applicationTitle != null
          ? applicationTitle.value
          : this.applicationTitle),
      applicationUrl: (applicationUrl != null
          ? applicationUrl.value
          : this.applicationUrl),
      hideAvailable: (hideAvailable != null
          ? hideAvailable.value
          : this.hideAvailable),
      partialRequestsEnabled: (partialRequestsEnabled != null
          ? partialRequestsEnabled.value
          : this.partialRequestsEnabled),
      localLogin: (localLogin != null ? localLogin.value : this.localLogin),
      mediaServerType: (mediaServerType != null
          ? mediaServerType.value
          : this.mediaServerType),
      newPlexLogin: (newPlexLogin != null
          ? newPlexLogin.value
          : this.newPlexLogin),
      defaultPermissions: (defaultPermissions != null
          ? defaultPermissions.value
          : this.defaultPermissions),
      enableSpecialEpisodes: (enableSpecialEpisodes != null
          ? enableSpecialEpisodes.value
          : this.enableSpecialEpisodes),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class NetworkSettings {
  const NetworkSettings({
    this.csrfProtection,
    this.forceIpv4First,
    this.trustProxy,
    this.proxy,
    this.dnsCache,
  });

  factory NetworkSettings.fromJson(Map<String, dynamic> json) =>
      _$NetworkSettingsFromJson(json);

  static const toJsonFactory = _$NetworkSettingsToJson;
  Map<String, dynamic> toJson() => _$NetworkSettingsToJson(this);

  @JsonKey(name: 'csrfProtection', includeIfNull: false)
  final bool? csrfProtection;
  @JsonKey(name: 'forceIpv4First', includeIfNull: false)
  final bool? forceIpv4First;
  @JsonKey(name: 'trustProxy', includeIfNull: false)
  final bool? trustProxy;
  @JsonKey(name: 'proxy', includeIfNull: false)
  final NetworkSettings$Proxy? proxy;
  @JsonKey(name: 'dnsCache', includeIfNull: false)
  final NetworkSettings$DnsCache? dnsCache;
  static const fromJsonFactory = _$NetworkSettingsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is NetworkSettings &&
            (identical(other.csrfProtection, csrfProtection) ||
                const DeepCollectionEquality().equals(
                  other.csrfProtection,
                  csrfProtection,
                )) &&
            (identical(other.forceIpv4First, forceIpv4First) ||
                const DeepCollectionEquality().equals(
                  other.forceIpv4First,
                  forceIpv4First,
                )) &&
            (identical(other.trustProxy, trustProxy) ||
                const DeepCollectionEquality().equals(
                  other.trustProxy,
                  trustProxy,
                )) &&
            (identical(other.proxy, proxy) ||
                const DeepCollectionEquality().equals(other.proxy, proxy)) &&
            (identical(other.dnsCache, dnsCache) ||
                const DeepCollectionEquality().equals(
                  other.dnsCache,
                  dnsCache,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(csrfProtection) ^
      const DeepCollectionEquality().hash(forceIpv4First) ^
      const DeepCollectionEquality().hash(trustProxy) ^
      const DeepCollectionEquality().hash(proxy) ^
      const DeepCollectionEquality().hash(dnsCache) ^
      runtimeType.hashCode;
}

extension $NetworkSettingsExtension on NetworkSettings {
  NetworkSettings copyWith({
    bool? csrfProtection,
    bool? forceIpv4First,
    bool? trustProxy,
    NetworkSettings$Proxy? proxy,
    NetworkSettings$DnsCache? dnsCache,
  }) {
    return NetworkSettings(
      csrfProtection: csrfProtection ?? this.csrfProtection,
      forceIpv4First: forceIpv4First ?? this.forceIpv4First,
      trustProxy: trustProxy ?? this.trustProxy,
      proxy: proxy ?? this.proxy,
      dnsCache: dnsCache ?? this.dnsCache,
    );
  }

  NetworkSettings copyWithWrapped({
    Wrapped<bool?>? csrfProtection,
    Wrapped<bool?>? forceIpv4First,
    Wrapped<bool?>? trustProxy,
    Wrapped<NetworkSettings$Proxy?>? proxy,
    Wrapped<NetworkSettings$DnsCache?>? dnsCache,
  }) {
    return NetworkSettings(
      csrfProtection: (csrfProtection != null
          ? csrfProtection.value
          : this.csrfProtection),
      forceIpv4First: (forceIpv4First != null
          ? forceIpv4First.value
          : this.forceIpv4First),
      trustProxy: (trustProxy != null ? trustProxy.value : this.trustProxy),
      proxy: (proxy != null ? proxy.value : this.proxy),
      dnsCache: (dnsCache != null ? dnsCache.value : this.dnsCache),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PlexLibrary {
  const PlexLibrary({
    required this.id,
    required this.name,
    required this.enabled,
  });

  factory PlexLibrary.fromJson(Map<String, dynamic> json) =>
      _$PlexLibraryFromJson(json);

  static const toJsonFactory = _$PlexLibraryToJson;
  Map<String, dynamic> toJson() => _$PlexLibraryToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  @JsonKey(name: 'enabled', includeIfNull: false)
  final bool enabled;
  static const fromJsonFactory = _$PlexLibraryFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PlexLibrary &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.enabled, enabled) ||
                const DeepCollectionEquality().equals(other.enabled, enabled)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(enabled) ^
      runtimeType.hashCode;
}

extension $PlexLibraryExtension on PlexLibrary {
  PlexLibrary copyWith({String? id, String? name, bool? enabled}) {
    return PlexLibrary(
      id: id ?? this.id,
      name: name ?? this.name,
      enabled: enabled ?? this.enabled,
    );
  }

  PlexLibrary copyWithWrapped({
    Wrapped<String>? id,
    Wrapped<String>? name,
    Wrapped<bool>? enabled,
  }) {
    return PlexLibrary(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
      enabled: (enabled != null ? enabled.value : this.enabled),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PlexSettings {
  const PlexSettings({
    this.name,
    this.machineId,
    required this.ip,
    required this.port,
    this.useSsl,
    this.libraries,
    this.webAppUrl,
  });

  factory PlexSettings.fromJson(Map<String, dynamic> json) =>
      _$PlexSettingsFromJson(json);

  static const toJsonFactory = _$PlexSettingsToJson;
  Map<String, dynamic> toJson() => _$PlexSettingsToJson(this);

  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(name: 'machineId', includeIfNull: false)
  final String? machineId;
  @JsonKey(name: 'ip', includeIfNull: false)
  final String ip;
  @JsonKey(name: 'port', includeIfNull: false)
  final double port;
  @JsonKey(name: 'useSsl', includeIfNull: false)
  final bool? useSsl;
  @JsonKey(
    name: 'libraries',
    includeIfNull: false,
    defaultValue: <PlexLibrary>[],
  )
  final List<PlexLibrary>? libraries;
  @JsonKey(name: 'webAppUrl', includeIfNull: false)
  final String? webAppUrl;
  static const fromJsonFactory = _$PlexSettingsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PlexSettings &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.machineId, machineId) ||
                const DeepCollectionEquality().equals(
                  other.machineId,
                  machineId,
                )) &&
            (identical(other.ip, ip) ||
                const DeepCollectionEquality().equals(other.ip, ip)) &&
            (identical(other.port, port) ||
                const DeepCollectionEquality().equals(other.port, port)) &&
            (identical(other.useSsl, useSsl) ||
                const DeepCollectionEquality().equals(other.useSsl, useSsl)) &&
            (identical(other.libraries, libraries) ||
                const DeepCollectionEquality().equals(
                  other.libraries,
                  libraries,
                )) &&
            (identical(other.webAppUrl, webAppUrl) ||
                const DeepCollectionEquality().equals(
                  other.webAppUrl,
                  webAppUrl,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(machineId) ^
      const DeepCollectionEquality().hash(ip) ^
      const DeepCollectionEquality().hash(port) ^
      const DeepCollectionEquality().hash(useSsl) ^
      const DeepCollectionEquality().hash(libraries) ^
      const DeepCollectionEquality().hash(webAppUrl) ^
      runtimeType.hashCode;
}

extension $PlexSettingsExtension on PlexSettings {
  PlexSettings copyWith({
    String? name,
    String? machineId,
    String? ip,
    double? port,
    bool? useSsl,
    List<PlexLibrary>? libraries,
    String? webAppUrl,
  }) {
    return PlexSettings(
      name: name ?? this.name,
      machineId: machineId ?? this.machineId,
      ip: ip ?? this.ip,
      port: port ?? this.port,
      useSsl: useSsl ?? this.useSsl,
      libraries: libraries ?? this.libraries,
      webAppUrl: webAppUrl ?? this.webAppUrl,
    );
  }

  PlexSettings copyWithWrapped({
    Wrapped<String?>? name,
    Wrapped<String?>? machineId,
    Wrapped<String>? ip,
    Wrapped<double>? port,
    Wrapped<bool?>? useSsl,
    Wrapped<List<PlexLibrary>?>? libraries,
    Wrapped<String?>? webAppUrl,
  }) {
    return PlexSettings(
      name: (name != null ? name.value : this.name),
      machineId: (machineId != null ? machineId.value : this.machineId),
      ip: (ip != null ? ip.value : this.ip),
      port: (port != null ? port.value : this.port),
      useSsl: (useSsl != null ? useSsl.value : this.useSsl),
      libraries: (libraries != null ? libraries.value : this.libraries),
      webAppUrl: (webAppUrl != null ? webAppUrl.value : this.webAppUrl),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PlexConnection {
  const PlexConnection({
    required this.protocol,
    required this.address,
    required this.port,
    required this.uri,
    required this.local,
    this.status,
    this.message,
  });

  factory PlexConnection.fromJson(Map<String, dynamic> json) =>
      _$PlexConnectionFromJson(json);

  static const toJsonFactory = _$PlexConnectionToJson;
  Map<String, dynamic> toJson() => _$PlexConnectionToJson(this);

  @JsonKey(name: 'protocol', includeIfNull: false)
  final String protocol;
  @JsonKey(name: 'address', includeIfNull: false)
  final String address;
  @JsonKey(name: 'port', includeIfNull: false)
  final double port;
  @JsonKey(name: 'uri', includeIfNull: false)
  final String uri;
  @JsonKey(name: 'local', includeIfNull: false)
  final bool local;
  @JsonKey(name: 'status', includeIfNull: false)
  final double? status;
  @JsonKey(name: 'message', includeIfNull: false)
  final String? message;
  static const fromJsonFactory = _$PlexConnectionFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PlexConnection &&
            (identical(other.protocol, protocol) ||
                const DeepCollectionEquality().equals(
                  other.protocol,
                  protocol,
                )) &&
            (identical(other.address, address) ||
                const DeepCollectionEquality().equals(
                  other.address,
                  address,
                )) &&
            (identical(other.port, port) ||
                const DeepCollectionEquality().equals(other.port, port)) &&
            (identical(other.uri, uri) ||
                const DeepCollectionEquality().equals(other.uri, uri)) &&
            (identical(other.local, local) ||
                const DeepCollectionEquality().equals(other.local, local)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(protocol) ^
      const DeepCollectionEquality().hash(address) ^
      const DeepCollectionEquality().hash(port) ^
      const DeepCollectionEquality().hash(uri) ^
      const DeepCollectionEquality().hash(local) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(message) ^
      runtimeType.hashCode;
}

extension $PlexConnectionExtension on PlexConnection {
  PlexConnection copyWith({
    String? protocol,
    String? address,
    double? port,
    String? uri,
    bool? local,
    double? status,
    String? message,
  }) {
    return PlexConnection(
      protocol: protocol ?? this.protocol,
      address: address ?? this.address,
      port: port ?? this.port,
      uri: uri ?? this.uri,
      local: local ?? this.local,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  PlexConnection copyWithWrapped({
    Wrapped<String>? protocol,
    Wrapped<String>? address,
    Wrapped<double>? port,
    Wrapped<String>? uri,
    Wrapped<bool>? local,
    Wrapped<double?>? status,
    Wrapped<String?>? message,
  }) {
    return PlexConnection(
      protocol: (protocol != null ? protocol.value : this.protocol),
      address: (address != null ? address.value : this.address),
      port: (port != null ? port.value : this.port),
      uri: (uri != null ? uri.value : this.uri),
      local: (local != null ? local.value : this.local),
      status: (status != null ? status.value : this.status),
      message: (message != null ? message.value : this.message),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PlexDevice {
  const PlexDevice({
    required this.name,
    required this.product,
    required this.productVersion,
    required this.platform,
    this.platformVersion,
    required this.device,
    required this.clientIdentifier,
    required this.createdAt,
    required this.lastSeenAt,
    required this.provides,
    required this.owned,
    this.ownerID,
    this.home,
    this.sourceTitle,
    this.accessToken,
    this.publicAddress,
    this.httpsRequired,
    this.synced,
    this.relay,
    this.dnsRebindingProtection,
    this.natLoopbackSupported,
    this.publicAddressMatches,
    this.presence,
    required this.connection,
  });

  factory PlexDevice.fromJson(Map<String, dynamic> json) =>
      _$PlexDeviceFromJson(json);

  static const toJsonFactory = _$PlexDeviceToJson;
  Map<String, dynamic> toJson() => _$PlexDeviceToJson(this);

  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  @JsonKey(name: 'product', includeIfNull: false)
  final String product;
  @JsonKey(name: 'productVersion', includeIfNull: false)
  final String productVersion;
  @JsonKey(name: 'platform', includeIfNull: false)
  final String platform;
  @JsonKey(name: 'platformVersion', includeIfNull: false)
  final String? platformVersion;
  @JsonKey(name: 'device', includeIfNull: false)
  final String device;
  @JsonKey(name: 'clientIdentifier', includeIfNull: false)
  final String clientIdentifier;
  @JsonKey(name: 'createdAt', includeIfNull: false)
  final String createdAt;
  @JsonKey(name: 'lastSeenAt', includeIfNull: false)
  final String lastSeenAt;
  @JsonKey(name: 'provides', includeIfNull: false, defaultValue: <String>[])
  final List<String> provides;
  @JsonKey(name: 'owned', includeIfNull: false)
  final bool owned;
  @JsonKey(name: 'ownerID', includeIfNull: false)
  final String? ownerID;
  @JsonKey(name: 'home', includeIfNull: false)
  final bool? home;
  @JsonKey(name: 'sourceTitle', includeIfNull: false)
  final String? sourceTitle;
  @JsonKey(name: 'accessToken', includeIfNull: false)
  final String? accessToken;
  @JsonKey(name: 'publicAddress', includeIfNull: false)
  final String? publicAddress;
  @JsonKey(name: 'httpsRequired', includeIfNull: false)
  final bool? httpsRequired;
  @JsonKey(name: 'synced', includeIfNull: false)
  final bool? synced;
  @JsonKey(name: 'relay', includeIfNull: false)
  final bool? relay;
  @JsonKey(name: 'dnsRebindingProtection', includeIfNull: false)
  final bool? dnsRebindingProtection;
  @JsonKey(name: 'natLoopbackSupported', includeIfNull: false)
  final bool? natLoopbackSupported;
  @JsonKey(name: 'publicAddressMatches', includeIfNull: false)
  final bool? publicAddressMatches;
  @JsonKey(name: 'presence', includeIfNull: false)
  final bool? presence;
  @JsonKey(
    name: 'connection',
    includeIfNull: false,
    defaultValue: <PlexConnection>[],
  )
  final List<PlexConnection> connection;
  static const fromJsonFactory = _$PlexDeviceFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PlexDevice &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.product, product) ||
                const DeepCollectionEquality().equals(
                  other.product,
                  product,
                )) &&
            (identical(other.productVersion, productVersion) ||
                const DeepCollectionEquality().equals(
                  other.productVersion,
                  productVersion,
                )) &&
            (identical(other.platform, platform) ||
                const DeepCollectionEquality().equals(
                  other.platform,
                  platform,
                )) &&
            (identical(other.platformVersion, platformVersion) ||
                const DeepCollectionEquality().equals(
                  other.platformVersion,
                  platformVersion,
                )) &&
            (identical(other.device, device) ||
                const DeepCollectionEquality().equals(other.device, device)) &&
            (identical(other.clientIdentifier, clientIdentifier) ||
                const DeepCollectionEquality().equals(
                  other.clientIdentifier,
                  clientIdentifier,
                )) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(
                  other.createdAt,
                  createdAt,
                )) &&
            (identical(other.lastSeenAt, lastSeenAt) ||
                const DeepCollectionEquality().equals(
                  other.lastSeenAt,
                  lastSeenAt,
                )) &&
            (identical(other.provides, provides) ||
                const DeepCollectionEquality().equals(
                  other.provides,
                  provides,
                )) &&
            (identical(other.owned, owned) ||
                const DeepCollectionEquality().equals(other.owned, owned)) &&
            (identical(other.ownerID, ownerID) ||
                const DeepCollectionEquality().equals(
                  other.ownerID,
                  ownerID,
                )) &&
            (identical(other.home, home) ||
                const DeepCollectionEquality().equals(other.home, home)) &&
            (identical(other.sourceTitle, sourceTitle) ||
                const DeepCollectionEquality().equals(
                  other.sourceTitle,
                  sourceTitle,
                )) &&
            (identical(other.accessToken, accessToken) ||
                const DeepCollectionEquality().equals(
                  other.accessToken,
                  accessToken,
                )) &&
            (identical(other.publicAddress, publicAddress) ||
                const DeepCollectionEquality().equals(
                  other.publicAddress,
                  publicAddress,
                )) &&
            (identical(other.httpsRequired, httpsRequired) ||
                const DeepCollectionEquality().equals(
                  other.httpsRequired,
                  httpsRequired,
                )) &&
            (identical(other.synced, synced) ||
                const DeepCollectionEquality().equals(other.synced, synced)) &&
            (identical(other.relay, relay) ||
                const DeepCollectionEquality().equals(other.relay, relay)) &&
            (identical(other.dnsRebindingProtection, dnsRebindingProtection) ||
                const DeepCollectionEquality().equals(
                  other.dnsRebindingProtection,
                  dnsRebindingProtection,
                )) &&
            (identical(other.natLoopbackSupported, natLoopbackSupported) ||
                const DeepCollectionEquality().equals(
                  other.natLoopbackSupported,
                  natLoopbackSupported,
                )) &&
            (identical(other.publicAddressMatches, publicAddressMatches) ||
                const DeepCollectionEquality().equals(
                  other.publicAddressMatches,
                  publicAddressMatches,
                )) &&
            (identical(other.presence, presence) ||
                const DeepCollectionEquality().equals(
                  other.presence,
                  presence,
                )) &&
            (identical(other.connection, connection) ||
                const DeepCollectionEquality().equals(
                  other.connection,
                  connection,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(product) ^
      const DeepCollectionEquality().hash(productVersion) ^
      const DeepCollectionEquality().hash(platform) ^
      const DeepCollectionEquality().hash(platformVersion) ^
      const DeepCollectionEquality().hash(device) ^
      const DeepCollectionEquality().hash(clientIdentifier) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(lastSeenAt) ^
      const DeepCollectionEquality().hash(provides) ^
      const DeepCollectionEquality().hash(owned) ^
      const DeepCollectionEquality().hash(ownerID) ^
      const DeepCollectionEquality().hash(home) ^
      const DeepCollectionEquality().hash(sourceTitle) ^
      const DeepCollectionEquality().hash(accessToken) ^
      const DeepCollectionEquality().hash(publicAddress) ^
      const DeepCollectionEquality().hash(httpsRequired) ^
      const DeepCollectionEquality().hash(synced) ^
      const DeepCollectionEquality().hash(relay) ^
      const DeepCollectionEquality().hash(dnsRebindingProtection) ^
      const DeepCollectionEquality().hash(natLoopbackSupported) ^
      const DeepCollectionEquality().hash(publicAddressMatches) ^
      const DeepCollectionEquality().hash(presence) ^
      const DeepCollectionEquality().hash(connection) ^
      runtimeType.hashCode;
}

extension $PlexDeviceExtension on PlexDevice {
  PlexDevice copyWith({
    String? name,
    String? product,
    String? productVersion,
    String? platform,
    String? platformVersion,
    String? device,
    String? clientIdentifier,
    String? createdAt,
    String? lastSeenAt,
    List<String>? provides,
    bool? owned,
    String? ownerID,
    bool? home,
    String? sourceTitle,
    String? accessToken,
    String? publicAddress,
    bool? httpsRequired,
    bool? synced,
    bool? relay,
    bool? dnsRebindingProtection,
    bool? natLoopbackSupported,
    bool? publicAddressMatches,
    bool? presence,
    List<PlexConnection>? connection,
  }) {
    return PlexDevice(
      name: name ?? this.name,
      product: product ?? this.product,
      productVersion: productVersion ?? this.productVersion,
      platform: platform ?? this.platform,
      platformVersion: platformVersion ?? this.platformVersion,
      device: device ?? this.device,
      clientIdentifier: clientIdentifier ?? this.clientIdentifier,
      createdAt: createdAt ?? this.createdAt,
      lastSeenAt: lastSeenAt ?? this.lastSeenAt,
      provides: provides ?? this.provides,
      owned: owned ?? this.owned,
      ownerID: ownerID ?? this.ownerID,
      home: home ?? this.home,
      sourceTitle: sourceTitle ?? this.sourceTitle,
      accessToken: accessToken ?? this.accessToken,
      publicAddress: publicAddress ?? this.publicAddress,
      httpsRequired: httpsRequired ?? this.httpsRequired,
      synced: synced ?? this.synced,
      relay: relay ?? this.relay,
      dnsRebindingProtection:
          dnsRebindingProtection ?? this.dnsRebindingProtection,
      natLoopbackSupported: natLoopbackSupported ?? this.natLoopbackSupported,
      publicAddressMatches: publicAddressMatches ?? this.publicAddressMatches,
      presence: presence ?? this.presence,
      connection: connection ?? this.connection,
    );
  }

  PlexDevice copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? product,
    Wrapped<String>? productVersion,
    Wrapped<String>? platform,
    Wrapped<String?>? platformVersion,
    Wrapped<String>? device,
    Wrapped<String>? clientIdentifier,
    Wrapped<String>? createdAt,
    Wrapped<String>? lastSeenAt,
    Wrapped<List<String>>? provides,
    Wrapped<bool>? owned,
    Wrapped<String?>? ownerID,
    Wrapped<bool?>? home,
    Wrapped<String?>? sourceTitle,
    Wrapped<String?>? accessToken,
    Wrapped<String?>? publicAddress,
    Wrapped<bool?>? httpsRequired,
    Wrapped<bool?>? synced,
    Wrapped<bool?>? relay,
    Wrapped<bool?>? dnsRebindingProtection,
    Wrapped<bool?>? natLoopbackSupported,
    Wrapped<bool?>? publicAddressMatches,
    Wrapped<bool?>? presence,
    Wrapped<List<PlexConnection>>? connection,
  }) {
    return PlexDevice(
      name: (name != null ? name.value : this.name),
      product: (product != null ? product.value : this.product),
      productVersion: (productVersion != null
          ? productVersion.value
          : this.productVersion),
      platform: (platform != null ? platform.value : this.platform),
      platformVersion: (platformVersion != null
          ? platformVersion.value
          : this.platformVersion),
      device: (device != null ? device.value : this.device),
      clientIdentifier: (clientIdentifier != null
          ? clientIdentifier.value
          : this.clientIdentifier),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      lastSeenAt: (lastSeenAt != null ? lastSeenAt.value : this.lastSeenAt),
      provides: (provides != null ? provides.value : this.provides),
      owned: (owned != null ? owned.value : this.owned),
      ownerID: (ownerID != null ? ownerID.value : this.ownerID),
      home: (home != null ? home.value : this.home),
      sourceTitle: (sourceTitle != null ? sourceTitle.value : this.sourceTitle),
      accessToken: (accessToken != null ? accessToken.value : this.accessToken),
      publicAddress: (publicAddress != null
          ? publicAddress.value
          : this.publicAddress),
      httpsRequired: (httpsRequired != null
          ? httpsRequired.value
          : this.httpsRequired),
      synced: (synced != null ? synced.value : this.synced),
      relay: (relay != null ? relay.value : this.relay),
      dnsRebindingProtection: (dnsRebindingProtection != null
          ? dnsRebindingProtection.value
          : this.dnsRebindingProtection),
      natLoopbackSupported: (natLoopbackSupported != null
          ? natLoopbackSupported.value
          : this.natLoopbackSupported),
      publicAddressMatches: (publicAddressMatches != null
          ? publicAddressMatches.value
          : this.publicAddressMatches),
      presence: (presence != null ? presence.value : this.presence),
      connection: (connection != null ? connection.value : this.connection),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class JellyfinLibrary {
  const JellyfinLibrary({
    required this.id,
    required this.name,
    required this.enabled,
  });

  factory JellyfinLibrary.fromJson(Map<String, dynamic> json) =>
      _$JellyfinLibraryFromJson(json);

  static const toJsonFactory = _$JellyfinLibraryToJson;
  Map<String, dynamic> toJson() => _$JellyfinLibraryToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  @JsonKey(name: 'enabled', includeIfNull: false)
  final bool enabled;
  static const fromJsonFactory = _$JellyfinLibraryFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is JellyfinLibrary &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.enabled, enabled) ||
                const DeepCollectionEquality().equals(other.enabled, enabled)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(enabled) ^
      runtimeType.hashCode;
}

extension $JellyfinLibraryExtension on JellyfinLibrary {
  JellyfinLibrary copyWith({String? id, String? name, bool? enabled}) {
    return JellyfinLibrary(
      id: id ?? this.id,
      name: name ?? this.name,
      enabled: enabled ?? this.enabled,
    );
  }

  JellyfinLibrary copyWithWrapped({
    Wrapped<String>? id,
    Wrapped<String>? name,
    Wrapped<bool>? enabled,
  }) {
    return JellyfinLibrary(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
      enabled: (enabled != null ? enabled.value : this.enabled),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class JellyfinSettings {
  const JellyfinSettings({
    this.name,
    this.hostname,
    this.externalHostname,
    this.jellyfinForgotPasswordUrl,
    this.adminUser,
    this.adminPass,
    this.libraries,
    this.serverID,
  });

  factory JellyfinSettings.fromJson(Map<String, dynamic> json) =>
      _$JellyfinSettingsFromJson(json);

  static const toJsonFactory = _$JellyfinSettingsToJson;
  Map<String, dynamic> toJson() => _$JellyfinSettingsToJson(this);

  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(name: 'hostname', includeIfNull: false)
  final String? hostname;
  @JsonKey(name: 'externalHostname', includeIfNull: false)
  final String? externalHostname;
  @JsonKey(name: 'jellyfinForgotPasswordUrl', includeIfNull: false)
  final String? jellyfinForgotPasswordUrl;
  @JsonKey(name: 'adminUser', includeIfNull: false)
  final String? adminUser;
  @JsonKey(name: 'adminPass', includeIfNull: false)
  final String? adminPass;
  @JsonKey(
    name: 'libraries',
    includeIfNull: false,
    defaultValue: <JellyfinLibrary>[],
  )
  final List<JellyfinLibrary>? libraries;
  @JsonKey(name: 'serverID', includeIfNull: false)
  final String? serverID;
  static const fromJsonFactory = _$JellyfinSettingsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is JellyfinSettings &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.hostname, hostname) ||
                const DeepCollectionEquality().equals(
                  other.hostname,
                  hostname,
                )) &&
            (identical(other.externalHostname, externalHostname) ||
                const DeepCollectionEquality().equals(
                  other.externalHostname,
                  externalHostname,
                )) &&
            (identical(
                  other.jellyfinForgotPasswordUrl,
                  jellyfinForgotPasswordUrl,
                ) ||
                const DeepCollectionEquality().equals(
                  other.jellyfinForgotPasswordUrl,
                  jellyfinForgotPasswordUrl,
                )) &&
            (identical(other.adminUser, adminUser) ||
                const DeepCollectionEquality().equals(
                  other.adminUser,
                  adminUser,
                )) &&
            (identical(other.adminPass, adminPass) ||
                const DeepCollectionEquality().equals(
                  other.adminPass,
                  adminPass,
                )) &&
            (identical(other.libraries, libraries) ||
                const DeepCollectionEquality().equals(
                  other.libraries,
                  libraries,
                )) &&
            (identical(other.serverID, serverID) ||
                const DeepCollectionEquality().equals(
                  other.serverID,
                  serverID,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(hostname) ^
      const DeepCollectionEquality().hash(externalHostname) ^
      const DeepCollectionEquality().hash(jellyfinForgotPasswordUrl) ^
      const DeepCollectionEquality().hash(adminUser) ^
      const DeepCollectionEquality().hash(adminPass) ^
      const DeepCollectionEquality().hash(libraries) ^
      const DeepCollectionEquality().hash(serverID) ^
      runtimeType.hashCode;
}

extension $JellyfinSettingsExtension on JellyfinSettings {
  JellyfinSettings copyWith({
    String? name,
    String? hostname,
    String? externalHostname,
    String? jellyfinForgotPasswordUrl,
    String? adminUser,
    String? adminPass,
    List<JellyfinLibrary>? libraries,
    String? serverID,
  }) {
    return JellyfinSettings(
      name: name ?? this.name,
      hostname: hostname ?? this.hostname,
      externalHostname: externalHostname ?? this.externalHostname,
      jellyfinForgotPasswordUrl:
          jellyfinForgotPasswordUrl ?? this.jellyfinForgotPasswordUrl,
      adminUser: adminUser ?? this.adminUser,
      adminPass: adminPass ?? this.adminPass,
      libraries: libraries ?? this.libraries,
      serverID: serverID ?? this.serverID,
    );
  }

  JellyfinSettings copyWithWrapped({
    Wrapped<String?>? name,
    Wrapped<String?>? hostname,
    Wrapped<String?>? externalHostname,
    Wrapped<String?>? jellyfinForgotPasswordUrl,
    Wrapped<String?>? adminUser,
    Wrapped<String?>? adminPass,
    Wrapped<List<JellyfinLibrary>?>? libraries,
    Wrapped<String?>? serverID,
  }) {
    return JellyfinSettings(
      name: (name != null ? name.value : this.name),
      hostname: (hostname != null ? hostname.value : this.hostname),
      externalHostname: (externalHostname != null
          ? externalHostname.value
          : this.externalHostname),
      jellyfinForgotPasswordUrl: (jellyfinForgotPasswordUrl != null
          ? jellyfinForgotPasswordUrl.value
          : this.jellyfinForgotPasswordUrl),
      adminUser: (adminUser != null ? adminUser.value : this.adminUser),
      adminPass: (adminPass != null ? adminPass.value : this.adminPass),
      libraries: (libraries != null ? libraries.value : this.libraries),
      serverID: (serverID != null ? serverID.value : this.serverID),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class MetadataSettings {
  const MetadataSettings({this.settings});

  factory MetadataSettings.fromJson(Map<String, dynamic> json) =>
      _$MetadataSettingsFromJson(json);

  static const toJsonFactory = _$MetadataSettingsToJson;
  Map<String, dynamic> toJson() => _$MetadataSettingsToJson(this);

  @JsonKey(name: 'settings', includeIfNull: false)
  final MetadataSettings$Settings? settings;
  static const fromJsonFactory = _$MetadataSettingsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MetadataSettings &&
            (identical(other.settings, settings) ||
                const DeepCollectionEquality().equals(
                  other.settings,
                  settings,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(settings) ^ runtimeType.hashCode;
}

extension $MetadataSettingsExtension on MetadataSettings {
  MetadataSettings copyWith({MetadataSettings$Settings? settings}) {
    return MetadataSettings(settings: settings ?? this.settings);
  }

  MetadataSettings copyWithWrapped({
    Wrapped<MetadataSettings$Settings?>? settings,
  }) {
    return MetadataSettings(
      settings: (settings != null ? settings.value : this.settings),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TautulliSettings {
  const TautulliSettings({
    this.hostname,
    this.port,
    this.useSsl,
    this.apiKey,
    this.externalUrl,
  });

  factory TautulliSettings.fromJson(Map<String, dynamic> json) =>
      _$TautulliSettingsFromJson(json);

  static const toJsonFactory = _$TautulliSettingsToJson;
  Map<String, dynamic> toJson() => _$TautulliSettingsToJson(this);

  @JsonKey(name: 'hostname', includeIfNull: false)
  final String? hostname;
  @JsonKey(name: 'port', includeIfNull: false)
  final double? port;
  @JsonKey(name: 'useSsl', includeIfNull: false)
  final bool? useSsl;
  @JsonKey(name: 'apiKey', includeIfNull: false)
  final String? apiKey;
  @JsonKey(name: 'externalUrl', includeIfNull: false)
  final String? externalUrl;
  static const fromJsonFactory = _$TautulliSettingsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TautulliSettings &&
            (identical(other.hostname, hostname) ||
                const DeepCollectionEquality().equals(
                  other.hostname,
                  hostname,
                )) &&
            (identical(other.port, port) ||
                const DeepCollectionEquality().equals(other.port, port)) &&
            (identical(other.useSsl, useSsl) ||
                const DeepCollectionEquality().equals(other.useSsl, useSsl)) &&
            (identical(other.apiKey, apiKey) ||
                const DeepCollectionEquality().equals(other.apiKey, apiKey)) &&
            (identical(other.externalUrl, externalUrl) ||
                const DeepCollectionEquality().equals(
                  other.externalUrl,
                  externalUrl,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(hostname) ^
      const DeepCollectionEquality().hash(port) ^
      const DeepCollectionEquality().hash(useSsl) ^
      const DeepCollectionEquality().hash(apiKey) ^
      const DeepCollectionEquality().hash(externalUrl) ^
      runtimeType.hashCode;
}

extension $TautulliSettingsExtension on TautulliSettings {
  TautulliSettings copyWith({
    String? hostname,
    double? port,
    bool? useSsl,
    String? apiKey,
    String? externalUrl,
  }) {
    return TautulliSettings(
      hostname: hostname ?? this.hostname,
      port: port ?? this.port,
      useSsl: useSsl ?? this.useSsl,
      apiKey: apiKey ?? this.apiKey,
      externalUrl: externalUrl ?? this.externalUrl,
    );
  }

  TautulliSettings copyWithWrapped({
    Wrapped<String?>? hostname,
    Wrapped<double?>? port,
    Wrapped<bool?>? useSsl,
    Wrapped<String?>? apiKey,
    Wrapped<String?>? externalUrl,
  }) {
    return TautulliSettings(
      hostname: (hostname != null ? hostname.value : this.hostname),
      port: (port != null ? port.value : this.port),
      useSsl: (useSsl != null ? useSsl.value : this.useSsl),
      apiKey: (apiKey != null ? apiKey.value : this.apiKey),
      externalUrl: (externalUrl != null ? externalUrl.value : this.externalUrl),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RadarrSettings {
  const RadarrSettings({
    this.id,
    required this.name,
    required this.hostname,
    required this.port,
    required this.apiKey,
    required this.useSsl,
    this.baseUrl,
    required this.activeProfileId,
    required this.activeProfileName,
    required this.activeDirectory,
    required this.is4k,
    required this.minimumAvailability,
    required this.isDefault,
    this.externalUrl,
    this.syncEnabled,
    this.preventSearch,
  });

  factory RadarrSettings.fromJson(Map<String, dynamic> json) =>
      _$RadarrSettingsFromJson(json);

  static const toJsonFactory = _$RadarrSettingsToJson;
  Map<String, dynamic> toJson() => _$RadarrSettingsToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final double? id;
  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  @JsonKey(name: 'hostname', includeIfNull: false)
  final String hostname;
  @JsonKey(name: 'port', includeIfNull: false)
  final double port;
  @JsonKey(name: 'apiKey', includeIfNull: false)
  final String apiKey;
  @JsonKey(name: 'useSsl', includeIfNull: false)
  final bool useSsl;
  @JsonKey(name: 'baseUrl', includeIfNull: false)
  final String? baseUrl;
  @JsonKey(name: 'activeProfileId', includeIfNull: false)
  final double activeProfileId;
  @JsonKey(name: 'activeProfileName', includeIfNull: false)
  final String activeProfileName;
  @JsonKey(name: 'activeDirectory', includeIfNull: false)
  final String activeDirectory;
  @JsonKey(name: 'is4k', includeIfNull: false)
  final bool is4k;
  @JsonKey(name: 'minimumAvailability', includeIfNull: false)
  final String minimumAvailability;
  @JsonKey(name: 'isDefault', includeIfNull: false)
  final bool isDefault;
  @JsonKey(name: 'externalUrl', includeIfNull: false)
  final String? externalUrl;
  @JsonKey(name: 'syncEnabled', includeIfNull: false)
  final bool? syncEnabled;
  @JsonKey(name: 'preventSearch', includeIfNull: false)
  final bool? preventSearch;
  static const fromJsonFactory = _$RadarrSettingsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is RadarrSettings &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.hostname, hostname) ||
                const DeepCollectionEquality().equals(
                  other.hostname,
                  hostname,
                )) &&
            (identical(other.port, port) ||
                const DeepCollectionEquality().equals(other.port, port)) &&
            (identical(other.apiKey, apiKey) ||
                const DeepCollectionEquality().equals(other.apiKey, apiKey)) &&
            (identical(other.useSsl, useSsl) ||
                const DeepCollectionEquality().equals(other.useSsl, useSsl)) &&
            (identical(other.baseUrl, baseUrl) ||
                const DeepCollectionEquality().equals(
                  other.baseUrl,
                  baseUrl,
                )) &&
            (identical(other.activeProfileId, activeProfileId) ||
                const DeepCollectionEquality().equals(
                  other.activeProfileId,
                  activeProfileId,
                )) &&
            (identical(other.activeProfileName, activeProfileName) ||
                const DeepCollectionEquality().equals(
                  other.activeProfileName,
                  activeProfileName,
                )) &&
            (identical(other.activeDirectory, activeDirectory) ||
                const DeepCollectionEquality().equals(
                  other.activeDirectory,
                  activeDirectory,
                )) &&
            (identical(other.is4k, is4k) ||
                const DeepCollectionEquality().equals(other.is4k, is4k)) &&
            (identical(other.minimumAvailability, minimumAvailability) ||
                const DeepCollectionEquality().equals(
                  other.minimumAvailability,
                  minimumAvailability,
                )) &&
            (identical(other.isDefault, isDefault) ||
                const DeepCollectionEquality().equals(
                  other.isDefault,
                  isDefault,
                )) &&
            (identical(other.externalUrl, externalUrl) ||
                const DeepCollectionEquality().equals(
                  other.externalUrl,
                  externalUrl,
                )) &&
            (identical(other.syncEnabled, syncEnabled) ||
                const DeepCollectionEquality().equals(
                  other.syncEnabled,
                  syncEnabled,
                )) &&
            (identical(other.preventSearch, preventSearch) ||
                const DeepCollectionEquality().equals(
                  other.preventSearch,
                  preventSearch,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(hostname) ^
      const DeepCollectionEquality().hash(port) ^
      const DeepCollectionEquality().hash(apiKey) ^
      const DeepCollectionEquality().hash(useSsl) ^
      const DeepCollectionEquality().hash(baseUrl) ^
      const DeepCollectionEquality().hash(activeProfileId) ^
      const DeepCollectionEquality().hash(activeProfileName) ^
      const DeepCollectionEquality().hash(activeDirectory) ^
      const DeepCollectionEquality().hash(is4k) ^
      const DeepCollectionEquality().hash(minimumAvailability) ^
      const DeepCollectionEquality().hash(isDefault) ^
      const DeepCollectionEquality().hash(externalUrl) ^
      const DeepCollectionEquality().hash(syncEnabled) ^
      const DeepCollectionEquality().hash(preventSearch) ^
      runtimeType.hashCode;
}

extension $RadarrSettingsExtension on RadarrSettings {
  RadarrSettings copyWith({
    double? id,
    String? name,
    String? hostname,
    double? port,
    String? apiKey,
    bool? useSsl,
    String? baseUrl,
    double? activeProfileId,
    String? activeProfileName,
    String? activeDirectory,
    bool? is4k,
    String? minimumAvailability,
    bool? isDefault,
    String? externalUrl,
    bool? syncEnabled,
    bool? preventSearch,
  }) {
    return RadarrSettings(
      id: id ?? this.id,
      name: name ?? this.name,
      hostname: hostname ?? this.hostname,
      port: port ?? this.port,
      apiKey: apiKey ?? this.apiKey,
      useSsl: useSsl ?? this.useSsl,
      baseUrl: baseUrl ?? this.baseUrl,
      activeProfileId: activeProfileId ?? this.activeProfileId,
      activeProfileName: activeProfileName ?? this.activeProfileName,
      activeDirectory: activeDirectory ?? this.activeDirectory,
      is4k: is4k ?? this.is4k,
      minimumAvailability: minimumAvailability ?? this.minimumAvailability,
      isDefault: isDefault ?? this.isDefault,
      externalUrl: externalUrl ?? this.externalUrl,
      syncEnabled: syncEnabled ?? this.syncEnabled,
      preventSearch: preventSearch ?? this.preventSearch,
    );
  }

  RadarrSettings copyWithWrapped({
    Wrapped<double?>? id,
    Wrapped<String>? name,
    Wrapped<String>? hostname,
    Wrapped<double>? port,
    Wrapped<String>? apiKey,
    Wrapped<bool>? useSsl,
    Wrapped<String?>? baseUrl,
    Wrapped<double>? activeProfileId,
    Wrapped<String>? activeProfileName,
    Wrapped<String>? activeDirectory,
    Wrapped<bool>? is4k,
    Wrapped<String>? minimumAvailability,
    Wrapped<bool>? isDefault,
    Wrapped<String?>? externalUrl,
    Wrapped<bool?>? syncEnabled,
    Wrapped<bool?>? preventSearch,
  }) {
    return RadarrSettings(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
      hostname: (hostname != null ? hostname.value : this.hostname),
      port: (port != null ? port.value : this.port),
      apiKey: (apiKey != null ? apiKey.value : this.apiKey),
      useSsl: (useSsl != null ? useSsl.value : this.useSsl),
      baseUrl: (baseUrl != null ? baseUrl.value : this.baseUrl),
      activeProfileId: (activeProfileId != null
          ? activeProfileId.value
          : this.activeProfileId),
      activeProfileName: (activeProfileName != null
          ? activeProfileName.value
          : this.activeProfileName),
      activeDirectory: (activeDirectory != null
          ? activeDirectory.value
          : this.activeDirectory),
      is4k: (is4k != null ? is4k.value : this.is4k),
      minimumAvailability: (minimumAvailability != null
          ? minimumAvailability.value
          : this.minimumAvailability),
      isDefault: (isDefault != null ? isDefault.value : this.isDefault),
      externalUrl: (externalUrl != null ? externalUrl.value : this.externalUrl),
      syncEnabled: (syncEnabled != null ? syncEnabled.value : this.syncEnabled),
      preventSearch: (preventSearch != null
          ? preventSearch.value
          : this.preventSearch),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SonarrSettings {
  const SonarrSettings({
    this.id,
    required this.name,
    required this.hostname,
    required this.port,
    required this.apiKey,
    required this.useSsl,
    this.baseUrl,
    required this.activeProfileId,
    required this.activeProfileName,
    required this.activeDirectory,
    this.activeLanguageProfileId,
    this.activeAnimeProfileId,
    this.activeAnimeLanguageProfileId,
    this.activeAnimeProfileName,
    this.activeAnimeDirectory,
    required this.is4k,
    required this.enableSeasonFolders,
    required this.isDefault,
    this.externalUrl,
    this.syncEnabled,
    this.preventSearch,
  });

  factory SonarrSettings.fromJson(Map<String, dynamic> json) =>
      _$SonarrSettingsFromJson(json);

  static const toJsonFactory = _$SonarrSettingsToJson;
  Map<String, dynamic> toJson() => _$SonarrSettingsToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final double? id;
  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  @JsonKey(name: 'hostname', includeIfNull: false)
  final String hostname;
  @JsonKey(name: 'port', includeIfNull: false)
  final double port;
  @JsonKey(name: 'apiKey', includeIfNull: false)
  final String apiKey;
  @JsonKey(name: 'useSsl', includeIfNull: false)
  final bool useSsl;
  @JsonKey(name: 'baseUrl', includeIfNull: false)
  final String? baseUrl;
  @JsonKey(name: 'activeProfileId', includeIfNull: false)
  final double activeProfileId;
  @JsonKey(name: 'activeProfileName', includeIfNull: false)
  final String activeProfileName;
  @JsonKey(name: 'activeDirectory', includeIfNull: false)
  final String activeDirectory;
  @JsonKey(name: 'activeLanguageProfileId', includeIfNull: false)
  final double? activeLanguageProfileId;
  @JsonKey(name: 'activeAnimeProfileId', includeIfNull: false)
  final double? activeAnimeProfileId;
  @JsonKey(name: 'activeAnimeLanguageProfileId', includeIfNull: false)
  final double? activeAnimeLanguageProfileId;
  @JsonKey(name: 'activeAnimeProfileName', includeIfNull: false)
  final String? activeAnimeProfileName;
  @JsonKey(name: 'activeAnimeDirectory', includeIfNull: false)
  final String? activeAnimeDirectory;
  @JsonKey(name: 'is4k', includeIfNull: false)
  final bool is4k;
  @JsonKey(name: 'enableSeasonFolders', includeIfNull: false)
  final bool enableSeasonFolders;
  @JsonKey(name: 'isDefault', includeIfNull: false)
  final bool isDefault;
  @JsonKey(name: 'externalUrl', includeIfNull: false)
  final String? externalUrl;
  @JsonKey(name: 'syncEnabled', includeIfNull: false)
  final bool? syncEnabled;
  @JsonKey(name: 'preventSearch', includeIfNull: false)
  final bool? preventSearch;
  static const fromJsonFactory = _$SonarrSettingsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SonarrSettings &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.hostname, hostname) ||
                const DeepCollectionEquality().equals(
                  other.hostname,
                  hostname,
                )) &&
            (identical(other.port, port) ||
                const DeepCollectionEquality().equals(other.port, port)) &&
            (identical(other.apiKey, apiKey) ||
                const DeepCollectionEquality().equals(other.apiKey, apiKey)) &&
            (identical(other.useSsl, useSsl) ||
                const DeepCollectionEquality().equals(other.useSsl, useSsl)) &&
            (identical(other.baseUrl, baseUrl) ||
                const DeepCollectionEquality().equals(
                  other.baseUrl,
                  baseUrl,
                )) &&
            (identical(other.activeProfileId, activeProfileId) ||
                const DeepCollectionEquality().equals(
                  other.activeProfileId,
                  activeProfileId,
                )) &&
            (identical(other.activeProfileName, activeProfileName) ||
                const DeepCollectionEquality().equals(
                  other.activeProfileName,
                  activeProfileName,
                )) &&
            (identical(other.activeDirectory, activeDirectory) ||
                const DeepCollectionEquality().equals(
                  other.activeDirectory,
                  activeDirectory,
                )) &&
            (identical(
                  other.activeLanguageProfileId,
                  activeLanguageProfileId,
                ) ||
                const DeepCollectionEquality().equals(
                  other.activeLanguageProfileId,
                  activeLanguageProfileId,
                )) &&
            (identical(other.activeAnimeProfileId, activeAnimeProfileId) ||
                const DeepCollectionEquality().equals(
                  other.activeAnimeProfileId,
                  activeAnimeProfileId,
                )) &&
            (identical(
                  other.activeAnimeLanguageProfileId,
                  activeAnimeLanguageProfileId,
                ) ||
                const DeepCollectionEquality().equals(
                  other.activeAnimeLanguageProfileId,
                  activeAnimeLanguageProfileId,
                )) &&
            (identical(other.activeAnimeProfileName, activeAnimeProfileName) ||
                const DeepCollectionEquality().equals(
                  other.activeAnimeProfileName,
                  activeAnimeProfileName,
                )) &&
            (identical(other.activeAnimeDirectory, activeAnimeDirectory) ||
                const DeepCollectionEquality().equals(
                  other.activeAnimeDirectory,
                  activeAnimeDirectory,
                )) &&
            (identical(other.is4k, is4k) ||
                const DeepCollectionEquality().equals(other.is4k, is4k)) &&
            (identical(other.enableSeasonFolders, enableSeasonFolders) ||
                const DeepCollectionEquality().equals(
                  other.enableSeasonFolders,
                  enableSeasonFolders,
                )) &&
            (identical(other.isDefault, isDefault) ||
                const DeepCollectionEquality().equals(
                  other.isDefault,
                  isDefault,
                )) &&
            (identical(other.externalUrl, externalUrl) ||
                const DeepCollectionEquality().equals(
                  other.externalUrl,
                  externalUrl,
                )) &&
            (identical(other.syncEnabled, syncEnabled) ||
                const DeepCollectionEquality().equals(
                  other.syncEnabled,
                  syncEnabled,
                )) &&
            (identical(other.preventSearch, preventSearch) ||
                const DeepCollectionEquality().equals(
                  other.preventSearch,
                  preventSearch,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(hostname) ^
      const DeepCollectionEquality().hash(port) ^
      const DeepCollectionEquality().hash(apiKey) ^
      const DeepCollectionEquality().hash(useSsl) ^
      const DeepCollectionEquality().hash(baseUrl) ^
      const DeepCollectionEquality().hash(activeProfileId) ^
      const DeepCollectionEquality().hash(activeProfileName) ^
      const DeepCollectionEquality().hash(activeDirectory) ^
      const DeepCollectionEquality().hash(activeLanguageProfileId) ^
      const DeepCollectionEquality().hash(activeAnimeProfileId) ^
      const DeepCollectionEquality().hash(activeAnimeLanguageProfileId) ^
      const DeepCollectionEquality().hash(activeAnimeProfileName) ^
      const DeepCollectionEquality().hash(activeAnimeDirectory) ^
      const DeepCollectionEquality().hash(is4k) ^
      const DeepCollectionEquality().hash(enableSeasonFolders) ^
      const DeepCollectionEquality().hash(isDefault) ^
      const DeepCollectionEquality().hash(externalUrl) ^
      const DeepCollectionEquality().hash(syncEnabled) ^
      const DeepCollectionEquality().hash(preventSearch) ^
      runtimeType.hashCode;
}

extension $SonarrSettingsExtension on SonarrSettings {
  SonarrSettings copyWith({
    double? id,
    String? name,
    String? hostname,
    double? port,
    String? apiKey,
    bool? useSsl,
    String? baseUrl,
    double? activeProfileId,
    String? activeProfileName,
    String? activeDirectory,
    double? activeLanguageProfileId,
    double? activeAnimeProfileId,
    double? activeAnimeLanguageProfileId,
    String? activeAnimeProfileName,
    String? activeAnimeDirectory,
    bool? is4k,
    bool? enableSeasonFolders,
    bool? isDefault,
    String? externalUrl,
    bool? syncEnabled,
    bool? preventSearch,
  }) {
    return SonarrSettings(
      id: id ?? this.id,
      name: name ?? this.name,
      hostname: hostname ?? this.hostname,
      port: port ?? this.port,
      apiKey: apiKey ?? this.apiKey,
      useSsl: useSsl ?? this.useSsl,
      baseUrl: baseUrl ?? this.baseUrl,
      activeProfileId: activeProfileId ?? this.activeProfileId,
      activeProfileName: activeProfileName ?? this.activeProfileName,
      activeDirectory: activeDirectory ?? this.activeDirectory,
      activeLanguageProfileId:
          activeLanguageProfileId ?? this.activeLanguageProfileId,
      activeAnimeProfileId: activeAnimeProfileId ?? this.activeAnimeProfileId,
      activeAnimeLanguageProfileId:
          activeAnimeLanguageProfileId ?? this.activeAnimeLanguageProfileId,
      activeAnimeProfileName:
          activeAnimeProfileName ?? this.activeAnimeProfileName,
      activeAnimeDirectory: activeAnimeDirectory ?? this.activeAnimeDirectory,
      is4k: is4k ?? this.is4k,
      enableSeasonFolders: enableSeasonFolders ?? this.enableSeasonFolders,
      isDefault: isDefault ?? this.isDefault,
      externalUrl: externalUrl ?? this.externalUrl,
      syncEnabled: syncEnabled ?? this.syncEnabled,
      preventSearch: preventSearch ?? this.preventSearch,
    );
  }

  SonarrSettings copyWithWrapped({
    Wrapped<double?>? id,
    Wrapped<String>? name,
    Wrapped<String>? hostname,
    Wrapped<double>? port,
    Wrapped<String>? apiKey,
    Wrapped<bool>? useSsl,
    Wrapped<String?>? baseUrl,
    Wrapped<double>? activeProfileId,
    Wrapped<String>? activeProfileName,
    Wrapped<String>? activeDirectory,
    Wrapped<double?>? activeLanguageProfileId,
    Wrapped<double?>? activeAnimeProfileId,
    Wrapped<double?>? activeAnimeLanguageProfileId,
    Wrapped<String?>? activeAnimeProfileName,
    Wrapped<String?>? activeAnimeDirectory,
    Wrapped<bool>? is4k,
    Wrapped<bool>? enableSeasonFolders,
    Wrapped<bool>? isDefault,
    Wrapped<String?>? externalUrl,
    Wrapped<bool?>? syncEnabled,
    Wrapped<bool?>? preventSearch,
  }) {
    return SonarrSettings(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
      hostname: (hostname != null ? hostname.value : this.hostname),
      port: (port != null ? port.value : this.port),
      apiKey: (apiKey != null ? apiKey.value : this.apiKey),
      useSsl: (useSsl != null ? useSsl.value : this.useSsl),
      baseUrl: (baseUrl != null ? baseUrl.value : this.baseUrl),
      activeProfileId: (activeProfileId != null
          ? activeProfileId.value
          : this.activeProfileId),
      activeProfileName: (activeProfileName != null
          ? activeProfileName.value
          : this.activeProfileName),
      activeDirectory: (activeDirectory != null
          ? activeDirectory.value
          : this.activeDirectory),
      activeLanguageProfileId: (activeLanguageProfileId != null
          ? activeLanguageProfileId.value
          : this.activeLanguageProfileId),
      activeAnimeProfileId: (activeAnimeProfileId != null
          ? activeAnimeProfileId.value
          : this.activeAnimeProfileId),
      activeAnimeLanguageProfileId: (activeAnimeLanguageProfileId != null
          ? activeAnimeLanguageProfileId.value
          : this.activeAnimeLanguageProfileId),
      activeAnimeProfileName: (activeAnimeProfileName != null
          ? activeAnimeProfileName.value
          : this.activeAnimeProfileName),
      activeAnimeDirectory: (activeAnimeDirectory != null
          ? activeAnimeDirectory.value
          : this.activeAnimeDirectory),
      is4k: (is4k != null ? is4k.value : this.is4k),
      enableSeasonFolders: (enableSeasonFolders != null
          ? enableSeasonFolders.value
          : this.enableSeasonFolders),
      isDefault: (isDefault != null ? isDefault.value : this.isDefault),
      externalUrl: (externalUrl != null ? externalUrl.value : this.externalUrl),
      syncEnabled: (syncEnabled != null ? syncEnabled.value : this.syncEnabled),
      preventSearch: (preventSearch != null
          ? preventSearch.value
          : this.preventSearch),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ServarrTag {
  const ServarrTag({this.id, this.label});

  factory ServarrTag.fromJson(Map<String, dynamic> json) =>
      _$ServarrTagFromJson(json);

  static const toJsonFactory = _$ServarrTagToJson;
  Map<String, dynamic> toJson() => _$ServarrTagToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final double? id;
  @JsonKey(name: 'label', includeIfNull: false)
  final String? label;
  static const fromJsonFactory = _$ServarrTagFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ServarrTag &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(label) ^
      runtimeType.hashCode;
}

extension $ServarrTagExtension on ServarrTag {
  ServarrTag copyWith({double? id, String? label}) {
    return ServarrTag(id: id ?? this.id, label: label ?? this.label);
  }

  ServarrTag copyWithWrapped({Wrapped<double?>? id, Wrapped<String?>? label}) {
    return ServarrTag(
      id: (id != null ? id.value : this.id),
      label: (label != null ? label.value : this.label),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PublicSettings {
  const PublicSettings({this.initialized});

  factory PublicSettings.fromJson(Map<String, dynamic> json) =>
      _$PublicSettingsFromJson(json);

  static const toJsonFactory = _$PublicSettingsToJson;
  Map<String, dynamic> toJson() => _$PublicSettingsToJson(this);

  @JsonKey(name: 'initialized', includeIfNull: false)
  final bool? initialized;
  static const fromJsonFactory = _$PublicSettingsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PublicSettings &&
            (identical(other.initialized, initialized) ||
                const DeepCollectionEquality().equals(
                  other.initialized,
                  initialized,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(initialized) ^ runtimeType.hashCode;
}

extension $PublicSettingsExtension on PublicSettings {
  PublicSettings copyWith({bool? initialized}) {
    return PublicSettings(initialized: initialized ?? this.initialized);
  }

  PublicSettings copyWithWrapped({Wrapped<bool?>? initialized}) {
    return PublicSettings(
      initialized: (initialized != null ? initialized.value : this.initialized),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class MovieResult {
  const MovieResult({
    required this.id,
    required this.mediaType,
    this.popularity,
    this.posterPath,
    this.backdropPath,
    this.voteCount,
    this.voteAverage,
    this.genreIds,
    this.overview,
    this.originalLanguage,
    required this.title,
    this.originalTitle,
    this.releaseDate,
    this.adult,
    this.video,
    this.mediaInfo,
  });

  factory MovieResult.fromJson(Map<String, dynamic> json) =>
      _$MovieResultFromJson(json);

  static const toJsonFactory = _$MovieResultToJson;
  Map<String, dynamic> toJson() => _$MovieResultToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final double id;
  @JsonKey(name: 'mediaType', includeIfNull: false)
  final String mediaType;
  @JsonKey(name: 'popularity', includeIfNull: false)
  final double? popularity;
  @JsonKey(name: 'posterPath', includeIfNull: false)
  final String? posterPath;
  @JsonKey(name: 'backdropPath', includeIfNull: false)
  final String? backdropPath;
  @JsonKey(name: 'voteCount', includeIfNull: false)
  final double? voteCount;
  @JsonKey(name: 'voteAverage', includeIfNull: false)
  final double? voteAverage;
  @JsonKey(name: 'genreIds', includeIfNull: false, defaultValue: <double>[])
  final List<double>? genreIds;
  @JsonKey(name: 'overview', includeIfNull: false)
  final String? overview;
  @JsonKey(name: 'originalLanguage', includeIfNull: false)
  final String? originalLanguage;
  @JsonKey(name: 'title', includeIfNull: false)
  final String title;
  @JsonKey(name: 'originalTitle', includeIfNull: false)
  final String? originalTitle;
  @JsonKey(name: 'releaseDate', includeIfNull: false)
  final String? releaseDate;
  @JsonKey(name: 'adult', includeIfNull: false)
  final bool? adult;
  @JsonKey(name: 'video', includeIfNull: false)
  final bool? video;
  @JsonKey(name: 'mediaInfo', includeIfNull: false)
  final MediaInfo? mediaInfo;
  static const fromJsonFactory = _$MovieResultFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MovieResult &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.mediaType, mediaType) ||
                const DeepCollectionEquality().equals(
                  other.mediaType,
                  mediaType,
                )) &&
            (identical(other.popularity, popularity) ||
                const DeepCollectionEquality().equals(
                  other.popularity,
                  popularity,
                )) &&
            (identical(other.posterPath, posterPath) ||
                const DeepCollectionEquality().equals(
                  other.posterPath,
                  posterPath,
                )) &&
            (identical(other.backdropPath, backdropPath) ||
                const DeepCollectionEquality().equals(
                  other.backdropPath,
                  backdropPath,
                )) &&
            (identical(other.voteCount, voteCount) ||
                const DeepCollectionEquality().equals(
                  other.voteCount,
                  voteCount,
                )) &&
            (identical(other.voteAverage, voteAverage) ||
                const DeepCollectionEquality().equals(
                  other.voteAverage,
                  voteAverage,
                )) &&
            (identical(other.genreIds, genreIds) ||
                const DeepCollectionEquality().equals(
                  other.genreIds,
                  genreIds,
                )) &&
            (identical(other.overview, overview) ||
                const DeepCollectionEquality().equals(
                  other.overview,
                  overview,
                )) &&
            (identical(other.originalLanguage, originalLanguage) ||
                const DeepCollectionEquality().equals(
                  other.originalLanguage,
                  originalLanguage,
                )) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.originalTitle, originalTitle) ||
                const DeepCollectionEquality().equals(
                  other.originalTitle,
                  originalTitle,
                )) &&
            (identical(other.releaseDate, releaseDate) ||
                const DeepCollectionEquality().equals(
                  other.releaseDate,
                  releaseDate,
                )) &&
            (identical(other.adult, adult) ||
                const DeepCollectionEquality().equals(other.adult, adult)) &&
            (identical(other.video, video) ||
                const DeepCollectionEquality().equals(other.video, video)) &&
            (identical(other.mediaInfo, mediaInfo) ||
                const DeepCollectionEquality().equals(
                  other.mediaInfo,
                  mediaInfo,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(mediaType) ^
      const DeepCollectionEquality().hash(popularity) ^
      const DeepCollectionEquality().hash(posterPath) ^
      const DeepCollectionEquality().hash(backdropPath) ^
      const DeepCollectionEquality().hash(voteCount) ^
      const DeepCollectionEquality().hash(voteAverage) ^
      const DeepCollectionEquality().hash(genreIds) ^
      const DeepCollectionEquality().hash(overview) ^
      const DeepCollectionEquality().hash(originalLanguage) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(originalTitle) ^
      const DeepCollectionEquality().hash(releaseDate) ^
      const DeepCollectionEquality().hash(adult) ^
      const DeepCollectionEquality().hash(video) ^
      const DeepCollectionEquality().hash(mediaInfo) ^
      runtimeType.hashCode;
}

extension $MovieResultExtension on MovieResult {
  MovieResult copyWith({
    double? id,
    String? mediaType,
    double? popularity,
    String? posterPath,
    String? backdropPath,
    double? voteCount,
    double? voteAverage,
    List<double>? genreIds,
    String? overview,
    String? originalLanguage,
    String? title,
    String? originalTitle,
    String? releaseDate,
    bool? adult,
    bool? video,
    MediaInfo? mediaInfo,
  }) {
    return MovieResult(
      id: id ?? this.id,
      mediaType: mediaType ?? this.mediaType,
      popularity: popularity ?? this.popularity,
      posterPath: posterPath ?? this.posterPath,
      backdropPath: backdropPath ?? this.backdropPath,
      voteCount: voteCount ?? this.voteCount,
      voteAverage: voteAverage ?? this.voteAverage,
      genreIds: genreIds ?? this.genreIds,
      overview: overview ?? this.overview,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      title: title ?? this.title,
      originalTitle: originalTitle ?? this.originalTitle,
      releaseDate: releaseDate ?? this.releaseDate,
      adult: adult ?? this.adult,
      video: video ?? this.video,
      mediaInfo: mediaInfo ?? this.mediaInfo,
    );
  }

  MovieResult copyWithWrapped({
    Wrapped<double>? id,
    Wrapped<String>? mediaType,
    Wrapped<double?>? popularity,
    Wrapped<String?>? posterPath,
    Wrapped<String?>? backdropPath,
    Wrapped<double?>? voteCount,
    Wrapped<double?>? voteAverage,
    Wrapped<List<double>?>? genreIds,
    Wrapped<String?>? overview,
    Wrapped<String?>? originalLanguage,
    Wrapped<String>? title,
    Wrapped<String?>? originalTitle,
    Wrapped<String?>? releaseDate,
    Wrapped<bool?>? adult,
    Wrapped<bool?>? video,
    Wrapped<MediaInfo?>? mediaInfo,
  }) {
    return MovieResult(
      id: (id != null ? id.value : this.id),
      mediaType: (mediaType != null ? mediaType.value : this.mediaType),
      popularity: (popularity != null ? popularity.value : this.popularity),
      posterPath: (posterPath != null ? posterPath.value : this.posterPath),
      backdropPath: (backdropPath != null
          ? backdropPath.value
          : this.backdropPath),
      voteCount: (voteCount != null ? voteCount.value : this.voteCount),
      voteAverage: (voteAverage != null ? voteAverage.value : this.voteAverage),
      genreIds: (genreIds != null ? genreIds.value : this.genreIds),
      overview: (overview != null ? overview.value : this.overview),
      originalLanguage: (originalLanguage != null
          ? originalLanguage.value
          : this.originalLanguage),
      title: (title != null ? title.value : this.title),
      originalTitle: (originalTitle != null
          ? originalTitle.value
          : this.originalTitle),
      releaseDate: (releaseDate != null ? releaseDate.value : this.releaseDate),
      adult: (adult != null ? adult.value : this.adult),
      video: (video != null ? video.value : this.video),
      mediaInfo: (mediaInfo != null ? mediaInfo.value : this.mediaInfo),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TvResult {
  const TvResult({
    this.id,
    this.mediaType,
    this.popularity,
    this.posterPath,
    this.backdropPath,
    this.voteCount,
    this.voteAverage,
    this.genreIds,
    this.overview,
    this.originalLanguage,
    this.name,
    this.originalName,
    this.originCountry,
    this.firstAirDate,
    this.mediaInfo,
  });

  factory TvResult.fromJson(Map<String, dynamic> json) =>
      _$TvResultFromJson(json);

  static const toJsonFactory = _$TvResultToJson;
  Map<String, dynamic> toJson() => _$TvResultToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final double? id;
  @JsonKey(name: 'mediaType', includeIfNull: false)
  final String? mediaType;
  @JsonKey(name: 'popularity', includeIfNull: false)
  final double? popularity;
  @JsonKey(name: 'posterPath', includeIfNull: false)
  final String? posterPath;
  @JsonKey(name: 'backdropPath', includeIfNull: false)
  final String? backdropPath;
  @JsonKey(name: 'voteCount', includeIfNull: false)
  final double? voteCount;
  @JsonKey(name: 'voteAverage', includeIfNull: false)
  final double? voteAverage;
  @JsonKey(name: 'genreIds', includeIfNull: false, defaultValue: <double>[])
  final List<double>? genreIds;
  @JsonKey(name: 'overview', includeIfNull: false)
  final String? overview;
  @JsonKey(name: 'originalLanguage', includeIfNull: false)
  final String? originalLanguage;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(name: 'originalName', includeIfNull: false)
  final String? originalName;
  @JsonKey(
    name: 'originCountry',
    includeIfNull: false,
    defaultValue: <String>[],
  )
  final List<String>? originCountry;
  @JsonKey(name: 'firstAirDate', includeIfNull: false)
  final String? firstAirDate;
  @JsonKey(name: 'mediaInfo', includeIfNull: false)
  final MediaInfo? mediaInfo;
  static const fromJsonFactory = _$TvResultFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TvResult &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.mediaType, mediaType) ||
                const DeepCollectionEquality().equals(
                  other.mediaType,
                  mediaType,
                )) &&
            (identical(other.popularity, popularity) ||
                const DeepCollectionEquality().equals(
                  other.popularity,
                  popularity,
                )) &&
            (identical(other.posterPath, posterPath) ||
                const DeepCollectionEquality().equals(
                  other.posterPath,
                  posterPath,
                )) &&
            (identical(other.backdropPath, backdropPath) ||
                const DeepCollectionEquality().equals(
                  other.backdropPath,
                  backdropPath,
                )) &&
            (identical(other.voteCount, voteCount) ||
                const DeepCollectionEquality().equals(
                  other.voteCount,
                  voteCount,
                )) &&
            (identical(other.voteAverage, voteAverage) ||
                const DeepCollectionEquality().equals(
                  other.voteAverage,
                  voteAverage,
                )) &&
            (identical(other.genreIds, genreIds) ||
                const DeepCollectionEquality().equals(
                  other.genreIds,
                  genreIds,
                )) &&
            (identical(other.overview, overview) ||
                const DeepCollectionEquality().equals(
                  other.overview,
                  overview,
                )) &&
            (identical(other.originalLanguage, originalLanguage) ||
                const DeepCollectionEquality().equals(
                  other.originalLanguage,
                  originalLanguage,
                )) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.originalName, originalName) ||
                const DeepCollectionEquality().equals(
                  other.originalName,
                  originalName,
                )) &&
            (identical(other.originCountry, originCountry) ||
                const DeepCollectionEquality().equals(
                  other.originCountry,
                  originCountry,
                )) &&
            (identical(other.firstAirDate, firstAirDate) ||
                const DeepCollectionEquality().equals(
                  other.firstAirDate,
                  firstAirDate,
                )) &&
            (identical(other.mediaInfo, mediaInfo) ||
                const DeepCollectionEquality().equals(
                  other.mediaInfo,
                  mediaInfo,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(mediaType) ^
      const DeepCollectionEquality().hash(popularity) ^
      const DeepCollectionEquality().hash(posterPath) ^
      const DeepCollectionEquality().hash(backdropPath) ^
      const DeepCollectionEquality().hash(voteCount) ^
      const DeepCollectionEquality().hash(voteAverage) ^
      const DeepCollectionEquality().hash(genreIds) ^
      const DeepCollectionEquality().hash(overview) ^
      const DeepCollectionEquality().hash(originalLanguage) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(originalName) ^
      const DeepCollectionEquality().hash(originCountry) ^
      const DeepCollectionEquality().hash(firstAirDate) ^
      const DeepCollectionEquality().hash(mediaInfo) ^
      runtimeType.hashCode;
}

extension $TvResultExtension on TvResult {
  TvResult copyWith({
    double? id,
    String? mediaType,
    double? popularity,
    String? posterPath,
    String? backdropPath,
    double? voteCount,
    double? voteAverage,
    List<double>? genreIds,
    String? overview,
    String? originalLanguage,
    String? name,
    String? originalName,
    List<String>? originCountry,
    String? firstAirDate,
    MediaInfo? mediaInfo,
  }) {
    return TvResult(
      id: id ?? this.id,
      mediaType: mediaType ?? this.mediaType,
      popularity: popularity ?? this.popularity,
      posterPath: posterPath ?? this.posterPath,
      backdropPath: backdropPath ?? this.backdropPath,
      voteCount: voteCount ?? this.voteCount,
      voteAverage: voteAverage ?? this.voteAverage,
      genreIds: genreIds ?? this.genreIds,
      overview: overview ?? this.overview,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      name: name ?? this.name,
      originalName: originalName ?? this.originalName,
      originCountry: originCountry ?? this.originCountry,
      firstAirDate: firstAirDate ?? this.firstAirDate,
      mediaInfo: mediaInfo ?? this.mediaInfo,
    );
  }

  TvResult copyWithWrapped({
    Wrapped<double?>? id,
    Wrapped<String?>? mediaType,
    Wrapped<double?>? popularity,
    Wrapped<String?>? posterPath,
    Wrapped<String?>? backdropPath,
    Wrapped<double?>? voteCount,
    Wrapped<double?>? voteAverage,
    Wrapped<List<double>?>? genreIds,
    Wrapped<String?>? overview,
    Wrapped<String?>? originalLanguage,
    Wrapped<String?>? name,
    Wrapped<String?>? originalName,
    Wrapped<List<String>?>? originCountry,
    Wrapped<String?>? firstAirDate,
    Wrapped<MediaInfo?>? mediaInfo,
  }) {
    return TvResult(
      id: (id != null ? id.value : this.id),
      mediaType: (mediaType != null ? mediaType.value : this.mediaType),
      popularity: (popularity != null ? popularity.value : this.popularity),
      posterPath: (posterPath != null ? posterPath.value : this.posterPath),
      backdropPath: (backdropPath != null
          ? backdropPath.value
          : this.backdropPath),
      voteCount: (voteCount != null ? voteCount.value : this.voteCount),
      voteAverage: (voteAverage != null ? voteAverage.value : this.voteAverage),
      genreIds: (genreIds != null ? genreIds.value : this.genreIds),
      overview: (overview != null ? overview.value : this.overview),
      originalLanguage: (originalLanguage != null
          ? originalLanguage.value
          : this.originalLanguage),
      name: (name != null ? name.value : this.name),
      originalName: (originalName != null
          ? originalName.value
          : this.originalName),
      originCountry: (originCountry != null
          ? originCountry.value
          : this.originCountry),
      firstAirDate: (firstAirDate != null
          ? firstAirDate.value
          : this.firstAirDate),
      mediaInfo: (mediaInfo != null ? mediaInfo.value : this.mediaInfo),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PersonResult {
  const PersonResult({
    this.id,
    this.profilePath,
    this.adult,
    this.mediaType,
    this.knownFor,
  });

  factory PersonResult.fromJson(Map<String, dynamic> json) =>
      _$PersonResultFromJson(json);

  static const toJsonFactory = _$PersonResultToJson;
  Map<String, dynamic> toJson() => _$PersonResultToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final double? id;
  @JsonKey(name: 'profilePath', includeIfNull: false)
  final String? profilePath;
  @JsonKey(name: 'adult', includeIfNull: false)
  final bool? adult;
  @JsonKey(name: 'mediaType', includeIfNull: false)
  final String? mediaType;
  @JsonKey(name: 'knownFor', includeIfNull: false, defaultValue: <Object>[])
  final List<Object>? knownFor;
  static const fromJsonFactory = _$PersonResultFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PersonResult &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.profilePath, profilePath) ||
                const DeepCollectionEquality().equals(
                  other.profilePath,
                  profilePath,
                )) &&
            (identical(other.adult, adult) ||
                const DeepCollectionEquality().equals(other.adult, adult)) &&
            (identical(other.mediaType, mediaType) ||
                const DeepCollectionEquality().equals(
                  other.mediaType,
                  mediaType,
                )) &&
            (identical(other.knownFor, knownFor) ||
                const DeepCollectionEquality().equals(
                  other.knownFor,
                  knownFor,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(profilePath) ^
      const DeepCollectionEquality().hash(adult) ^
      const DeepCollectionEquality().hash(mediaType) ^
      const DeepCollectionEquality().hash(knownFor) ^
      runtimeType.hashCode;
}

extension $PersonResultExtension on PersonResult {
  PersonResult copyWith({
    double? id,
    String? profilePath,
    bool? adult,
    String? mediaType,
    List<Object>? knownFor,
  }) {
    return PersonResult(
      id: id ?? this.id,
      profilePath: profilePath ?? this.profilePath,
      adult: adult ?? this.adult,
      mediaType: mediaType ?? this.mediaType,
      knownFor: knownFor ?? this.knownFor,
    );
  }

  PersonResult copyWithWrapped({
    Wrapped<double?>? id,
    Wrapped<String?>? profilePath,
    Wrapped<bool?>? adult,
    Wrapped<String?>? mediaType,
    Wrapped<List<Object>?>? knownFor,
  }) {
    return PersonResult(
      id: (id != null ? id.value : this.id),
      profilePath: (profilePath != null ? profilePath.value : this.profilePath),
      adult: (adult != null ? adult.value : this.adult),
      mediaType: (mediaType != null ? mediaType.value : this.mediaType),
      knownFor: (knownFor != null ? knownFor.value : this.knownFor),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Genre {
  const Genre({this.id, this.name});

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);

  static const toJsonFactory = _$GenreToJson;
  Map<String, dynamic> toJson() => _$GenreToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final double? id;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  static const fromJsonFactory = _$GenreFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Genre &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      runtimeType.hashCode;
}

extension $GenreExtension on Genre {
  Genre copyWith({double? id, String? name}) {
    return Genre(id: id ?? this.id, name: name ?? this.name);
  }

  Genre copyWithWrapped({Wrapped<double?>? id, Wrapped<String?>? name}) {
    return Genre(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Company {
  const Company({this.id, this.logoPath, this.name});

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);

  static const toJsonFactory = _$CompanyToJson;
  Map<String, dynamic> toJson() => _$CompanyToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final double? id;
  @JsonKey(name: 'logo_path', includeIfNull: false)
  final String? logoPath;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  static const fromJsonFactory = _$CompanyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Company &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.logoPath, logoPath) ||
                const DeepCollectionEquality().equals(
                  other.logoPath,
                  logoPath,
                )) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(logoPath) ^
      const DeepCollectionEquality().hash(name) ^
      runtimeType.hashCode;
}

extension $CompanyExtension on Company {
  Company copyWith({double? id, String? logoPath, String? name}) {
    return Company(
      id: id ?? this.id,
      logoPath: logoPath ?? this.logoPath,
      name: name ?? this.name,
    );
  }

  Company copyWithWrapped({
    Wrapped<double?>? id,
    Wrapped<String?>? logoPath,
    Wrapped<String?>? name,
  }) {
    return Company(
      id: (id != null ? id.value : this.id),
      logoPath: (logoPath != null ? logoPath.value : this.logoPath),
      name: (name != null ? name.value : this.name),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ProductionCompany {
  const ProductionCompany({
    this.id,
    this.logoPath,
    this.originCountry,
    this.name,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompanyFromJson(json);

  static const toJsonFactory = _$ProductionCompanyToJson;
  Map<String, dynamic> toJson() => _$ProductionCompanyToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final double? id;
  @JsonKey(name: 'logoPath', includeIfNull: false)
  final String? logoPath;
  @JsonKey(name: 'originCountry', includeIfNull: false)
  final String? originCountry;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  static const fromJsonFactory = _$ProductionCompanyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ProductionCompany &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.logoPath, logoPath) ||
                const DeepCollectionEquality().equals(
                  other.logoPath,
                  logoPath,
                )) &&
            (identical(other.originCountry, originCountry) ||
                const DeepCollectionEquality().equals(
                  other.originCountry,
                  originCountry,
                )) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(logoPath) ^
      const DeepCollectionEquality().hash(originCountry) ^
      const DeepCollectionEquality().hash(name) ^
      runtimeType.hashCode;
}

extension $ProductionCompanyExtension on ProductionCompany {
  ProductionCompany copyWith({
    double? id,
    String? logoPath,
    String? originCountry,
    String? name,
  }) {
    return ProductionCompany(
      id: id ?? this.id,
      logoPath: logoPath ?? this.logoPath,
      originCountry: originCountry ?? this.originCountry,
      name: name ?? this.name,
    );
  }

  ProductionCompany copyWithWrapped({
    Wrapped<double?>? id,
    Wrapped<String?>? logoPath,
    Wrapped<String?>? originCountry,
    Wrapped<String?>? name,
  }) {
    return ProductionCompany(
      id: (id != null ? id.value : this.id),
      logoPath: (logoPath != null ? logoPath.value : this.logoPath),
      originCountry: (originCountry != null
          ? originCountry.value
          : this.originCountry),
      name: (name != null ? name.value : this.name),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Network {
  const Network({this.id, this.logoPath, this.originCountry, this.name});

  factory Network.fromJson(Map<String, dynamic> json) =>
      _$NetworkFromJson(json);

  static const toJsonFactory = _$NetworkToJson;
  Map<String, dynamic> toJson() => _$NetworkToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final double? id;
  @JsonKey(name: 'logoPath', includeIfNull: false)
  final String? logoPath;
  @JsonKey(name: 'originCountry', includeIfNull: false)
  final String? originCountry;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  static const fromJsonFactory = _$NetworkFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Network &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.logoPath, logoPath) ||
                const DeepCollectionEquality().equals(
                  other.logoPath,
                  logoPath,
                )) &&
            (identical(other.originCountry, originCountry) ||
                const DeepCollectionEquality().equals(
                  other.originCountry,
                  originCountry,
                )) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(logoPath) ^
      const DeepCollectionEquality().hash(originCountry) ^
      const DeepCollectionEquality().hash(name) ^
      runtimeType.hashCode;
}

extension $NetworkExtension on Network {
  Network copyWith({
    double? id,
    String? logoPath,
    String? originCountry,
    String? name,
  }) {
    return Network(
      id: id ?? this.id,
      logoPath: logoPath ?? this.logoPath,
      originCountry: originCountry ?? this.originCountry,
      name: name ?? this.name,
    );
  }

  Network copyWithWrapped({
    Wrapped<double?>? id,
    Wrapped<String?>? logoPath,
    Wrapped<String?>? originCountry,
    Wrapped<String?>? name,
  }) {
    return Network(
      id: (id != null ? id.value : this.id),
      logoPath: (logoPath != null ? logoPath.value : this.logoPath),
      originCountry: (originCountry != null
          ? originCountry.value
          : this.originCountry),
      name: (name != null ? name.value : this.name),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RelatedVideo {
  const RelatedVideo({
    this.url,
    this.key,
    this.name,
    this.size,
    this.type,
    this.site,
  });

  factory RelatedVideo.fromJson(Map<String, dynamic> json) =>
      _$RelatedVideoFromJson(json);

  static const toJsonFactory = _$RelatedVideoToJson;
  Map<String, dynamic> toJson() => _$RelatedVideoToJson(this);

  @JsonKey(name: 'url', includeIfNull: false)
  final String? url;
  @JsonKey(name: 'key', includeIfNull: false)
  final String? key;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(name: 'size', includeIfNull: false)
  final double? size;
  @JsonKey(
    name: 'type',
    includeIfNull: false,
    toJson: relatedVideoTypeNullableToJson,
    fromJson: relatedVideoTypeNullableFromJson,
  )
  final enums.RelatedVideoType? type;
  @JsonKey(
    name: 'site',
    includeIfNull: false,
    toJson: relatedVideoSiteNullableToJson,
    fromJson: relatedVideoSiteNullableFromJson,
  )
  final enums.RelatedVideoSite? site;
  static const fromJsonFactory = _$RelatedVideoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is RelatedVideo &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.key, key) ||
                const DeepCollectionEquality().equals(other.key, key)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.size, size) ||
                const DeepCollectionEquality().equals(other.size, size)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.site, site) ||
                const DeepCollectionEquality().equals(other.site, site)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(url) ^
      const DeepCollectionEquality().hash(key) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(size) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(site) ^
      runtimeType.hashCode;
}

extension $RelatedVideoExtension on RelatedVideo {
  RelatedVideo copyWith({
    String? url,
    String? key,
    String? name,
    double? size,
    enums.RelatedVideoType? type,
    enums.RelatedVideoSite? site,
  }) {
    return RelatedVideo(
      url: url ?? this.url,
      key: key ?? this.key,
      name: name ?? this.name,
      size: size ?? this.size,
      type: type ?? this.type,
      site: site ?? this.site,
    );
  }

  RelatedVideo copyWithWrapped({
    Wrapped<String?>? url,
    Wrapped<String?>? key,
    Wrapped<String?>? name,
    Wrapped<double?>? size,
    Wrapped<enums.RelatedVideoType?>? type,
    Wrapped<enums.RelatedVideoSite?>? site,
  }) {
    return RelatedVideo(
      url: (url != null ? url.value : this.url),
      key: (key != null ? key.value : this.key),
      name: (name != null ? name.value : this.name),
      size: (size != null ? size.value : this.size),
      type: (type != null ? type.value : this.type),
      site: (site != null ? site.value : this.site),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class MovieDetails {
  const MovieDetails({
    this.id,
    this.imdbId,
    this.adult,
    this.backdropPath,
    this.posterPath,
    this.budget,
    this.genres,
    this.homepage,
    this.relatedVideos,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.productionCompanies,
    this.productionCountries,
    this.releaseDate,
    this.releases,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.credits,
    this.collection,
    this.externalIds,
    this.mediaInfo,
    this.watchProviders,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsFromJson(json);

  static const toJsonFactory = _$MovieDetailsToJson;
  Map<String, dynamic> toJson() => _$MovieDetailsToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final double? id;
  @JsonKey(name: 'imdbId', includeIfNull: false)
  final String? imdbId;
  @JsonKey(name: 'adult', includeIfNull: false)
  final bool? adult;
  @JsonKey(name: 'backdropPath', includeIfNull: false)
  final String? backdropPath;
  @JsonKey(name: 'posterPath', includeIfNull: false)
  final String? posterPath;
  @JsonKey(name: 'budget', includeIfNull: false)
  final double? budget;
  @JsonKey(name: 'genres', includeIfNull: false, defaultValue: <Genre>[])
  final List<Genre>? genres;
  @JsonKey(name: 'homepage', includeIfNull: false)
  final String? homepage;
  @JsonKey(
    name: 'relatedVideos',
    includeIfNull: false,
    defaultValue: <RelatedVideo>[],
  )
  final List<RelatedVideo>? relatedVideos;
  @JsonKey(name: 'originalLanguage', includeIfNull: false)
  final String? originalLanguage;
  @JsonKey(name: 'originalTitle', includeIfNull: false)
  final String? originalTitle;
  @JsonKey(name: 'overview', includeIfNull: false)
  final String? overview;
  @JsonKey(name: 'popularity', includeIfNull: false)
  final double? popularity;
  @JsonKey(
    name: 'productionCompanies',
    includeIfNull: false,
    defaultValue: <ProductionCompany>[],
  )
  final List<ProductionCompany>? productionCompanies;
  @JsonKey(name: 'productionCountries', includeIfNull: false)
  final List<MovieDetails$ProductionCountries$Item>? productionCountries;
  @JsonKey(name: 'releaseDate', includeIfNull: false)
  final String? releaseDate;
  @JsonKey(name: 'releases', includeIfNull: false)
  final MovieDetails$Releases? releases;
  @JsonKey(name: 'revenue', includeIfNull: false)
  final double? revenue;
  @JsonKey(name: 'runtime', includeIfNull: false)
  final double? runtime;
  @JsonKey(
    name: 'spokenLanguages',
    includeIfNull: false,
    defaultValue: <SpokenLanguage>[],
  )
  final List<SpokenLanguage>? spokenLanguages;
  @JsonKey(name: 'status', includeIfNull: false)
  final String? status;
  @JsonKey(name: 'tagline', includeIfNull: false)
  final String? tagline;
  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;
  @JsonKey(name: 'video', includeIfNull: false)
  final bool? video;
  @JsonKey(name: 'voteAverage', includeIfNull: false)
  final double? voteAverage;
  @JsonKey(name: 'voteCount', includeIfNull: false)
  final double? voteCount;
  @JsonKey(name: 'credits', includeIfNull: false)
  final MovieDetails$Credits? credits;
  @JsonKey(name: 'collection', includeIfNull: false)
  final MovieDetails$Collection? collection;
  @JsonKey(name: 'externalIds', includeIfNull: false)
  final ExternalIds? externalIds;
  @JsonKey(name: 'mediaInfo', includeIfNull: false)
  final MediaInfo? mediaInfo;
  @JsonKey(
    name: 'watchProviders',
    includeIfNull: false,
    defaultValue: <WatchProviders>[],
  )
  final List<WatchProviders>? watchProviders;
  static const fromJsonFactory = _$MovieDetailsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MovieDetails &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.imdbId, imdbId) ||
                const DeepCollectionEquality().equals(other.imdbId, imdbId)) &&
            (identical(other.adult, adult) ||
                const DeepCollectionEquality().equals(other.adult, adult)) &&
            (identical(other.backdropPath, backdropPath) ||
                const DeepCollectionEquality().equals(
                  other.backdropPath,
                  backdropPath,
                )) &&
            (identical(other.posterPath, posterPath) ||
                const DeepCollectionEquality().equals(
                  other.posterPath,
                  posterPath,
                )) &&
            (identical(other.budget, budget) ||
                const DeepCollectionEquality().equals(other.budget, budget)) &&
            (identical(other.genres, genres) ||
                const DeepCollectionEquality().equals(other.genres, genres)) &&
            (identical(other.homepage, homepage) ||
                const DeepCollectionEquality().equals(
                  other.homepage,
                  homepage,
                )) &&
            (identical(other.relatedVideos, relatedVideos) ||
                const DeepCollectionEquality().equals(
                  other.relatedVideos,
                  relatedVideos,
                )) &&
            (identical(other.originalLanguage, originalLanguage) ||
                const DeepCollectionEquality().equals(
                  other.originalLanguage,
                  originalLanguage,
                )) &&
            (identical(other.originalTitle, originalTitle) ||
                const DeepCollectionEquality().equals(
                  other.originalTitle,
                  originalTitle,
                )) &&
            (identical(other.overview, overview) ||
                const DeepCollectionEquality().equals(
                  other.overview,
                  overview,
                )) &&
            (identical(other.popularity, popularity) ||
                const DeepCollectionEquality().equals(
                  other.popularity,
                  popularity,
                )) &&
            (identical(other.productionCompanies, productionCompanies) ||
                const DeepCollectionEquality().equals(
                  other.productionCompanies,
                  productionCompanies,
                )) &&
            (identical(other.productionCountries, productionCountries) ||
                const DeepCollectionEquality().equals(
                  other.productionCountries,
                  productionCountries,
                )) &&
            (identical(other.releaseDate, releaseDate) ||
                const DeepCollectionEquality().equals(
                  other.releaseDate,
                  releaseDate,
                )) &&
            (identical(other.releases, releases) ||
                const DeepCollectionEquality().equals(
                  other.releases,
                  releases,
                )) &&
            (identical(other.revenue, revenue) ||
                const DeepCollectionEquality().equals(
                  other.revenue,
                  revenue,
                )) &&
            (identical(other.runtime, runtime) ||
                const DeepCollectionEquality().equals(
                  other.runtime,
                  runtime,
                )) &&
            (identical(other.spokenLanguages, spokenLanguages) ||
                const DeepCollectionEquality().equals(
                  other.spokenLanguages,
                  spokenLanguages,
                )) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.tagline, tagline) ||
                const DeepCollectionEquality().equals(
                  other.tagline,
                  tagline,
                )) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.video, video) ||
                const DeepCollectionEquality().equals(other.video, video)) &&
            (identical(other.voteAverage, voteAverage) ||
                const DeepCollectionEquality().equals(
                  other.voteAverage,
                  voteAverage,
                )) &&
            (identical(other.voteCount, voteCount) ||
                const DeepCollectionEquality().equals(
                  other.voteCount,
                  voteCount,
                )) &&
            (identical(other.credits, credits) ||
                const DeepCollectionEquality().equals(
                  other.credits,
                  credits,
                )) &&
            (identical(other.collection, collection) ||
                const DeepCollectionEquality().equals(
                  other.collection,
                  collection,
                )) &&
            (identical(other.externalIds, externalIds) ||
                const DeepCollectionEquality().equals(
                  other.externalIds,
                  externalIds,
                )) &&
            (identical(other.mediaInfo, mediaInfo) ||
                const DeepCollectionEquality().equals(
                  other.mediaInfo,
                  mediaInfo,
                )) &&
            (identical(other.watchProviders, watchProviders) ||
                const DeepCollectionEquality().equals(
                  other.watchProviders,
                  watchProviders,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(imdbId) ^
      const DeepCollectionEquality().hash(adult) ^
      const DeepCollectionEquality().hash(backdropPath) ^
      const DeepCollectionEquality().hash(posterPath) ^
      const DeepCollectionEquality().hash(budget) ^
      const DeepCollectionEquality().hash(genres) ^
      const DeepCollectionEquality().hash(homepage) ^
      const DeepCollectionEquality().hash(relatedVideos) ^
      const DeepCollectionEquality().hash(originalLanguage) ^
      const DeepCollectionEquality().hash(originalTitle) ^
      const DeepCollectionEquality().hash(overview) ^
      const DeepCollectionEquality().hash(popularity) ^
      const DeepCollectionEquality().hash(productionCompanies) ^
      const DeepCollectionEquality().hash(productionCountries) ^
      const DeepCollectionEquality().hash(releaseDate) ^
      const DeepCollectionEquality().hash(releases) ^
      const DeepCollectionEquality().hash(revenue) ^
      const DeepCollectionEquality().hash(runtime) ^
      const DeepCollectionEquality().hash(spokenLanguages) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(tagline) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(video) ^
      const DeepCollectionEquality().hash(voteAverage) ^
      const DeepCollectionEquality().hash(voteCount) ^
      const DeepCollectionEquality().hash(credits) ^
      const DeepCollectionEquality().hash(collection) ^
      const DeepCollectionEquality().hash(externalIds) ^
      const DeepCollectionEquality().hash(mediaInfo) ^
      const DeepCollectionEquality().hash(watchProviders) ^
      runtimeType.hashCode;
}

extension $MovieDetailsExtension on MovieDetails {
  MovieDetails copyWith({
    double? id,
    String? imdbId,
    bool? adult,
    String? backdropPath,
    String? posterPath,
    double? budget,
    List<Genre>? genres,
    String? homepage,
    List<RelatedVideo>? relatedVideos,
    String? originalLanguage,
    String? originalTitle,
    String? overview,
    double? popularity,
    List<ProductionCompany>? productionCompanies,
    List<MovieDetails$ProductionCountries$Item>? productionCountries,
    String? releaseDate,
    MovieDetails$Releases? releases,
    double? revenue,
    double? runtime,
    List<SpokenLanguage>? spokenLanguages,
    String? status,
    String? tagline,
    String? title,
    bool? video,
    double? voteAverage,
    double? voteCount,
    MovieDetails$Credits? credits,
    MovieDetails$Collection? collection,
    ExternalIds? externalIds,
    MediaInfo? mediaInfo,
    List<WatchProviders>? watchProviders,
  }) {
    return MovieDetails(
      id: id ?? this.id,
      imdbId: imdbId ?? this.imdbId,
      adult: adult ?? this.adult,
      backdropPath: backdropPath ?? this.backdropPath,
      posterPath: posterPath ?? this.posterPath,
      budget: budget ?? this.budget,
      genres: genres ?? this.genres,
      homepage: homepage ?? this.homepage,
      relatedVideos: relatedVideos ?? this.relatedVideos,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      originalTitle: originalTitle ?? this.originalTitle,
      overview: overview ?? this.overview,
      popularity: popularity ?? this.popularity,
      productionCompanies: productionCompanies ?? this.productionCompanies,
      productionCountries: productionCountries ?? this.productionCountries,
      releaseDate: releaseDate ?? this.releaseDate,
      releases: releases ?? this.releases,
      revenue: revenue ?? this.revenue,
      runtime: runtime ?? this.runtime,
      spokenLanguages: spokenLanguages ?? this.spokenLanguages,
      status: status ?? this.status,
      tagline: tagline ?? this.tagline,
      title: title ?? this.title,
      video: video ?? this.video,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
      credits: credits ?? this.credits,
      collection: collection ?? this.collection,
      externalIds: externalIds ?? this.externalIds,
      mediaInfo: mediaInfo ?? this.mediaInfo,
      watchProviders: watchProviders ?? this.watchProviders,
    );
  }

  MovieDetails copyWithWrapped({
    Wrapped<double?>? id,
    Wrapped<String?>? imdbId,
    Wrapped<bool?>? adult,
    Wrapped<String?>? backdropPath,
    Wrapped<String?>? posterPath,
    Wrapped<double?>? budget,
    Wrapped<List<Genre>?>? genres,
    Wrapped<String?>? homepage,
    Wrapped<List<RelatedVideo>?>? relatedVideos,
    Wrapped<String?>? originalLanguage,
    Wrapped<String?>? originalTitle,
    Wrapped<String?>? overview,
    Wrapped<double?>? popularity,
    Wrapped<List<ProductionCompany>?>? productionCompanies,
    Wrapped<List<MovieDetails$ProductionCountries$Item>?>? productionCountries,
    Wrapped<String?>? releaseDate,
    Wrapped<MovieDetails$Releases?>? releases,
    Wrapped<double?>? revenue,
    Wrapped<double?>? runtime,
    Wrapped<List<SpokenLanguage>?>? spokenLanguages,
    Wrapped<String?>? status,
    Wrapped<String?>? tagline,
    Wrapped<String?>? title,
    Wrapped<bool?>? video,
    Wrapped<double?>? voteAverage,
    Wrapped<double?>? voteCount,
    Wrapped<MovieDetails$Credits?>? credits,
    Wrapped<MovieDetails$Collection?>? collection,
    Wrapped<ExternalIds?>? externalIds,
    Wrapped<MediaInfo?>? mediaInfo,
    Wrapped<List<WatchProviders>?>? watchProviders,
  }) {
    return MovieDetails(
      id: (id != null ? id.value : this.id),
      imdbId: (imdbId != null ? imdbId.value : this.imdbId),
      adult: (adult != null ? adult.value : this.adult),
      backdropPath: (backdropPath != null
          ? backdropPath.value
          : this.backdropPath),
      posterPath: (posterPath != null ? posterPath.value : this.posterPath),
      budget: (budget != null ? budget.value : this.budget),
      genres: (genres != null ? genres.value : this.genres),
      homepage: (homepage != null ? homepage.value : this.homepage),
      relatedVideos: (relatedVideos != null
          ? relatedVideos.value
          : this.relatedVideos),
      originalLanguage: (originalLanguage != null
          ? originalLanguage.value
          : this.originalLanguage),
      originalTitle: (originalTitle != null
          ? originalTitle.value
          : this.originalTitle),
      overview: (overview != null ? overview.value : this.overview),
      popularity: (popularity != null ? popularity.value : this.popularity),
      productionCompanies: (productionCompanies != null
          ? productionCompanies.value
          : this.productionCompanies),
      productionCountries: (productionCountries != null
          ? productionCountries.value
          : this.productionCountries),
      releaseDate: (releaseDate != null ? releaseDate.value : this.releaseDate),
      releases: (releases != null ? releases.value : this.releases),
      revenue: (revenue != null ? revenue.value : this.revenue),
      runtime: (runtime != null ? runtime.value : this.runtime),
      spokenLanguages: (spokenLanguages != null
          ? spokenLanguages.value
          : this.spokenLanguages),
      status: (status != null ? status.value : this.status),
      tagline: (tagline != null ? tagline.value : this.tagline),
      title: (title != null ? title.value : this.title),
      video: (video != null ? video.value : this.video),
      voteAverage: (voteAverage != null ? voteAverage.value : this.voteAverage),
      voteCount: (voteCount != null ? voteCount.value : this.voteCount),
      credits: (credits != null ? credits.value : this.credits),
      collection: (collection != null ? collection.value : this.collection),
      externalIds: (externalIds != null ? externalIds.value : this.externalIds),
      mediaInfo: (mediaInfo != null ? mediaInfo.value : this.mediaInfo),
      watchProviders: (watchProviders != null
          ? watchProviders.value
          : this.watchProviders),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Episode {
  const Episode({
    this.id,
    this.name,
    this.airDate,
    this.episodeNumber,
    this.overview,
    this.productionCode,
    this.seasonNumber,
    this.showId,
    this.stillPath,
    this.voteAverage,
    this.voteCount,
  });

  factory Episode.fromJson(Map<String, dynamic> json) =>
      _$EpisodeFromJson(json);

  static const toJsonFactory = _$EpisodeToJson;
  Map<String, dynamic> toJson() => _$EpisodeToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final double? id;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(name: 'airDate', includeIfNull: false)
  final String? airDate;
  @JsonKey(name: 'episodeNumber', includeIfNull: false)
  final double? episodeNumber;
  @JsonKey(name: 'overview', includeIfNull: false)
  final String? overview;
  @JsonKey(name: 'productionCode', includeIfNull: false)
  final String? productionCode;
  @JsonKey(name: 'seasonNumber', includeIfNull: false)
  final double? seasonNumber;
  @JsonKey(name: 'showId', includeIfNull: false)
  final double? showId;
  @JsonKey(name: 'stillPath', includeIfNull: false)
  final String? stillPath;
  @JsonKey(name: 'voteAverage', includeIfNull: false)
  final double? voteAverage;
  @JsonKey(name: 'voteCount', includeIfNull: false)
  final double? voteCount;
  static const fromJsonFactory = _$EpisodeFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Episode &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.airDate, airDate) ||
                const DeepCollectionEquality().equals(
                  other.airDate,
                  airDate,
                )) &&
            (identical(other.episodeNumber, episodeNumber) ||
                const DeepCollectionEquality().equals(
                  other.episodeNumber,
                  episodeNumber,
                )) &&
            (identical(other.overview, overview) ||
                const DeepCollectionEquality().equals(
                  other.overview,
                  overview,
                )) &&
            (identical(other.productionCode, productionCode) ||
                const DeepCollectionEquality().equals(
                  other.productionCode,
                  productionCode,
                )) &&
            (identical(other.seasonNumber, seasonNumber) ||
                const DeepCollectionEquality().equals(
                  other.seasonNumber,
                  seasonNumber,
                )) &&
            (identical(other.showId, showId) ||
                const DeepCollectionEquality().equals(other.showId, showId)) &&
            (identical(other.stillPath, stillPath) ||
                const DeepCollectionEquality().equals(
                  other.stillPath,
                  stillPath,
                )) &&
            (identical(other.voteAverage, voteAverage) ||
                const DeepCollectionEquality().equals(
                  other.voteAverage,
                  voteAverage,
                )) &&
            (identical(other.voteCount, voteCount) ||
                const DeepCollectionEquality().equals(
                  other.voteCount,
                  voteCount,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(airDate) ^
      const DeepCollectionEquality().hash(episodeNumber) ^
      const DeepCollectionEquality().hash(overview) ^
      const DeepCollectionEquality().hash(productionCode) ^
      const DeepCollectionEquality().hash(seasonNumber) ^
      const DeepCollectionEquality().hash(showId) ^
      const DeepCollectionEquality().hash(stillPath) ^
      const DeepCollectionEquality().hash(voteAverage) ^
      const DeepCollectionEquality().hash(voteCount) ^
      runtimeType.hashCode;
}

extension $EpisodeExtension on Episode {
  Episode copyWith({
    double? id,
    String? name,
    String? airDate,
    double? episodeNumber,
    String? overview,
    String? productionCode,
    double? seasonNumber,
    double? showId,
    String? stillPath,
    double? voteAverage,
    double? voteCount,
  }) {
    return Episode(
      id: id ?? this.id,
      name: name ?? this.name,
      airDate: airDate ?? this.airDate,
      episodeNumber: episodeNumber ?? this.episodeNumber,
      overview: overview ?? this.overview,
      productionCode: productionCode ?? this.productionCode,
      seasonNumber: seasonNumber ?? this.seasonNumber,
      showId: showId ?? this.showId,
      stillPath: stillPath ?? this.stillPath,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
    );
  }

  Episode copyWithWrapped({
    Wrapped<double?>? id,
    Wrapped<String?>? name,
    Wrapped<String?>? airDate,
    Wrapped<double?>? episodeNumber,
    Wrapped<String?>? overview,
    Wrapped<String?>? productionCode,
    Wrapped<double?>? seasonNumber,
    Wrapped<double?>? showId,
    Wrapped<String?>? stillPath,
    Wrapped<double?>? voteAverage,
    Wrapped<double?>? voteCount,
  }) {
    return Episode(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
      airDate: (airDate != null ? airDate.value : this.airDate),
      episodeNumber: (episodeNumber != null
          ? episodeNumber.value
          : this.episodeNumber),
      overview: (overview != null ? overview.value : this.overview),
      productionCode: (productionCode != null
          ? productionCode.value
          : this.productionCode),
      seasonNumber: (seasonNumber != null
          ? seasonNumber.value
          : this.seasonNumber),
      showId: (showId != null ? showId.value : this.showId),
      stillPath: (stillPath != null ? stillPath.value : this.stillPath),
      voteAverage: (voteAverage != null ? voteAverage.value : this.voteAverage),
      voteCount: (voteCount != null ? voteCount.value : this.voteCount),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Season {
  const Season({
    this.id,
    this.airDate,
    this.episodeCount,
    this.name,
    this.overview,
    this.posterPath,
    this.seasonNumber,
    this.episodes,
  });

  factory Season.fromJson(Map<String, dynamic> json) => _$SeasonFromJson(json);

  static const toJsonFactory = _$SeasonToJson;
  Map<String, dynamic> toJson() => _$SeasonToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final double? id;
  @JsonKey(name: 'airDate', includeIfNull: false)
  final String? airDate;
  @JsonKey(name: 'episodeCount', includeIfNull: false)
  final double? episodeCount;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(name: 'overview', includeIfNull: false)
  final String? overview;
  @JsonKey(name: 'posterPath', includeIfNull: false)
  final String? posterPath;
  @JsonKey(name: 'seasonNumber', includeIfNull: false)
  final double? seasonNumber;
  @JsonKey(name: 'episodes', includeIfNull: false, defaultValue: <Episode>[])
  final List<Episode>? episodes;
  static const fromJsonFactory = _$SeasonFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Season &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.airDate, airDate) ||
                const DeepCollectionEquality().equals(
                  other.airDate,
                  airDate,
                )) &&
            (identical(other.episodeCount, episodeCount) ||
                const DeepCollectionEquality().equals(
                  other.episodeCount,
                  episodeCount,
                )) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.overview, overview) ||
                const DeepCollectionEquality().equals(
                  other.overview,
                  overview,
                )) &&
            (identical(other.posterPath, posterPath) ||
                const DeepCollectionEquality().equals(
                  other.posterPath,
                  posterPath,
                )) &&
            (identical(other.seasonNumber, seasonNumber) ||
                const DeepCollectionEquality().equals(
                  other.seasonNumber,
                  seasonNumber,
                )) &&
            (identical(other.episodes, episodes) ||
                const DeepCollectionEquality().equals(
                  other.episodes,
                  episodes,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(airDate) ^
      const DeepCollectionEquality().hash(episodeCount) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(overview) ^
      const DeepCollectionEquality().hash(posterPath) ^
      const DeepCollectionEquality().hash(seasonNumber) ^
      const DeepCollectionEquality().hash(episodes) ^
      runtimeType.hashCode;
}

extension $SeasonExtension on Season {
  Season copyWith({
    double? id,
    String? airDate,
    double? episodeCount,
    String? name,
    String? overview,
    String? posterPath,
    double? seasonNumber,
    List<Episode>? episodes,
  }) {
    return Season(
      id: id ?? this.id,
      airDate: airDate ?? this.airDate,
      episodeCount: episodeCount ?? this.episodeCount,
      name: name ?? this.name,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
      seasonNumber: seasonNumber ?? this.seasonNumber,
      episodes: episodes ?? this.episodes,
    );
  }

  Season copyWithWrapped({
    Wrapped<double?>? id,
    Wrapped<String?>? airDate,
    Wrapped<double?>? episodeCount,
    Wrapped<String?>? name,
    Wrapped<String?>? overview,
    Wrapped<String?>? posterPath,
    Wrapped<double?>? seasonNumber,
    Wrapped<List<Episode>?>? episodes,
  }) {
    return Season(
      id: (id != null ? id.value : this.id),
      airDate: (airDate != null ? airDate.value : this.airDate),
      episodeCount: (episodeCount != null
          ? episodeCount.value
          : this.episodeCount),
      name: (name != null ? name.value : this.name),
      overview: (overview != null ? overview.value : this.overview),
      posterPath: (posterPath != null ? posterPath.value : this.posterPath),
      seasonNumber: (seasonNumber != null
          ? seasonNumber.value
          : this.seasonNumber),
      episodes: (episodes != null ? episodes.value : this.episodes),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TvDetails {
  const TvDetails({
    this.id,
    this.backdropPath,
    this.posterPath,
    this.contentRatings,
    this.createdBy,
    this.episodeRunTime,
    this.firstAirDate,
    this.genres,
    this.homepage,
    this.inProduction,
    this.languages,
    this.lastAirDate,
    this.lastEpisodeToAir,
    this.name,
    this.nextEpisodeToAir,
    this.networks,
    this.numberOfEpisodes,
    this.numberOfSeason,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    this.productionCompanies,
    this.productionCountries,
    this.spokenLanguages,
    this.seasons,
    this.status,
    this.tagline,
    this.type,
    this.voteAverage,
    this.voteCount,
    this.credits,
    this.externalIds,
    this.keywords,
    this.mediaInfo,
    this.watchProviders,
  });

  factory TvDetails.fromJson(Map<String, dynamic> json) =>
      _$TvDetailsFromJson(json);

  static const toJsonFactory = _$TvDetailsToJson;
  Map<String, dynamic> toJson() => _$TvDetailsToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final double? id;
  @JsonKey(name: 'backdropPath', includeIfNull: false)
  final String? backdropPath;
  @JsonKey(name: 'posterPath', includeIfNull: false)
  final String? posterPath;
  @JsonKey(name: 'contentRatings', includeIfNull: false)
  final TvDetails$ContentRatings? contentRatings;
  @JsonKey(name: 'createdBy', includeIfNull: false)
  final List<TvDetails$CreatedBy$Item>? createdBy;
  @JsonKey(
    name: 'episodeRunTime',
    includeIfNull: false,
    defaultValue: <double>[],
  )
  final List<double>? episodeRunTime;
  @JsonKey(name: 'firstAirDate', includeIfNull: false)
  final String? firstAirDate;
  @JsonKey(name: 'genres', includeIfNull: false, defaultValue: <Genre>[])
  final List<Genre>? genres;
  @JsonKey(name: 'homepage', includeIfNull: false)
  final String? homepage;
  @JsonKey(name: 'inProduction', includeIfNull: false)
  final bool? inProduction;
  @JsonKey(name: 'languages', includeIfNull: false, defaultValue: <String>[])
  final List<String>? languages;
  @JsonKey(name: 'lastAirDate', includeIfNull: false)
  final String? lastAirDate;
  @JsonKey(name: 'lastEpisodeToAir', includeIfNull: false)
  final Episode? lastEpisodeToAir;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(name: 'nextEpisodeToAir', includeIfNull: false)
  final Episode? nextEpisodeToAir;
  @JsonKey(
    name: 'networks',
    includeIfNull: false,
    defaultValue: <ProductionCompany>[],
  )
  final List<ProductionCompany>? networks;
  @JsonKey(name: 'numberOfEpisodes', includeIfNull: false)
  final double? numberOfEpisodes;
  @JsonKey(name: 'numberOfSeason', includeIfNull: false)
  final double? numberOfSeason;
  @JsonKey(
    name: 'originCountry',
    includeIfNull: false,
    defaultValue: <String>[],
  )
  final List<String>? originCountry;
  @JsonKey(name: 'originalLanguage', includeIfNull: false)
  final String? originalLanguage;
  @JsonKey(name: 'originalName', includeIfNull: false)
  final String? originalName;
  @JsonKey(name: 'overview', includeIfNull: false)
  final String? overview;
  @JsonKey(name: 'popularity', includeIfNull: false)
  final double? popularity;
  @JsonKey(
    name: 'productionCompanies',
    includeIfNull: false,
    defaultValue: <ProductionCompany>[],
  )
  final List<ProductionCompany>? productionCompanies;
  @JsonKey(name: 'productionCountries', includeIfNull: false)
  final List<TvDetails$ProductionCountries$Item>? productionCountries;
  @JsonKey(
    name: 'spokenLanguages',
    includeIfNull: false,
    defaultValue: <SpokenLanguage>[],
  )
  final List<SpokenLanguage>? spokenLanguages;
  @JsonKey(name: 'seasons', includeIfNull: false, defaultValue: <Season>[])
  final List<Season>? seasons;
  @JsonKey(name: 'status', includeIfNull: false)
  final String? status;
  @JsonKey(name: 'tagline', includeIfNull: false)
  final String? tagline;
  @JsonKey(name: 'type', includeIfNull: false)
  final String? type;
  @JsonKey(name: 'voteAverage', includeIfNull: false)
  final double? voteAverage;
  @JsonKey(name: 'voteCount', includeIfNull: false)
  final double? voteCount;
  @JsonKey(name: 'credits', includeIfNull: false)
  final TvDetails$Credits? credits;
  @JsonKey(name: 'externalIds', includeIfNull: false)
  final ExternalIds? externalIds;
  @JsonKey(name: 'keywords', includeIfNull: false, defaultValue: <Keyword>[])
  final List<Keyword>? keywords;
  @JsonKey(name: 'mediaInfo', includeIfNull: false)
  final MediaInfo? mediaInfo;
  @JsonKey(
    name: 'watchProviders',
    includeIfNull: false,
    defaultValue: <WatchProviders>[],
  )
  final List<WatchProviders>? watchProviders;
  static const fromJsonFactory = _$TvDetailsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TvDetails &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.backdropPath, backdropPath) ||
                const DeepCollectionEquality().equals(
                  other.backdropPath,
                  backdropPath,
                )) &&
            (identical(other.posterPath, posterPath) ||
                const DeepCollectionEquality().equals(
                  other.posterPath,
                  posterPath,
                )) &&
            (identical(other.contentRatings, contentRatings) ||
                const DeepCollectionEquality().equals(
                  other.contentRatings,
                  contentRatings,
                )) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality().equals(
                  other.createdBy,
                  createdBy,
                )) &&
            (identical(other.episodeRunTime, episodeRunTime) ||
                const DeepCollectionEquality().equals(
                  other.episodeRunTime,
                  episodeRunTime,
                )) &&
            (identical(other.firstAirDate, firstAirDate) ||
                const DeepCollectionEquality().equals(
                  other.firstAirDate,
                  firstAirDate,
                )) &&
            (identical(other.genres, genres) ||
                const DeepCollectionEquality().equals(other.genres, genres)) &&
            (identical(other.homepage, homepage) ||
                const DeepCollectionEquality().equals(
                  other.homepage,
                  homepage,
                )) &&
            (identical(other.inProduction, inProduction) ||
                const DeepCollectionEquality().equals(
                  other.inProduction,
                  inProduction,
                )) &&
            (identical(other.languages, languages) ||
                const DeepCollectionEquality().equals(
                  other.languages,
                  languages,
                )) &&
            (identical(other.lastAirDate, lastAirDate) ||
                const DeepCollectionEquality().equals(
                  other.lastAirDate,
                  lastAirDate,
                )) &&
            (identical(other.lastEpisodeToAir, lastEpisodeToAir) ||
                const DeepCollectionEquality().equals(
                  other.lastEpisodeToAir,
                  lastEpisodeToAir,
                )) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.nextEpisodeToAir, nextEpisodeToAir) ||
                const DeepCollectionEquality().equals(
                  other.nextEpisodeToAir,
                  nextEpisodeToAir,
                )) &&
            (identical(other.networks, networks) ||
                const DeepCollectionEquality().equals(
                  other.networks,
                  networks,
                )) &&
            (identical(other.numberOfEpisodes, numberOfEpisodes) ||
                const DeepCollectionEquality().equals(
                  other.numberOfEpisodes,
                  numberOfEpisodes,
                )) &&
            (identical(other.numberOfSeason, numberOfSeason) ||
                const DeepCollectionEquality().equals(
                  other.numberOfSeason,
                  numberOfSeason,
                )) &&
            (identical(other.originCountry, originCountry) ||
                const DeepCollectionEquality().equals(
                  other.originCountry,
                  originCountry,
                )) &&
            (identical(other.originalLanguage, originalLanguage) ||
                const DeepCollectionEquality().equals(
                  other.originalLanguage,
                  originalLanguage,
                )) &&
            (identical(other.originalName, originalName) ||
                const DeepCollectionEquality().equals(
                  other.originalName,
                  originalName,
                )) &&
            (identical(other.overview, overview) ||
                const DeepCollectionEquality().equals(
                  other.overview,
                  overview,
                )) &&
            (identical(other.popularity, popularity) ||
                const DeepCollectionEquality().equals(
                  other.popularity,
                  popularity,
                )) &&
            (identical(other.productionCompanies, productionCompanies) ||
                const DeepCollectionEquality().equals(
                  other.productionCompanies,
                  productionCompanies,
                )) &&
            (identical(other.productionCountries, productionCountries) ||
                const DeepCollectionEquality().equals(
                  other.productionCountries,
                  productionCountries,
                )) &&
            (identical(other.spokenLanguages, spokenLanguages) ||
                const DeepCollectionEquality().equals(
                  other.spokenLanguages,
                  spokenLanguages,
                )) &&
            (identical(other.seasons, seasons) ||
                const DeepCollectionEquality().equals(
                  other.seasons,
                  seasons,
                )) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.tagline, tagline) ||
                const DeepCollectionEquality().equals(
                  other.tagline,
                  tagline,
                )) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.voteAverage, voteAverage) ||
                const DeepCollectionEquality().equals(
                  other.voteAverage,
                  voteAverage,
                )) &&
            (identical(other.voteCount, voteCount) ||
                const DeepCollectionEquality().equals(
                  other.voteCount,
                  voteCount,
                )) &&
            (identical(other.credits, credits) ||
                const DeepCollectionEquality().equals(
                  other.credits,
                  credits,
                )) &&
            (identical(other.externalIds, externalIds) ||
                const DeepCollectionEquality().equals(
                  other.externalIds,
                  externalIds,
                )) &&
            (identical(other.keywords, keywords) ||
                const DeepCollectionEquality().equals(
                  other.keywords,
                  keywords,
                )) &&
            (identical(other.mediaInfo, mediaInfo) ||
                const DeepCollectionEquality().equals(
                  other.mediaInfo,
                  mediaInfo,
                )) &&
            (identical(other.watchProviders, watchProviders) ||
                const DeepCollectionEquality().equals(
                  other.watchProviders,
                  watchProviders,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(backdropPath) ^
      const DeepCollectionEquality().hash(posterPath) ^
      const DeepCollectionEquality().hash(contentRatings) ^
      const DeepCollectionEquality().hash(createdBy) ^
      const DeepCollectionEquality().hash(episodeRunTime) ^
      const DeepCollectionEquality().hash(firstAirDate) ^
      const DeepCollectionEquality().hash(genres) ^
      const DeepCollectionEquality().hash(homepage) ^
      const DeepCollectionEquality().hash(inProduction) ^
      const DeepCollectionEquality().hash(languages) ^
      const DeepCollectionEquality().hash(lastAirDate) ^
      const DeepCollectionEquality().hash(lastEpisodeToAir) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(nextEpisodeToAir) ^
      const DeepCollectionEquality().hash(networks) ^
      const DeepCollectionEquality().hash(numberOfEpisodes) ^
      const DeepCollectionEquality().hash(numberOfSeason) ^
      const DeepCollectionEquality().hash(originCountry) ^
      const DeepCollectionEquality().hash(originalLanguage) ^
      const DeepCollectionEquality().hash(originalName) ^
      const DeepCollectionEquality().hash(overview) ^
      const DeepCollectionEquality().hash(popularity) ^
      const DeepCollectionEquality().hash(productionCompanies) ^
      const DeepCollectionEquality().hash(productionCountries) ^
      const DeepCollectionEquality().hash(spokenLanguages) ^
      const DeepCollectionEquality().hash(seasons) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(tagline) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(voteAverage) ^
      const DeepCollectionEquality().hash(voteCount) ^
      const DeepCollectionEquality().hash(credits) ^
      const DeepCollectionEquality().hash(externalIds) ^
      const DeepCollectionEquality().hash(keywords) ^
      const DeepCollectionEquality().hash(mediaInfo) ^
      const DeepCollectionEquality().hash(watchProviders) ^
      runtimeType.hashCode;
}

extension $TvDetailsExtension on TvDetails {
  TvDetails copyWith({
    double? id,
    String? backdropPath,
    String? posterPath,
    TvDetails$ContentRatings? contentRatings,
    List<TvDetails$CreatedBy$Item>? createdBy,
    List<double>? episodeRunTime,
    String? firstAirDate,
    List<Genre>? genres,
    String? homepage,
    bool? inProduction,
    List<String>? languages,
    String? lastAirDate,
    Episode? lastEpisodeToAir,
    String? name,
    Episode? nextEpisodeToAir,
    List<ProductionCompany>? networks,
    double? numberOfEpisodes,
    double? numberOfSeason,
    List<String>? originCountry,
    String? originalLanguage,
    String? originalName,
    String? overview,
    double? popularity,
    List<ProductionCompany>? productionCompanies,
    List<TvDetails$ProductionCountries$Item>? productionCountries,
    List<SpokenLanguage>? spokenLanguages,
    List<Season>? seasons,
    String? status,
    String? tagline,
    String? type,
    double? voteAverage,
    double? voteCount,
    TvDetails$Credits? credits,
    ExternalIds? externalIds,
    List<Keyword>? keywords,
    MediaInfo? mediaInfo,
    List<WatchProviders>? watchProviders,
  }) {
    return TvDetails(
      id: id ?? this.id,
      backdropPath: backdropPath ?? this.backdropPath,
      posterPath: posterPath ?? this.posterPath,
      contentRatings: contentRatings ?? this.contentRatings,
      createdBy: createdBy ?? this.createdBy,
      episodeRunTime: episodeRunTime ?? this.episodeRunTime,
      firstAirDate: firstAirDate ?? this.firstAirDate,
      genres: genres ?? this.genres,
      homepage: homepage ?? this.homepage,
      inProduction: inProduction ?? this.inProduction,
      languages: languages ?? this.languages,
      lastAirDate: lastAirDate ?? this.lastAirDate,
      lastEpisodeToAir: lastEpisodeToAir ?? this.lastEpisodeToAir,
      name: name ?? this.name,
      nextEpisodeToAir: nextEpisodeToAir ?? this.nextEpisodeToAir,
      networks: networks ?? this.networks,
      numberOfEpisodes: numberOfEpisodes ?? this.numberOfEpisodes,
      numberOfSeason: numberOfSeason ?? this.numberOfSeason,
      originCountry: originCountry ?? this.originCountry,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      originalName: originalName ?? this.originalName,
      overview: overview ?? this.overview,
      popularity: popularity ?? this.popularity,
      productionCompanies: productionCompanies ?? this.productionCompanies,
      productionCountries: productionCountries ?? this.productionCountries,
      spokenLanguages: spokenLanguages ?? this.spokenLanguages,
      seasons: seasons ?? this.seasons,
      status: status ?? this.status,
      tagline: tagline ?? this.tagline,
      type: type ?? this.type,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
      credits: credits ?? this.credits,
      externalIds: externalIds ?? this.externalIds,
      keywords: keywords ?? this.keywords,
      mediaInfo: mediaInfo ?? this.mediaInfo,
      watchProviders: watchProviders ?? this.watchProviders,
    );
  }

  TvDetails copyWithWrapped({
    Wrapped<double?>? id,
    Wrapped<String?>? backdropPath,
    Wrapped<String?>? posterPath,
    Wrapped<TvDetails$ContentRatings?>? contentRatings,
    Wrapped<List<TvDetails$CreatedBy$Item>?>? createdBy,
    Wrapped<List<double>?>? episodeRunTime,
    Wrapped<String?>? firstAirDate,
    Wrapped<List<Genre>?>? genres,
    Wrapped<String?>? homepage,
    Wrapped<bool?>? inProduction,
    Wrapped<List<String>?>? languages,
    Wrapped<String?>? lastAirDate,
    Wrapped<Episode?>? lastEpisodeToAir,
    Wrapped<String?>? name,
    Wrapped<Episode?>? nextEpisodeToAir,
    Wrapped<List<ProductionCompany>?>? networks,
    Wrapped<double?>? numberOfEpisodes,
    Wrapped<double?>? numberOfSeason,
    Wrapped<List<String>?>? originCountry,
    Wrapped<String?>? originalLanguage,
    Wrapped<String?>? originalName,
    Wrapped<String?>? overview,
    Wrapped<double?>? popularity,
    Wrapped<List<ProductionCompany>?>? productionCompanies,
    Wrapped<List<TvDetails$ProductionCountries$Item>?>? productionCountries,
    Wrapped<List<SpokenLanguage>?>? spokenLanguages,
    Wrapped<List<Season>?>? seasons,
    Wrapped<String?>? status,
    Wrapped<String?>? tagline,
    Wrapped<String?>? type,
    Wrapped<double?>? voteAverage,
    Wrapped<double?>? voteCount,
    Wrapped<TvDetails$Credits?>? credits,
    Wrapped<ExternalIds?>? externalIds,
    Wrapped<List<Keyword>?>? keywords,
    Wrapped<MediaInfo?>? mediaInfo,
    Wrapped<List<WatchProviders>?>? watchProviders,
  }) {
    return TvDetails(
      id: (id != null ? id.value : this.id),
      backdropPath: (backdropPath != null
          ? backdropPath.value
          : this.backdropPath),
      posterPath: (posterPath != null ? posterPath.value : this.posterPath),
      contentRatings: (contentRatings != null
          ? contentRatings.value
          : this.contentRatings),
      createdBy: (createdBy != null ? createdBy.value : this.createdBy),
      episodeRunTime: (episodeRunTime != null
          ? episodeRunTime.value
          : this.episodeRunTime),
      firstAirDate: (firstAirDate != null
          ? firstAirDate.value
          : this.firstAirDate),
      genres: (genres != null ? genres.value : this.genres),
      homepage: (homepage != null ? homepage.value : this.homepage),
      inProduction: (inProduction != null
          ? inProduction.value
          : this.inProduction),
      languages: (languages != null ? languages.value : this.languages),
      lastAirDate: (lastAirDate != null ? lastAirDate.value : this.lastAirDate),
      lastEpisodeToAir: (lastEpisodeToAir != null
          ? lastEpisodeToAir.value
          : this.lastEpisodeToAir),
      name: (name != null ? name.value : this.name),
      nextEpisodeToAir: (nextEpisodeToAir != null
          ? nextEpisodeToAir.value
          : this.nextEpisodeToAir),
      networks: (networks != null ? networks.value : this.networks),
      numberOfEpisodes: (numberOfEpisodes != null
          ? numberOfEpisodes.value
          : this.numberOfEpisodes),
      numberOfSeason: (numberOfSeason != null
          ? numberOfSeason.value
          : this.numberOfSeason),
      originCountry: (originCountry != null
          ? originCountry.value
          : this.originCountry),
      originalLanguage: (originalLanguage != null
          ? originalLanguage.value
          : this.originalLanguage),
      originalName: (originalName != null
          ? originalName.value
          : this.originalName),
      overview: (overview != null ? overview.value : this.overview),
      popularity: (popularity != null ? popularity.value : this.popularity),
      productionCompanies: (productionCompanies != null
          ? productionCompanies.value
          : this.productionCompanies),
      productionCountries: (productionCountries != null
          ? productionCountries.value
          : this.productionCountries),
      spokenLanguages: (spokenLanguages != null
          ? spokenLanguages.value
          : this.spokenLanguages),
      seasons: (seasons != null ? seasons.value : this.seasons),
      status: (status != null ? status.value : this.status),
      tagline: (tagline != null ? tagline.value : this.tagline),
      type: (type != null ? type.value : this.type),
      voteAverage: (voteAverage != null ? voteAverage.value : this.voteAverage),
      voteCount: (voteCount != null ? voteCount.value : this.voteCount),
      credits: (credits != null ? credits.value : this.credits),
      externalIds: (externalIds != null ? externalIds.value : this.externalIds),
      keywords: (keywords != null ? keywords.value : this.keywords),
      mediaInfo: (mediaInfo != null ? mediaInfo.value : this.mediaInfo),
      watchProviders: (watchProviders != null
          ? watchProviders.value
          : this.watchProviders),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class MediaRequest {
  const MediaRequest({
    this.id,
    this.status,
    this.media,
    this.createdAt,
    this.updatedAt,
    this.requestedBy,
    this.modifiedBy,
    this.is4k,
    this.serverId,
    this.profileId,
    this.rootFolder,
  });

  factory MediaRequest.fromJson(Map<String, dynamic> json) =>
      _$MediaRequestFromJson(json);

  static const toJsonFactory = _$MediaRequestToJson;
  Map<String, dynamic> toJson() => _$MediaRequestToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final double? id;
  @JsonKey(name: 'status', includeIfNull: false)
  final double? status;
  @JsonKey(name: 'media', includeIfNull: false)
  final MediaInfo? media;
  @JsonKey(name: 'createdAt', includeIfNull: false)
  final String? createdAt;
  @JsonKey(name: 'updatedAt', includeIfNull: false)
  final String? updatedAt;
  @JsonKey(name: 'requestedBy', includeIfNull: false)
  final User? requestedBy;
  @JsonKey(name: 'modifiedBy', includeIfNull: false)
  final dynamic modifiedBy;
  @JsonKey(name: 'is4k', includeIfNull: false)
  final bool? is4k;
  @JsonKey(name: 'serverId', includeIfNull: false)
  final double? serverId;
  @JsonKey(name: 'profileId', includeIfNull: false)
  final double? profileId;
  @JsonKey(name: 'rootFolder', includeIfNull: false)
  final String? rootFolder;
  static const fromJsonFactory = _$MediaRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MediaRequest &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.media, media) ||
                const DeepCollectionEquality().equals(other.media, media)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(
                  other.createdAt,
                  createdAt,
                )) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality().equals(
                  other.updatedAt,
                  updatedAt,
                )) &&
            (identical(other.requestedBy, requestedBy) ||
                const DeepCollectionEquality().equals(
                  other.requestedBy,
                  requestedBy,
                )) &&
            (identical(other.modifiedBy, modifiedBy) ||
                const DeepCollectionEquality().equals(
                  other.modifiedBy,
                  modifiedBy,
                )) &&
            (identical(other.is4k, is4k) ||
                const DeepCollectionEquality().equals(other.is4k, is4k)) &&
            (identical(other.serverId, serverId) ||
                const DeepCollectionEquality().equals(
                  other.serverId,
                  serverId,
                )) &&
            (identical(other.profileId, profileId) ||
                const DeepCollectionEquality().equals(
                  other.profileId,
                  profileId,
                )) &&
            (identical(other.rootFolder, rootFolder) ||
                const DeepCollectionEquality().equals(
                  other.rootFolder,
                  rootFolder,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(media) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(requestedBy) ^
      const DeepCollectionEquality().hash(modifiedBy) ^
      const DeepCollectionEquality().hash(is4k) ^
      const DeepCollectionEquality().hash(serverId) ^
      const DeepCollectionEquality().hash(profileId) ^
      const DeepCollectionEquality().hash(rootFolder) ^
      runtimeType.hashCode;
}

extension $MediaRequestExtension on MediaRequest {
  MediaRequest copyWith({
    double? id,
    double? status,
    MediaInfo? media,
    String? createdAt,
    String? updatedAt,
    User? requestedBy,
    dynamic modifiedBy,
    bool? is4k,
    double? serverId,
    double? profileId,
    String? rootFolder,
  }) {
    return MediaRequest(
      id: id ?? this.id,
      status: status ?? this.status,
      media: media ?? this.media,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      requestedBy: requestedBy ?? this.requestedBy,
      modifiedBy: modifiedBy ?? this.modifiedBy,
      is4k: is4k ?? this.is4k,
      serverId: serverId ?? this.serverId,
      profileId: profileId ?? this.profileId,
      rootFolder: rootFolder ?? this.rootFolder,
    );
  }

  MediaRequest copyWithWrapped({
    Wrapped<double?>? id,
    Wrapped<double?>? status,
    Wrapped<MediaInfo?>? media,
    Wrapped<String?>? createdAt,
    Wrapped<String?>? updatedAt,
    Wrapped<User?>? requestedBy,
    Wrapped<dynamic>? modifiedBy,
    Wrapped<bool?>? is4k,
    Wrapped<double?>? serverId,
    Wrapped<double?>? profileId,
    Wrapped<String?>? rootFolder,
  }) {
    return MediaRequest(
      id: (id != null ? id.value : this.id),
      status: (status != null ? status.value : this.status),
      media: (media != null ? media.value : this.media),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      requestedBy: (requestedBy != null ? requestedBy.value : this.requestedBy),
      modifiedBy: (modifiedBy != null ? modifiedBy.value : this.modifiedBy),
      is4k: (is4k != null ? is4k.value : this.is4k),
      serverId: (serverId != null ? serverId.value : this.serverId),
      profileId: (profileId != null ? profileId.value : this.profileId),
      rootFolder: (rootFolder != null ? rootFolder.value : this.rootFolder),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class MediaInfo {
  const MediaInfo({
    this.id,
    this.tmdbId,
    this.tvdbId,
    this.status,
    this.requests,
    this.createdAt,
    this.updatedAt,
  });

  factory MediaInfo.fromJson(Map<String, dynamic> json) =>
      _$MediaInfoFromJson(json);

  static const toJsonFactory = _$MediaInfoToJson;
  Map<String, dynamic> toJson() => _$MediaInfoToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final double? id;
  @JsonKey(name: 'tmdbId', includeIfNull: false)
  final double? tmdbId;
  @JsonKey(name: 'tvdbId', includeIfNull: false)
  final double? tvdbId;
  @JsonKey(name: 'status', includeIfNull: false)
  final double? status;
  @JsonKey(
    name: 'requests',
    includeIfNull: false,
    defaultValue: <MediaRequest>[],
  )
  final List<MediaRequest>? requests;
  @JsonKey(name: 'createdAt', includeIfNull: false)
  final String? createdAt;
  @JsonKey(name: 'updatedAt', includeIfNull: false)
  final String? updatedAt;
  static const fromJsonFactory = _$MediaInfoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MediaInfo &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.tmdbId, tmdbId) ||
                const DeepCollectionEquality().equals(other.tmdbId, tmdbId)) &&
            (identical(other.tvdbId, tvdbId) ||
                const DeepCollectionEquality().equals(other.tvdbId, tvdbId)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.requests, requests) ||
                const DeepCollectionEquality().equals(
                  other.requests,
                  requests,
                )) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(
                  other.createdAt,
                  createdAt,
                )) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality().equals(
                  other.updatedAt,
                  updatedAt,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(tmdbId) ^
      const DeepCollectionEquality().hash(tvdbId) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(requests) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      runtimeType.hashCode;
}

extension $MediaInfoExtension on MediaInfo {
  MediaInfo copyWith({
    double? id,
    double? tmdbId,
    double? tvdbId,
    double? status,
    List<MediaRequest>? requests,
    String? createdAt,
    String? updatedAt,
  }) {
    return MediaInfo(
      id: id ?? this.id,
      tmdbId: tmdbId ?? this.tmdbId,
      tvdbId: tvdbId ?? this.tvdbId,
      status: status ?? this.status,
      requests: requests ?? this.requests,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  MediaInfo copyWithWrapped({
    Wrapped<double?>? id,
    Wrapped<double?>? tmdbId,
    Wrapped<double?>? tvdbId,
    Wrapped<double?>? status,
    Wrapped<List<MediaRequest>?>? requests,
    Wrapped<String?>? createdAt,
    Wrapped<String?>? updatedAt,
  }) {
    return MediaInfo(
      id: (id != null ? id.value : this.id),
      tmdbId: (tmdbId != null ? tmdbId.value : this.tmdbId),
      tvdbId: (tvdbId != null ? tvdbId.value : this.tvdbId),
      status: (status != null ? status.value : this.status),
      requests: (requests != null ? requests.value : this.requests),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Cast {
  const Cast({
    this.id,
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.name,
    this.order,
    this.profilePath,
  });

  factory Cast.fromJson(Map<String, dynamic> json) => _$CastFromJson(json);

  static const toJsonFactory = _$CastToJson;
  Map<String, dynamic> toJson() => _$CastToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final double? id;
  @JsonKey(name: 'castId', includeIfNull: false)
  final double? castId;
  @JsonKey(name: 'character', includeIfNull: false)
  final String? character;
  @JsonKey(name: 'creditId', includeIfNull: false)
  final String? creditId;
  @JsonKey(name: 'gender', includeIfNull: false)
  final double? gender;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(name: 'order', includeIfNull: false)
  final double? order;
  @JsonKey(name: 'profilePath', includeIfNull: false)
  final String? profilePath;
  static const fromJsonFactory = _$CastFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Cast &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.castId, castId) ||
                const DeepCollectionEquality().equals(other.castId, castId)) &&
            (identical(other.character, character) ||
                const DeepCollectionEquality().equals(
                  other.character,
                  character,
                )) &&
            (identical(other.creditId, creditId) ||
                const DeepCollectionEquality().equals(
                  other.creditId,
                  creditId,
                )) &&
            (identical(other.gender, gender) ||
                const DeepCollectionEquality().equals(other.gender, gender)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.order, order) ||
                const DeepCollectionEquality().equals(other.order, order)) &&
            (identical(other.profilePath, profilePath) ||
                const DeepCollectionEquality().equals(
                  other.profilePath,
                  profilePath,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(castId) ^
      const DeepCollectionEquality().hash(character) ^
      const DeepCollectionEquality().hash(creditId) ^
      const DeepCollectionEquality().hash(gender) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(order) ^
      const DeepCollectionEquality().hash(profilePath) ^
      runtimeType.hashCode;
}

extension $CastExtension on Cast {
  Cast copyWith({
    double? id,
    double? castId,
    String? character,
    String? creditId,
    double? gender,
    String? name,
    double? order,
    String? profilePath,
  }) {
    return Cast(
      id: id ?? this.id,
      castId: castId ?? this.castId,
      character: character ?? this.character,
      creditId: creditId ?? this.creditId,
      gender: gender ?? this.gender,
      name: name ?? this.name,
      order: order ?? this.order,
      profilePath: profilePath ?? this.profilePath,
    );
  }

  Cast copyWithWrapped({
    Wrapped<double?>? id,
    Wrapped<double?>? castId,
    Wrapped<String?>? character,
    Wrapped<String?>? creditId,
    Wrapped<double?>? gender,
    Wrapped<String?>? name,
    Wrapped<double?>? order,
    Wrapped<String?>? profilePath,
  }) {
    return Cast(
      id: (id != null ? id.value : this.id),
      castId: (castId != null ? castId.value : this.castId),
      character: (character != null ? character.value : this.character),
      creditId: (creditId != null ? creditId.value : this.creditId),
      gender: (gender != null ? gender.value : this.gender),
      name: (name != null ? name.value : this.name),
      order: (order != null ? order.value : this.order),
      profilePath: (profilePath != null ? profilePath.value : this.profilePath),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Crew {
  const Crew({
    this.id,
    this.creditId,
    this.gender,
    this.name,
    this.job,
    this.department,
    this.profilePath,
  });

  factory Crew.fromJson(Map<String, dynamic> json) => _$CrewFromJson(json);

  static const toJsonFactory = _$CrewToJson;
  Map<String, dynamic> toJson() => _$CrewToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final double? id;
  @JsonKey(name: 'creditId', includeIfNull: false)
  final String? creditId;
  @JsonKey(name: 'gender', includeIfNull: false)
  final double? gender;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(name: 'job', includeIfNull: false)
  final String? job;
  @JsonKey(name: 'department', includeIfNull: false)
  final String? department;
  @JsonKey(name: 'profilePath', includeIfNull: false)
  final String? profilePath;
  static const fromJsonFactory = _$CrewFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Crew &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.creditId, creditId) ||
                const DeepCollectionEquality().equals(
                  other.creditId,
                  creditId,
                )) &&
            (identical(other.gender, gender) ||
                const DeepCollectionEquality().equals(other.gender, gender)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.job, job) ||
                const DeepCollectionEquality().equals(other.job, job)) &&
            (identical(other.department, department) ||
                const DeepCollectionEquality().equals(
                  other.department,
                  department,
                )) &&
            (identical(other.profilePath, profilePath) ||
                const DeepCollectionEquality().equals(
                  other.profilePath,
                  profilePath,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(creditId) ^
      const DeepCollectionEquality().hash(gender) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(job) ^
      const DeepCollectionEquality().hash(department) ^
      const DeepCollectionEquality().hash(profilePath) ^
      runtimeType.hashCode;
}

extension $CrewExtension on Crew {
  Crew copyWith({
    double? id,
    String? creditId,
    double? gender,
    String? name,
    String? job,
    String? department,
    String? profilePath,
  }) {
    return Crew(
      id: id ?? this.id,
      creditId: creditId ?? this.creditId,
      gender: gender ?? this.gender,
      name: name ?? this.name,
      job: job ?? this.job,
      department: department ?? this.department,
      profilePath: profilePath ?? this.profilePath,
    );
  }

  Crew copyWithWrapped({
    Wrapped<double?>? id,
    Wrapped<String?>? creditId,
    Wrapped<double?>? gender,
    Wrapped<String?>? name,
    Wrapped<String?>? job,
    Wrapped<String?>? department,
    Wrapped<String?>? profilePath,
  }) {
    return Crew(
      id: (id != null ? id.value : this.id),
      creditId: (creditId != null ? creditId.value : this.creditId),
      gender: (gender != null ? gender.value : this.gender),
      name: (name != null ? name.value : this.name),
      job: (job != null ? job.value : this.job),
      department: (department != null ? department.value : this.department),
      profilePath: (profilePath != null ? profilePath.value : this.profilePath),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ExternalIds {
  const ExternalIds({
    this.facebookId,
    this.freebaseId,
    this.freebaseMid,
    this.imdbId,
    this.instagramId,
    this.tvdbId,
    this.tvrageId,
    this.twitterId,
  });

  factory ExternalIds.fromJson(Map<String, dynamic> json) =>
      _$ExternalIdsFromJson(json);

  static const toJsonFactory = _$ExternalIdsToJson;
  Map<String, dynamic> toJson() => _$ExternalIdsToJson(this);

  @JsonKey(name: 'facebookId', includeIfNull: false)
  final String? facebookId;
  @JsonKey(name: 'freebaseId', includeIfNull: false)
  final String? freebaseId;
  @JsonKey(name: 'freebaseMid', includeIfNull: false)
  final String? freebaseMid;
  @JsonKey(name: 'imdbId', includeIfNull: false)
  final String? imdbId;
  @JsonKey(name: 'instagramId', includeIfNull: false)
  final String? instagramId;
  @JsonKey(name: 'tvdbId', includeIfNull: false)
  final double? tvdbId;
  @JsonKey(name: 'tvrageId', includeIfNull: false)
  final double? tvrageId;
  @JsonKey(name: 'twitterId', includeIfNull: false)
  final String? twitterId;
  static const fromJsonFactory = _$ExternalIdsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ExternalIds &&
            (identical(other.facebookId, facebookId) ||
                const DeepCollectionEquality().equals(
                  other.facebookId,
                  facebookId,
                )) &&
            (identical(other.freebaseId, freebaseId) ||
                const DeepCollectionEquality().equals(
                  other.freebaseId,
                  freebaseId,
                )) &&
            (identical(other.freebaseMid, freebaseMid) ||
                const DeepCollectionEquality().equals(
                  other.freebaseMid,
                  freebaseMid,
                )) &&
            (identical(other.imdbId, imdbId) ||
                const DeepCollectionEquality().equals(other.imdbId, imdbId)) &&
            (identical(other.instagramId, instagramId) ||
                const DeepCollectionEquality().equals(
                  other.instagramId,
                  instagramId,
                )) &&
            (identical(other.tvdbId, tvdbId) ||
                const DeepCollectionEquality().equals(other.tvdbId, tvdbId)) &&
            (identical(other.tvrageId, tvrageId) ||
                const DeepCollectionEquality().equals(
                  other.tvrageId,
                  tvrageId,
                )) &&
            (identical(other.twitterId, twitterId) ||
                const DeepCollectionEquality().equals(
                  other.twitterId,
                  twitterId,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(facebookId) ^
      const DeepCollectionEquality().hash(freebaseId) ^
      const DeepCollectionEquality().hash(freebaseMid) ^
      const DeepCollectionEquality().hash(imdbId) ^
      const DeepCollectionEquality().hash(instagramId) ^
      const DeepCollectionEquality().hash(tvdbId) ^
      const DeepCollectionEquality().hash(tvrageId) ^
      const DeepCollectionEquality().hash(twitterId) ^
      runtimeType.hashCode;
}

extension $ExternalIdsExtension on ExternalIds {
  ExternalIds copyWith({
    String? facebookId,
    String? freebaseId,
    String? freebaseMid,
    String? imdbId,
    String? instagramId,
    double? tvdbId,
    double? tvrageId,
    String? twitterId,
  }) {
    return ExternalIds(
      facebookId: facebookId ?? this.facebookId,
      freebaseId: freebaseId ?? this.freebaseId,
      freebaseMid: freebaseMid ?? this.freebaseMid,
      imdbId: imdbId ?? this.imdbId,
      instagramId: instagramId ?? this.instagramId,
      tvdbId: tvdbId ?? this.tvdbId,
      tvrageId: tvrageId ?? this.tvrageId,
      twitterId: twitterId ?? this.twitterId,
    );
  }

  ExternalIds copyWithWrapped({
    Wrapped<String?>? facebookId,
    Wrapped<String?>? freebaseId,
    Wrapped<String?>? freebaseMid,
    Wrapped<String?>? imdbId,
    Wrapped<String?>? instagramId,
    Wrapped<double?>? tvdbId,
    Wrapped<double?>? tvrageId,
    Wrapped<String?>? twitterId,
  }) {
    return ExternalIds(
      facebookId: (facebookId != null ? facebookId.value : this.facebookId),
      freebaseId: (freebaseId != null ? freebaseId.value : this.freebaseId),
      freebaseMid: (freebaseMid != null ? freebaseMid.value : this.freebaseMid),
      imdbId: (imdbId != null ? imdbId.value : this.imdbId),
      instagramId: (instagramId != null ? instagramId.value : this.instagramId),
      tvdbId: (tvdbId != null ? tvdbId.value : this.tvdbId),
      tvrageId: (tvrageId != null ? tvrageId.value : this.tvrageId),
      twitterId: (twitterId != null ? twitterId.value : this.twitterId),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ServiceProfile {
  const ServiceProfile({this.id, this.name});

  factory ServiceProfile.fromJson(Map<String, dynamic> json) =>
      _$ServiceProfileFromJson(json);

  static const toJsonFactory = _$ServiceProfileToJson;
  Map<String, dynamic> toJson() => _$ServiceProfileToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final double? id;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  static const fromJsonFactory = _$ServiceProfileFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ServiceProfile &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      runtimeType.hashCode;
}

extension $ServiceProfileExtension on ServiceProfile {
  ServiceProfile copyWith({double? id, String? name}) {
    return ServiceProfile(id: id ?? this.id, name: name ?? this.name);
  }

  ServiceProfile copyWithWrapped({
    Wrapped<double?>? id,
    Wrapped<String?>? name,
  }) {
    return ServiceProfile(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PageInfo {
  const PageInfo({this.page, this.pages, this.results});

  factory PageInfo.fromJson(Map<String, dynamic> json) =>
      _$PageInfoFromJson(json);

  static const toJsonFactory = _$PageInfoToJson;
  Map<String, dynamic> toJson() => _$PageInfoToJson(this);

  @JsonKey(name: 'page', includeIfNull: false)
  final double? page;
  @JsonKey(name: 'pages', includeIfNull: false)
  final double? pages;
  @JsonKey(name: 'results', includeIfNull: false)
  final double? results;
  static const fromJsonFactory = _$PageInfoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PageInfo &&
            (identical(other.page, page) ||
                const DeepCollectionEquality().equals(other.page, page)) &&
            (identical(other.pages, pages) ||
                const DeepCollectionEquality().equals(other.pages, pages)) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(page) ^
      const DeepCollectionEquality().hash(pages) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $PageInfoExtension on PageInfo {
  PageInfo copyWith({double? page, double? pages, double? results}) {
    return PageInfo(
      page: page ?? this.page,
      pages: pages ?? this.pages,
      results: results ?? this.results,
    );
  }

  PageInfo copyWithWrapped({
    Wrapped<double?>? page,
    Wrapped<double?>? pages,
    Wrapped<double?>? results,
  }) {
    return PageInfo(
      page: (page != null ? page.value : this.page),
      pages: (pages != null ? pages.value : this.pages),
      results: (results != null ? results.value : this.results),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class DiscordSettings {
  const DiscordSettings({this.enabled, this.types, this.options});

  factory DiscordSettings.fromJson(Map<String, dynamic> json) =>
      _$DiscordSettingsFromJson(json);

  static const toJsonFactory = _$DiscordSettingsToJson;
  Map<String, dynamic> toJson() => _$DiscordSettingsToJson(this);

  @JsonKey(name: 'enabled', includeIfNull: false)
  final bool? enabled;
  @JsonKey(name: 'types', includeIfNull: false)
  final double? types;
  @JsonKey(name: 'options', includeIfNull: false)
  final DiscordSettings$Options? options;
  static const fromJsonFactory = _$DiscordSettingsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is DiscordSettings &&
            (identical(other.enabled, enabled) ||
                const DeepCollectionEquality().equals(
                  other.enabled,
                  enabled,
                )) &&
            (identical(other.types, types) ||
                const DeepCollectionEquality().equals(other.types, types)) &&
            (identical(other.options, options) ||
                const DeepCollectionEquality().equals(other.options, options)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(enabled) ^
      const DeepCollectionEquality().hash(types) ^
      const DeepCollectionEquality().hash(options) ^
      runtimeType.hashCode;
}

extension $DiscordSettingsExtension on DiscordSettings {
  DiscordSettings copyWith({
    bool? enabled,
    double? types,
    DiscordSettings$Options? options,
  }) {
    return DiscordSettings(
      enabled: enabled ?? this.enabled,
      types: types ?? this.types,
      options: options ?? this.options,
    );
  }

  DiscordSettings copyWithWrapped({
    Wrapped<bool?>? enabled,
    Wrapped<double?>? types,
    Wrapped<DiscordSettings$Options?>? options,
  }) {
    return DiscordSettings(
      enabled: (enabled != null ? enabled.value : this.enabled),
      types: (types != null ? types.value : this.types),
      options: (options != null ? options.value : this.options),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SlackSettings {
  const SlackSettings({this.enabled, this.types, this.options});

  factory SlackSettings.fromJson(Map<String, dynamic> json) =>
      _$SlackSettingsFromJson(json);

  static const toJsonFactory = _$SlackSettingsToJson;
  Map<String, dynamic> toJson() => _$SlackSettingsToJson(this);

  @JsonKey(name: 'enabled', includeIfNull: false)
  final bool? enabled;
  @JsonKey(name: 'types', includeIfNull: false)
  final double? types;
  @JsonKey(name: 'options', includeIfNull: false)
  final SlackSettings$Options? options;
  static const fromJsonFactory = _$SlackSettingsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SlackSettings &&
            (identical(other.enabled, enabled) ||
                const DeepCollectionEquality().equals(
                  other.enabled,
                  enabled,
                )) &&
            (identical(other.types, types) ||
                const DeepCollectionEquality().equals(other.types, types)) &&
            (identical(other.options, options) ||
                const DeepCollectionEquality().equals(other.options, options)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(enabled) ^
      const DeepCollectionEquality().hash(types) ^
      const DeepCollectionEquality().hash(options) ^
      runtimeType.hashCode;
}

extension $SlackSettingsExtension on SlackSettings {
  SlackSettings copyWith({
    bool? enabled,
    double? types,
    SlackSettings$Options? options,
  }) {
    return SlackSettings(
      enabled: enabled ?? this.enabled,
      types: types ?? this.types,
      options: options ?? this.options,
    );
  }

  SlackSettings copyWithWrapped({
    Wrapped<bool?>? enabled,
    Wrapped<double?>? types,
    Wrapped<SlackSettings$Options?>? options,
  }) {
    return SlackSettings(
      enabled: (enabled != null ? enabled.value : this.enabled),
      types: (types != null ? types.value : this.types),
      options: (options != null ? options.value : this.options),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class WebPushSettings {
  const WebPushSettings({this.enabled, this.types});

  factory WebPushSettings.fromJson(Map<String, dynamic> json) =>
      _$WebPushSettingsFromJson(json);

  static const toJsonFactory = _$WebPushSettingsToJson;
  Map<String, dynamic> toJson() => _$WebPushSettingsToJson(this);

  @JsonKey(name: 'enabled', includeIfNull: false)
  final bool? enabled;
  @JsonKey(name: 'types', includeIfNull: false)
  final double? types;
  static const fromJsonFactory = _$WebPushSettingsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is WebPushSettings &&
            (identical(other.enabled, enabled) ||
                const DeepCollectionEquality().equals(
                  other.enabled,
                  enabled,
                )) &&
            (identical(other.types, types) ||
                const DeepCollectionEquality().equals(other.types, types)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(enabled) ^
      const DeepCollectionEquality().hash(types) ^
      runtimeType.hashCode;
}

extension $WebPushSettingsExtension on WebPushSettings {
  WebPushSettings copyWith({bool? enabled, double? types}) {
    return WebPushSettings(
      enabled: enabled ?? this.enabled,
      types: types ?? this.types,
    );
  }

  WebPushSettings copyWithWrapped({
    Wrapped<bool?>? enabled,
    Wrapped<double?>? types,
  }) {
    return WebPushSettings(
      enabled: (enabled != null ? enabled.value : this.enabled),
      types: (types != null ? types.value : this.types),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class WebhookSettings {
  const WebhookSettings({this.enabled, this.types, this.options});

  factory WebhookSettings.fromJson(Map<String, dynamic> json) =>
      _$WebhookSettingsFromJson(json);

  static const toJsonFactory = _$WebhookSettingsToJson;
  Map<String, dynamic> toJson() => _$WebhookSettingsToJson(this);

  @JsonKey(name: 'enabled', includeIfNull: false)
  final bool? enabled;
  @JsonKey(name: 'types', includeIfNull: false)
  final double? types;
  @JsonKey(name: 'options', includeIfNull: false)
  final WebhookSettings$Options? options;
  static const fromJsonFactory = _$WebhookSettingsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is WebhookSettings &&
            (identical(other.enabled, enabled) ||
                const DeepCollectionEquality().equals(
                  other.enabled,
                  enabled,
                )) &&
            (identical(other.types, types) ||
                const DeepCollectionEquality().equals(other.types, types)) &&
            (identical(other.options, options) ||
                const DeepCollectionEquality().equals(other.options, options)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(enabled) ^
      const DeepCollectionEquality().hash(types) ^
      const DeepCollectionEquality().hash(options) ^
      runtimeType.hashCode;
}

extension $WebhookSettingsExtension on WebhookSettings {
  WebhookSettings copyWith({
    bool? enabled,
    double? types,
    WebhookSettings$Options? options,
  }) {
    return WebhookSettings(
      enabled: enabled ?? this.enabled,
      types: types ?? this.types,
      options: options ?? this.options,
    );
  }

  WebhookSettings copyWithWrapped({
    Wrapped<bool?>? enabled,
    Wrapped<double?>? types,
    Wrapped<WebhookSettings$Options?>? options,
  }) {
    return WebhookSettings(
      enabled: (enabled != null ? enabled.value : this.enabled),
      types: (types != null ? types.value : this.types),
      options: (options != null ? options.value : this.options),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TelegramSettings {
  const TelegramSettings({this.enabled, this.types, this.options});

  factory TelegramSettings.fromJson(Map<String, dynamic> json) =>
      _$TelegramSettingsFromJson(json);

  static const toJsonFactory = _$TelegramSettingsToJson;
  Map<String, dynamic> toJson() => _$TelegramSettingsToJson(this);

  @JsonKey(name: 'enabled', includeIfNull: false)
  final bool? enabled;
  @JsonKey(name: 'types', includeIfNull: false)
  final double? types;
  @JsonKey(name: 'options', includeIfNull: false)
  final TelegramSettings$Options? options;
  static const fromJsonFactory = _$TelegramSettingsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TelegramSettings &&
            (identical(other.enabled, enabled) ||
                const DeepCollectionEquality().equals(
                  other.enabled,
                  enabled,
                )) &&
            (identical(other.types, types) ||
                const DeepCollectionEquality().equals(other.types, types)) &&
            (identical(other.options, options) ||
                const DeepCollectionEquality().equals(other.options, options)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(enabled) ^
      const DeepCollectionEquality().hash(types) ^
      const DeepCollectionEquality().hash(options) ^
      runtimeType.hashCode;
}

extension $TelegramSettingsExtension on TelegramSettings {
  TelegramSettings copyWith({
    bool? enabled,
    double? types,
    TelegramSettings$Options? options,
  }) {
    return TelegramSettings(
      enabled: enabled ?? this.enabled,
      types: types ?? this.types,
      options: options ?? this.options,
    );
  }

  TelegramSettings copyWithWrapped({
    Wrapped<bool?>? enabled,
    Wrapped<double?>? types,
    Wrapped<TelegramSettings$Options?>? options,
  }) {
    return TelegramSettings(
      enabled: (enabled != null ? enabled.value : this.enabled),
      types: (types != null ? types.value : this.types),
      options: (options != null ? options.value : this.options),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PushbulletSettings {
  const PushbulletSettings({this.enabled, this.types, this.options});

  factory PushbulletSettings.fromJson(Map<String, dynamic> json) =>
      _$PushbulletSettingsFromJson(json);

  static const toJsonFactory = _$PushbulletSettingsToJson;
  Map<String, dynamic> toJson() => _$PushbulletSettingsToJson(this);

  @JsonKey(name: 'enabled', includeIfNull: false)
  final bool? enabled;
  @JsonKey(name: 'types', includeIfNull: false)
  final double? types;
  @JsonKey(name: 'options', includeIfNull: false)
  final PushbulletSettings$Options? options;
  static const fromJsonFactory = _$PushbulletSettingsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PushbulletSettings &&
            (identical(other.enabled, enabled) ||
                const DeepCollectionEquality().equals(
                  other.enabled,
                  enabled,
                )) &&
            (identical(other.types, types) ||
                const DeepCollectionEquality().equals(other.types, types)) &&
            (identical(other.options, options) ||
                const DeepCollectionEquality().equals(other.options, options)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(enabled) ^
      const DeepCollectionEquality().hash(types) ^
      const DeepCollectionEquality().hash(options) ^
      runtimeType.hashCode;
}

extension $PushbulletSettingsExtension on PushbulletSettings {
  PushbulletSettings copyWith({
    bool? enabled,
    double? types,
    PushbulletSettings$Options? options,
  }) {
    return PushbulletSettings(
      enabled: enabled ?? this.enabled,
      types: types ?? this.types,
      options: options ?? this.options,
    );
  }

  PushbulletSettings copyWithWrapped({
    Wrapped<bool?>? enabled,
    Wrapped<double?>? types,
    Wrapped<PushbulletSettings$Options?>? options,
  }) {
    return PushbulletSettings(
      enabled: (enabled != null ? enabled.value : this.enabled),
      types: (types != null ? types.value : this.types),
      options: (options != null ? options.value : this.options),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PushoverSettings {
  const PushoverSettings({this.enabled, this.types, this.options});

  factory PushoverSettings.fromJson(Map<String, dynamic> json) =>
      _$PushoverSettingsFromJson(json);

  static const toJsonFactory = _$PushoverSettingsToJson;
  Map<String, dynamic> toJson() => _$PushoverSettingsToJson(this);

  @JsonKey(name: 'enabled', includeIfNull: false)
  final bool? enabled;
  @JsonKey(name: 'types', includeIfNull: false)
  final double? types;
  @JsonKey(name: 'options', includeIfNull: false)
  final PushoverSettings$Options? options;
  static const fromJsonFactory = _$PushoverSettingsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PushoverSettings &&
            (identical(other.enabled, enabled) ||
                const DeepCollectionEquality().equals(
                  other.enabled,
                  enabled,
                )) &&
            (identical(other.types, types) ||
                const DeepCollectionEquality().equals(other.types, types)) &&
            (identical(other.options, options) ||
                const DeepCollectionEquality().equals(other.options, options)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(enabled) ^
      const DeepCollectionEquality().hash(types) ^
      const DeepCollectionEquality().hash(options) ^
      runtimeType.hashCode;
}

extension $PushoverSettingsExtension on PushoverSettings {
  PushoverSettings copyWith({
    bool? enabled,
    double? types,
    PushoverSettings$Options? options,
  }) {
    return PushoverSettings(
      enabled: enabled ?? this.enabled,
      types: types ?? this.types,
      options: options ?? this.options,
    );
  }

  PushoverSettings copyWithWrapped({
    Wrapped<bool?>? enabled,
    Wrapped<double?>? types,
    Wrapped<PushoverSettings$Options?>? options,
  }) {
    return PushoverSettings(
      enabled: (enabled != null ? enabled.value : this.enabled),
      types: (types != null ? types.value : this.types),
      options: (options != null ? options.value : this.options),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class GotifySettings {
  const GotifySettings({this.enabled, this.types, this.options});

  factory GotifySettings.fromJson(Map<String, dynamic> json) =>
      _$GotifySettingsFromJson(json);

  static const toJsonFactory = _$GotifySettingsToJson;
  Map<String, dynamic> toJson() => _$GotifySettingsToJson(this);

  @JsonKey(name: 'enabled', includeIfNull: false)
  final bool? enabled;
  @JsonKey(name: 'types', includeIfNull: false)
  final double? types;
  @JsonKey(name: 'options', includeIfNull: false)
  final GotifySettings$Options? options;
  static const fromJsonFactory = _$GotifySettingsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is GotifySettings &&
            (identical(other.enabled, enabled) ||
                const DeepCollectionEquality().equals(
                  other.enabled,
                  enabled,
                )) &&
            (identical(other.types, types) ||
                const DeepCollectionEquality().equals(other.types, types)) &&
            (identical(other.options, options) ||
                const DeepCollectionEquality().equals(other.options, options)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(enabled) ^
      const DeepCollectionEquality().hash(types) ^
      const DeepCollectionEquality().hash(options) ^
      runtimeType.hashCode;
}

extension $GotifySettingsExtension on GotifySettings {
  GotifySettings copyWith({
    bool? enabled,
    double? types,
    GotifySettings$Options? options,
  }) {
    return GotifySettings(
      enabled: enabled ?? this.enabled,
      types: types ?? this.types,
      options: options ?? this.options,
    );
  }

  GotifySettings copyWithWrapped({
    Wrapped<bool?>? enabled,
    Wrapped<double?>? types,
    Wrapped<GotifySettings$Options?>? options,
  }) {
    return GotifySettings(
      enabled: (enabled != null ? enabled.value : this.enabled),
      types: (types != null ? types.value : this.types),
      options: (options != null ? options.value : this.options),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class NtfySettings {
  const NtfySettings({this.enabled, this.types, this.options});

  factory NtfySettings.fromJson(Map<String, dynamic> json) =>
      _$NtfySettingsFromJson(json);

  static const toJsonFactory = _$NtfySettingsToJson;
  Map<String, dynamic> toJson() => _$NtfySettingsToJson(this);

  @JsonKey(name: 'enabled', includeIfNull: false)
  final bool? enabled;
  @JsonKey(name: 'types', includeIfNull: false)
  final double? types;
  @JsonKey(name: 'options', includeIfNull: false)
  final NtfySettings$Options? options;
  static const fromJsonFactory = _$NtfySettingsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is NtfySettings &&
            (identical(other.enabled, enabled) ||
                const DeepCollectionEquality().equals(
                  other.enabled,
                  enabled,
                )) &&
            (identical(other.types, types) ||
                const DeepCollectionEquality().equals(other.types, types)) &&
            (identical(other.options, options) ||
                const DeepCollectionEquality().equals(other.options, options)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(enabled) ^
      const DeepCollectionEquality().hash(types) ^
      const DeepCollectionEquality().hash(options) ^
      runtimeType.hashCode;
}

extension $NtfySettingsExtension on NtfySettings {
  NtfySettings copyWith({
    bool? enabled,
    double? types,
    NtfySettings$Options? options,
  }) {
    return NtfySettings(
      enabled: enabled ?? this.enabled,
      types: types ?? this.types,
      options: options ?? this.options,
    );
  }

  NtfySettings copyWithWrapped({
    Wrapped<bool?>? enabled,
    Wrapped<double?>? types,
    Wrapped<NtfySettings$Options?>? options,
  }) {
    return NtfySettings(
      enabled: (enabled != null ? enabled.value : this.enabled),
      types: (types != null ? types.value : this.types),
      options: (options != null ? options.value : this.options),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class NotificationEmailSettings {
  const NotificationEmailSettings({this.enabled, this.types, this.options});

  factory NotificationEmailSettings.fromJson(Map<String, dynamic> json) =>
      _$NotificationEmailSettingsFromJson(json);

  static const toJsonFactory = _$NotificationEmailSettingsToJson;
  Map<String, dynamic> toJson() => _$NotificationEmailSettingsToJson(this);

  @JsonKey(name: 'enabled', includeIfNull: false)
  final bool? enabled;
  @JsonKey(name: 'types', includeIfNull: false)
  final double? types;
  @JsonKey(name: 'options', includeIfNull: false)
  final NotificationEmailSettings$Options? options;
  static const fromJsonFactory = _$NotificationEmailSettingsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is NotificationEmailSettings &&
            (identical(other.enabled, enabled) ||
                const DeepCollectionEquality().equals(
                  other.enabled,
                  enabled,
                )) &&
            (identical(other.types, types) ||
                const DeepCollectionEquality().equals(other.types, types)) &&
            (identical(other.options, options) ||
                const DeepCollectionEquality().equals(other.options, options)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(enabled) ^
      const DeepCollectionEquality().hash(types) ^
      const DeepCollectionEquality().hash(options) ^
      runtimeType.hashCode;
}

extension $NotificationEmailSettingsExtension on NotificationEmailSettings {
  NotificationEmailSettings copyWith({
    bool? enabled,
    double? types,
    NotificationEmailSettings$Options? options,
  }) {
    return NotificationEmailSettings(
      enabled: enabled ?? this.enabled,
      types: types ?? this.types,
      options: options ?? this.options,
    );
  }

  NotificationEmailSettings copyWithWrapped({
    Wrapped<bool?>? enabled,
    Wrapped<double?>? types,
    Wrapped<NotificationEmailSettings$Options?>? options,
  }) {
    return NotificationEmailSettings(
      enabled: (enabled != null ? enabled.value : this.enabled),
      types: (types != null ? types.value : this.types),
      options: (options != null ? options.value : this.options),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Job {
  const Job({
    this.id,
    this.type,
    this.interval,
    this.name,
    this.nextExecutionTime,
    this.running,
  });

  factory Job.fromJson(Map<String, dynamic> json) => _$JobFromJson(json);

  static const toJsonFactory = _$JobToJson;
  Map<String, dynamic> toJson() => _$JobToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final String? id;
  @JsonKey(
    name: 'type',
    includeIfNull: false,
    toJson: jobTypeNullableToJson,
    fromJson: jobTypeNullableFromJson,
  )
  final enums.JobType? type;
  @JsonKey(
    name: 'interval',
    includeIfNull: false,
    toJson: jobIntervalNullableToJson,
    fromJson: jobIntervalNullableFromJson,
  )
  final enums.JobInterval? interval;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(name: 'nextExecutionTime', includeIfNull: false)
  final String? nextExecutionTime;
  @JsonKey(name: 'running', includeIfNull: false)
  final bool? running;
  static const fromJsonFactory = _$JobFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Job &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.interval, interval) ||
                const DeepCollectionEquality().equals(
                  other.interval,
                  interval,
                )) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.nextExecutionTime, nextExecutionTime) ||
                const DeepCollectionEquality().equals(
                  other.nextExecutionTime,
                  nextExecutionTime,
                )) &&
            (identical(other.running, running) ||
                const DeepCollectionEquality().equals(other.running, running)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(interval) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(nextExecutionTime) ^
      const DeepCollectionEquality().hash(running) ^
      runtimeType.hashCode;
}

extension $JobExtension on Job {
  Job copyWith({
    String? id,
    enums.JobType? type,
    enums.JobInterval? interval,
    String? name,
    String? nextExecutionTime,
    bool? running,
  }) {
    return Job(
      id: id ?? this.id,
      type: type ?? this.type,
      interval: interval ?? this.interval,
      name: name ?? this.name,
      nextExecutionTime: nextExecutionTime ?? this.nextExecutionTime,
      running: running ?? this.running,
    );
  }

  Job copyWithWrapped({
    Wrapped<String?>? id,
    Wrapped<enums.JobType?>? type,
    Wrapped<enums.JobInterval?>? interval,
    Wrapped<String?>? name,
    Wrapped<String?>? nextExecutionTime,
    Wrapped<bool?>? running,
  }) {
    return Job(
      id: (id != null ? id.value : this.id),
      type: (type != null ? type.value : this.type),
      interval: (interval != null ? interval.value : this.interval),
      name: (name != null ? name.value : this.name),
      nextExecutionTime: (nextExecutionTime != null
          ? nextExecutionTime.value
          : this.nextExecutionTime),
      running: (running != null ? running.value : this.running),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PersonDetails {
  const PersonDetails({
    this.id,
    this.name,
    this.deathday,
    this.knownForDepartment,
    this.alsoKnownAs,
    this.gender,
    this.biography,
    this.popularity,
    this.placeOfBirth,
    this.profilePath,
    this.adult,
    this.imdbId,
    this.homepage,
  });

  factory PersonDetails.fromJson(Map<String, dynamic> json) =>
      _$PersonDetailsFromJson(json);

  static const toJsonFactory = _$PersonDetailsToJson;
  Map<String, dynamic> toJson() => _$PersonDetailsToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final double? id;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(name: 'deathday', includeIfNull: false)
  final String? deathday;
  @JsonKey(name: 'knownForDepartment', includeIfNull: false)
  final String? knownForDepartment;
  @JsonKey(name: 'alsoKnownAs', includeIfNull: false, defaultValue: <String>[])
  final List<String>? alsoKnownAs;
  @JsonKey(name: 'gender', includeIfNull: false)
  final String? gender;
  @JsonKey(name: 'biography', includeIfNull: false)
  final String? biography;
  @JsonKey(name: 'popularity', includeIfNull: false)
  final String? popularity;
  @JsonKey(name: 'placeOfBirth', includeIfNull: false)
  final String? placeOfBirth;
  @JsonKey(name: 'profilePath', includeIfNull: false)
  final String? profilePath;
  @JsonKey(name: 'adult', includeIfNull: false)
  final bool? adult;
  @JsonKey(name: 'imdbId', includeIfNull: false)
  final String? imdbId;
  @JsonKey(name: 'homepage', includeIfNull: false)
  final String? homepage;
  static const fromJsonFactory = _$PersonDetailsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PersonDetails &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.deathday, deathday) ||
                const DeepCollectionEquality().equals(
                  other.deathday,
                  deathday,
                )) &&
            (identical(other.knownForDepartment, knownForDepartment) ||
                const DeepCollectionEquality().equals(
                  other.knownForDepartment,
                  knownForDepartment,
                )) &&
            (identical(other.alsoKnownAs, alsoKnownAs) ||
                const DeepCollectionEquality().equals(
                  other.alsoKnownAs,
                  alsoKnownAs,
                )) &&
            (identical(other.gender, gender) ||
                const DeepCollectionEquality().equals(other.gender, gender)) &&
            (identical(other.biography, biography) ||
                const DeepCollectionEquality().equals(
                  other.biography,
                  biography,
                )) &&
            (identical(other.popularity, popularity) ||
                const DeepCollectionEquality().equals(
                  other.popularity,
                  popularity,
                )) &&
            (identical(other.placeOfBirth, placeOfBirth) ||
                const DeepCollectionEquality().equals(
                  other.placeOfBirth,
                  placeOfBirth,
                )) &&
            (identical(other.profilePath, profilePath) ||
                const DeepCollectionEquality().equals(
                  other.profilePath,
                  profilePath,
                )) &&
            (identical(other.adult, adult) ||
                const DeepCollectionEquality().equals(other.adult, adult)) &&
            (identical(other.imdbId, imdbId) ||
                const DeepCollectionEquality().equals(other.imdbId, imdbId)) &&
            (identical(other.homepage, homepage) ||
                const DeepCollectionEquality().equals(
                  other.homepage,
                  homepage,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(deathday) ^
      const DeepCollectionEquality().hash(knownForDepartment) ^
      const DeepCollectionEquality().hash(alsoKnownAs) ^
      const DeepCollectionEquality().hash(gender) ^
      const DeepCollectionEquality().hash(biography) ^
      const DeepCollectionEquality().hash(popularity) ^
      const DeepCollectionEquality().hash(placeOfBirth) ^
      const DeepCollectionEquality().hash(profilePath) ^
      const DeepCollectionEquality().hash(adult) ^
      const DeepCollectionEquality().hash(imdbId) ^
      const DeepCollectionEquality().hash(homepage) ^
      runtimeType.hashCode;
}

extension $PersonDetailsExtension on PersonDetails {
  PersonDetails copyWith({
    double? id,
    String? name,
    String? deathday,
    String? knownForDepartment,
    List<String>? alsoKnownAs,
    String? gender,
    String? biography,
    String? popularity,
    String? placeOfBirth,
    String? profilePath,
    bool? adult,
    String? imdbId,
    String? homepage,
  }) {
    return PersonDetails(
      id: id ?? this.id,
      name: name ?? this.name,
      deathday: deathday ?? this.deathday,
      knownForDepartment: knownForDepartment ?? this.knownForDepartment,
      alsoKnownAs: alsoKnownAs ?? this.alsoKnownAs,
      gender: gender ?? this.gender,
      biography: biography ?? this.biography,
      popularity: popularity ?? this.popularity,
      placeOfBirth: placeOfBirth ?? this.placeOfBirth,
      profilePath: profilePath ?? this.profilePath,
      adult: adult ?? this.adult,
      imdbId: imdbId ?? this.imdbId,
      homepage: homepage ?? this.homepage,
    );
  }

  PersonDetails copyWithWrapped({
    Wrapped<double?>? id,
    Wrapped<String?>? name,
    Wrapped<String?>? deathday,
    Wrapped<String?>? knownForDepartment,
    Wrapped<List<String>?>? alsoKnownAs,
    Wrapped<String?>? gender,
    Wrapped<String?>? biography,
    Wrapped<String?>? popularity,
    Wrapped<String?>? placeOfBirth,
    Wrapped<String?>? profilePath,
    Wrapped<bool?>? adult,
    Wrapped<String?>? imdbId,
    Wrapped<String?>? homepage,
  }) {
    return PersonDetails(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
      deathday: (deathday != null ? deathday.value : this.deathday),
      knownForDepartment: (knownForDepartment != null
          ? knownForDepartment.value
          : this.knownForDepartment),
      alsoKnownAs: (alsoKnownAs != null ? alsoKnownAs.value : this.alsoKnownAs),
      gender: (gender != null ? gender.value : this.gender),
      biography: (biography != null ? biography.value : this.biography),
      popularity: (popularity != null ? popularity.value : this.popularity),
      placeOfBirth: (placeOfBirth != null
          ? placeOfBirth.value
          : this.placeOfBirth),
      profilePath: (profilePath != null ? profilePath.value : this.profilePath),
      adult: (adult != null ? adult.value : this.adult),
      imdbId: (imdbId != null ? imdbId.value : this.imdbId),
      homepage: (homepage != null ? homepage.value : this.homepage),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CreditCast {
  const CreditCast({
    this.id,
    this.originalLanguage,
    this.episodeCount,
    this.overview,
    this.originCountry,
    this.originalName,
    this.voteCount,
    this.name,
    this.mediaType,
    this.popularity,
    this.creditId,
    this.backdropPath,
    this.firstAirDate,
    this.voteAverage,
    this.genreIds,
    this.posterPath,
    this.originalTitle,
    this.video,
    this.title,
    this.adult,
    this.releaseDate,
    this.character,
    this.mediaInfo,
  });

  factory CreditCast.fromJson(Map<String, dynamic> json) =>
      _$CreditCastFromJson(json);

  static const toJsonFactory = _$CreditCastToJson;
  Map<String, dynamic> toJson() => _$CreditCastToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final double? id;
  @JsonKey(name: 'originalLanguage', includeIfNull: false)
  final String? originalLanguage;
  @JsonKey(name: 'episodeCount', includeIfNull: false)
  final double? episodeCount;
  @JsonKey(name: 'overview', includeIfNull: false)
  final String? overview;
  @JsonKey(
    name: 'originCountry',
    includeIfNull: false,
    defaultValue: <String>[],
  )
  final List<String>? originCountry;
  @JsonKey(name: 'originalName', includeIfNull: false)
  final String? originalName;
  @JsonKey(name: 'voteCount', includeIfNull: false)
  final double? voteCount;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(name: 'mediaType', includeIfNull: false)
  final String? mediaType;
  @JsonKey(name: 'popularity', includeIfNull: false)
  final double? popularity;
  @JsonKey(name: 'creditId', includeIfNull: false)
  final String? creditId;
  @JsonKey(name: 'backdropPath', includeIfNull: false)
  final String? backdropPath;
  @JsonKey(name: 'firstAirDate', includeIfNull: false)
  final String? firstAirDate;
  @JsonKey(name: 'voteAverage', includeIfNull: false)
  final double? voteAverage;
  @JsonKey(name: 'genreIds', includeIfNull: false, defaultValue: <double>[])
  final List<double>? genreIds;
  @JsonKey(name: 'posterPath', includeIfNull: false)
  final String? posterPath;
  @JsonKey(name: 'originalTitle', includeIfNull: false)
  final String? originalTitle;
  @JsonKey(name: 'video', includeIfNull: false)
  final bool? video;
  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;
  @JsonKey(name: 'adult', includeIfNull: false)
  final bool? adult;
  @JsonKey(name: 'releaseDate', includeIfNull: false)
  final String? releaseDate;
  @JsonKey(name: 'character', includeIfNull: false)
  final String? character;
  @JsonKey(name: 'mediaInfo', includeIfNull: false)
  final MediaInfo? mediaInfo;
  static const fromJsonFactory = _$CreditCastFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CreditCast &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.originalLanguage, originalLanguage) ||
                const DeepCollectionEquality().equals(
                  other.originalLanguage,
                  originalLanguage,
                )) &&
            (identical(other.episodeCount, episodeCount) ||
                const DeepCollectionEquality().equals(
                  other.episodeCount,
                  episodeCount,
                )) &&
            (identical(other.overview, overview) ||
                const DeepCollectionEquality().equals(
                  other.overview,
                  overview,
                )) &&
            (identical(other.originCountry, originCountry) ||
                const DeepCollectionEquality().equals(
                  other.originCountry,
                  originCountry,
                )) &&
            (identical(other.originalName, originalName) ||
                const DeepCollectionEquality().equals(
                  other.originalName,
                  originalName,
                )) &&
            (identical(other.voteCount, voteCount) ||
                const DeepCollectionEquality().equals(
                  other.voteCount,
                  voteCount,
                )) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.mediaType, mediaType) ||
                const DeepCollectionEquality().equals(
                  other.mediaType,
                  mediaType,
                )) &&
            (identical(other.popularity, popularity) ||
                const DeepCollectionEquality().equals(
                  other.popularity,
                  popularity,
                )) &&
            (identical(other.creditId, creditId) ||
                const DeepCollectionEquality().equals(
                  other.creditId,
                  creditId,
                )) &&
            (identical(other.backdropPath, backdropPath) ||
                const DeepCollectionEquality().equals(
                  other.backdropPath,
                  backdropPath,
                )) &&
            (identical(other.firstAirDate, firstAirDate) ||
                const DeepCollectionEquality().equals(
                  other.firstAirDate,
                  firstAirDate,
                )) &&
            (identical(other.voteAverage, voteAverage) ||
                const DeepCollectionEquality().equals(
                  other.voteAverage,
                  voteAverage,
                )) &&
            (identical(other.genreIds, genreIds) ||
                const DeepCollectionEquality().equals(
                  other.genreIds,
                  genreIds,
                )) &&
            (identical(other.posterPath, posterPath) ||
                const DeepCollectionEquality().equals(
                  other.posterPath,
                  posterPath,
                )) &&
            (identical(other.originalTitle, originalTitle) ||
                const DeepCollectionEquality().equals(
                  other.originalTitle,
                  originalTitle,
                )) &&
            (identical(other.video, video) ||
                const DeepCollectionEquality().equals(other.video, video)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.adult, adult) ||
                const DeepCollectionEquality().equals(other.adult, adult)) &&
            (identical(other.releaseDate, releaseDate) ||
                const DeepCollectionEquality().equals(
                  other.releaseDate,
                  releaseDate,
                )) &&
            (identical(other.character, character) ||
                const DeepCollectionEquality().equals(
                  other.character,
                  character,
                )) &&
            (identical(other.mediaInfo, mediaInfo) ||
                const DeepCollectionEquality().equals(
                  other.mediaInfo,
                  mediaInfo,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(originalLanguage) ^
      const DeepCollectionEquality().hash(episodeCount) ^
      const DeepCollectionEquality().hash(overview) ^
      const DeepCollectionEquality().hash(originCountry) ^
      const DeepCollectionEquality().hash(originalName) ^
      const DeepCollectionEquality().hash(voteCount) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(mediaType) ^
      const DeepCollectionEquality().hash(popularity) ^
      const DeepCollectionEquality().hash(creditId) ^
      const DeepCollectionEquality().hash(backdropPath) ^
      const DeepCollectionEquality().hash(firstAirDate) ^
      const DeepCollectionEquality().hash(voteAverage) ^
      const DeepCollectionEquality().hash(genreIds) ^
      const DeepCollectionEquality().hash(posterPath) ^
      const DeepCollectionEquality().hash(originalTitle) ^
      const DeepCollectionEquality().hash(video) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(adult) ^
      const DeepCollectionEquality().hash(releaseDate) ^
      const DeepCollectionEquality().hash(character) ^
      const DeepCollectionEquality().hash(mediaInfo) ^
      runtimeType.hashCode;
}

extension $CreditCastExtension on CreditCast {
  CreditCast copyWith({
    double? id,
    String? originalLanguage,
    double? episodeCount,
    String? overview,
    List<String>? originCountry,
    String? originalName,
    double? voteCount,
    String? name,
    String? mediaType,
    double? popularity,
    String? creditId,
    String? backdropPath,
    String? firstAirDate,
    double? voteAverage,
    List<double>? genreIds,
    String? posterPath,
    String? originalTitle,
    bool? video,
    String? title,
    bool? adult,
    String? releaseDate,
    String? character,
    MediaInfo? mediaInfo,
  }) {
    return CreditCast(
      id: id ?? this.id,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      episodeCount: episodeCount ?? this.episodeCount,
      overview: overview ?? this.overview,
      originCountry: originCountry ?? this.originCountry,
      originalName: originalName ?? this.originalName,
      voteCount: voteCount ?? this.voteCount,
      name: name ?? this.name,
      mediaType: mediaType ?? this.mediaType,
      popularity: popularity ?? this.popularity,
      creditId: creditId ?? this.creditId,
      backdropPath: backdropPath ?? this.backdropPath,
      firstAirDate: firstAirDate ?? this.firstAirDate,
      voteAverage: voteAverage ?? this.voteAverage,
      genreIds: genreIds ?? this.genreIds,
      posterPath: posterPath ?? this.posterPath,
      originalTitle: originalTitle ?? this.originalTitle,
      video: video ?? this.video,
      title: title ?? this.title,
      adult: adult ?? this.adult,
      releaseDate: releaseDate ?? this.releaseDate,
      character: character ?? this.character,
      mediaInfo: mediaInfo ?? this.mediaInfo,
    );
  }

  CreditCast copyWithWrapped({
    Wrapped<double?>? id,
    Wrapped<String?>? originalLanguage,
    Wrapped<double?>? episodeCount,
    Wrapped<String?>? overview,
    Wrapped<List<String>?>? originCountry,
    Wrapped<String?>? originalName,
    Wrapped<double?>? voteCount,
    Wrapped<String?>? name,
    Wrapped<String?>? mediaType,
    Wrapped<double?>? popularity,
    Wrapped<String?>? creditId,
    Wrapped<String?>? backdropPath,
    Wrapped<String?>? firstAirDate,
    Wrapped<double?>? voteAverage,
    Wrapped<List<double>?>? genreIds,
    Wrapped<String?>? posterPath,
    Wrapped<String?>? originalTitle,
    Wrapped<bool?>? video,
    Wrapped<String?>? title,
    Wrapped<bool?>? adult,
    Wrapped<String?>? releaseDate,
    Wrapped<String?>? character,
    Wrapped<MediaInfo?>? mediaInfo,
  }) {
    return CreditCast(
      id: (id != null ? id.value : this.id),
      originalLanguage: (originalLanguage != null
          ? originalLanguage.value
          : this.originalLanguage),
      episodeCount: (episodeCount != null
          ? episodeCount.value
          : this.episodeCount),
      overview: (overview != null ? overview.value : this.overview),
      originCountry: (originCountry != null
          ? originCountry.value
          : this.originCountry),
      originalName: (originalName != null
          ? originalName.value
          : this.originalName),
      voteCount: (voteCount != null ? voteCount.value : this.voteCount),
      name: (name != null ? name.value : this.name),
      mediaType: (mediaType != null ? mediaType.value : this.mediaType),
      popularity: (popularity != null ? popularity.value : this.popularity),
      creditId: (creditId != null ? creditId.value : this.creditId),
      backdropPath: (backdropPath != null
          ? backdropPath.value
          : this.backdropPath),
      firstAirDate: (firstAirDate != null
          ? firstAirDate.value
          : this.firstAirDate),
      voteAverage: (voteAverage != null ? voteAverage.value : this.voteAverage),
      genreIds: (genreIds != null ? genreIds.value : this.genreIds),
      posterPath: (posterPath != null ? posterPath.value : this.posterPath),
      originalTitle: (originalTitle != null
          ? originalTitle.value
          : this.originalTitle),
      video: (video != null ? video.value : this.video),
      title: (title != null ? title.value : this.title),
      adult: (adult != null ? adult.value : this.adult),
      releaseDate: (releaseDate != null ? releaseDate.value : this.releaseDate),
      character: (character != null ? character.value : this.character),
      mediaInfo: (mediaInfo != null ? mediaInfo.value : this.mediaInfo),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CreditCrew {
  const CreditCrew({
    this.id,
    this.originalLanguage,
    this.episodeCount,
    this.overview,
    this.originCountry,
    this.originalName,
    this.voteCount,
    this.name,
    this.mediaType,
    this.popularity,
    this.creditId,
    this.backdropPath,
    this.firstAirDate,
    this.voteAverage,
    this.genreIds,
    this.posterPath,
    this.originalTitle,
    this.video,
    this.title,
    this.adult,
    this.releaseDate,
    this.department,
    this.job,
    this.mediaInfo,
  });

  factory CreditCrew.fromJson(Map<String, dynamic> json) =>
      _$CreditCrewFromJson(json);

  static const toJsonFactory = _$CreditCrewToJson;
  Map<String, dynamic> toJson() => _$CreditCrewToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final double? id;
  @JsonKey(name: 'originalLanguage', includeIfNull: false)
  final String? originalLanguage;
  @JsonKey(name: 'episodeCount', includeIfNull: false)
  final double? episodeCount;
  @JsonKey(name: 'overview', includeIfNull: false)
  final String? overview;
  @JsonKey(
    name: 'originCountry',
    includeIfNull: false,
    defaultValue: <String>[],
  )
  final List<String>? originCountry;
  @JsonKey(name: 'originalName', includeIfNull: false)
  final String? originalName;
  @JsonKey(name: 'voteCount', includeIfNull: false)
  final double? voteCount;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(name: 'mediaType', includeIfNull: false)
  final String? mediaType;
  @JsonKey(name: 'popularity', includeIfNull: false)
  final double? popularity;
  @JsonKey(name: 'creditId', includeIfNull: false)
  final String? creditId;
  @JsonKey(name: 'backdropPath', includeIfNull: false)
  final String? backdropPath;
  @JsonKey(name: 'firstAirDate', includeIfNull: false)
  final String? firstAirDate;
  @JsonKey(name: 'voteAverage', includeIfNull: false)
  final double? voteAverage;
  @JsonKey(name: 'genreIds', includeIfNull: false, defaultValue: <double>[])
  final List<double>? genreIds;
  @JsonKey(name: 'posterPath', includeIfNull: false)
  final String? posterPath;
  @JsonKey(name: 'originalTitle', includeIfNull: false)
  final String? originalTitle;
  @JsonKey(name: 'video', includeIfNull: false)
  final bool? video;
  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;
  @JsonKey(name: 'adult', includeIfNull: false)
  final bool? adult;
  @JsonKey(name: 'releaseDate', includeIfNull: false)
  final String? releaseDate;
  @JsonKey(name: 'department', includeIfNull: false)
  final String? department;
  @JsonKey(name: 'job', includeIfNull: false)
  final String? job;
  @JsonKey(name: 'mediaInfo', includeIfNull: false)
  final MediaInfo? mediaInfo;
  static const fromJsonFactory = _$CreditCrewFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CreditCrew &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.originalLanguage, originalLanguage) ||
                const DeepCollectionEquality().equals(
                  other.originalLanguage,
                  originalLanguage,
                )) &&
            (identical(other.episodeCount, episodeCount) ||
                const DeepCollectionEquality().equals(
                  other.episodeCount,
                  episodeCount,
                )) &&
            (identical(other.overview, overview) ||
                const DeepCollectionEquality().equals(
                  other.overview,
                  overview,
                )) &&
            (identical(other.originCountry, originCountry) ||
                const DeepCollectionEquality().equals(
                  other.originCountry,
                  originCountry,
                )) &&
            (identical(other.originalName, originalName) ||
                const DeepCollectionEquality().equals(
                  other.originalName,
                  originalName,
                )) &&
            (identical(other.voteCount, voteCount) ||
                const DeepCollectionEquality().equals(
                  other.voteCount,
                  voteCount,
                )) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.mediaType, mediaType) ||
                const DeepCollectionEquality().equals(
                  other.mediaType,
                  mediaType,
                )) &&
            (identical(other.popularity, popularity) ||
                const DeepCollectionEquality().equals(
                  other.popularity,
                  popularity,
                )) &&
            (identical(other.creditId, creditId) ||
                const DeepCollectionEquality().equals(
                  other.creditId,
                  creditId,
                )) &&
            (identical(other.backdropPath, backdropPath) ||
                const DeepCollectionEquality().equals(
                  other.backdropPath,
                  backdropPath,
                )) &&
            (identical(other.firstAirDate, firstAirDate) ||
                const DeepCollectionEquality().equals(
                  other.firstAirDate,
                  firstAirDate,
                )) &&
            (identical(other.voteAverage, voteAverage) ||
                const DeepCollectionEquality().equals(
                  other.voteAverage,
                  voteAverage,
                )) &&
            (identical(other.genreIds, genreIds) ||
                const DeepCollectionEquality().equals(
                  other.genreIds,
                  genreIds,
                )) &&
            (identical(other.posterPath, posterPath) ||
                const DeepCollectionEquality().equals(
                  other.posterPath,
                  posterPath,
                )) &&
            (identical(other.originalTitle, originalTitle) ||
                const DeepCollectionEquality().equals(
                  other.originalTitle,
                  originalTitle,
                )) &&
            (identical(other.video, video) ||
                const DeepCollectionEquality().equals(other.video, video)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.adult, adult) ||
                const DeepCollectionEquality().equals(other.adult, adult)) &&
            (identical(other.releaseDate, releaseDate) ||
                const DeepCollectionEquality().equals(
                  other.releaseDate,
                  releaseDate,
                )) &&
            (identical(other.department, department) ||
                const DeepCollectionEquality().equals(
                  other.department,
                  department,
                )) &&
            (identical(other.job, job) ||
                const DeepCollectionEquality().equals(other.job, job)) &&
            (identical(other.mediaInfo, mediaInfo) ||
                const DeepCollectionEquality().equals(
                  other.mediaInfo,
                  mediaInfo,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(originalLanguage) ^
      const DeepCollectionEquality().hash(episodeCount) ^
      const DeepCollectionEquality().hash(overview) ^
      const DeepCollectionEquality().hash(originCountry) ^
      const DeepCollectionEquality().hash(originalName) ^
      const DeepCollectionEquality().hash(voteCount) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(mediaType) ^
      const DeepCollectionEquality().hash(popularity) ^
      const DeepCollectionEquality().hash(creditId) ^
      const DeepCollectionEquality().hash(backdropPath) ^
      const DeepCollectionEquality().hash(firstAirDate) ^
      const DeepCollectionEquality().hash(voteAverage) ^
      const DeepCollectionEquality().hash(genreIds) ^
      const DeepCollectionEquality().hash(posterPath) ^
      const DeepCollectionEquality().hash(originalTitle) ^
      const DeepCollectionEquality().hash(video) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(adult) ^
      const DeepCollectionEquality().hash(releaseDate) ^
      const DeepCollectionEquality().hash(department) ^
      const DeepCollectionEquality().hash(job) ^
      const DeepCollectionEquality().hash(mediaInfo) ^
      runtimeType.hashCode;
}

extension $CreditCrewExtension on CreditCrew {
  CreditCrew copyWith({
    double? id,
    String? originalLanguage,
    double? episodeCount,
    String? overview,
    List<String>? originCountry,
    String? originalName,
    double? voteCount,
    String? name,
    String? mediaType,
    double? popularity,
    String? creditId,
    String? backdropPath,
    String? firstAirDate,
    double? voteAverage,
    List<double>? genreIds,
    String? posterPath,
    String? originalTitle,
    bool? video,
    String? title,
    bool? adult,
    String? releaseDate,
    String? department,
    String? job,
    MediaInfo? mediaInfo,
  }) {
    return CreditCrew(
      id: id ?? this.id,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      episodeCount: episodeCount ?? this.episodeCount,
      overview: overview ?? this.overview,
      originCountry: originCountry ?? this.originCountry,
      originalName: originalName ?? this.originalName,
      voteCount: voteCount ?? this.voteCount,
      name: name ?? this.name,
      mediaType: mediaType ?? this.mediaType,
      popularity: popularity ?? this.popularity,
      creditId: creditId ?? this.creditId,
      backdropPath: backdropPath ?? this.backdropPath,
      firstAirDate: firstAirDate ?? this.firstAirDate,
      voteAverage: voteAverage ?? this.voteAverage,
      genreIds: genreIds ?? this.genreIds,
      posterPath: posterPath ?? this.posterPath,
      originalTitle: originalTitle ?? this.originalTitle,
      video: video ?? this.video,
      title: title ?? this.title,
      adult: adult ?? this.adult,
      releaseDate: releaseDate ?? this.releaseDate,
      department: department ?? this.department,
      job: job ?? this.job,
      mediaInfo: mediaInfo ?? this.mediaInfo,
    );
  }

  CreditCrew copyWithWrapped({
    Wrapped<double?>? id,
    Wrapped<String?>? originalLanguage,
    Wrapped<double?>? episodeCount,
    Wrapped<String?>? overview,
    Wrapped<List<String>?>? originCountry,
    Wrapped<String?>? originalName,
    Wrapped<double?>? voteCount,
    Wrapped<String?>? name,
    Wrapped<String?>? mediaType,
    Wrapped<double?>? popularity,
    Wrapped<String?>? creditId,
    Wrapped<String?>? backdropPath,
    Wrapped<String?>? firstAirDate,
    Wrapped<double?>? voteAverage,
    Wrapped<List<double>?>? genreIds,
    Wrapped<String?>? posterPath,
    Wrapped<String?>? originalTitle,
    Wrapped<bool?>? video,
    Wrapped<String?>? title,
    Wrapped<bool?>? adult,
    Wrapped<String?>? releaseDate,
    Wrapped<String?>? department,
    Wrapped<String?>? job,
    Wrapped<MediaInfo?>? mediaInfo,
  }) {
    return CreditCrew(
      id: (id != null ? id.value : this.id),
      originalLanguage: (originalLanguage != null
          ? originalLanguage.value
          : this.originalLanguage),
      episodeCount: (episodeCount != null
          ? episodeCount.value
          : this.episodeCount),
      overview: (overview != null ? overview.value : this.overview),
      originCountry: (originCountry != null
          ? originCountry.value
          : this.originCountry),
      originalName: (originalName != null
          ? originalName.value
          : this.originalName),
      voteCount: (voteCount != null ? voteCount.value : this.voteCount),
      name: (name != null ? name.value : this.name),
      mediaType: (mediaType != null ? mediaType.value : this.mediaType),
      popularity: (popularity != null ? popularity.value : this.popularity),
      creditId: (creditId != null ? creditId.value : this.creditId),
      backdropPath: (backdropPath != null
          ? backdropPath.value
          : this.backdropPath),
      firstAirDate: (firstAirDate != null
          ? firstAirDate.value
          : this.firstAirDate),
      voteAverage: (voteAverage != null ? voteAverage.value : this.voteAverage),
      genreIds: (genreIds != null ? genreIds.value : this.genreIds),
      posterPath: (posterPath != null ? posterPath.value : this.posterPath),
      originalTitle: (originalTitle != null
          ? originalTitle.value
          : this.originalTitle),
      video: (video != null ? video.value : this.video),
      title: (title != null ? title.value : this.title),
      adult: (adult != null ? adult.value : this.adult),
      releaseDate: (releaseDate != null ? releaseDate.value : this.releaseDate),
      department: (department != null ? department.value : this.department),
      job: (job != null ? job.value : this.job),
      mediaInfo: (mediaInfo != null ? mediaInfo.value : this.mediaInfo),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Keyword {
  const Keyword({this.id, this.name});

  factory Keyword.fromJson(Map<String, dynamic> json) =>
      _$KeywordFromJson(json);

  static const toJsonFactory = _$KeywordToJson;
  Map<String, dynamic> toJson() => _$KeywordToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final double? id;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  static const fromJsonFactory = _$KeywordFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Keyword &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      runtimeType.hashCode;
}

extension $KeywordExtension on Keyword {
  Keyword copyWith({double? id, String? name}) {
    return Keyword(id: id ?? this.id, name: name ?? this.name);
  }

  Keyword copyWithWrapped({Wrapped<double?>? id, Wrapped<String?>? name}) {
    return Keyword(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SpokenLanguage {
  const SpokenLanguage({this.englishName, this.iso6391, this.name});

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) =>
      _$SpokenLanguageFromJson(json);

  static const toJsonFactory = _$SpokenLanguageToJson;
  Map<String, dynamic> toJson() => _$SpokenLanguageToJson(this);

  @JsonKey(name: 'englishName', includeIfNull: false)
  final String? englishName;
  @JsonKey(name: 'iso_639_1', includeIfNull: false)
  final String? iso6391;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  static const fromJsonFactory = _$SpokenLanguageFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SpokenLanguage &&
            (identical(other.englishName, englishName) ||
                const DeepCollectionEquality().equals(
                  other.englishName,
                  englishName,
                )) &&
            (identical(other.iso6391, iso6391) ||
                const DeepCollectionEquality().equals(
                  other.iso6391,
                  iso6391,
                )) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(englishName) ^
      const DeepCollectionEquality().hash(iso6391) ^
      const DeepCollectionEquality().hash(name) ^
      runtimeType.hashCode;
}

extension $SpokenLanguageExtension on SpokenLanguage {
  SpokenLanguage copyWith({
    String? englishName,
    String? iso6391,
    String? name,
  }) {
    return SpokenLanguage(
      englishName: englishName ?? this.englishName,
      iso6391: iso6391 ?? this.iso6391,
      name: name ?? this.name,
    );
  }

  SpokenLanguage copyWithWrapped({
    Wrapped<String?>? englishName,
    Wrapped<String?>? iso6391,
    Wrapped<String?>? name,
  }) {
    return SpokenLanguage(
      englishName: (englishName != null ? englishName.value : this.englishName),
      iso6391: (iso6391 != null ? iso6391.value : this.iso6391),
      name: (name != null ? name.value : this.name),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Collection {
  const Collection({
    this.id,
    this.name,
    this.overview,
    this.posterPath,
    this.backdropPath,
    this.parts,
  });

  factory Collection.fromJson(Map<String, dynamic> json) =>
      _$CollectionFromJson(json);

  static const toJsonFactory = _$CollectionToJson;
  Map<String, dynamic> toJson() => _$CollectionToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final double? id;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(name: 'overview', includeIfNull: false)
  final String? overview;
  @JsonKey(name: 'posterPath', includeIfNull: false)
  final String? posterPath;
  @JsonKey(name: 'backdropPath', includeIfNull: false)
  final String? backdropPath;
  @JsonKey(name: 'parts', includeIfNull: false, defaultValue: <MovieResult>[])
  final List<MovieResult>? parts;
  static const fromJsonFactory = _$CollectionFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Collection &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.overview, overview) ||
                const DeepCollectionEquality().equals(
                  other.overview,
                  overview,
                )) &&
            (identical(other.posterPath, posterPath) ||
                const DeepCollectionEquality().equals(
                  other.posterPath,
                  posterPath,
                )) &&
            (identical(other.backdropPath, backdropPath) ||
                const DeepCollectionEquality().equals(
                  other.backdropPath,
                  backdropPath,
                )) &&
            (identical(other.parts, parts) ||
                const DeepCollectionEquality().equals(other.parts, parts)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(overview) ^
      const DeepCollectionEquality().hash(posterPath) ^
      const DeepCollectionEquality().hash(backdropPath) ^
      const DeepCollectionEquality().hash(parts) ^
      runtimeType.hashCode;
}

extension $CollectionExtension on Collection {
  Collection copyWith({
    double? id,
    String? name,
    String? overview,
    String? posterPath,
    String? backdropPath,
    List<MovieResult>? parts,
  }) {
    return Collection(
      id: id ?? this.id,
      name: name ?? this.name,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
      backdropPath: backdropPath ?? this.backdropPath,
      parts: parts ?? this.parts,
    );
  }

  Collection copyWithWrapped({
    Wrapped<double?>? id,
    Wrapped<String?>? name,
    Wrapped<String?>? overview,
    Wrapped<String?>? posterPath,
    Wrapped<String?>? backdropPath,
    Wrapped<List<MovieResult>?>? parts,
  }) {
    return Collection(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
      overview: (overview != null ? overview.value : this.overview),
      posterPath: (posterPath != null ? posterPath.value : this.posterPath),
      backdropPath: (backdropPath != null
          ? backdropPath.value
          : this.backdropPath),
      parts: (parts != null ? parts.value : this.parts),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SonarrSeries {
  const SonarrSeries({
    this.title,
    this.sortTitle,
    this.seasonCount,
    this.status,
    this.overview,
    this.network,
    this.airTime,
    this.images,
    this.remotePoster,
    this.seasons,
    this.year,
    this.path,
    this.profileId,
    this.languageProfileId,
    this.seasonFolder,
    this.monitored,
    this.useSceneNumbering,
    this.runtime,
    this.tvdbId,
    this.tvRageId,
    this.tvMazeId,
    this.firstAired,
    this.lastInfoSync,
    this.seriesType,
    this.cleanTitle,
    this.imdbId,
    this.titleSlug,
    this.certification,
    this.genres,
    this.tags,
    this.added,
    this.ratings,
    this.qualityProfileId,
    this.id,
    this.rootFolderPath,
    this.addOptions,
  });

  factory SonarrSeries.fromJson(Map<String, dynamic> json) =>
      _$SonarrSeriesFromJson(json);

  static const toJsonFactory = _$SonarrSeriesToJson;
  Map<String, dynamic> toJson() => _$SonarrSeriesToJson(this);

  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;
  @JsonKey(name: 'sortTitle', includeIfNull: false)
  final String? sortTitle;
  @JsonKey(name: 'seasonCount', includeIfNull: false)
  final double? seasonCount;
  @JsonKey(name: 'status', includeIfNull: false)
  final String? status;
  @JsonKey(name: 'overview', includeIfNull: false)
  final String? overview;
  @JsonKey(name: 'network', includeIfNull: false)
  final String? network;
  @JsonKey(name: 'airTime', includeIfNull: false)
  final String? airTime;
  @JsonKey(name: 'images', includeIfNull: false)
  final List<SonarrSeries$Images$Item>? images;
  @JsonKey(name: 'remotePoster', includeIfNull: false)
  final String? remotePoster;
  @JsonKey(name: 'seasons', includeIfNull: false)
  final List<SonarrSeries$Seasons$Item>? seasons;
  @JsonKey(name: 'year', includeIfNull: false)
  final double? year;
  @JsonKey(name: 'path', includeIfNull: false)
  final String? path;
  @JsonKey(name: 'profileId', includeIfNull: false)
  final double? profileId;
  @JsonKey(name: 'languageProfileId', includeIfNull: false)
  final double? languageProfileId;
  @JsonKey(name: 'seasonFolder', includeIfNull: false)
  final bool? seasonFolder;
  @JsonKey(name: 'monitored', includeIfNull: false)
  final bool? monitored;
  @JsonKey(name: 'useSceneNumbering', includeIfNull: false)
  final bool? useSceneNumbering;
  @JsonKey(name: 'runtime', includeIfNull: false)
  final double? runtime;
  @JsonKey(name: 'tvdbId', includeIfNull: false)
  final double? tvdbId;
  @JsonKey(name: 'tvRageId', includeIfNull: false)
  final double? tvRageId;
  @JsonKey(name: 'tvMazeId', includeIfNull: false)
  final double? tvMazeId;
  @JsonKey(name: 'firstAired', includeIfNull: false)
  final String? firstAired;
  @JsonKey(name: 'lastInfoSync', includeIfNull: false)
  final String? lastInfoSync;
  @JsonKey(name: 'seriesType', includeIfNull: false)
  final String? seriesType;
  @JsonKey(name: 'cleanTitle', includeIfNull: false)
  final String? cleanTitle;
  @JsonKey(name: 'imdbId', includeIfNull: false)
  final String? imdbId;
  @JsonKey(name: 'titleSlug', includeIfNull: false)
  final String? titleSlug;
  @JsonKey(name: 'certification', includeIfNull: false)
  final String? certification;
  @JsonKey(name: 'genres', includeIfNull: false, defaultValue: <String>[])
  final List<String>? genres;
  @JsonKey(name: 'tags', includeIfNull: false, defaultValue: <String>[])
  final List<String>? tags;
  @JsonKey(name: 'added', includeIfNull: false)
  final String? added;
  @JsonKey(name: 'ratings', includeIfNull: false)
  final List<SonarrSeries$Ratings$Item>? ratings;
  @JsonKey(name: 'qualityProfileId', includeIfNull: false)
  final double? qualityProfileId;
  @JsonKey(name: 'id', includeIfNull: false)
  final double? id;
  @JsonKey(name: 'rootFolderPath', includeIfNull: false)
  final String? rootFolderPath;
  @JsonKey(name: 'addOptions', includeIfNull: false)
  final List<SonarrSeries$AddOptions$Item>? addOptions;
  static const fromJsonFactory = _$SonarrSeriesFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SonarrSeries &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.sortTitle, sortTitle) ||
                const DeepCollectionEquality().equals(
                  other.sortTitle,
                  sortTitle,
                )) &&
            (identical(other.seasonCount, seasonCount) ||
                const DeepCollectionEquality().equals(
                  other.seasonCount,
                  seasonCount,
                )) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.overview, overview) ||
                const DeepCollectionEquality().equals(
                  other.overview,
                  overview,
                )) &&
            (identical(other.network, network) ||
                const DeepCollectionEquality().equals(
                  other.network,
                  network,
                )) &&
            (identical(other.airTime, airTime) ||
                const DeepCollectionEquality().equals(
                  other.airTime,
                  airTime,
                )) &&
            (identical(other.images, images) ||
                const DeepCollectionEquality().equals(other.images, images)) &&
            (identical(other.remotePoster, remotePoster) ||
                const DeepCollectionEquality().equals(
                  other.remotePoster,
                  remotePoster,
                )) &&
            (identical(other.seasons, seasons) ||
                const DeepCollectionEquality().equals(
                  other.seasons,
                  seasons,
                )) &&
            (identical(other.year, year) ||
                const DeepCollectionEquality().equals(other.year, year)) &&
            (identical(other.path, path) ||
                const DeepCollectionEquality().equals(other.path, path)) &&
            (identical(other.profileId, profileId) ||
                const DeepCollectionEquality().equals(
                  other.profileId,
                  profileId,
                )) &&
            (identical(other.languageProfileId, languageProfileId) ||
                const DeepCollectionEquality().equals(
                  other.languageProfileId,
                  languageProfileId,
                )) &&
            (identical(other.seasonFolder, seasonFolder) ||
                const DeepCollectionEquality().equals(
                  other.seasonFolder,
                  seasonFolder,
                )) &&
            (identical(other.monitored, monitored) ||
                const DeepCollectionEquality().equals(
                  other.monitored,
                  monitored,
                )) &&
            (identical(other.useSceneNumbering, useSceneNumbering) ||
                const DeepCollectionEquality().equals(
                  other.useSceneNumbering,
                  useSceneNumbering,
                )) &&
            (identical(other.runtime, runtime) ||
                const DeepCollectionEquality().equals(
                  other.runtime,
                  runtime,
                )) &&
            (identical(other.tvdbId, tvdbId) ||
                const DeepCollectionEquality().equals(other.tvdbId, tvdbId)) &&
            (identical(other.tvRageId, tvRageId) ||
                const DeepCollectionEquality().equals(
                  other.tvRageId,
                  tvRageId,
                )) &&
            (identical(other.tvMazeId, tvMazeId) ||
                const DeepCollectionEquality().equals(
                  other.tvMazeId,
                  tvMazeId,
                )) &&
            (identical(other.firstAired, firstAired) ||
                const DeepCollectionEquality().equals(
                  other.firstAired,
                  firstAired,
                )) &&
            (identical(other.lastInfoSync, lastInfoSync) ||
                const DeepCollectionEquality().equals(
                  other.lastInfoSync,
                  lastInfoSync,
                )) &&
            (identical(other.seriesType, seriesType) ||
                const DeepCollectionEquality().equals(
                  other.seriesType,
                  seriesType,
                )) &&
            (identical(other.cleanTitle, cleanTitle) ||
                const DeepCollectionEquality().equals(
                  other.cleanTitle,
                  cleanTitle,
                )) &&
            (identical(other.imdbId, imdbId) ||
                const DeepCollectionEquality().equals(other.imdbId, imdbId)) &&
            (identical(other.titleSlug, titleSlug) ||
                const DeepCollectionEquality().equals(
                  other.titleSlug,
                  titleSlug,
                )) &&
            (identical(other.certification, certification) ||
                const DeepCollectionEquality().equals(
                  other.certification,
                  certification,
                )) &&
            (identical(other.genres, genres) ||
                const DeepCollectionEquality().equals(other.genres, genres)) &&
            (identical(other.tags, tags) ||
                const DeepCollectionEquality().equals(other.tags, tags)) &&
            (identical(other.added, added) ||
                const DeepCollectionEquality().equals(other.added, added)) &&
            (identical(other.ratings, ratings) ||
                const DeepCollectionEquality().equals(
                  other.ratings,
                  ratings,
                )) &&
            (identical(other.qualityProfileId, qualityProfileId) ||
                const DeepCollectionEquality().equals(
                  other.qualityProfileId,
                  qualityProfileId,
                )) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.rootFolderPath, rootFolderPath) ||
                const DeepCollectionEquality().equals(
                  other.rootFolderPath,
                  rootFolderPath,
                )) &&
            (identical(other.addOptions, addOptions) ||
                const DeepCollectionEquality().equals(
                  other.addOptions,
                  addOptions,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(sortTitle) ^
      const DeepCollectionEquality().hash(seasonCount) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(overview) ^
      const DeepCollectionEquality().hash(network) ^
      const DeepCollectionEquality().hash(airTime) ^
      const DeepCollectionEquality().hash(images) ^
      const DeepCollectionEquality().hash(remotePoster) ^
      const DeepCollectionEquality().hash(seasons) ^
      const DeepCollectionEquality().hash(year) ^
      const DeepCollectionEquality().hash(path) ^
      const DeepCollectionEquality().hash(profileId) ^
      const DeepCollectionEquality().hash(languageProfileId) ^
      const DeepCollectionEquality().hash(seasonFolder) ^
      const DeepCollectionEquality().hash(monitored) ^
      const DeepCollectionEquality().hash(useSceneNumbering) ^
      const DeepCollectionEquality().hash(runtime) ^
      const DeepCollectionEquality().hash(tvdbId) ^
      const DeepCollectionEquality().hash(tvRageId) ^
      const DeepCollectionEquality().hash(tvMazeId) ^
      const DeepCollectionEquality().hash(firstAired) ^
      const DeepCollectionEquality().hash(lastInfoSync) ^
      const DeepCollectionEquality().hash(seriesType) ^
      const DeepCollectionEquality().hash(cleanTitle) ^
      const DeepCollectionEquality().hash(imdbId) ^
      const DeepCollectionEquality().hash(titleSlug) ^
      const DeepCollectionEquality().hash(certification) ^
      const DeepCollectionEquality().hash(genres) ^
      const DeepCollectionEquality().hash(tags) ^
      const DeepCollectionEquality().hash(added) ^
      const DeepCollectionEquality().hash(ratings) ^
      const DeepCollectionEquality().hash(qualityProfileId) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(rootFolderPath) ^
      const DeepCollectionEquality().hash(addOptions) ^
      runtimeType.hashCode;
}

extension $SonarrSeriesExtension on SonarrSeries {
  SonarrSeries copyWith({
    String? title,
    String? sortTitle,
    double? seasonCount,
    String? status,
    String? overview,
    String? network,
    String? airTime,
    List<SonarrSeries$Images$Item>? images,
    String? remotePoster,
    List<SonarrSeries$Seasons$Item>? seasons,
    double? year,
    String? path,
    double? profileId,
    double? languageProfileId,
    bool? seasonFolder,
    bool? monitored,
    bool? useSceneNumbering,
    double? runtime,
    double? tvdbId,
    double? tvRageId,
    double? tvMazeId,
    String? firstAired,
    String? lastInfoSync,
    String? seriesType,
    String? cleanTitle,
    String? imdbId,
    String? titleSlug,
    String? certification,
    List<String>? genres,
    List<String>? tags,
    String? added,
    List<SonarrSeries$Ratings$Item>? ratings,
    double? qualityProfileId,
    double? id,
    String? rootFolderPath,
    List<SonarrSeries$AddOptions$Item>? addOptions,
  }) {
    return SonarrSeries(
      title: title ?? this.title,
      sortTitle: sortTitle ?? this.sortTitle,
      seasonCount: seasonCount ?? this.seasonCount,
      status: status ?? this.status,
      overview: overview ?? this.overview,
      network: network ?? this.network,
      airTime: airTime ?? this.airTime,
      images: images ?? this.images,
      remotePoster: remotePoster ?? this.remotePoster,
      seasons: seasons ?? this.seasons,
      year: year ?? this.year,
      path: path ?? this.path,
      profileId: profileId ?? this.profileId,
      languageProfileId: languageProfileId ?? this.languageProfileId,
      seasonFolder: seasonFolder ?? this.seasonFolder,
      monitored: monitored ?? this.monitored,
      useSceneNumbering: useSceneNumbering ?? this.useSceneNumbering,
      runtime: runtime ?? this.runtime,
      tvdbId: tvdbId ?? this.tvdbId,
      tvRageId: tvRageId ?? this.tvRageId,
      tvMazeId: tvMazeId ?? this.tvMazeId,
      firstAired: firstAired ?? this.firstAired,
      lastInfoSync: lastInfoSync ?? this.lastInfoSync,
      seriesType: seriesType ?? this.seriesType,
      cleanTitle: cleanTitle ?? this.cleanTitle,
      imdbId: imdbId ?? this.imdbId,
      titleSlug: titleSlug ?? this.titleSlug,
      certification: certification ?? this.certification,
      genres: genres ?? this.genres,
      tags: tags ?? this.tags,
      added: added ?? this.added,
      ratings: ratings ?? this.ratings,
      qualityProfileId: qualityProfileId ?? this.qualityProfileId,
      id: id ?? this.id,
      rootFolderPath: rootFolderPath ?? this.rootFolderPath,
      addOptions: addOptions ?? this.addOptions,
    );
  }

  SonarrSeries copyWithWrapped({
    Wrapped<String?>? title,
    Wrapped<String?>? sortTitle,
    Wrapped<double?>? seasonCount,
    Wrapped<String?>? status,
    Wrapped<String?>? overview,
    Wrapped<String?>? network,
    Wrapped<String?>? airTime,
    Wrapped<List<SonarrSeries$Images$Item>?>? images,
    Wrapped<String?>? remotePoster,
    Wrapped<List<SonarrSeries$Seasons$Item>?>? seasons,
    Wrapped<double?>? year,
    Wrapped<String?>? path,
    Wrapped<double?>? profileId,
    Wrapped<double?>? languageProfileId,
    Wrapped<bool?>? seasonFolder,
    Wrapped<bool?>? monitored,
    Wrapped<bool?>? useSceneNumbering,
    Wrapped<double?>? runtime,
    Wrapped<double?>? tvdbId,
    Wrapped<double?>? tvRageId,
    Wrapped<double?>? tvMazeId,
    Wrapped<String?>? firstAired,
    Wrapped<String?>? lastInfoSync,
    Wrapped<String?>? seriesType,
    Wrapped<String?>? cleanTitle,
    Wrapped<String?>? imdbId,
    Wrapped<String?>? titleSlug,
    Wrapped<String?>? certification,
    Wrapped<List<String>?>? genres,
    Wrapped<List<String>?>? tags,
    Wrapped<String?>? added,
    Wrapped<List<SonarrSeries$Ratings$Item>?>? ratings,
    Wrapped<double?>? qualityProfileId,
    Wrapped<double?>? id,
    Wrapped<String?>? rootFolderPath,
    Wrapped<List<SonarrSeries$AddOptions$Item>?>? addOptions,
  }) {
    return SonarrSeries(
      title: (title != null ? title.value : this.title),
      sortTitle: (sortTitle != null ? sortTitle.value : this.sortTitle),
      seasonCount: (seasonCount != null ? seasonCount.value : this.seasonCount),
      status: (status != null ? status.value : this.status),
      overview: (overview != null ? overview.value : this.overview),
      network: (network != null ? network.value : this.network),
      airTime: (airTime != null ? airTime.value : this.airTime),
      images: (images != null ? images.value : this.images),
      remotePoster: (remotePoster != null
          ? remotePoster.value
          : this.remotePoster),
      seasons: (seasons != null ? seasons.value : this.seasons),
      year: (year != null ? year.value : this.year),
      path: (path != null ? path.value : this.path),
      profileId: (profileId != null ? profileId.value : this.profileId),
      languageProfileId: (languageProfileId != null
          ? languageProfileId.value
          : this.languageProfileId),
      seasonFolder: (seasonFolder != null
          ? seasonFolder.value
          : this.seasonFolder),
      monitored: (monitored != null ? monitored.value : this.monitored),
      useSceneNumbering: (useSceneNumbering != null
          ? useSceneNumbering.value
          : this.useSceneNumbering),
      runtime: (runtime != null ? runtime.value : this.runtime),
      tvdbId: (tvdbId != null ? tvdbId.value : this.tvdbId),
      tvRageId: (tvRageId != null ? tvRageId.value : this.tvRageId),
      tvMazeId: (tvMazeId != null ? tvMazeId.value : this.tvMazeId),
      firstAired: (firstAired != null ? firstAired.value : this.firstAired),
      lastInfoSync: (lastInfoSync != null
          ? lastInfoSync.value
          : this.lastInfoSync),
      seriesType: (seriesType != null ? seriesType.value : this.seriesType),
      cleanTitle: (cleanTitle != null ? cleanTitle.value : this.cleanTitle),
      imdbId: (imdbId != null ? imdbId.value : this.imdbId),
      titleSlug: (titleSlug != null ? titleSlug.value : this.titleSlug),
      certification: (certification != null
          ? certification.value
          : this.certification),
      genres: (genres != null ? genres.value : this.genres),
      tags: (tags != null ? tags.value : this.tags),
      added: (added != null ? added.value : this.added),
      ratings: (ratings != null ? ratings.value : this.ratings),
      qualityProfileId: (qualityProfileId != null
          ? qualityProfileId.value
          : this.qualityProfileId),
      id: (id != null ? id.value : this.id),
      rootFolderPath: (rootFolderPath != null
          ? rootFolderPath.value
          : this.rootFolderPath),
      addOptions: (addOptions != null ? addOptions.value : this.addOptions),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserSettingsNotifications {
  const UserSettingsNotifications({
    this.notificationTypes,
    this.emailEnabled,
    this.pgpKey,
    this.discordEnabled,
    this.discordEnabledTypes,
    this.discordId,
    this.pushbulletAccessToken,
    this.pushoverApplicationToken,
    this.pushoverUserKey,
    this.pushoverSound,
    this.telegramEnabled,
    this.telegramBotUsername,
    this.telegramChatId,
    this.telegramMessageThreadId,
    this.telegramSendSilently,
  });

  factory UserSettingsNotifications.fromJson(Map<String, dynamic> json) =>
      _$UserSettingsNotificationsFromJson(json);

  static const toJsonFactory = _$UserSettingsNotificationsToJson;
  Map<String, dynamic> toJson() => _$UserSettingsNotificationsToJson(this);

  @JsonKey(name: 'notificationTypes', includeIfNull: false)
  final NotificationAgentTypes? notificationTypes;
  @JsonKey(name: 'emailEnabled', includeIfNull: false)
  final bool? emailEnabled;
  @JsonKey(name: 'pgpKey', includeIfNull: false)
  final String? pgpKey;
  @JsonKey(name: 'discordEnabled', includeIfNull: false)
  final bool? discordEnabled;
  @JsonKey(name: 'discordEnabledTypes', includeIfNull: false)
  final double? discordEnabledTypes;
  @JsonKey(name: 'discordId', includeIfNull: false)
  final String? discordId;
  @JsonKey(name: 'pushbulletAccessToken', includeIfNull: false)
  final String? pushbulletAccessToken;
  @JsonKey(name: 'pushoverApplicationToken', includeIfNull: false)
  final String? pushoverApplicationToken;
  @JsonKey(name: 'pushoverUserKey', includeIfNull: false)
  final String? pushoverUserKey;
  @JsonKey(name: 'pushoverSound', includeIfNull: false)
  final String? pushoverSound;
  @JsonKey(name: 'telegramEnabled', includeIfNull: false)
  final bool? telegramEnabled;
  @JsonKey(name: 'telegramBotUsername', includeIfNull: false)
  final String? telegramBotUsername;
  @JsonKey(name: 'telegramChatId', includeIfNull: false)
  final String? telegramChatId;
  @JsonKey(name: 'telegramMessageThreadId', includeIfNull: false)
  final String? telegramMessageThreadId;
  @JsonKey(name: 'telegramSendSilently', includeIfNull: false)
  final bool? telegramSendSilently;
  static const fromJsonFactory = _$UserSettingsNotificationsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserSettingsNotifications &&
            (identical(other.notificationTypes, notificationTypes) ||
                const DeepCollectionEquality().equals(
                  other.notificationTypes,
                  notificationTypes,
                )) &&
            (identical(other.emailEnabled, emailEnabled) ||
                const DeepCollectionEquality().equals(
                  other.emailEnabled,
                  emailEnabled,
                )) &&
            (identical(other.pgpKey, pgpKey) ||
                const DeepCollectionEquality().equals(other.pgpKey, pgpKey)) &&
            (identical(other.discordEnabled, discordEnabled) ||
                const DeepCollectionEquality().equals(
                  other.discordEnabled,
                  discordEnabled,
                )) &&
            (identical(other.discordEnabledTypes, discordEnabledTypes) ||
                const DeepCollectionEquality().equals(
                  other.discordEnabledTypes,
                  discordEnabledTypes,
                )) &&
            (identical(other.discordId, discordId) ||
                const DeepCollectionEquality().equals(
                  other.discordId,
                  discordId,
                )) &&
            (identical(other.pushbulletAccessToken, pushbulletAccessToken) ||
                const DeepCollectionEquality().equals(
                  other.pushbulletAccessToken,
                  pushbulletAccessToken,
                )) &&
            (identical(
                  other.pushoverApplicationToken,
                  pushoverApplicationToken,
                ) ||
                const DeepCollectionEquality().equals(
                  other.pushoverApplicationToken,
                  pushoverApplicationToken,
                )) &&
            (identical(other.pushoverUserKey, pushoverUserKey) ||
                const DeepCollectionEquality().equals(
                  other.pushoverUserKey,
                  pushoverUserKey,
                )) &&
            (identical(other.pushoverSound, pushoverSound) ||
                const DeepCollectionEquality().equals(
                  other.pushoverSound,
                  pushoverSound,
                )) &&
            (identical(other.telegramEnabled, telegramEnabled) ||
                const DeepCollectionEquality().equals(
                  other.telegramEnabled,
                  telegramEnabled,
                )) &&
            (identical(other.telegramBotUsername, telegramBotUsername) ||
                const DeepCollectionEquality().equals(
                  other.telegramBotUsername,
                  telegramBotUsername,
                )) &&
            (identical(other.telegramChatId, telegramChatId) ||
                const DeepCollectionEquality().equals(
                  other.telegramChatId,
                  telegramChatId,
                )) &&
            (identical(
                  other.telegramMessageThreadId,
                  telegramMessageThreadId,
                ) ||
                const DeepCollectionEquality().equals(
                  other.telegramMessageThreadId,
                  telegramMessageThreadId,
                )) &&
            (identical(other.telegramSendSilently, telegramSendSilently) ||
                const DeepCollectionEquality().equals(
                  other.telegramSendSilently,
                  telegramSendSilently,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(notificationTypes) ^
      const DeepCollectionEquality().hash(emailEnabled) ^
      const DeepCollectionEquality().hash(pgpKey) ^
      const DeepCollectionEquality().hash(discordEnabled) ^
      const DeepCollectionEquality().hash(discordEnabledTypes) ^
      const DeepCollectionEquality().hash(discordId) ^
      const DeepCollectionEquality().hash(pushbulletAccessToken) ^
      const DeepCollectionEquality().hash(pushoverApplicationToken) ^
      const DeepCollectionEquality().hash(pushoverUserKey) ^
      const DeepCollectionEquality().hash(pushoverSound) ^
      const DeepCollectionEquality().hash(telegramEnabled) ^
      const DeepCollectionEquality().hash(telegramBotUsername) ^
      const DeepCollectionEquality().hash(telegramChatId) ^
      const DeepCollectionEquality().hash(telegramMessageThreadId) ^
      const DeepCollectionEquality().hash(telegramSendSilently) ^
      runtimeType.hashCode;
}

extension $UserSettingsNotificationsExtension on UserSettingsNotifications {
  UserSettingsNotifications copyWith({
    NotificationAgentTypes? notificationTypes,
    bool? emailEnabled,
    String? pgpKey,
    bool? discordEnabled,
    double? discordEnabledTypes,
    String? discordId,
    String? pushbulletAccessToken,
    String? pushoverApplicationToken,
    String? pushoverUserKey,
    String? pushoverSound,
    bool? telegramEnabled,
    String? telegramBotUsername,
    String? telegramChatId,
    String? telegramMessageThreadId,
    bool? telegramSendSilently,
  }) {
    return UserSettingsNotifications(
      notificationTypes: notificationTypes ?? this.notificationTypes,
      emailEnabled: emailEnabled ?? this.emailEnabled,
      pgpKey: pgpKey ?? this.pgpKey,
      discordEnabled: discordEnabled ?? this.discordEnabled,
      discordEnabledTypes: discordEnabledTypes ?? this.discordEnabledTypes,
      discordId: discordId ?? this.discordId,
      pushbulletAccessToken:
          pushbulletAccessToken ?? this.pushbulletAccessToken,
      pushoverApplicationToken:
          pushoverApplicationToken ?? this.pushoverApplicationToken,
      pushoverUserKey: pushoverUserKey ?? this.pushoverUserKey,
      pushoverSound: pushoverSound ?? this.pushoverSound,
      telegramEnabled: telegramEnabled ?? this.telegramEnabled,
      telegramBotUsername: telegramBotUsername ?? this.telegramBotUsername,
      telegramChatId: telegramChatId ?? this.telegramChatId,
      telegramMessageThreadId:
          telegramMessageThreadId ?? this.telegramMessageThreadId,
      telegramSendSilently: telegramSendSilently ?? this.telegramSendSilently,
    );
  }

  UserSettingsNotifications copyWithWrapped({
    Wrapped<NotificationAgentTypes?>? notificationTypes,
    Wrapped<bool?>? emailEnabled,
    Wrapped<String?>? pgpKey,
    Wrapped<bool?>? discordEnabled,
    Wrapped<double?>? discordEnabledTypes,
    Wrapped<String?>? discordId,
    Wrapped<String?>? pushbulletAccessToken,
    Wrapped<String?>? pushoverApplicationToken,
    Wrapped<String?>? pushoverUserKey,
    Wrapped<String?>? pushoverSound,
    Wrapped<bool?>? telegramEnabled,
    Wrapped<String?>? telegramBotUsername,
    Wrapped<String?>? telegramChatId,
    Wrapped<String?>? telegramMessageThreadId,
    Wrapped<bool?>? telegramSendSilently,
  }) {
    return UserSettingsNotifications(
      notificationTypes: (notificationTypes != null
          ? notificationTypes.value
          : this.notificationTypes),
      emailEnabled: (emailEnabled != null
          ? emailEnabled.value
          : this.emailEnabled),
      pgpKey: (pgpKey != null ? pgpKey.value : this.pgpKey),
      discordEnabled: (discordEnabled != null
          ? discordEnabled.value
          : this.discordEnabled),
      discordEnabledTypes: (discordEnabledTypes != null
          ? discordEnabledTypes.value
          : this.discordEnabledTypes),
      discordId: (discordId != null ? discordId.value : this.discordId),
      pushbulletAccessToken: (pushbulletAccessToken != null
          ? pushbulletAccessToken.value
          : this.pushbulletAccessToken),
      pushoverApplicationToken: (pushoverApplicationToken != null
          ? pushoverApplicationToken.value
          : this.pushoverApplicationToken),
      pushoverUserKey: (pushoverUserKey != null
          ? pushoverUserKey.value
          : this.pushoverUserKey),
      pushoverSound: (pushoverSound != null
          ? pushoverSound.value
          : this.pushoverSound),
      telegramEnabled: (telegramEnabled != null
          ? telegramEnabled.value
          : this.telegramEnabled),
      telegramBotUsername: (telegramBotUsername != null
          ? telegramBotUsername.value
          : this.telegramBotUsername),
      telegramChatId: (telegramChatId != null
          ? telegramChatId.value
          : this.telegramChatId),
      telegramMessageThreadId: (telegramMessageThreadId != null
          ? telegramMessageThreadId.value
          : this.telegramMessageThreadId),
      telegramSendSilently: (telegramSendSilently != null
          ? telegramSendSilently.value
          : this.telegramSendSilently),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class NotificationAgentTypes {
  const NotificationAgentTypes({
    this.discord,
    this.email,
    this.pushbullet,
    this.pushover,
    this.slack,
    this.telegram,
    this.webhook,
    this.webpush,
  });

  factory NotificationAgentTypes.fromJson(Map<String, dynamic> json) =>
      _$NotificationAgentTypesFromJson(json);

  static const toJsonFactory = _$NotificationAgentTypesToJson;
  Map<String, dynamic> toJson() => _$NotificationAgentTypesToJson(this);

  @JsonKey(name: 'discord', includeIfNull: false)
  final double? discord;
  @JsonKey(name: 'email', includeIfNull: false)
  final double? email;
  @JsonKey(name: 'pushbullet', includeIfNull: false)
  final double? pushbullet;
  @JsonKey(name: 'pushover', includeIfNull: false)
  final double? pushover;
  @JsonKey(name: 'slack', includeIfNull: false)
  final double? slack;
  @JsonKey(name: 'telegram', includeIfNull: false)
  final double? telegram;
  @JsonKey(name: 'webhook', includeIfNull: false)
  final double? webhook;
  @JsonKey(name: 'webpush', includeIfNull: false)
  final double? webpush;
  static const fromJsonFactory = _$NotificationAgentTypesFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is NotificationAgentTypes &&
            (identical(other.discord, discord) ||
                const DeepCollectionEquality().equals(
                  other.discord,
                  discord,
                )) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.pushbullet, pushbullet) ||
                const DeepCollectionEquality().equals(
                  other.pushbullet,
                  pushbullet,
                )) &&
            (identical(other.pushover, pushover) ||
                const DeepCollectionEquality().equals(
                  other.pushover,
                  pushover,
                )) &&
            (identical(other.slack, slack) ||
                const DeepCollectionEquality().equals(other.slack, slack)) &&
            (identical(other.telegram, telegram) ||
                const DeepCollectionEquality().equals(
                  other.telegram,
                  telegram,
                )) &&
            (identical(other.webhook, webhook) ||
                const DeepCollectionEquality().equals(
                  other.webhook,
                  webhook,
                )) &&
            (identical(other.webpush, webpush) ||
                const DeepCollectionEquality().equals(other.webpush, webpush)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(discord) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(pushbullet) ^
      const DeepCollectionEquality().hash(pushover) ^
      const DeepCollectionEquality().hash(slack) ^
      const DeepCollectionEquality().hash(telegram) ^
      const DeepCollectionEquality().hash(webhook) ^
      const DeepCollectionEquality().hash(webpush) ^
      runtimeType.hashCode;
}

extension $NotificationAgentTypesExtension on NotificationAgentTypes {
  NotificationAgentTypes copyWith({
    double? discord,
    double? email,
    double? pushbullet,
    double? pushover,
    double? slack,
    double? telegram,
    double? webhook,
    double? webpush,
  }) {
    return NotificationAgentTypes(
      discord: discord ?? this.discord,
      email: email ?? this.email,
      pushbullet: pushbullet ?? this.pushbullet,
      pushover: pushover ?? this.pushover,
      slack: slack ?? this.slack,
      telegram: telegram ?? this.telegram,
      webhook: webhook ?? this.webhook,
      webpush: webpush ?? this.webpush,
    );
  }

  NotificationAgentTypes copyWithWrapped({
    Wrapped<double?>? discord,
    Wrapped<double?>? email,
    Wrapped<double?>? pushbullet,
    Wrapped<double?>? pushover,
    Wrapped<double?>? slack,
    Wrapped<double?>? telegram,
    Wrapped<double?>? webhook,
    Wrapped<double?>? webpush,
  }) {
    return NotificationAgentTypes(
      discord: (discord != null ? discord.value : this.discord),
      email: (email != null ? email.value : this.email),
      pushbullet: (pushbullet != null ? pushbullet.value : this.pushbullet),
      pushover: (pushover != null ? pushover.value : this.pushover),
      slack: (slack != null ? slack.value : this.slack),
      telegram: (telegram != null ? telegram.value : this.telegram),
      webhook: (webhook != null ? webhook.value : this.webhook),
      webpush: (webpush != null ? webpush.value : this.webpush),
    );
  }
}

typedef WatchProviders = List<WatchProviders$Item>;

@JsonSerializable(explicitToJson: true)
class WatchProviders$Item {
  const WatchProviders$Item({
    this.iso31661,
    this.link,
    this.buy,
    this.flatrate,
  });

  factory WatchProviders$Item.fromJson(Map<String, dynamic> json) =>
      _$WatchProviders$ItemFromJson(json);

  static const toJsonFactory = _$WatchProviders$ItemToJson;
  Map<String, dynamic> toJson() => _$WatchProviders$ItemToJson(this);

  @JsonKey(name: 'iso_3166_1', includeIfNull: false)
  final String? iso31661;
  @JsonKey(name: 'link', includeIfNull: false)
  final String? link;
  @JsonKey(name: 'buy', includeIfNull: false, defaultValue: <Object>[])
  final List<Object>? buy;
  @JsonKey(name: 'flatrate', includeIfNull: false, defaultValue: <Object>[])
  final List<Object>? flatrate;
  static const fromJsonFactory = _$WatchProviders$ItemFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is WatchProviders$Item &&
            (identical(other.iso31661, iso31661) ||
                const DeepCollectionEquality().equals(
                  other.iso31661,
                  iso31661,
                )) &&
            (identical(other.link, link) ||
                const DeepCollectionEquality().equals(other.link, link)) &&
            (identical(other.buy, buy) ||
                const DeepCollectionEquality().equals(other.buy, buy)) &&
            (identical(other.flatrate, flatrate) ||
                const DeepCollectionEquality().equals(
                  other.flatrate,
                  flatrate,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(iso31661) ^
      const DeepCollectionEquality().hash(link) ^
      const DeepCollectionEquality().hash(buy) ^
      const DeepCollectionEquality().hash(flatrate) ^
      runtimeType.hashCode;
}

extension $WatchProviders$ItemExtension on WatchProviders$Item {
  WatchProviders$Item copyWith({
    String? iso31661,
    String? link,
    List<Object>? buy,
    List<Object>? flatrate,
  }) {
    return WatchProviders$Item(
      iso31661: iso31661 ?? this.iso31661,
      link: link ?? this.link,
      buy: buy ?? this.buy,
      flatrate: flatrate ?? this.flatrate,
    );
  }

  WatchProviders$Item copyWithWrapped({
    Wrapped<String?>? iso31661,
    Wrapped<String?>? link,
    Wrapped<List<Object>?>? buy,
    Wrapped<List<Object>?>? flatrate,
  }) {
    return WatchProviders$Item(
      iso31661: (iso31661 != null ? iso31661.value : this.iso31661),
      link: (link != null ? link.value : this.link),
      buy: (buy != null ? buy.value : this.buy),
      flatrate: (flatrate != null ? flatrate.value : this.flatrate),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class WatchProviderDetails {
  const WatchProviderDetails({
    this.displayPriority,
    this.logoPath,
    this.id,
    this.name,
  });

  factory WatchProviderDetails.fromJson(Map<String, dynamic> json) =>
      _$WatchProviderDetailsFromJson(json);

  static const toJsonFactory = _$WatchProviderDetailsToJson;
  Map<String, dynamic> toJson() => _$WatchProviderDetailsToJson(this);

  @JsonKey(name: 'displayPriority', includeIfNull: false)
  final double? displayPriority;
  @JsonKey(name: 'logoPath', includeIfNull: false)
  final String? logoPath;
  @JsonKey(name: 'id', includeIfNull: false)
  final double? id;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  static const fromJsonFactory = _$WatchProviderDetailsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is WatchProviderDetails &&
            (identical(other.displayPriority, displayPriority) ||
                const DeepCollectionEquality().equals(
                  other.displayPriority,
                  displayPriority,
                )) &&
            (identical(other.logoPath, logoPath) ||
                const DeepCollectionEquality().equals(
                  other.logoPath,
                  logoPath,
                )) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(displayPriority) ^
      const DeepCollectionEquality().hash(logoPath) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      runtimeType.hashCode;
}

extension $WatchProviderDetailsExtension on WatchProviderDetails {
  WatchProviderDetails copyWith({
    double? displayPriority,
    String? logoPath,
    double? id,
    String? name,
  }) {
    return WatchProviderDetails(
      displayPriority: displayPriority ?? this.displayPriority,
      logoPath: logoPath ?? this.logoPath,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  WatchProviderDetails copyWithWrapped({
    Wrapped<double?>? displayPriority,
    Wrapped<String?>? logoPath,
    Wrapped<double?>? id,
    Wrapped<String?>? name,
  }) {
    return WatchProviderDetails(
      displayPriority: (displayPriority != null
          ? displayPriority.value
          : this.displayPriority),
      logoPath: (logoPath != null ? logoPath.value : this.logoPath),
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Issue {
  const Issue({
    this.id,
    this.issueType,
    this.media,
    this.createdBy,
    this.modifiedBy,
    this.comments,
  });

  factory Issue.fromJson(Map<String, dynamic> json) => _$IssueFromJson(json);

  static const toJsonFactory = _$IssueToJson;
  Map<String, dynamic> toJson() => _$IssueToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final double? id;
  @JsonKey(name: 'issueType', includeIfNull: false)
  final double? issueType;
  @JsonKey(name: 'media', includeIfNull: false)
  final MediaInfo? media;
  @JsonKey(name: 'createdBy', includeIfNull: false)
  final User? createdBy;
  @JsonKey(name: 'modifiedBy', includeIfNull: false)
  final User? modifiedBy;
  @JsonKey(
    name: 'comments',
    includeIfNull: false,
    defaultValue: <IssueComment>[],
  )
  final List<IssueComment>? comments;
  static const fromJsonFactory = _$IssueFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Issue &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.issueType, issueType) ||
                const DeepCollectionEquality().equals(
                  other.issueType,
                  issueType,
                )) &&
            (identical(other.media, media) ||
                const DeepCollectionEquality().equals(other.media, media)) &&
            (identical(other.createdBy, createdBy) ||
                const DeepCollectionEquality().equals(
                  other.createdBy,
                  createdBy,
                )) &&
            (identical(other.modifiedBy, modifiedBy) ||
                const DeepCollectionEquality().equals(
                  other.modifiedBy,
                  modifiedBy,
                )) &&
            (identical(other.comments, comments) ||
                const DeepCollectionEquality().equals(
                  other.comments,
                  comments,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(issueType) ^
      const DeepCollectionEquality().hash(media) ^
      const DeepCollectionEquality().hash(createdBy) ^
      const DeepCollectionEquality().hash(modifiedBy) ^
      const DeepCollectionEquality().hash(comments) ^
      runtimeType.hashCode;
}

extension $IssueExtension on Issue {
  Issue copyWith({
    double? id,
    double? issueType,
    MediaInfo? media,
    User? createdBy,
    User? modifiedBy,
    List<IssueComment>? comments,
  }) {
    return Issue(
      id: id ?? this.id,
      issueType: issueType ?? this.issueType,
      media: media ?? this.media,
      createdBy: createdBy ?? this.createdBy,
      modifiedBy: modifiedBy ?? this.modifiedBy,
      comments: comments ?? this.comments,
    );
  }

  Issue copyWithWrapped({
    Wrapped<double?>? id,
    Wrapped<double?>? issueType,
    Wrapped<MediaInfo?>? media,
    Wrapped<User?>? createdBy,
    Wrapped<User?>? modifiedBy,
    Wrapped<List<IssueComment>?>? comments,
  }) {
    return Issue(
      id: (id != null ? id.value : this.id),
      issueType: (issueType != null ? issueType.value : this.issueType),
      media: (media != null ? media.value : this.media),
      createdBy: (createdBy != null ? createdBy.value : this.createdBy),
      modifiedBy: (modifiedBy != null ? modifiedBy.value : this.modifiedBy),
      comments: (comments != null ? comments.value : this.comments),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class IssueComment {
  const IssueComment({this.id, this.user, this.message});

  factory IssueComment.fromJson(Map<String, dynamic> json) =>
      _$IssueCommentFromJson(json);

  static const toJsonFactory = _$IssueCommentToJson;
  Map<String, dynamic> toJson() => _$IssueCommentToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final double? id;
  @JsonKey(name: 'user', includeIfNull: false)
  final User? user;
  @JsonKey(name: 'message', includeIfNull: false)
  final String? message;
  static const fromJsonFactory = _$IssueCommentFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is IssueComment &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(user) ^
      const DeepCollectionEquality().hash(message) ^
      runtimeType.hashCode;
}

extension $IssueCommentExtension on IssueComment {
  IssueComment copyWith({double? id, User? user, String? message}) {
    return IssueComment(
      id: id ?? this.id,
      user: user ?? this.user,
      message: message ?? this.message,
    );
  }

  IssueComment copyWithWrapped({
    Wrapped<double?>? id,
    Wrapped<User?>? user,
    Wrapped<String?>? message,
  }) {
    return IssueComment(
      id: (id != null ? id.value : this.id),
      user: (user != null ? user.value : this.user),
      message: (message != null ? message.value : this.message),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class DiscoverSlider {
  const DiscoverSlider({
    this.id,
    required this.type,
    this.title,
    this.isBuiltIn,
    required this.enabled,
    this.data,
  });

  factory DiscoverSlider.fromJson(Map<String, dynamic> json) =>
      _$DiscoverSliderFromJson(json);

  static const toJsonFactory = _$DiscoverSliderToJson;
  Map<String, dynamic> toJson() => _$DiscoverSliderToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final double? id;
  @JsonKey(name: 'type', includeIfNull: false)
  final double type;
  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;
  @JsonKey(name: 'isBuiltIn', includeIfNull: false)
  final bool? isBuiltIn;
  @JsonKey(name: 'enabled', includeIfNull: false)
  final bool enabled;
  @JsonKey(name: 'data', includeIfNull: false)
  final String? data;
  static const fromJsonFactory = _$DiscoverSliderFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is DiscoverSlider &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.isBuiltIn, isBuiltIn) ||
                const DeepCollectionEquality().equals(
                  other.isBuiltIn,
                  isBuiltIn,
                )) &&
            (identical(other.enabled, enabled) ||
                const DeepCollectionEquality().equals(
                  other.enabled,
                  enabled,
                )) &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(isBuiltIn) ^
      const DeepCollectionEquality().hash(enabled) ^
      const DeepCollectionEquality().hash(data) ^
      runtimeType.hashCode;
}

extension $DiscoverSliderExtension on DiscoverSlider {
  DiscoverSlider copyWith({
    double? id,
    double? type,
    String? title,
    bool? isBuiltIn,
    bool? enabled,
    String? data,
  }) {
    return DiscoverSlider(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      isBuiltIn: isBuiltIn ?? this.isBuiltIn,
      enabled: enabled ?? this.enabled,
      data: data ?? this.data,
    );
  }

  DiscoverSlider copyWithWrapped({
    Wrapped<double?>? id,
    Wrapped<double>? type,
    Wrapped<String?>? title,
    Wrapped<bool?>? isBuiltIn,
    Wrapped<bool>? enabled,
    Wrapped<String?>? data,
  }) {
    return DiscoverSlider(
      id: (id != null ? id.value : this.id),
      type: (type != null ? type.value : this.type),
      title: (title != null ? title.value : this.title),
      isBuiltIn: (isBuiltIn != null ? isBuiltIn.value : this.isBuiltIn),
      enabled: (enabled != null ? enabled.value : this.enabled),
      data: (data != null ? data.value : this.data),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class WatchProviderRegion {
  const WatchProviderRegion({this.iso31661, this.englishName, this.nativeName});

  factory WatchProviderRegion.fromJson(Map<String, dynamic> json) =>
      _$WatchProviderRegionFromJson(json);

  static const toJsonFactory = _$WatchProviderRegionToJson;
  Map<String, dynamic> toJson() => _$WatchProviderRegionToJson(this);

  @JsonKey(name: 'iso_3166_1', includeIfNull: false)
  final String? iso31661;
  @JsonKey(name: 'english_name', includeIfNull: false)
  final String? englishName;
  @JsonKey(name: 'native_name', includeIfNull: false)
  final String? nativeName;
  static const fromJsonFactory = _$WatchProviderRegionFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is WatchProviderRegion &&
            (identical(other.iso31661, iso31661) ||
                const DeepCollectionEquality().equals(
                  other.iso31661,
                  iso31661,
                )) &&
            (identical(other.englishName, englishName) ||
                const DeepCollectionEquality().equals(
                  other.englishName,
                  englishName,
                )) &&
            (identical(other.nativeName, nativeName) ||
                const DeepCollectionEquality().equals(
                  other.nativeName,
                  nativeName,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(iso31661) ^
      const DeepCollectionEquality().hash(englishName) ^
      const DeepCollectionEquality().hash(nativeName) ^
      runtimeType.hashCode;
}

extension $WatchProviderRegionExtension on WatchProviderRegion {
  WatchProviderRegion copyWith({
    String? iso31661,
    String? englishName,
    String? nativeName,
  }) {
    return WatchProviderRegion(
      iso31661: iso31661 ?? this.iso31661,
      englishName: englishName ?? this.englishName,
      nativeName: nativeName ?? this.nativeName,
    );
  }

  WatchProviderRegion copyWithWrapped({
    Wrapped<String?>? iso31661,
    Wrapped<String?>? englishName,
    Wrapped<String?>? nativeName,
  }) {
    return WatchProviderRegion(
      iso31661: (iso31661 != null ? iso31661.value : this.iso31661),
      englishName: (englishName != null ? englishName.value : this.englishName),
      nativeName: (nativeName != null ? nativeName.value : this.nativeName),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class OverrideRule {
  const OverrideRule({this.id});

  factory OverrideRule.fromJson(Map<String, dynamic> json) =>
      _$OverrideRuleFromJson(json);

  static const toJsonFactory = _$OverrideRuleToJson;
  Map<String, dynamic> toJson() => _$OverrideRuleToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final String? id;
  static const fromJsonFactory = _$OverrideRuleFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is OverrideRule &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^ runtimeType.hashCode;
}

extension $OverrideRuleExtension on OverrideRule {
  OverrideRule copyWith({String? id}) {
    return OverrideRule(id: id ?? this.id);
  }

  OverrideRule copyWithWrapped({Wrapped<String?>? id}) {
    return OverrideRule(id: (id != null ? id.value : this.id));
  }
}

@JsonSerializable(explicitToJson: true)
class Certification {
  const Certification({required this.certification, this.meaning, this.order});

  factory Certification.fromJson(Map<String, dynamic> json) =>
      _$CertificationFromJson(json);

  static const toJsonFactory = _$CertificationToJson;
  Map<String, dynamic> toJson() => _$CertificationToJson(this);

  @JsonKey(name: 'certification', includeIfNull: false)
  final String certification;
  @JsonKey(name: 'meaning', includeIfNull: false)
  final String? meaning;
  @JsonKey(name: 'order', includeIfNull: false)
  final double? order;
  static const fromJsonFactory = _$CertificationFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Certification &&
            (identical(other.certification, certification) ||
                const DeepCollectionEquality().equals(
                  other.certification,
                  certification,
                )) &&
            (identical(other.meaning, meaning) ||
                const DeepCollectionEquality().equals(
                  other.meaning,
                  meaning,
                )) &&
            (identical(other.order, order) ||
                const DeepCollectionEquality().equals(other.order, order)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(certification) ^
      const DeepCollectionEquality().hash(meaning) ^
      const DeepCollectionEquality().hash(order) ^
      runtimeType.hashCode;
}

extension $CertificationExtension on Certification {
  Certification copyWith({
    String? certification,
    String? meaning,
    double? order,
  }) {
    return Certification(
      certification: certification ?? this.certification,
      meaning: meaning ?? this.meaning,
      order: order ?? this.order,
    );
  }

  Certification copyWithWrapped({
    Wrapped<String>? certification,
    Wrapped<String?>? meaning,
    Wrapped<double?>? order,
  }) {
    return Certification(
      certification: (certification != null
          ? certification.value
          : this.certification),
      meaning: (meaning != null ? meaning.value : this.meaning),
      order: (order != null ? order.value : this.order),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CertificationResponse {
  const CertificationResponse({this.certifications});

  factory CertificationResponse.fromJson(Map<String, dynamic> json) =>
      _$CertificationResponseFromJson(json);

  static const toJsonFactory = _$CertificationResponseToJson;
  Map<String, dynamic> toJson() => _$CertificationResponseToJson(this);

  @JsonKey(name: 'certifications', includeIfNull: false)
  final Map<String, dynamic>? certifications;
  static const fromJsonFactory = _$CertificationResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CertificationResponse &&
            (identical(other.certifications, certifications) ||
                const DeepCollectionEquality().equals(
                  other.certifications,
                  certifications,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(certifications) ^
      runtimeType.hashCode;
}

extension $CertificationResponseExtension on CertificationResponse {
  CertificationResponse copyWith({Map<String, dynamic>? certifications}) {
    return CertificationResponse(
      certifications: certifications ?? this.certifications,
    );
  }

  CertificationResponse copyWithWrapped({
    Wrapped<Map<String, dynamic>?>? certifications,
  }) {
    return CertificationResponse(
      certifications: (certifications != null
          ? certifications.value
          : this.certifications),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SettingsJellyfinSyncPost$RequestBody {
  const SettingsJellyfinSyncPost$RequestBody({this.cancel, this.start});

  factory SettingsJellyfinSyncPost$RequestBody.fromJson(
    Map<String, dynamic> json,
  ) => _$SettingsJellyfinSyncPost$RequestBodyFromJson(json);

  static const toJsonFactory = _$SettingsJellyfinSyncPost$RequestBodyToJson;
  Map<String, dynamic> toJson() =>
      _$SettingsJellyfinSyncPost$RequestBodyToJson(this);

  @JsonKey(name: 'cancel', includeIfNull: false)
  final bool? cancel;
  @JsonKey(name: 'start', includeIfNull: false)
  final bool? start;
  static const fromJsonFactory = _$SettingsJellyfinSyncPost$RequestBodyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SettingsJellyfinSyncPost$RequestBody &&
            (identical(other.cancel, cancel) ||
                const DeepCollectionEquality().equals(other.cancel, cancel)) &&
            (identical(other.start, start) ||
                const DeepCollectionEquality().equals(other.start, start)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(cancel) ^
      const DeepCollectionEquality().hash(start) ^
      runtimeType.hashCode;
}

extension $SettingsJellyfinSyncPost$RequestBodyExtension
    on SettingsJellyfinSyncPost$RequestBody {
  SettingsJellyfinSyncPost$RequestBody copyWith({bool? cancel, bool? start}) {
    return SettingsJellyfinSyncPost$RequestBody(
      cancel: cancel ?? this.cancel,
      start: start ?? this.start,
    );
  }

  SettingsJellyfinSyncPost$RequestBody copyWithWrapped({
    Wrapped<bool?>? cancel,
    Wrapped<bool?>? start,
  }) {
    return SettingsJellyfinSyncPost$RequestBody(
      cancel: (cancel != null ? cancel.value : this.cancel),
      start: (start != null ? start.value : this.start),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SettingsPlexSyncPost$RequestBody {
  const SettingsPlexSyncPost$RequestBody({this.cancel, this.start});

  factory SettingsPlexSyncPost$RequestBody.fromJson(
    Map<String, dynamic> json,
  ) => _$SettingsPlexSyncPost$RequestBodyFromJson(json);

  static const toJsonFactory = _$SettingsPlexSyncPost$RequestBodyToJson;
  Map<String, dynamic> toJson() =>
      _$SettingsPlexSyncPost$RequestBodyToJson(this);

  @JsonKey(name: 'cancel', includeIfNull: false)
  final bool? cancel;
  @JsonKey(name: 'start', includeIfNull: false)
  final bool? start;
  static const fromJsonFactory = _$SettingsPlexSyncPost$RequestBodyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SettingsPlexSyncPost$RequestBody &&
            (identical(other.cancel, cancel) ||
                const DeepCollectionEquality().equals(other.cancel, cancel)) &&
            (identical(other.start, start) ||
                const DeepCollectionEquality().equals(other.start, start)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(cancel) ^
      const DeepCollectionEquality().hash(start) ^
      runtimeType.hashCode;
}

extension $SettingsPlexSyncPost$RequestBodyExtension
    on SettingsPlexSyncPost$RequestBody {
  SettingsPlexSyncPost$RequestBody copyWith({bool? cancel, bool? start}) {
    return SettingsPlexSyncPost$RequestBody(
      cancel: cancel ?? this.cancel,
      start: start ?? this.start,
    );
  }

  SettingsPlexSyncPost$RequestBody copyWithWrapped({
    Wrapped<bool?>? cancel,
    Wrapped<bool?>? start,
  }) {
    return SettingsPlexSyncPost$RequestBody(
      cancel: (cancel != null ? cancel.value : this.cancel),
      start: (start != null ? start.value : this.start),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SettingsMetadatasTestPost$RequestBody {
  const SettingsMetadatasTestPost$RequestBody({this.tmdb, this.tvdb});

  factory SettingsMetadatasTestPost$RequestBody.fromJson(
    Map<String, dynamic> json,
  ) => _$SettingsMetadatasTestPost$RequestBodyFromJson(json);

  static const toJsonFactory = _$SettingsMetadatasTestPost$RequestBodyToJson;
  Map<String, dynamic> toJson() =>
      _$SettingsMetadatasTestPost$RequestBodyToJson(this);

  @JsonKey(name: 'tmdb', includeIfNull: false)
  final bool? tmdb;
  @JsonKey(name: 'tvdb', includeIfNull: false)
  final bool? tvdb;
  static const fromJsonFactory =
      _$SettingsMetadatasTestPost$RequestBodyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SettingsMetadatasTestPost$RequestBody &&
            (identical(other.tmdb, tmdb) ||
                const DeepCollectionEquality().equals(other.tmdb, tmdb)) &&
            (identical(other.tvdb, tvdb) ||
                const DeepCollectionEquality().equals(other.tvdb, tvdb)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(tmdb) ^
      const DeepCollectionEquality().hash(tvdb) ^
      runtimeType.hashCode;
}

extension $SettingsMetadatasTestPost$RequestBodyExtension
    on SettingsMetadatasTestPost$RequestBody {
  SettingsMetadatasTestPost$RequestBody copyWith({bool? tmdb, bool? tvdb}) {
    return SettingsMetadatasTestPost$RequestBody(
      tmdb: tmdb ?? this.tmdb,
      tvdb: tvdb ?? this.tvdb,
    );
  }

  SettingsMetadatasTestPost$RequestBody copyWithWrapped({
    Wrapped<bool?>? tmdb,
    Wrapped<bool?>? tvdb,
  }) {
    return SettingsMetadatasTestPost$RequestBody(
      tmdb: (tmdb != null ? tmdb.value : this.tmdb),
      tvdb: (tvdb != null ? tvdb.value : this.tvdb),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SettingsRadarrTestPost$RequestBody {
  const SettingsRadarrTestPost$RequestBody({
    required this.hostname,
    required this.port,
    required this.apiKey,
    required this.useSsl,
    this.baseUrl,
  });

  factory SettingsRadarrTestPost$RequestBody.fromJson(
    Map<String, dynamic> json,
  ) => _$SettingsRadarrTestPost$RequestBodyFromJson(json);

  static const toJsonFactory = _$SettingsRadarrTestPost$RequestBodyToJson;
  Map<String, dynamic> toJson() =>
      _$SettingsRadarrTestPost$RequestBodyToJson(this);

  @JsonKey(name: 'hostname', includeIfNull: false)
  final String hostname;
  @JsonKey(name: 'port', includeIfNull: false)
  final double port;
  @JsonKey(name: 'apiKey', includeIfNull: false)
  final String apiKey;
  @JsonKey(name: 'useSsl', includeIfNull: false)
  final bool useSsl;
  @JsonKey(name: 'baseUrl', includeIfNull: false)
  final String? baseUrl;
  static const fromJsonFactory = _$SettingsRadarrTestPost$RequestBodyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SettingsRadarrTestPost$RequestBody &&
            (identical(other.hostname, hostname) ||
                const DeepCollectionEquality().equals(
                  other.hostname,
                  hostname,
                )) &&
            (identical(other.port, port) ||
                const DeepCollectionEquality().equals(other.port, port)) &&
            (identical(other.apiKey, apiKey) ||
                const DeepCollectionEquality().equals(other.apiKey, apiKey)) &&
            (identical(other.useSsl, useSsl) ||
                const DeepCollectionEquality().equals(other.useSsl, useSsl)) &&
            (identical(other.baseUrl, baseUrl) ||
                const DeepCollectionEquality().equals(other.baseUrl, baseUrl)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(hostname) ^
      const DeepCollectionEquality().hash(port) ^
      const DeepCollectionEquality().hash(apiKey) ^
      const DeepCollectionEquality().hash(useSsl) ^
      const DeepCollectionEquality().hash(baseUrl) ^
      runtimeType.hashCode;
}

extension $SettingsRadarrTestPost$RequestBodyExtension
    on SettingsRadarrTestPost$RequestBody {
  SettingsRadarrTestPost$RequestBody copyWith({
    String? hostname,
    double? port,
    String? apiKey,
    bool? useSsl,
    String? baseUrl,
  }) {
    return SettingsRadarrTestPost$RequestBody(
      hostname: hostname ?? this.hostname,
      port: port ?? this.port,
      apiKey: apiKey ?? this.apiKey,
      useSsl: useSsl ?? this.useSsl,
      baseUrl: baseUrl ?? this.baseUrl,
    );
  }

  SettingsRadarrTestPost$RequestBody copyWithWrapped({
    Wrapped<String>? hostname,
    Wrapped<double>? port,
    Wrapped<String>? apiKey,
    Wrapped<bool>? useSsl,
    Wrapped<String?>? baseUrl,
  }) {
    return SettingsRadarrTestPost$RequestBody(
      hostname: (hostname != null ? hostname.value : this.hostname),
      port: (port != null ? port.value : this.port),
      apiKey: (apiKey != null ? apiKey.value : this.apiKey),
      useSsl: (useSsl != null ? useSsl.value : this.useSsl),
      baseUrl: (baseUrl != null ? baseUrl.value : this.baseUrl),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SettingsSonarrTestPost$RequestBody {
  const SettingsSonarrTestPost$RequestBody({
    required this.hostname,
    required this.port,
    required this.apiKey,
    required this.useSsl,
    this.baseUrl,
  });

  factory SettingsSonarrTestPost$RequestBody.fromJson(
    Map<String, dynamic> json,
  ) => _$SettingsSonarrTestPost$RequestBodyFromJson(json);

  static const toJsonFactory = _$SettingsSonarrTestPost$RequestBodyToJson;
  Map<String, dynamic> toJson() =>
      _$SettingsSonarrTestPost$RequestBodyToJson(this);

  @JsonKey(name: 'hostname', includeIfNull: false)
  final String hostname;
  @JsonKey(name: 'port', includeIfNull: false)
  final double port;
  @JsonKey(name: 'apiKey', includeIfNull: false)
  final String apiKey;
  @JsonKey(name: 'useSsl', includeIfNull: false)
  final bool useSsl;
  @JsonKey(name: 'baseUrl', includeIfNull: false)
  final String? baseUrl;
  static const fromJsonFactory = _$SettingsSonarrTestPost$RequestBodyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SettingsSonarrTestPost$RequestBody &&
            (identical(other.hostname, hostname) ||
                const DeepCollectionEquality().equals(
                  other.hostname,
                  hostname,
                )) &&
            (identical(other.port, port) ||
                const DeepCollectionEquality().equals(other.port, port)) &&
            (identical(other.apiKey, apiKey) ||
                const DeepCollectionEquality().equals(other.apiKey, apiKey)) &&
            (identical(other.useSsl, useSsl) ||
                const DeepCollectionEquality().equals(other.useSsl, useSsl)) &&
            (identical(other.baseUrl, baseUrl) ||
                const DeepCollectionEquality().equals(other.baseUrl, baseUrl)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(hostname) ^
      const DeepCollectionEquality().hash(port) ^
      const DeepCollectionEquality().hash(apiKey) ^
      const DeepCollectionEquality().hash(useSsl) ^
      const DeepCollectionEquality().hash(baseUrl) ^
      runtimeType.hashCode;
}

extension $SettingsSonarrTestPost$RequestBodyExtension
    on SettingsSonarrTestPost$RequestBody {
  SettingsSonarrTestPost$RequestBody copyWith({
    String? hostname,
    double? port,
    String? apiKey,
    bool? useSsl,
    String? baseUrl,
  }) {
    return SettingsSonarrTestPost$RequestBody(
      hostname: hostname ?? this.hostname,
      port: port ?? this.port,
      apiKey: apiKey ?? this.apiKey,
      useSsl: useSsl ?? this.useSsl,
      baseUrl: baseUrl ?? this.baseUrl,
    );
  }

  SettingsSonarrTestPost$RequestBody copyWithWrapped({
    Wrapped<String>? hostname,
    Wrapped<double>? port,
    Wrapped<String>? apiKey,
    Wrapped<bool>? useSsl,
    Wrapped<String?>? baseUrl,
  }) {
    return SettingsSonarrTestPost$RequestBody(
      hostname: (hostname != null ? hostname.value : this.hostname),
      port: (port != null ? port.value : this.port),
      apiKey: (apiKey != null ? apiKey.value : this.apiKey),
      useSsl: (useSsl != null ? useSsl.value : this.useSsl),
      baseUrl: (baseUrl != null ? baseUrl.value : this.baseUrl),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SettingsJobsJobIdSchedulePost$RequestBody {
  const SettingsJobsJobIdSchedulePost$RequestBody({this.schedule});

  factory SettingsJobsJobIdSchedulePost$RequestBody.fromJson(
    Map<String, dynamic> json,
  ) => _$SettingsJobsJobIdSchedulePost$RequestBodyFromJson(json);

  static const toJsonFactory =
      _$SettingsJobsJobIdSchedulePost$RequestBodyToJson;
  Map<String, dynamic> toJson() =>
      _$SettingsJobsJobIdSchedulePost$RequestBodyToJson(this);

  @JsonKey(name: 'schedule', includeIfNull: false)
  final String? schedule;
  static const fromJsonFactory =
      _$SettingsJobsJobIdSchedulePost$RequestBodyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SettingsJobsJobIdSchedulePost$RequestBody &&
            (identical(other.schedule, schedule) ||
                const DeepCollectionEquality().equals(
                  other.schedule,
                  schedule,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(schedule) ^ runtimeType.hashCode;
}

extension $SettingsJobsJobIdSchedulePost$RequestBodyExtension
    on SettingsJobsJobIdSchedulePost$RequestBody {
  SettingsJobsJobIdSchedulePost$RequestBody copyWith({String? schedule}) {
    return SettingsJobsJobIdSchedulePost$RequestBody(
      schedule: schedule ?? this.schedule,
    );
  }

  SettingsJobsJobIdSchedulePost$RequestBody copyWithWrapped({
    Wrapped<String?>? schedule,
  }) {
    return SettingsJobsJobIdSchedulePost$RequestBody(
      schedule: (schedule != null ? schedule.value : this.schedule),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SettingsDiscoverSliderIdPut$RequestBody {
  const SettingsDiscoverSliderIdPut$RequestBody({
    this.title,
    this.type,
    this.data,
  });

  factory SettingsDiscoverSliderIdPut$RequestBody.fromJson(
    Map<String, dynamic> json,
  ) => _$SettingsDiscoverSliderIdPut$RequestBodyFromJson(json);

  static const toJsonFactory = _$SettingsDiscoverSliderIdPut$RequestBodyToJson;
  Map<String, dynamic> toJson() =>
      _$SettingsDiscoverSliderIdPut$RequestBodyToJson(this);

  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;
  @JsonKey(name: 'type', includeIfNull: false)
  final double? type;
  @JsonKey(name: 'data', includeIfNull: false)
  final String? data;
  static const fromJsonFactory =
      _$SettingsDiscoverSliderIdPut$RequestBodyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SettingsDiscoverSliderIdPut$RequestBody &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(data) ^
      runtimeType.hashCode;
}

extension $SettingsDiscoverSliderIdPut$RequestBodyExtension
    on SettingsDiscoverSliderIdPut$RequestBody {
  SettingsDiscoverSliderIdPut$RequestBody copyWith({
    String? title,
    double? type,
    String? data,
  }) {
    return SettingsDiscoverSliderIdPut$RequestBody(
      title: title ?? this.title,
      type: type ?? this.type,
      data: data ?? this.data,
    );
  }

  SettingsDiscoverSliderIdPut$RequestBody copyWithWrapped({
    Wrapped<String?>? title,
    Wrapped<double?>? type,
    Wrapped<String?>? data,
  }) {
    return SettingsDiscoverSliderIdPut$RequestBody(
      title: (title != null ? title.value : this.title),
      type: (type != null ? type.value : this.type),
      data: (data != null ? data.value : this.data),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SettingsDiscoverAddPost$RequestBody {
  const SettingsDiscoverAddPost$RequestBody({this.title, this.type, this.data});

  factory SettingsDiscoverAddPost$RequestBody.fromJson(
    Map<String, dynamic> json,
  ) => _$SettingsDiscoverAddPost$RequestBodyFromJson(json);

  static const toJsonFactory = _$SettingsDiscoverAddPost$RequestBodyToJson;
  Map<String, dynamic> toJson() =>
      _$SettingsDiscoverAddPost$RequestBodyToJson(this);

  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;
  @JsonKey(name: 'type', includeIfNull: false)
  final double? type;
  @JsonKey(name: 'data', includeIfNull: false)
  final String? data;
  static const fromJsonFactory = _$SettingsDiscoverAddPost$RequestBodyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SettingsDiscoverAddPost$RequestBody &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(data) ^
      runtimeType.hashCode;
}

extension $SettingsDiscoverAddPost$RequestBodyExtension
    on SettingsDiscoverAddPost$RequestBody {
  SettingsDiscoverAddPost$RequestBody copyWith({
    String? title,
    double? type,
    String? data,
  }) {
    return SettingsDiscoverAddPost$RequestBody(
      title: title ?? this.title,
      type: type ?? this.type,
      data: data ?? this.data,
    );
  }

  SettingsDiscoverAddPost$RequestBody copyWithWrapped({
    Wrapped<String?>? title,
    Wrapped<double?>? type,
    Wrapped<String?>? data,
  }) {
    return SettingsDiscoverAddPost$RequestBody(
      title: (title != null ? title.value : this.title),
      type: (type != null ? type.value : this.type),
      data: (data != null ? data.value : this.data),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AuthPlexPost$RequestBody {
  const AuthPlexPost$RequestBody({required this.authToken});

  factory AuthPlexPost$RequestBody.fromJson(Map<String, dynamic> json) =>
      _$AuthPlexPost$RequestBodyFromJson(json);

  static const toJsonFactory = _$AuthPlexPost$RequestBodyToJson;
  Map<String, dynamic> toJson() => _$AuthPlexPost$RequestBodyToJson(this);

  @JsonKey(name: 'authToken', includeIfNull: false)
  final String authToken;
  static const fromJsonFactory = _$AuthPlexPost$RequestBodyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AuthPlexPost$RequestBody &&
            (identical(other.authToken, authToken) ||
                const DeepCollectionEquality().equals(
                  other.authToken,
                  authToken,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(authToken) ^ runtimeType.hashCode;
}

extension $AuthPlexPost$RequestBodyExtension on AuthPlexPost$RequestBody {
  AuthPlexPost$RequestBody copyWith({String? authToken}) {
    return AuthPlexPost$RequestBody(authToken: authToken ?? this.authToken);
  }

  AuthPlexPost$RequestBody copyWithWrapped({Wrapped<String>? authToken}) {
    return AuthPlexPost$RequestBody(
      authToken: (authToken != null ? authToken.value : this.authToken),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AuthJellyfinPost$RequestBody {
  const AuthJellyfinPost$RequestBody({
    required this.username,
    required this.password,
    this.hostname,
    this.email,
    this.serverType,
  });

  factory AuthJellyfinPost$RequestBody.fromJson(Map<String, dynamic> json) =>
      _$AuthJellyfinPost$RequestBodyFromJson(json);

  static const toJsonFactory = _$AuthJellyfinPost$RequestBodyToJson;
  Map<String, dynamic> toJson() => _$AuthJellyfinPost$RequestBodyToJson(this);

  @JsonKey(name: 'username', includeIfNull: false)
  final String username;
  @JsonKey(name: 'password', includeIfNull: false)
  final String password;
  @JsonKey(name: 'hostname', includeIfNull: false)
  final String? hostname;
  @JsonKey(name: 'email', includeIfNull: false)
  final String? email;
  @JsonKey(name: 'serverType', includeIfNull: false)
  final double? serverType;
  static const fromJsonFactory = _$AuthJellyfinPost$RequestBodyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AuthJellyfinPost$RequestBody &&
            (identical(other.username, username) ||
                const DeepCollectionEquality().equals(
                  other.username,
                  username,
                )) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality().equals(
                  other.password,
                  password,
                )) &&
            (identical(other.hostname, hostname) ||
                const DeepCollectionEquality().equals(
                  other.hostname,
                  hostname,
                )) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.serverType, serverType) ||
                const DeepCollectionEquality().equals(
                  other.serverType,
                  serverType,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(password) ^
      const DeepCollectionEquality().hash(hostname) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(serverType) ^
      runtimeType.hashCode;
}

extension $AuthJellyfinPost$RequestBodyExtension
    on AuthJellyfinPost$RequestBody {
  AuthJellyfinPost$RequestBody copyWith({
    String? username,
    String? password,
    String? hostname,
    String? email,
    double? serverType,
  }) {
    return AuthJellyfinPost$RequestBody(
      username: username ?? this.username,
      password: password ?? this.password,
      hostname: hostname ?? this.hostname,
      email: email ?? this.email,
      serverType: serverType ?? this.serverType,
    );
  }

  AuthJellyfinPost$RequestBody copyWithWrapped({
    Wrapped<String>? username,
    Wrapped<String>? password,
    Wrapped<String?>? hostname,
    Wrapped<String?>? email,
    Wrapped<double?>? serverType,
  }) {
    return AuthJellyfinPost$RequestBody(
      username: (username != null ? username.value : this.username),
      password: (password != null ? password.value : this.password),
      hostname: (hostname != null ? hostname.value : this.hostname),
      email: (email != null ? email.value : this.email),
      serverType: (serverType != null ? serverType.value : this.serverType),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AuthLocalPost$RequestBody {
  const AuthLocalPost$RequestBody({
    required this.email,
    required this.password,
  });

  factory AuthLocalPost$RequestBody.fromJson(Map<String, dynamic> json) =>
      _$AuthLocalPost$RequestBodyFromJson(json);

  static const toJsonFactory = _$AuthLocalPost$RequestBodyToJson;
  Map<String, dynamic> toJson() => _$AuthLocalPost$RequestBodyToJson(this);

  @JsonKey(name: 'email', includeIfNull: false)
  final String email;
  @JsonKey(name: 'password', includeIfNull: false)
  final String password;
  static const fromJsonFactory = _$AuthLocalPost$RequestBodyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AuthLocalPost$RequestBody &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality().equals(
                  other.password,
                  password,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(password) ^
      runtimeType.hashCode;
}

extension $AuthLocalPost$RequestBodyExtension on AuthLocalPost$RequestBody {
  AuthLocalPost$RequestBody copyWith({String? email, String? password}) {
    return AuthLocalPost$RequestBody(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  AuthLocalPost$RequestBody copyWithWrapped({
    Wrapped<String>? email,
    Wrapped<String>? password,
  }) {
    return AuthLocalPost$RequestBody(
      email: (email != null ? email.value : this.email),
      password: (password != null ? password.value : this.password),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AuthResetPasswordPost$RequestBody {
  const AuthResetPasswordPost$RequestBody({required this.email});

  factory AuthResetPasswordPost$RequestBody.fromJson(
    Map<String, dynamic> json,
  ) => _$AuthResetPasswordPost$RequestBodyFromJson(json);

  static const toJsonFactory = _$AuthResetPasswordPost$RequestBodyToJson;
  Map<String, dynamic> toJson() =>
      _$AuthResetPasswordPost$RequestBodyToJson(this);

  @JsonKey(name: 'email', includeIfNull: false)
  final String email;
  static const fromJsonFactory = _$AuthResetPasswordPost$RequestBodyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AuthResetPasswordPost$RequestBody &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(email) ^ runtimeType.hashCode;
}

extension $AuthResetPasswordPost$RequestBodyExtension
    on AuthResetPasswordPost$RequestBody {
  AuthResetPasswordPost$RequestBody copyWith({String? email}) {
    return AuthResetPasswordPost$RequestBody(email: email ?? this.email);
  }

  AuthResetPasswordPost$RequestBody copyWithWrapped({Wrapped<String>? email}) {
    return AuthResetPasswordPost$RequestBody(
      email: (email != null ? email.value : this.email),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AuthResetPasswordGuidPost$RequestBody {
  const AuthResetPasswordGuidPost$RequestBody({required this.password});

  factory AuthResetPasswordGuidPost$RequestBody.fromJson(
    Map<String, dynamic> json,
  ) => _$AuthResetPasswordGuidPost$RequestBodyFromJson(json);

  static const toJsonFactory = _$AuthResetPasswordGuidPost$RequestBodyToJson;
  Map<String, dynamic> toJson() =>
      _$AuthResetPasswordGuidPost$RequestBodyToJson(this);

  @JsonKey(name: 'password', includeIfNull: false)
  final String password;
  static const fromJsonFactory =
      _$AuthResetPasswordGuidPost$RequestBodyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AuthResetPasswordGuidPost$RequestBody &&
            (identical(other.password, password) ||
                const DeepCollectionEquality().equals(
                  other.password,
                  password,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(password) ^ runtimeType.hashCode;
}

extension $AuthResetPasswordGuidPost$RequestBodyExtension
    on AuthResetPasswordGuidPost$RequestBody {
  AuthResetPasswordGuidPost$RequestBody copyWith({String? password}) {
    return AuthResetPasswordGuidPost$RequestBody(
      password: password ?? this.password,
    );
  }

  AuthResetPasswordGuidPost$RequestBody copyWithWrapped({
    Wrapped<String>? password,
  }) {
    return AuthResetPasswordGuidPost$RequestBody(
      password: (password != null ? password.value : this.password),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserPut$RequestBody {
  const UserPut$RequestBody({this.ids, this.permissions});

  factory UserPut$RequestBody.fromJson(Map<String, dynamic> json) =>
      _$UserPut$RequestBodyFromJson(json);

  static const toJsonFactory = _$UserPut$RequestBodyToJson;
  Map<String, dynamic> toJson() => _$UserPut$RequestBodyToJson(this);

  @JsonKey(name: 'ids', includeIfNull: false, defaultValue: <int>[])
  final List<int>? ids;
  @JsonKey(name: 'permissions', includeIfNull: false)
  final int? permissions;
  static const fromJsonFactory = _$UserPut$RequestBodyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserPut$RequestBody &&
            (identical(other.ids, ids) ||
                const DeepCollectionEquality().equals(other.ids, ids)) &&
            (identical(other.permissions, permissions) ||
                const DeepCollectionEquality().equals(
                  other.permissions,
                  permissions,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(ids) ^
      const DeepCollectionEquality().hash(permissions) ^
      runtimeType.hashCode;
}

extension $UserPut$RequestBodyExtension on UserPut$RequestBody {
  UserPut$RequestBody copyWith({List<int>? ids, int? permissions}) {
    return UserPut$RequestBody(
      ids: ids ?? this.ids,
      permissions: permissions ?? this.permissions,
    );
  }

  UserPut$RequestBody copyWithWrapped({
    Wrapped<List<int>?>? ids,
    Wrapped<int?>? permissions,
  }) {
    return UserPut$RequestBody(
      ids: (ids != null ? ids.value : this.ids),
      permissions: (permissions != null ? permissions.value : this.permissions),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserPost$RequestBody {
  const UserPost$RequestBody({this.email, this.username, this.permissions});

  factory UserPost$RequestBody.fromJson(Map<String, dynamic> json) =>
      _$UserPost$RequestBodyFromJson(json);

  static const toJsonFactory = _$UserPost$RequestBodyToJson;
  Map<String, dynamic> toJson() => _$UserPost$RequestBodyToJson(this);

  @JsonKey(name: 'email', includeIfNull: false)
  final String? email;
  @JsonKey(name: 'username', includeIfNull: false)
  final String? username;
  @JsonKey(name: 'permissions', includeIfNull: false)
  final double? permissions;
  static const fromJsonFactory = _$UserPost$RequestBodyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserPost$RequestBody &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.username, username) ||
                const DeepCollectionEquality().equals(
                  other.username,
                  username,
                )) &&
            (identical(other.permissions, permissions) ||
                const DeepCollectionEquality().equals(
                  other.permissions,
                  permissions,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(permissions) ^
      runtimeType.hashCode;
}

extension $UserPost$RequestBodyExtension on UserPost$RequestBody {
  UserPost$RequestBody copyWith({
    String? email,
    String? username,
    double? permissions,
  }) {
    return UserPost$RequestBody(
      email: email ?? this.email,
      username: username ?? this.username,
      permissions: permissions ?? this.permissions,
    );
  }

  UserPost$RequestBody copyWithWrapped({
    Wrapped<String?>? email,
    Wrapped<String?>? username,
    Wrapped<double?>? permissions,
  }) {
    return UserPost$RequestBody(
      email: (email != null ? email.value : this.email),
      username: (username != null ? username.value : this.username),
      permissions: (permissions != null ? permissions.value : this.permissions),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserImportFromPlexPost$RequestBody {
  const UserImportFromPlexPost$RequestBody({this.plexIds});

  factory UserImportFromPlexPost$RequestBody.fromJson(
    Map<String, dynamic> json,
  ) => _$UserImportFromPlexPost$RequestBodyFromJson(json);

  static const toJsonFactory = _$UserImportFromPlexPost$RequestBodyToJson;
  Map<String, dynamic> toJson() =>
      _$UserImportFromPlexPost$RequestBodyToJson(this);

  @JsonKey(name: 'plexIds', includeIfNull: false, defaultValue: <String>[])
  final List<String>? plexIds;
  static const fromJsonFactory = _$UserImportFromPlexPost$RequestBodyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserImportFromPlexPost$RequestBody &&
            (identical(other.plexIds, plexIds) ||
                const DeepCollectionEquality().equals(other.plexIds, plexIds)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(plexIds) ^ runtimeType.hashCode;
}

extension $UserImportFromPlexPost$RequestBodyExtension
    on UserImportFromPlexPost$RequestBody {
  UserImportFromPlexPost$RequestBody copyWith({List<String>? plexIds}) {
    return UserImportFromPlexPost$RequestBody(plexIds: plexIds ?? this.plexIds);
  }

  UserImportFromPlexPost$RequestBody copyWithWrapped({
    Wrapped<List<String>?>? plexIds,
  }) {
    return UserImportFromPlexPost$RequestBody(
      plexIds: (plexIds != null ? plexIds.value : this.plexIds),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserImportFromJellyfinPost$RequestBody {
  const UserImportFromJellyfinPost$RequestBody({this.jellyfinUserIds});

  factory UserImportFromJellyfinPost$RequestBody.fromJson(
    Map<String, dynamic> json,
  ) => _$UserImportFromJellyfinPost$RequestBodyFromJson(json);

  static const toJsonFactory = _$UserImportFromJellyfinPost$RequestBodyToJson;
  Map<String, dynamic> toJson() =>
      _$UserImportFromJellyfinPost$RequestBodyToJson(this);

  @JsonKey(
    name: 'jellyfinUserIds',
    includeIfNull: false,
    defaultValue: <String>[],
  )
  final List<String>? jellyfinUserIds;
  static const fromJsonFactory =
      _$UserImportFromJellyfinPost$RequestBodyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserImportFromJellyfinPost$RequestBody &&
            (identical(other.jellyfinUserIds, jellyfinUserIds) ||
                const DeepCollectionEquality().equals(
                  other.jellyfinUserIds,
                  jellyfinUserIds,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(jellyfinUserIds) ^
      runtimeType.hashCode;
}

extension $UserImportFromJellyfinPost$RequestBodyExtension
    on UserImportFromJellyfinPost$RequestBody {
  UserImportFromJellyfinPost$RequestBody copyWith({
    List<String>? jellyfinUserIds,
  }) {
    return UserImportFromJellyfinPost$RequestBody(
      jellyfinUserIds: jellyfinUserIds ?? this.jellyfinUserIds,
    );
  }

  UserImportFromJellyfinPost$RequestBody copyWithWrapped({
    Wrapped<List<String>?>? jellyfinUserIds,
  }) {
    return UserImportFromJellyfinPost$RequestBody(
      jellyfinUserIds: (jellyfinUserIds != null
          ? jellyfinUserIds.value
          : this.jellyfinUserIds),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserRegisterPushSubscriptionPost$RequestBody {
  const UserRegisterPushSubscriptionPost$RequestBody({
    required this.endpoint,
    required this.auth,
    required this.p256dh,
    this.userAgent,
  });

  factory UserRegisterPushSubscriptionPost$RequestBody.fromJson(
    Map<String, dynamic> json,
  ) => _$UserRegisterPushSubscriptionPost$RequestBodyFromJson(json);

  static const toJsonFactory =
      _$UserRegisterPushSubscriptionPost$RequestBodyToJson;
  Map<String, dynamic> toJson() =>
      _$UserRegisterPushSubscriptionPost$RequestBodyToJson(this);

  @JsonKey(name: 'endpoint', includeIfNull: false)
  final String endpoint;
  @JsonKey(name: 'auth', includeIfNull: false)
  final String auth;
  @JsonKey(name: 'p256dh', includeIfNull: false)
  final String p256dh;
  @JsonKey(name: 'userAgent', includeIfNull: false)
  final String? userAgent;
  static const fromJsonFactory =
      _$UserRegisterPushSubscriptionPost$RequestBodyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserRegisterPushSubscriptionPost$RequestBody &&
            (identical(other.endpoint, endpoint) ||
                const DeepCollectionEquality().equals(
                  other.endpoint,
                  endpoint,
                )) &&
            (identical(other.auth, auth) ||
                const DeepCollectionEquality().equals(other.auth, auth)) &&
            (identical(other.p256dh, p256dh) ||
                const DeepCollectionEquality().equals(other.p256dh, p256dh)) &&
            (identical(other.userAgent, userAgent) ||
                const DeepCollectionEquality().equals(
                  other.userAgent,
                  userAgent,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(endpoint) ^
      const DeepCollectionEquality().hash(auth) ^
      const DeepCollectionEquality().hash(p256dh) ^
      const DeepCollectionEquality().hash(userAgent) ^
      runtimeType.hashCode;
}

extension $UserRegisterPushSubscriptionPost$RequestBodyExtension
    on UserRegisterPushSubscriptionPost$RequestBody {
  UserRegisterPushSubscriptionPost$RequestBody copyWith({
    String? endpoint,
    String? auth,
    String? p256dh,
    String? userAgent,
  }) {
    return UserRegisterPushSubscriptionPost$RequestBody(
      endpoint: endpoint ?? this.endpoint,
      auth: auth ?? this.auth,
      p256dh: p256dh ?? this.p256dh,
      userAgent: userAgent ?? this.userAgent,
    );
  }

  UserRegisterPushSubscriptionPost$RequestBody copyWithWrapped({
    Wrapped<String>? endpoint,
    Wrapped<String>? auth,
    Wrapped<String>? p256dh,
    Wrapped<String?>? userAgent,
  }) {
    return UserRegisterPushSubscriptionPost$RequestBody(
      endpoint: (endpoint != null ? endpoint.value : this.endpoint),
      auth: (auth != null ? auth.value : this.auth),
      p256dh: (p256dh != null ? p256dh.value : this.p256dh),
      userAgent: (userAgent != null ? userAgent.value : this.userAgent),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserUserIdSettingsPasswordPost$RequestBody {
  const UserUserIdSettingsPasswordPost$RequestBody({
    this.currentPassword,
    required this.newPassword,
  });

  factory UserUserIdSettingsPasswordPost$RequestBody.fromJson(
    Map<String, dynamic> json,
  ) => _$UserUserIdSettingsPasswordPost$RequestBodyFromJson(json);

  static const toJsonFactory =
      _$UserUserIdSettingsPasswordPost$RequestBodyToJson;
  Map<String, dynamic> toJson() =>
      _$UserUserIdSettingsPasswordPost$RequestBodyToJson(this);

  @JsonKey(name: 'currentPassword', includeIfNull: false)
  final String? currentPassword;
  @JsonKey(name: 'newPassword', includeIfNull: false)
  final String newPassword;
  static const fromJsonFactory =
      _$UserUserIdSettingsPasswordPost$RequestBodyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserUserIdSettingsPasswordPost$RequestBody &&
            (identical(other.currentPassword, currentPassword) ||
                const DeepCollectionEquality().equals(
                  other.currentPassword,
                  currentPassword,
                )) &&
            (identical(other.newPassword, newPassword) ||
                const DeepCollectionEquality().equals(
                  other.newPassword,
                  newPassword,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(currentPassword) ^
      const DeepCollectionEquality().hash(newPassword) ^
      runtimeType.hashCode;
}

extension $UserUserIdSettingsPasswordPost$RequestBodyExtension
    on UserUserIdSettingsPasswordPost$RequestBody {
  UserUserIdSettingsPasswordPost$RequestBody copyWith({
    String? currentPassword,
    String? newPassword,
  }) {
    return UserUserIdSettingsPasswordPost$RequestBody(
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
    );
  }

  UserUserIdSettingsPasswordPost$RequestBody copyWithWrapped({
    Wrapped<String?>? currentPassword,
    Wrapped<String>? newPassword,
  }) {
    return UserUserIdSettingsPasswordPost$RequestBody(
      currentPassword: (currentPassword != null
          ? currentPassword.value
          : this.currentPassword),
      newPassword: (newPassword != null ? newPassword.value : this.newPassword),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserUserIdSettingsLinkedAccountsPlexPost$RequestBody {
  const UserUserIdSettingsLinkedAccountsPlexPost$RequestBody({
    required this.authToken,
  });

  factory UserUserIdSettingsLinkedAccountsPlexPost$RequestBody.fromJson(
    Map<String, dynamic> json,
  ) => _$UserUserIdSettingsLinkedAccountsPlexPost$RequestBodyFromJson(json);

  static const toJsonFactory =
      _$UserUserIdSettingsLinkedAccountsPlexPost$RequestBodyToJson;
  Map<String, dynamic> toJson() =>
      _$UserUserIdSettingsLinkedAccountsPlexPost$RequestBodyToJson(this);

  @JsonKey(name: 'authToken', includeIfNull: false)
  final String authToken;
  static const fromJsonFactory =
      _$UserUserIdSettingsLinkedAccountsPlexPost$RequestBodyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserUserIdSettingsLinkedAccountsPlexPost$RequestBody &&
            (identical(other.authToken, authToken) ||
                const DeepCollectionEquality().equals(
                  other.authToken,
                  authToken,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(authToken) ^ runtimeType.hashCode;
}

extension $UserUserIdSettingsLinkedAccountsPlexPost$RequestBodyExtension
    on UserUserIdSettingsLinkedAccountsPlexPost$RequestBody {
  UserUserIdSettingsLinkedAccountsPlexPost$RequestBody copyWith({
    String? authToken,
  }) {
    return UserUserIdSettingsLinkedAccountsPlexPost$RequestBody(
      authToken: authToken ?? this.authToken,
    );
  }

  UserUserIdSettingsLinkedAccountsPlexPost$RequestBody copyWithWrapped({
    Wrapped<String>? authToken,
  }) {
    return UserUserIdSettingsLinkedAccountsPlexPost$RequestBody(
      authToken: (authToken != null ? authToken.value : this.authToken),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserUserIdSettingsLinkedAccountsJellyfinPost$RequestBody {
  const UserUserIdSettingsLinkedAccountsJellyfinPost$RequestBody({
    this.username,
    this.password,
  });

  factory UserUserIdSettingsLinkedAccountsJellyfinPost$RequestBody.fromJson(
    Map<String, dynamic> json,
  ) => _$UserUserIdSettingsLinkedAccountsJellyfinPost$RequestBodyFromJson(json);

  static const toJsonFactory =
      _$UserUserIdSettingsLinkedAccountsJellyfinPost$RequestBodyToJson;
  Map<String, dynamic> toJson() =>
      _$UserUserIdSettingsLinkedAccountsJellyfinPost$RequestBodyToJson(this);

  @JsonKey(name: 'username', includeIfNull: false)
  final String? username;
  @JsonKey(name: 'password', includeIfNull: false)
  final String? password;
  static const fromJsonFactory =
      _$UserUserIdSettingsLinkedAccountsJellyfinPost$RequestBodyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserUserIdSettingsLinkedAccountsJellyfinPost$RequestBody &&
            (identical(other.username, username) ||
                const DeepCollectionEquality().equals(
                  other.username,
                  username,
                )) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality().equals(
                  other.password,
                  password,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(password) ^
      runtimeType.hashCode;
}

extension $UserUserIdSettingsLinkedAccountsJellyfinPost$RequestBodyExtension
    on UserUserIdSettingsLinkedAccountsJellyfinPost$RequestBody {
  UserUserIdSettingsLinkedAccountsJellyfinPost$RequestBody copyWith({
    String? username,
    String? password,
  }) {
    return UserUserIdSettingsLinkedAccountsJellyfinPost$RequestBody(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  UserUserIdSettingsLinkedAccountsJellyfinPost$RequestBody copyWithWrapped({
    Wrapped<String?>? username,
    Wrapped<String?>? password,
  }) {
    return UserUserIdSettingsLinkedAccountsJellyfinPost$RequestBody(
      username: (username != null ? username.value : this.username),
      password: (password != null ? password.value : this.password),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserUserIdSettingsPermissionsPost$RequestBody {
  const UserUserIdSettingsPermissionsPost$RequestBody({
    required this.permissions,
  });

  factory UserUserIdSettingsPermissionsPost$RequestBody.fromJson(
    Map<String, dynamic> json,
  ) => _$UserUserIdSettingsPermissionsPost$RequestBodyFromJson(json);

  static const toJsonFactory =
      _$UserUserIdSettingsPermissionsPost$RequestBodyToJson;
  Map<String, dynamic> toJson() =>
      _$UserUserIdSettingsPermissionsPost$RequestBodyToJson(this);

  @JsonKey(name: 'permissions', includeIfNull: false)
  final double permissions;
  static const fromJsonFactory =
      _$UserUserIdSettingsPermissionsPost$RequestBodyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserUserIdSettingsPermissionsPost$RequestBody &&
            (identical(other.permissions, permissions) ||
                const DeepCollectionEquality().equals(
                  other.permissions,
                  permissions,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(permissions) ^ runtimeType.hashCode;
}

extension $UserUserIdSettingsPermissionsPost$RequestBodyExtension
    on UserUserIdSettingsPermissionsPost$RequestBody {
  UserUserIdSettingsPermissionsPost$RequestBody copyWith({
    double? permissions,
  }) {
    return UserUserIdSettingsPermissionsPost$RequestBody(
      permissions: permissions ?? this.permissions,
    );
  }

  UserUserIdSettingsPermissionsPost$RequestBody copyWithWrapped({
    Wrapped<double>? permissions,
  }) {
    return UserUserIdSettingsPermissionsPost$RequestBody(
      permissions: (permissions != null ? permissions.value : this.permissions),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RequestPost$RequestBody {
  const RequestPost$RequestBody({
    required this.mediaType,
    required this.mediaId,
    this.tvdbId,
    this.seasons,
    this.is4k,
    this.serverId,
    this.profileId,
    this.rootFolder,
    this.languageProfileId,
    this.userId,
  });

  factory RequestPost$RequestBody.fromJson(Map<String, dynamic> json) =>
      _$RequestPost$RequestBodyFromJson(json);

  static const toJsonFactory = _$RequestPost$RequestBodyToJson;
  Map<String, dynamic> toJson() => _$RequestPost$RequestBodyToJson(this);

  @JsonKey(
    name: 'mediaType',
    includeIfNull: false,
    toJson: requestPost$RequestBodyMediaTypeToJson,
    fromJson: requestPost$RequestBodyMediaTypeFromJson,
  )
  final enums.RequestPost$RequestBodyMediaType mediaType;
  @JsonKey(name: 'mediaId', includeIfNull: false)
  final double mediaId;
  @JsonKey(name: 'tvdbId', includeIfNull: false)
  final double? tvdbId;
  @JsonKey(name: 'seasons', includeIfNull: false)
  final dynamic seasons;
  @JsonKey(name: 'is4k', includeIfNull: false)
  final bool? is4k;
  @JsonKey(name: 'serverId', includeIfNull: false)
  final double? serverId;
  @JsonKey(name: 'profileId', includeIfNull: false)
  final double? profileId;
  @JsonKey(name: 'rootFolder', includeIfNull: false)
  final String? rootFolder;
  @JsonKey(name: 'languageProfileId', includeIfNull: false)
  final double? languageProfileId;
  @JsonKey(name: 'userId', includeIfNull: false)
  final double? userId;
  static const fromJsonFactory = _$RequestPost$RequestBodyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is RequestPost$RequestBody &&
            (identical(other.mediaType, mediaType) ||
                const DeepCollectionEquality().equals(
                  other.mediaType,
                  mediaType,
                )) &&
            (identical(other.mediaId, mediaId) ||
                const DeepCollectionEquality().equals(
                  other.mediaId,
                  mediaId,
                )) &&
            (identical(other.tvdbId, tvdbId) ||
                const DeepCollectionEquality().equals(other.tvdbId, tvdbId)) &&
            (identical(other.seasons, seasons) ||
                const DeepCollectionEquality().equals(
                  other.seasons,
                  seasons,
                )) &&
            (identical(other.is4k, is4k) ||
                const DeepCollectionEquality().equals(other.is4k, is4k)) &&
            (identical(other.serverId, serverId) ||
                const DeepCollectionEquality().equals(
                  other.serverId,
                  serverId,
                )) &&
            (identical(other.profileId, profileId) ||
                const DeepCollectionEquality().equals(
                  other.profileId,
                  profileId,
                )) &&
            (identical(other.rootFolder, rootFolder) ||
                const DeepCollectionEquality().equals(
                  other.rootFolder,
                  rootFolder,
                )) &&
            (identical(other.languageProfileId, languageProfileId) ||
                const DeepCollectionEquality().equals(
                  other.languageProfileId,
                  languageProfileId,
                )) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(mediaType) ^
      const DeepCollectionEquality().hash(mediaId) ^
      const DeepCollectionEquality().hash(tvdbId) ^
      const DeepCollectionEquality().hash(seasons) ^
      const DeepCollectionEquality().hash(is4k) ^
      const DeepCollectionEquality().hash(serverId) ^
      const DeepCollectionEquality().hash(profileId) ^
      const DeepCollectionEquality().hash(rootFolder) ^
      const DeepCollectionEquality().hash(languageProfileId) ^
      const DeepCollectionEquality().hash(userId) ^
      runtimeType.hashCode;
}

extension $RequestPost$RequestBodyExtension on RequestPost$RequestBody {
  RequestPost$RequestBody copyWith({
    enums.RequestPost$RequestBodyMediaType? mediaType,
    double? mediaId,
    double? tvdbId,
    dynamic seasons,
    bool? is4k,
    double? serverId,
    double? profileId,
    String? rootFolder,
    double? languageProfileId,
    double? userId,
  }) {
    return RequestPost$RequestBody(
      mediaType: mediaType ?? this.mediaType,
      mediaId: mediaId ?? this.mediaId,
      tvdbId: tvdbId ?? this.tvdbId,
      seasons: seasons ?? this.seasons,
      is4k: is4k ?? this.is4k,
      serverId: serverId ?? this.serverId,
      profileId: profileId ?? this.profileId,
      rootFolder: rootFolder ?? this.rootFolder,
      languageProfileId: languageProfileId ?? this.languageProfileId,
      userId: userId ?? this.userId,
    );
  }

  RequestPost$RequestBody copyWithWrapped({
    Wrapped<enums.RequestPost$RequestBodyMediaType>? mediaType,
    Wrapped<double>? mediaId,
    Wrapped<double?>? tvdbId,
    Wrapped<dynamic>? seasons,
    Wrapped<bool?>? is4k,
    Wrapped<double?>? serverId,
    Wrapped<double?>? profileId,
    Wrapped<String?>? rootFolder,
    Wrapped<double?>? languageProfileId,
    Wrapped<double?>? userId,
  }) {
    return RequestPost$RequestBody(
      mediaType: (mediaType != null ? mediaType.value : this.mediaType),
      mediaId: (mediaId != null ? mediaId.value : this.mediaId),
      tvdbId: (tvdbId != null ? tvdbId.value : this.tvdbId),
      seasons: (seasons != null ? seasons.value : this.seasons),
      is4k: (is4k != null ? is4k.value : this.is4k),
      serverId: (serverId != null ? serverId.value : this.serverId),
      profileId: (profileId != null ? profileId.value : this.profileId),
      rootFolder: (rootFolder != null ? rootFolder.value : this.rootFolder),
      languageProfileId: (languageProfileId != null
          ? languageProfileId.value
          : this.languageProfileId),
      userId: (userId != null ? userId.value : this.userId),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RequestRequestIdPut$RequestBody {
  const RequestRequestIdPut$RequestBody({
    required this.mediaType,
    this.seasons,
    this.is4k,
    this.serverId,
    this.profileId,
    this.rootFolder,
    this.languageProfileId,
    this.userId,
  });

  factory RequestRequestIdPut$RequestBody.fromJson(Map<String, dynamic> json) =>
      _$RequestRequestIdPut$RequestBodyFromJson(json);

  static const toJsonFactory = _$RequestRequestIdPut$RequestBodyToJson;
  Map<String, dynamic> toJson() =>
      _$RequestRequestIdPut$RequestBodyToJson(this);

  @JsonKey(
    name: 'mediaType',
    includeIfNull: false,
    toJson: requestRequestIdPut$RequestBodyMediaTypeToJson,
    fromJson: requestRequestIdPut$RequestBodyMediaTypeFromJson,
  )
  final enums.RequestRequestIdPut$RequestBodyMediaType mediaType;
  @JsonKey(name: 'seasons', includeIfNull: false, defaultValue: <double>[])
  final List<double>? seasons;
  @JsonKey(name: 'is4k', includeIfNull: false)
  final bool? is4k;
  @JsonKey(name: 'serverId', includeIfNull: false)
  final double? serverId;
  @JsonKey(name: 'profileId', includeIfNull: false)
  final double? profileId;
  @JsonKey(name: 'rootFolder', includeIfNull: false)
  final String? rootFolder;
  @JsonKey(name: 'languageProfileId', includeIfNull: false)
  final double? languageProfileId;
  @JsonKey(name: 'userId', includeIfNull: false)
  final double? userId;
  static const fromJsonFactory = _$RequestRequestIdPut$RequestBodyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is RequestRequestIdPut$RequestBody &&
            (identical(other.mediaType, mediaType) ||
                const DeepCollectionEquality().equals(
                  other.mediaType,
                  mediaType,
                )) &&
            (identical(other.seasons, seasons) ||
                const DeepCollectionEquality().equals(
                  other.seasons,
                  seasons,
                )) &&
            (identical(other.is4k, is4k) ||
                const DeepCollectionEquality().equals(other.is4k, is4k)) &&
            (identical(other.serverId, serverId) ||
                const DeepCollectionEquality().equals(
                  other.serverId,
                  serverId,
                )) &&
            (identical(other.profileId, profileId) ||
                const DeepCollectionEquality().equals(
                  other.profileId,
                  profileId,
                )) &&
            (identical(other.rootFolder, rootFolder) ||
                const DeepCollectionEquality().equals(
                  other.rootFolder,
                  rootFolder,
                )) &&
            (identical(other.languageProfileId, languageProfileId) ||
                const DeepCollectionEquality().equals(
                  other.languageProfileId,
                  languageProfileId,
                )) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(mediaType) ^
      const DeepCollectionEquality().hash(seasons) ^
      const DeepCollectionEquality().hash(is4k) ^
      const DeepCollectionEquality().hash(serverId) ^
      const DeepCollectionEquality().hash(profileId) ^
      const DeepCollectionEquality().hash(rootFolder) ^
      const DeepCollectionEquality().hash(languageProfileId) ^
      const DeepCollectionEquality().hash(userId) ^
      runtimeType.hashCode;
}

extension $RequestRequestIdPut$RequestBodyExtension
    on RequestRequestIdPut$RequestBody {
  RequestRequestIdPut$RequestBody copyWith({
    enums.RequestRequestIdPut$RequestBodyMediaType? mediaType,
    List<double>? seasons,
    bool? is4k,
    double? serverId,
    double? profileId,
    String? rootFolder,
    double? languageProfileId,
    double? userId,
  }) {
    return RequestRequestIdPut$RequestBody(
      mediaType: mediaType ?? this.mediaType,
      seasons: seasons ?? this.seasons,
      is4k: is4k ?? this.is4k,
      serverId: serverId ?? this.serverId,
      profileId: profileId ?? this.profileId,
      rootFolder: rootFolder ?? this.rootFolder,
      languageProfileId: languageProfileId ?? this.languageProfileId,
      userId: userId ?? this.userId,
    );
  }

  RequestRequestIdPut$RequestBody copyWithWrapped({
    Wrapped<enums.RequestRequestIdPut$RequestBodyMediaType>? mediaType,
    Wrapped<List<double>?>? seasons,
    Wrapped<bool?>? is4k,
    Wrapped<double?>? serverId,
    Wrapped<double?>? profileId,
    Wrapped<String?>? rootFolder,
    Wrapped<double?>? languageProfileId,
    Wrapped<double?>? userId,
  }) {
    return RequestRequestIdPut$RequestBody(
      mediaType: (mediaType != null ? mediaType.value : this.mediaType),
      seasons: (seasons != null ? seasons.value : this.seasons),
      is4k: (is4k != null ? is4k.value : this.is4k),
      serverId: (serverId != null ? serverId.value : this.serverId),
      profileId: (profileId != null ? profileId.value : this.profileId),
      rootFolder: (rootFolder != null ? rootFolder.value : this.rootFolder),
      languageProfileId: (languageProfileId != null
          ? languageProfileId.value
          : this.languageProfileId),
      userId: (userId != null ? userId.value : this.userId),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class MediaMediaIdStatusPost$RequestBody {
  const MediaMediaIdStatusPost$RequestBody({this.is4k});

  factory MediaMediaIdStatusPost$RequestBody.fromJson(
    Map<String, dynamic> json,
  ) => _$MediaMediaIdStatusPost$RequestBodyFromJson(json);

  static const toJsonFactory = _$MediaMediaIdStatusPost$RequestBodyToJson;
  Map<String, dynamic> toJson() =>
      _$MediaMediaIdStatusPost$RequestBodyToJson(this);

  @JsonKey(name: 'is4k', includeIfNull: false)
  final bool? is4k;
  static const fromJsonFactory = _$MediaMediaIdStatusPost$RequestBodyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MediaMediaIdStatusPost$RequestBody &&
            (identical(other.is4k, is4k) ||
                const DeepCollectionEquality().equals(other.is4k, is4k)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(is4k) ^ runtimeType.hashCode;
}

extension $MediaMediaIdStatusPost$RequestBodyExtension
    on MediaMediaIdStatusPost$RequestBody {
  MediaMediaIdStatusPost$RequestBody copyWith({bool? is4k}) {
    return MediaMediaIdStatusPost$RequestBody(is4k: is4k ?? this.is4k);
  }

  MediaMediaIdStatusPost$RequestBody copyWithWrapped({Wrapped<bool?>? is4k}) {
    return MediaMediaIdStatusPost$RequestBody(
      is4k: (is4k != null ? is4k.value : this.is4k),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class IssuePost$RequestBody {
  const IssuePost$RequestBody({this.issueType, this.message, this.mediaId});

  factory IssuePost$RequestBody.fromJson(Map<String, dynamic> json) =>
      _$IssuePost$RequestBodyFromJson(json);

  static const toJsonFactory = _$IssuePost$RequestBodyToJson;
  Map<String, dynamic> toJson() => _$IssuePost$RequestBodyToJson(this);

  @JsonKey(name: 'issueType', includeIfNull: false)
  final double? issueType;
  @JsonKey(name: 'message', includeIfNull: false)
  final String? message;
  @JsonKey(name: 'mediaId', includeIfNull: false)
  final double? mediaId;
  static const fromJsonFactory = _$IssuePost$RequestBodyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is IssuePost$RequestBody &&
            (identical(other.issueType, issueType) ||
                const DeepCollectionEquality().equals(
                  other.issueType,
                  issueType,
                )) &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(
                  other.message,
                  message,
                )) &&
            (identical(other.mediaId, mediaId) ||
                const DeepCollectionEquality().equals(other.mediaId, mediaId)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(issueType) ^
      const DeepCollectionEquality().hash(message) ^
      const DeepCollectionEquality().hash(mediaId) ^
      runtimeType.hashCode;
}

extension $IssuePost$RequestBodyExtension on IssuePost$RequestBody {
  IssuePost$RequestBody copyWith({
    double? issueType,
    String? message,
    double? mediaId,
  }) {
    return IssuePost$RequestBody(
      issueType: issueType ?? this.issueType,
      message: message ?? this.message,
      mediaId: mediaId ?? this.mediaId,
    );
  }

  IssuePost$RequestBody copyWithWrapped({
    Wrapped<double?>? issueType,
    Wrapped<String?>? message,
    Wrapped<double?>? mediaId,
  }) {
    return IssuePost$RequestBody(
      issueType: (issueType != null ? issueType.value : this.issueType),
      message: (message != null ? message.value : this.message),
      mediaId: (mediaId != null ? mediaId.value : this.mediaId),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class IssueIssueIdCommentPost$RequestBody {
  const IssueIssueIdCommentPost$RequestBody({required this.message});

  factory IssueIssueIdCommentPost$RequestBody.fromJson(
    Map<String, dynamic> json,
  ) => _$IssueIssueIdCommentPost$RequestBodyFromJson(json);

  static const toJsonFactory = _$IssueIssueIdCommentPost$RequestBodyToJson;
  Map<String, dynamic> toJson() =>
      _$IssueIssueIdCommentPost$RequestBodyToJson(this);

  @JsonKey(name: 'message', includeIfNull: false)
  final String message;
  static const fromJsonFactory = _$IssueIssueIdCommentPost$RequestBodyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is IssueIssueIdCommentPost$RequestBody &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(message) ^ runtimeType.hashCode;
}

extension $IssueIssueIdCommentPost$RequestBodyExtension
    on IssueIssueIdCommentPost$RequestBody {
  IssueIssueIdCommentPost$RequestBody copyWith({String? message}) {
    return IssueIssueIdCommentPost$RequestBody(
      message: message ?? this.message,
    );
  }

  IssueIssueIdCommentPost$RequestBody copyWithWrapped({
    Wrapped<String>? message,
  }) {
    return IssueIssueIdCommentPost$RequestBody(
      message: (message != null ? message.value : this.message),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class IssueCommentCommentIdPut$RequestBody {
  const IssueCommentCommentIdPut$RequestBody({this.message});

  factory IssueCommentCommentIdPut$RequestBody.fromJson(
    Map<String, dynamic> json,
  ) => _$IssueCommentCommentIdPut$RequestBodyFromJson(json);

  static const toJsonFactory = _$IssueCommentCommentIdPut$RequestBodyToJson;
  Map<String, dynamic> toJson() =>
      _$IssueCommentCommentIdPut$RequestBodyToJson(this);

  @JsonKey(name: 'message', includeIfNull: false)
  final String? message;
  static const fromJsonFactory = _$IssueCommentCommentIdPut$RequestBodyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is IssueCommentCommentIdPut$RequestBody &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(message) ^ runtimeType.hashCode;
}

extension $IssueCommentCommentIdPut$RequestBodyExtension
    on IssueCommentCommentIdPut$RequestBody {
  IssueCommentCommentIdPut$RequestBody copyWith({String? message}) {
    return IssueCommentCommentIdPut$RequestBody(
      message: message ?? this.message,
    );
  }

  IssueCommentCommentIdPut$RequestBody copyWithWrapped({
    Wrapped<String?>? message,
  }) {
    return IssueCommentCommentIdPut$RequestBody(
      message: (message != null ? message.value : this.message),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class StatusGet$Response {
  const StatusGet$Response({
    this.version,
    this.commitTag,
    this.updateAvailable,
    this.commitsBehind,
    this.restartRequired,
  });

  factory StatusGet$Response.fromJson(Map<String, dynamic> json) =>
      _$StatusGet$ResponseFromJson(json);

  static const toJsonFactory = _$StatusGet$ResponseToJson;
  Map<String, dynamic> toJson() => _$StatusGet$ResponseToJson(this);

  @JsonKey(name: 'version', includeIfNull: false)
  final String? version;
  @JsonKey(name: 'commitTag', includeIfNull: false)
  final String? commitTag;
  @JsonKey(name: 'updateAvailable', includeIfNull: false)
  final bool? updateAvailable;
  @JsonKey(name: 'commitsBehind', includeIfNull: false)
  final double? commitsBehind;
  @JsonKey(name: 'restartRequired', includeIfNull: false)
  final bool? restartRequired;
  static const fromJsonFactory = _$StatusGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is StatusGet$Response &&
            (identical(other.version, version) ||
                const DeepCollectionEquality().equals(
                  other.version,
                  version,
                )) &&
            (identical(other.commitTag, commitTag) ||
                const DeepCollectionEquality().equals(
                  other.commitTag,
                  commitTag,
                )) &&
            (identical(other.updateAvailable, updateAvailable) ||
                const DeepCollectionEquality().equals(
                  other.updateAvailable,
                  updateAvailable,
                )) &&
            (identical(other.commitsBehind, commitsBehind) ||
                const DeepCollectionEquality().equals(
                  other.commitsBehind,
                  commitsBehind,
                )) &&
            (identical(other.restartRequired, restartRequired) ||
                const DeepCollectionEquality().equals(
                  other.restartRequired,
                  restartRequired,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(version) ^
      const DeepCollectionEquality().hash(commitTag) ^
      const DeepCollectionEquality().hash(updateAvailable) ^
      const DeepCollectionEquality().hash(commitsBehind) ^
      const DeepCollectionEquality().hash(restartRequired) ^
      runtimeType.hashCode;
}

extension $StatusGet$ResponseExtension on StatusGet$Response {
  StatusGet$Response copyWith({
    String? version,
    String? commitTag,
    bool? updateAvailable,
    double? commitsBehind,
    bool? restartRequired,
  }) {
    return StatusGet$Response(
      version: version ?? this.version,
      commitTag: commitTag ?? this.commitTag,
      updateAvailable: updateAvailable ?? this.updateAvailable,
      commitsBehind: commitsBehind ?? this.commitsBehind,
      restartRequired: restartRequired ?? this.restartRequired,
    );
  }

  StatusGet$Response copyWithWrapped({
    Wrapped<String?>? version,
    Wrapped<String?>? commitTag,
    Wrapped<bool?>? updateAvailable,
    Wrapped<double?>? commitsBehind,
    Wrapped<bool?>? restartRequired,
  }) {
    return StatusGet$Response(
      version: (version != null ? version.value : this.version),
      commitTag: (commitTag != null ? commitTag.value : this.commitTag),
      updateAvailable: (updateAvailable != null
          ? updateAvailable.value
          : this.updateAvailable),
      commitsBehind: (commitsBehind != null
          ? commitsBehind.value
          : this.commitsBehind),
      restartRequired: (restartRequired != null
          ? restartRequired.value
          : this.restartRequired),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class StatusAppdataGet$Response {
  const StatusAppdataGet$Response({
    this.appData,
    this.appDataPath,
    this.appDataPermissions,
  });

  factory StatusAppdataGet$Response.fromJson(Map<String, dynamic> json) =>
      _$StatusAppdataGet$ResponseFromJson(json);

  static const toJsonFactory = _$StatusAppdataGet$ResponseToJson;
  Map<String, dynamic> toJson() => _$StatusAppdataGet$ResponseToJson(this);

  @JsonKey(name: 'appData', includeIfNull: false)
  final bool? appData;
  @JsonKey(name: 'appDataPath', includeIfNull: false)
  final String? appDataPath;
  @JsonKey(name: 'appDataPermissions', includeIfNull: false)
  final bool? appDataPermissions;
  static const fromJsonFactory = _$StatusAppdataGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is StatusAppdataGet$Response &&
            (identical(other.appData, appData) ||
                const DeepCollectionEquality().equals(
                  other.appData,
                  appData,
                )) &&
            (identical(other.appDataPath, appDataPath) ||
                const DeepCollectionEquality().equals(
                  other.appDataPath,
                  appDataPath,
                )) &&
            (identical(other.appDataPermissions, appDataPermissions) ||
                const DeepCollectionEquality().equals(
                  other.appDataPermissions,
                  appDataPermissions,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(appData) ^
      const DeepCollectionEquality().hash(appDataPath) ^
      const DeepCollectionEquality().hash(appDataPermissions) ^
      runtimeType.hashCode;
}

extension $StatusAppdataGet$ResponseExtension on StatusAppdataGet$Response {
  StatusAppdataGet$Response copyWith({
    bool? appData,
    String? appDataPath,
    bool? appDataPermissions,
  }) {
    return StatusAppdataGet$Response(
      appData: appData ?? this.appData,
      appDataPath: appDataPath ?? this.appDataPath,
      appDataPermissions: appDataPermissions ?? this.appDataPermissions,
    );
  }

  StatusAppdataGet$Response copyWithWrapped({
    Wrapped<bool?>? appData,
    Wrapped<String?>? appDataPath,
    Wrapped<bool?>? appDataPermissions,
  }) {
    return StatusAppdataGet$Response(
      appData: (appData != null ? appData.value : this.appData),
      appDataPath: (appDataPath != null ? appDataPath.value : this.appDataPath),
      appDataPermissions: (appDataPermissions != null
          ? appDataPermissions.value
          : this.appDataPermissions),
    );
  }
}

typedef SettingsJellyfinUsersGet$Response =
    List<SettingsJellyfinUsersGet$Response$Item>;

@JsonSerializable(explicitToJson: true)
class SettingsJellyfinUsersGet$Response$Item {
  const SettingsJellyfinUsersGet$Response$Item({
    this.username,
    this.id,
    this.thumb,
    this.email,
  });

  factory SettingsJellyfinUsersGet$Response$Item.fromJson(
    Map<String, dynamic> json,
  ) => _$SettingsJellyfinUsersGet$Response$ItemFromJson(json);

  static const toJsonFactory = _$SettingsJellyfinUsersGet$Response$ItemToJson;
  Map<String, dynamic> toJson() =>
      _$SettingsJellyfinUsersGet$Response$ItemToJson(this);

  @JsonKey(name: 'username', includeIfNull: false)
  final String? username;
  @JsonKey(name: 'id', includeIfNull: false)
  final String? id;
  @JsonKey(name: 'thumb', includeIfNull: false)
  final String? thumb;
  @JsonKey(name: 'email', includeIfNull: false)
  final String? email;
  static const fromJsonFactory =
      _$SettingsJellyfinUsersGet$Response$ItemFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SettingsJellyfinUsersGet$Response$Item &&
            (identical(other.username, username) ||
                const DeepCollectionEquality().equals(
                  other.username,
                  username,
                )) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.thumb, thumb) ||
                const DeepCollectionEquality().equals(other.thumb, thumb)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(thumb) ^
      const DeepCollectionEquality().hash(email) ^
      runtimeType.hashCode;
}

extension $SettingsJellyfinUsersGet$Response$ItemExtension
    on SettingsJellyfinUsersGet$Response$Item {
  SettingsJellyfinUsersGet$Response$Item copyWith({
    String? username,
    String? id,
    String? thumb,
    String? email,
  }) {
    return SettingsJellyfinUsersGet$Response$Item(
      username: username ?? this.username,
      id: id ?? this.id,
      thumb: thumb ?? this.thumb,
      email: email ?? this.email,
    );
  }

  SettingsJellyfinUsersGet$Response$Item copyWithWrapped({
    Wrapped<String?>? username,
    Wrapped<String?>? id,
    Wrapped<String?>? thumb,
    Wrapped<String?>? email,
  }) {
    return SettingsJellyfinUsersGet$Response$Item(
      username: (username != null ? username.value : this.username),
      id: (id != null ? id.value : this.id),
      thumb: (thumb != null ? thumb.value : this.thumb),
      email: (email != null ? email.value : this.email),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SettingsJellyfinSyncGet$Response {
  const SettingsJellyfinSyncGet$Response({
    this.running,
    this.progress,
    this.total,
    this.currentLibrary,
    this.libraries,
  });

  factory SettingsJellyfinSyncGet$Response.fromJson(
    Map<String, dynamic> json,
  ) => _$SettingsJellyfinSyncGet$ResponseFromJson(json);

  static const toJsonFactory = _$SettingsJellyfinSyncGet$ResponseToJson;
  Map<String, dynamic> toJson() =>
      _$SettingsJellyfinSyncGet$ResponseToJson(this);

  @JsonKey(name: 'running', includeIfNull: false)
  final bool? running;
  @JsonKey(name: 'progress', includeIfNull: false)
  final double? progress;
  @JsonKey(name: 'total', includeIfNull: false)
  final double? total;
  @JsonKey(name: 'currentLibrary', includeIfNull: false)
  final JellyfinLibrary? currentLibrary;
  @JsonKey(
    name: 'libraries',
    includeIfNull: false,
    defaultValue: <JellyfinLibrary>[],
  )
  final List<JellyfinLibrary>? libraries;
  static const fromJsonFactory = _$SettingsJellyfinSyncGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SettingsJellyfinSyncGet$Response &&
            (identical(other.running, running) ||
                const DeepCollectionEquality().equals(
                  other.running,
                  running,
                )) &&
            (identical(other.progress, progress) ||
                const DeepCollectionEquality().equals(
                  other.progress,
                  progress,
                )) &&
            (identical(other.total, total) ||
                const DeepCollectionEquality().equals(other.total, total)) &&
            (identical(other.currentLibrary, currentLibrary) ||
                const DeepCollectionEquality().equals(
                  other.currentLibrary,
                  currentLibrary,
                )) &&
            (identical(other.libraries, libraries) ||
                const DeepCollectionEquality().equals(
                  other.libraries,
                  libraries,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(running) ^
      const DeepCollectionEquality().hash(progress) ^
      const DeepCollectionEquality().hash(total) ^
      const DeepCollectionEquality().hash(currentLibrary) ^
      const DeepCollectionEquality().hash(libraries) ^
      runtimeType.hashCode;
}

extension $SettingsJellyfinSyncGet$ResponseExtension
    on SettingsJellyfinSyncGet$Response {
  SettingsJellyfinSyncGet$Response copyWith({
    bool? running,
    double? progress,
    double? total,
    JellyfinLibrary? currentLibrary,
    List<JellyfinLibrary>? libraries,
  }) {
    return SettingsJellyfinSyncGet$Response(
      running: running ?? this.running,
      progress: progress ?? this.progress,
      total: total ?? this.total,
      currentLibrary: currentLibrary ?? this.currentLibrary,
      libraries: libraries ?? this.libraries,
    );
  }

  SettingsJellyfinSyncGet$Response copyWithWrapped({
    Wrapped<bool?>? running,
    Wrapped<double?>? progress,
    Wrapped<double?>? total,
    Wrapped<JellyfinLibrary?>? currentLibrary,
    Wrapped<List<JellyfinLibrary>?>? libraries,
  }) {
    return SettingsJellyfinSyncGet$Response(
      running: (running != null ? running.value : this.running),
      progress: (progress != null ? progress.value : this.progress),
      total: (total != null ? total.value : this.total),
      currentLibrary: (currentLibrary != null
          ? currentLibrary.value
          : this.currentLibrary),
      libraries: (libraries != null ? libraries.value : this.libraries),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SettingsJellyfinSyncPost$Response {
  const SettingsJellyfinSyncPost$Response({
    this.running,
    this.progress,
    this.total,
    this.currentLibrary,
    this.libraries,
  });

  factory SettingsJellyfinSyncPost$Response.fromJson(
    Map<String, dynamic> json,
  ) => _$SettingsJellyfinSyncPost$ResponseFromJson(json);

  static const toJsonFactory = _$SettingsJellyfinSyncPost$ResponseToJson;
  Map<String, dynamic> toJson() =>
      _$SettingsJellyfinSyncPost$ResponseToJson(this);

  @JsonKey(name: 'running', includeIfNull: false)
  final bool? running;
  @JsonKey(name: 'progress', includeIfNull: false)
  final double? progress;
  @JsonKey(name: 'total', includeIfNull: false)
  final double? total;
  @JsonKey(name: 'currentLibrary', includeIfNull: false)
  final JellyfinLibrary? currentLibrary;
  @JsonKey(
    name: 'libraries',
    includeIfNull: false,
    defaultValue: <JellyfinLibrary>[],
  )
  final List<JellyfinLibrary>? libraries;
  static const fromJsonFactory = _$SettingsJellyfinSyncPost$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SettingsJellyfinSyncPost$Response &&
            (identical(other.running, running) ||
                const DeepCollectionEquality().equals(
                  other.running,
                  running,
                )) &&
            (identical(other.progress, progress) ||
                const DeepCollectionEquality().equals(
                  other.progress,
                  progress,
                )) &&
            (identical(other.total, total) ||
                const DeepCollectionEquality().equals(other.total, total)) &&
            (identical(other.currentLibrary, currentLibrary) ||
                const DeepCollectionEquality().equals(
                  other.currentLibrary,
                  currentLibrary,
                )) &&
            (identical(other.libraries, libraries) ||
                const DeepCollectionEquality().equals(
                  other.libraries,
                  libraries,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(running) ^
      const DeepCollectionEquality().hash(progress) ^
      const DeepCollectionEquality().hash(total) ^
      const DeepCollectionEquality().hash(currentLibrary) ^
      const DeepCollectionEquality().hash(libraries) ^
      runtimeType.hashCode;
}

extension $SettingsJellyfinSyncPost$ResponseExtension
    on SettingsJellyfinSyncPost$Response {
  SettingsJellyfinSyncPost$Response copyWith({
    bool? running,
    double? progress,
    double? total,
    JellyfinLibrary? currentLibrary,
    List<JellyfinLibrary>? libraries,
  }) {
    return SettingsJellyfinSyncPost$Response(
      running: running ?? this.running,
      progress: progress ?? this.progress,
      total: total ?? this.total,
      currentLibrary: currentLibrary ?? this.currentLibrary,
      libraries: libraries ?? this.libraries,
    );
  }

  SettingsJellyfinSyncPost$Response copyWithWrapped({
    Wrapped<bool?>? running,
    Wrapped<double?>? progress,
    Wrapped<double?>? total,
    Wrapped<JellyfinLibrary?>? currentLibrary,
    Wrapped<List<JellyfinLibrary>?>? libraries,
  }) {
    return SettingsJellyfinSyncPost$Response(
      running: (running != null ? running.value : this.running),
      progress: (progress != null ? progress.value : this.progress),
      total: (total != null ? total.value : this.total),
      currentLibrary: (currentLibrary != null
          ? currentLibrary.value
          : this.currentLibrary),
      libraries: (libraries != null ? libraries.value : this.libraries),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SettingsPlexSyncGet$Response {
  const SettingsPlexSyncGet$Response({
    this.running,
    this.progress,
    this.total,
    this.currentLibrary,
    this.libraries,
  });

  factory SettingsPlexSyncGet$Response.fromJson(Map<String, dynamic> json) =>
      _$SettingsPlexSyncGet$ResponseFromJson(json);

  static const toJsonFactory = _$SettingsPlexSyncGet$ResponseToJson;
  Map<String, dynamic> toJson() => _$SettingsPlexSyncGet$ResponseToJson(this);

  @JsonKey(name: 'running', includeIfNull: false)
  final bool? running;
  @JsonKey(name: 'progress', includeIfNull: false)
  final double? progress;
  @JsonKey(name: 'total', includeIfNull: false)
  final double? total;
  @JsonKey(name: 'currentLibrary', includeIfNull: false)
  final PlexLibrary? currentLibrary;
  @JsonKey(
    name: 'libraries',
    includeIfNull: false,
    defaultValue: <PlexLibrary>[],
  )
  final List<PlexLibrary>? libraries;
  static const fromJsonFactory = _$SettingsPlexSyncGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SettingsPlexSyncGet$Response &&
            (identical(other.running, running) ||
                const DeepCollectionEquality().equals(
                  other.running,
                  running,
                )) &&
            (identical(other.progress, progress) ||
                const DeepCollectionEquality().equals(
                  other.progress,
                  progress,
                )) &&
            (identical(other.total, total) ||
                const DeepCollectionEquality().equals(other.total, total)) &&
            (identical(other.currentLibrary, currentLibrary) ||
                const DeepCollectionEquality().equals(
                  other.currentLibrary,
                  currentLibrary,
                )) &&
            (identical(other.libraries, libraries) ||
                const DeepCollectionEquality().equals(
                  other.libraries,
                  libraries,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(running) ^
      const DeepCollectionEquality().hash(progress) ^
      const DeepCollectionEquality().hash(total) ^
      const DeepCollectionEquality().hash(currentLibrary) ^
      const DeepCollectionEquality().hash(libraries) ^
      runtimeType.hashCode;
}

extension $SettingsPlexSyncGet$ResponseExtension
    on SettingsPlexSyncGet$Response {
  SettingsPlexSyncGet$Response copyWith({
    bool? running,
    double? progress,
    double? total,
    PlexLibrary? currentLibrary,
    List<PlexLibrary>? libraries,
  }) {
    return SettingsPlexSyncGet$Response(
      running: running ?? this.running,
      progress: progress ?? this.progress,
      total: total ?? this.total,
      currentLibrary: currentLibrary ?? this.currentLibrary,
      libraries: libraries ?? this.libraries,
    );
  }

  SettingsPlexSyncGet$Response copyWithWrapped({
    Wrapped<bool?>? running,
    Wrapped<double?>? progress,
    Wrapped<double?>? total,
    Wrapped<PlexLibrary?>? currentLibrary,
    Wrapped<List<PlexLibrary>?>? libraries,
  }) {
    return SettingsPlexSyncGet$Response(
      running: (running != null ? running.value : this.running),
      progress: (progress != null ? progress.value : this.progress),
      total: (total != null ? total.value : this.total),
      currentLibrary: (currentLibrary != null
          ? currentLibrary.value
          : this.currentLibrary),
      libraries: (libraries != null ? libraries.value : this.libraries),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SettingsPlexSyncPost$Response {
  const SettingsPlexSyncPost$Response({
    this.running,
    this.progress,
    this.total,
    this.currentLibrary,
    this.libraries,
  });

  factory SettingsPlexSyncPost$Response.fromJson(Map<String, dynamic> json) =>
      _$SettingsPlexSyncPost$ResponseFromJson(json);

  static const toJsonFactory = _$SettingsPlexSyncPost$ResponseToJson;
  Map<String, dynamic> toJson() => _$SettingsPlexSyncPost$ResponseToJson(this);

  @JsonKey(name: 'running', includeIfNull: false)
  final bool? running;
  @JsonKey(name: 'progress', includeIfNull: false)
  final double? progress;
  @JsonKey(name: 'total', includeIfNull: false)
  final double? total;
  @JsonKey(name: 'currentLibrary', includeIfNull: false)
  final PlexLibrary? currentLibrary;
  @JsonKey(
    name: 'libraries',
    includeIfNull: false,
    defaultValue: <PlexLibrary>[],
  )
  final List<PlexLibrary>? libraries;
  static const fromJsonFactory = _$SettingsPlexSyncPost$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SettingsPlexSyncPost$Response &&
            (identical(other.running, running) ||
                const DeepCollectionEquality().equals(
                  other.running,
                  running,
                )) &&
            (identical(other.progress, progress) ||
                const DeepCollectionEquality().equals(
                  other.progress,
                  progress,
                )) &&
            (identical(other.total, total) ||
                const DeepCollectionEquality().equals(other.total, total)) &&
            (identical(other.currentLibrary, currentLibrary) ||
                const DeepCollectionEquality().equals(
                  other.currentLibrary,
                  currentLibrary,
                )) &&
            (identical(other.libraries, libraries) ||
                const DeepCollectionEquality().equals(
                  other.libraries,
                  libraries,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(running) ^
      const DeepCollectionEquality().hash(progress) ^
      const DeepCollectionEquality().hash(total) ^
      const DeepCollectionEquality().hash(currentLibrary) ^
      const DeepCollectionEquality().hash(libraries) ^
      runtimeType.hashCode;
}

extension $SettingsPlexSyncPost$ResponseExtension
    on SettingsPlexSyncPost$Response {
  SettingsPlexSyncPost$Response copyWith({
    bool? running,
    double? progress,
    double? total,
    PlexLibrary? currentLibrary,
    List<PlexLibrary>? libraries,
  }) {
    return SettingsPlexSyncPost$Response(
      running: running ?? this.running,
      progress: progress ?? this.progress,
      total: total ?? this.total,
      currentLibrary: currentLibrary ?? this.currentLibrary,
      libraries: libraries ?? this.libraries,
    );
  }

  SettingsPlexSyncPost$Response copyWithWrapped({
    Wrapped<bool?>? running,
    Wrapped<double?>? progress,
    Wrapped<double?>? total,
    Wrapped<PlexLibrary?>? currentLibrary,
    Wrapped<List<PlexLibrary>?>? libraries,
  }) {
    return SettingsPlexSyncPost$Response(
      running: (running != null ? running.value : this.running),
      progress: (progress != null ? progress.value : this.progress),
      total: (total != null ? total.value : this.total),
      currentLibrary: (currentLibrary != null
          ? currentLibrary.value
          : this.currentLibrary),
      libraries: (libraries != null ? libraries.value : this.libraries),
    );
  }
}

typedef SettingsPlexUsersGet$Response =
    List<SettingsPlexUsersGet$Response$Item>;

@JsonSerializable(explicitToJson: true)
class SettingsPlexUsersGet$Response$Item {
  const SettingsPlexUsersGet$Response$Item({
    this.id,
    this.title,
    this.username,
    this.email,
    this.thumb,
  });

  factory SettingsPlexUsersGet$Response$Item.fromJson(
    Map<String, dynamic> json,
  ) => _$SettingsPlexUsersGet$Response$ItemFromJson(json);

  static const toJsonFactory = _$SettingsPlexUsersGet$Response$ItemToJson;
  Map<String, dynamic> toJson() =>
      _$SettingsPlexUsersGet$Response$ItemToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final String? id;
  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;
  @JsonKey(name: 'username', includeIfNull: false)
  final String? username;
  @JsonKey(name: 'email', includeIfNull: false)
  final String? email;
  @JsonKey(name: 'thumb', includeIfNull: false)
  final String? thumb;
  static const fromJsonFactory = _$SettingsPlexUsersGet$Response$ItemFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SettingsPlexUsersGet$Response$Item &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.username, username) ||
                const DeepCollectionEquality().equals(
                  other.username,
                  username,
                )) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.thumb, thumb) ||
                const DeepCollectionEquality().equals(other.thumb, thumb)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(thumb) ^
      runtimeType.hashCode;
}

extension $SettingsPlexUsersGet$Response$ItemExtension
    on SettingsPlexUsersGet$Response$Item {
  SettingsPlexUsersGet$Response$Item copyWith({
    String? id,
    String? title,
    String? username,
    String? email,
    String? thumb,
  }) {
    return SettingsPlexUsersGet$Response$Item(
      id: id ?? this.id,
      title: title ?? this.title,
      username: username ?? this.username,
      email: email ?? this.email,
      thumb: thumb ?? this.thumb,
    );
  }

  SettingsPlexUsersGet$Response$Item copyWithWrapped({
    Wrapped<String?>? id,
    Wrapped<String?>? title,
    Wrapped<String?>? username,
    Wrapped<String?>? email,
    Wrapped<String?>? thumb,
  }) {
    return SettingsPlexUsersGet$Response$Item(
      id: (id != null ? id.value : this.id),
      title: (title != null ? title.value : this.title),
      username: (username != null ? username.value : this.username),
      email: (email != null ? email.value : this.email),
      thumb: (thumb != null ? thumb.value : this.thumb),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SettingsMetadatasTestPost$Response {
  const SettingsMetadatasTestPost$Response({this.message});

  factory SettingsMetadatasTestPost$Response.fromJson(
    Map<String, dynamic> json,
  ) => _$SettingsMetadatasTestPost$ResponseFromJson(json);

  static const toJsonFactory = _$SettingsMetadatasTestPost$ResponseToJson;
  Map<String, dynamic> toJson() =>
      _$SettingsMetadatasTestPost$ResponseToJson(this);

  @JsonKey(name: 'message', includeIfNull: false)
  final String? message;
  static const fromJsonFactory = _$SettingsMetadatasTestPost$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SettingsMetadatasTestPost$Response &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(message) ^ runtimeType.hashCode;
}

extension $SettingsMetadatasTestPost$ResponseExtension
    on SettingsMetadatasTestPost$Response {
  SettingsMetadatasTestPost$Response copyWith({String? message}) {
    return SettingsMetadatasTestPost$Response(message: message ?? this.message);
  }

  SettingsMetadatasTestPost$Response copyWithWrapped({
    Wrapped<String?>? message,
  }) {
    return SettingsMetadatasTestPost$Response(
      message: (message != null ? message.value : this.message),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SettingsRadarrTestPost$Response {
  const SettingsRadarrTestPost$Response({this.profiles});

  factory SettingsRadarrTestPost$Response.fromJson(Map<String, dynamic> json) =>
      _$SettingsRadarrTestPost$ResponseFromJson(json);

  static const toJsonFactory = _$SettingsRadarrTestPost$ResponseToJson;
  Map<String, dynamic> toJson() =>
      _$SettingsRadarrTestPost$ResponseToJson(this);

  @JsonKey(
    name: 'profiles',
    includeIfNull: false,
    defaultValue: <ServiceProfile>[],
  )
  final List<ServiceProfile>? profiles;
  static const fromJsonFactory = _$SettingsRadarrTestPost$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SettingsRadarrTestPost$Response &&
            (identical(other.profiles, profiles) ||
                const DeepCollectionEquality().equals(
                  other.profiles,
                  profiles,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(profiles) ^ runtimeType.hashCode;
}

extension $SettingsRadarrTestPost$ResponseExtension
    on SettingsRadarrTestPost$Response {
  SettingsRadarrTestPost$Response copyWith({List<ServiceProfile>? profiles}) {
    return SettingsRadarrTestPost$Response(profiles: profiles ?? this.profiles);
  }

  SettingsRadarrTestPost$Response copyWithWrapped({
    Wrapped<List<ServiceProfile>?>? profiles,
  }) {
    return SettingsRadarrTestPost$Response(
      profiles: (profiles != null ? profiles.value : this.profiles),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SettingsSonarrTestPost$Response {
  const SettingsSonarrTestPost$Response({this.profiles});

  factory SettingsSonarrTestPost$Response.fromJson(Map<String, dynamic> json) =>
      _$SettingsSonarrTestPost$ResponseFromJson(json);

  static const toJsonFactory = _$SettingsSonarrTestPost$ResponseToJson;
  Map<String, dynamic> toJson() =>
      _$SettingsSonarrTestPost$ResponseToJson(this);

  @JsonKey(
    name: 'profiles',
    includeIfNull: false,
    defaultValue: <ServiceProfile>[],
  )
  final List<ServiceProfile>? profiles;
  static const fromJsonFactory = _$SettingsSonarrTestPost$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SettingsSonarrTestPost$Response &&
            (identical(other.profiles, profiles) ||
                const DeepCollectionEquality().equals(
                  other.profiles,
                  profiles,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(profiles) ^ runtimeType.hashCode;
}

extension $SettingsSonarrTestPost$ResponseExtension
    on SettingsSonarrTestPost$Response {
  SettingsSonarrTestPost$Response copyWith({List<ServiceProfile>? profiles}) {
    return SettingsSonarrTestPost$Response(profiles: profiles ?? this.profiles);
  }

  SettingsSonarrTestPost$Response copyWithWrapped({
    Wrapped<List<ServiceProfile>?>? profiles,
  }) {
    return SettingsSonarrTestPost$Response(
      profiles: (profiles != null ? profiles.value : this.profiles),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SettingsCacheGet$Response {
  const SettingsCacheGet$Response({
    this.imageCache,
    this.dnsCache,
    this.apiCaches,
  });

  factory SettingsCacheGet$Response.fromJson(Map<String, dynamic> json) =>
      _$SettingsCacheGet$ResponseFromJson(json);

  static const toJsonFactory = _$SettingsCacheGet$ResponseToJson;
  Map<String, dynamic> toJson() => _$SettingsCacheGet$ResponseToJson(this);

  @JsonKey(name: 'imageCache', includeIfNull: false)
  final SettingsCacheGet$Response$ImageCache? imageCache;
  @JsonKey(name: 'dnsCache', includeIfNull: false)
  final SettingsCacheGet$Response$DnsCache? dnsCache;
  @JsonKey(name: 'apiCaches', includeIfNull: false)
  final List<SettingsCacheGet$Response$ApiCaches$Item>? apiCaches;
  static const fromJsonFactory = _$SettingsCacheGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SettingsCacheGet$Response &&
            (identical(other.imageCache, imageCache) ||
                const DeepCollectionEquality().equals(
                  other.imageCache,
                  imageCache,
                )) &&
            (identical(other.dnsCache, dnsCache) ||
                const DeepCollectionEquality().equals(
                  other.dnsCache,
                  dnsCache,
                )) &&
            (identical(other.apiCaches, apiCaches) ||
                const DeepCollectionEquality().equals(
                  other.apiCaches,
                  apiCaches,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(imageCache) ^
      const DeepCollectionEquality().hash(dnsCache) ^
      const DeepCollectionEquality().hash(apiCaches) ^
      runtimeType.hashCode;
}

extension $SettingsCacheGet$ResponseExtension on SettingsCacheGet$Response {
  SettingsCacheGet$Response copyWith({
    SettingsCacheGet$Response$ImageCache? imageCache,
    SettingsCacheGet$Response$DnsCache? dnsCache,
    List<SettingsCacheGet$Response$ApiCaches$Item>? apiCaches,
  }) {
    return SettingsCacheGet$Response(
      imageCache: imageCache ?? this.imageCache,
      dnsCache: dnsCache ?? this.dnsCache,
      apiCaches: apiCaches ?? this.apiCaches,
    );
  }

  SettingsCacheGet$Response copyWithWrapped({
    Wrapped<SettingsCacheGet$Response$ImageCache?>? imageCache,
    Wrapped<SettingsCacheGet$Response$DnsCache?>? dnsCache,
    Wrapped<List<SettingsCacheGet$Response$ApiCaches$Item>?>? apiCaches,
  }) {
    return SettingsCacheGet$Response(
      imageCache: (imageCache != null ? imageCache.value : this.imageCache),
      dnsCache: (dnsCache != null ? dnsCache.value : this.dnsCache),
      apiCaches: (apiCaches != null ? apiCaches.value : this.apiCaches),
    );
  }
}

typedef SettingsLogsGet$Response = List<SettingsLogsGet$Response$Item>;

@JsonSerializable(explicitToJson: true)
class SettingsLogsGet$Response$Item {
  const SettingsLogsGet$Response$Item({
    this.label,
    this.level,
    this.message,
    this.timestamp,
  });

  factory SettingsLogsGet$Response$Item.fromJson(Map<String, dynamic> json) =>
      _$SettingsLogsGet$Response$ItemFromJson(json);

  static const toJsonFactory = _$SettingsLogsGet$Response$ItemToJson;
  Map<String, dynamic> toJson() => _$SettingsLogsGet$Response$ItemToJson(this);

  @JsonKey(name: 'label', includeIfNull: false)
  final String? label;
  @JsonKey(name: 'level', includeIfNull: false)
  final String? level;
  @JsonKey(name: 'message', includeIfNull: false)
  final String? message;
  @JsonKey(name: 'timestamp', includeIfNull: false)
  final String? timestamp;
  static const fromJsonFactory = _$SettingsLogsGet$Response$ItemFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SettingsLogsGet$Response$Item &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.level, level) ||
                const DeepCollectionEquality().equals(other.level, level)) &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(
                  other.message,
                  message,
                )) &&
            (identical(other.timestamp, timestamp) ||
                const DeepCollectionEquality().equals(
                  other.timestamp,
                  timestamp,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash(level) ^
      const DeepCollectionEquality().hash(message) ^
      const DeepCollectionEquality().hash(timestamp) ^
      runtimeType.hashCode;
}

extension $SettingsLogsGet$Response$ItemExtension
    on SettingsLogsGet$Response$Item {
  SettingsLogsGet$Response$Item copyWith({
    String? label,
    String? level,
    String? message,
    String? timestamp,
  }) {
    return SettingsLogsGet$Response$Item(
      label: label ?? this.label,
      level: level ?? this.level,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  SettingsLogsGet$Response$Item copyWithWrapped({
    Wrapped<String?>? label,
    Wrapped<String?>? level,
    Wrapped<String?>? message,
    Wrapped<String?>? timestamp,
  }) {
    return SettingsLogsGet$Response$Item(
      label: (label != null ? label.value : this.label),
      level: (level != null ? level.value : this.level),
      message: (message != null ? message.value : this.message),
      timestamp: (timestamp != null ? timestamp.value : this.timestamp),
    );
  }
}

typedef SettingsNotificationsPushoverSoundsGet$Response =
    List<SettingsNotificationsPushoverSoundsGet$Response$Item>;

@JsonSerializable(explicitToJson: true)
class SettingsNotificationsPushoverSoundsGet$Response$Item {
  const SettingsNotificationsPushoverSoundsGet$Response$Item({
    this.name,
    this.description,
  });

  factory SettingsNotificationsPushoverSoundsGet$Response$Item.fromJson(
    Map<String, dynamic> json,
  ) => _$SettingsNotificationsPushoverSoundsGet$Response$ItemFromJson(json);

  static const toJsonFactory =
      _$SettingsNotificationsPushoverSoundsGet$Response$ItemToJson;
  Map<String, dynamic> toJson() =>
      _$SettingsNotificationsPushoverSoundsGet$Response$ItemToJson(this);

  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  static const fromJsonFactory =
      _$SettingsNotificationsPushoverSoundsGet$Response$ItemFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SettingsNotificationsPushoverSoundsGet$Response$Item &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      runtimeType.hashCode;
}

extension $SettingsNotificationsPushoverSoundsGet$Response$ItemExtension
    on SettingsNotificationsPushoverSoundsGet$Response$Item {
  SettingsNotificationsPushoverSoundsGet$Response$Item copyWith({
    String? name,
    String? description,
  }) {
    return SettingsNotificationsPushoverSoundsGet$Response$Item(
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  SettingsNotificationsPushoverSoundsGet$Response$Item copyWithWrapped({
    Wrapped<String?>? name,
    Wrapped<String?>? description,
  }) {
    return SettingsNotificationsPushoverSoundsGet$Response$Item(
      name: (name != null ? name.value : this.name),
      description: (description != null ? description.value : this.description),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SettingsAboutGet$Response {
  const SettingsAboutGet$Response({
    this.version,
    this.totalRequests,
    this.totalMediaItems,
    this.tz,
    this.appDataPath,
  });

  factory SettingsAboutGet$Response.fromJson(Map<String, dynamic> json) =>
      _$SettingsAboutGet$ResponseFromJson(json);

  static const toJsonFactory = _$SettingsAboutGet$ResponseToJson;
  Map<String, dynamic> toJson() => _$SettingsAboutGet$ResponseToJson(this);

  @JsonKey(name: 'version', includeIfNull: false)
  final String? version;
  @JsonKey(name: 'totalRequests', includeIfNull: false)
  final double? totalRequests;
  @JsonKey(name: 'totalMediaItems', includeIfNull: false)
  final double? totalMediaItems;
  @JsonKey(name: 'tz', includeIfNull: false)
  final String? tz;
  @JsonKey(name: 'appDataPath', includeIfNull: false)
  final String? appDataPath;
  static const fromJsonFactory = _$SettingsAboutGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SettingsAboutGet$Response &&
            (identical(other.version, version) ||
                const DeepCollectionEquality().equals(
                  other.version,
                  version,
                )) &&
            (identical(other.totalRequests, totalRequests) ||
                const DeepCollectionEquality().equals(
                  other.totalRequests,
                  totalRequests,
                )) &&
            (identical(other.totalMediaItems, totalMediaItems) ||
                const DeepCollectionEquality().equals(
                  other.totalMediaItems,
                  totalMediaItems,
                )) &&
            (identical(other.tz, tz) ||
                const DeepCollectionEquality().equals(other.tz, tz)) &&
            (identical(other.appDataPath, appDataPath) ||
                const DeepCollectionEquality().equals(
                  other.appDataPath,
                  appDataPath,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(version) ^
      const DeepCollectionEquality().hash(totalRequests) ^
      const DeepCollectionEquality().hash(totalMediaItems) ^
      const DeepCollectionEquality().hash(tz) ^
      const DeepCollectionEquality().hash(appDataPath) ^
      runtimeType.hashCode;
}

extension $SettingsAboutGet$ResponseExtension on SettingsAboutGet$Response {
  SettingsAboutGet$Response copyWith({
    String? version,
    double? totalRequests,
    double? totalMediaItems,
    String? tz,
    String? appDataPath,
  }) {
    return SettingsAboutGet$Response(
      version: version ?? this.version,
      totalRequests: totalRequests ?? this.totalRequests,
      totalMediaItems: totalMediaItems ?? this.totalMediaItems,
      tz: tz ?? this.tz,
      appDataPath: appDataPath ?? this.appDataPath,
    );
  }

  SettingsAboutGet$Response copyWithWrapped({
    Wrapped<String?>? version,
    Wrapped<double?>? totalRequests,
    Wrapped<double?>? totalMediaItems,
    Wrapped<String?>? tz,
    Wrapped<String?>? appDataPath,
  }) {
    return SettingsAboutGet$Response(
      version: (version != null ? version.value : this.version),
      totalRequests: (totalRequests != null
          ? totalRequests.value
          : this.totalRequests),
      totalMediaItems: (totalMediaItems != null
          ? totalMediaItems.value
          : this.totalMediaItems),
      tz: (tz != null ? tz.value : this.tz),
      appDataPath: (appDataPath != null ? appDataPath.value : this.appDataPath),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AuthLogoutPost$Response {
  const AuthLogoutPost$Response({this.status});

  factory AuthLogoutPost$Response.fromJson(Map<String, dynamic> json) =>
      _$AuthLogoutPost$ResponseFromJson(json);

  static const toJsonFactory = _$AuthLogoutPost$ResponseToJson;
  Map<String, dynamic> toJson() => _$AuthLogoutPost$ResponseToJson(this);

  @JsonKey(name: 'status', includeIfNull: false)
  final String? status;
  static const fromJsonFactory = _$AuthLogoutPost$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AuthLogoutPost$Response &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(status) ^ runtimeType.hashCode;
}

extension $AuthLogoutPost$ResponseExtension on AuthLogoutPost$Response {
  AuthLogoutPost$Response copyWith({String? status}) {
    return AuthLogoutPost$Response(status: status ?? this.status);
  }

  AuthLogoutPost$Response copyWithWrapped({Wrapped<String?>? status}) {
    return AuthLogoutPost$Response(
      status: (status != null ? status.value : this.status),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AuthResetPasswordPost$Response {
  const AuthResetPasswordPost$Response({this.status});

  factory AuthResetPasswordPost$Response.fromJson(Map<String, dynamic> json) =>
      _$AuthResetPasswordPost$ResponseFromJson(json);

  static const toJsonFactory = _$AuthResetPasswordPost$ResponseToJson;
  Map<String, dynamic> toJson() => _$AuthResetPasswordPost$ResponseToJson(this);

  @JsonKey(name: 'status', includeIfNull: false)
  final String? status;
  static const fromJsonFactory = _$AuthResetPasswordPost$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AuthResetPasswordPost$Response &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(status) ^ runtimeType.hashCode;
}

extension $AuthResetPasswordPost$ResponseExtension
    on AuthResetPasswordPost$Response {
  AuthResetPasswordPost$Response copyWith({String? status}) {
    return AuthResetPasswordPost$Response(status: status ?? this.status);
  }

  AuthResetPasswordPost$Response copyWithWrapped({Wrapped<String?>? status}) {
    return AuthResetPasswordPost$Response(
      status: (status != null ? status.value : this.status),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AuthResetPasswordGuidPost$Response {
  const AuthResetPasswordGuidPost$Response({this.status});

  factory AuthResetPasswordGuidPost$Response.fromJson(
    Map<String, dynamic> json,
  ) => _$AuthResetPasswordGuidPost$ResponseFromJson(json);

  static const toJsonFactory = _$AuthResetPasswordGuidPost$ResponseToJson;
  Map<String, dynamic> toJson() =>
      _$AuthResetPasswordGuidPost$ResponseToJson(this);

  @JsonKey(name: 'status', includeIfNull: false)
  final String? status;
  static const fromJsonFactory = _$AuthResetPasswordGuidPost$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AuthResetPasswordGuidPost$Response &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(status) ^ runtimeType.hashCode;
}

extension $AuthResetPasswordGuidPost$ResponseExtension
    on AuthResetPasswordGuidPost$Response {
  AuthResetPasswordGuidPost$Response copyWith({String? status}) {
    return AuthResetPasswordGuidPost$Response(status: status ?? this.status);
  }

  AuthResetPasswordGuidPost$Response copyWithWrapped({
    Wrapped<String?>? status,
  }) {
    return AuthResetPasswordGuidPost$Response(
      status: (status != null ? status.value : this.status),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserGet$Response {
  const UserGet$Response({this.pageInfo, this.results});

  factory UserGet$Response.fromJson(Map<String, dynamic> json) =>
      _$UserGet$ResponseFromJson(json);

  static const toJsonFactory = _$UserGet$ResponseToJson;
  Map<String, dynamic> toJson() => _$UserGet$ResponseToJson(this);

  @JsonKey(name: 'pageInfo', includeIfNull: false)
  final PageInfo? pageInfo;
  @JsonKey(name: 'results', includeIfNull: false, defaultValue: <User>[])
  final List<User>? results;
  static const fromJsonFactory = _$UserGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserGet$Response &&
            (identical(other.pageInfo, pageInfo) ||
                const DeepCollectionEquality().equals(
                  other.pageInfo,
                  pageInfo,
                )) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(pageInfo) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $UserGet$ResponseExtension on UserGet$Response {
  UserGet$Response copyWith({PageInfo? pageInfo, List<User>? results}) {
    return UserGet$Response(
      pageInfo: pageInfo ?? this.pageInfo,
      results: results ?? this.results,
    );
  }

  UserGet$Response copyWithWrapped({
    Wrapped<PageInfo?>? pageInfo,
    Wrapped<List<User>?>? results,
  }) {
    return UserGet$Response(
      pageInfo: (pageInfo != null ? pageInfo.value : this.pageInfo),
      results: (results != null ? results.value : this.results),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserUserIdPushSubscriptionsGet$Response {
  const UserUserIdPushSubscriptionsGet$Response({
    this.endpoint,
    this.p256dh,
    this.auth,
    this.userAgent,
  });

  factory UserUserIdPushSubscriptionsGet$Response.fromJson(
    Map<String, dynamic> json,
  ) => _$UserUserIdPushSubscriptionsGet$ResponseFromJson(json);

  static const toJsonFactory = _$UserUserIdPushSubscriptionsGet$ResponseToJson;
  Map<String, dynamic> toJson() =>
      _$UserUserIdPushSubscriptionsGet$ResponseToJson(this);

  @JsonKey(name: 'endpoint', includeIfNull: false)
  final String? endpoint;
  @JsonKey(name: 'p256dh', includeIfNull: false)
  final String? p256dh;
  @JsonKey(name: 'auth', includeIfNull: false)
  final String? auth;
  @JsonKey(name: 'userAgent', includeIfNull: false)
  final String? userAgent;
  static const fromJsonFactory =
      _$UserUserIdPushSubscriptionsGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserUserIdPushSubscriptionsGet$Response &&
            (identical(other.endpoint, endpoint) ||
                const DeepCollectionEquality().equals(
                  other.endpoint,
                  endpoint,
                )) &&
            (identical(other.p256dh, p256dh) ||
                const DeepCollectionEquality().equals(other.p256dh, p256dh)) &&
            (identical(other.auth, auth) ||
                const DeepCollectionEquality().equals(other.auth, auth)) &&
            (identical(other.userAgent, userAgent) ||
                const DeepCollectionEquality().equals(
                  other.userAgent,
                  userAgent,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(endpoint) ^
      const DeepCollectionEquality().hash(p256dh) ^
      const DeepCollectionEquality().hash(auth) ^
      const DeepCollectionEquality().hash(userAgent) ^
      runtimeType.hashCode;
}

extension $UserUserIdPushSubscriptionsGet$ResponseExtension
    on UserUserIdPushSubscriptionsGet$Response {
  UserUserIdPushSubscriptionsGet$Response copyWith({
    String? endpoint,
    String? p256dh,
    String? auth,
    String? userAgent,
  }) {
    return UserUserIdPushSubscriptionsGet$Response(
      endpoint: endpoint ?? this.endpoint,
      p256dh: p256dh ?? this.p256dh,
      auth: auth ?? this.auth,
      userAgent: userAgent ?? this.userAgent,
    );
  }

  UserUserIdPushSubscriptionsGet$Response copyWithWrapped({
    Wrapped<String?>? endpoint,
    Wrapped<String?>? p256dh,
    Wrapped<String?>? auth,
    Wrapped<String?>? userAgent,
  }) {
    return UserUserIdPushSubscriptionsGet$Response(
      endpoint: (endpoint != null ? endpoint.value : this.endpoint),
      p256dh: (p256dh != null ? p256dh.value : this.p256dh),
      auth: (auth != null ? auth.value : this.auth),
      userAgent: (userAgent != null ? userAgent.value : this.userAgent),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserUserIdPushSubscriptionEndpointGet$Response {
  const UserUserIdPushSubscriptionEndpointGet$Response({
    this.endpoint,
    this.p256dh,
    this.auth,
    this.userAgent,
  });

  factory UserUserIdPushSubscriptionEndpointGet$Response.fromJson(
    Map<String, dynamic> json,
  ) => _$UserUserIdPushSubscriptionEndpointGet$ResponseFromJson(json);

  static const toJsonFactory =
      _$UserUserIdPushSubscriptionEndpointGet$ResponseToJson;
  Map<String, dynamic> toJson() =>
      _$UserUserIdPushSubscriptionEndpointGet$ResponseToJson(this);

  @JsonKey(name: 'endpoint', includeIfNull: false)
  final String? endpoint;
  @JsonKey(name: 'p256dh', includeIfNull: false)
  final String? p256dh;
  @JsonKey(name: 'auth', includeIfNull: false)
  final String? auth;
  @JsonKey(name: 'userAgent', includeIfNull: false)
  final String? userAgent;
  static const fromJsonFactory =
      _$UserUserIdPushSubscriptionEndpointGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserUserIdPushSubscriptionEndpointGet$Response &&
            (identical(other.endpoint, endpoint) ||
                const DeepCollectionEquality().equals(
                  other.endpoint,
                  endpoint,
                )) &&
            (identical(other.p256dh, p256dh) ||
                const DeepCollectionEquality().equals(other.p256dh, p256dh)) &&
            (identical(other.auth, auth) ||
                const DeepCollectionEquality().equals(other.auth, auth)) &&
            (identical(other.userAgent, userAgent) ||
                const DeepCollectionEquality().equals(
                  other.userAgent,
                  userAgent,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(endpoint) ^
      const DeepCollectionEquality().hash(p256dh) ^
      const DeepCollectionEquality().hash(auth) ^
      const DeepCollectionEquality().hash(userAgent) ^
      runtimeType.hashCode;
}

extension $UserUserIdPushSubscriptionEndpointGet$ResponseExtension
    on UserUserIdPushSubscriptionEndpointGet$Response {
  UserUserIdPushSubscriptionEndpointGet$Response copyWith({
    String? endpoint,
    String? p256dh,
    String? auth,
    String? userAgent,
  }) {
    return UserUserIdPushSubscriptionEndpointGet$Response(
      endpoint: endpoint ?? this.endpoint,
      p256dh: p256dh ?? this.p256dh,
      auth: auth ?? this.auth,
      userAgent: userAgent ?? this.userAgent,
    );
  }

  UserUserIdPushSubscriptionEndpointGet$Response copyWithWrapped({
    Wrapped<String?>? endpoint,
    Wrapped<String?>? p256dh,
    Wrapped<String?>? auth,
    Wrapped<String?>? userAgent,
  }) {
    return UserUserIdPushSubscriptionEndpointGet$Response(
      endpoint: (endpoint != null ? endpoint.value : this.endpoint),
      p256dh: (p256dh != null ? p256dh.value : this.p256dh),
      auth: (auth != null ? auth.value : this.auth),
      userAgent: (userAgent != null ? userAgent.value : this.userAgent),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserUserIdRequestsGet$Response {
  const UserUserIdRequestsGet$Response({this.pageInfo, this.results});

  factory UserUserIdRequestsGet$Response.fromJson(Map<String, dynamic> json) =>
      _$UserUserIdRequestsGet$ResponseFromJson(json);

  static const toJsonFactory = _$UserUserIdRequestsGet$ResponseToJson;
  Map<String, dynamic> toJson() => _$UserUserIdRequestsGet$ResponseToJson(this);

  @JsonKey(name: 'pageInfo', includeIfNull: false)
  final PageInfo? pageInfo;
  @JsonKey(
    name: 'results',
    includeIfNull: false,
    defaultValue: <MediaRequest>[],
  )
  final List<MediaRequest>? results;
  static const fromJsonFactory = _$UserUserIdRequestsGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserUserIdRequestsGet$Response &&
            (identical(other.pageInfo, pageInfo) ||
                const DeepCollectionEquality().equals(
                  other.pageInfo,
                  pageInfo,
                )) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(pageInfo) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $UserUserIdRequestsGet$ResponseExtension
    on UserUserIdRequestsGet$Response {
  UserUserIdRequestsGet$Response copyWith({
    PageInfo? pageInfo,
    List<MediaRequest>? results,
  }) {
    return UserUserIdRequestsGet$Response(
      pageInfo: pageInfo ?? this.pageInfo,
      results: results ?? this.results,
    );
  }

  UserUserIdRequestsGet$Response copyWithWrapped({
    Wrapped<PageInfo?>? pageInfo,
    Wrapped<List<MediaRequest>?>? results,
  }) {
    return UserUserIdRequestsGet$Response(
      pageInfo: (pageInfo != null ? pageInfo.value : this.pageInfo),
      results: (results != null ? results.value : this.results),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserUserIdQuotaGet$Response {
  const UserUserIdQuotaGet$Response({this.movie, this.tv});

  factory UserUserIdQuotaGet$Response.fromJson(Map<String, dynamic> json) =>
      _$UserUserIdQuotaGet$ResponseFromJson(json);

  static const toJsonFactory = _$UserUserIdQuotaGet$ResponseToJson;
  Map<String, dynamic> toJson() => _$UserUserIdQuotaGet$ResponseToJson(this);

  @JsonKey(name: 'movie', includeIfNull: false)
  final UserUserIdQuotaGet$Response$Movie? movie;
  @JsonKey(name: 'tv', includeIfNull: false)
  final UserUserIdQuotaGet$Response$Tv? tv;
  static const fromJsonFactory = _$UserUserIdQuotaGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserUserIdQuotaGet$Response &&
            (identical(other.movie, movie) ||
                const DeepCollectionEquality().equals(other.movie, movie)) &&
            (identical(other.tv, tv) ||
                const DeepCollectionEquality().equals(other.tv, tv)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(movie) ^
      const DeepCollectionEquality().hash(tv) ^
      runtimeType.hashCode;
}

extension $UserUserIdQuotaGet$ResponseExtension on UserUserIdQuotaGet$Response {
  UserUserIdQuotaGet$Response copyWith({
    UserUserIdQuotaGet$Response$Movie? movie,
    UserUserIdQuotaGet$Response$Tv? tv,
  }) {
    return UserUserIdQuotaGet$Response(
      movie: movie ?? this.movie,
      tv: tv ?? this.tv,
    );
  }

  UserUserIdQuotaGet$Response copyWithWrapped({
    Wrapped<UserUserIdQuotaGet$Response$Movie?>? movie,
    Wrapped<UserUserIdQuotaGet$Response$Tv?>? tv,
  }) {
    return UserUserIdQuotaGet$Response(
      movie: (movie != null ? movie.value : this.movie),
      tv: (tv != null ? tv.value : this.tv),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class BlacklistGet$Response {
  const BlacklistGet$Response({this.pageInfo, this.results});

  factory BlacklistGet$Response.fromJson(Map<String, dynamic> json) =>
      _$BlacklistGet$ResponseFromJson(json);

  static const toJsonFactory = _$BlacklistGet$ResponseToJson;
  Map<String, dynamic> toJson() => _$BlacklistGet$ResponseToJson(this);

  @JsonKey(name: 'pageInfo', includeIfNull: false)
  final PageInfo? pageInfo;
  @JsonKey(name: 'results', includeIfNull: false)
  final List<BlacklistGet$Response$Results$Item>? results;
  static const fromJsonFactory = _$BlacklistGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is BlacklistGet$Response &&
            (identical(other.pageInfo, pageInfo) ||
                const DeepCollectionEquality().equals(
                  other.pageInfo,
                  pageInfo,
                )) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(pageInfo) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $BlacklistGet$ResponseExtension on BlacklistGet$Response {
  BlacklistGet$Response copyWith({
    PageInfo? pageInfo,
    List<BlacklistGet$Response$Results$Item>? results,
  }) {
    return BlacklistGet$Response(
      pageInfo: pageInfo ?? this.pageInfo,
      results: results ?? this.results,
    );
  }

  BlacklistGet$Response copyWithWrapped({
    Wrapped<PageInfo?>? pageInfo,
    Wrapped<List<BlacklistGet$Response$Results$Item>?>? results,
  }) {
    return BlacklistGet$Response(
      pageInfo: (pageInfo != null ? pageInfo.value : this.pageInfo),
      results: (results != null ? results.value : this.results),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserUserIdWatchlistGet$Response {
  const UserUserIdWatchlistGet$Response({
    this.page,
    this.totalPages,
    this.totalResults,
    this.results,
  });

  factory UserUserIdWatchlistGet$Response.fromJson(Map<String, dynamic> json) =>
      _$UserUserIdWatchlistGet$ResponseFromJson(json);

  static const toJsonFactory = _$UserUserIdWatchlistGet$ResponseToJson;
  Map<String, dynamic> toJson() =>
      _$UserUserIdWatchlistGet$ResponseToJson(this);

  @JsonKey(name: 'page', includeIfNull: false)
  final double? page;
  @JsonKey(name: 'totalPages', includeIfNull: false)
  final double? totalPages;
  @JsonKey(name: 'totalResults', includeIfNull: false)
  final double? totalResults;
  @JsonKey(name: 'results', includeIfNull: false)
  final List<UserUserIdWatchlistGet$Response$Results$Item>? results;
  static const fromJsonFactory = _$UserUserIdWatchlistGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserUserIdWatchlistGet$Response &&
            (identical(other.page, page) ||
                const DeepCollectionEquality().equals(other.page, page)) &&
            (identical(other.totalPages, totalPages) ||
                const DeepCollectionEquality().equals(
                  other.totalPages,
                  totalPages,
                )) &&
            (identical(other.totalResults, totalResults) ||
                const DeepCollectionEquality().equals(
                  other.totalResults,
                  totalResults,
                )) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(page) ^
      const DeepCollectionEquality().hash(totalPages) ^
      const DeepCollectionEquality().hash(totalResults) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $UserUserIdWatchlistGet$ResponseExtension
    on UserUserIdWatchlistGet$Response {
  UserUserIdWatchlistGet$Response copyWith({
    double? page,
    double? totalPages,
    double? totalResults,
    List<UserUserIdWatchlistGet$Response$Results$Item>? results,
  }) {
    return UserUserIdWatchlistGet$Response(
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
      results: results ?? this.results,
    );
  }

  UserUserIdWatchlistGet$Response copyWithWrapped({
    Wrapped<double?>? page,
    Wrapped<double?>? totalPages,
    Wrapped<double?>? totalResults,
    Wrapped<List<UserUserIdWatchlistGet$Response$Results$Item>?>? results,
  }) {
    return UserUserIdWatchlistGet$Response(
      page: (page != null ? page.value : this.page),
      totalPages: (totalPages != null ? totalPages.value : this.totalPages),
      totalResults: (totalResults != null
          ? totalResults.value
          : this.totalResults),
      results: (results != null ? results.value : this.results),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserUserIdSettingsPasswordGet$Response {
  const UserUserIdSettingsPasswordGet$Response({this.hasPassword});

  factory UserUserIdSettingsPasswordGet$Response.fromJson(
    Map<String, dynamic> json,
  ) => _$UserUserIdSettingsPasswordGet$ResponseFromJson(json);

  static const toJsonFactory = _$UserUserIdSettingsPasswordGet$ResponseToJson;
  Map<String, dynamic> toJson() =>
      _$UserUserIdSettingsPasswordGet$ResponseToJson(this);

  @JsonKey(name: 'hasPassword', includeIfNull: false)
  final bool? hasPassword;
  static const fromJsonFactory =
      _$UserUserIdSettingsPasswordGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserUserIdSettingsPasswordGet$Response &&
            (identical(other.hasPassword, hasPassword) ||
                const DeepCollectionEquality().equals(
                  other.hasPassword,
                  hasPassword,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(hasPassword) ^ runtimeType.hashCode;
}

extension $UserUserIdSettingsPasswordGet$ResponseExtension
    on UserUserIdSettingsPasswordGet$Response {
  UserUserIdSettingsPasswordGet$Response copyWith({bool? hasPassword}) {
    return UserUserIdSettingsPasswordGet$Response(
      hasPassword: hasPassword ?? this.hasPassword,
    );
  }

  UserUserIdSettingsPasswordGet$Response copyWithWrapped({
    Wrapped<bool?>? hasPassword,
  }) {
    return UserUserIdSettingsPasswordGet$Response(
      hasPassword: (hasPassword != null ? hasPassword.value : this.hasPassword),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserUserIdSettingsPermissionsGet$Response {
  const UserUserIdSettingsPermissionsGet$Response({this.permissions});

  factory UserUserIdSettingsPermissionsGet$Response.fromJson(
    Map<String, dynamic> json,
  ) => _$UserUserIdSettingsPermissionsGet$ResponseFromJson(json);

  static const toJsonFactory =
      _$UserUserIdSettingsPermissionsGet$ResponseToJson;
  Map<String, dynamic> toJson() =>
      _$UserUserIdSettingsPermissionsGet$ResponseToJson(this);

  @JsonKey(name: 'permissions', includeIfNull: false)
  final double? permissions;
  static const fromJsonFactory =
      _$UserUserIdSettingsPermissionsGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserUserIdSettingsPermissionsGet$Response &&
            (identical(other.permissions, permissions) ||
                const DeepCollectionEquality().equals(
                  other.permissions,
                  permissions,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(permissions) ^ runtimeType.hashCode;
}

extension $UserUserIdSettingsPermissionsGet$ResponseExtension
    on UserUserIdSettingsPermissionsGet$Response {
  UserUserIdSettingsPermissionsGet$Response copyWith({double? permissions}) {
    return UserUserIdSettingsPermissionsGet$Response(
      permissions: permissions ?? this.permissions,
    );
  }

  UserUserIdSettingsPermissionsGet$Response copyWithWrapped({
    Wrapped<double?>? permissions,
  }) {
    return UserUserIdSettingsPermissionsGet$Response(
      permissions: (permissions != null ? permissions.value : this.permissions),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserUserIdSettingsPermissionsPost$Response {
  const UserUserIdSettingsPermissionsPost$Response({this.permissions});

  factory UserUserIdSettingsPermissionsPost$Response.fromJson(
    Map<String, dynamic> json,
  ) => _$UserUserIdSettingsPermissionsPost$ResponseFromJson(json);

  static const toJsonFactory =
      _$UserUserIdSettingsPermissionsPost$ResponseToJson;
  Map<String, dynamic> toJson() =>
      _$UserUserIdSettingsPermissionsPost$ResponseToJson(this);

  @JsonKey(name: 'permissions', includeIfNull: false)
  final double? permissions;
  static const fromJsonFactory =
      _$UserUserIdSettingsPermissionsPost$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserUserIdSettingsPermissionsPost$Response &&
            (identical(other.permissions, permissions) ||
                const DeepCollectionEquality().equals(
                  other.permissions,
                  permissions,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(permissions) ^ runtimeType.hashCode;
}

extension $UserUserIdSettingsPermissionsPost$ResponseExtension
    on UserUserIdSettingsPermissionsPost$Response {
  UserUserIdSettingsPermissionsPost$Response copyWith({double? permissions}) {
    return UserUserIdSettingsPermissionsPost$Response(
      permissions: permissions ?? this.permissions,
    );
  }

  UserUserIdSettingsPermissionsPost$Response copyWithWrapped({
    Wrapped<double?>? permissions,
  }) {
    return UserUserIdSettingsPermissionsPost$Response(
      permissions: (permissions != null ? permissions.value : this.permissions),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserUserIdWatchDataGet$Response {
  const UserUserIdWatchDataGet$Response({this.recentlyWatched, this.playCount});

  factory UserUserIdWatchDataGet$Response.fromJson(Map<String, dynamic> json) =>
      _$UserUserIdWatchDataGet$ResponseFromJson(json);

  static const toJsonFactory = _$UserUserIdWatchDataGet$ResponseToJson;
  Map<String, dynamic> toJson() =>
      _$UserUserIdWatchDataGet$ResponseToJson(this);

  @JsonKey(
    name: 'recentlyWatched',
    includeIfNull: false,
    defaultValue: <MediaInfo>[],
  )
  final List<MediaInfo>? recentlyWatched;
  @JsonKey(name: 'playCount', includeIfNull: false)
  final double? playCount;
  static const fromJsonFactory = _$UserUserIdWatchDataGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserUserIdWatchDataGet$Response &&
            (identical(other.recentlyWatched, recentlyWatched) ||
                const DeepCollectionEquality().equals(
                  other.recentlyWatched,
                  recentlyWatched,
                )) &&
            (identical(other.playCount, playCount) ||
                const DeepCollectionEquality().equals(
                  other.playCount,
                  playCount,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(recentlyWatched) ^
      const DeepCollectionEquality().hash(playCount) ^
      runtimeType.hashCode;
}

extension $UserUserIdWatchDataGet$ResponseExtension
    on UserUserIdWatchDataGet$Response {
  UserUserIdWatchDataGet$Response copyWith({
    List<MediaInfo>? recentlyWatched,
    double? playCount,
  }) {
    return UserUserIdWatchDataGet$Response(
      recentlyWatched: recentlyWatched ?? this.recentlyWatched,
      playCount: playCount ?? this.playCount,
    );
  }

  UserUserIdWatchDataGet$Response copyWithWrapped({
    Wrapped<List<MediaInfo>?>? recentlyWatched,
    Wrapped<double?>? playCount,
  }) {
    return UserUserIdWatchDataGet$Response(
      recentlyWatched: (recentlyWatched != null
          ? recentlyWatched.value
          : this.recentlyWatched),
      playCount: (playCount != null ? playCount.value : this.playCount),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SearchGet$Response {
  const SearchGet$Response({
    this.page,
    this.totalPages,
    this.totalResults,
    this.results,
  });

  factory SearchGet$Response.fromJson(Map<String, dynamic> json) =>
      _$SearchGet$ResponseFromJson(json);

  static const toJsonFactory = _$SearchGet$ResponseToJson;
  Map<String, dynamic> toJson() => _$SearchGet$ResponseToJson(this);

  @JsonKey(name: 'page', includeIfNull: false)
  final double? page;
  @JsonKey(name: 'totalPages', includeIfNull: false)
  final double? totalPages;
  @JsonKey(name: 'totalResults', includeIfNull: false)
  final double? totalResults;
  @JsonKey(name: 'results', includeIfNull: false, defaultValue: <Object>[])
  final List<Object>? results;
  static const fromJsonFactory = _$SearchGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SearchGet$Response &&
            (identical(other.page, page) ||
                const DeepCollectionEquality().equals(other.page, page)) &&
            (identical(other.totalPages, totalPages) ||
                const DeepCollectionEquality().equals(
                  other.totalPages,
                  totalPages,
                )) &&
            (identical(other.totalResults, totalResults) ||
                const DeepCollectionEquality().equals(
                  other.totalResults,
                  totalResults,
                )) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(page) ^
      const DeepCollectionEquality().hash(totalPages) ^
      const DeepCollectionEquality().hash(totalResults) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $SearchGet$ResponseExtension on SearchGet$Response {
  SearchGet$Response copyWith({
    double? page,
    double? totalPages,
    double? totalResults,
    List<Object>? results,
  }) {
    return SearchGet$Response(
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
      results: results ?? this.results,
    );
  }

  SearchGet$Response copyWithWrapped({
    Wrapped<double?>? page,
    Wrapped<double?>? totalPages,
    Wrapped<double?>? totalResults,
    Wrapped<List<Object>?>? results,
  }) {
    return SearchGet$Response(
      page: (page != null ? page.value : this.page),
      totalPages: (totalPages != null ? totalPages.value : this.totalPages),
      totalResults: (totalResults != null
          ? totalResults.value
          : this.totalResults),
      results: (results != null ? results.value : this.results),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SearchKeywordGet$Response {
  const SearchKeywordGet$Response({
    this.page,
    this.totalPages,
    this.totalResults,
    this.results,
  });

  factory SearchKeywordGet$Response.fromJson(Map<String, dynamic> json) =>
      _$SearchKeywordGet$ResponseFromJson(json);

  static const toJsonFactory = _$SearchKeywordGet$ResponseToJson;
  Map<String, dynamic> toJson() => _$SearchKeywordGet$ResponseToJson(this);

  @JsonKey(name: 'page', includeIfNull: false)
  final double? page;
  @JsonKey(name: 'totalPages', includeIfNull: false)
  final double? totalPages;
  @JsonKey(name: 'totalResults', includeIfNull: false)
  final double? totalResults;
  @JsonKey(name: 'results', includeIfNull: false, defaultValue: <Keyword>[])
  final List<Keyword>? results;
  static const fromJsonFactory = _$SearchKeywordGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SearchKeywordGet$Response &&
            (identical(other.page, page) ||
                const DeepCollectionEquality().equals(other.page, page)) &&
            (identical(other.totalPages, totalPages) ||
                const DeepCollectionEquality().equals(
                  other.totalPages,
                  totalPages,
                )) &&
            (identical(other.totalResults, totalResults) ||
                const DeepCollectionEquality().equals(
                  other.totalResults,
                  totalResults,
                )) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(page) ^
      const DeepCollectionEquality().hash(totalPages) ^
      const DeepCollectionEquality().hash(totalResults) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $SearchKeywordGet$ResponseExtension on SearchKeywordGet$Response {
  SearchKeywordGet$Response copyWith({
    double? page,
    double? totalPages,
    double? totalResults,
    List<Keyword>? results,
  }) {
    return SearchKeywordGet$Response(
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
      results: results ?? this.results,
    );
  }

  SearchKeywordGet$Response copyWithWrapped({
    Wrapped<double?>? page,
    Wrapped<double?>? totalPages,
    Wrapped<double?>? totalResults,
    Wrapped<List<Keyword>?>? results,
  }) {
    return SearchKeywordGet$Response(
      page: (page != null ? page.value : this.page),
      totalPages: (totalPages != null ? totalPages.value : this.totalPages),
      totalResults: (totalResults != null
          ? totalResults.value
          : this.totalResults),
      results: (results != null ? results.value : this.results),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SearchCompanyGet$Response {
  const SearchCompanyGet$Response({
    this.page,
    this.totalPages,
    this.totalResults,
    this.results,
  });

  factory SearchCompanyGet$Response.fromJson(Map<String, dynamic> json) =>
      _$SearchCompanyGet$ResponseFromJson(json);

  static const toJsonFactory = _$SearchCompanyGet$ResponseToJson;
  Map<String, dynamic> toJson() => _$SearchCompanyGet$ResponseToJson(this);

  @JsonKey(name: 'page', includeIfNull: false)
  final double? page;
  @JsonKey(name: 'totalPages', includeIfNull: false)
  final double? totalPages;
  @JsonKey(name: 'totalResults', includeIfNull: false)
  final double? totalResults;
  @JsonKey(name: 'results', includeIfNull: false, defaultValue: <Company>[])
  final List<Company>? results;
  static const fromJsonFactory = _$SearchCompanyGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SearchCompanyGet$Response &&
            (identical(other.page, page) ||
                const DeepCollectionEquality().equals(other.page, page)) &&
            (identical(other.totalPages, totalPages) ||
                const DeepCollectionEquality().equals(
                  other.totalPages,
                  totalPages,
                )) &&
            (identical(other.totalResults, totalResults) ||
                const DeepCollectionEquality().equals(
                  other.totalResults,
                  totalResults,
                )) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(page) ^
      const DeepCollectionEquality().hash(totalPages) ^
      const DeepCollectionEquality().hash(totalResults) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $SearchCompanyGet$ResponseExtension on SearchCompanyGet$Response {
  SearchCompanyGet$Response copyWith({
    double? page,
    double? totalPages,
    double? totalResults,
    List<Company>? results,
  }) {
    return SearchCompanyGet$Response(
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
      results: results ?? this.results,
    );
  }

  SearchCompanyGet$Response copyWithWrapped({
    Wrapped<double?>? page,
    Wrapped<double?>? totalPages,
    Wrapped<double?>? totalResults,
    Wrapped<List<Company>?>? results,
  }) {
    return SearchCompanyGet$Response(
      page: (page != null ? page.value : this.page),
      totalPages: (totalPages != null ? totalPages.value : this.totalPages),
      totalResults: (totalResults != null
          ? totalResults.value
          : this.totalResults),
      results: (results != null ? results.value : this.results),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class DiscoverMoviesGet$Response {
  const DiscoverMoviesGet$Response({
    this.page,
    this.totalPages,
    this.totalResults,
    this.results,
  });

  factory DiscoverMoviesGet$Response.fromJson(Map<String, dynamic> json) =>
      _$DiscoverMoviesGet$ResponseFromJson(json);

  static const toJsonFactory = _$DiscoverMoviesGet$ResponseToJson;
  Map<String, dynamic> toJson() => _$DiscoverMoviesGet$ResponseToJson(this);

  @JsonKey(name: 'page', includeIfNull: false)
  final double? page;
  @JsonKey(name: 'totalPages', includeIfNull: false)
  final double? totalPages;
  @JsonKey(name: 'totalResults', includeIfNull: false)
  final double? totalResults;
  @JsonKey(name: 'results', includeIfNull: false, defaultValue: <MovieResult>[])
  final List<MovieResult>? results;
  static const fromJsonFactory = _$DiscoverMoviesGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is DiscoverMoviesGet$Response &&
            (identical(other.page, page) ||
                const DeepCollectionEquality().equals(other.page, page)) &&
            (identical(other.totalPages, totalPages) ||
                const DeepCollectionEquality().equals(
                  other.totalPages,
                  totalPages,
                )) &&
            (identical(other.totalResults, totalResults) ||
                const DeepCollectionEquality().equals(
                  other.totalResults,
                  totalResults,
                )) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(page) ^
      const DeepCollectionEquality().hash(totalPages) ^
      const DeepCollectionEquality().hash(totalResults) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $DiscoverMoviesGet$ResponseExtension on DiscoverMoviesGet$Response {
  DiscoverMoviesGet$Response copyWith({
    double? page,
    double? totalPages,
    double? totalResults,
    List<MovieResult>? results,
  }) {
    return DiscoverMoviesGet$Response(
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
      results: results ?? this.results,
    );
  }

  DiscoverMoviesGet$Response copyWithWrapped({
    Wrapped<double?>? page,
    Wrapped<double?>? totalPages,
    Wrapped<double?>? totalResults,
    Wrapped<List<MovieResult>?>? results,
  }) {
    return DiscoverMoviesGet$Response(
      page: (page != null ? page.value : this.page),
      totalPages: (totalPages != null ? totalPages.value : this.totalPages),
      totalResults: (totalResults != null
          ? totalResults.value
          : this.totalResults),
      results: (results != null ? results.value : this.results),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class DiscoverMoviesGenreGenreIdGet$Response {
  const DiscoverMoviesGenreGenreIdGet$Response({
    this.page,
    this.totalPages,
    this.totalResults,
    this.genre,
    this.results,
  });

  factory DiscoverMoviesGenreGenreIdGet$Response.fromJson(
    Map<String, dynamic> json,
  ) => _$DiscoverMoviesGenreGenreIdGet$ResponseFromJson(json);

  static const toJsonFactory = _$DiscoverMoviesGenreGenreIdGet$ResponseToJson;
  Map<String, dynamic> toJson() =>
      _$DiscoverMoviesGenreGenreIdGet$ResponseToJson(this);

  @JsonKey(name: 'page', includeIfNull: false)
  final double? page;
  @JsonKey(name: 'totalPages', includeIfNull: false)
  final double? totalPages;
  @JsonKey(name: 'totalResults', includeIfNull: false)
  final double? totalResults;
  @JsonKey(name: 'genre', includeIfNull: false)
  final Genre? genre;
  @JsonKey(name: 'results', includeIfNull: false, defaultValue: <MovieResult>[])
  final List<MovieResult>? results;
  static const fromJsonFactory =
      _$DiscoverMoviesGenreGenreIdGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is DiscoverMoviesGenreGenreIdGet$Response &&
            (identical(other.page, page) ||
                const DeepCollectionEquality().equals(other.page, page)) &&
            (identical(other.totalPages, totalPages) ||
                const DeepCollectionEquality().equals(
                  other.totalPages,
                  totalPages,
                )) &&
            (identical(other.totalResults, totalResults) ||
                const DeepCollectionEquality().equals(
                  other.totalResults,
                  totalResults,
                )) &&
            (identical(other.genre, genre) ||
                const DeepCollectionEquality().equals(other.genre, genre)) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(page) ^
      const DeepCollectionEquality().hash(totalPages) ^
      const DeepCollectionEquality().hash(totalResults) ^
      const DeepCollectionEquality().hash(genre) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $DiscoverMoviesGenreGenreIdGet$ResponseExtension
    on DiscoverMoviesGenreGenreIdGet$Response {
  DiscoverMoviesGenreGenreIdGet$Response copyWith({
    double? page,
    double? totalPages,
    double? totalResults,
    Genre? genre,
    List<MovieResult>? results,
  }) {
    return DiscoverMoviesGenreGenreIdGet$Response(
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
      genre: genre ?? this.genre,
      results: results ?? this.results,
    );
  }

  DiscoverMoviesGenreGenreIdGet$Response copyWithWrapped({
    Wrapped<double?>? page,
    Wrapped<double?>? totalPages,
    Wrapped<double?>? totalResults,
    Wrapped<Genre?>? genre,
    Wrapped<List<MovieResult>?>? results,
  }) {
    return DiscoverMoviesGenreGenreIdGet$Response(
      page: (page != null ? page.value : this.page),
      totalPages: (totalPages != null ? totalPages.value : this.totalPages),
      totalResults: (totalResults != null
          ? totalResults.value
          : this.totalResults),
      genre: (genre != null ? genre.value : this.genre),
      results: (results != null ? results.value : this.results),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class DiscoverMoviesLanguageLanguageGet$Response {
  const DiscoverMoviesLanguageLanguageGet$Response({
    this.page,
    this.totalPages,
    this.totalResults,
    this.language,
    this.results,
  });

  factory DiscoverMoviesLanguageLanguageGet$Response.fromJson(
    Map<String, dynamic> json,
  ) => _$DiscoverMoviesLanguageLanguageGet$ResponseFromJson(json);

  static const toJsonFactory =
      _$DiscoverMoviesLanguageLanguageGet$ResponseToJson;
  Map<String, dynamic> toJson() =>
      _$DiscoverMoviesLanguageLanguageGet$ResponseToJson(this);

  @JsonKey(name: 'page', includeIfNull: false)
  final double? page;
  @JsonKey(name: 'totalPages', includeIfNull: false)
  final double? totalPages;
  @JsonKey(name: 'totalResults', includeIfNull: false)
  final double? totalResults;
  @JsonKey(name: 'language', includeIfNull: false)
  final SpokenLanguage? language;
  @JsonKey(name: 'results', includeIfNull: false, defaultValue: <MovieResult>[])
  final List<MovieResult>? results;
  static const fromJsonFactory =
      _$DiscoverMoviesLanguageLanguageGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is DiscoverMoviesLanguageLanguageGet$Response &&
            (identical(other.page, page) ||
                const DeepCollectionEquality().equals(other.page, page)) &&
            (identical(other.totalPages, totalPages) ||
                const DeepCollectionEquality().equals(
                  other.totalPages,
                  totalPages,
                )) &&
            (identical(other.totalResults, totalResults) ||
                const DeepCollectionEquality().equals(
                  other.totalResults,
                  totalResults,
                )) &&
            (identical(other.language, language) ||
                const DeepCollectionEquality().equals(
                  other.language,
                  language,
                )) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(page) ^
      const DeepCollectionEquality().hash(totalPages) ^
      const DeepCollectionEquality().hash(totalResults) ^
      const DeepCollectionEquality().hash(language) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $DiscoverMoviesLanguageLanguageGet$ResponseExtension
    on DiscoverMoviesLanguageLanguageGet$Response {
  DiscoverMoviesLanguageLanguageGet$Response copyWith({
    double? page,
    double? totalPages,
    double? totalResults,
    SpokenLanguage? language,
    List<MovieResult>? results,
  }) {
    return DiscoverMoviesLanguageLanguageGet$Response(
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
      language: language ?? this.language,
      results: results ?? this.results,
    );
  }

  DiscoverMoviesLanguageLanguageGet$Response copyWithWrapped({
    Wrapped<double?>? page,
    Wrapped<double?>? totalPages,
    Wrapped<double?>? totalResults,
    Wrapped<SpokenLanguage?>? language,
    Wrapped<List<MovieResult>?>? results,
  }) {
    return DiscoverMoviesLanguageLanguageGet$Response(
      page: (page != null ? page.value : this.page),
      totalPages: (totalPages != null ? totalPages.value : this.totalPages),
      totalResults: (totalResults != null
          ? totalResults.value
          : this.totalResults),
      language: (language != null ? language.value : this.language),
      results: (results != null ? results.value : this.results),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class DiscoverMoviesStudioStudioIdGet$Response {
  const DiscoverMoviesStudioStudioIdGet$Response({
    this.page,
    this.totalPages,
    this.totalResults,
    this.studio,
    this.results,
  });

  factory DiscoverMoviesStudioStudioIdGet$Response.fromJson(
    Map<String, dynamic> json,
  ) => _$DiscoverMoviesStudioStudioIdGet$ResponseFromJson(json);

  static const toJsonFactory = _$DiscoverMoviesStudioStudioIdGet$ResponseToJson;
  Map<String, dynamic> toJson() =>
      _$DiscoverMoviesStudioStudioIdGet$ResponseToJson(this);

  @JsonKey(name: 'page', includeIfNull: false)
  final double? page;
  @JsonKey(name: 'totalPages', includeIfNull: false)
  final double? totalPages;
  @JsonKey(name: 'totalResults', includeIfNull: false)
  final double? totalResults;
  @JsonKey(name: 'studio', includeIfNull: false)
  final ProductionCompany? studio;
  @JsonKey(name: 'results', includeIfNull: false, defaultValue: <MovieResult>[])
  final List<MovieResult>? results;
  static const fromJsonFactory =
      _$DiscoverMoviesStudioStudioIdGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is DiscoverMoviesStudioStudioIdGet$Response &&
            (identical(other.page, page) ||
                const DeepCollectionEquality().equals(other.page, page)) &&
            (identical(other.totalPages, totalPages) ||
                const DeepCollectionEquality().equals(
                  other.totalPages,
                  totalPages,
                )) &&
            (identical(other.totalResults, totalResults) ||
                const DeepCollectionEquality().equals(
                  other.totalResults,
                  totalResults,
                )) &&
            (identical(other.studio, studio) ||
                const DeepCollectionEquality().equals(other.studio, studio)) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(page) ^
      const DeepCollectionEquality().hash(totalPages) ^
      const DeepCollectionEquality().hash(totalResults) ^
      const DeepCollectionEquality().hash(studio) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $DiscoverMoviesStudioStudioIdGet$ResponseExtension
    on DiscoverMoviesStudioStudioIdGet$Response {
  DiscoverMoviesStudioStudioIdGet$Response copyWith({
    double? page,
    double? totalPages,
    double? totalResults,
    ProductionCompany? studio,
    List<MovieResult>? results,
  }) {
    return DiscoverMoviesStudioStudioIdGet$Response(
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
      studio: studio ?? this.studio,
      results: results ?? this.results,
    );
  }

  DiscoverMoviesStudioStudioIdGet$Response copyWithWrapped({
    Wrapped<double?>? page,
    Wrapped<double?>? totalPages,
    Wrapped<double?>? totalResults,
    Wrapped<ProductionCompany?>? studio,
    Wrapped<List<MovieResult>?>? results,
  }) {
    return DiscoverMoviesStudioStudioIdGet$Response(
      page: (page != null ? page.value : this.page),
      totalPages: (totalPages != null ? totalPages.value : this.totalPages),
      totalResults: (totalResults != null
          ? totalResults.value
          : this.totalResults),
      studio: (studio != null ? studio.value : this.studio),
      results: (results != null ? results.value : this.results),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class DiscoverMoviesUpcomingGet$Response {
  const DiscoverMoviesUpcomingGet$Response({
    this.page,
    this.totalPages,
    this.totalResults,
    this.results,
  });

  factory DiscoverMoviesUpcomingGet$Response.fromJson(
    Map<String, dynamic> json,
  ) => _$DiscoverMoviesUpcomingGet$ResponseFromJson(json);

  static const toJsonFactory = _$DiscoverMoviesUpcomingGet$ResponseToJson;
  Map<String, dynamic> toJson() =>
      _$DiscoverMoviesUpcomingGet$ResponseToJson(this);

  @JsonKey(name: 'page', includeIfNull: false)
  final double? page;
  @JsonKey(name: 'totalPages', includeIfNull: false)
  final double? totalPages;
  @JsonKey(name: 'totalResults', includeIfNull: false)
  final double? totalResults;
  @JsonKey(name: 'results', includeIfNull: false, defaultValue: <MovieResult>[])
  final List<MovieResult>? results;
  static const fromJsonFactory = _$DiscoverMoviesUpcomingGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is DiscoverMoviesUpcomingGet$Response &&
            (identical(other.page, page) ||
                const DeepCollectionEquality().equals(other.page, page)) &&
            (identical(other.totalPages, totalPages) ||
                const DeepCollectionEquality().equals(
                  other.totalPages,
                  totalPages,
                )) &&
            (identical(other.totalResults, totalResults) ||
                const DeepCollectionEquality().equals(
                  other.totalResults,
                  totalResults,
                )) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(page) ^
      const DeepCollectionEquality().hash(totalPages) ^
      const DeepCollectionEquality().hash(totalResults) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $DiscoverMoviesUpcomingGet$ResponseExtension
    on DiscoverMoviesUpcomingGet$Response {
  DiscoverMoviesUpcomingGet$Response copyWith({
    double? page,
    double? totalPages,
    double? totalResults,
    List<MovieResult>? results,
  }) {
    return DiscoverMoviesUpcomingGet$Response(
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
      results: results ?? this.results,
    );
  }

  DiscoverMoviesUpcomingGet$Response copyWithWrapped({
    Wrapped<double?>? page,
    Wrapped<double?>? totalPages,
    Wrapped<double?>? totalResults,
    Wrapped<List<MovieResult>?>? results,
  }) {
    return DiscoverMoviesUpcomingGet$Response(
      page: (page != null ? page.value : this.page),
      totalPages: (totalPages != null ? totalPages.value : this.totalPages),
      totalResults: (totalResults != null
          ? totalResults.value
          : this.totalResults),
      results: (results != null ? results.value : this.results),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class DiscoverTvGet$Response {
  const DiscoverTvGet$Response({
    this.page,
    this.totalPages,
    this.totalResults,
    this.results,
  });

  factory DiscoverTvGet$Response.fromJson(Map<String, dynamic> json) =>
      _$DiscoverTvGet$ResponseFromJson(json);

  static const toJsonFactory = _$DiscoverTvGet$ResponseToJson;
  Map<String, dynamic> toJson() => _$DiscoverTvGet$ResponseToJson(this);

  @JsonKey(name: 'page', includeIfNull: false)
  final double? page;
  @JsonKey(name: 'totalPages', includeIfNull: false)
  final double? totalPages;
  @JsonKey(name: 'totalResults', includeIfNull: false)
  final double? totalResults;
  @JsonKey(name: 'results', includeIfNull: false, defaultValue: <TvResult>[])
  final List<TvResult>? results;
  static const fromJsonFactory = _$DiscoverTvGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is DiscoverTvGet$Response &&
            (identical(other.page, page) ||
                const DeepCollectionEquality().equals(other.page, page)) &&
            (identical(other.totalPages, totalPages) ||
                const DeepCollectionEquality().equals(
                  other.totalPages,
                  totalPages,
                )) &&
            (identical(other.totalResults, totalResults) ||
                const DeepCollectionEquality().equals(
                  other.totalResults,
                  totalResults,
                )) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(page) ^
      const DeepCollectionEquality().hash(totalPages) ^
      const DeepCollectionEquality().hash(totalResults) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $DiscoverTvGet$ResponseExtension on DiscoverTvGet$Response {
  DiscoverTvGet$Response copyWith({
    double? page,
    double? totalPages,
    double? totalResults,
    List<TvResult>? results,
  }) {
    return DiscoverTvGet$Response(
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
      results: results ?? this.results,
    );
  }

  DiscoverTvGet$Response copyWithWrapped({
    Wrapped<double?>? page,
    Wrapped<double?>? totalPages,
    Wrapped<double?>? totalResults,
    Wrapped<List<TvResult>?>? results,
  }) {
    return DiscoverTvGet$Response(
      page: (page != null ? page.value : this.page),
      totalPages: (totalPages != null ? totalPages.value : this.totalPages),
      totalResults: (totalResults != null
          ? totalResults.value
          : this.totalResults),
      results: (results != null ? results.value : this.results),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class DiscoverTvLanguageLanguageGet$Response {
  const DiscoverTvLanguageLanguageGet$Response({
    this.page,
    this.totalPages,
    this.totalResults,
    this.language,
    this.results,
  });

  factory DiscoverTvLanguageLanguageGet$Response.fromJson(
    Map<String, dynamic> json,
  ) => _$DiscoverTvLanguageLanguageGet$ResponseFromJson(json);

  static const toJsonFactory = _$DiscoverTvLanguageLanguageGet$ResponseToJson;
  Map<String, dynamic> toJson() =>
      _$DiscoverTvLanguageLanguageGet$ResponseToJson(this);

  @JsonKey(name: 'page', includeIfNull: false)
  final double? page;
  @JsonKey(name: 'totalPages', includeIfNull: false)
  final double? totalPages;
  @JsonKey(name: 'totalResults', includeIfNull: false)
  final double? totalResults;
  @JsonKey(name: 'language', includeIfNull: false)
  final SpokenLanguage? language;
  @JsonKey(name: 'results', includeIfNull: false, defaultValue: <TvResult>[])
  final List<TvResult>? results;
  static const fromJsonFactory =
      _$DiscoverTvLanguageLanguageGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is DiscoverTvLanguageLanguageGet$Response &&
            (identical(other.page, page) ||
                const DeepCollectionEquality().equals(other.page, page)) &&
            (identical(other.totalPages, totalPages) ||
                const DeepCollectionEquality().equals(
                  other.totalPages,
                  totalPages,
                )) &&
            (identical(other.totalResults, totalResults) ||
                const DeepCollectionEquality().equals(
                  other.totalResults,
                  totalResults,
                )) &&
            (identical(other.language, language) ||
                const DeepCollectionEquality().equals(
                  other.language,
                  language,
                )) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(page) ^
      const DeepCollectionEquality().hash(totalPages) ^
      const DeepCollectionEquality().hash(totalResults) ^
      const DeepCollectionEquality().hash(language) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $DiscoverTvLanguageLanguageGet$ResponseExtension
    on DiscoverTvLanguageLanguageGet$Response {
  DiscoverTvLanguageLanguageGet$Response copyWith({
    double? page,
    double? totalPages,
    double? totalResults,
    SpokenLanguage? language,
    List<TvResult>? results,
  }) {
    return DiscoverTvLanguageLanguageGet$Response(
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
      language: language ?? this.language,
      results: results ?? this.results,
    );
  }

  DiscoverTvLanguageLanguageGet$Response copyWithWrapped({
    Wrapped<double?>? page,
    Wrapped<double?>? totalPages,
    Wrapped<double?>? totalResults,
    Wrapped<SpokenLanguage?>? language,
    Wrapped<List<TvResult>?>? results,
  }) {
    return DiscoverTvLanguageLanguageGet$Response(
      page: (page != null ? page.value : this.page),
      totalPages: (totalPages != null ? totalPages.value : this.totalPages),
      totalResults: (totalResults != null
          ? totalResults.value
          : this.totalResults),
      language: (language != null ? language.value : this.language),
      results: (results != null ? results.value : this.results),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class DiscoverTvGenreGenreIdGet$Response {
  const DiscoverTvGenreGenreIdGet$Response({
    this.page,
    this.totalPages,
    this.totalResults,
    this.genre,
    this.results,
  });

  factory DiscoverTvGenreGenreIdGet$Response.fromJson(
    Map<String, dynamic> json,
  ) => _$DiscoverTvGenreGenreIdGet$ResponseFromJson(json);

  static const toJsonFactory = _$DiscoverTvGenreGenreIdGet$ResponseToJson;
  Map<String, dynamic> toJson() =>
      _$DiscoverTvGenreGenreIdGet$ResponseToJson(this);

  @JsonKey(name: 'page', includeIfNull: false)
  final double? page;
  @JsonKey(name: 'totalPages', includeIfNull: false)
  final double? totalPages;
  @JsonKey(name: 'totalResults', includeIfNull: false)
  final double? totalResults;
  @JsonKey(name: 'genre', includeIfNull: false)
  final Genre? genre;
  @JsonKey(name: 'results', includeIfNull: false, defaultValue: <TvResult>[])
  final List<TvResult>? results;
  static const fromJsonFactory = _$DiscoverTvGenreGenreIdGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is DiscoverTvGenreGenreIdGet$Response &&
            (identical(other.page, page) ||
                const DeepCollectionEquality().equals(other.page, page)) &&
            (identical(other.totalPages, totalPages) ||
                const DeepCollectionEquality().equals(
                  other.totalPages,
                  totalPages,
                )) &&
            (identical(other.totalResults, totalResults) ||
                const DeepCollectionEquality().equals(
                  other.totalResults,
                  totalResults,
                )) &&
            (identical(other.genre, genre) ||
                const DeepCollectionEquality().equals(other.genre, genre)) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(page) ^
      const DeepCollectionEquality().hash(totalPages) ^
      const DeepCollectionEquality().hash(totalResults) ^
      const DeepCollectionEquality().hash(genre) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $DiscoverTvGenreGenreIdGet$ResponseExtension
    on DiscoverTvGenreGenreIdGet$Response {
  DiscoverTvGenreGenreIdGet$Response copyWith({
    double? page,
    double? totalPages,
    double? totalResults,
    Genre? genre,
    List<TvResult>? results,
  }) {
    return DiscoverTvGenreGenreIdGet$Response(
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
      genre: genre ?? this.genre,
      results: results ?? this.results,
    );
  }

  DiscoverTvGenreGenreIdGet$Response copyWithWrapped({
    Wrapped<double?>? page,
    Wrapped<double?>? totalPages,
    Wrapped<double?>? totalResults,
    Wrapped<Genre?>? genre,
    Wrapped<List<TvResult>?>? results,
  }) {
    return DiscoverTvGenreGenreIdGet$Response(
      page: (page != null ? page.value : this.page),
      totalPages: (totalPages != null ? totalPages.value : this.totalPages),
      totalResults: (totalResults != null
          ? totalResults.value
          : this.totalResults),
      genre: (genre != null ? genre.value : this.genre),
      results: (results != null ? results.value : this.results),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class DiscoverTvNetworkNetworkIdGet$Response {
  const DiscoverTvNetworkNetworkIdGet$Response({
    this.page,
    this.totalPages,
    this.totalResults,
    this.network,
    this.results,
  });

  factory DiscoverTvNetworkNetworkIdGet$Response.fromJson(
    Map<String, dynamic> json,
  ) => _$DiscoverTvNetworkNetworkIdGet$ResponseFromJson(json);

  static const toJsonFactory = _$DiscoverTvNetworkNetworkIdGet$ResponseToJson;
  Map<String, dynamic> toJson() =>
      _$DiscoverTvNetworkNetworkIdGet$ResponseToJson(this);

  @JsonKey(name: 'page', includeIfNull: false)
  final double? page;
  @JsonKey(name: 'totalPages', includeIfNull: false)
  final double? totalPages;
  @JsonKey(name: 'totalResults', includeIfNull: false)
  final double? totalResults;
  @JsonKey(name: 'network', includeIfNull: false)
  final Network? network;
  @JsonKey(name: 'results', includeIfNull: false, defaultValue: <TvResult>[])
  final List<TvResult>? results;
  static const fromJsonFactory =
      _$DiscoverTvNetworkNetworkIdGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is DiscoverTvNetworkNetworkIdGet$Response &&
            (identical(other.page, page) ||
                const DeepCollectionEquality().equals(other.page, page)) &&
            (identical(other.totalPages, totalPages) ||
                const DeepCollectionEquality().equals(
                  other.totalPages,
                  totalPages,
                )) &&
            (identical(other.totalResults, totalResults) ||
                const DeepCollectionEquality().equals(
                  other.totalResults,
                  totalResults,
                )) &&
            (identical(other.network, network) ||
                const DeepCollectionEquality().equals(
                  other.network,
                  network,
                )) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(page) ^
      const DeepCollectionEquality().hash(totalPages) ^
      const DeepCollectionEquality().hash(totalResults) ^
      const DeepCollectionEquality().hash(network) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $DiscoverTvNetworkNetworkIdGet$ResponseExtension
    on DiscoverTvNetworkNetworkIdGet$Response {
  DiscoverTvNetworkNetworkIdGet$Response copyWith({
    double? page,
    double? totalPages,
    double? totalResults,
    Network? network,
    List<TvResult>? results,
  }) {
    return DiscoverTvNetworkNetworkIdGet$Response(
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
      network: network ?? this.network,
      results: results ?? this.results,
    );
  }

  DiscoverTvNetworkNetworkIdGet$Response copyWithWrapped({
    Wrapped<double?>? page,
    Wrapped<double?>? totalPages,
    Wrapped<double?>? totalResults,
    Wrapped<Network?>? network,
    Wrapped<List<TvResult>?>? results,
  }) {
    return DiscoverTvNetworkNetworkIdGet$Response(
      page: (page != null ? page.value : this.page),
      totalPages: (totalPages != null ? totalPages.value : this.totalPages),
      totalResults: (totalResults != null
          ? totalResults.value
          : this.totalResults),
      network: (network != null ? network.value : this.network),
      results: (results != null ? results.value : this.results),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class DiscoverTvUpcomingGet$Response {
  const DiscoverTvUpcomingGet$Response({
    this.page,
    this.totalPages,
    this.totalResults,
    this.results,
  });

  factory DiscoverTvUpcomingGet$Response.fromJson(Map<String, dynamic> json) =>
      _$DiscoverTvUpcomingGet$ResponseFromJson(json);

  static const toJsonFactory = _$DiscoverTvUpcomingGet$ResponseToJson;
  Map<String, dynamic> toJson() => _$DiscoverTvUpcomingGet$ResponseToJson(this);

  @JsonKey(name: 'page', includeIfNull: false)
  final double? page;
  @JsonKey(name: 'totalPages', includeIfNull: false)
  final double? totalPages;
  @JsonKey(name: 'totalResults', includeIfNull: false)
  final double? totalResults;
  @JsonKey(name: 'results', includeIfNull: false, defaultValue: <TvResult>[])
  final List<TvResult>? results;
  static const fromJsonFactory = _$DiscoverTvUpcomingGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is DiscoverTvUpcomingGet$Response &&
            (identical(other.page, page) ||
                const DeepCollectionEquality().equals(other.page, page)) &&
            (identical(other.totalPages, totalPages) ||
                const DeepCollectionEquality().equals(
                  other.totalPages,
                  totalPages,
                )) &&
            (identical(other.totalResults, totalResults) ||
                const DeepCollectionEquality().equals(
                  other.totalResults,
                  totalResults,
                )) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(page) ^
      const DeepCollectionEquality().hash(totalPages) ^
      const DeepCollectionEquality().hash(totalResults) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $DiscoverTvUpcomingGet$ResponseExtension
    on DiscoverTvUpcomingGet$Response {
  DiscoverTvUpcomingGet$Response copyWith({
    double? page,
    double? totalPages,
    double? totalResults,
    List<TvResult>? results,
  }) {
    return DiscoverTvUpcomingGet$Response(
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
      results: results ?? this.results,
    );
  }

  DiscoverTvUpcomingGet$Response copyWithWrapped({
    Wrapped<double?>? page,
    Wrapped<double?>? totalPages,
    Wrapped<double?>? totalResults,
    Wrapped<List<TvResult>?>? results,
  }) {
    return DiscoverTvUpcomingGet$Response(
      page: (page != null ? page.value : this.page),
      totalPages: (totalPages != null ? totalPages.value : this.totalPages),
      totalResults: (totalResults != null
          ? totalResults.value
          : this.totalResults),
      results: (results != null ? results.value : this.results),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class DiscoverTrendingGet$Response {
  const DiscoverTrendingGet$Response({
    this.page,
    this.totalPages,
    this.totalResults,
    this.results,
  });

  factory DiscoverTrendingGet$Response.fromJson(Map<String, dynamic> json) =>
      _$DiscoverTrendingGet$ResponseFromJson(json);

  static const toJsonFactory = _$DiscoverTrendingGet$ResponseToJson;
  Map<String, dynamic> toJson() => _$DiscoverTrendingGet$ResponseToJson(this);

  @JsonKey(name: 'page', includeIfNull: false)
  final double? page;
  @JsonKey(name: 'totalPages', includeIfNull: false)
  final double? totalPages;
  @JsonKey(name: 'totalResults', includeIfNull: false)
  final double? totalResults;
  @JsonKey(name: 'results', includeIfNull: false, defaultValue: <Object>[])
  final List<Object>? results;
  static const fromJsonFactory = _$DiscoverTrendingGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is DiscoverTrendingGet$Response &&
            (identical(other.page, page) ||
                const DeepCollectionEquality().equals(other.page, page)) &&
            (identical(other.totalPages, totalPages) ||
                const DeepCollectionEquality().equals(
                  other.totalPages,
                  totalPages,
                )) &&
            (identical(other.totalResults, totalResults) ||
                const DeepCollectionEquality().equals(
                  other.totalResults,
                  totalResults,
                )) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(page) ^
      const DeepCollectionEquality().hash(totalPages) ^
      const DeepCollectionEquality().hash(totalResults) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $DiscoverTrendingGet$ResponseExtension
    on DiscoverTrendingGet$Response {
  DiscoverTrendingGet$Response copyWith({
    double? page,
    double? totalPages,
    double? totalResults,
    List<Object>? results,
  }) {
    return DiscoverTrendingGet$Response(
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
      results: results ?? this.results,
    );
  }

  DiscoverTrendingGet$Response copyWithWrapped({
    Wrapped<double?>? page,
    Wrapped<double?>? totalPages,
    Wrapped<double?>? totalResults,
    Wrapped<List<Object>?>? results,
  }) {
    return DiscoverTrendingGet$Response(
      page: (page != null ? page.value : this.page),
      totalPages: (totalPages != null ? totalPages.value : this.totalPages),
      totalResults: (totalResults != null
          ? totalResults.value
          : this.totalResults),
      results: (results != null ? results.value : this.results),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class DiscoverKeywordKeywordIdMoviesGet$Response {
  const DiscoverKeywordKeywordIdMoviesGet$Response({
    this.page,
    this.totalPages,
    this.totalResults,
    this.results,
  });

  factory DiscoverKeywordKeywordIdMoviesGet$Response.fromJson(
    Map<String, dynamic> json,
  ) => _$DiscoverKeywordKeywordIdMoviesGet$ResponseFromJson(json);

  static const toJsonFactory =
      _$DiscoverKeywordKeywordIdMoviesGet$ResponseToJson;
  Map<String, dynamic> toJson() =>
      _$DiscoverKeywordKeywordIdMoviesGet$ResponseToJson(this);

  @JsonKey(name: 'page', includeIfNull: false)
  final double? page;
  @JsonKey(name: 'totalPages', includeIfNull: false)
  final double? totalPages;
  @JsonKey(name: 'totalResults', includeIfNull: false)
  final double? totalResults;
  @JsonKey(name: 'results', includeIfNull: false, defaultValue: <MovieResult>[])
  final List<MovieResult>? results;
  static const fromJsonFactory =
      _$DiscoverKeywordKeywordIdMoviesGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is DiscoverKeywordKeywordIdMoviesGet$Response &&
            (identical(other.page, page) ||
                const DeepCollectionEquality().equals(other.page, page)) &&
            (identical(other.totalPages, totalPages) ||
                const DeepCollectionEquality().equals(
                  other.totalPages,
                  totalPages,
                )) &&
            (identical(other.totalResults, totalResults) ||
                const DeepCollectionEquality().equals(
                  other.totalResults,
                  totalResults,
                )) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(page) ^
      const DeepCollectionEquality().hash(totalPages) ^
      const DeepCollectionEquality().hash(totalResults) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $DiscoverKeywordKeywordIdMoviesGet$ResponseExtension
    on DiscoverKeywordKeywordIdMoviesGet$Response {
  DiscoverKeywordKeywordIdMoviesGet$Response copyWith({
    double? page,
    double? totalPages,
    double? totalResults,
    List<MovieResult>? results,
  }) {
    return DiscoverKeywordKeywordIdMoviesGet$Response(
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
      results: results ?? this.results,
    );
  }

  DiscoverKeywordKeywordIdMoviesGet$Response copyWithWrapped({
    Wrapped<double?>? page,
    Wrapped<double?>? totalPages,
    Wrapped<double?>? totalResults,
    Wrapped<List<MovieResult>?>? results,
  }) {
    return DiscoverKeywordKeywordIdMoviesGet$Response(
      page: (page != null ? page.value : this.page),
      totalPages: (totalPages != null ? totalPages.value : this.totalPages),
      totalResults: (totalResults != null
          ? totalResults.value
          : this.totalResults),
      results: (results != null ? results.value : this.results),
    );
  }
}

typedef DiscoverGenresliderMovieGet$Response =
    List<DiscoverGenresliderMovieGet$Response$Item>;

@JsonSerializable(explicitToJson: true)
class DiscoverGenresliderMovieGet$Response$Item {
  const DiscoverGenresliderMovieGet$Response$Item({
    this.id,
    this.backdrops,
    this.name,
  });

  factory DiscoverGenresliderMovieGet$Response$Item.fromJson(
    Map<String, dynamic> json,
  ) => _$DiscoverGenresliderMovieGet$Response$ItemFromJson(json);

  static const toJsonFactory =
      _$DiscoverGenresliderMovieGet$Response$ItemToJson;
  Map<String, dynamic> toJson() =>
      _$DiscoverGenresliderMovieGet$Response$ItemToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final double? id;
  @JsonKey(name: 'backdrops', includeIfNull: false, defaultValue: <Object>[])
  final List<Object>? backdrops;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  static const fromJsonFactory =
      _$DiscoverGenresliderMovieGet$Response$ItemFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is DiscoverGenresliderMovieGet$Response$Item &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.backdrops, backdrops) ||
                const DeepCollectionEquality().equals(
                  other.backdrops,
                  backdrops,
                )) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(backdrops) ^
      const DeepCollectionEquality().hash(name) ^
      runtimeType.hashCode;
}

extension $DiscoverGenresliderMovieGet$Response$ItemExtension
    on DiscoverGenresliderMovieGet$Response$Item {
  DiscoverGenresliderMovieGet$Response$Item copyWith({
    double? id,
    List<Object>? backdrops,
    String? name,
  }) {
    return DiscoverGenresliderMovieGet$Response$Item(
      id: id ?? this.id,
      backdrops: backdrops ?? this.backdrops,
      name: name ?? this.name,
    );
  }

  DiscoverGenresliderMovieGet$Response$Item copyWithWrapped({
    Wrapped<double?>? id,
    Wrapped<List<Object>?>? backdrops,
    Wrapped<String?>? name,
  }) {
    return DiscoverGenresliderMovieGet$Response$Item(
      id: (id != null ? id.value : this.id),
      backdrops: (backdrops != null ? backdrops.value : this.backdrops),
      name: (name != null ? name.value : this.name),
    );
  }
}

typedef DiscoverGenresliderTvGet$Response =
    List<DiscoverGenresliderTvGet$Response$Item>;

@JsonSerializable(explicitToJson: true)
class DiscoverGenresliderTvGet$Response$Item {
  const DiscoverGenresliderTvGet$Response$Item({
    this.id,
    this.backdrops,
    this.name,
  });

  factory DiscoverGenresliderTvGet$Response$Item.fromJson(
    Map<String, dynamic> json,
  ) => _$DiscoverGenresliderTvGet$Response$ItemFromJson(json);

  static const toJsonFactory = _$DiscoverGenresliderTvGet$Response$ItemToJson;
  Map<String, dynamic> toJson() =>
      _$DiscoverGenresliderTvGet$Response$ItemToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final double? id;
  @JsonKey(name: 'backdrops', includeIfNull: false, defaultValue: <Object>[])
  final List<Object>? backdrops;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  static const fromJsonFactory =
      _$DiscoverGenresliderTvGet$Response$ItemFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is DiscoverGenresliderTvGet$Response$Item &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.backdrops, backdrops) ||
                const DeepCollectionEquality().equals(
                  other.backdrops,
                  backdrops,
                )) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(backdrops) ^
      const DeepCollectionEquality().hash(name) ^
      runtimeType.hashCode;
}

extension $DiscoverGenresliderTvGet$Response$ItemExtension
    on DiscoverGenresliderTvGet$Response$Item {
  DiscoverGenresliderTvGet$Response$Item copyWith({
    double? id,
    List<Object>? backdrops,
    String? name,
  }) {
    return DiscoverGenresliderTvGet$Response$Item(
      id: id ?? this.id,
      backdrops: backdrops ?? this.backdrops,
      name: name ?? this.name,
    );
  }

  DiscoverGenresliderTvGet$Response$Item copyWithWrapped({
    Wrapped<double?>? id,
    Wrapped<List<Object>?>? backdrops,
    Wrapped<String?>? name,
  }) {
    return DiscoverGenresliderTvGet$Response$Item(
      id: (id != null ? id.value : this.id),
      backdrops: (backdrops != null ? backdrops.value : this.backdrops),
      name: (name != null ? name.value : this.name),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class DiscoverWatchlistGet$Response {
  const DiscoverWatchlistGet$Response({
    this.page,
    this.totalPages,
    this.totalResults,
    this.results,
  });

  factory DiscoverWatchlistGet$Response.fromJson(Map<String, dynamic> json) =>
      _$DiscoverWatchlistGet$ResponseFromJson(json);

  static const toJsonFactory = _$DiscoverWatchlistGet$ResponseToJson;
  Map<String, dynamic> toJson() => _$DiscoverWatchlistGet$ResponseToJson(this);

  @JsonKey(name: 'page', includeIfNull: false)
  final double? page;
  @JsonKey(name: 'totalPages', includeIfNull: false)
  final double? totalPages;
  @JsonKey(name: 'totalResults', includeIfNull: false)
  final double? totalResults;
  @JsonKey(name: 'results', includeIfNull: false)
  final List<DiscoverWatchlistGet$Response$Results$Item>? results;
  static const fromJsonFactory = _$DiscoverWatchlistGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is DiscoverWatchlistGet$Response &&
            (identical(other.page, page) ||
                const DeepCollectionEquality().equals(other.page, page)) &&
            (identical(other.totalPages, totalPages) ||
                const DeepCollectionEquality().equals(
                  other.totalPages,
                  totalPages,
                )) &&
            (identical(other.totalResults, totalResults) ||
                const DeepCollectionEquality().equals(
                  other.totalResults,
                  totalResults,
                )) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(page) ^
      const DeepCollectionEquality().hash(totalPages) ^
      const DeepCollectionEquality().hash(totalResults) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $DiscoverWatchlistGet$ResponseExtension
    on DiscoverWatchlistGet$Response {
  DiscoverWatchlistGet$Response copyWith({
    double? page,
    double? totalPages,
    double? totalResults,
    List<DiscoverWatchlistGet$Response$Results$Item>? results,
  }) {
    return DiscoverWatchlistGet$Response(
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
      results: results ?? this.results,
    );
  }

  DiscoverWatchlistGet$Response copyWithWrapped({
    Wrapped<double?>? page,
    Wrapped<double?>? totalPages,
    Wrapped<double?>? totalResults,
    Wrapped<List<DiscoverWatchlistGet$Response$Results$Item>?>? results,
  }) {
    return DiscoverWatchlistGet$Response(
      page: (page != null ? page.value : this.page),
      totalPages: (totalPages != null ? totalPages.value : this.totalPages),
      totalResults: (totalResults != null
          ? totalResults.value
          : this.totalResults),
      results: (results != null ? results.value : this.results),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RequestGet$Response {
  const RequestGet$Response({this.pageInfo, this.results});

  factory RequestGet$Response.fromJson(Map<String, dynamic> json) =>
      _$RequestGet$ResponseFromJson(json);

  static const toJsonFactory = _$RequestGet$ResponseToJson;
  Map<String, dynamic> toJson() => _$RequestGet$ResponseToJson(this);

  @JsonKey(name: 'pageInfo', includeIfNull: false)
  final PageInfo? pageInfo;
  @JsonKey(
    name: 'results',
    includeIfNull: false,
    defaultValue: <MediaRequest>[],
  )
  final List<MediaRequest>? results;
  static const fromJsonFactory = _$RequestGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is RequestGet$Response &&
            (identical(other.pageInfo, pageInfo) ||
                const DeepCollectionEquality().equals(
                  other.pageInfo,
                  pageInfo,
                )) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(pageInfo) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $RequestGet$ResponseExtension on RequestGet$Response {
  RequestGet$Response copyWith({
    PageInfo? pageInfo,
    List<MediaRequest>? results,
  }) {
    return RequestGet$Response(
      pageInfo: pageInfo ?? this.pageInfo,
      results: results ?? this.results,
    );
  }

  RequestGet$Response copyWithWrapped({
    Wrapped<PageInfo?>? pageInfo,
    Wrapped<List<MediaRequest>?>? results,
  }) {
    return RequestGet$Response(
      pageInfo: (pageInfo != null ? pageInfo.value : this.pageInfo),
      results: (results != null ? results.value : this.results),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RequestCountGet$Response {
  const RequestCountGet$Response({
    this.total,
    this.movie,
    this.tv,
    this.pending,
    this.approved,
    this.declined,
    this.processing,
    this.available,
    this.completed,
  });

  factory RequestCountGet$Response.fromJson(Map<String, dynamic> json) =>
      _$RequestCountGet$ResponseFromJson(json);

  static const toJsonFactory = _$RequestCountGet$ResponseToJson;
  Map<String, dynamic> toJson() => _$RequestCountGet$ResponseToJson(this);

  @JsonKey(name: 'total', includeIfNull: false)
  final double? total;
  @JsonKey(name: 'movie', includeIfNull: false)
  final double? movie;
  @JsonKey(name: 'tv', includeIfNull: false)
  final double? tv;
  @JsonKey(name: 'pending', includeIfNull: false)
  final double? pending;
  @JsonKey(name: 'approved', includeIfNull: false)
  final double? approved;
  @JsonKey(name: 'declined', includeIfNull: false)
  final double? declined;
  @JsonKey(name: 'processing', includeIfNull: false)
  final double? processing;
  @JsonKey(name: 'available', includeIfNull: false)
  final double? available;
  @JsonKey(name: 'completed', includeIfNull: false)
  final double? completed;
  static const fromJsonFactory = _$RequestCountGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is RequestCountGet$Response &&
            (identical(other.total, total) ||
                const DeepCollectionEquality().equals(other.total, total)) &&
            (identical(other.movie, movie) ||
                const DeepCollectionEquality().equals(other.movie, movie)) &&
            (identical(other.tv, tv) ||
                const DeepCollectionEquality().equals(other.tv, tv)) &&
            (identical(other.pending, pending) ||
                const DeepCollectionEquality().equals(
                  other.pending,
                  pending,
                )) &&
            (identical(other.approved, approved) ||
                const DeepCollectionEquality().equals(
                  other.approved,
                  approved,
                )) &&
            (identical(other.declined, declined) ||
                const DeepCollectionEquality().equals(
                  other.declined,
                  declined,
                )) &&
            (identical(other.processing, processing) ||
                const DeepCollectionEquality().equals(
                  other.processing,
                  processing,
                )) &&
            (identical(other.available, available) ||
                const DeepCollectionEquality().equals(
                  other.available,
                  available,
                )) &&
            (identical(other.completed, completed) ||
                const DeepCollectionEquality().equals(
                  other.completed,
                  completed,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(total) ^
      const DeepCollectionEquality().hash(movie) ^
      const DeepCollectionEquality().hash(tv) ^
      const DeepCollectionEquality().hash(pending) ^
      const DeepCollectionEquality().hash(approved) ^
      const DeepCollectionEquality().hash(declined) ^
      const DeepCollectionEquality().hash(processing) ^
      const DeepCollectionEquality().hash(available) ^
      const DeepCollectionEquality().hash(completed) ^
      runtimeType.hashCode;
}

extension $RequestCountGet$ResponseExtension on RequestCountGet$Response {
  RequestCountGet$Response copyWith({
    double? total,
    double? movie,
    double? tv,
    double? pending,
    double? approved,
    double? declined,
    double? processing,
    double? available,
    double? completed,
  }) {
    return RequestCountGet$Response(
      total: total ?? this.total,
      movie: movie ?? this.movie,
      tv: tv ?? this.tv,
      pending: pending ?? this.pending,
      approved: approved ?? this.approved,
      declined: declined ?? this.declined,
      processing: processing ?? this.processing,
      available: available ?? this.available,
      completed: completed ?? this.completed,
    );
  }

  RequestCountGet$Response copyWithWrapped({
    Wrapped<double?>? total,
    Wrapped<double?>? movie,
    Wrapped<double?>? tv,
    Wrapped<double?>? pending,
    Wrapped<double?>? approved,
    Wrapped<double?>? declined,
    Wrapped<double?>? processing,
    Wrapped<double?>? available,
    Wrapped<double?>? completed,
  }) {
    return RequestCountGet$Response(
      total: (total != null ? total.value : this.total),
      movie: (movie != null ? movie.value : this.movie),
      tv: (tv != null ? tv.value : this.tv),
      pending: (pending != null ? pending.value : this.pending),
      approved: (approved != null ? approved.value : this.approved),
      declined: (declined != null ? declined.value : this.declined),
      processing: (processing != null ? processing.value : this.processing),
      available: (available != null ? available.value : this.available),
      completed: (completed != null ? completed.value : this.completed),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class MovieMovieIdRecommendationsGet$Response {
  const MovieMovieIdRecommendationsGet$Response({
    this.page,
    this.totalPages,
    this.totalResults,
    this.results,
  });

  factory MovieMovieIdRecommendationsGet$Response.fromJson(
    Map<String, dynamic> json,
  ) => _$MovieMovieIdRecommendationsGet$ResponseFromJson(json);

  static const toJsonFactory = _$MovieMovieIdRecommendationsGet$ResponseToJson;
  Map<String, dynamic> toJson() =>
      _$MovieMovieIdRecommendationsGet$ResponseToJson(this);

  @JsonKey(name: 'page', includeIfNull: false)
  final double? page;
  @JsonKey(name: 'totalPages', includeIfNull: false)
  final double? totalPages;
  @JsonKey(name: 'totalResults', includeIfNull: false)
  final double? totalResults;
  @JsonKey(name: 'results', includeIfNull: false, defaultValue: <MovieResult>[])
  final List<MovieResult>? results;
  static const fromJsonFactory =
      _$MovieMovieIdRecommendationsGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MovieMovieIdRecommendationsGet$Response &&
            (identical(other.page, page) ||
                const DeepCollectionEquality().equals(other.page, page)) &&
            (identical(other.totalPages, totalPages) ||
                const DeepCollectionEquality().equals(
                  other.totalPages,
                  totalPages,
                )) &&
            (identical(other.totalResults, totalResults) ||
                const DeepCollectionEquality().equals(
                  other.totalResults,
                  totalResults,
                )) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(page) ^
      const DeepCollectionEquality().hash(totalPages) ^
      const DeepCollectionEquality().hash(totalResults) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $MovieMovieIdRecommendationsGet$ResponseExtension
    on MovieMovieIdRecommendationsGet$Response {
  MovieMovieIdRecommendationsGet$Response copyWith({
    double? page,
    double? totalPages,
    double? totalResults,
    List<MovieResult>? results,
  }) {
    return MovieMovieIdRecommendationsGet$Response(
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
      results: results ?? this.results,
    );
  }

  MovieMovieIdRecommendationsGet$Response copyWithWrapped({
    Wrapped<double?>? page,
    Wrapped<double?>? totalPages,
    Wrapped<double?>? totalResults,
    Wrapped<List<MovieResult>?>? results,
  }) {
    return MovieMovieIdRecommendationsGet$Response(
      page: (page != null ? page.value : this.page),
      totalPages: (totalPages != null ? totalPages.value : this.totalPages),
      totalResults: (totalResults != null
          ? totalResults.value
          : this.totalResults),
      results: (results != null ? results.value : this.results),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class MovieMovieIdSimilarGet$Response {
  const MovieMovieIdSimilarGet$Response({
    this.page,
    this.totalPages,
    this.totalResults,
    this.results,
  });

  factory MovieMovieIdSimilarGet$Response.fromJson(Map<String, dynamic> json) =>
      _$MovieMovieIdSimilarGet$ResponseFromJson(json);

  static const toJsonFactory = _$MovieMovieIdSimilarGet$ResponseToJson;
  Map<String, dynamic> toJson() =>
      _$MovieMovieIdSimilarGet$ResponseToJson(this);

  @JsonKey(name: 'page', includeIfNull: false)
  final double? page;
  @JsonKey(name: 'totalPages', includeIfNull: false)
  final double? totalPages;
  @JsonKey(name: 'totalResults', includeIfNull: false)
  final double? totalResults;
  @JsonKey(name: 'results', includeIfNull: false, defaultValue: <MovieResult>[])
  final List<MovieResult>? results;
  static const fromJsonFactory = _$MovieMovieIdSimilarGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MovieMovieIdSimilarGet$Response &&
            (identical(other.page, page) ||
                const DeepCollectionEquality().equals(other.page, page)) &&
            (identical(other.totalPages, totalPages) ||
                const DeepCollectionEquality().equals(
                  other.totalPages,
                  totalPages,
                )) &&
            (identical(other.totalResults, totalResults) ||
                const DeepCollectionEquality().equals(
                  other.totalResults,
                  totalResults,
                )) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(page) ^
      const DeepCollectionEquality().hash(totalPages) ^
      const DeepCollectionEquality().hash(totalResults) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $MovieMovieIdSimilarGet$ResponseExtension
    on MovieMovieIdSimilarGet$Response {
  MovieMovieIdSimilarGet$Response copyWith({
    double? page,
    double? totalPages,
    double? totalResults,
    List<MovieResult>? results,
  }) {
    return MovieMovieIdSimilarGet$Response(
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
      results: results ?? this.results,
    );
  }

  MovieMovieIdSimilarGet$Response copyWithWrapped({
    Wrapped<double?>? page,
    Wrapped<double?>? totalPages,
    Wrapped<double?>? totalResults,
    Wrapped<List<MovieResult>?>? results,
  }) {
    return MovieMovieIdSimilarGet$Response(
      page: (page != null ? page.value : this.page),
      totalPages: (totalPages != null ? totalPages.value : this.totalPages),
      totalResults: (totalResults != null
          ? totalResults.value
          : this.totalResults),
      results: (results != null ? results.value : this.results),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class MovieMovieIdRatingsGet$Response {
  const MovieMovieIdRatingsGet$Response({
    this.title,
    this.year,
    this.url,
    this.criticsScore,
    this.criticsRating,
    this.audienceScore,
    this.audienceRating,
  });

  factory MovieMovieIdRatingsGet$Response.fromJson(Map<String, dynamic> json) =>
      _$MovieMovieIdRatingsGet$ResponseFromJson(json);

  static const toJsonFactory = _$MovieMovieIdRatingsGet$ResponseToJson;
  Map<String, dynamic> toJson() =>
      _$MovieMovieIdRatingsGet$ResponseToJson(this);

  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;
  @JsonKey(name: 'year', includeIfNull: false)
  final double? year;
  @JsonKey(name: 'url', includeIfNull: false)
  final String? url;
  @JsonKey(name: 'criticsScore', includeIfNull: false)
  final double? criticsScore;
  @JsonKey(
    name: 'criticsRating',
    includeIfNull: false,
    toJson: movieMovieIdRatingsGet$ResponseCriticsRatingNullableToJson,
    fromJson: movieMovieIdRatingsGet$ResponseCriticsRatingNullableFromJson,
  )
  final enums.MovieMovieIdRatingsGet$ResponseCriticsRating? criticsRating;
  @JsonKey(name: 'audienceScore', includeIfNull: false)
  final double? audienceScore;
  @JsonKey(
    name: 'audienceRating',
    includeIfNull: false,
    toJson: movieMovieIdRatingsGet$ResponseAudienceRatingNullableToJson,
    fromJson: movieMovieIdRatingsGet$ResponseAudienceRatingNullableFromJson,
  )
  final enums.MovieMovieIdRatingsGet$ResponseAudienceRating? audienceRating;
  static const fromJsonFactory = _$MovieMovieIdRatingsGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MovieMovieIdRatingsGet$Response &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.year, year) ||
                const DeepCollectionEquality().equals(other.year, year)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.criticsScore, criticsScore) ||
                const DeepCollectionEquality().equals(
                  other.criticsScore,
                  criticsScore,
                )) &&
            (identical(other.criticsRating, criticsRating) ||
                const DeepCollectionEquality().equals(
                  other.criticsRating,
                  criticsRating,
                )) &&
            (identical(other.audienceScore, audienceScore) ||
                const DeepCollectionEquality().equals(
                  other.audienceScore,
                  audienceScore,
                )) &&
            (identical(other.audienceRating, audienceRating) ||
                const DeepCollectionEquality().equals(
                  other.audienceRating,
                  audienceRating,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(year) ^
      const DeepCollectionEquality().hash(url) ^
      const DeepCollectionEquality().hash(criticsScore) ^
      const DeepCollectionEquality().hash(criticsRating) ^
      const DeepCollectionEquality().hash(audienceScore) ^
      const DeepCollectionEquality().hash(audienceRating) ^
      runtimeType.hashCode;
}

extension $MovieMovieIdRatingsGet$ResponseExtension
    on MovieMovieIdRatingsGet$Response {
  MovieMovieIdRatingsGet$Response copyWith({
    String? title,
    double? year,
    String? url,
    double? criticsScore,
    enums.MovieMovieIdRatingsGet$ResponseCriticsRating? criticsRating,
    double? audienceScore,
    enums.MovieMovieIdRatingsGet$ResponseAudienceRating? audienceRating,
  }) {
    return MovieMovieIdRatingsGet$Response(
      title: title ?? this.title,
      year: year ?? this.year,
      url: url ?? this.url,
      criticsScore: criticsScore ?? this.criticsScore,
      criticsRating: criticsRating ?? this.criticsRating,
      audienceScore: audienceScore ?? this.audienceScore,
      audienceRating: audienceRating ?? this.audienceRating,
    );
  }

  MovieMovieIdRatingsGet$Response copyWithWrapped({
    Wrapped<String?>? title,
    Wrapped<double?>? year,
    Wrapped<String?>? url,
    Wrapped<double?>? criticsScore,
    Wrapped<enums.MovieMovieIdRatingsGet$ResponseCriticsRating?>? criticsRating,
    Wrapped<double?>? audienceScore,
    Wrapped<enums.MovieMovieIdRatingsGet$ResponseAudienceRating?>?
    audienceRating,
  }) {
    return MovieMovieIdRatingsGet$Response(
      title: (title != null ? title.value : this.title),
      year: (year != null ? year.value : this.year),
      url: (url != null ? url.value : this.url),
      criticsScore: (criticsScore != null
          ? criticsScore.value
          : this.criticsScore),
      criticsRating: (criticsRating != null
          ? criticsRating.value
          : this.criticsRating),
      audienceScore: (audienceScore != null
          ? audienceScore.value
          : this.audienceScore),
      audienceRating: (audienceRating != null
          ? audienceRating.value
          : this.audienceRating),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class MovieMovieIdRatingscombinedGet$Response {
  const MovieMovieIdRatingscombinedGet$Response({this.rt, this.imdb});

  factory MovieMovieIdRatingscombinedGet$Response.fromJson(
    Map<String, dynamic> json,
  ) => _$MovieMovieIdRatingscombinedGet$ResponseFromJson(json);

  static const toJsonFactory = _$MovieMovieIdRatingscombinedGet$ResponseToJson;
  Map<String, dynamic> toJson() =>
      _$MovieMovieIdRatingscombinedGet$ResponseToJson(this);

  @JsonKey(name: 'rt', includeIfNull: false)
  final MovieMovieIdRatingscombinedGet$Response$Rt? rt;
  @JsonKey(name: 'imdb', includeIfNull: false)
  final MovieMovieIdRatingscombinedGet$Response$Imdb? imdb;
  static const fromJsonFactory =
      _$MovieMovieIdRatingscombinedGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MovieMovieIdRatingscombinedGet$Response &&
            (identical(other.rt, rt) ||
                const DeepCollectionEquality().equals(other.rt, rt)) &&
            (identical(other.imdb, imdb) ||
                const DeepCollectionEquality().equals(other.imdb, imdb)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(rt) ^
      const DeepCollectionEquality().hash(imdb) ^
      runtimeType.hashCode;
}

extension $MovieMovieIdRatingscombinedGet$ResponseExtension
    on MovieMovieIdRatingscombinedGet$Response {
  MovieMovieIdRatingscombinedGet$Response copyWith({
    MovieMovieIdRatingscombinedGet$Response$Rt? rt,
    MovieMovieIdRatingscombinedGet$Response$Imdb? imdb,
  }) {
    return MovieMovieIdRatingscombinedGet$Response(
      rt: rt ?? this.rt,
      imdb: imdb ?? this.imdb,
    );
  }

  MovieMovieIdRatingscombinedGet$Response copyWithWrapped({
    Wrapped<MovieMovieIdRatingscombinedGet$Response$Rt?>? rt,
    Wrapped<MovieMovieIdRatingscombinedGet$Response$Imdb?>? imdb,
  }) {
    return MovieMovieIdRatingscombinedGet$Response(
      rt: (rt != null ? rt.value : this.rt),
      imdb: (imdb != null ? imdb.value : this.imdb),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TvTvIdRecommendationsGet$Response {
  const TvTvIdRecommendationsGet$Response({
    this.page,
    this.totalPages,
    this.totalResults,
    this.results,
  });

  factory TvTvIdRecommendationsGet$Response.fromJson(
    Map<String, dynamic> json,
  ) => _$TvTvIdRecommendationsGet$ResponseFromJson(json);

  static const toJsonFactory = _$TvTvIdRecommendationsGet$ResponseToJson;
  Map<String, dynamic> toJson() =>
      _$TvTvIdRecommendationsGet$ResponseToJson(this);

  @JsonKey(name: 'page', includeIfNull: false)
  final double? page;
  @JsonKey(name: 'totalPages', includeIfNull: false)
  final double? totalPages;
  @JsonKey(name: 'totalResults', includeIfNull: false)
  final double? totalResults;
  @JsonKey(name: 'results', includeIfNull: false, defaultValue: <TvResult>[])
  final List<TvResult>? results;
  static const fromJsonFactory = _$TvTvIdRecommendationsGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TvTvIdRecommendationsGet$Response &&
            (identical(other.page, page) ||
                const DeepCollectionEquality().equals(other.page, page)) &&
            (identical(other.totalPages, totalPages) ||
                const DeepCollectionEquality().equals(
                  other.totalPages,
                  totalPages,
                )) &&
            (identical(other.totalResults, totalResults) ||
                const DeepCollectionEquality().equals(
                  other.totalResults,
                  totalResults,
                )) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(page) ^
      const DeepCollectionEquality().hash(totalPages) ^
      const DeepCollectionEquality().hash(totalResults) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $TvTvIdRecommendationsGet$ResponseExtension
    on TvTvIdRecommendationsGet$Response {
  TvTvIdRecommendationsGet$Response copyWith({
    double? page,
    double? totalPages,
    double? totalResults,
    List<TvResult>? results,
  }) {
    return TvTvIdRecommendationsGet$Response(
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
      results: results ?? this.results,
    );
  }

  TvTvIdRecommendationsGet$Response copyWithWrapped({
    Wrapped<double?>? page,
    Wrapped<double?>? totalPages,
    Wrapped<double?>? totalResults,
    Wrapped<List<TvResult>?>? results,
  }) {
    return TvTvIdRecommendationsGet$Response(
      page: (page != null ? page.value : this.page),
      totalPages: (totalPages != null ? totalPages.value : this.totalPages),
      totalResults: (totalResults != null
          ? totalResults.value
          : this.totalResults),
      results: (results != null ? results.value : this.results),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TvTvIdSimilarGet$Response {
  const TvTvIdSimilarGet$Response({
    this.page,
    this.totalPages,
    this.totalResults,
    this.results,
  });

  factory TvTvIdSimilarGet$Response.fromJson(Map<String, dynamic> json) =>
      _$TvTvIdSimilarGet$ResponseFromJson(json);

  static const toJsonFactory = _$TvTvIdSimilarGet$ResponseToJson;
  Map<String, dynamic> toJson() => _$TvTvIdSimilarGet$ResponseToJson(this);

  @JsonKey(name: 'page', includeIfNull: false)
  final double? page;
  @JsonKey(name: 'totalPages', includeIfNull: false)
  final double? totalPages;
  @JsonKey(name: 'totalResults', includeIfNull: false)
  final double? totalResults;
  @JsonKey(name: 'results', includeIfNull: false, defaultValue: <TvResult>[])
  final List<TvResult>? results;
  static const fromJsonFactory = _$TvTvIdSimilarGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TvTvIdSimilarGet$Response &&
            (identical(other.page, page) ||
                const DeepCollectionEquality().equals(other.page, page)) &&
            (identical(other.totalPages, totalPages) ||
                const DeepCollectionEquality().equals(
                  other.totalPages,
                  totalPages,
                )) &&
            (identical(other.totalResults, totalResults) ||
                const DeepCollectionEquality().equals(
                  other.totalResults,
                  totalResults,
                )) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(page) ^
      const DeepCollectionEquality().hash(totalPages) ^
      const DeepCollectionEquality().hash(totalResults) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $TvTvIdSimilarGet$ResponseExtension on TvTvIdSimilarGet$Response {
  TvTvIdSimilarGet$Response copyWith({
    double? page,
    double? totalPages,
    double? totalResults,
    List<TvResult>? results,
  }) {
    return TvTvIdSimilarGet$Response(
      page: page ?? this.page,
      totalPages: totalPages ?? this.totalPages,
      totalResults: totalResults ?? this.totalResults,
      results: results ?? this.results,
    );
  }

  TvTvIdSimilarGet$Response copyWithWrapped({
    Wrapped<double?>? page,
    Wrapped<double?>? totalPages,
    Wrapped<double?>? totalResults,
    Wrapped<List<TvResult>?>? results,
  }) {
    return TvTvIdSimilarGet$Response(
      page: (page != null ? page.value : this.page),
      totalPages: (totalPages != null ? totalPages.value : this.totalPages),
      totalResults: (totalResults != null
          ? totalResults.value
          : this.totalResults),
      results: (results != null ? results.value : this.results),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TvTvIdRatingsGet$Response {
  const TvTvIdRatingsGet$Response({
    this.title,
    this.year,
    this.url,
    this.criticsScore,
    this.criticsRating,
  });

  factory TvTvIdRatingsGet$Response.fromJson(Map<String, dynamic> json) =>
      _$TvTvIdRatingsGet$ResponseFromJson(json);

  static const toJsonFactory = _$TvTvIdRatingsGet$ResponseToJson;
  Map<String, dynamic> toJson() => _$TvTvIdRatingsGet$ResponseToJson(this);

  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;
  @JsonKey(name: 'year', includeIfNull: false)
  final double? year;
  @JsonKey(name: 'url', includeIfNull: false)
  final String? url;
  @JsonKey(name: 'criticsScore', includeIfNull: false)
  final double? criticsScore;
  @JsonKey(
    name: 'criticsRating',
    includeIfNull: false,
    toJson: tvTvIdRatingsGet$ResponseCriticsRatingNullableToJson,
    fromJson: tvTvIdRatingsGet$ResponseCriticsRatingNullableFromJson,
  )
  final enums.TvTvIdRatingsGet$ResponseCriticsRating? criticsRating;
  static const fromJsonFactory = _$TvTvIdRatingsGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TvTvIdRatingsGet$Response &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.year, year) ||
                const DeepCollectionEquality().equals(other.year, year)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.criticsScore, criticsScore) ||
                const DeepCollectionEquality().equals(
                  other.criticsScore,
                  criticsScore,
                )) &&
            (identical(other.criticsRating, criticsRating) ||
                const DeepCollectionEquality().equals(
                  other.criticsRating,
                  criticsRating,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(year) ^
      const DeepCollectionEquality().hash(url) ^
      const DeepCollectionEquality().hash(criticsScore) ^
      const DeepCollectionEquality().hash(criticsRating) ^
      runtimeType.hashCode;
}

extension $TvTvIdRatingsGet$ResponseExtension on TvTvIdRatingsGet$Response {
  TvTvIdRatingsGet$Response copyWith({
    String? title,
    double? year,
    String? url,
    double? criticsScore,
    enums.TvTvIdRatingsGet$ResponseCriticsRating? criticsRating,
  }) {
    return TvTvIdRatingsGet$Response(
      title: title ?? this.title,
      year: year ?? this.year,
      url: url ?? this.url,
      criticsScore: criticsScore ?? this.criticsScore,
      criticsRating: criticsRating ?? this.criticsRating,
    );
  }

  TvTvIdRatingsGet$Response copyWithWrapped({
    Wrapped<String?>? title,
    Wrapped<double?>? year,
    Wrapped<String?>? url,
    Wrapped<double?>? criticsScore,
    Wrapped<enums.TvTvIdRatingsGet$ResponseCriticsRating?>? criticsRating,
  }) {
    return TvTvIdRatingsGet$Response(
      title: (title != null ? title.value : this.title),
      year: (year != null ? year.value : this.year),
      url: (url != null ? url.value : this.url),
      criticsScore: (criticsScore != null
          ? criticsScore.value
          : this.criticsScore),
      criticsRating: (criticsRating != null
          ? criticsRating.value
          : this.criticsRating),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PersonPersonIdCombinedCreditsGet$Response {
  const PersonPersonIdCombinedCreditsGet$Response({
    this.cast,
    this.crew,
    this.id,
  });

  factory PersonPersonIdCombinedCreditsGet$Response.fromJson(
    Map<String, dynamic> json,
  ) => _$PersonPersonIdCombinedCreditsGet$ResponseFromJson(json);

  static const toJsonFactory =
      _$PersonPersonIdCombinedCreditsGet$ResponseToJson;
  Map<String, dynamic> toJson() =>
      _$PersonPersonIdCombinedCreditsGet$ResponseToJson(this);

  @JsonKey(name: 'cast', includeIfNull: false, defaultValue: <CreditCast>[])
  final List<CreditCast>? cast;
  @JsonKey(name: 'crew', includeIfNull: false, defaultValue: <CreditCrew>[])
  final List<CreditCrew>? crew;
  @JsonKey(name: 'id', includeIfNull: false)
  final double? id;
  static const fromJsonFactory =
      _$PersonPersonIdCombinedCreditsGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PersonPersonIdCombinedCreditsGet$Response &&
            (identical(other.cast, cast) ||
                const DeepCollectionEquality().equals(other.cast, cast)) &&
            (identical(other.crew, crew) ||
                const DeepCollectionEquality().equals(other.crew, crew)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(cast) ^
      const DeepCollectionEquality().hash(crew) ^
      const DeepCollectionEquality().hash(id) ^
      runtimeType.hashCode;
}

extension $PersonPersonIdCombinedCreditsGet$ResponseExtension
    on PersonPersonIdCombinedCreditsGet$Response {
  PersonPersonIdCombinedCreditsGet$Response copyWith({
    List<CreditCast>? cast,
    List<CreditCrew>? crew,
    double? id,
  }) {
    return PersonPersonIdCombinedCreditsGet$Response(
      cast: cast ?? this.cast,
      crew: crew ?? this.crew,
      id: id ?? this.id,
    );
  }

  PersonPersonIdCombinedCreditsGet$Response copyWithWrapped({
    Wrapped<List<CreditCast>?>? cast,
    Wrapped<List<CreditCrew>?>? crew,
    Wrapped<double?>? id,
  }) {
    return PersonPersonIdCombinedCreditsGet$Response(
      cast: (cast != null ? cast.value : this.cast),
      crew: (crew != null ? crew.value : this.crew),
      id: (id != null ? id.value : this.id),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class MediaGet$Response {
  const MediaGet$Response({this.pageInfo, this.results});

  factory MediaGet$Response.fromJson(Map<String, dynamic> json) =>
      _$MediaGet$ResponseFromJson(json);

  static const toJsonFactory = _$MediaGet$ResponseToJson;
  Map<String, dynamic> toJson() => _$MediaGet$ResponseToJson(this);

  @JsonKey(name: 'pageInfo', includeIfNull: false)
  final PageInfo? pageInfo;
  @JsonKey(name: 'results', includeIfNull: false, defaultValue: <MediaInfo>[])
  final List<MediaInfo>? results;
  static const fromJsonFactory = _$MediaGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MediaGet$Response &&
            (identical(other.pageInfo, pageInfo) ||
                const DeepCollectionEquality().equals(
                  other.pageInfo,
                  pageInfo,
                )) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(pageInfo) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $MediaGet$ResponseExtension on MediaGet$Response {
  MediaGet$Response copyWith({PageInfo? pageInfo, List<MediaInfo>? results}) {
    return MediaGet$Response(
      pageInfo: pageInfo ?? this.pageInfo,
      results: results ?? this.results,
    );
  }

  MediaGet$Response copyWithWrapped({
    Wrapped<PageInfo?>? pageInfo,
    Wrapped<List<MediaInfo>?>? results,
  }) {
    return MediaGet$Response(
      pageInfo: (pageInfo != null ? pageInfo.value : this.pageInfo),
      results: (results != null ? results.value : this.results),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class MediaMediaIdWatchDataGet$Response {
  const MediaMediaIdWatchDataGet$Response({this.data, this.data4k});

  factory MediaMediaIdWatchDataGet$Response.fromJson(
    Map<String, dynamic> json,
  ) => _$MediaMediaIdWatchDataGet$ResponseFromJson(json);

  static const toJsonFactory = _$MediaMediaIdWatchDataGet$ResponseToJson;
  Map<String, dynamic> toJson() =>
      _$MediaMediaIdWatchDataGet$ResponseToJson(this);

  @JsonKey(name: 'data', includeIfNull: false)
  final MediaMediaIdWatchDataGet$Response$Data? data;
  @JsonKey(name: 'data4k', includeIfNull: false)
  final MediaMediaIdWatchDataGet$Response$Data4k? data4k;
  static const fromJsonFactory = _$MediaMediaIdWatchDataGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MediaMediaIdWatchDataGet$Response &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)) &&
            (identical(other.data4k, data4k) ||
                const DeepCollectionEquality().equals(other.data4k, data4k)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(data) ^
      const DeepCollectionEquality().hash(data4k) ^
      runtimeType.hashCode;
}

extension $MediaMediaIdWatchDataGet$ResponseExtension
    on MediaMediaIdWatchDataGet$Response {
  MediaMediaIdWatchDataGet$Response copyWith({
    MediaMediaIdWatchDataGet$Response$Data? data,
    MediaMediaIdWatchDataGet$Response$Data4k? data4k,
  }) {
    return MediaMediaIdWatchDataGet$Response(
      data: data ?? this.data,
      data4k: data4k ?? this.data4k,
    );
  }

  MediaMediaIdWatchDataGet$Response copyWithWrapped({
    Wrapped<MediaMediaIdWatchDataGet$Response$Data?>? data,
    Wrapped<MediaMediaIdWatchDataGet$Response$Data4k?>? data4k,
  }) {
    return MediaMediaIdWatchDataGet$Response(
      data: (data != null ? data.value : this.data),
      data4k: (data4k != null ? data4k.value : this.data4k),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ServiceRadarrRadarrIdGet$Response {
  const ServiceRadarrRadarrIdGet$Response({this.server, this.profiles});

  factory ServiceRadarrRadarrIdGet$Response.fromJson(
    Map<String, dynamic> json,
  ) => _$ServiceRadarrRadarrIdGet$ResponseFromJson(json);

  static const toJsonFactory = _$ServiceRadarrRadarrIdGet$ResponseToJson;
  Map<String, dynamic> toJson() =>
      _$ServiceRadarrRadarrIdGet$ResponseToJson(this);

  @JsonKey(name: 'server', includeIfNull: false)
  final RadarrSettings? server;
  @JsonKey(name: 'profiles', includeIfNull: false)
  final ServiceProfile? profiles;
  static const fromJsonFactory = _$ServiceRadarrRadarrIdGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ServiceRadarrRadarrIdGet$Response &&
            (identical(other.server, server) ||
                const DeepCollectionEquality().equals(other.server, server)) &&
            (identical(other.profiles, profiles) ||
                const DeepCollectionEquality().equals(
                  other.profiles,
                  profiles,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(server) ^
      const DeepCollectionEquality().hash(profiles) ^
      runtimeType.hashCode;
}

extension $ServiceRadarrRadarrIdGet$ResponseExtension
    on ServiceRadarrRadarrIdGet$Response {
  ServiceRadarrRadarrIdGet$Response copyWith({
    RadarrSettings? server,
    ServiceProfile? profiles,
  }) {
    return ServiceRadarrRadarrIdGet$Response(
      server: server ?? this.server,
      profiles: profiles ?? this.profiles,
    );
  }

  ServiceRadarrRadarrIdGet$Response copyWithWrapped({
    Wrapped<RadarrSettings?>? server,
    Wrapped<ServiceProfile?>? profiles,
  }) {
    return ServiceRadarrRadarrIdGet$Response(
      server: (server != null ? server.value : this.server),
      profiles: (profiles != null ? profiles.value : this.profiles),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ServiceSonarrSonarrIdGet$Response {
  const ServiceSonarrSonarrIdGet$Response({this.server, this.profiles});

  factory ServiceSonarrSonarrIdGet$Response.fromJson(
    Map<String, dynamic> json,
  ) => _$ServiceSonarrSonarrIdGet$ResponseFromJson(json);

  static const toJsonFactory = _$ServiceSonarrSonarrIdGet$ResponseToJson;
  Map<String, dynamic> toJson() =>
      _$ServiceSonarrSonarrIdGet$ResponseToJson(this);

  @JsonKey(name: 'server', includeIfNull: false)
  final SonarrSettings? server;
  @JsonKey(name: 'profiles', includeIfNull: false)
  final ServiceProfile? profiles;
  static const fromJsonFactory = _$ServiceSonarrSonarrIdGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ServiceSonarrSonarrIdGet$Response &&
            (identical(other.server, server) ||
                const DeepCollectionEquality().equals(other.server, server)) &&
            (identical(other.profiles, profiles) ||
                const DeepCollectionEquality().equals(
                  other.profiles,
                  profiles,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(server) ^
      const DeepCollectionEquality().hash(profiles) ^
      runtimeType.hashCode;
}

extension $ServiceSonarrSonarrIdGet$ResponseExtension
    on ServiceSonarrSonarrIdGet$Response {
  ServiceSonarrSonarrIdGet$Response copyWith({
    SonarrSettings? server,
    ServiceProfile? profiles,
  }) {
    return ServiceSonarrSonarrIdGet$Response(
      server: server ?? this.server,
      profiles: profiles ?? this.profiles,
    );
  }

  ServiceSonarrSonarrIdGet$Response copyWithWrapped({
    Wrapped<SonarrSettings?>? server,
    Wrapped<ServiceProfile?>? profiles,
  }) {
    return ServiceSonarrSonarrIdGet$Response(
      server: (server != null ? server.value : this.server),
      profiles: (profiles != null ? profiles.value : this.profiles),
    );
  }
}

typedef RegionsGet$Response = List<RegionsGet$Response$Item>;

@JsonSerializable(explicitToJson: true)
class RegionsGet$Response$Item {
  const RegionsGet$Response$Item({this.iso31661, this.englishName});

  factory RegionsGet$Response$Item.fromJson(Map<String, dynamic> json) =>
      _$RegionsGet$Response$ItemFromJson(json);

  static const toJsonFactory = _$RegionsGet$Response$ItemToJson;
  Map<String, dynamic> toJson() => _$RegionsGet$Response$ItemToJson(this);

  @JsonKey(name: 'iso_3166_1', includeIfNull: false)
  final String? iso31661;
  @JsonKey(name: 'english_name', includeIfNull: false)
  final String? englishName;
  static const fromJsonFactory = _$RegionsGet$Response$ItemFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is RegionsGet$Response$Item &&
            (identical(other.iso31661, iso31661) ||
                const DeepCollectionEquality().equals(
                  other.iso31661,
                  iso31661,
                )) &&
            (identical(other.englishName, englishName) ||
                const DeepCollectionEquality().equals(
                  other.englishName,
                  englishName,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(iso31661) ^
      const DeepCollectionEquality().hash(englishName) ^
      runtimeType.hashCode;
}

extension $RegionsGet$Response$ItemExtension on RegionsGet$Response$Item {
  RegionsGet$Response$Item copyWith({String? iso31661, String? englishName}) {
    return RegionsGet$Response$Item(
      iso31661: iso31661 ?? this.iso31661,
      englishName: englishName ?? this.englishName,
    );
  }

  RegionsGet$Response$Item copyWithWrapped({
    Wrapped<String?>? iso31661,
    Wrapped<String?>? englishName,
  }) {
    return RegionsGet$Response$Item(
      iso31661: (iso31661 != null ? iso31661.value : this.iso31661),
      englishName: (englishName != null ? englishName.value : this.englishName),
    );
  }
}

typedef LanguagesGet$Response = List<LanguagesGet$Response$Item>;

@JsonSerializable(explicitToJson: true)
class LanguagesGet$Response$Item {
  const LanguagesGet$Response$Item({this.iso6391, this.englishName, this.name});

  factory LanguagesGet$Response$Item.fromJson(Map<String, dynamic> json) =>
      _$LanguagesGet$Response$ItemFromJson(json);

  static const toJsonFactory = _$LanguagesGet$Response$ItemToJson;
  Map<String, dynamic> toJson() => _$LanguagesGet$Response$ItemToJson(this);

  @JsonKey(name: 'iso_639_1', includeIfNull: false)
  final String? iso6391;
  @JsonKey(name: 'english_name', includeIfNull: false)
  final String? englishName;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  static const fromJsonFactory = _$LanguagesGet$Response$ItemFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is LanguagesGet$Response$Item &&
            (identical(other.iso6391, iso6391) ||
                const DeepCollectionEquality().equals(
                  other.iso6391,
                  iso6391,
                )) &&
            (identical(other.englishName, englishName) ||
                const DeepCollectionEquality().equals(
                  other.englishName,
                  englishName,
                )) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(iso6391) ^
      const DeepCollectionEquality().hash(englishName) ^
      const DeepCollectionEquality().hash(name) ^
      runtimeType.hashCode;
}

extension $LanguagesGet$Response$ItemExtension on LanguagesGet$Response$Item {
  LanguagesGet$Response$Item copyWith({
    String? iso6391,
    String? englishName,
    String? name,
  }) {
    return LanguagesGet$Response$Item(
      iso6391: iso6391 ?? this.iso6391,
      englishName: englishName ?? this.englishName,
      name: name ?? this.name,
    );
  }

  LanguagesGet$Response$Item copyWithWrapped({
    Wrapped<String?>? iso6391,
    Wrapped<String?>? englishName,
    Wrapped<String?>? name,
  }) {
    return LanguagesGet$Response$Item(
      iso6391: (iso6391 != null ? iso6391.value : this.iso6391),
      englishName: (englishName != null ? englishName.value : this.englishName),
      name: (name != null ? name.value : this.name),
    );
  }
}

typedef GenresMovieGet$Response = List<GenresMovieGet$Response$Item>;

@JsonSerializable(explicitToJson: true)
class GenresMovieGet$Response$Item {
  const GenresMovieGet$Response$Item({this.id, this.name});

  factory GenresMovieGet$Response$Item.fromJson(Map<String, dynamic> json) =>
      _$GenresMovieGet$Response$ItemFromJson(json);

  static const toJsonFactory = _$GenresMovieGet$Response$ItemToJson;
  Map<String, dynamic> toJson() => _$GenresMovieGet$Response$ItemToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final double? id;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  static const fromJsonFactory = _$GenresMovieGet$Response$ItemFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is GenresMovieGet$Response$Item &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      runtimeType.hashCode;
}

extension $GenresMovieGet$Response$ItemExtension
    on GenresMovieGet$Response$Item {
  GenresMovieGet$Response$Item copyWith({double? id, String? name}) {
    return GenresMovieGet$Response$Item(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  GenresMovieGet$Response$Item copyWithWrapped({
    Wrapped<double?>? id,
    Wrapped<String?>? name,
  }) {
    return GenresMovieGet$Response$Item(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
    );
  }
}

typedef GenresTvGet$Response = List<GenresTvGet$Response$Item>;

@JsonSerializable(explicitToJson: true)
class GenresTvGet$Response$Item {
  const GenresTvGet$Response$Item({this.id, this.name});

  factory GenresTvGet$Response$Item.fromJson(Map<String, dynamic> json) =>
      _$GenresTvGet$Response$ItemFromJson(json);

  static const toJsonFactory = _$GenresTvGet$Response$ItemToJson;
  Map<String, dynamic> toJson() => _$GenresTvGet$Response$ItemToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final double? id;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  static const fromJsonFactory = _$GenresTvGet$Response$ItemFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is GenresTvGet$Response$Item &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      runtimeType.hashCode;
}

extension $GenresTvGet$Response$ItemExtension on GenresTvGet$Response$Item {
  GenresTvGet$Response$Item copyWith({double? id, String? name}) {
    return GenresTvGet$Response$Item(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  GenresTvGet$Response$Item copyWithWrapped({
    Wrapped<double?>? id,
    Wrapped<String?>? name,
  }) {
    return GenresTvGet$Response$Item(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class IssueGet$Response {
  const IssueGet$Response({this.pageInfo, this.results});

  factory IssueGet$Response.fromJson(Map<String, dynamic> json) =>
      _$IssueGet$ResponseFromJson(json);

  static const toJsonFactory = _$IssueGet$ResponseToJson;
  Map<String, dynamic> toJson() => _$IssueGet$ResponseToJson(this);

  @JsonKey(name: 'pageInfo', includeIfNull: false)
  final PageInfo? pageInfo;
  @JsonKey(name: 'results', includeIfNull: false, defaultValue: <Issue>[])
  final List<Issue>? results;
  static const fromJsonFactory = _$IssueGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is IssueGet$Response &&
            (identical(other.pageInfo, pageInfo) ||
                const DeepCollectionEquality().equals(
                  other.pageInfo,
                  pageInfo,
                )) &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(pageInfo) ^
      const DeepCollectionEquality().hash(results) ^
      runtimeType.hashCode;
}

extension $IssueGet$ResponseExtension on IssueGet$Response {
  IssueGet$Response copyWith({PageInfo? pageInfo, List<Issue>? results}) {
    return IssueGet$Response(
      pageInfo: pageInfo ?? this.pageInfo,
      results: results ?? this.results,
    );
  }

  IssueGet$Response copyWithWrapped({
    Wrapped<PageInfo?>? pageInfo,
    Wrapped<List<Issue>?>? results,
  }) {
    return IssueGet$Response(
      pageInfo: (pageInfo != null ? pageInfo.value : this.pageInfo),
      results: (results != null ? results.value : this.results),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class IssueCountGet$Response {
  const IssueCountGet$Response({
    this.total,
    this.video,
    this.audio,
    this.subtitles,
    this.others,
    this.open,
    this.closed,
  });

  factory IssueCountGet$Response.fromJson(Map<String, dynamic> json) =>
      _$IssueCountGet$ResponseFromJson(json);

  static const toJsonFactory = _$IssueCountGet$ResponseToJson;
  Map<String, dynamic> toJson() => _$IssueCountGet$ResponseToJson(this);

  @JsonKey(name: 'total', includeIfNull: false)
  final double? total;
  @JsonKey(name: 'video', includeIfNull: false)
  final double? video;
  @JsonKey(name: 'audio', includeIfNull: false)
  final double? audio;
  @JsonKey(name: 'subtitles', includeIfNull: false)
  final double? subtitles;
  @JsonKey(name: 'others', includeIfNull: false)
  final double? others;
  @JsonKey(name: 'open', includeIfNull: false)
  final double? open;
  @JsonKey(name: 'closed', includeIfNull: false)
  final double? closed;
  static const fromJsonFactory = _$IssueCountGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is IssueCountGet$Response &&
            (identical(other.total, total) ||
                const DeepCollectionEquality().equals(other.total, total)) &&
            (identical(other.video, video) ||
                const DeepCollectionEquality().equals(other.video, video)) &&
            (identical(other.audio, audio) ||
                const DeepCollectionEquality().equals(other.audio, audio)) &&
            (identical(other.subtitles, subtitles) ||
                const DeepCollectionEquality().equals(
                  other.subtitles,
                  subtitles,
                )) &&
            (identical(other.others, others) ||
                const DeepCollectionEquality().equals(other.others, others)) &&
            (identical(other.open, open) ||
                const DeepCollectionEquality().equals(other.open, open)) &&
            (identical(other.closed, closed) ||
                const DeepCollectionEquality().equals(other.closed, closed)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(total) ^
      const DeepCollectionEquality().hash(video) ^
      const DeepCollectionEquality().hash(audio) ^
      const DeepCollectionEquality().hash(subtitles) ^
      const DeepCollectionEquality().hash(others) ^
      const DeepCollectionEquality().hash(open) ^
      const DeepCollectionEquality().hash(closed) ^
      runtimeType.hashCode;
}

extension $IssueCountGet$ResponseExtension on IssueCountGet$Response {
  IssueCountGet$Response copyWith({
    double? total,
    double? video,
    double? audio,
    double? subtitles,
    double? others,
    double? open,
    double? closed,
  }) {
    return IssueCountGet$Response(
      total: total ?? this.total,
      video: video ?? this.video,
      audio: audio ?? this.audio,
      subtitles: subtitles ?? this.subtitles,
      others: others ?? this.others,
      open: open ?? this.open,
      closed: closed ?? this.closed,
    );
  }

  IssueCountGet$Response copyWithWrapped({
    Wrapped<double?>? total,
    Wrapped<double?>? video,
    Wrapped<double?>? audio,
    Wrapped<double?>? subtitles,
    Wrapped<double?>? others,
    Wrapped<double?>? open,
    Wrapped<double?>? closed,
  }) {
    return IssueCountGet$Response(
      total: (total != null ? total.value : this.total),
      video: (video != null ? video.value : this.video),
      audio: (audio != null ? audio.value : this.audio),
      subtitles: (subtitles != null ? subtitles.value : this.subtitles),
      others: (others != null ? others.value : this.others),
      open: (open != null ? open.value : this.open),
      closed: (closed != null ? closed.value : this.closed),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class NetworkSettings$Proxy {
  const NetworkSettings$Proxy({
    this.enabled,
    this.hostname,
    this.port,
    this.useSsl,
    this.user,
    this.password,
    this.bypassFilter,
    this.bypassLocalAddresses,
  });

  factory NetworkSettings$Proxy.fromJson(Map<String, dynamic> json) =>
      _$NetworkSettings$ProxyFromJson(json);

  static const toJsonFactory = _$NetworkSettings$ProxyToJson;
  Map<String, dynamic> toJson() => _$NetworkSettings$ProxyToJson(this);

  @JsonKey(name: 'enabled', includeIfNull: false)
  final bool? enabled;
  @JsonKey(name: 'hostname', includeIfNull: false)
  final String? hostname;
  @JsonKey(name: 'port', includeIfNull: false)
  final double? port;
  @JsonKey(name: 'useSsl', includeIfNull: false)
  final bool? useSsl;
  @JsonKey(name: 'user', includeIfNull: false)
  final String? user;
  @JsonKey(name: 'password', includeIfNull: false)
  final String? password;
  @JsonKey(name: 'bypassFilter', includeIfNull: false)
  final String? bypassFilter;
  @JsonKey(name: 'bypassLocalAddresses', includeIfNull: false)
  final bool? bypassLocalAddresses;
  static const fromJsonFactory = _$NetworkSettings$ProxyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is NetworkSettings$Proxy &&
            (identical(other.enabled, enabled) ||
                const DeepCollectionEquality().equals(
                  other.enabled,
                  enabled,
                )) &&
            (identical(other.hostname, hostname) ||
                const DeepCollectionEquality().equals(
                  other.hostname,
                  hostname,
                )) &&
            (identical(other.port, port) ||
                const DeepCollectionEquality().equals(other.port, port)) &&
            (identical(other.useSsl, useSsl) ||
                const DeepCollectionEquality().equals(other.useSsl, useSsl)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality().equals(
                  other.password,
                  password,
                )) &&
            (identical(other.bypassFilter, bypassFilter) ||
                const DeepCollectionEquality().equals(
                  other.bypassFilter,
                  bypassFilter,
                )) &&
            (identical(other.bypassLocalAddresses, bypassLocalAddresses) ||
                const DeepCollectionEquality().equals(
                  other.bypassLocalAddresses,
                  bypassLocalAddresses,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(enabled) ^
      const DeepCollectionEquality().hash(hostname) ^
      const DeepCollectionEquality().hash(port) ^
      const DeepCollectionEquality().hash(useSsl) ^
      const DeepCollectionEquality().hash(user) ^
      const DeepCollectionEquality().hash(password) ^
      const DeepCollectionEquality().hash(bypassFilter) ^
      const DeepCollectionEquality().hash(bypassLocalAddresses) ^
      runtimeType.hashCode;
}

extension $NetworkSettings$ProxyExtension on NetworkSettings$Proxy {
  NetworkSettings$Proxy copyWith({
    bool? enabled,
    String? hostname,
    double? port,
    bool? useSsl,
    String? user,
    String? password,
    String? bypassFilter,
    bool? bypassLocalAddresses,
  }) {
    return NetworkSettings$Proxy(
      enabled: enabled ?? this.enabled,
      hostname: hostname ?? this.hostname,
      port: port ?? this.port,
      useSsl: useSsl ?? this.useSsl,
      user: user ?? this.user,
      password: password ?? this.password,
      bypassFilter: bypassFilter ?? this.bypassFilter,
      bypassLocalAddresses: bypassLocalAddresses ?? this.bypassLocalAddresses,
    );
  }

  NetworkSettings$Proxy copyWithWrapped({
    Wrapped<bool?>? enabled,
    Wrapped<String?>? hostname,
    Wrapped<double?>? port,
    Wrapped<bool?>? useSsl,
    Wrapped<String?>? user,
    Wrapped<String?>? password,
    Wrapped<String?>? bypassFilter,
    Wrapped<bool?>? bypassLocalAddresses,
  }) {
    return NetworkSettings$Proxy(
      enabled: (enabled != null ? enabled.value : this.enabled),
      hostname: (hostname != null ? hostname.value : this.hostname),
      port: (port != null ? port.value : this.port),
      useSsl: (useSsl != null ? useSsl.value : this.useSsl),
      user: (user != null ? user.value : this.user),
      password: (password != null ? password.value : this.password),
      bypassFilter: (bypassFilter != null
          ? bypassFilter.value
          : this.bypassFilter),
      bypassLocalAddresses: (bypassLocalAddresses != null
          ? bypassLocalAddresses.value
          : this.bypassLocalAddresses),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class NetworkSettings$DnsCache {
  const NetworkSettings$DnsCache({
    this.enabled,
    this.forceMinTtl,
    this.forceMaxTtl,
  });

  factory NetworkSettings$DnsCache.fromJson(Map<String, dynamic> json) =>
      _$NetworkSettings$DnsCacheFromJson(json);

  static const toJsonFactory = _$NetworkSettings$DnsCacheToJson;
  Map<String, dynamic> toJson() => _$NetworkSettings$DnsCacheToJson(this);

  @JsonKey(name: 'enabled', includeIfNull: false)
  final bool? enabled;
  @JsonKey(name: 'forceMinTtl', includeIfNull: false)
  final double? forceMinTtl;
  @JsonKey(name: 'forceMaxTtl', includeIfNull: false)
  final double? forceMaxTtl;
  static const fromJsonFactory = _$NetworkSettings$DnsCacheFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is NetworkSettings$DnsCache &&
            (identical(other.enabled, enabled) ||
                const DeepCollectionEquality().equals(
                  other.enabled,
                  enabled,
                )) &&
            (identical(other.forceMinTtl, forceMinTtl) ||
                const DeepCollectionEquality().equals(
                  other.forceMinTtl,
                  forceMinTtl,
                )) &&
            (identical(other.forceMaxTtl, forceMaxTtl) ||
                const DeepCollectionEquality().equals(
                  other.forceMaxTtl,
                  forceMaxTtl,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(enabled) ^
      const DeepCollectionEquality().hash(forceMinTtl) ^
      const DeepCollectionEquality().hash(forceMaxTtl) ^
      runtimeType.hashCode;
}

extension $NetworkSettings$DnsCacheExtension on NetworkSettings$DnsCache {
  NetworkSettings$DnsCache copyWith({
    bool? enabled,
    double? forceMinTtl,
    double? forceMaxTtl,
  }) {
    return NetworkSettings$DnsCache(
      enabled: enabled ?? this.enabled,
      forceMinTtl: forceMinTtl ?? this.forceMinTtl,
      forceMaxTtl: forceMaxTtl ?? this.forceMaxTtl,
    );
  }

  NetworkSettings$DnsCache copyWithWrapped({
    Wrapped<bool?>? enabled,
    Wrapped<double?>? forceMinTtl,
    Wrapped<double?>? forceMaxTtl,
  }) {
    return NetworkSettings$DnsCache(
      enabled: (enabled != null ? enabled.value : this.enabled),
      forceMinTtl: (forceMinTtl != null ? forceMinTtl.value : this.forceMinTtl),
      forceMaxTtl: (forceMaxTtl != null ? forceMaxTtl.value : this.forceMaxTtl),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class MetadataSettings$Settings {
  const MetadataSettings$Settings({this.tv, this.anime});

  factory MetadataSettings$Settings.fromJson(Map<String, dynamic> json) =>
      _$MetadataSettings$SettingsFromJson(json);

  static const toJsonFactory = _$MetadataSettings$SettingsToJson;
  Map<String, dynamic> toJson() => _$MetadataSettings$SettingsToJson(this);

  @JsonKey(
    name: 'tv',
    includeIfNull: false,
    toJson: metadataSettings$SettingsTvNullableToJson,
    fromJson: metadataSettings$SettingsTvNullableFromJson,
  )
  final enums.MetadataSettings$SettingsTv? tv;
  @JsonKey(
    name: 'anime',
    includeIfNull: false,
    toJson: metadataSettings$SettingsAnimeNullableToJson,
    fromJson: metadataSettings$SettingsAnimeNullableFromJson,
  )
  final enums.MetadataSettings$SettingsAnime? anime;
  static const fromJsonFactory = _$MetadataSettings$SettingsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MetadataSettings$Settings &&
            (identical(other.tv, tv) ||
                const DeepCollectionEquality().equals(other.tv, tv)) &&
            (identical(other.anime, anime) ||
                const DeepCollectionEquality().equals(other.anime, anime)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(tv) ^
      const DeepCollectionEquality().hash(anime) ^
      runtimeType.hashCode;
}

extension $MetadataSettings$SettingsExtension on MetadataSettings$Settings {
  MetadataSettings$Settings copyWith({
    enums.MetadataSettings$SettingsTv? tv,
    enums.MetadataSettings$SettingsAnime? anime,
  }) {
    return MetadataSettings$Settings(
      tv: tv ?? this.tv,
      anime: anime ?? this.anime,
    );
  }

  MetadataSettings$Settings copyWithWrapped({
    Wrapped<enums.MetadataSettings$SettingsTv?>? tv,
    Wrapped<enums.MetadataSettings$SettingsAnime?>? anime,
  }) {
    return MetadataSettings$Settings(
      tv: (tv != null ? tv.value : this.tv),
      anime: (anime != null ? anime.value : this.anime),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class MovieDetails$ProductionCountries$Item {
  const MovieDetails$ProductionCountries$Item({this.iso31661, this.name});

  factory MovieDetails$ProductionCountries$Item.fromJson(
    Map<String, dynamic> json,
  ) => _$MovieDetails$ProductionCountries$ItemFromJson(json);

  static const toJsonFactory = _$MovieDetails$ProductionCountries$ItemToJson;
  Map<String, dynamic> toJson() =>
      _$MovieDetails$ProductionCountries$ItemToJson(this);

  @JsonKey(name: 'iso_3166_1', includeIfNull: false)
  final String? iso31661;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  static const fromJsonFactory =
      _$MovieDetails$ProductionCountries$ItemFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MovieDetails$ProductionCountries$Item &&
            (identical(other.iso31661, iso31661) ||
                const DeepCollectionEquality().equals(
                  other.iso31661,
                  iso31661,
                )) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(iso31661) ^
      const DeepCollectionEquality().hash(name) ^
      runtimeType.hashCode;
}

extension $MovieDetails$ProductionCountries$ItemExtension
    on MovieDetails$ProductionCountries$Item {
  MovieDetails$ProductionCountries$Item copyWith({
    String? iso31661,
    String? name,
  }) {
    return MovieDetails$ProductionCountries$Item(
      iso31661: iso31661 ?? this.iso31661,
      name: name ?? this.name,
    );
  }

  MovieDetails$ProductionCountries$Item copyWithWrapped({
    Wrapped<String?>? iso31661,
    Wrapped<String?>? name,
  }) {
    return MovieDetails$ProductionCountries$Item(
      iso31661: (iso31661 != null ? iso31661.value : this.iso31661),
      name: (name != null ? name.value : this.name),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class MovieDetails$Releases {
  const MovieDetails$Releases({this.results});

  factory MovieDetails$Releases.fromJson(Map<String, dynamic> json) =>
      _$MovieDetails$ReleasesFromJson(json);

  static const toJsonFactory = _$MovieDetails$ReleasesToJson;
  Map<String, dynamic> toJson() => _$MovieDetails$ReleasesToJson(this);

  @JsonKey(name: 'results', includeIfNull: false)
  final List<MovieDetails$Releases$Results$Item>? results;
  static const fromJsonFactory = _$MovieDetails$ReleasesFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MovieDetails$Releases &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(results) ^ runtimeType.hashCode;
}

extension $MovieDetails$ReleasesExtension on MovieDetails$Releases {
  MovieDetails$Releases copyWith({
    List<MovieDetails$Releases$Results$Item>? results,
  }) {
    return MovieDetails$Releases(results: results ?? this.results);
  }

  MovieDetails$Releases copyWithWrapped({
    Wrapped<List<MovieDetails$Releases$Results$Item>?>? results,
  }) {
    return MovieDetails$Releases(
      results: (results != null ? results.value : this.results),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class MovieDetails$Credits {
  const MovieDetails$Credits({this.cast, this.crew});

  factory MovieDetails$Credits.fromJson(Map<String, dynamic> json) =>
      _$MovieDetails$CreditsFromJson(json);

  static const toJsonFactory = _$MovieDetails$CreditsToJson;
  Map<String, dynamic> toJson() => _$MovieDetails$CreditsToJson(this);

  @JsonKey(name: 'cast', includeIfNull: false, defaultValue: <Cast>[])
  final List<Cast>? cast;
  @JsonKey(name: 'crew', includeIfNull: false, defaultValue: <Crew>[])
  final List<Crew>? crew;
  static const fromJsonFactory = _$MovieDetails$CreditsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MovieDetails$Credits &&
            (identical(other.cast, cast) ||
                const DeepCollectionEquality().equals(other.cast, cast)) &&
            (identical(other.crew, crew) ||
                const DeepCollectionEquality().equals(other.crew, crew)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(cast) ^
      const DeepCollectionEquality().hash(crew) ^
      runtimeType.hashCode;
}

extension $MovieDetails$CreditsExtension on MovieDetails$Credits {
  MovieDetails$Credits copyWith({List<Cast>? cast, List<Crew>? crew}) {
    return MovieDetails$Credits(
      cast: cast ?? this.cast,
      crew: crew ?? this.crew,
    );
  }

  MovieDetails$Credits copyWithWrapped({
    Wrapped<List<Cast>?>? cast,
    Wrapped<List<Crew>?>? crew,
  }) {
    return MovieDetails$Credits(
      cast: (cast != null ? cast.value : this.cast),
      crew: (crew != null ? crew.value : this.crew),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class MovieDetails$Collection {
  const MovieDetails$Collection({
    this.id,
    this.name,
    this.posterPath,
    this.backdropPath,
  });

  factory MovieDetails$Collection.fromJson(Map<String, dynamic> json) =>
      _$MovieDetails$CollectionFromJson(json);

  static const toJsonFactory = _$MovieDetails$CollectionToJson;
  Map<String, dynamic> toJson() => _$MovieDetails$CollectionToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final double? id;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(name: 'posterPath', includeIfNull: false)
  final String? posterPath;
  @JsonKey(name: 'backdropPath', includeIfNull: false)
  final String? backdropPath;
  static const fromJsonFactory = _$MovieDetails$CollectionFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MovieDetails$Collection &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.posterPath, posterPath) ||
                const DeepCollectionEquality().equals(
                  other.posterPath,
                  posterPath,
                )) &&
            (identical(other.backdropPath, backdropPath) ||
                const DeepCollectionEquality().equals(
                  other.backdropPath,
                  backdropPath,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(posterPath) ^
      const DeepCollectionEquality().hash(backdropPath) ^
      runtimeType.hashCode;
}

extension $MovieDetails$CollectionExtension on MovieDetails$Collection {
  MovieDetails$Collection copyWith({
    double? id,
    String? name,
    String? posterPath,
    String? backdropPath,
  }) {
    return MovieDetails$Collection(
      id: id ?? this.id,
      name: name ?? this.name,
      posterPath: posterPath ?? this.posterPath,
      backdropPath: backdropPath ?? this.backdropPath,
    );
  }

  MovieDetails$Collection copyWithWrapped({
    Wrapped<double?>? id,
    Wrapped<String?>? name,
    Wrapped<String?>? posterPath,
    Wrapped<String?>? backdropPath,
  }) {
    return MovieDetails$Collection(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
      posterPath: (posterPath != null ? posterPath.value : this.posterPath),
      backdropPath: (backdropPath != null
          ? backdropPath.value
          : this.backdropPath),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TvDetails$ContentRatings {
  const TvDetails$ContentRatings({this.results});

  factory TvDetails$ContentRatings.fromJson(Map<String, dynamic> json) =>
      _$TvDetails$ContentRatingsFromJson(json);

  static const toJsonFactory = _$TvDetails$ContentRatingsToJson;
  Map<String, dynamic> toJson() => _$TvDetails$ContentRatingsToJson(this);

  @JsonKey(name: 'results', includeIfNull: false)
  final List<TvDetails$ContentRatings$Results$Item>? results;
  static const fromJsonFactory = _$TvDetails$ContentRatingsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TvDetails$ContentRatings &&
            (identical(other.results, results) ||
                const DeepCollectionEquality().equals(other.results, results)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(results) ^ runtimeType.hashCode;
}

extension $TvDetails$ContentRatingsExtension on TvDetails$ContentRatings {
  TvDetails$ContentRatings copyWith({
    List<TvDetails$ContentRatings$Results$Item>? results,
  }) {
    return TvDetails$ContentRatings(results: results ?? this.results);
  }

  TvDetails$ContentRatings copyWithWrapped({
    Wrapped<List<TvDetails$ContentRatings$Results$Item>?>? results,
  }) {
    return TvDetails$ContentRatings(
      results: (results != null ? results.value : this.results),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TvDetails$CreatedBy$Item {
  const TvDetails$CreatedBy$Item({
    this.id,
    this.name,
    this.gender,
    this.profilePath,
  });

  factory TvDetails$CreatedBy$Item.fromJson(Map<String, dynamic> json) =>
      _$TvDetails$CreatedBy$ItemFromJson(json);

  static const toJsonFactory = _$TvDetails$CreatedBy$ItemToJson;
  Map<String, dynamic> toJson() => _$TvDetails$CreatedBy$ItemToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final double? id;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(name: 'gender', includeIfNull: false)
  final double? gender;
  @JsonKey(name: 'profilePath', includeIfNull: false)
  final String? profilePath;
  static const fromJsonFactory = _$TvDetails$CreatedBy$ItemFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TvDetails$CreatedBy$Item &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.gender, gender) ||
                const DeepCollectionEquality().equals(other.gender, gender)) &&
            (identical(other.profilePath, profilePath) ||
                const DeepCollectionEquality().equals(
                  other.profilePath,
                  profilePath,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(gender) ^
      const DeepCollectionEquality().hash(profilePath) ^
      runtimeType.hashCode;
}

extension $TvDetails$CreatedBy$ItemExtension on TvDetails$CreatedBy$Item {
  TvDetails$CreatedBy$Item copyWith({
    double? id,
    String? name,
    double? gender,
    String? profilePath,
  }) {
    return TvDetails$CreatedBy$Item(
      id: id ?? this.id,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      profilePath: profilePath ?? this.profilePath,
    );
  }

  TvDetails$CreatedBy$Item copyWithWrapped({
    Wrapped<double?>? id,
    Wrapped<String?>? name,
    Wrapped<double?>? gender,
    Wrapped<String?>? profilePath,
  }) {
    return TvDetails$CreatedBy$Item(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
      gender: (gender != null ? gender.value : this.gender),
      profilePath: (profilePath != null ? profilePath.value : this.profilePath),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TvDetails$ProductionCountries$Item {
  const TvDetails$ProductionCountries$Item({this.iso31661, this.name});

  factory TvDetails$ProductionCountries$Item.fromJson(
    Map<String, dynamic> json,
  ) => _$TvDetails$ProductionCountries$ItemFromJson(json);

  static const toJsonFactory = _$TvDetails$ProductionCountries$ItemToJson;
  Map<String, dynamic> toJson() =>
      _$TvDetails$ProductionCountries$ItemToJson(this);

  @JsonKey(name: 'iso_3166_1', includeIfNull: false)
  final String? iso31661;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  static const fromJsonFactory = _$TvDetails$ProductionCountries$ItemFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TvDetails$ProductionCountries$Item &&
            (identical(other.iso31661, iso31661) ||
                const DeepCollectionEquality().equals(
                  other.iso31661,
                  iso31661,
                )) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(iso31661) ^
      const DeepCollectionEquality().hash(name) ^
      runtimeType.hashCode;
}

extension $TvDetails$ProductionCountries$ItemExtension
    on TvDetails$ProductionCountries$Item {
  TvDetails$ProductionCountries$Item copyWith({
    String? iso31661,
    String? name,
  }) {
    return TvDetails$ProductionCountries$Item(
      iso31661: iso31661 ?? this.iso31661,
      name: name ?? this.name,
    );
  }

  TvDetails$ProductionCountries$Item copyWithWrapped({
    Wrapped<String?>? iso31661,
    Wrapped<String?>? name,
  }) {
    return TvDetails$ProductionCountries$Item(
      iso31661: (iso31661 != null ? iso31661.value : this.iso31661),
      name: (name != null ? name.value : this.name),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TvDetails$Credits {
  const TvDetails$Credits({this.cast, this.crew});

  factory TvDetails$Credits.fromJson(Map<String, dynamic> json) =>
      _$TvDetails$CreditsFromJson(json);

  static const toJsonFactory = _$TvDetails$CreditsToJson;
  Map<String, dynamic> toJson() => _$TvDetails$CreditsToJson(this);

  @JsonKey(name: 'cast', includeIfNull: false, defaultValue: <Cast>[])
  final List<Cast>? cast;
  @JsonKey(name: 'crew', includeIfNull: false, defaultValue: <Crew>[])
  final List<Crew>? crew;
  static const fromJsonFactory = _$TvDetails$CreditsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TvDetails$Credits &&
            (identical(other.cast, cast) ||
                const DeepCollectionEquality().equals(other.cast, cast)) &&
            (identical(other.crew, crew) ||
                const DeepCollectionEquality().equals(other.crew, crew)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(cast) ^
      const DeepCollectionEquality().hash(crew) ^
      runtimeType.hashCode;
}

extension $TvDetails$CreditsExtension on TvDetails$Credits {
  TvDetails$Credits copyWith({List<Cast>? cast, List<Crew>? crew}) {
    return TvDetails$Credits(cast: cast ?? this.cast, crew: crew ?? this.crew);
  }

  TvDetails$Credits copyWithWrapped({
    Wrapped<List<Cast>?>? cast,
    Wrapped<List<Crew>?>? crew,
  }) {
    return TvDetails$Credits(
      cast: (cast != null ? cast.value : this.cast),
      crew: (crew != null ? crew.value : this.crew),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class DiscordSettings$Options {
  const DiscordSettings$Options({
    this.botUsername,
    this.botAvatarUrl,
    this.webhookUrl,
    this.webhookRoleId,
    this.enableMentions,
  });

  factory DiscordSettings$Options.fromJson(Map<String, dynamic> json) =>
      _$DiscordSettings$OptionsFromJson(json);

  static const toJsonFactory = _$DiscordSettings$OptionsToJson;
  Map<String, dynamic> toJson() => _$DiscordSettings$OptionsToJson(this);

  @JsonKey(name: 'botUsername', includeIfNull: false)
  final String? botUsername;
  @JsonKey(name: 'botAvatarUrl', includeIfNull: false)
  final String? botAvatarUrl;
  @JsonKey(name: 'webhookUrl', includeIfNull: false)
  final String? webhookUrl;
  @JsonKey(name: 'webhookRoleId', includeIfNull: false)
  final String? webhookRoleId;
  @JsonKey(name: 'enableMentions', includeIfNull: false)
  final bool? enableMentions;
  static const fromJsonFactory = _$DiscordSettings$OptionsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is DiscordSettings$Options &&
            (identical(other.botUsername, botUsername) ||
                const DeepCollectionEquality().equals(
                  other.botUsername,
                  botUsername,
                )) &&
            (identical(other.botAvatarUrl, botAvatarUrl) ||
                const DeepCollectionEquality().equals(
                  other.botAvatarUrl,
                  botAvatarUrl,
                )) &&
            (identical(other.webhookUrl, webhookUrl) ||
                const DeepCollectionEquality().equals(
                  other.webhookUrl,
                  webhookUrl,
                )) &&
            (identical(other.webhookRoleId, webhookRoleId) ||
                const DeepCollectionEquality().equals(
                  other.webhookRoleId,
                  webhookRoleId,
                )) &&
            (identical(other.enableMentions, enableMentions) ||
                const DeepCollectionEquality().equals(
                  other.enableMentions,
                  enableMentions,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(botUsername) ^
      const DeepCollectionEquality().hash(botAvatarUrl) ^
      const DeepCollectionEquality().hash(webhookUrl) ^
      const DeepCollectionEquality().hash(webhookRoleId) ^
      const DeepCollectionEquality().hash(enableMentions) ^
      runtimeType.hashCode;
}

extension $DiscordSettings$OptionsExtension on DiscordSettings$Options {
  DiscordSettings$Options copyWith({
    String? botUsername,
    String? botAvatarUrl,
    String? webhookUrl,
    String? webhookRoleId,
    bool? enableMentions,
  }) {
    return DiscordSettings$Options(
      botUsername: botUsername ?? this.botUsername,
      botAvatarUrl: botAvatarUrl ?? this.botAvatarUrl,
      webhookUrl: webhookUrl ?? this.webhookUrl,
      webhookRoleId: webhookRoleId ?? this.webhookRoleId,
      enableMentions: enableMentions ?? this.enableMentions,
    );
  }

  DiscordSettings$Options copyWithWrapped({
    Wrapped<String?>? botUsername,
    Wrapped<String?>? botAvatarUrl,
    Wrapped<String?>? webhookUrl,
    Wrapped<String?>? webhookRoleId,
    Wrapped<bool?>? enableMentions,
  }) {
    return DiscordSettings$Options(
      botUsername: (botUsername != null ? botUsername.value : this.botUsername),
      botAvatarUrl: (botAvatarUrl != null
          ? botAvatarUrl.value
          : this.botAvatarUrl),
      webhookUrl: (webhookUrl != null ? webhookUrl.value : this.webhookUrl),
      webhookRoleId: (webhookRoleId != null
          ? webhookRoleId.value
          : this.webhookRoleId),
      enableMentions: (enableMentions != null
          ? enableMentions.value
          : this.enableMentions),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SlackSettings$Options {
  const SlackSettings$Options({this.webhookUrl});

  factory SlackSettings$Options.fromJson(Map<String, dynamic> json) =>
      _$SlackSettings$OptionsFromJson(json);

  static const toJsonFactory = _$SlackSettings$OptionsToJson;
  Map<String, dynamic> toJson() => _$SlackSettings$OptionsToJson(this);

  @JsonKey(name: 'webhookUrl', includeIfNull: false)
  final String? webhookUrl;
  static const fromJsonFactory = _$SlackSettings$OptionsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SlackSettings$Options &&
            (identical(other.webhookUrl, webhookUrl) ||
                const DeepCollectionEquality().equals(
                  other.webhookUrl,
                  webhookUrl,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(webhookUrl) ^ runtimeType.hashCode;
}

extension $SlackSettings$OptionsExtension on SlackSettings$Options {
  SlackSettings$Options copyWith({String? webhookUrl}) {
    return SlackSettings$Options(webhookUrl: webhookUrl ?? this.webhookUrl);
  }

  SlackSettings$Options copyWithWrapped({Wrapped<String?>? webhookUrl}) {
    return SlackSettings$Options(
      webhookUrl: (webhookUrl != null ? webhookUrl.value : this.webhookUrl),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class WebhookSettings$Options {
  const WebhookSettings$Options({
    this.webhookUrl,
    this.authHeader,
    this.jsonPayload,
    this.supportVariables,
  });

  factory WebhookSettings$Options.fromJson(Map<String, dynamic> json) =>
      _$WebhookSettings$OptionsFromJson(json);

  static const toJsonFactory = _$WebhookSettings$OptionsToJson;
  Map<String, dynamic> toJson() => _$WebhookSettings$OptionsToJson(this);

  @JsonKey(name: 'webhookUrl', includeIfNull: false)
  final String? webhookUrl;
  @JsonKey(name: 'authHeader', includeIfNull: false)
  final String? authHeader;
  @JsonKey(name: 'jsonPayload', includeIfNull: false)
  final String? jsonPayload;
  @JsonKey(name: 'supportVariables', includeIfNull: false)
  final bool? supportVariables;
  static const fromJsonFactory = _$WebhookSettings$OptionsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is WebhookSettings$Options &&
            (identical(other.webhookUrl, webhookUrl) ||
                const DeepCollectionEquality().equals(
                  other.webhookUrl,
                  webhookUrl,
                )) &&
            (identical(other.authHeader, authHeader) ||
                const DeepCollectionEquality().equals(
                  other.authHeader,
                  authHeader,
                )) &&
            (identical(other.jsonPayload, jsonPayload) ||
                const DeepCollectionEquality().equals(
                  other.jsonPayload,
                  jsonPayload,
                )) &&
            (identical(other.supportVariables, supportVariables) ||
                const DeepCollectionEquality().equals(
                  other.supportVariables,
                  supportVariables,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(webhookUrl) ^
      const DeepCollectionEquality().hash(authHeader) ^
      const DeepCollectionEquality().hash(jsonPayload) ^
      const DeepCollectionEquality().hash(supportVariables) ^
      runtimeType.hashCode;
}

extension $WebhookSettings$OptionsExtension on WebhookSettings$Options {
  WebhookSettings$Options copyWith({
    String? webhookUrl,
    String? authHeader,
    String? jsonPayload,
    bool? supportVariables,
  }) {
    return WebhookSettings$Options(
      webhookUrl: webhookUrl ?? this.webhookUrl,
      authHeader: authHeader ?? this.authHeader,
      jsonPayload: jsonPayload ?? this.jsonPayload,
      supportVariables: supportVariables ?? this.supportVariables,
    );
  }

  WebhookSettings$Options copyWithWrapped({
    Wrapped<String?>? webhookUrl,
    Wrapped<String?>? authHeader,
    Wrapped<String?>? jsonPayload,
    Wrapped<bool?>? supportVariables,
  }) {
    return WebhookSettings$Options(
      webhookUrl: (webhookUrl != null ? webhookUrl.value : this.webhookUrl),
      authHeader: (authHeader != null ? authHeader.value : this.authHeader),
      jsonPayload: (jsonPayload != null ? jsonPayload.value : this.jsonPayload),
      supportVariables: (supportVariables != null
          ? supportVariables.value
          : this.supportVariables),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TelegramSettings$Options {
  const TelegramSettings$Options({
    this.botUsername,
    this.botAPI,
    this.chatId,
    this.messageThreadId,
    this.sendSilently,
  });

  factory TelegramSettings$Options.fromJson(Map<String, dynamic> json) =>
      _$TelegramSettings$OptionsFromJson(json);

  static const toJsonFactory = _$TelegramSettings$OptionsToJson;
  Map<String, dynamic> toJson() => _$TelegramSettings$OptionsToJson(this);

  @JsonKey(name: 'botUsername', includeIfNull: false)
  final String? botUsername;
  @JsonKey(name: 'botAPI', includeIfNull: false)
  final String? botAPI;
  @JsonKey(name: 'chatId', includeIfNull: false)
  final String? chatId;
  @JsonKey(name: 'messageThreadId', includeIfNull: false)
  final String? messageThreadId;
  @JsonKey(name: 'sendSilently', includeIfNull: false)
  final bool? sendSilently;
  static const fromJsonFactory = _$TelegramSettings$OptionsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TelegramSettings$Options &&
            (identical(other.botUsername, botUsername) ||
                const DeepCollectionEquality().equals(
                  other.botUsername,
                  botUsername,
                )) &&
            (identical(other.botAPI, botAPI) ||
                const DeepCollectionEquality().equals(other.botAPI, botAPI)) &&
            (identical(other.chatId, chatId) ||
                const DeepCollectionEquality().equals(other.chatId, chatId)) &&
            (identical(other.messageThreadId, messageThreadId) ||
                const DeepCollectionEquality().equals(
                  other.messageThreadId,
                  messageThreadId,
                )) &&
            (identical(other.sendSilently, sendSilently) ||
                const DeepCollectionEquality().equals(
                  other.sendSilently,
                  sendSilently,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(botUsername) ^
      const DeepCollectionEquality().hash(botAPI) ^
      const DeepCollectionEquality().hash(chatId) ^
      const DeepCollectionEquality().hash(messageThreadId) ^
      const DeepCollectionEquality().hash(sendSilently) ^
      runtimeType.hashCode;
}

extension $TelegramSettings$OptionsExtension on TelegramSettings$Options {
  TelegramSettings$Options copyWith({
    String? botUsername,
    String? botAPI,
    String? chatId,
    String? messageThreadId,
    bool? sendSilently,
  }) {
    return TelegramSettings$Options(
      botUsername: botUsername ?? this.botUsername,
      botAPI: botAPI ?? this.botAPI,
      chatId: chatId ?? this.chatId,
      messageThreadId: messageThreadId ?? this.messageThreadId,
      sendSilently: sendSilently ?? this.sendSilently,
    );
  }

  TelegramSettings$Options copyWithWrapped({
    Wrapped<String?>? botUsername,
    Wrapped<String?>? botAPI,
    Wrapped<String?>? chatId,
    Wrapped<String?>? messageThreadId,
    Wrapped<bool?>? sendSilently,
  }) {
    return TelegramSettings$Options(
      botUsername: (botUsername != null ? botUsername.value : this.botUsername),
      botAPI: (botAPI != null ? botAPI.value : this.botAPI),
      chatId: (chatId != null ? chatId.value : this.chatId),
      messageThreadId: (messageThreadId != null
          ? messageThreadId.value
          : this.messageThreadId),
      sendSilently: (sendSilently != null
          ? sendSilently.value
          : this.sendSilently),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PushbulletSettings$Options {
  const PushbulletSettings$Options({this.accessToken, this.channelTag});

  factory PushbulletSettings$Options.fromJson(Map<String, dynamic> json) =>
      _$PushbulletSettings$OptionsFromJson(json);

  static const toJsonFactory = _$PushbulletSettings$OptionsToJson;
  Map<String, dynamic> toJson() => _$PushbulletSettings$OptionsToJson(this);

  @JsonKey(name: 'accessToken', includeIfNull: false)
  final String? accessToken;
  @JsonKey(name: 'channelTag', includeIfNull: false)
  final String? channelTag;
  static const fromJsonFactory = _$PushbulletSettings$OptionsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PushbulletSettings$Options &&
            (identical(other.accessToken, accessToken) ||
                const DeepCollectionEquality().equals(
                  other.accessToken,
                  accessToken,
                )) &&
            (identical(other.channelTag, channelTag) ||
                const DeepCollectionEquality().equals(
                  other.channelTag,
                  channelTag,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(accessToken) ^
      const DeepCollectionEquality().hash(channelTag) ^
      runtimeType.hashCode;
}

extension $PushbulletSettings$OptionsExtension on PushbulletSettings$Options {
  PushbulletSettings$Options copyWith({
    String? accessToken,
    String? channelTag,
  }) {
    return PushbulletSettings$Options(
      accessToken: accessToken ?? this.accessToken,
      channelTag: channelTag ?? this.channelTag,
    );
  }

  PushbulletSettings$Options copyWithWrapped({
    Wrapped<String?>? accessToken,
    Wrapped<String?>? channelTag,
  }) {
    return PushbulletSettings$Options(
      accessToken: (accessToken != null ? accessToken.value : this.accessToken),
      channelTag: (channelTag != null ? channelTag.value : this.channelTag),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PushoverSettings$Options {
  const PushoverSettings$Options({
    this.accessToken,
    this.userToken,
    this.sound,
  });

  factory PushoverSettings$Options.fromJson(Map<String, dynamic> json) =>
      _$PushoverSettings$OptionsFromJson(json);

  static const toJsonFactory = _$PushoverSettings$OptionsToJson;
  Map<String, dynamic> toJson() => _$PushoverSettings$OptionsToJson(this);

  @JsonKey(name: 'accessToken', includeIfNull: false)
  final String? accessToken;
  @JsonKey(name: 'userToken', includeIfNull: false)
  final String? userToken;
  @JsonKey(name: 'sound', includeIfNull: false)
  final String? sound;
  static const fromJsonFactory = _$PushoverSettings$OptionsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PushoverSettings$Options &&
            (identical(other.accessToken, accessToken) ||
                const DeepCollectionEquality().equals(
                  other.accessToken,
                  accessToken,
                )) &&
            (identical(other.userToken, userToken) ||
                const DeepCollectionEquality().equals(
                  other.userToken,
                  userToken,
                )) &&
            (identical(other.sound, sound) ||
                const DeepCollectionEquality().equals(other.sound, sound)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(accessToken) ^
      const DeepCollectionEquality().hash(userToken) ^
      const DeepCollectionEquality().hash(sound) ^
      runtimeType.hashCode;
}

extension $PushoverSettings$OptionsExtension on PushoverSettings$Options {
  PushoverSettings$Options copyWith({
    String? accessToken,
    String? userToken,
    String? sound,
  }) {
    return PushoverSettings$Options(
      accessToken: accessToken ?? this.accessToken,
      userToken: userToken ?? this.userToken,
      sound: sound ?? this.sound,
    );
  }

  PushoverSettings$Options copyWithWrapped({
    Wrapped<String?>? accessToken,
    Wrapped<String?>? userToken,
    Wrapped<String?>? sound,
  }) {
    return PushoverSettings$Options(
      accessToken: (accessToken != null ? accessToken.value : this.accessToken),
      userToken: (userToken != null ? userToken.value : this.userToken),
      sound: (sound != null ? sound.value : this.sound),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class GotifySettings$Options {
  const GotifySettings$Options({this.url, this.token});

  factory GotifySettings$Options.fromJson(Map<String, dynamic> json) =>
      _$GotifySettings$OptionsFromJson(json);

  static const toJsonFactory = _$GotifySettings$OptionsToJson;
  Map<String, dynamic> toJson() => _$GotifySettings$OptionsToJson(this);

  @JsonKey(name: 'url', includeIfNull: false)
  final String? url;
  @JsonKey(name: 'token', includeIfNull: false)
  final String? token;
  static const fromJsonFactory = _$GotifySettings$OptionsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is GotifySettings$Options &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.token, token) ||
                const DeepCollectionEquality().equals(other.token, token)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(url) ^
      const DeepCollectionEquality().hash(token) ^
      runtimeType.hashCode;
}

extension $GotifySettings$OptionsExtension on GotifySettings$Options {
  GotifySettings$Options copyWith({String? url, String? token}) {
    return GotifySettings$Options(
      url: url ?? this.url,
      token: token ?? this.token,
    );
  }

  GotifySettings$Options copyWithWrapped({
    Wrapped<String?>? url,
    Wrapped<String?>? token,
  }) {
    return GotifySettings$Options(
      url: (url != null ? url.value : this.url),
      token: (token != null ? token.value : this.token),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class NtfySettings$Options {
  const NtfySettings$Options({
    this.url,
    this.topic,
    this.authMethodUsernamePassword,
    this.username,
    this.password,
    this.authMethodToken,
    this.token,
  });

  factory NtfySettings$Options.fromJson(Map<String, dynamic> json) =>
      _$NtfySettings$OptionsFromJson(json);

  static const toJsonFactory = _$NtfySettings$OptionsToJson;
  Map<String, dynamic> toJson() => _$NtfySettings$OptionsToJson(this);

  @JsonKey(name: 'url', includeIfNull: false)
  final String? url;
  @JsonKey(name: 'topic', includeIfNull: false)
  final String? topic;
  @JsonKey(name: 'authMethodUsernamePassword', includeIfNull: false)
  final bool? authMethodUsernamePassword;
  @JsonKey(name: 'username', includeIfNull: false)
  final String? username;
  @JsonKey(name: 'password', includeIfNull: false)
  final String? password;
  @JsonKey(name: 'authMethodToken', includeIfNull: false)
  final bool? authMethodToken;
  @JsonKey(name: 'token', includeIfNull: false)
  final String? token;
  static const fromJsonFactory = _$NtfySettings$OptionsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is NtfySettings$Options &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.topic, topic) ||
                const DeepCollectionEquality().equals(other.topic, topic)) &&
            (identical(
                  other.authMethodUsernamePassword,
                  authMethodUsernamePassword,
                ) ||
                const DeepCollectionEquality().equals(
                  other.authMethodUsernamePassword,
                  authMethodUsernamePassword,
                )) &&
            (identical(other.username, username) ||
                const DeepCollectionEquality().equals(
                  other.username,
                  username,
                )) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality().equals(
                  other.password,
                  password,
                )) &&
            (identical(other.authMethodToken, authMethodToken) ||
                const DeepCollectionEquality().equals(
                  other.authMethodToken,
                  authMethodToken,
                )) &&
            (identical(other.token, token) ||
                const DeepCollectionEquality().equals(other.token, token)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(url) ^
      const DeepCollectionEquality().hash(topic) ^
      const DeepCollectionEquality().hash(authMethodUsernamePassword) ^
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(password) ^
      const DeepCollectionEquality().hash(authMethodToken) ^
      const DeepCollectionEquality().hash(token) ^
      runtimeType.hashCode;
}

extension $NtfySettings$OptionsExtension on NtfySettings$Options {
  NtfySettings$Options copyWith({
    String? url,
    String? topic,
    bool? authMethodUsernamePassword,
    String? username,
    String? password,
    bool? authMethodToken,
    String? token,
  }) {
    return NtfySettings$Options(
      url: url ?? this.url,
      topic: topic ?? this.topic,
      authMethodUsernamePassword:
          authMethodUsernamePassword ?? this.authMethodUsernamePassword,
      username: username ?? this.username,
      password: password ?? this.password,
      authMethodToken: authMethodToken ?? this.authMethodToken,
      token: token ?? this.token,
    );
  }

  NtfySettings$Options copyWithWrapped({
    Wrapped<String?>? url,
    Wrapped<String?>? topic,
    Wrapped<bool?>? authMethodUsernamePassword,
    Wrapped<String?>? username,
    Wrapped<String?>? password,
    Wrapped<bool?>? authMethodToken,
    Wrapped<String?>? token,
  }) {
    return NtfySettings$Options(
      url: (url != null ? url.value : this.url),
      topic: (topic != null ? topic.value : this.topic),
      authMethodUsernamePassword: (authMethodUsernamePassword != null
          ? authMethodUsernamePassword.value
          : this.authMethodUsernamePassword),
      username: (username != null ? username.value : this.username),
      password: (password != null ? password.value : this.password),
      authMethodToken: (authMethodToken != null
          ? authMethodToken.value
          : this.authMethodToken),
      token: (token != null ? token.value : this.token),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class NotificationEmailSettings$Options {
  const NotificationEmailSettings$Options({
    this.emailFrom,
    this.senderName,
    this.smtpHost,
    this.smtpPort,
    this.secure,
    this.ignoreTls,
    this.requireTls,
    this.authUser,
    this.authPass,
    this.allowSelfSigned,
  });

  factory NotificationEmailSettings$Options.fromJson(
    Map<String, dynamic> json,
  ) => _$NotificationEmailSettings$OptionsFromJson(json);

  static const toJsonFactory = _$NotificationEmailSettings$OptionsToJson;
  Map<String, dynamic> toJson() =>
      _$NotificationEmailSettings$OptionsToJson(this);

  @JsonKey(name: 'emailFrom', includeIfNull: false)
  final String? emailFrom;
  @JsonKey(name: 'senderName', includeIfNull: false)
  final String? senderName;
  @JsonKey(name: 'smtpHost', includeIfNull: false)
  final String? smtpHost;
  @JsonKey(name: 'smtpPort', includeIfNull: false)
  final double? smtpPort;
  @JsonKey(name: 'secure', includeIfNull: false)
  final bool? secure;
  @JsonKey(name: 'ignoreTls', includeIfNull: false)
  final bool? ignoreTls;
  @JsonKey(name: 'requireTls', includeIfNull: false)
  final bool? requireTls;
  @JsonKey(name: 'authUser', includeIfNull: false)
  final String? authUser;
  @JsonKey(name: 'authPass', includeIfNull: false)
  final String? authPass;
  @JsonKey(name: 'allowSelfSigned', includeIfNull: false)
  final bool? allowSelfSigned;
  static const fromJsonFactory = _$NotificationEmailSettings$OptionsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is NotificationEmailSettings$Options &&
            (identical(other.emailFrom, emailFrom) ||
                const DeepCollectionEquality().equals(
                  other.emailFrom,
                  emailFrom,
                )) &&
            (identical(other.senderName, senderName) ||
                const DeepCollectionEquality().equals(
                  other.senderName,
                  senderName,
                )) &&
            (identical(other.smtpHost, smtpHost) ||
                const DeepCollectionEquality().equals(
                  other.smtpHost,
                  smtpHost,
                )) &&
            (identical(other.smtpPort, smtpPort) ||
                const DeepCollectionEquality().equals(
                  other.smtpPort,
                  smtpPort,
                )) &&
            (identical(other.secure, secure) ||
                const DeepCollectionEquality().equals(other.secure, secure)) &&
            (identical(other.ignoreTls, ignoreTls) ||
                const DeepCollectionEquality().equals(
                  other.ignoreTls,
                  ignoreTls,
                )) &&
            (identical(other.requireTls, requireTls) ||
                const DeepCollectionEquality().equals(
                  other.requireTls,
                  requireTls,
                )) &&
            (identical(other.authUser, authUser) ||
                const DeepCollectionEquality().equals(
                  other.authUser,
                  authUser,
                )) &&
            (identical(other.authPass, authPass) ||
                const DeepCollectionEquality().equals(
                  other.authPass,
                  authPass,
                )) &&
            (identical(other.allowSelfSigned, allowSelfSigned) ||
                const DeepCollectionEquality().equals(
                  other.allowSelfSigned,
                  allowSelfSigned,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(emailFrom) ^
      const DeepCollectionEquality().hash(senderName) ^
      const DeepCollectionEquality().hash(smtpHost) ^
      const DeepCollectionEquality().hash(smtpPort) ^
      const DeepCollectionEquality().hash(secure) ^
      const DeepCollectionEquality().hash(ignoreTls) ^
      const DeepCollectionEquality().hash(requireTls) ^
      const DeepCollectionEquality().hash(authUser) ^
      const DeepCollectionEquality().hash(authPass) ^
      const DeepCollectionEquality().hash(allowSelfSigned) ^
      runtimeType.hashCode;
}

extension $NotificationEmailSettings$OptionsExtension
    on NotificationEmailSettings$Options {
  NotificationEmailSettings$Options copyWith({
    String? emailFrom,
    String? senderName,
    String? smtpHost,
    double? smtpPort,
    bool? secure,
    bool? ignoreTls,
    bool? requireTls,
    String? authUser,
    String? authPass,
    bool? allowSelfSigned,
  }) {
    return NotificationEmailSettings$Options(
      emailFrom: emailFrom ?? this.emailFrom,
      senderName: senderName ?? this.senderName,
      smtpHost: smtpHost ?? this.smtpHost,
      smtpPort: smtpPort ?? this.smtpPort,
      secure: secure ?? this.secure,
      ignoreTls: ignoreTls ?? this.ignoreTls,
      requireTls: requireTls ?? this.requireTls,
      authUser: authUser ?? this.authUser,
      authPass: authPass ?? this.authPass,
      allowSelfSigned: allowSelfSigned ?? this.allowSelfSigned,
    );
  }

  NotificationEmailSettings$Options copyWithWrapped({
    Wrapped<String?>? emailFrom,
    Wrapped<String?>? senderName,
    Wrapped<String?>? smtpHost,
    Wrapped<double?>? smtpPort,
    Wrapped<bool?>? secure,
    Wrapped<bool?>? ignoreTls,
    Wrapped<bool?>? requireTls,
    Wrapped<String?>? authUser,
    Wrapped<String?>? authPass,
    Wrapped<bool?>? allowSelfSigned,
  }) {
    return NotificationEmailSettings$Options(
      emailFrom: (emailFrom != null ? emailFrom.value : this.emailFrom),
      senderName: (senderName != null ? senderName.value : this.senderName),
      smtpHost: (smtpHost != null ? smtpHost.value : this.smtpHost),
      smtpPort: (smtpPort != null ? smtpPort.value : this.smtpPort),
      secure: (secure != null ? secure.value : this.secure),
      ignoreTls: (ignoreTls != null ? ignoreTls.value : this.ignoreTls),
      requireTls: (requireTls != null ? requireTls.value : this.requireTls),
      authUser: (authUser != null ? authUser.value : this.authUser),
      authPass: (authPass != null ? authPass.value : this.authPass),
      allowSelfSigned: (allowSelfSigned != null
          ? allowSelfSigned.value
          : this.allowSelfSigned),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SonarrSeries$Images$Item {
  const SonarrSeries$Images$Item({this.coverType, this.url});

  factory SonarrSeries$Images$Item.fromJson(Map<String, dynamic> json) =>
      _$SonarrSeries$Images$ItemFromJson(json);

  static const toJsonFactory = _$SonarrSeries$Images$ItemToJson;
  Map<String, dynamic> toJson() => _$SonarrSeries$Images$ItemToJson(this);

  @JsonKey(name: 'coverType', includeIfNull: false)
  final String? coverType;
  @JsonKey(name: 'url', includeIfNull: false)
  final String? url;
  static const fromJsonFactory = _$SonarrSeries$Images$ItemFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SonarrSeries$Images$Item &&
            (identical(other.coverType, coverType) ||
                const DeepCollectionEquality().equals(
                  other.coverType,
                  coverType,
                )) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(coverType) ^
      const DeepCollectionEquality().hash(url) ^
      runtimeType.hashCode;
}

extension $SonarrSeries$Images$ItemExtension on SonarrSeries$Images$Item {
  SonarrSeries$Images$Item copyWith({String? coverType, String? url}) {
    return SonarrSeries$Images$Item(
      coverType: coverType ?? this.coverType,
      url: url ?? this.url,
    );
  }

  SonarrSeries$Images$Item copyWithWrapped({
    Wrapped<String?>? coverType,
    Wrapped<String?>? url,
  }) {
    return SonarrSeries$Images$Item(
      coverType: (coverType != null ? coverType.value : this.coverType),
      url: (url != null ? url.value : this.url),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SonarrSeries$Seasons$Item {
  const SonarrSeries$Seasons$Item({this.seasonNumber, this.monitored});

  factory SonarrSeries$Seasons$Item.fromJson(Map<String, dynamic> json) =>
      _$SonarrSeries$Seasons$ItemFromJson(json);

  static const toJsonFactory = _$SonarrSeries$Seasons$ItemToJson;
  Map<String, dynamic> toJson() => _$SonarrSeries$Seasons$ItemToJson(this);

  @JsonKey(name: 'seasonNumber', includeIfNull: false)
  final double? seasonNumber;
  @JsonKey(name: 'monitored', includeIfNull: false)
  final bool? monitored;
  static const fromJsonFactory = _$SonarrSeries$Seasons$ItemFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SonarrSeries$Seasons$Item &&
            (identical(other.seasonNumber, seasonNumber) ||
                const DeepCollectionEquality().equals(
                  other.seasonNumber,
                  seasonNumber,
                )) &&
            (identical(other.monitored, monitored) ||
                const DeepCollectionEquality().equals(
                  other.monitored,
                  monitored,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(seasonNumber) ^
      const DeepCollectionEquality().hash(monitored) ^
      runtimeType.hashCode;
}

extension $SonarrSeries$Seasons$ItemExtension on SonarrSeries$Seasons$Item {
  SonarrSeries$Seasons$Item copyWith({double? seasonNumber, bool? monitored}) {
    return SonarrSeries$Seasons$Item(
      seasonNumber: seasonNumber ?? this.seasonNumber,
      monitored: monitored ?? this.monitored,
    );
  }

  SonarrSeries$Seasons$Item copyWithWrapped({
    Wrapped<double?>? seasonNumber,
    Wrapped<bool?>? monitored,
  }) {
    return SonarrSeries$Seasons$Item(
      seasonNumber: (seasonNumber != null
          ? seasonNumber.value
          : this.seasonNumber),
      monitored: (monitored != null ? monitored.value : this.monitored),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SonarrSeries$Ratings$Item {
  const SonarrSeries$Ratings$Item({this.votes, this.$value});

  factory SonarrSeries$Ratings$Item.fromJson(Map<String, dynamic> json) =>
      _$SonarrSeries$Ratings$ItemFromJson(json);

  static const toJsonFactory = _$SonarrSeries$Ratings$ItemToJson;
  Map<String, dynamic> toJson() => _$SonarrSeries$Ratings$ItemToJson(this);

  @JsonKey(name: 'votes', includeIfNull: false)
  final double? votes;
  @JsonKey(name: 'value', includeIfNull: false)
  final double? $value;
  static const fromJsonFactory = _$SonarrSeries$Ratings$ItemFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SonarrSeries$Ratings$Item &&
            (identical(other.votes, votes) ||
                const DeepCollectionEquality().equals(other.votes, votes)) &&
            (identical(other.$value, $value) ||
                const DeepCollectionEquality().equals(other.$value, $value)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(votes) ^
      const DeepCollectionEquality().hash($value) ^
      runtimeType.hashCode;
}

extension $SonarrSeries$Ratings$ItemExtension on SonarrSeries$Ratings$Item {
  SonarrSeries$Ratings$Item copyWith({double? votes, double? $value}) {
    return SonarrSeries$Ratings$Item(
      votes: votes ?? this.votes,
      $value: $value ?? this.$value,
    );
  }

  SonarrSeries$Ratings$Item copyWithWrapped({
    Wrapped<double?>? votes,
    Wrapped<double?>? $value,
  }) {
    return SonarrSeries$Ratings$Item(
      votes: (votes != null ? votes.value : this.votes),
      $value: ($value != null ? $value.value : this.$value),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SonarrSeries$AddOptions$Item {
  const SonarrSeries$AddOptions$Item({
    this.ignoreEpisodesWithFiles,
    this.ignoreEpisodesWithoutFiles,
    this.searchForMissingEpisodes,
  });

  factory SonarrSeries$AddOptions$Item.fromJson(Map<String, dynamic> json) =>
      _$SonarrSeries$AddOptions$ItemFromJson(json);

  static const toJsonFactory = _$SonarrSeries$AddOptions$ItemToJson;
  Map<String, dynamic> toJson() => _$SonarrSeries$AddOptions$ItemToJson(this);

  @JsonKey(name: 'ignoreEpisodesWithFiles', includeIfNull: false)
  final bool? ignoreEpisodesWithFiles;
  @JsonKey(name: 'ignoreEpisodesWithoutFiles', includeIfNull: false)
  final bool? ignoreEpisodesWithoutFiles;
  @JsonKey(name: 'searchForMissingEpisodes', includeIfNull: false)
  final bool? searchForMissingEpisodes;
  static const fromJsonFactory = _$SonarrSeries$AddOptions$ItemFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SonarrSeries$AddOptions$Item &&
            (identical(
                  other.ignoreEpisodesWithFiles,
                  ignoreEpisodesWithFiles,
                ) ||
                const DeepCollectionEquality().equals(
                  other.ignoreEpisodesWithFiles,
                  ignoreEpisodesWithFiles,
                )) &&
            (identical(
                  other.ignoreEpisodesWithoutFiles,
                  ignoreEpisodesWithoutFiles,
                ) ||
                const DeepCollectionEquality().equals(
                  other.ignoreEpisodesWithoutFiles,
                  ignoreEpisodesWithoutFiles,
                )) &&
            (identical(
                  other.searchForMissingEpisodes,
                  searchForMissingEpisodes,
                ) ||
                const DeepCollectionEquality().equals(
                  other.searchForMissingEpisodes,
                  searchForMissingEpisodes,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(ignoreEpisodesWithFiles) ^
      const DeepCollectionEquality().hash(ignoreEpisodesWithoutFiles) ^
      const DeepCollectionEquality().hash(searchForMissingEpisodes) ^
      runtimeType.hashCode;
}

extension $SonarrSeries$AddOptions$ItemExtension
    on SonarrSeries$AddOptions$Item {
  SonarrSeries$AddOptions$Item copyWith({
    bool? ignoreEpisodesWithFiles,
    bool? ignoreEpisodesWithoutFiles,
    bool? searchForMissingEpisodes,
  }) {
    return SonarrSeries$AddOptions$Item(
      ignoreEpisodesWithFiles:
          ignoreEpisodesWithFiles ?? this.ignoreEpisodesWithFiles,
      ignoreEpisodesWithoutFiles:
          ignoreEpisodesWithoutFiles ?? this.ignoreEpisodesWithoutFiles,
      searchForMissingEpisodes:
          searchForMissingEpisodes ?? this.searchForMissingEpisodes,
    );
  }

  SonarrSeries$AddOptions$Item copyWithWrapped({
    Wrapped<bool?>? ignoreEpisodesWithFiles,
    Wrapped<bool?>? ignoreEpisodesWithoutFiles,
    Wrapped<bool?>? searchForMissingEpisodes,
  }) {
    return SonarrSeries$AddOptions$Item(
      ignoreEpisodesWithFiles: (ignoreEpisodesWithFiles != null
          ? ignoreEpisodesWithFiles.value
          : this.ignoreEpisodesWithFiles),
      ignoreEpisodesWithoutFiles: (ignoreEpisodesWithoutFiles != null
          ? ignoreEpisodesWithoutFiles.value
          : this.ignoreEpisodesWithoutFiles),
      searchForMissingEpisodes: (searchForMissingEpisodes != null
          ? searchForMissingEpisodes.value
          : this.searchForMissingEpisodes),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SettingsCacheGet$Response$ImageCache {
  const SettingsCacheGet$Response$ImageCache({this.tmdb, this.avatar});

  factory SettingsCacheGet$Response$ImageCache.fromJson(
    Map<String, dynamic> json,
  ) => _$SettingsCacheGet$Response$ImageCacheFromJson(json);

  static const toJsonFactory = _$SettingsCacheGet$Response$ImageCacheToJson;
  Map<String, dynamic> toJson() =>
      _$SettingsCacheGet$Response$ImageCacheToJson(this);

  @JsonKey(name: 'tmdb', includeIfNull: false)
  final SettingsCacheGet$Response$ImageCache$Tmdb? tmdb;
  @JsonKey(name: 'avatar', includeIfNull: false)
  final SettingsCacheGet$Response$ImageCache$Avatar? avatar;
  static const fromJsonFactory = _$SettingsCacheGet$Response$ImageCacheFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SettingsCacheGet$Response$ImageCache &&
            (identical(other.tmdb, tmdb) ||
                const DeepCollectionEquality().equals(other.tmdb, tmdb)) &&
            (identical(other.avatar, avatar) ||
                const DeepCollectionEquality().equals(other.avatar, avatar)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(tmdb) ^
      const DeepCollectionEquality().hash(avatar) ^
      runtimeType.hashCode;
}

extension $SettingsCacheGet$Response$ImageCacheExtension
    on SettingsCacheGet$Response$ImageCache {
  SettingsCacheGet$Response$ImageCache copyWith({
    SettingsCacheGet$Response$ImageCache$Tmdb? tmdb,
    SettingsCacheGet$Response$ImageCache$Avatar? avatar,
  }) {
    return SettingsCacheGet$Response$ImageCache(
      tmdb: tmdb ?? this.tmdb,
      avatar: avatar ?? this.avatar,
    );
  }

  SettingsCacheGet$Response$ImageCache copyWithWrapped({
    Wrapped<SettingsCacheGet$Response$ImageCache$Tmdb?>? tmdb,
    Wrapped<SettingsCacheGet$Response$ImageCache$Avatar?>? avatar,
  }) {
    return SettingsCacheGet$Response$ImageCache(
      tmdb: (tmdb != null ? tmdb.value : this.tmdb),
      avatar: (avatar != null ? avatar.value : this.avatar),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SettingsCacheGet$Response$DnsCache {
  const SettingsCacheGet$Response$DnsCache({this.stats, this.entries});

  factory SettingsCacheGet$Response$DnsCache.fromJson(
    Map<String, dynamic> json,
  ) => _$SettingsCacheGet$Response$DnsCacheFromJson(json);

  static const toJsonFactory = _$SettingsCacheGet$Response$DnsCacheToJson;
  Map<String, dynamic> toJson() =>
      _$SettingsCacheGet$Response$DnsCacheToJson(this);

  @JsonKey(name: 'stats', includeIfNull: false)
  final SettingsCacheGet$Response$DnsCache$Stats? stats;
  @JsonKey(name: 'entries', includeIfNull: false)
  final Map<String, dynamic>? entries;
  static const fromJsonFactory = _$SettingsCacheGet$Response$DnsCacheFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SettingsCacheGet$Response$DnsCache &&
            (identical(other.stats, stats) ||
                const DeepCollectionEquality().equals(other.stats, stats)) &&
            (identical(other.entries, entries) ||
                const DeepCollectionEquality().equals(other.entries, entries)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(stats) ^
      const DeepCollectionEquality().hash(entries) ^
      runtimeType.hashCode;
}

extension $SettingsCacheGet$Response$DnsCacheExtension
    on SettingsCacheGet$Response$DnsCache {
  SettingsCacheGet$Response$DnsCache copyWith({
    SettingsCacheGet$Response$DnsCache$Stats? stats,
    Map<String, dynamic>? entries,
  }) {
    return SettingsCacheGet$Response$DnsCache(
      stats: stats ?? this.stats,
      entries: entries ?? this.entries,
    );
  }

  SettingsCacheGet$Response$DnsCache copyWithWrapped({
    Wrapped<SettingsCacheGet$Response$DnsCache$Stats?>? stats,
    Wrapped<Map<String, dynamic>?>? entries,
  }) {
    return SettingsCacheGet$Response$DnsCache(
      stats: (stats != null ? stats.value : this.stats),
      entries: (entries != null ? entries.value : this.entries),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SettingsCacheGet$Response$ApiCaches$Item {
  const SettingsCacheGet$Response$ApiCaches$Item({
    this.id,
    this.name,
    this.stats,
  });

  factory SettingsCacheGet$Response$ApiCaches$Item.fromJson(
    Map<String, dynamic> json,
  ) => _$SettingsCacheGet$Response$ApiCaches$ItemFromJson(json);

  static const toJsonFactory = _$SettingsCacheGet$Response$ApiCaches$ItemToJson;
  Map<String, dynamic> toJson() =>
      _$SettingsCacheGet$Response$ApiCaches$ItemToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final String? id;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(name: 'stats', includeIfNull: false)
  final SettingsCacheGet$Response$ApiCaches$Item$Stats? stats;
  static const fromJsonFactory =
      _$SettingsCacheGet$Response$ApiCaches$ItemFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SettingsCacheGet$Response$ApiCaches$Item &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.stats, stats) ||
                const DeepCollectionEquality().equals(other.stats, stats)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(stats) ^
      runtimeType.hashCode;
}

extension $SettingsCacheGet$Response$ApiCaches$ItemExtension
    on SettingsCacheGet$Response$ApiCaches$Item {
  SettingsCacheGet$Response$ApiCaches$Item copyWith({
    String? id,
    String? name,
    SettingsCacheGet$Response$ApiCaches$Item$Stats? stats,
  }) {
    return SettingsCacheGet$Response$ApiCaches$Item(
      id: id ?? this.id,
      name: name ?? this.name,
      stats: stats ?? this.stats,
    );
  }

  SettingsCacheGet$Response$ApiCaches$Item copyWithWrapped({
    Wrapped<String?>? id,
    Wrapped<String?>? name,
    Wrapped<SettingsCacheGet$Response$ApiCaches$Item$Stats?>? stats,
  }) {
    return SettingsCacheGet$Response$ApiCaches$Item(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
      stats: (stats != null ? stats.value : this.stats),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserUserIdQuotaGet$Response$Movie {
  const UserUserIdQuotaGet$Response$Movie({
    this.days,
    this.limit,
    this.used,
    this.remaining,
    this.restricted,
  });

  factory UserUserIdQuotaGet$Response$Movie.fromJson(
    Map<String, dynamic> json,
  ) => _$UserUserIdQuotaGet$Response$MovieFromJson(json);

  static const toJsonFactory = _$UserUserIdQuotaGet$Response$MovieToJson;
  Map<String, dynamic> toJson() =>
      _$UserUserIdQuotaGet$Response$MovieToJson(this);

  @JsonKey(name: 'days', includeIfNull: false)
  final double? days;
  @JsonKey(name: 'limit', includeIfNull: false)
  final double? limit;
  @JsonKey(name: 'used', includeIfNull: false)
  final double? used;
  @JsonKey(name: 'remaining', includeIfNull: false)
  final double? remaining;
  @JsonKey(name: 'restricted', includeIfNull: false)
  final bool? restricted;
  static const fromJsonFactory = _$UserUserIdQuotaGet$Response$MovieFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserUserIdQuotaGet$Response$Movie &&
            (identical(other.days, days) ||
                const DeepCollectionEquality().equals(other.days, days)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.used, used) ||
                const DeepCollectionEquality().equals(other.used, used)) &&
            (identical(other.remaining, remaining) ||
                const DeepCollectionEquality().equals(
                  other.remaining,
                  remaining,
                )) &&
            (identical(other.restricted, restricted) ||
                const DeepCollectionEquality().equals(
                  other.restricted,
                  restricted,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(days) ^
      const DeepCollectionEquality().hash(limit) ^
      const DeepCollectionEquality().hash(used) ^
      const DeepCollectionEquality().hash(remaining) ^
      const DeepCollectionEquality().hash(restricted) ^
      runtimeType.hashCode;
}

extension $UserUserIdQuotaGet$Response$MovieExtension
    on UserUserIdQuotaGet$Response$Movie {
  UserUserIdQuotaGet$Response$Movie copyWith({
    double? days,
    double? limit,
    double? used,
    double? remaining,
    bool? restricted,
  }) {
    return UserUserIdQuotaGet$Response$Movie(
      days: days ?? this.days,
      limit: limit ?? this.limit,
      used: used ?? this.used,
      remaining: remaining ?? this.remaining,
      restricted: restricted ?? this.restricted,
    );
  }

  UserUserIdQuotaGet$Response$Movie copyWithWrapped({
    Wrapped<double?>? days,
    Wrapped<double?>? limit,
    Wrapped<double?>? used,
    Wrapped<double?>? remaining,
    Wrapped<bool?>? restricted,
  }) {
    return UserUserIdQuotaGet$Response$Movie(
      days: (days != null ? days.value : this.days),
      limit: (limit != null ? limit.value : this.limit),
      used: (used != null ? used.value : this.used),
      remaining: (remaining != null ? remaining.value : this.remaining),
      restricted: (restricted != null ? restricted.value : this.restricted),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserUserIdQuotaGet$Response$Tv {
  const UserUserIdQuotaGet$Response$Tv({
    this.days,
    this.limit,
    this.used,
    this.remaining,
    this.restricted,
  });

  factory UserUserIdQuotaGet$Response$Tv.fromJson(Map<String, dynamic> json) =>
      _$UserUserIdQuotaGet$Response$TvFromJson(json);

  static const toJsonFactory = _$UserUserIdQuotaGet$Response$TvToJson;
  Map<String, dynamic> toJson() => _$UserUserIdQuotaGet$Response$TvToJson(this);

  @JsonKey(name: 'days', includeIfNull: false)
  final double? days;
  @JsonKey(name: 'limit', includeIfNull: false)
  final double? limit;
  @JsonKey(name: 'used', includeIfNull: false)
  final double? used;
  @JsonKey(name: 'remaining', includeIfNull: false)
  final double? remaining;
  @JsonKey(name: 'restricted', includeIfNull: false)
  final bool? restricted;
  static const fromJsonFactory = _$UserUserIdQuotaGet$Response$TvFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserUserIdQuotaGet$Response$Tv &&
            (identical(other.days, days) ||
                const DeepCollectionEquality().equals(other.days, days)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.used, used) ||
                const DeepCollectionEquality().equals(other.used, used)) &&
            (identical(other.remaining, remaining) ||
                const DeepCollectionEquality().equals(
                  other.remaining,
                  remaining,
                )) &&
            (identical(other.restricted, restricted) ||
                const DeepCollectionEquality().equals(
                  other.restricted,
                  restricted,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(days) ^
      const DeepCollectionEquality().hash(limit) ^
      const DeepCollectionEquality().hash(used) ^
      const DeepCollectionEquality().hash(remaining) ^
      const DeepCollectionEquality().hash(restricted) ^
      runtimeType.hashCode;
}

extension $UserUserIdQuotaGet$Response$TvExtension
    on UserUserIdQuotaGet$Response$Tv {
  UserUserIdQuotaGet$Response$Tv copyWith({
    double? days,
    double? limit,
    double? used,
    double? remaining,
    bool? restricted,
  }) {
    return UserUserIdQuotaGet$Response$Tv(
      days: days ?? this.days,
      limit: limit ?? this.limit,
      used: used ?? this.used,
      remaining: remaining ?? this.remaining,
      restricted: restricted ?? this.restricted,
    );
  }

  UserUserIdQuotaGet$Response$Tv copyWithWrapped({
    Wrapped<double?>? days,
    Wrapped<double?>? limit,
    Wrapped<double?>? used,
    Wrapped<double?>? remaining,
    Wrapped<bool?>? restricted,
  }) {
    return UserUserIdQuotaGet$Response$Tv(
      days: (days != null ? days.value : this.days),
      limit: (limit != null ? limit.value : this.limit),
      used: (used != null ? used.value : this.used),
      remaining: (remaining != null ? remaining.value : this.remaining),
      restricted: (restricted != null ? restricted.value : this.restricted),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class BlacklistGet$Response$Results$Item {
  const BlacklistGet$Response$Results$Item({
    this.user,
    this.createdAt,
    this.id,
    this.mediaType,
    this.title,
    this.tmdbId,
  });

  factory BlacklistGet$Response$Results$Item.fromJson(
    Map<String, dynamic> json,
  ) => _$BlacklistGet$Response$Results$ItemFromJson(json);

  static const toJsonFactory = _$BlacklistGet$Response$Results$ItemToJson;
  Map<String, dynamic> toJson() =>
      _$BlacklistGet$Response$Results$ItemToJson(this);

  @JsonKey(name: 'user', includeIfNull: false)
  final User? user;
  @JsonKey(name: 'createdAt', includeIfNull: false)
  final String? createdAt;
  @JsonKey(name: 'id', includeIfNull: false)
  final double? id;
  @JsonKey(name: 'mediaType', includeIfNull: false)
  final String? mediaType;
  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;
  @JsonKey(name: 'tmdbId', includeIfNull: false)
  final double? tmdbId;
  static const fromJsonFactory = _$BlacklistGet$Response$Results$ItemFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is BlacklistGet$Response$Results$Item &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(
                  other.createdAt,
                  createdAt,
                )) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.mediaType, mediaType) ||
                const DeepCollectionEquality().equals(
                  other.mediaType,
                  mediaType,
                )) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.tmdbId, tmdbId) ||
                const DeepCollectionEquality().equals(other.tmdbId, tmdbId)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(user) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(mediaType) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(tmdbId) ^
      runtimeType.hashCode;
}

extension $BlacklistGet$Response$Results$ItemExtension
    on BlacklistGet$Response$Results$Item {
  BlacklistGet$Response$Results$Item copyWith({
    User? user,
    String? createdAt,
    double? id,
    String? mediaType,
    String? title,
    double? tmdbId,
  }) {
    return BlacklistGet$Response$Results$Item(
      user: user ?? this.user,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      mediaType: mediaType ?? this.mediaType,
      title: title ?? this.title,
      tmdbId: tmdbId ?? this.tmdbId,
    );
  }

  BlacklistGet$Response$Results$Item copyWithWrapped({
    Wrapped<User?>? user,
    Wrapped<String?>? createdAt,
    Wrapped<double?>? id,
    Wrapped<String?>? mediaType,
    Wrapped<String?>? title,
    Wrapped<double?>? tmdbId,
  }) {
    return BlacklistGet$Response$Results$Item(
      user: (user != null ? user.value : this.user),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      id: (id != null ? id.value : this.id),
      mediaType: (mediaType != null ? mediaType.value : this.mediaType),
      title: (title != null ? title.value : this.title),
      tmdbId: (tmdbId != null ? tmdbId.value : this.tmdbId),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class UserUserIdWatchlistGet$Response$Results$Item {
  const UserUserIdWatchlistGet$Response$Results$Item({
    this.tmdbId,
    this.ratingKey,
    this.type,
    this.title,
  });

  factory UserUserIdWatchlistGet$Response$Results$Item.fromJson(
    Map<String, dynamic> json,
  ) => _$UserUserIdWatchlistGet$Response$Results$ItemFromJson(json);

  static const toJsonFactory =
      _$UserUserIdWatchlistGet$Response$Results$ItemToJson;
  Map<String, dynamic> toJson() =>
      _$UserUserIdWatchlistGet$Response$Results$ItemToJson(this);

  @JsonKey(name: 'tmdbId', includeIfNull: false)
  final double? tmdbId;
  @JsonKey(name: 'ratingKey', includeIfNull: false)
  final String? ratingKey;
  @JsonKey(name: 'type', includeIfNull: false)
  final String? type;
  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;
  static const fromJsonFactory =
      _$UserUserIdWatchlistGet$Response$Results$ItemFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserUserIdWatchlistGet$Response$Results$Item &&
            (identical(other.tmdbId, tmdbId) ||
                const DeepCollectionEquality().equals(other.tmdbId, tmdbId)) &&
            (identical(other.ratingKey, ratingKey) ||
                const DeepCollectionEquality().equals(
                  other.ratingKey,
                  ratingKey,
                )) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(tmdbId) ^
      const DeepCollectionEquality().hash(ratingKey) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(title) ^
      runtimeType.hashCode;
}

extension $UserUserIdWatchlistGet$Response$Results$ItemExtension
    on UserUserIdWatchlistGet$Response$Results$Item {
  UserUserIdWatchlistGet$Response$Results$Item copyWith({
    double? tmdbId,
    String? ratingKey,
    String? type,
    String? title,
  }) {
    return UserUserIdWatchlistGet$Response$Results$Item(
      tmdbId: tmdbId ?? this.tmdbId,
      ratingKey: ratingKey ?? this.ratingKey,
      type: type ?? this.type,
      title: title ?? this.title,
    );
  }

  UserUserIdWatchlistGet$Response$Results$Item copyWithWrapped({
    Wrapped<double?>? tmdbId,
    Wrapped<String?>? ratingKey,
    Wrapped<String?>? type,
    Wrapped<String?>? title,
  }) {
    return UserUserIdWatchlistGet$Response$Results$Item(
      tmdbId: (tmdbId != null ? tmdbId.value : this.tmdbId),
      ratingKey: (ratingKey != null ? ratingKey.value : this.ratingKey),
      type: (type != null ? type.value : this.type),
      title: (title != null ? title.value : this.title),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class DiscoverWatchlistGet$Response$Results$Item {
  const DiscoverWatchlistGet$Response$Results$Item({
    this.tmdbId,
    this.ratingKey,
    this.type,
    this.title,
  });

  factory DiscoverWatchlistGet$Response$Results$Item.fromJson(
    Map<String, dynamic> json,
  ) => _$DiscoverWatchlistGet$Response$Results$ItemFromJson(json);

  static const toJsonFactory =
      _$DiscoverWatchlistGet$Response$Results$ItemToJson;
  Map<String, dynamic> toJson() =>
      _$DiscoverWatchlistGet$Response$Results$ItemToJson(this);

  @JsonKey(name: 'tmdbId', includeIfNull: false)
  final double? tmdbId;
  @JsonKey(name: 'ratingKey', includeIfNull: false)
  final String? ratingKey;
  @JsonKey(name: 'type', includeIfNull: false)
  final String? type;
  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;
  static const fromJsonFactory =
      _$DiscoverWatchlistGet$Response$Results$ItemFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is DiscoverWatchlistGet$Response$Results$Item &&
            (identical(other.tmdbId, tmdbId) ||
                const DeepCollectionEquality().equals(other.tmdbId, tmdbId)) &&
            (identical(other.ratingKey, ratingKey) ||
                const DeepCollectionEquality().equals(
                  other.ratingKey,
                  ratingKey,
                )) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(tmdbId) ^
      const DeepCollectionEquality().hash(ratingKey) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(title) ^
      runtimeType.hashCode;
}

extension $DiscoverWatchlistGet$Response$Results$ItemExtension
    on DiscoverWatchlistGet$Response$Results$Item {
  DiscoverWatchlistGet$Response$Results$Item copyWith({
    double? tmdbId,
    String? ratingKey,
    String? type,
    String? title,
  }) {
    return DiscoverWatchlistGet$Response$Results$Item(
      tmdbId: tmdbId ?? this.tmdbId,
      ratingKey: ratingKey ?? this.ratingKey,
      type: type ?? this.type,
      title: title ?? this.title,
    );
  }

  DiscoverWatchlistGet$Response$Results$Item copyWithWrapped({
    Wrapped<double?>? tmdbId,
    Wrapped<String?>? ratingKey,
    Wrapped<String?>? type,
    Wrapped<String?>? title,
  }) {
    return DiscoverWatchlistGet$Response$Results$Item(
      tmdbId: (tmdbId != null ? tmdbId.value : this.tmdbId),
      ratingKey: (ratingKey != null ? ratingKey.value : this.ratingKey),
      type: (type != null ? type.value : this.type),
      title: (title != null ? title.value : this.title),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class MovieMovieIdRatingscombinedGet$Response$Rt {
  const MovieMovieIdRatingscombinedGet$Response$Rt({
    this.title,
    this.year,
    this.url,
    this.criticsScore,
    this.criticsRating,
    this.audienceScore,
    this.audienceRating,
  });

  factory MovieMovieIdRatingscombinedGet$Response$Rt.fromJson(
    Map<String, dynamic> json,
  ) => _$MovieMovieIdRatingscombinedGet$Response$RtFromJson(json);

  static const toJsonFactory =
      _$MovieMovieIdRatingscombinedGet$Response$RtToJson;
  Map<String, dynamic> toJson() =>
      _$MovieMovieIdRatingscombinedGet$Response$RtToJson(this);

  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;
  @JsonKey(name: 'year', includeIfNull: false)
  final double? year;
  @JsonKey(name: 'url', includeIfNull: false)
  final String? url;
  @JsonKey(name: 'criticsScore', includeIfNull: false)
  final double? criticsScore;
  @JsonKey(
    name: 'criticsRating',
    includeIfNull: false,
    toJson:
        movieMovieIdRatingscombinedGet$Response$RtCriticsRatingNullableToJson,
    fromJson:
        movieMovieIdRatingscombinedGet$Response$RtCriticsRatingNullableFromJson,
  )
  final enums.MovieMovieIdRatingscombinedGet$Response$RtCriticsRating?
  criticsRating;
  @JsonKey(name: 'audienceScore', includeIfNull: false)
  final double? audienceScore;
  @JsonKey(
    name: 'audienceRating',
    includeIfNull: false,
    toJson:
        movieMovieIdRatingscombinedGet$Response$RtAudienceRatingNullableToJson,
    fromJson:
        movieMovieIdRatingscombinedGet$Response$RtAudienceRatingNullableFromJson,
  )
  final enums.MovieMovieIdRatingscombinedGet$Response$RtAudienceRating?
  audienceRating;
  static const fromJsonFactory =
      _$MovieMovieIdRatingscombinedGet$Response$RtFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MovieMovieIdRatingscombinedGet$Response$Rt &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.year, year) ||
                const DeepCollectionEquality().equals(other.year, year)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.criticsScore, criticsScore) ||
                const DeepCollectionEquality().equals(
                  other.criticsScore,
                  criticsScore,
                )) &&
            (identical(other.criticsRating, criticsRating) ||
                const DeepCollectionEquality().equals(
                  other.criticsRating,
                  criticsRating,
                )) &&
            (identical(other.audienceScore, audienceScore) ||
                const DeepCollectionEquality().equals(
                  other.audienceScore,
                  audienceScore,
                )) &&
            (identical(other.audienceRating, audienceRating) ||
                const DeepCollectionEquality().equals(
                  other.audienceRating,
                  audienceRating,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(year) ^
      const DeepCollectionEquality().hash(url) ^
      const DeepCollectionEquality().hash(criticsScore) ^
      const DeepCollectionEquality().hash(criticsRating) ^
      const DeepCollectionEquality().hash(audienceScore) ^
      const DeepCollectionEquality().hash(audienceRating) ^
      runtimeType.hashCode;
}

extension $MovieMovieIdRatingscombinedGet$Response$RtExtension
    on MovieMovieIdRatingscombinedGet$Response$Rt {
  MovieMovieIdRatingscombinedGet$Response$Rt copyWith({
    String? title,
    double? year,
    String? url,
    double? criticsScore,
    enums.MovieMovieIdRatingscombinedGet$Response$RtCriticsRating?
    criticsRating,
    double? audienceScore,
    enums.MovieMovieIdRatingscombinedGet$Response$RtAudienceRating?
    audienceRating,
  }) {
    return MovieMovieIdRatingscombinedGet$Response$Rt(
      title: title ?? this.title,
      year: year ?? this.year,
      url: url ?? this.url,
      criticsScore: criticsScore ?? this.criticsScore,
      criticsRating: criticsRating ?? this.criticsRating,
      audienceScore: audienceScore ?? this.audienceScore,
      audienceRating: audienceRating ?? this.audienceRating,
    );
  }

  MovieMovieIdRatingscombinedGet$Response$Rt copyWithWrapped({
    Wrapped<String?>? title,
    Wrapped<double?>? year,
    Wrapped<String?>? url,
    Wrapped<double?>? criticsScore,
    Wrapped<enums.MovieMovieIdRatingscombinedGet$Response$RtCriticsRating?>?
    criticsRating,
    Wrapped<double?>? audienceScore,
    Wrapped<enums.MovieMovieIdRatingscombinedGet$Response$RtAudienceRating?>?
    audienceRating,
  }) {
    return MovieMovieIdRatingscombinedGet$Response$Rt(
      title: (title != null ? title.value : this.title),
      year: (year != null ? year.value : this.year),
      url: (url != null ? url.value : this.url),
      criticsScore: (criticsScore != null
          ? criticsScore.value
          : this.criticsScore),
      criticsRating: (criticsRating != null
          ? criticsRating.value
          : this.criticsRating),
      audienceScore: (audienceScore != null
          ? audienceScore.value
          : this.audienceScore),
      audienceRating: (audienceRating != null
          ? audienceRating.value
          : this.audienceRating),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class MovieMovieIdRatingscombinedGet$Response$Imdb {
  const MovieMovieIdRatingscombinedGet$Response$Imdb({
    this.title,
    this.url,
    this.criticsScore,
  });

  factory MovieMovieIdRatingscombinedGet$Response$Imdb.fromJson(
    Map<String, dynamic> json,
  ) => _$MovieMovieIdRatingscombinedGet$Response$ImdbFromJson(json);

  static const toJsonFactory =
      _$MovieMovieIdRatingscombinedGet$Response$ImdbToJson;
  Map<String, dynamic> toJson() =>
      _$MovieMovieIdRatingscombinedGet$Response$ImdbToJson(this);

  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;
  @JsonKey(name: 'url', includeIfNull: false)
  final String? url;
  @JsonKey(name: 'criticsScore', includeIfNull: false)
  final double? criticsScore;
  static const fromJsonFactory =
      _$MovieMovieIdRatingscombinedGet$Response$ImdbFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MovieMovieIdRatingscombinedGet$Response$Imdb &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.criticsScore, criticsScore) ||
                const DeepCollectionEquality().equals(
                  other.criticsScore,
                  criticsScore,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(url) ^
      const DeepCollectionEquality().hash(criticsScore) ^
      runtimeType.hashCode;
}

extension $MovieMovieIdRatingscombinedGet$Response$ImdbExtension
    on MovieMovieIdRatingscombinedGet$Response$Imdb {
  MovieMovieIdRatingscombinedGet$Response$Imdb copyWith({
    String? title,
    String? url,
    double? criticsScore,
  }) {
    return MovieMovieIdRatingscombinedGet$Response$Imdb(
      title: title ?? this.title,
      url: url ?? this.url,
      criticsScore: criticsScore ?? this.criticsScore,
    );
  }

  MovieMovieIdRatingscombinedGet$Response$Imdb copyWithWrapped({
    Wrapped<String?>? title,
    Wrapped<String?>? url,
    Wrapped<double?>? criticsScore,
  }) {
    return MovieMovieIdRatingscombinedGet$Response$Imdb(
      title: (title != null ? title.value : this.title),
      url: (url != null ? url.value : this.url),
      criticsScore: (criticsScore != null
          ? criticsScore.value
          : this.criticsScore),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class MediaMediaIdWatchDataGet$Response$Data {
  const MediaMediaIdWatchDataGet$Response$Data({
    this.playCount7Days,
    this.playCount30Days,
    this.playCount,
    this.users,
  });

  factory MediaMediaIdWatchDataGet$Response$Data.fromJson(
    Map<String, dynamic> json,
  ) => _$MediaMediaIdWatchDataGet$Response$DataFromJson(json);

  static const toJsonFactory = _$MediaMediaIdWatchDataGet$Response$DataToJson;
  Map<String, dynamic> toJson() =>
      _$MediaMediaIdWatchDataGet$Response$DataToJson(this);

  @JsonKey(name: 'playCount7Days', includeIfNull: false)
  final double? playCount7Days;
  @JsonKey(name: 'playCount30Days', includeIfNull: false)
  final double? playCount30Days;
  @JsonKey(name: 'playCount', includeIfNull: false)
  final double? playCount;
  @JsonKey(name: 'users', includeIfNull: false, defaultValue: <User>[])
  final List<User>? users;
  static const fromJsonFactory =
      _$MediaMediaIdWatchDataGet$Response$DataFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MediaMediaIdWatchDataGet$Response$Data &&
            (identical(other.playCount7Days, playCount7Days) ||
                const DeepCollectionEquality().equals(
                  other.playCount7Days,
                  playCount7Days,
                )) &&
            (identical(other.playCount30Days, playCount30Days) ||
                const DeepCollectionEquality().equals(
                  other.playCount30Days,
                  playCount30Days,
                )) &&
            (identical(other.playCount, playCount) ||
                const DeepCollectionEquality().equals(
                  other.playCount,
                  playCount,
                )) &&
            (identical(other.users, users) ||
                const DeepCollectionEquality().equals(other.users, users)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(playCount7Days) ^
      const DeepCollectionEquality().hash(playCount30Days) ^
      const DeepCollectionEquality().hash(playCount) ^
      const DeepCollectionEquality().hash(users) ^
      runtimeType.hashCode;
}

extension $MediaMediaIdWatchDataGet$Response$DataExtension
    on MediaMediaIdWatchDataGet$Response$Data {
  MediaMediaIdWatchDataGet$Response$Data copyWith({
    double? playCount7Days,
    double? playCount30Days,
    double? playCount,
    List<User>? users,
  }) {
    return MediaMediaIdWatchDataGet$Response$Data(
      playCount7Days: playCount7Days ?? this.playCount7Days,
      playCount30Days: playCount30Days ?? this.playCount30Days,
      playCount: playCount ?? this.playCount,
      users: users ?? this.users,
    );
  }

  MediaMediaIdWatchDataGet$Response$Data copyWithWrapped({
    Wrapped<double?>? playCount7Days,
    Wrapped<double?>? playCount30Days,
    Wrapped<double?>? playCount,
    Wrapped<List<User>?>? users,
  }) {
    return MediaMediaIdWatchDataGet$Response$Data(
      playCount7Days: (playCount7Days != null
          ? playCount7Days.value
          : this.playCount7Days),
      playCount30Days: (playCount30Days != null
          ? playCount30Days.value
          : this.playCount30Days),
      playCount: (playCount != null ? playCount.value : this.playCount),
      users: (users != null ? users.value : this.users),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class MediaMediaIdWatchDataGet$Response$Data4k {
  const MediaMediaIdWatchDataGet$Response$Data4k({
    this.playCount7Days,
    this.playCount30Days,
    this.playCount,
    this.users,
  });

  factory MediaMediaIdWatchDataGet$Response$Data4k.fromJson(
    Map<String, dynamic> json,
  ) => _$MediaMediaIdWatchDataGet$Response$Data4kFromJson(json);

  static const toJsonFactory = _$MediaMediaIdWatchDataGet$Response$Data4kToJson;
  Map<String, dynamic> toJson() =>
      _$MediaMediaIdWatchDataGet$Response$Data4kToJson(this);

  @JsonKey(name: 'playCount7Days', includeIfNull: false)
  final double? playCount7Days;
  @JsonKey(name: 'playCount30Days', includeIfNull: false)
  final double? playCount30Days;
  @JsonKey(name: 'playCount', includeIfNull: false)
  final double? playCount;
  @JsonKey(name: 'users', includeIfNull: false, defaultValue: <User>[])
  final List<User>? users;
  static const fromJsonFactory =
      _$MediaMediaIdWatchDataGet$Response$Data4kFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MediaMediaIdWatchDataGet$Response$Data4k &&
            (identical(other.playCount7Days, playCount7Days) ||
                const DeepCollectionEquality().equals(
                  other.playCount7Days,
                  playCount7Days,
                )) &&
            (identical(other.playCount30Days, playCount30Days) ||
                const DeepCollectionEquality().equals(
                  other.playCount30Days,
                  playCount30Days,
                )) &&
            (identical(other.playCount, playCount) ||
                const DeepCollectionEquality().equals(
                  other.playCount,
                  playCount,
                )) &&
            (identical(other.users, users) ||
                const DeepCollectionEquality().equals(other.users, users)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(playCount7Days) ^
      const DeepCollectionEquality().hash(playCount30Days) ^
      const DeepCollectionEquality().hash(playCount) ^
      const DeepCollectionEquality().hash(users) ^
      runtimeType.hashCode;
}

extension $MediaMediaIdWatchDataGet$Response$Data4kExtension
    on MediaMediaIdWatchDataGet$Response$Data4k {
  MediaMediaIdWatchDataGet$Response$Data4k copyWith({
    double? playCount7Days,
    double? playCount30Days,
    double? playCount,
    List<User>? users,
  }) {
    return MediaMediaIdWatchDataGet$Response$Data4k(
      playCount7Days: playCount7Days ?? this.playCount7Days,
      playCount30Days: playCount30Days ?? this.playCount30Days,
      playCount: playCount ?? this.playCount,
      users: users ?? this.users,
    );
  }

  MediaMediaIdWatchDataGet$Response$Data4k copyWithWrapped({
    Wrapped<double?>? playCount7Days,
    Wrapped<double?>? playCount30Days,
    Wrapped<double?>? playCount,
    Wrapped<List<User>?>? users,
  }) {
    return MediaMediaIdWatchDataGet$Response$Data4k(
      playCount7Days: (playCount7Days != null
          ? playCount7Days.value
          : this.playCount7Days),
      playCount30Days: (playCount30Days != null
          ? playCount30Days.value
          : this.playCount30Days),
      playCount: (playCount != null ? playCount.value : this.playCount),
      users: (users != null ? users.value : this.users),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class MovieDetails$Releases$Results$Item {
  const MovieDetails$Releases$Results$Item({
    this.iso31661,
    this.rating,
    this.releaseDates,
  });

  factory MovieDetails$Releases$Results$Item.fromJson(
    Map<String, dynamic> json,
  ) => _$MovieDetails$Releases$Results$ItemFromJson(json);

  static const toJsonFactory = _$MovieDetails$Releases$Results$ItemToJson;
  Map<String, dynamic> toJson() =>
      _$MovieDetails$Releases$Results$ItemToJson(this);

  @JsonKey(name: 'iso_3166_1', includeIfNull: false)
  final String? iso31661;
  @JsonKey(name: 'rating', includeIfNull: false)
  final String? rating;
  @JsonKey(name: 'release_dates', includeIfNull: false)
  final List<MovieDetails$Releases$Results$Item$ReleaseDates$Item>?
  releaseDates;
  static const fromJsonFactory = _$MovieDetails$Releases$Results$ItemFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MovieDetails$Releases$Results$Item &&
            (identical(other.iso31661, iso31661) ||
                const DeepCollectionEquality().equals(
                  other.iso31661,
                  iso31661,
                )) &&
            (identical(other.rating, rating) ||
                const DeepCollectionEquality().equals(other.rating, rating)) &&
            (identical(other.releaseDates, releaseDates) ||
                const DeepCollectionEquality().equals(
                  other.releaseDates,
                  releaseDates,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(iso31661) ^
      const DeepCollectionEquality().hash(rating) ^
      const DeepCollectionEquality().hash(releaseDates) ^
      runtimeType.hashCode;
}

extension $MovieDetails$Releases$Results$ItemExtension
    on MovieDetails$Releases$Results$Item {
  MovieDetails$Releases$Results$Item copyWith({
    String? iso31661,
    String? rating,
    List<MovieDetails$Releases$Results$Item$ReleaseDates$Item>? releaseDates,
  }) {
    return MovieDetails$Releases$Results$Item(
      iso31661: iso31661 ?? this.iso31661,
      rating: rating ?? this.rating,
      releaseDates: releaseDates ?? this.releaseDates,
    );
  }

  MovieDetails$Releases$Results$Item copyWithWrapped({
    Wrapped<String?>? iso31661,
    Wrapped<String?>? rating,
    Wrapped<List<MovieDetails$Releases$Results$Item$ReleaseDates$Item>?>?
    releaseDates,
  }) {
    return MovieDetails$Releases$Results$Item(
      iso31661: (iso31661 != null ? iso31661.value : this.iso31661),
      rating: (rating != null ? rating.value : this.rating),
      releaseDates: (releaseDates != null
          ? releaseDates.value
          : this.releaseDates),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TvDetails$ContentRatings$Results$Item {
  const TvDetails$ContentRatings$Results$Item({this.iso31661, this.rating});

  factory TvDetails$ContentRatings$Results$Item.fromJson(
    Map<String, dynamic> json,
  ) => _$TvDetails$ContentRatings$Results$ItemFromJson(json);

  static const toJsonFactory = _$TvDetails$ContentRatings$Results$ItemToJson;
  Map<String, dynamic> toJson() =>
      _$TvDetails$ContentRatings$Results$ItemToJson(this);

  @JsonKey(name: 'iso_3166_1', includeIfNull: false)
  final String? iso31661;
  @JsonKey(name: 'rating', includeIfNull: false)
  final String? rating;
  static const fromJsonFactory =
      _$TvDetails$ContentRatings$Results$ItemFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TvDetails$ContentRatings$Results$Item &&
            (identical(other.iso31661, iso31661) ||
                const DeepCollectionEquality().equals(
                  other.iso31661,
                  iso31661,
                )) &&
            (identical(other.rating, rating) ||
                const DeepCollectionEquality().equals(other.rating, rating)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(iso31661) ^
      const DeepCollectionEquality().hash(rating) ^
      runtimeType.hashCode;
}

extension $TvDetails$ContentRatings$Results$ItemExtension
    on TvDetails$ContentRatings$Results$Item {
  TvDetails$ContentRatings$Results$Item copyWith({
    String? iso31661,
    String? rating,
  }) {
    return TvDetails$ContentRatings$Results$Item(
      iso31661: iso31661 ?? this.iso31661,
      rating: rating ?? this.rating,
    );
  }

  TvDetails$ContentRatings$Results$Item copyWithWrapped({
    Wrapped<String?>? iso31661,
    Wrapped<String?>? rating,
  }) {
    return TvDetails$ContentRatings$Results$Item(
      iso31661: (iso31661 != null ? iso31661.value : this.iso31661),
      rating: (rating != null ? rating.value : this.rating),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SettingsCacheGet$Response$ImageCache$Tmdb {
  const SettingsCacheGet$Response$ImageCache$Tmdb({this.size, this.imageCount});

  factory SettingsCacheGet$Response$ImageCache$Tmdb.fromJson(
    Map<String, dynamic> json,
  ) => _$SettingsCacheGet$Response$ImageCache$TmdbFromJson(json);

  static const toJsonFactory =
      _$SettingsCacheGet$Response$ImageCache$TmdbToJson;
  Map<String, dynamic> toJson() =>
      _$SettingsCacheGet$Response$ImageCache$TmdbToJson(this);

  @JsonKey(name: 'size', includeIfNull: false)
  final double? size;
  @JsonKey(name: 'imageCount', includeIfNull: false)
  final double? imageCount;
  static const fromJsonFactory =
      _$SettingsCacheGet$Response$ImageCache$TmdbFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SettingsCacheGet$Response$ImageCache$Tmdb &&
            (identical(other.size, size) ||
                const DeepCollectionEquality().equals(other.size, size)) &&
            (identical(other.imageCount, imageCount) ||
                const DeepCollectionEquality().equals(
                  other.imageCount,
                  imageCount,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(size) ^
      const DeepCollectionEquality().hash(imageCount) ^
      runtimeType.hashCode;
}

extension $SettingsCacheGet$Response$ImageCache$TmdbExtension
    on SettingsCacheGet$Response$ImageCache$Tmdb {
  SettingsCacheGet$Response$ImageCache$Tmdb copyWith({
    double? size,
    double? imageCount,
  }) {
    return SettingsCacheGet$Response$ImageCache$Tmdb(
      size: size ?? this.size,
      imageCount: imageCount ?? this.imageCount,
    );
  }

  SettingsCacheGet$Response$ImageCache$Tmdb copyWithWrapped({
    Wrapped<double?>? size,
    Wrapped<double?>? imageCount,
  }) {
    return SettingsCacheGet$Response$ImageCache$Tmdb(
      size: (size != null ? size.value : this.size),
      imageCount: (imageCount != null ? imageCount.value : this.imageCount),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SettingsCacheGet$Response$ImageCache$Avatar {
  const SettingsCacheGet$Response$ImageCache$Avatar({
    this.size,
    this.imageCount,
  });

  factory SettingsCacheGet$Response$ImageCache$Avatar.fromJson(
    Map<String, dynamic> json,
  ) => _$SettingsCacheGet$Response$ImageCache$AvatarFromJson(json);

  static const toJsonFactory =
      _$SettingsCacheGet$Response$ImageCache$AvatarToJson;
  Map<String, dynamic> toJson() =>
      _$SettingsCacheGet$Response$ImageCache$AvatarToJson(this);

  @JsonKey(name: 'size', includeIfNull: false)
  final double? size;
  @JsonKey(name: 'imageCount', includeIfNull: false)
  final double? imageCount;
  static const fromJsonFactory =
      _$SettingsCacheGet$Response$ImageCache$AvatarFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SettingsCacheGet$Response$ImageCache$Avatar &&
            (identical(other.size, size) ||
                const DeepCollectionEquality().equals(other.size, size)) &&
            (identical(other.imageCount, imageCount) ||
                const DeepCollectionEquality().equals(
                  other.imageCount,
                  imageCount,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(size) ^
      const DeepCollectionEquality().hash(imageCount) ^
      runtimeType.hashCode;
}

extension $SettingsCacheGet$Response$ImageCache$AvatarExtension
    on SettingsCacheGet$Response$ImageCache$Avatar {
  SettingsCacheGet$Response$ImageCache$Avatar copyWith({
    double? size,
    double? imageCount,
  }) {
    return SettingsCacheGet$Response$ImageCache$Avatar(
      size: size ?? this.size,
      imageCount: imageCount ?? this.imageCount,
    );
  }

  SettingsCacheGet$Response$ImageCache$Avatar copyWithWrapped({
    Wrapped<double?>? size,
    Wrapped<double?>? imageCount,
  }) {
    return SettingsCacheGet$Response$ImageCache$Avatar(
      size: (size != null ? size.value : this.size),
      imageCount: (imageCount != null ? imageCount.value : this.imageCount),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SettingsCacheGet$Response$DnsCache$Stats {
  const SettingsCacheGet$Response$DnsCache$Stats({
    this.size,
    this.maxSize,
    this.hits,
    this.misses,
    this.failures,
    this.ipv4Fallbacks,
    this.hitRate,
  });

  factory SettingsCacheGet$Response$DnsCache$Stats.fromJson(
    Map<String, dynamic> json,
  ) => _$SettingsCacheGet$Response$DnsCache$StatsFromJson(json);

  static const toJsonFactory = _$SettingsCacheGet$Response$DnsCache$StatsToJson;
  Map<String, dynamic> toJson() =>
      _$SettingsCacheGet$Response$DnsCache$StatsToJson(this);

  @JsonKey(name: 'size', includeIfNull: false)
  final double? size;
  @JsonKey(name: 'maxSize', includeIfNull: false)
  final double? maxSize;
  @JsonKey(name: 'hits', includeIfNull: false)
  final double? hits;
  @JsonKey(name: 'misses', includeIfNull: false)
  final double? misses;
  @JsonKey(name: 'failures', includeIfNull: false)
  final double? failures;
  @JsonKey(name: 'ipv4Fallbacks', includeIfNull: false)
  final double? ipv4Fallbacks;
  @JsonKey(name: 'hitRate', includeIfNull: false)
  final double? hitRate;
  static const fromJsonFactory =
      _$SettingsCacheGet$Response$DnsCache$StatsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SettingsCacheGet$Response$DnsCache$Stats &&
            (identical(other.size, size) ||
                const DeepCollectionEquality().equals(other.size, size)) &&
            (identical(other.maxSize, maxSize) ||
                const DeepCollectionEquality().equals(
                  other.maxSize,
                  maxSize,
                )) &&
            (identical(other.hits, hits) ||
                const DeepCollectionEquality().equals(other.hits, hits)) &&
            (identical(other.misses, misses) ||
                const DeepCollectionEquality().equals(other.misses, misses)) &&
            (identical(other.failures, failures) ||
                const DeepCollectionEquality().equals(
                  other.failures,
                  failures,
                )) &&
            (identical(other.ipv4Fallbacks, ipv4Fallbacks) ||
                const DeepCollectionEquality().equals(
                  other.ipv4Fallbacks,
                  ipv4Fallbacks,
                )) &&
            (identical(other.hitRate, hitRate) ||
                const DeepCollectionEquality().equals(other.hitRate, hitRate)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(size) ^
      const DeepCollectionEquality().hash(maxSize) ^
      const DeepCollectionEquality().hash(hits) ^
      const DeepCollectionEquality().hash(misses) ^
      const DeepCollectionEquality().hash(failures) ^
      const DeepCollectionEquality().hash(ipv4Fallbacks) ^
      const DeepCollectionEquality().hash(hitRate) ^
      runtimeType.hashCode;
}

extension $SettingsCacheGet$Response$DnsCache$StatsExtension
    on SettingsCacheGet$Response$DnsCache$Stats {
  SettingsCacheGet$Response$DnsCache$Stats copyWith({
    double? size,
    double? maxSize,
    double? hits,
    double? misses,
    double? failures,
    double? ipv4Fallbacks,
    double? hitRate,
  }) {
    return SettingsCacheGet$Response$DnsCache$Stats(
      size: size ?? this.size,
      maxSize: maxSize ?? this.maxSize,
      hits: hits ?? this.hits,
      misses: misses ?? this.misses,
      failures: failures ?? this.failures,
      ipv4Fallbacks: ipv4Fallbacks ?? this.ipv4Fallbacks,
      hitRate: hitRate ?? this.hitRate,
    );
  }

  SettingsCacheGet$Response$DnsCache$Stats copyWithWrapped({
    Wrapped<double?>? size,
    Wrapped<double?>? maxSize,
    Wrapped<double?>? hits,
    Wrapped<double?>? misses,
    Wrapped<double?>? failures,
    Wrapped<double?>? ipv4Fallbacks,
    Wrapped<double?>? hitRate,
  }) {
    return SettingsCacheGet$Response$DnsCache$Stats(
      size: (size != null ? size.value : this.size),
      maxSize: (maxSize != null ? maxSize.value : this.maxSize),
      hits: (hits != null ? hits.value : this.hits),
      misses: (misses != null ? misses.value : this.misses),
      failures: (failures != null ? failures.value : this.failures),
      ipv4Fallbacks: (ipv4Fallbacks != null
          ? ipv4Fallbacks.value
          : this.ipv4Fallbacks),
      hitRate: (hitRate != null ? hitRate.value : this.hitRate),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SettingsCacheGet$Response$ApiCaches$Item$Stats {
  const SettingsCacheGet$Response$ApiCaches$Item$Stats({
    this.hits,
    this.misses,
    this.keys,
    this.ksize,
    this.vsize,
  });

  factory SettingsCacheGet$Response$ApiCaches$Item$Stats.fromJson(
    Map<String, dynamic> json,
  ) => _$SettingsCacheGet$Response$ApiCaches$Item$StatsFromJson(json);

  static const toJsonFactory =
      _$SettingsCacheGet$Response$ApiCaches$Item$StatsToJson;
  Map<String, dynamic> toJson() =>
      _$SettingsCacheGet$Response$ApiCaches$Item$StatsToJson(this);

  @JsonKey(name: 'hits', includeIfNull: false)
  final double? hits;
  @JsonKey(name: 'misses', includeIfNull: false)
  final double? misses;
  @JsonKey(name: 'keys', includeIfNull: false)
  final double? keys;
  @JsonKey(name: 'ksize', includeIfNull: false)
  final double? ksize;
  @JsonKey(name: 'vsize', includeIfNull: false)
  final double? vsize;
  static const fromJsonFactory =
      _$SettingsCacheGet$Response$ApiCaches$Item$StatsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SettingsCacheGet$Response$ApiCaches$Item$Stats &&
            (identical(other.hits, hits) ||
                const DeepCollectionEquality().equals(other.hits, hits)) &&
            (identical(other.misses, misses) ||
                const DeepCollectionEquality().equals(other.misses, misses)) &&
            (identical(other.keys, keys) ||
                const DeepCollectionEquality().equals(other.keys, keys)) &&
            (identical(other.ksize, ksize) ||
                const DeepCollectionEquality().equals(other.ksize, ksize)) &&
            (identical(other.vsize, vsize) ||
                const DeepCollectionEquality().equals(other.vsize, vsize)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(hits) ^
      const DeepCollectionEquality().hash(misses) ^
      const DeepCollectionEquality().hash(keys) ^
      const DeepCollectionEquality().hash(ksize) ^
      const DeepCollectionEquality().hash(vsize) ^
      runtimeType.hashCode;
}

extension $SettingsCacheGet$Response$ApiCaches$Item$StatsExtension
    on SettingsCacheGet$Response$ApiCaches$Item$Stats {
  SettingsCacheGet$Response$ApiCaches$Item$Stats copyWith({
    double? hits,
    double? misses,
    double? keys,
    double? ksize,
    double? vsize,
  }) {
    return SettingsCacheGet$Response$ApiCaches$Item$Stats(
      hits: hits ?? this.hits,
      misses: misses ?? this.misses,
      keys: keys ?? this.keys,
      ksize: ksize ?? this.ksize,
      vsize: vsize ?? this.vsize,
    );
  }

  SettingsCacheGet$Response$ApiCaches$Item$Stats copyWithWrapped({
    Wrapped<double?>? hits,
    Wrapped<double?>? misses,
    Wrapped<double?>? keys,
    Wrapped<double?>? ksize,
    Wrapped<double?>? vsize,
  }) {
    return SettingsCacheGet$Response$ApiCaches$Item$Stats(
      hits: (hits != null ? hits.value : this.hits),
      misses: (misses != null ? misses.value : this.misses),
      keys: (keys != null ? keys.value : this.keys),
      ksize: (ksize != null ? ksize.value : this.ksize),
      vsize: (vsize != null ? vsize.value : this.vsize),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class MovieDetails$Releases$Results$Item$ReleaseDates$Item {
  const MovieDetails$Releases$Results$Item$ReleaseDates$Item({
    this.certification,
    this.iso6391,
    this.note,
    this.releaseDate,
    this.type,
  });

  factory MovieDetails$Releases$Results$Item$ReleaseDates$Item.fromJson(
    Map<String, dynamic> json,
  ) => _$MovieDetails$Releases$Results$Item$ReleaseDates$ItemFromJson(json);

  static const toJsonFactory =
      _$MovieDetails$Releases$Results$Item$ReleaseDates$ItemToJson;
  Map<String, dynamic> toJson() =>
      _$MovieDetails$Releases$Results$Item$ReleaseDates$ItemToJson(this);

  @JsonKey(name: 'certification', includeIfNull: false)
  final String? certification;
  @JsonKey(name: 'iso_639_1', includeIfNull: false)
  final String? iso6391;
  @JsonKey(name: 'note', includeIfNull: false)
  final String? note;
  @JsonKey(name: 'release_date', includeIfNull: false)
  final String? releaseDate;
  @JsonKey(name: 'type', includeIfNull: false)
  final double? type;
  static const fromJsonFactory =
      _$MovieDetails$Releases$Results$Item$ReleaseDates$ItemFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MovieDetails$Releases$Results$Item$ReleaseDates$Item &&
            (identical(other.certification, certification) ||
                const DeepCollectionEquality().equals(
                  other.certification,
                  certification,
                )) &&
            (identical(other.iso6391, iso6391) ||
                const DeepCollectionEquality().equals(
                  other.iso6391,
                  iso6391,
                )) &&
            (identical(other.note, note) ||
                const DeepCollectionEquality().equals(other.note, note)) &&
            (identical(other.releaseDate, releaseDate) ||
                const DeepCollectionEquality().equals(
                  other.releaseDate,
                  releaseDate,
                )) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(certification) ^
      const DeepCollectionEquality().hash(iso6391) ^
      const DeepCollectionEquality().hash(note) ^
      const DeepCollectionEquality().hash(releaseDate) ^
      const DeepCollectionEquality().hash(type) ^
      runtimeType.hashCode;
}

extension $MovieDetails$Releases$Results$Item$ReleaseDates$ItemExtension
    on MovieDetails$Releases$Results$Item$ReleaseDates$Item {
  MovieDetails$Releases$Results$Item$ReleaseDates$Item copyWith({
    String? certification,
    String? iso6391,
    String? note,
    String? releaseDate,
    double? type,
  }) {
    return MovieDetails$Releases$Results$Item$ReleaseDates$Item(
      certification: certification ?? this.certification,
      iso6391: iso6391 ?? this.iso6391,
      note: note ?? this.note,
      releaseDate: releaseDate ?? this.releaseDate,
      type: type ?? this.type,
    );
  }

  MovieDetails$Releases$Results$Item$ReleaseDates$Item copyWithWrapped({
    Wrapped<String?>? certification,
    Wrapped<String?>? iso6391,
    Wrapped<String?>? note,
    Wrapped<String?>? releaseDate,
    Wrapped<double?>? type,
  }) {
    return MovieDetails$Releases$Results$Item$ReleaseDates$Item(
      certification: (certification != null
          ? certification.value
          : this.certification),
      iso6391: (iso6391 != null ? iso6391.value : this.iso6391),
      note: (note != null ? note.value : this.note),
      releaseDate: (releaseDate != null ? releaseDate.value : this.releaseDate),
      type: (type != null ? type.value : this.type),
    );
  }
}

String? metadataSettings$SettingsTvNullableToJson(
  enums.MetadataSettings$SettingsTv? metadataSettings$SettingsTv,
) {
  return metadataSettings$SettingsTv?.value;
}

String? metadataSettings$SettingsTvToJson(
  enums.MetadataSettings$SettingsTv metadataSettings$SettingsTv,
) {
  return metadataSettings$SettingsTv.value;
}

enums.MetadataSettings$SettingsTv metadataSettings$SettingsTvFromJson(
  Object? metadataSettings$SettingsTv, [
  enums.MetadataSettings$SettingsTv? defaultValue,
]) {
  return enums.MetadataSettings$SettingsTv.values.firstWhereOrNull(
        (e) => e.value == metadataSettings$SettingsTv,
      ) ??
      defaultValue ??
      enums.MetadataSettings$SettingsTv.swaggerGeneratedUnknown;
}

enums.MetadataSettings$SettingsTv? metadataSettings$SettingsTvNullableFromJson(
  Object? metadataSettings$SettingsTv, [
  enums.MetadataSettings$SettingsTv? defaultValue,
]) {
  if (metadataSettings$SettingsTv == null) {
    return null;
  }
  return enums.MetadataSettings$SettingsTv.values.firstWhereOrNull(
        (e) => e.value == metadataSettings$SettingsTv,
      ) ??
      defaultValue;
}

String metadataSettings$SettingsTvExplodedListToJson(
  List<enums.MetadataSettings$SettingsTv>? metadataSettings$SettingsTv,
) {
  return metadataSettings$SettingsTv?.map((e) => e.value!).join(',') ?? '';
}

List<String> metadataSettings$SettingsTvListToJson(
  List<enums.MetadataSettings$SettingsTv>? metadataSettings$SettingsTv,
) {
  if (metadataSettings$SettingsTv == null) {
    return [];
  }

  return metadataSettings$SettingsTv.map((e) => e.value!).toList();
}

List<enums.MetadataSettings$SettingsTv> metadataSettings$SettingsTvListFromJson(
  List? metadataSettings$SettingsTv, [
  List<enums.MetadataSettings$SettingsTv>? defaultValue,
]) {
  if (metadataSettings$SettingsTv == null) {
    return defaultValue ?? [];
  }

  return metadataSettings$SettingsTv
      .map((e) => metadataSettings$SettingsTvFromJson(e.toString()))
      .toList();
}

List<enums.MetadataSettings$SettingsTv>?
metadataSettings$SettingsTvNullableListFromJson(
  List? metadataSettings$SettingsTv, [
  List<enums.MetadataSettings$SettingsTv>? defaultValue,
]) {
  if (metadataSettings$SettingsTv == null) {
    return defaultValue;
  }

  return metadataSettings$SettingsTv
      .map((e) => metadataSettings$SettingsTvFromJson(e.toString()))
      .toList();
}

String? metadataSettings$SettingsAnimeNullableToJson(
  enums.MetadataSettings$SettingsAnime? metadataSettings$SettingsAnime,
) {
  return metadataSettings$SettingsAnime?.value;
}

String? metadataSettings$SettingsAnimeToJson(
  enums.MetadataSettings$SettingsAnime metadataSettings$SettingsAnime,
) {
  return metadataSettings$SettingsAnime.value;
}

enums.MetadataSettings$SettingsAnime metadataSettings$SettingsAnimeFromJson(
  Object? metadataSettings$SettingsAnime, [
  enums.MetadataSettings$SettingsAnime? defaultValue,
]) {
  return enums.MetadataSettings$SettingsAnime.values.firstWhereOrNull(
        (e) => e.value == metadataSettings$SettingsAnime,
      ) ??
      defaultValue ??
      enums.MetadataSettings$SettingsAnime.swaggerGeneratedUnknown;
}

enums.MetadataSettings$SettingsAnime?
metadataSettings$SettingsAnimeNullableFromJson(
  Object? metadataSettings$SettingsAnime, [
  enums.MetadataSettings$SettingsAnime? defaultValue,
]) {
  if (metadataSettings$SettingsAnime == null) {
    return null;
  }
  return enums.MetadataSettings$SettingsAnime.values.firstWhereOrNull(
        (e) => e.value == metadataSettings$SettingsAnime,
      ) ??
      defaultValue;
}

String metadataSettings$SettingsAnimeExplodedListToJson(
  List<enums.MetadataSettings$SettingsAnime>? metadataSettings$SettingsAnime,
) {
  return metadataSettings$SettingsAnime?.map((e) => e.value!).join(',') ?? '';
}

List<String> metadataSettings$SettingsAnimeListToJson(
  List<enums.MetadataSettings$SettingsAnime>? metadataSettings$SettingsAnime,
) {
  if (metadataSettings$SettingsAnime == null) {
    return [];
  }

  return metadataSettings$SettingsAnime.map((e) => e.value!).toList();
}

List<enums.MetadataSettings$SettingsAnime>
metadataSettings$SettingsAnimeListFromJson(
  List? metadataSettings$SettingsAnime, [
  List<enums.MetadataSettings$SettingsAnime>? defaultValue,
]) {
  if (metadataSettings$SettingsAnime == null) {
    return defaultValue ?? [];
  }

  return metadataSettings$SettingsAnime
      .map((e) => metadataSettings$SettingsAnimeFromJson(e.toString()))
      .toList();
}

List<enums.MetadataSettings$SettingsAnime>?
metadataSettings$SettingsAnimeNullableListFromJson(
  List? metadataSettings$SettingsAnime, [
  List<enums.MetadataSettings$SettingsAnime>? defaultValue,
]) {
  if (metadataSettings$SettingsAnime == null) {
    return defaultValue;
  }

  return metadataSettings$SettingsAnime
      .map((e) => metadataSettings$SettingsAnimeFromJson(e.toString()))
      .toList();
}

String? relatedVideoTypeNullableToJson(
  enums.RelatedVideoType? relatedVideoType,
) {
  return relatedVideoType?.value;
}

String? relatedVideoTypeToJson(enums.RelatedVideoType relatedVideoType) {
  return relatedVideoType.value;
}

enums.RelatedVideoType relatedVideoTypeFromJson(
  Object? relatedVideoType, [
  enums.RelatedVideoType? defaultValue,
]) {
  return enums.RelatedVideoType.values.firstWhereOrNull(
        (e) => e.value == relatedVideoType,
      ) ??
      defaultValue ??
      enums.RelatedVideoType.swaggerGeneratedUnknown;
}

enums.RelatedVideoType? relatedVideoTypeNullableFromJson(
  Object? relatedVideoType, [
  enums.RelatedVideoType? defaultValue,
]) {
  if (relatedVideoType == null) {
    return null;
  }
  return enums.RelatedVideoType.values.firstWhereOrNull(
        (e) => e.value == relatedVideoType,
      ) ??
      defaultValue;
}

String relatedVideoTypeExplodedListToJson(
  List<enums.RelatedVideoType>? relatedVideoType,
) {
  return relatedVideoType?.map((e) => e.value!).join(',') ?? '';
}

List<String> relatedVideoTypeListToJson(
  List<enums.RelatedVideoType>? relatedVideoType,
) {
  if (relatedVideoType == null) {
    return [];
  }

  return relatedVideoType.map((e) => e.value!).toList();
}

List<enums.RelatedVideoType> relatedVideoTypeListFromJson(
  List? relatedVideoType, [
  List<enums.RelatedVideoType>? defaultValue,
]) {
  if (relatedVideoType == null) {
    return defaultValue ?? [];
  }

  return relatedVideoType
      .map((e) => relatedVideoTypeFromJson(e.toString()))
      .toList();
}

List<enums.RelatedVideoType>? relatedVideoTypeNullableListFromJson(
  List? relatedVideoType, [
  List<enums.RelatedVideoType>? defaultValue,
]) {
  if (relatedVideoType == null) {
    return defaultValue;
  }

  return relatedVideoType
      .map((e) => relatedVideoTypeFromJson(e.toString()))
      .toList();
}

String? relatedVideoSiteNullableToJson(
  enums.RelatedVideoSite? relatedVideoSite,
) {
  return relatedVideoSite?.value;
}

String? relatedVideoSiteToJson(enums.RelatedVideoSite relatedVideoSite) {
  return relatedVideoSite.value;
}

enums.RelatedVideoSite relatedVideoSiteFromJson(
  Object? relatedVideoSite, [
  enums.RelatedVideoSite? defaultValue,
]) {
  return enums.RelatedVideoSite.values.firstWhereOrNull(
        (e) => e.value == relatedVideoSite,
      ) ??
      defaultValue ??
      enums.RelatedVideoSite.swaggerGeneratedUnknown;
}

enums.RelatedVideoSite? relatedVideoSiteNullableFromJson(
  Object? relatedVideoSite, [
  enums.RelatedVideoSite? defaultValue,
]) {
  if (relatedVideoSite == null) {
    return null;
  }
  return enums.RelatedVideoSite.values.firstWhereOrNull(
        (e) => e.value == relatedVideoSite,
      ) ??
      defaultValue;
}

String relatedVideoSiteExplodedListToJson(
  List<enums.RelatedVideoSite>? relatedVideoSite,
) {
  return relatedVideoSite?.map((e) => e.value!).join(',') ?? '';
}

List<String> relatedVideoSiteListToJson(
  List<enums.RelatedVideoSite>? relatedVideoSite,
) {
  if (relatedVideoSite == null) {
    return [];
  }

  return relatedVideoSite.map((e) => e.value!).toList();
}

List<enums.RelatedVideoSite> relatedVideoSiteListFromJson(
  List? relatedVideoSite, [
  List<enums.RelatedVideoSite>? defaultValue,
]) {
  if (relatedVideoSite == null) {
    return defaultValue ?? [];
  }

  return relatedVideoSite
      .map((e) => relatedVideoSiteFromJson(e.toString()))
      .toList();
}

List<enums.RelatedVideoSite>? relatedVideoSiteNullableListFromJson(
  List? relatedVideoSite, [
  List<enums.RelatedVideoSite>? defaultValue,
]) {
  if (relatedVideoSite == null) {
    return defaultValue;
  }

  return relatedVideoSite
      .map((e) => relatedVideoSiteFromJson(e.toString()))
      .toList();
}

String? jobTypeNullableToJson(enums.JobType? jobType) {
  return jobType?.value;
}

String? jobTypeToJson(enums.JobType jobType) {
  return jobType.value;
}

enums.JobType jobTypeFromJson(Object? jobType, [enums.JobType? defaultValue]) {
  return enums.JobType.values.firstWhereOrNull((e) => e.value == jobType) ??
      defaultValue ??
      enums.JobType.swaggerGeneratedUnknown;
}

enums.JobType? jobTypeNullableFromJson(
  Object? jobType, [
  enums.JobType? defaultValue,
]) {
  if (jobType == null) {
    return null;
  }
  return enums.JobType.values.firstWhereOrNull((e) => e.value == jobType) ??
      defaultValue;
}

String jobTypeExplodedListToJson(List<enums.JobType>? jobType) {
  return jobType?.map((e) => e.value!).join(',') ?? '';
}

List<String> jobTypeListToJson(List<enums.JobType>? jobType) {
  if (jobType == null) {
    return [];
  }

  return jobType.map((e) => e.value!).toList();
}

List<enums.JobType> jobTypeListFromJson(
  List? jobType, [
  List<enums.JobType>? defaultValue,
]) {
  if (jobType == null) {
    return defaultValue ?? [];
  }

  return jobType.map((e) => jobTypeFromJson(e.toString())).toList();
}

List<enums.JobType>? jobTypeNullableListFromJson(
  List? jobType, [
  List<enums.JobType>? defaultValue,
]) {
  if (jobType == null) {
    return defaultValue;
  }

  return jobType.map((e) => jobTypeFromJson(e.toString())).toList();
}

String? jobIntervalNullableToJson(enums.JobInterval? jobInterval) {
  return jobInterval?.value;
}

String? jobIntervalToJson(enums.JobInterval jobInterval) {
  return jobInterval.value;
}

enums.JobInterval jobIntervalFromJson(
  Object? jobInterval, [
  enums.JobInterval? defaultValue,
]) {
  return enums.JobInterval.values.firstWhereOrNull(
        (e) => e.value == jobInterval,
      ) ??
      defaultValue ??
      enums.JobInterval.swaggerGeneratedUnknown;
}

enums.JobInterval? jobIntervalNullableFromJson(
  Object? jobInterval, [
  enums.JobInterval? defaultValue,
]) {
  if (jobInterval == null) {
    return null;
  }
  return enums.JobInterval.values.firstWhereOrNull(
        (e) => e.value == jobInterval,
      ) ??
      defaultValue;
}

String jobIntervalExplodedListToJson(List<enums.JobInterval>? jobInterval) {
  return jobInterval?.map((e) => e.value!).join(',') ?? '';
}

List<String> jobIntervalListToJson(List<enums.JobInterval>? jobInterval) {
  if (jobInterval == null) {
    return [];
  }

  return jobInterval.map((e) => e.value!).toList();
}

List<enums.JobInterval> jobIntervalListFromJson(
  List? jobInterval, [
  List<enums.JobInterval>? defaultValue,
]) {
  if (jobInterval == null) {
    return defaultValue ?? [];
  }

  return jobInterval.map((e) => jobIntervalFromJson(e.toString())).toList();
}

List<enums.JobInterval>? jobIntervalNullableListFromJson(
  List? jobInterval, [
  List<enums.JobInterval>? defaultValue,
]) {
  if (jobInterval == null) {
    return defaultValue;
  }

  return jobInterval.map((e) => jobIntervalFromJson(e.toString())).toList();
}

String? settingsLogsGetFilterNullableToJson(
  enums.SettingsLogsGetFilter? settingsLogsGetFilter,
) {
  return settingsLogsGetFilter?.value;
}

String? settingsLogsGetFilterToJson(
  enums.SettingsLogsGetFilter settingsLogsGetFilter,
) {
  return settingsLogsGetFilter.value;
}

enums.SettingsLogsGetFilter settingsLogsGetFilterFromJson(
  Object? settingsLogsGetFilter, [
  enums.SettingsLogsGetFilter? defaultValue,
]) {
  return enums.SettingsLogsGetFilter.values.firstWhereOrNull(
        (e) => e.value == settingsLogsGetFilter,
      ) ??
      defaultValue ??
      enums.SettingsLogsGetFilter.swaggerGeneratedUnknown;
}

enums.SettingsLogsGetFilter? settingsLogsGetFilterNullableFromJson(
  Object? settingsLogsGetFilter, [
  enums.SettingsLogsGetFilter? defaultValue,
]) {
  if (settingsLogsGetFilter == null) {
    return null;
  }
  return enums.SettingsLogsGetFilter.values.firstWhereOrNull(
        (e) => e.value == settingsLogsGetFilter,
      ) ??
      defaultValue;
}

String settingsLogsGetFilterExplodedListToJson(
  List<enums.SettingsLogsGetFilter>? settingsLogsGetFilter,
) {
  return settingsLogsGetFilter?.map((e) => e.value!).join(',') ?? '';
}

List<String> settingsLogsGetFilterListToJson(
  List<enums.SettingsLogsGetFilter>? settingsLogsGetFilter,
) {
  if (settingsLogsGetFilter == null) {
    return [];
  }

  return settingsLogsGetFilter.map((e) => e.value!).toList();
}

List<enums.SettingsLogsGetFilter> settingsLogsGetFilterListFromJson(
  List? settingsLogsGetFilter, [
  List<enums.SettingsLogsGetFilter>? defaultValue,
]) {
  if (settingsLogsGetFilter == null) {
    return defaultValue ?? [];
  }

  return settingsLogsGetFilter
      .map((e) => settingsLogsGetFilterFromJson(e.toString()))
      .toList();
}

List<enums.SettingsLogsGetFilter>? settingsLogsGetFilterNullableListFromJson(
  List? settingsLogsGetFilter, [
  List<enums.SettingsLogsGetFilter>? defaultValue,
]) {
  if (settingsLogsGetFilter == null) {
    return defaultValue;
  }

  return settingsLogsGetFilter
      .map((e) => settingsLogsGetFilterFromJson(e.toString()))
      .toList();
}

String? userGetSortNullableToJson(enums.UserGetSort? userGetSort) {
  return userGetSort?.value;
}

String? userGetSortToJson(enums.UserGetSort userGetSort) {
  return userGetSort.value;
}

enums.UserGetSort userGetSortFromJson(
  Object? userGetSort, [
  enums.UserGetSort? defaultValue,
]) {
  return enums.UserGetSort.values.firstWhereOrNull(
        (e) => e.value == userGetSort,
      ) ??
      defaultValue ??
      enums.UserGetSort.swaggerGeneratedUnknown;
}

enums.UserGetSort? userGetSortNullableFromJson(
  Object? userGetSort, [
  enums.UserGetSort? defaultValue,
]) {
  if (userGetSort == null) {
    return null;
  }
  return enums.UserGetSort.values.firstWhereOrNull(
        (e) => e.value == userGetSort,
      ) ??
      defaultValue;
}

String userGetSortExplodedListToJson(List<enums.UserGetSort>? userGetSort) {
  return userGetSort?.map((e) => e.value!).join(',') ?? '';
}

List<String> userGetSortListToJson(List<enums.UserGetSort>? userGetSort) {
  if (userGetSort == null) {
    return [];
  }

  return userGetSort.map((e) => e.value!).toList();
}

List<enums.UserGetSort> userGetSortListFromJson(
  List? userGetSort, [
  List<enums.UserGetSort>? defaultValue,
]) {
  if (userGetSort == null) {
    return defaultValue ?? [];
  }

  return userGetSort.map((e) => userGetSortFromJson(e.toString())).toList();
}

List<enums.UserGetSort>? userGetSortNullableListFromJson(
  List? userGetSort, [
  List<enums.UserGetSort>? defaultValue,
]) {
  if (userGetSort == null) {
    return defaultValue;
  }

  return userGetSort.map((e) => userGetSortFromJson(e.toString())).toList();
}

String? blacklistGetFilterNullableToJson(
  enums.BlacklistGetFilter? blacklistGetFilter,
) {
  return blacklistGetFilter?.value;
}

String? blacklistGetFilterToJson(enums.BlacklistGetFilter blacklistGetFilter) {
  return blacklistGetFilter.value;
}

enums.BlacklistGetFilter blacklistGetFilterFromJson(
  Object? blacklistGetFilter, [
  enums.BlacklistGetFilter? defaultValue,
]) {
  return enums.BlacklistGetFilter.values.firstWhereOrNull(
        (e) => e.value == blacklistGetFilter,
      ) ??
      defaultValue ??
      enums.BlacklistGetFilter.swaggerGeneratedUnknown;
}

enums.BlacklistGetFilter? blacklistGetFilterNullableFromJson(
  Object? blacklistGetFilter, [
  enums.BlacklistGetFilter? defaultValue,
]) {
  if (blacklistGetFilter == null) {
    return null;
  }
  return enums.BlacklistGetFilter.values.firstWhereOrNull(
        (e) => e.value == blacklistGetFilter,
      ) ??
      defaultValue;
}

String blacklistGetFilterExplodedListToJson(
  List<enums.BlacklistGetFilter>? blacklistGetFilter,
) {
  return blacklistGetFilter?.map((e) => e.value!).join(',') ?? '';
}

List<String> blacklistGetFilterListToJson(
  List<enums.BlacklistGetFilter>? blacklistGetFilter,
) {
  if (blacklistGetFilter == null) {
    return [];
  }

  return blacklistGetFilter.map((e) => e.value!).toList();
}

List<enums.BlacklistGetFilter> blacklistGetFilterListFromJson(
  List? blacklistGetFilter, [
  List<enums.BlacklistGetFilter>? defaultValue,
]) {
  if (blacklistGetFilter == null) {
    return defaultValue ?? [];
  }

  return blacklistGetFilter
      .map((e) => blacklistGetFilterFromJson(e.toString()))
      .toList();
}

List<enums.BlacklistGetFilter>? blacklistGetFilterNullableListFromJson(
  List? blacklistGetFilter, [
  List<enums.BlacklistGetFilter>? defaultValue,
]) {
  if (blacklistGetFilter == null) {
    return defaultValue;
  }

  return blacklistGetFilter
      .map((e) => blacklistGetFilterFromJson(e.toString()))
      .toList();
}

String? discoverMoviesGetCertificationModeNullableToJson(
  enums.DiscoverMoviesGetCertificationMode? discoverMoviesGetCertificationMode,
) {
  return discoverMoviesGetCertificationMode?.value;
}

String? discoverMoviesGetCertificationModeToJson(
  enums.DiscoverMoviesGetCertificationMode discoverMoviesGetCertificationMode,
) {
  return discoverMoviesGetCertificationMode.value;
}

enums.DiscoverMoviesGetCertificationMode
discoverMoviesGetCertificationModeFromJson(
  Object? discoverMoviesGetCertificationMode, [
  enums.DiscoverMoviesGetCertificationMode? defaultValue,
]) {
  return enums.DiscoverMoviesGetCertificationMode.values.firstWhereOrNull(
        (e) => e.value == discoverMoviesGetCertificationMode,
      ) ??
      defaultValue ??
      enums.DiscoverMoviesGetCertificationMode.swaggerGeneratedUnknown;
}

enums.DiscoverMoviesGetCertificationMode?
discoverMoviesGetCertificationModeNullableFromJson(
  Object? discoverMoviesGetCertificationMode, [
  enums.DiscoverMoviesGetCertificationMode? defaultValue,
]) {
  if (discoverMoviesGetCertificationMode == null) {
    return null;
  }
  return enums.DiscoverMoviesGetCertificationMode.values.firstWhereOrNull(
        (e) => e.value == discoverMoviesGetCertificationMode,
      ) ??
      defaultValue;
}

String discoverMoviesGetCertificationModeExplodedListToJson(
  List<enums.DiscoverMoviesGetCertificationMode>?
  discoverMoviesGetCertificationMode,
) {
  return discoverMoviesGetCertificationMode?.map((e) => e.value!).join(',') ??
      '';
}

List<String> discoverMoviesGetCertificationModeListToJson(
  List<enums.DiscoverMoviesGetCertificationMode>?
  discoverMoviesGetCertificationMode,
) {
  if (discoverMoviesGetCertificationMode == null) {
    return [];
  }

  return discoverMoviesGetCertificationMode.map((e) => e.value!).toList();
}

List<enums.DiscoverMoviesGetCertificationMode>
discoverMoviesGetCertificationModeListFromJson(
  List? discoverMoviesGetCertificationMode, [
  List<enums.DiscoverMoviesGetCertificationMode>? defaultValue,
]) {
  if (discoverMoviesGetCertificationMode == null) {
    return defaultValue ?? [];
  }

  return discoverMoviesGetCertificationMode
      .map((e) => discoverMoviesGetCertificationModeFromJson(e.toString()))
      .toList();
}

List<enums.DiscoverMoviesGetCertificationMode>?
discoverMoviesGetCertificationModeNullableListFromJson(
  List? discoverMoviesGetCertificationMode, [
  List<enums.DiscoverMoviesGetCertificationMode>? defaultValue,
]) {
  if (discoverMoviesGetCertificationMode == null) {
    return defaultValue;
  }

  return discoverMoviesGetCertificationMode
      .map((e) => discoverMoviesGetCertificationModeFromJson(e.toString()))
      .toList();
}

String? discoverTvGetCertificationModeNullableToJson(
  enums.DiscoverTvGetCertificationMode? discoverTvGetCertificationMode,
) {
  return discoverTvGetCertificationMode?.value;
}

String? discoverTvGetCertificationModeToJson(
  enums.DiscoverTvGetCertificationMode discoverTvGetCertificationMode,
) {
  return discoverTvGetCertificationMode.value;
}

enums.DiscoverTvGetCertificationMode discoverTvGetCertificationModeFromJson(
  Object? discoverTvGetCertificationMode, [
  enums.DiscoverTvGetCertificationMode? defaultValue,
]) {
  return enums.DiscoverTvGetCertificationMode.values.firstWhereOrNull(
        (e) => e.value == discoverTvGetCertificationMode,
      ) ??
      defaultValue ??
      enums.DiscoverTvGetCertificationMode.swaggerGeneratedUnknown;
}

enums.DiscoverTvGetCertificationMode?
discoverTvGetCertificationModeNullableFromJson(
  Object? discoverTvGetCertificationMode, [
  enums.DiscoverTvGetCertificationMode? defaultValue,
]) {
  if (discoverTvGetCertificationMode == null) {
    return null;
  }
  return enums.DiscoverTvGetCertificationMode.values.firstWhereOrNull(
        (e) => e.value == discoverTvGetCertificationMode,
      ) ??
      defaultValue;
}

String discoverTvGetCertificationModeExplodedListToJson(
  List<enums.DiscoverTvGetCertificationMode>? discoverTvGetCertificationMode,
) {
  return discoverTvGetCertificationMode?.map((e) => e.value!).join(',') ?? '';
}

List<String> discoverTvGetCertificationModeListToJson(
  List<enums.DiscoverTvGetCertificationMode>? discoverTvGetCertificationMode,
) {
  if (discoverTvGetCertificationMode == null) {
    return [];
  }

  return discoverTvGetCertificationMode.map((e) => e.value!).toList();
}

List<enums.DiscoverTvGetCertificationMode>
discoverTvGetCertificationModeListFromJson(
  List? discoverTvGetCertificationMode, [
  List<enums.DiscoverTvGetCertificationMode>? defaultValue,
]) {
  if (discoverTvGetCertificationMode == null) {
    return defaultValue ?? [];
  }

  return discoverTvGetCertificationMode
      .map((e) => discoverTvGetCertificationModeFromJson(e.toString()))
      .toList();
}

List<enums.DiscoverTvGetCertificationMode>?
discoverTvGetCertificationModeNullableListFromJson(
  List? discoverTvGetCertificationMode, [
  List<enums.DiscoverTvGetCertificationMode>? defaultValue,
]) {
  if (discoverTvGetCertificationMode == null) {
    return defaultValue;
  }

  return discoverTvGetCertificationMode
      .map((e) => discoverTvGetCertificationModeFromJson(e.toString()))
      .toList();
}

String? requestGetFilterNullableToJson(
  enums.RequestGetFilter? requestGetFilter,
) {
  return requestGetFilter?.value;
}

String? requestGetFilterToJson(enums.RequestGetFilter requestGetFilter) {
  return requestGetFilter.value;
}

enums.RequestGetFilter requestGetFilterFromJson(
  Object? requestGetFilter, [
  enums.RequestGetFilter? defaultValue,
]) {
  return enums.RequestGetFilter.values.firstWhereOrNull(
        (e) => e.value == requestGetFilter,
      ) ??
      defaultValue ??
      enums.RequestGetFilter.swaggerGeneratedUnknown;
}

enums.RequestGetFilter? requestGetFilterNullableFromJson(
  Object? requestGetFilter, [
  enums.RequestGetFilter? defaultValue,
]) {
  if (requestGetFilter == null) {
    return null;
  }
  return enums.RequestGetFilter.values.firstWhereOrNull(
        (e) => e.value == requestGetFilter,
      ) ??
      defaultValue;
}

String requestGetFilterExplodedListToJson(
  List<enums.RequestGetFilter>? requestGetFilter,
) {
  return requestGetFilter?.map((e) => e.value!).join(',') ?? '';
}

List<String> requestGetFilterListToJson(
  List<enums.RequestGetFilter>? requestGetFilter,
) {
  if (requestGetFilter == null) {
    return [];
  }

  return requestGetFilter.map((e) => e.value!).toList();
}

List<enums.RequestGetFilter> requestGetFilterListFromJson(
  List? requestGetFilter, [
  List<enums.RequestGetFilter>? defaultValue,
]) {
  if (requestGetFilter == null) {
    return defaultValue ?? [];
  }

  return requestGetFilter
      .map((e) => requestGetFilterFromJson(e.toString()))
      .toList();
}

List<enums.RequestGetFilter>? requestGetFilterNullableListFromJson(
  List? requestGetFilter, [
  List<enums.RequestGetFilter>? defaultValue,
]) {
  if (requestGetFilter == null) {
    return defaultValue;
  }

  return requestGetFilter
      .map((e) => requestGetFilterFromJson(e.toString()))
      .toList();
}

String? requestGetSortNullableToJson(enums.RequestGetSort? requestGetSort) {
  return requestGetSort?.value;
}

String? requestGetSortToJson(enums.RequestGetSort requestGetSort) {
  return requestGetSort.value;
}

enums.RequestGetSort requestGetSortFromJson(
  Object? requestGetSort, [
  enums.RequestGetSort? defaultValue,
]) {
  return enums.RequestGetSort.values.firstWhereOrNull(
        (e) => e.value == requestGetSort,
      ) ??
      defaultValue ??
      enums.RequestGetSort.swaggerGeneratedUnknown;
}

enums.RequestGetSort? requestGetSortNullableFromJson(
  Object? requestGetSort, [
  enums.RequestGetSort? defaultValue,
]) {
  if (requestGetSort == null) {
    return null;
  }
  return enums.RequestGetSort.values.firstWhereOrNull(
        (e) => e.value == requestGetSort,
      ) ??
      defaultValue;
}

String requestGetSortExplodedListToJson(
  List<enums.RequestGetSort>? requestGetSort,
) {
  return requestGetSort?.map((e) => e.value!).join(',') ?? '';
}

List<String> requestGetSortListToJson(
  List<enums.RequestGetSort>? requestGetSort,
) {
  if (requestGetSort == null) {
    return [];
  }

  return requestGetSort.map((e) => e.value!).toList();
}

List<enums.RequestGetSort> requestGetSortListFromJson(
  List? requestGetSort, [
  List<enums.RequestGetSort>? defaultValue,
]) {
  if (requestGetSort == null) {
    return defaultValue ?? [];
  }

  return requestGetSort
      .map((e) => requestGetSortFromJson(e.toString()))
      .toList();
}

List<enums.RequestGetSort>? requestGetSortNullableListFromJson(
  List? requestGetSort, [
  List<enums.RequestGetSort>? defaultValue,
]) {
  if (requestGetSort == null) {
    return defaultValue;
  }

  return requestGetSort
      .map((e) => requestGetSortFromJson(e.toString()))
      .toList();
}

String? requestGetSortDirectionNullableToJson(
  enums.RequestGetSortDirection? requestGetSortDirection,
) {
  return requestGetSortDirection?.value;
}

String? requestGetSortDirectionToJson(
  enums.RequestGetSortDirection requestGetSortDirection,
) {
  return requestGetSortDirection.value;
}

enums.RequestGetSortDirection requestGetSortDirectionFromJson(
  Object? requestGetSortDirection, [
  enums.RequestGetSortDirection? defaultValue,
]) {
  return enums.RequestGetSortDirection.values.firstWhereOrNull(
        (e) => e.value == requestGetSortDirection,
      ) ??
      defaultValue ??
      enums.RequestGetSortDirection.swaggerGeneratedUnknown;
}

enums.RequestGetSortDirection? requestGetSortDirectionNullableFromJson(
  Object? requestGetSortDirection, [
  enums.RequestGetSortDirection? defaultValue,
]) {
  if (requestGetSortDirection == null) {
    return null;
  }
  return enums.RequestGetSortDirection.values.firstWhereOrNull(
        (e) => e.value == requestGetSortDirection,
      ) ??
      defaultValue;
}

String requestGetSortDirectionExplodedListToJson(
  List<enums.RequestGetSortDirection>? requestGetSortDirection,
) {
  return requestGetSortDirection?.map((e) => e.value!).join(',') ?? '';
}

List<String> requestGetSortDirectionListToJson(
  List<enums.RequestGetSortDirection>? requestGetSortDirection,
) {
  if (requestGetSortDirection == null) {
    return [];
  }

  return requestGetSortDirection.map((e) => e.value!).toList();
}

List<enums.RequestGetSortDirection> requestGetSortDirectionListFromJson(
  List? requestGetSortDirection, [
  List<enums.RequestGetSortDirection>? defaultValue,
]) {
  if (requestGetSortDirection == null) {
    return defaultValue ?? [];
  }

  return requestGetSortDirection
      .map((e) => requestGetSortDirectionFromJson(e.toString()))
      .toList();
}

List<enums.RequestGetSortDirection>?
requestGetSortDirectionNullableListFromJson(
  List? requestGetSortDirection, [
  List<enums.RequestGetSortDirection>? defaultValue,
]) {
  if (requestGetSortDirection == null) {
    return defaultValue;
  }

  return requestGetSortDirection
      .map((e) => requestGetSortDirectionFromJson(e.toString()))
      .toList();
}

String? requestGetMediaTypeNullableToJson(
  enums.RequestGetMediaType? requestGetMediaType,
) {
  return requestGetMediaType?.value;
}

String? requestGetMediaTypeToJson(
  enums.RequestGetMediaType requestGetMediaType,
) {
  return requestGetMediaType.value;
}

enums.RequestGetMediaType requestGetMediaTypeFromJson(
  Object? requestGetMediaType, [
  enums.RequestGetMediaType? defaultValue,
]) {
  return enums.RequestGetMediaType.values.firstWhereOrNull(
        (e) => e.value == requestGetMediaType,
      ) ??
      defaultValue ??
      enums.RequestGetMediaType.swaggerGeneratedUnknown;
}

enums.RequestGetMediaType? requestGetMediaTypeNullableFromJson(
  Object? requestGetMediaType, [
  enums.RequestGetMediaType? defaultValue,
]) {
  if (requestGetMediaType == null) {
    return null;
  }
  return enums.RequestGetMediaType.values.firstWhereOrNull(
        (e) => e.value == requestGetMediaType,
      ) ??
      defaultValue;
}

String requestGetMediaTypeExplodedListToJson(
  List<enums.RequestGetMediaType>? requestGetMediaType,
) {
  return requestGetMediaType?.map((e) => e.value!).join(',') ?? '';
}

List<String> requestGetMediaTypeListToJson(
  List<enums.RequestGetMediaType>? requestGetMediaType,
) {
  if (requestGetMediaType == null) {
    return [];
  }

  return requestGetMediaType.map((e) => e.value!).toList();
}

List<enums.RequestGetMediaType> requestGetMediaTypeListFromJson(
  List? requestGetMediaType, [
  List<enums.RequestGetMediaType>? defaultValue,
]) {
  if (requestGetMediaType == null) {
    return defaultValue ?? [];
  }

  return requestGetMediaType
      .map((e) => requestGetMediaTypeFromJson(e.toString()))
      .toList();
}

List<enums.RequestGetMediaType>? requestGetMediaTypeNullableListFromJson(
  List? requestGetMediaType, [
  List<enums.RequestGetMediaType>? defaultValue,
]) {
  if (requestGetMediaType == null) {
    return defaultValue;
  }

  return requestGetMediaType
      .map((e) => requestGetMediaTypeFromJson(e.toString()))
      .toList();
}

String? requestRequestIdStatusPostStatusNullableToJson(
  enums.RequestRequestIdStatusPostStatus? requestRequestIdStatusPostStatus,
) {
  return requestRequestIdStatusPostStatus?.value;
}

String? requestRequestIdStatusPostStatusToJson(
  enums.RequestRequestIdStatusPostStatus requestRequestIdStatusPostStatus,
) {
  return requestRequestIdStatusPostStatus.value;
}

enums.RequestRequestIdStatusPostStatus requestRequestIdStatusPostStatusFromJson(
  Object? requestRequestIdStatusPostStatus, [
  enums.RequestRequestIdStatusPostStatus? defaultValue,
]) {
  return enums.RequestRequestIdStatusPostStatus.values.firstWhereOrNull(
        (e) => e.value == requestRequestIdStatusPostStatus,
      ) ??
      defaultValue ??
      enums.RequestRequestIdStatusPostStatus.swaggerGeneratedUnknown;
}

enums.RequestRequestIdStatusPostStatus?
requestRequestIdStatusPostStatusNullableFromJson(
  Object? requestRequestIdStatusPostStatus, [
  enums.RequestRequestIdStatusPostStatus? defaultValue,
]) {
  if (requestRequestIdStatusPostStatus == null) {
    return null;
  }
  return enums.RequestRequestIdStatusPostStatus.values.firstWhereOrNull(
        (e) => e.value == requestRequestIdStatusPostStatus,
      ) ??
      defaultValue;
}

String requestRequestIdStatusPostStatusExplodedListToJson(
  List<enums.RequestRequestIdStatusPostStatus>?
  requestRequestIdStatusPostStatus,
) {
  return requestRequestIdStatusPostStatus?.map((e) => e.value!).join(',') ?? '';
}

List<String> requestRequestIdStatusPostStatusListToJson(
  List<enums.RequestRequestIdStatusPostStatus>?
  requestRequestIdStatusPostStatus,
) {
  if (requestRequestIdStatusPostStatus == null) {
    return [];
  }

  return requestRequestIdStatusPostStatus.map((e) => e.value!).toList();
}

List<enums.RequestRequestIdStatusPostStatus>
requestRequestIdStatusPostStatusListFromJson(
  List? requestRequestIdStatusPostStatus, [
  List<enums.RequestRequestIdStatusPostStatus>? defaultValue,
]) {
  if (requestRequestIdStatusPostStatus == null) {
    return defaultValue ?? [];
  }

  return requestRequestIdStatusPostStatus
      .map((e) => requestRequestIdStatusPostStatusFromJson(e.toString()))
      .toList();
}

List<enums.RequestRequestIdStatusPostStatus>?
requestRequestIdStatusPostStatusNullableListFromJson(
  List? requestRequestIdStatusPostStatus, [
  List<enums.RequestRequestIdStatusPostStatus>? defaultValue,
]) {
  if (requestRequestIdStatusPostStatus == null) {
    return defaultValue;
  }

  return requestRequestIdStatusPostStatus
      .map((e) => requestRequestIdStatusPostStatusFromJson(e.toString()))
      .toList();
}

String? movieMovieIdRatingsGet$ResponseCriticsRatingNullableToJson(
  enums.MovieMovieIdRatingsGet$ResponseCriticsRating?
  movieMovieIdRatingsGet$ResponseCriticsRating,
) {
  return movieMovieIdRatingsGet$ResponseCriticsRating?.value;
}

String? movieMovieIdRatingsGet$ResponseCriticsRatingToJson(
  enums.MovieMovieIdRatingsGet$ResponseCriticsRating
  movieMovieIdRatingsGet$ResponseCriticsRating,
) {
  return movieMovieIdRatingsGet$ResponseCriticsRating.value;
}

enums.MovieMovieIdRatingsGet$ResponseCriticsRating
movieMovieIdRatingsGet$ResponseCriticsRatingFromJson(
  Object? movieMovieIdRatingsGet$ResponseCriticsRating, [
  enums.MovieMovieIdRatingsGet$ResponseCriticsRating? defaultValue,
]) {
  return enums.MovieMovieIdRatingsGet$ResponseCriticsRating.values
          .firstWhereOrNull(
            (e) => e.value == movieMovieIdRatingsGet$ResponseCriticsRating,
          ) ??
      defaultValue ??
      enums
          .MovieMovieIdRatingsGet$ResponseCriticsRating
          .swaggerGeneratedUnknown;
}

enums.MovieMovieIdRatingsGet$ResponseCriticsRating?
movieMovieIdRatingsGet$ResponseCriticsRatingNullableFromJson(
  Object? movieMovieIdRatingsGet$ResponseCriticsRating, [
  enums.MovieMovieIdRatingsGet$ResponseCriticsRating? defaultValue,
]) {
  if (movieMovieIdRatingsGet$ResponseCriticsRating == null) {
    return null;
  }
  return enums.MovieMovieIdRatingsGet$ResponseCriticsRating.values
          .firstWhereOrNull(
            (e) => e.value == movieMovieIdRatingsGet$ResponseCriticsRating,
          ) ??
      defaultValue;
}

String movieMovieIdRatingsGet$ResponseCriticsRatingExplodedListToJson(
  List<enums.MovieMovieIdRatingsGet$ResponseCriticsRating>?
  movieMovieIdRatingsGet$ResponseCriticsRating,
) {
  return movieMovieIdRatingsGet$ResponseCriticsRating
          ?.map((e) => e.value!)
          .join(',') ??
      '';
}

List<String> movieMovieIdRatingsGet$ResponseCriticsRatingListToJson(
  List<enums.MovieMovieIdRatingsGet$ResponseCriticsRating>?
  movieMovieIdRatingsGet$ResponseCriticsRating,
) {
  if (movieMovieIdRatingsGet$ResponseCriticsRating == null) {
    return [];
  }

  return movieMovieIdRatingsGet$ResponseCriticsRating
      .map((e) => e.value!)
      .toList();
}

List<enums.MovieMovieIdRatingsGet$ResponseCriticsRating>
movieMovieIdRatingsGet$ResponseCriticsRatingListFromJson(
  List? movieMovieIdRatingsGet$ResponseCriticsRating, [
  List<enums.MovieMovieIdRatingsGet$ResponseCriticsRating>? defaultValue,
]) {
  if (movieMovieIdRatingsGet$ResponseCriticsRating == null) {
    return defaultValue ?? [];
  }

  return movieMovieIdRatingsGet$ResponseCriticsRating
      .map(
        (e) =>
            movieMovieIdRatingsGet$ResponseCriticsRatingFromJson(e.toString()),
      )
      .toList();
}

List<enums.MovieMovieIdRatingsGet$ResponseCriticsRating>?
movieMovieIdRatingsGet$ResponseCriticsRatingNullableListFromJson(
  List? movieMovieIdRatingsGet$ResponseCriticsRating, [
  List<enums.MovieMovieIdRatingsGet$ResponseCriticsRating>? defaultValue,
]) {
  if (movieMovieIdRatingsGet$ResponseCriticsRating == null) {
    return defaultValue;
  }

  return movieMovieIdRatingsGet$ResponseCriticsRating
      .map(
        (e) =>
            movieMovieIdRatingsGet$ResponseCriticsRatingFromJson(e.toString()),
      )
      .toList();
}

String? movieMovieIdRatingsGet$ResponseAudienceRatingNullableToJson(
  enums.MovieMovieIdRatingsGet$ResponseAudienceRating?
  movieMovieIdRatingsGet$ResponseAudienceRating,
) {
  return movieMovieIdRatingsGet$ResponseAudienceRating?.value;
}

String? movieMovieIdRatingsGet$ResponseAudienceRatingToJson(
  enums.MovieMovieIdRatingsGet$ResponseAudienceRating
  movieMovieIdRatingsGet$ResponseAudienceRating,
) {
  return movieMovieIdRatingsGet$ResponseAudienceRating.value;
}

enums.MovieMovieIdRatingsGet$ResponseAudienceRating
movieMovieIdRatingsGet$ResponseAudienceRatingFromJson(
  Object? movieMovieIdRatingsGet$ResponseAudienceRating, [
  enums.MovieMovieIdRatingsGet$ResponseAudienceRating? defaultValue,
]) {
  return enums.MovieMovieIdRatingsGet$ResponseAudienceRating.values
          .firstWhereOrNull(
            (e) => e.value == movieMovieIdRatingsGet$ResponseAudienceRating,
          ) ??
      defaultValue ??
      enums
          .MovieMovieIdRatingsGet$ResponseAudienceRating
          .swaggerGeneratedUnknown;
}

enums.MovieMovieIdRatingsGet$ResponseAudienceRating?
movieMovieIdRatingsGet$ResponseAudienceRatingNullableFromJson(
  Object? movieMovieIdRatingsGet$ResponseAudienceRating, [
  enums.MovieMovieIdRatingsGet$ResponseAudienceRating? defaultValue,
]) {
  if (movieMovieIdRatingsGet$ResponseAudienceRating == null) {
    return null;
  }
  return enums.MovieMovieIdRatingsGet$ResponseAudienceRating.values
          .firstWhereOrNull(
            (e) => e.value == movieMovieIdRatingsGet$ResponseAudienceRating,
          ) ??
      defaultValue;
}

String movieMovieIdRatingsGet$ResponseAudienceRatingExplodedListToJson(
  List<enums.MovieMovieIdRatingsGet$ResponseAudienceRating>?
  movieMovieIdRatingsGet$ResponseAudienceRating,
) {
  return movieMovieIdRatingsGet$ResponseAudienceRating
          ?.map((e) => e.value!)
          .join(',') ??
      '';
}

List<String> movieMovieIdRatingsGet$ResponseAudienceRatingListToJson(
  List<enums.MovieMovieIdRatingsGet$ResponseAudienceRating>?
  movieMovieIdRatingsGet$ResponseAudienceRating,
) {
  if (movieMovieIdRatingsGet$ResponseAudienceRating == null) {
    return [];
  }

  return movieMovieIdRatingsGet$ResponseAudienceRating
      .map((e) => e.value!)
      .toList();
}

List<enums.MovieMovieIdRatingsGet$ResponseAudienceRating>
movieMovieIdRatingsGet$ResponseAudienceRatingListFromJson(
  List? movieMovieIdRatingsGet$ResponseAudienceRating, [
  List<enums.MovieMovieIdRatingsGet$ResponseAudienceRating>? defaultValue,
]) {
  if (movieMovieIdRatingsGet$ResponseAudienceRating == null) {
    return defaultValue ?? [];
  }

  return movieMovieIdRatingsGet$ResponseAudienceRating
      .map(
        (e) =>
            movieMovieIdRatingsGet$ResponseAudienceRatingFromJson(e.toString()),
      )
      .toList();
}

List<enums.MovieMovieIdRatingsGet$ResponseAudienceRating>?
movieMovieIdRatingsGet$ResponseAudienceRatingNullableListFromJson(
  List? movieMovieIdRatingsGet$ResponseAudienceRating, [
  List<enums.MovieMovieIdRatingsGet$ResponseAudienceRating>? defaultValue,
]) {
  if (movieMovieIdRatingsGet$ResponseAudienceRating == null) {
    return defaultValue;
  }

  return movieMovieIdRatingsGet$ResponseAudienceRating
      .map(
        (e) =>
            movieMovieIdRatingsGet$ResponseAudienceRatingFromJson(e.toString()),
      )
      .toList();
}

String? movieMovieIdRatingscombinedGet$Response$RtCriticsRatingNullableToJson(
  enums.MovieMovieIdRatingscombinedGet$Response$RtCriticsRating?
  movieMovieIdRatingscombinedGet$Response$RtCriticsRating,
) {
  return movieMovieIdRatingscombinedGet$Response$RtCriticsRating?.value;
}

String? movieMovieIdRatingscombinedGet$Response$RtCriticsRatingToJson(
  enums.MovieMovieIdRatingscombinedGet$Response$RtCriticsRating
  movieMovieIdRatingscombinedGet$Response$RtCriticsRating,
) {
  return movieMovieIdRatingscombinedGet$Response$RtCriticsRating.value;
}

enums.MovieMovieIdRatingscombinedGet$Response$RtCriticsRating
movieMovieIdRatingscombinedGet$Response$RtCriticsRatingFromJson(
  Object? movieMovieIdRatingscombinedGet$Response$RtCriticsRating, [
  enums.MovieMovieIdRatingscombinedGet$Response$RtCriticsRating? defaultValue,
]) {
  return enums.MovieMovieIdRatingscombinedGet$Response$RtCriticsRating.values
          .firstWhereOrNull(
            (e) =>
                e.value ==
                movieMovieIdRatingscombinedGet$Response$RtCriticsRating,
          ) ??
      defaultValue ??
      enums
          .MovieMovieIdRatingscombinedGet$Response$RtCriticsRating
          .swaggerGeneratedUnknown;
}

enums.MovieMovieIdRatingscombinedGet$Response$RtCriticsRating?
movieMovieIdRatingscombinedGet$Response$RtCriticsRatingNullableFromJson(
  Object? movieMovieIdRatingscombinedGet$Response$RtCriticsRating, [
  enums.MovieMovieIdRatingscombinedGet$Response$RtCriticsRating? defaultValue,
]) {
  if (movieMovieIdRatingscombinedGet$Response$RtCriticsRating == null) {
    return null;
  }
  return enums.MovieMovieIdRatingscombinedGet$Response$RtCriticsRating.values
          .firstWhereOrNull(
            (e) =>
                e.value ==
                movieMovieIdRatingscombinedGet$Response$RtCriticsRating,
          ) ??
      defaultValue;
}

String
movieMovieIdRatingscombinedGet$Response$RtCriticsRatingExplodedListToJson(
  List<enums.MovieMovieIdRatingscombinedGet$Response$RtCriticsRating>?
  movieMovieIdRatingscombinedGet$Response$RtCriticsRating,
) {
  return movieMovieIdRatingscombinedGet$Response$RtCriticsRating
          ?.map((e) => e.value!)
          .join(',') ??
      '';
}

List<String> movieMovieIdRatingscombinedGet$Response$RtCriticsRatingListToJson(
  List<enums.MovieMovieIdRatingscombinedGet$Response$RtCriticsRating>?
  movieMovieIdRatingscombinedGet$Response$RtCriticsRating,
) {
  if (movieMovieIdRatingscombinedGet$Response$RtCriticsRating == null) {
    return [];
  }

  return movieMovieIdRatingscombinedGet$Response$RtCriticsRating
      .map((e) => e.value!)
      .toList();
}

List<enums.MovieMovieIdRatingscombinedGet$Response$RtCriticsRating>
movieMovieIdRatingscombinedGet$Response$RtCriticsRatingListFromJson(
  List? movieMovieIdRatingscombinedGet$Response$RtCriticsRating, [
  List<enums.MovieMovieIdRatingscombinedGet$Response$RtCriticsRating>?
  defaultValue,
]) {
  if (movieMovieIdRatingscombinedGet$Response$RtCriticsRating == null) {
    return defaultValue ?? [];
  }

  return movieMovieIdRatingscombinedGet$Response$RtCriticsRating
      .map(
        (e) => movieMovieIdRatingscombinedGet$Response$RtCriticsRatingFromJson(
          e.toString(),
        ),
      )
      .toList();
}

List<enums.MovieMovieIdRatingscombinedGet$Response$RtCriticsRating>?
movieMovieIdRatingscombinedGet$Response$RtCriticsRatingNullableListFromJson(
  List? movieMovieIdRatingscombinedGet$Response$RtCriticsRating, [
  List<enums.MovieMovieIdRatingscombinedGet$Response$RtCriticsRating>?
  defaultValue,
]) {
  if (movieMovieIdRatingscombinedGet$Response$RtCriticsRating == null) {
    return defaultValue;
  }

  return movieMovieIdRatingscombinedGet$Response$RtCriticsRating
      .map(
        (e) => movieMovieIdRatingscombinedGet$Response$RtCriticsRatingFromJson(
          e.toString(),
        ),
      )
      .toList();
}

String? movieMovieIdRatingscombinedGet$Response$RtAudienceRatingNullableToJson(
  enums.MovieMovieIdRatingscombinedGet$Response$RtAudienceRating?
  movieMovieIdRatingscombinedGet$Response$RtAudienceRating,
) {
  return movieMovieIdRatingscombinedGet$Response$RtAudienceRating?.value;
}

String? movieMovieIdRatingscombinedGet$Response$RtAudienceRatingToJson(
  enums.MovieMovieIdRatingscombinedGet$Response$RtAudienceRating
  movieMovieIdRatingscombinedGet$Response$RtAudienceRating,
) {
  return movieMovieIdRatingscombinedGet$Response$RtAudienceRating.value;
}

enums.MovieMovieIdRatingscombinedGet$Response$RtAudienceRating
movieMovieIdRatingscombinedGet$Response$RtAudienceRatingFromJson(
  Object? movieMovieIdRatingscombinedGet$Response$RtAudienceRating, [
  enums.MovieMovieIdRatingscombinedGet$Response$RtAudienceRating? defaultValue,
]) {
  return enums.MovieMovieIdRatingscombinedGet$Response$RtAudienceRating.values
          .firstWhereOrNull(
            (e) =>
                e.value ==
                movieMovieIdRatingscombinedGet$Response$RtAudienceRating,
          ) ??
      defaultValue ??
      enums
          .MovieMovieIdRatingscombinedGet$Response$RtAudienceRating
          .swaggerGeneratedUnknown;
}

enums.MovieMovieIdRatingscombinedGet$Response$RtAudienceRating?
movieMovieIdRatingscombinedGet$Response$RtAudienceRatingNullableFromJson(
  Object? movieMovieIdRatingscombinedGet$Response$RtAudienceRating, [
  enums.MovieMovieIdRatingscombinedGet$Response$RtAudienceRating? defaultValue,
]) {
  if (movieMovieIdRatingscombinedGet$Response$RtAudienceRating == null) {
    return null;
  }
  return enums.MovieMovieIdRatingscombinedGet$Response$RtAudienceRating.values
          .firstWhereOrNull(
            (e) =>
                e.value ==
                movieMovieIdRatingscombinedGet$Response$RtAudienceRating,
          ) ??
      defaultValue;
}

String
movieMovieIdRatingscombinedGet$Response$RtAudienceRatingExplodedListToJson(
  List<enums.MovieMovieIdRatingscombinedGet$Response$RtAudienceRating>?
  movieMovieIdRatingscombinedGet$Response$RtAudienceRating,
) {
  return movieMovieIdRatingscombinedGet$Response$RtAudienceRating
          ?.map((e) => e.value!)
          .join(',') ??
      '';
}

List<String> movieMovieIdRatingscombinedGet$Response$RtAudienceRatingListToJson(
  List<enums.MovieMovieIdRatingscombinedGet$Response$RtAudienceRating>?
  movieMovieIdRatingscombinedGet$Response$RtAudienceRating,
) {
  if (movieMovieIdRatingscombinedGet$Response$RtAudienceRating == null) {
    return [];
  }

  return movieMovieIdRatingscombinedGet$Response$RtAudienceRating
      .map((e) => e.value!)
      .toList();
}

List<enums.MovieMovieIdRatingscombinedGet$Response$RtAudienceRating>
movieMovieIdRatingscombinedGet$Response$RtAudienceRatingListFromJson(
  List? movieMovieIdRatingscombinedGet$Response$RtAudienceRating, [
  List<enums.MovieMovieIdRatingscombinedGet$Response$RtAudienceRating>?
  defaultValue,
]) {
  if (movieMovieIdRatingscombinedGet$Response$RtAudienceRating == null) {
    return defaultValue ?? [];
  }

  return movieMovieIdRatingscombinedGet$Response$RtAudienceRating
      .map(
        (e) => movieMovieIdRatingscombinedGet$Response$RtAudienceRatingFromJson(
          e.toString(),
        ),
      )
      .toList();
}

List<enums.MovieMovieIdRatingscombinedGet$Response$RtAudienceRating>?
movieMovieIdRatingscombinedGet$Response$RtAudienceRatingNullableListFromJson(
  List? movieMovieIdRatingscombinedGet$Response$RtAudienceRating, [
  List<enums.MovieMovieIdRatingscombinedGet$Response$RtAudienceRating>?
  defaultValue,
]) {
  if (movieMovieIdRatingscombinedGet$Response$RtAudienceRating == null) {
    return defaultValue;
  }

  return movieMovieIdRatingscombinedGet$Response$RtAudienceRating
      .map(
        (e) => movieMovieIdRatingscombinedGet$Response$RtAudienceRatingFromJson(
          e.toString(),
        ),
      )
      .toList();
}

String? tvTvIdRatingsGet$ResponseCriticsRatingNullableToJson(
  enums.TvTvIdRatingsGet$ResponseCriticsRating?
  tvTvIdRatingsGet$ResponseCriticsRating,
) {
  return tvTvIdRatingsGet$ResponseCriticsRating?.value;
}

String? tvTvIdRatingsGet$ResponseCriticsRatingToJson(
  enums.TvTvIdRatingsGet$ResponseCriticsRating
  tvTvIdRatingsGet$ResponseCriticsRating,
) {
  return tvTvIdRatingsGet$ResponseCriticsRating.value;
}

enums.TvTvIdRatingsGet$ResponseCriticsRating
tvTvIdRatingsGet$ResponseCriticsRatingFromJson(
  Object? tvTvIdRatingsGet$ResponseCriticsRating, [
  enums.TvTvIdRatingsGet$ResponseCriticsRating? defaultValue,
]) {
  return enums.TvTvIdRatingsGet$ResponseCriticsRating.values.firstWhereOrNull(
        (e) => e.value == tvTvIdRatingsGet$ResponseCriticsRating,
      ) ??
      defaultValue ??
      enums.TvTvIdRatingsGet$ResponseCriticsRating.swaggerGeneratedUnknown;
}

enums.TvTvIdRatingsGet$ResponseCriticsRating?
tvTvIdRatingsGet$ResponseCriticsRatingNullableFromJson(
  Object? tvTvIdRatingsGet$ResponseCriticsRating, [
  enums.TvTvIdRatingsGet$ResponseCriticsRating? defaultValue,
]) {
  if (tvTvIdRatingsGet$ResponseCriticsRating == null) {
    return null;
  }
  return enums.TvTvIdRatingsGet$ResponseCriticsRating.values.firstWhereOrNull(
        (e) => e.value == tvTvIdRatingsGet$ResponseCriticsRating,
      ) ??
      defaultValue;
}

String tvTvIdRatingsGet$ResponseCriticsRatingExplodedListToJson(
  List<enums.TvTvIdRatingsGet$ResponseCriticsRating>?
  tvTvIdRatingsGet$ResponseCriticsRating,
) {
  return tvTvIdRatingsGet$ResponseCriticsRating
          ?.map((e) => e.value!)
          .join(',') ??
      '';
}

List<String> tvTvIdRatingsGet$ResponseCriticsRatingListToJson(
  List<enums.TvTvIdRatingsGet$ResponseCriticsRating>?
  tvTvIdRatingsGet$ResponseCriticsRating,
) {
  if (tvTvIdRatingsGet$ResponseCriticsRating == null) {
    return [];
  }

  return tvTvIdRatingsGet$ResponseCriticsRating.map((e) => e.value!).toList();
}

List<enums.TvTvIdRatingsGet$ResponseCriticsRating>
tvTvIdRatingsGet$ResponseCriticsRatingListFromJson(
  List? tvTvIdRatingsGet$ResponseCriticsRating, [
  List<enums.TvTvIdRatingsGet$ResponseCriticsRating>? defaultValue,
]) {
  if (tvTvIdRatingsGet$ResponseCriticsRating == null) {
    return defaultValue ?? [];
  }

  return tvTvIdRatingsGet$ResponseCriticsRating
      .map((e) => tvTvIdRatingsGet$ResponseCriticsRatingFromJson(e.toString()))
      .toList();
}

List<enums.TvTvIdRatingsGet$ResponseCriticsRating>?
tvTvIdRatingsGet$ResponseCriticsRatingNullableListFromJson(
  List? tvTvIdRatingsGet$ResponseCriticsRating, [
  List<enums.TvTvIdRatingsGet$ResponseCriticsRating>? defaultValue,
]) {
  if (tvTvIdRatingsGet$ResponseCriticsRating == null) {
    return defaultValue;
  }

  return tvTvIdRatingsGet$ResponseCriticsRating
      .map((e) => tvTvIdRatingsGet$ResponseCriticsRatingFromJson(e.toString()))
      .toList();
}

String? mediaGetFilterNullableToJson(enums.MediaGetFilter? mediaGetFilter) {
  return mediaGetFilter?.value;
}

String? mediaGetFilterToJson(enums.MediaGetFilter mediaGetFilter) {
  return mediaGetFilter.value;
}

enums.MediaGetFilter mediaGetFilterFromJson(
  Object? mediaGetFilter, [
  enums.MediaGetFilter? defaultValue,
]) {
  return enums.MediaGetFilter.values.firstWhereOrNull(
        (e) => e.value == mediaGetFilter,
      ) ??
      defaultValue ??
      enums.MediaGetFilter.swaggerGeneratedUnknown;
}

enums.MediaGetFilter? mediaGetFilterNullableFromJson(
  Object? mediaGetFilter, [
  enums.MediaGetFilter? defaultValue,
]) {
  if (mediaGetFilter == null) {
    return null;
  }
  return enums.MediaGetFilter.values.firstWhereOrNull(
        (e) => e.value == mediaGetFilter,
      ) ??
      defaultValue;
}

String mediaGetFilterExplodedListToJson(
  List<enums.MediaGetFilter>? mediaGetFilter,
) {
  return mediaGetFilter?.map((e) => e.value!).join(',') ?? '';
}

List<String> mediaGetFilterListToJson(
  List<enums.MediaGetFilter>? mediaGetFilter,
) {
  if (mediaGetFilter == null) {
    return [];
  }

  return mediaGetFilter.map((e) => e.value!).toList();
}

List<enums.MediaGetFilter> mediaGetFilterListFromJson(
  List? mediaGetFilter, [
  List<enums.MediaGetFilter>? defaultValue,
]) {
  if (mediaGetFilter == null) {
    return defaultValue ?? [];
  }

  return mediaGetFilter
      .map((e) => mediaGetFilterFromJson(e.toString()))
      .toList();
}

List<enums.MediaGetFilter>? mediaGetFilterNullableListFromJson(
  List? mediaGetFilter, [
  List<enums.MediaGetFilter>? defaultValue,
]) {
  if (mediaGetFilter == null) {
    return defaultValue;
  }

  return mediaGetFilter
      .map((e) => mediaGetFilterFromJson(e.toString()))
      .toList();
}

String? mediaGetSortNullableToJson(enums.MediaGetSort? mediaGetSort) {
  return mediaGetSort?.value;
}

String? mediaGetSortToJson(enums.MediaGetSort mediaGetSort) {
  return mediaGetSort.value;
}

enums.MediaGetSort mediaGetSortFromJson(
  Object? mediaGetSort, [
  enums.MediaGetSort? defaultValue,
]) {
  return enums.MediaGetSort.values.firstWhereOrNull(
        (e) => e.value == mediaGetSort,
      ) ??
      defaultValue ??
      enums.MediaGetSort.swaggerGeneratedUnknown;
}

enums.MediaGetSort? mediaGetSortNullableFromJson(
  Object? mediaGetSort, [
  enums.MediaGetSort? defaultValue,
]) {
  if (mediaGetSort == null) {
    return null;
  }
  return enums.MediaGetSort.values.firstWhereOrNull(
        (e) => e.value == mediaGetSort,
      ) ??
      defaultValue;
}

String mediaGetSortExplodedListToJson(List<enums.MediaGetSort>? mediaGetSort) {
  return mediaGetSort?.map((e) => e.value!).join(',') ?? '';
}

List<String> mediaGetSortListToJson(List<enums.MediaGetSort>? mediaGetSort) {
  if (mediaGetSort == null) {
    return [];
  }

  return mediaGetSort.map((e) => e.value!).toList();
}

List<enums.MediaGetSort> mediaGetSortListFromJson(
  List? mediaGetSort, [
  List<enums.MediaGetSort>? defaultValue,
]) {
  if (mediaGetSort == null) {
    return defaultValue ?? [];
  }

  return mediaGetSort.map((e) => mediaGetSortFromJson(e.toString())).toList();
}

List<enums.MediaGetSort>? mediaGetSortNullableListFromJson(
  List? mediaGetSort, [
  List<enums.MediaGetSort>? defaultValue,
]) {
  if (mediaGetSort == null) {
    return defaultValue;
  }

  return mediaGetSort.map((e) => mediaGetSortFromJson(e.toString())).toList();
}

String? mediaMediaIdStatusPostStatusNullableToJson(
  enums.MediaMediaIdStatusPostStatus? mediaMediaIdStatusPostStatus,
) {
  return mediaMediaIdStatusPostStatus?.value;
}

String? mediaMediaIdStatusPostStatusToJson(
  enums.MediaMediaIdStatusPostStatus mediaMediaIdStatusPostStatus,
) {
  return mediaMediaIdStatusPostStatus.value;
}

enums.MediaMediaIdStatusPostStatus mediaMediaIdStatusPostStatusFromJson(
  Object? mediaMediaIdStatusPostStatus, [
  enums.MediaMediaIdStatusPostStatus? defaultValue,
]) {
  return enums.MediaMediaIdStatusPostStatus.values.firstWhereOrNull(
        (e) => e.value == mediaMediaIdStatusPostStatus,
      ) ??
      defaultValue ??
      enums.MediaMediaIdStatusPostStatus.swaggerGeneratedUnknown;
}

enums.MediaMediaIdStatusPostStatus?
mediaMediaIdStatusPostStatusNullableFromJson(
  Object? mediaMediaIdStatusPostStatus, [
  enums.MediaMediaIdStatusPostStatus? defaultValue,
]) {
  if (mediaMediaIdStatusPostStatus == null) {
    return null;
  }
  return enums.MediaMediaIdStatusPostStatus.values.firstWhereOrNull(
        (e) => e.value == mediaMediaIdStatusPostStatus,
      ) ??
      defaultValue;
}

String mediaMediaIdStatusPostStatusExplodedListToJson(
  List<enums.MediaMediaIdStatusPostStatus>? mediaMediaIdStatusPostStatus,
) {
  return mediaMediaIdStatusPostStatus?.map((e) => e.value!).join(',') ?? '';
}

List<String> mediaMediaIdStatusPostStatusListToJson(
  List<enums.MediaMediaIdStatusPostStatus>? mediaMediaIdStatusPostStatus,
) {
  if (mediaMediaIdStatusPostStatus == null) {
    return [];
  }

  return mediaMediaIdStatusPostStatus.map((e) => e.value!).toList();
}

List<enums.MediaMediaIdStatusPostStatus>
mediaMediaIdStatusPostStatusListFromJson(
  List? mediaMediaIdStatusPostStatus, [
  List<enums.MediaMediaIdStatusPostStatus>? defaultValue,
]) {
  if (mediaMediaIdStatusPostStatus == null) {
    return defaultValue ?? [];
  }

  return mediaMediaIdStatusPostStatus
      .map((e) => mediaMediaIdStatusPostStatusFromJson(e.toString()))
      .toList();
}

List<enums.MediaMediaIdStatusPostStatus>?
mediaMediaIdStatusPostStatusNullableListFromJson(
  List? mediaMediaIdStatusPostStatus, [
  List<enums.MediaMediaIdStatusPostStatus>? defaultValue,
]) {
  if (mediaMediaIdStatusPostStatus == null) {
    return defaultValue;
  }

  return mediaMediaIdStatusPostStatus
      .map((e) => mediaMediaIdStatusPostStatusFromJson(e.toString()))
      .toList();
}

String? issueGetSortNullableToJson(enums.IssueGetSort? issueGetSort) {
  return issueGetSort?.value;
}

String? issueGetSortToJson(enums.IssueGetSort issueGetSort) {
  return issueGetSort.value;
}

enums.IssueGetSort issueGetSortFromJson(
  Object? issueGetSort, [
  enums.IssueGetSort? defaultValue,
]) {
  return enums.IssueGetSort.values.firstWhereOrNull(
        (e) => e.value == issueGetSort,
      ) ??
      defaultValue ??
      enums.IssueGetSort.swaggerGeneratedUnknown;
}

enums.IssueGetSort? issueGetSortNullableFromJson(
  Object? issueGetSort, [
  enums.IssueGetSort? defaultValue,
]) {
  if (issueGetSort == null) {
    return null;
  }
  return enums.IssueGetSort.values.firstWhereOrNull(
        (e) => e.value == issueGetSort,
      ) ??
      defaultValue;
}

String issueGetSortExplodedListToJson(List<enums.IssueGetSort>? issueGetSort) {
  return issueGetSort?.map((e) => e.value!).join(',') ?? '';
}

List<String> issueGetSortListToJson(List<enums.IssueGetSort>? issueGetSort) {
  if (issueGetSort == null) {
    return [];
  }

  return issueGetSort.map((e) => e.value!).toList();
}

List<enums.IssueGetSort> issueGetSortListFromJson(
  List? issueGetSort, [
  List<enums.IssueGetSort>? defaultValue,
]) {
  if (issueGetSort == null) {
    return defaultValue ?? [];
  }

  return issueGetSort.map((e) => issueGetSortFromJson(e.toString())).toList();
}

List<enums.IssueGetSort>? issueGetSortNullableListFromJson(
  List? issueGetSort, [
  List<enums.IssueGetSort>? defaultValue,
]) {
  if (issueGetSort == null) {
    return defaultValue;
  }

  return issueGetSort.map((e) => issueGetSortFromJson(e.toString())).toList();
}

String? issueGetFilterNullableToJson(enums.IssueGetFilter? issueGetFilter) {
  return issueGetFilter?.value;
}

String? issueGetFilterToJson(enums.IssueGetFilter issueGetFilter) {
  return issueGetFilter.value;
}

enums.IssueGetFilter issueGetFilterFromJson(
  Object? issueGetFilter, [
  enums.IssueGetFilter? defaultValue,
]) {
  return enums.IssueGetFilter.values.firstWhereOrNull(
        (e) => e.value == issueGetFilter,
      ) ??
      defaultValue ??
      enums.IssueGetFilter.swaggerGeneratedUnknown;
}

enums.IssueGetFilter? issueGetFilterNullableFromJson(
  Object? issueGetFilter, [
  enums.IssueGetFilter? defaultValue,
]) {
  if (issueGetFilter == null) {
    return null;
  }
  return enums.IssueGetFilter.values.firstWhereOrNull(
        (e) => e.value == issueGetFilter,
      ) ??
      defaultValue;
}

String issueGetFilterExplodedListToJson(
  List<enums.IssueGetFilter>? issueGetFilter,
) {
  return issueGetFilter?.map((e) => e.value!).join(',') ?? '';
}

List<String> issueGetFilterListToJson(
  List<enums.IssueGetFilter>? issueGetFilter,
) {
  if (issueGetFilter == null) {
    return [];
  }

  return issueGetFilter.map((e) => e.value!).toList();
}

List<enums.IssueGetFilter> issueGetFilterListFromJson(
  List? issueGetFilter, [
  List<enums.IssueGetFilter>? defaultValue,
]) {
  if (issueGetFilter == null) {
    return defaultValue ?? [];
  }

  return issueGetFilter
      .map((e) => issueGetFilterFromJson(e.toString()))
      .toList();
}

List<enums.IssueGetFilter>? issueGetFilterNullableListFromJson(
  List? issueGetFilter, [
  List<enums.IssueGetFilter>? defaultValue,
]) {
  if (issueGetFilter == null) {
    return defaultValue;
  }

  return issueGetFilter
      .map((e) => issueGetFilterFromJson(e.toString()))
      .toList();
}

String? issueIssueIdStatusPostStatusNullableToJson(
  enums.IssueIssueIdStatusPostStatus? issueIssueIdStatusPostStatus,
) {
  return issueIssueIdStatusPostStatus?.value;
}

String? issueIssueIdStatusPostStatusToJson(
  enums.IssueIssueIdStatusPostStatus issueIssueIdStatusPostStatus,
) {
  return issueIssueIdStatusPostStatus.value;
}

enums.IssueIssueIdStatusPostStatus issueIssueIdStatusPostStatusFromJson(
  Object? issueIssueIdStatusPostStatus, [
  enums.IssueIssueIdStatusPostStatus? defaultValue,
]) {
  return enums.IssueIssueIdStatusPostStatus.values.firstWhereOrNull(
        (e) => e.value == issueIssueIdStatusPostStatus,
      ) ??
      defaultValue ??
      enums.IssueIssueIdStatusPostStatus.swaggerGeneratedUnknown;
}

enums.IssueIssueIdStatusPostStatus?
issueIssueIdStatusPostStatusNullableFromJson(
  Object? issueIssueIdStatusPostStatus, [
  enums.IssueIssueIdStatusPostStatus? defaultValue,
]) {
  if (issueIssueIdStatusPostStatus == null) {
    return null;
  }
  return enums.IssueIssueIdStatusPostStatus.values.firstWhereOrNull(
        (e) => e.value == issueIssueIdStatusPostStatus,
      ) ??
      defaultValue;
}

String issueIssueIdStatusPostStatusExplodedListToJson(
  List<enums.IssueIssueIdStatusPostStatus>? issueIssueIdStatusPostStatus,
) {
  return issueIssueIdStatusPostStatus?.map((e) => e.value!).join(',') ?? '';
}

List<String> issueIssueIdStatusPostStatusListToJson(
  List<enums.IssueIssueIdStatusPostStatus>? issueIssueIdStatusPostStatus,
) {
  if (issueIssueIdStatusPostStatus == null) {
    return [];
  }

  return issueIssueIdStatusPostStatus.map((e) => e.value!).toList();
}

List<enums.IssueIssueIdStatusPostStatus>
issueIssueIdStatusPostStatusListFromJson(
  List? issueIssueIdStatusPostStatus, [
  List<enums.IssueIssueIdStatusPostStatus>? defaultValue,
]) {
  if (issueIssueIdStatusPostStatus == null) {
    return defaultValue ?? [];
  }

  return issueIssueIdStatusPostStatus
      .map((e) => issueIssueIdStatusPostStatusFromJson(e.toString()))
      .toList();
}

List<enums.IssueIssueIdStatusPostStatus>?
issueIssueIdStatusPostStatusNullableListFromJson(
  List? issueIssueIdStatusPostStatus, [
  List<enums.IssueIssueIdStatusPostStatus>? defaultValue,
]) {
  if (issueIssueIdStatusPostStatus == null) {
    return defaultValue;
  }

  return issueIssueIdStatusPostStatus
      .map((e) => issueIssueIdStatusPostStatusFromJson(e.toString()))
      .toList();
}

String? requestPost$RequestBodyMediaTypeNullableToJson(
  enums.RequestPost$RequestBodyMediaType? requestPost$RequestBodyMediaType,
) {
  return requestPost$RequestBodyMediaType?.value;
}

String? requestPost$RequestBodyMediaTypeToJson(
  enums.RequestPost$RequestBodyMediaType requestPost$RequestBodyMediaType,
) {
  return requestPost$RequestBodyMediaType.value;
}

enums.RequestPost$RequestBodyMediaType requestPost$RequestBodyMediaTypeFromJson(
  Object? requestPost$RequestBodyMediaType, [
  enums.RequestPost$RequestBodyMediaType? defaultValue,
]) {
  return enums.RequestPost$RequestBodyMediaType.values.firstWhereOrNull(
        (e) => e.value == requestPost$RequestBodyMediaType,
      ) ??
      defaultValue ??
      enums.RequestPost$RequestBodyMediaType.swaggerGeneratedUnknown;
}

enums.RequestPost$RequestBodyMediaType?
requestPost$RequestBodyMediaTypeNullableFromJson(
  Object? requestPost$RequestBodyMediaType, [
  enums.RequestPost$RequestBodyMediaType? defaultValue,
]) {
  if (requestPost$RequestBodyMediaType == null) {
    return null;
  }
  return enums.RequestPost$RequestBodyMediaType.values.firstWhereOrNull(
        (e) => e.value == requestPost$RequestBodyMediaType,
      ) ??
      defaultValue;
}

String requestPost$RequestBodyMediaTypeExplodedListToJson(
  List<enums.RequestPost$RequestBodyMediaType>?
  requestPost$RequestBodyMediaType,
) {
  return requestPost$RequestBodyMediaType?.map((e) => e.value!).join(',') ?? '';
}

List<String> requestPost$RequestBodyMediaTypeListToJson(
  List<enums.RequestPost$RequestBodyMediaType>?
  requestPost$RequestBodyMediaType,
) {
  if (requestPost$RequestBodyMediaType == null) {
    return [];
  }

  return requestPost$RequestBodyMediaType.map((e) => e.value!).toList();
}

List<enums.RequestPost$RequestBodyMediaType>
requestPost$RequestBodyMediaTypeListFromJson(
  List? requestPost$RequestBodyMediaType, [
  List<enums.RequestPost$RequestBodyMediaType>? defaultValue,
]) {
  if (requestPost$RequestBodyMediaType == null) {
    return defaultValue ?? [];
  }

  return requestPost$RequestBodyMediaType
      .map((e) => requestPost$RequestBodyMediaTypeFromJson(e.toString()))
      .toList();
}

List<enums.RequestPost$RequestBodyMediaType>?
requestPost$RequestBodyMediaTypeNullableListFromJson(
  List? requestPost$RequestBodyMediaType, [
  List<enums.RequestPost$RequestBodyMediaType>? defaultValue,
]) {
  if (requestPost$RequestBodyMediaType == null) {
    return defaultValue;
  }

  return requestPost$RequestBodyMediaType
      .map((e) => requestPost$RequestBodyMediaTypeFromJson(e.toString()))
      .toList();
}

String? requestRequestIdPut$RequestBodyMediaTypeNullableToJson(
  enums.RequestRequestIdPut$RequestBodyMediaType?
  requestRequestIdPut$RequestBodyMediaType,
) {
  return requestRequestIdPut$RequestBodyMediaType?.value;
}

String? requestRequestIdPut$RequestBodyMediaTypeToJson(
  enums.RequestRequestIdPut$RequestBodyMediaType
  requestRequestIdPut$RequestBodyMediaType,
) {
  return requestRequestIdPut$RequestBodyMediaType.value;
}

enums.RequestRequestIdPut$RequestBodyMediaType
requestRequestIdPut$RequestBodyMediaTypeFromJson(
  Object? requestRequestIdPut$RequestBodyMediaType, [
  enums.RequestRequestIdPut$RequestBodyMediaType? defaultValue,
]) {
  return enums.RequestRequestIdPut$RequestBodyMediaType.values.firstWhereOrNull(
        (e) => e.value == requestRequestIdPut$RequestBodyMediaType,
      ) ??
      defaultValue ??
      enums.RequestRequestIdPut$RequestBodyMediaType.swaggerGeneratedUnknown;
}

enums.RequestRequestIdPut$RequestBodyMediaType?
requestRequestIdPut$RequestBodyMediaTypeNullableFromJson(
  Object? requestRequestIdPut$RequestBodyMediaType, [
  enums.RequestRequestIdPut$RequestBodyMediaType? defaultValue,
]) {
  if (requestRequestIdPut$RequestBodyMediaType == null) {
    return null;
  }
  return enums.RequestRequestIdPut$RequestBodyMediaType.values.firstWhereOrNull(
        (e) => e.value == requestRequestIdPut$RequestBodyMediaType,
      ) ??
      defaultValue;
}

String requestRequestIdPut$RequestBodyMediaTypeExplodedListToJson(
  List<enums.RequestRequestIdPut$RequestBodyMediaType>?
  requestRequestIdPut$RequestBodyMediaType,
) {
  return requestRequestIdPut$RequestBodyMediaType
          ?.map((e) => e.value!)
          .join(',') ??
      '';
}

List<String> requestRequestIdPut$RequestBodyMediaTypeListToJson(
  List<enums.RequestRequestIdPut$RequestBodyMediaType>?
  requestRequestIdPut$RequestBodyMediaType,
) {
  if (requestRequestIdPut$RequestBodyMediaType == null) {
    return [];
  }

  return requestRequestIdPut$RequestBodyMediaType.map((e) => e.value!).toList();
}

List<enums.RequestRequestIdPut$RequestBodyMediaType>
requestRequestIdPut$RequestBodyMediaTypeListFromJson(
  List? requestRequestIdPut$RequestBodyMediaType, [
  List<enums.RequestRequestIdPut$RequestBodyMediaType>? defaultValue,
]) {
  if (requestRequestIdPut$RequestBodyMediaType == null) {
    return defaultValue ?? [];
  }

  return requestRequestIdPut$RequestBodyMediaType
      .map(
        (e) => requestRequestIdPut$RequestBodyMediaTypeFromJson(e.toString()),
      )
      .toList();
}

List<enums.RequestRequestIdPut$RequestBodyMediaType>?
requestRequestIdPut$RequestBodyMediaTypeNullableListFromJson(
  List? requestRequestIdPut$RequestBodyMediaType, [
  List<enums.RequestRequestIdPut$RequestBodyMediaType>? defaultValue,
]) {
  if (requestRequestIdPut$RequestBodyMediaType == null) {
    return defaultValue;
  }

  return requestRequestIdPut$RequestBodyMediaType
      .map(
        (e) => requestRequestIdPut$RequestBodyMediaTypeFromJson(e.toString()),
      )
      .toList();
}

typedef $JsonFactory<T> = T Function(Map<String, dynamic> json);

class $CustomJsonDecoder {
  $CustomJsonDecoder(this.factories);

  final Map<Type, $JsonFactory> factories;

  dynamic decode<T>(dynamic entity) {
    if (entity is Iterable) {
      return _decodeList<T>(entity);
    }

    if (entity is T) {
      return entity;
    }

    if (isTypeOf<T, Map>()) {
      return entity;
    }

    if (isTypeOf<T, Iterable>()) {
      return entity;
    }

    if (entity is Map<String, dynamic>) {
      return _decodeMap<T>(entity);
    }

    return entity;
  }

  T _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! $JsonFactory<T>) {
      return throw "Could not find factory for type $T. Is '$T: $T.fromJsonFactory' included in the CustomJsonDecoder instance creation in bootstrapper.dart?";
    }

    return jsonFactory(values);
  }

  List<T> _decodeList<T>(Iterable values) =>
      values.where((v) => v != null).map<T>((v) => decode<T>(v) as T).toList();
}

class $JsonSerializableConverter extends chopper.JsonConverter {
  @override
  FutureOr<chopper.Response<ResultType>> convertResponse<ResultType, Item>(
    chopper.Response response,
  ) async {
    if (response.bodyString.isEmpty) {
      // In rare cases, when let's say 204 (no content) is returned -
      // we cannot decode the missing json with the result type specified
      return chopper.Response(response.base, null, error: response.error);
    }

    if (ResultType == String) {
      return response.copyWith();
    }

    if (ResultType == DateTime) {
      return response.copyWith(
        body:
            DateTime.parse((response.body as String).replaceAll('"', ''))
                as ResultType,
      );
    }

    final jsonRes = await super.convertResponse(response);
    return jsonRes.copyWith<ResultType>(
      body: $jsonDecoder.decode<Item>(jsonRes.body) as ResultType,
    );
  }
}

final $jsonDecoder = $CustomJsonDecoder(generatedMapping);

// ignore: unused_element
String? _dateToJson(DateTime? date) {
  if (date == null) {
    return null;
  }

  final year = date.year.toString();
  final month = date.month < 10 ? '0${date.month}' : date.month.toString();
  final day = date.day < 10 ? '0${date.day}' : date.day.toString();

  return '$year-$month-$day';
}

class Wrapped<T> {
  final T value;
  const Wrapped.value(this.value);
}
