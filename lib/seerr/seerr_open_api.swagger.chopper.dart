// dart format width=80
//Generated seerr api code

part of 'seerr_open_api.swagger.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$SeerrOpenApi extends SeerrOpenApi {
  _$SeerrOpenApi([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = SeerrOpenApi;

  @override
  Future<Response<StatusGet$Response>> _statusGet() {
    final Uri $url = Uri.parse('/status');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<StatusGet$Response, StatusGet$Response>($request);
  }

  @override
  Future<Response<StatusAppdataGet$Response>> _statusAppdataGet() {
    final Uri $url = Uri.parse('/status/appdata');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<StatusAppdataGet$Response, StatusAppdataGet$Response>($request);
  }

  @override
  Future<Response<MainSettings>> _settingsMainGet() {
    final Uri $url = Uri.parse('/settings/main');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<MainSettings, MainSettings>($request);
  }

  @override
  Future<Response<MainSettings>> _settingsMainPost(
      {required MainSettings? body}) {
    final Uri $url = Uri.parse('/settings/main');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<MainSettings, MainSettings>($request);
  }

  @override
  Future<Response<MainSettings>> _settingsNetworkGet() {
    final Uri $url = Uri.parse('/settings/network');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<MainSettings, MainSettings>($request);
  }

  @override
  Future<Response<NetworkSettings>> _settingsNetworkPost(
      {required NetworkSettings? body}) {
    final Uri $url = Uri.parse('/settings/network');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<NetworkSettings, NetworkSettings>($request);
  }

  @override
  Future<Response<MainSettings>> _settingsMainRegeneratePost() {
    final Uri $url = Uri.parse('/settings/main/regenerate');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<MainSettings, MainSettings>($request);
  }

  @override
  Future<Response<JellyfinSettings>> _settingsJellyfinGet() {
    final Uri $url = Uri.parse('/settings/jellyfin');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<JellyfinSettings, JellyfinSettings>($request);
  }

  @override
  Future<Response<JellyfinSettings>> _settingsJellyfinPost(
      {required JellyfinSettings? body}) {
    final Uri $url = Uri.parse('/settings/jellyfin');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<JellyfinSettings, JellyfinSettings>($request);
  }

  @override
  Future<Response<List<JellyfinLibrary>>> _settingsJellyfinLibraryGet({
    String? $sync,
    String? enable,
  }) {
    final Uri $url = Uri.parse('/settings/jellyfin/library');
    final Map<String, dynamic> $params = <String, dynamic>{
      'sync': $sync,
      'enable': enable,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<JellyfinLibrary>, JellyfinLibrary>($request);
  }

  @override
  Future<Response<List<List<SettingsJellyfinUsersGet$Response$Item>>>>
      _settingsJellyfinUsersGet() {
    final Uri $url = Uri.parse('/settings/jellyfin/users');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<List<SettingsJellyfinUsersGet$Response$Item>>,
        List<SettingsJellyfinUsersGet$Response$Item>>($request);
  }

  @override
  Future<Response<SettingsJellyfinSyncGet$Response>>
      _settingsJellyfinSyncGet() {
    final Uri $url = Uri.parse('/settings/jellyfin/sync');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<SettingsJellyfinSyncGet$Response,
        SettingsJellyfinSyncGet$Response>($request);
  }

  @override
  Future<Response<SettingsJellyfinSyncPost$Response>> _settingsJellyfinSyncPost(
      {required SettingsJellyfinSyncPost$RequestBody? body}) {
    final Uri $url = Uri.parse('/settings/jellyfin/sync');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<SettingsJellyfinSyncPost$Response,
        SettingsJellyfinSyncPost$Response>($request);
  }

  @override
  Future<Response<PlexSettings>> _settingsPlexGet() {
    final Uri $url = Uri.parse('/settings/plex');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<PlexSettings, PlexSettings>($request);
  }

  @override
  Future<Response<PlexSettings>> _settingsPlexPost(
      {required PlexSettings? body}) {
    final Uri $url = Uri.parse('/settings/plex');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<PlexSettings, PlexSettings>($request);
  }

  @override
  Future<Response<List<PlexLibrary>>> _settingsPlexLibraryGet({
    String? $sync,
    String? enable,
  }) {
    final Uri $url = Uri.parse('/settings/plex/library');
    final Map<String, dynamic> $params = <String, dynamic>{
      'sync': $sync,
      'enable': enable,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<PlexLibrary>, PlexLibrary>($request);
  }

  @override
  Future<Response<SettingsPlexSyncGet$Response>> _settingsPlexSyncGet() {
    final Uri $url = Uri.parse('/settings/plex/sync');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<SettingsPlexSyncGet$Response,
        SettingsPlexSyncGet$Response>($request);
  }

  @override
  Future<Response<SettingsPlexSyncPost$Response>> _settingsPlexSyncPost(
      {required SettingsPlexSyncPost$RequestBody? body}) {
    final Uri $url = Uri.parse('/settings/plex/sync');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<SettingsPlexSyncPost$Response,
        SettingsPlexSyncPost$Response>($request);
  }

  @override
  Future<Response<List<PlexDevice>>> _settingsPlexDevicesServersGet() {
    final Uri $url = Uri.parse('/settings/plex/devices/servers');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<PlexDevice>, PlexDevice>($request);
  }

  @override
  Future<Response<List<List<SettingsPlexUsersGet$Response$Item>>>>
      _settingsPlexUsersGet() {
    final Uri $url = Uri.parse('/settings/plex/users');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<List<SettingsPlexUsersGet$Response$Item>>,
        List<SettingsPlexUsersGet$Response$Item>>($request);
  }

  @override
  Future<Response<MetadataSettings>> _settingsMetadatasGet() {
    final Uri $url = Uri.parse('/settings/metadatas');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<MetadataSettings, MetadataSettings>($request);
  }

  @override
  Future<Response<MetadataSettings>> _settingsMetadatasPut(
      {required MetadataSettings? body}) {
    final Uri $url = Uri.parse('/settings/metadatas');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<MetadataSettings, MetadataSettings>($request);
  }

  @override
  Future<Response<SettingsMetadatasTestPost$Response>>
      _settingsMetadatasTestPost(
          {required SettingsMetadatasTestPost$RequestBody? body}) {
    final Uri $url = Uri.parse('/settings/metadatas/test');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<SettingsMetadatasTestPost$Response,
        SettingsMetadatasTestPost$Response>($request);
  }

  @override
  Future<Response<TautulliSettings>> _settingsTautulliGet() {
    final Uri $url = Uri.parse('/settings/tautulli');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<TautulliSettings, TautulliSettings>($request);
  }

  @override
  Future<Response<TautulliSettings>> _settingsTautulliPost(
      {required TautulliSettings? body}) {
    final Uri $url = Uri.parse('/settings/tautulli');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<TautulliSettings, TautulliSettings>($request);
  }

  @override
  Future<Response<List<RadarrSettings>>> _settingsRadarrGet() {
    final Uri $url = Uri.parse('/settings/radarr');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<RadarrSettings>, RadarrSettings>($request);
  }

  @override
  Future<Response<RadarrSettings>> _settingsRadarrPost(
      {required RadarrSettings? body}) {
    final Uri $url = Uri.parse('/settings/radarr');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<RadarrSettings, RadarrSettings>($request);
  }

  @override
  Future<Response<SettingsRadarrTestPost$Response>> _settingsRadarrTestPost(
      {required SettingsRadarrTestPost$RequestBody? body}) {
    final Uri $url = Uri.parse('/settings/radarr/test');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<SettingsRadarrTestPost$Response,
        SettingsRadarrTestPost$Response>($request);
  }

  @override
  Future<Response<RadarrSettings>> _settingsRadarrRadarrIdPut({
    required int? radarrId,
    required RadarrSettings? body,
  }) {
    final Uri $url = Uri.parse('/settings/radarr/${radarrId}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<RadarrSettings, RadarrSettings>($request);
  }

  @override
  Future<Response<RadarrSettings>> _settingsRadarrRadarrIdDelete(
      {required int? radarrId}) {
    final Uri $url = Uri.parse('/settings/radarr/${radarrId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<RadarrSettings, RadarrSettings>($request);
  }

  @override
  Future<Response<List<ServiceProfile>>> _settingsRadarrRadarrIdProfilesGet(
      {required int? radarrId}) {
    final Uri $url = Uri.parse('/settings/radarr/${radarrId}/profiles');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<ServiceProfile>, ServiceProfile>($request);
  }

  @override
  Future<Response<List<SonarrSettings>>> _settingsSonarrGet() {
    final Uri $url = Uri.parse('/settings/sonarr');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<SonarrSettings>, SonarrSettings>($request);
  }

  @override
  Future<Response<SonarrSettings>> _settingsSonarrPost(
      {required SonarrSettings? body}) {
    final Uri $url = Uri.parse('/settings/sonarr');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<SonarrSettings, SonarrSettings>($request);
  }

  @override
  Future<Response<SettingsSonarrTestPost$Response>> _settingsSonarrTestPost(
      {required SettingsSonarrTestPost$RequestBody? body}) {
    final Uri $url = Uri.parse('/settings/sonarr/test');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<SettingsSonarrTestPost$Response,
        SettingsSonarrTestPost$Response>($request);
  }

  @override
  Future<Response<SonarrSettings>> _settingsSonarrSonarrIdPut({
    required int? sonarrId,
    required SonarrSettings? body,
  }) {
    final Uri $url = Uri.parse('/settings/sonarr/${sonarrId}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<SonarrSettings, SonarrSettings>($request);
  }

  @override
  Future<Response<SonarrSettings>> _settingsSonarrSonarrIdDelete(
      {required int? sonarrId}) {
    final Uri $url = Uri.parse('/settings/sonarr/${sonarrId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<SonarrSettings, SonarrSettings>($request);
  }

  @override
  Future<Response<PublicSettings>> _settingsPublicGet() {
    final Uri $url = Uri.parse('/settings/public');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<PublicSettings, PublicSettings>($request);
  }

  @override
  Future<Response<PublicSettings>> _settingsInitializePost() {
    final Uri $url = Uri.parse('/settings/initialize');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<PublicSettings, PublicSettings>($request);
  }

  @override
  Future<Response<List<Job>>> _settingsJobsGet() {
    final Uri $url = Uri.parse('/settings/jobs');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<Job>, Job>($request);
  }

  @override
  Future<Response<Job>> _settingsJobsJobIdRunPost({required String? jobId}) {
    final Uri $url = Uri.parse('/settings/jobs/${jobId}/run');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<Job, Job>($request);
  }

  @override
  Future<Response<Job>> _settingsJobsJobIdCancelPost({required String? jobId}) {
    final Uri $url = Uri.parse('/settings/jobs/${jobId}/cancel');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<Job, Job>($request);
  }

  @override
  Future<Response<Job>> _settingsJobsJobIdSchedulePost({
    required String? jobId,
    required SettingsJobsJobIdSchedulePost$RequestBody? body,
  }) {
    final Uri $url = Uri.parse('/settings/jobs/${jobId}/schedule');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<Job, Job>($request);
  }

  @override
  Future<Response<SettingsCacheGet$Response>> _settingsCacheGet() {
    final Uri $url = Uri.parse('/settings/cache');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<SettingsCacheGet$Response, SettingsCacheGet$Response>($request);
  }

  @override
  Future<Response<dynamic>> _settingsCacheCacheIdFlushPost(
      {required String? cacheId}) {
    final Uri $url = Uri.parse('/settings/cache/${cacheId}/flush');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _settingsCacheDnsDnsEntryFlushPost(
      {required String? dnsEntry}) {
    final Uri $url = Uri.parse('/settings/cache/dns/${dnsEntry}/flush');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<List<SettingsLogsGet$Response$Item>>>> _settingsLogsGet({
    num? take,
    num? skip,
    String? filter,
    String? search,
  }) {
    final Uri $url = Uri.parse('/settings/logs');
    final Map<String, dynamic> $params = <String, dynamic>{
      'take': take,
      'skip': skip,
      'filter': filter,
      'search': search,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<List<SettingsLogsGet$Response$Item>>,
        List<SettingsLogsGet$Response$Item>>($request);
  }

  @override
  Future<Response<NotificationEmailSettings>> _settingsNotificationsEmailGet() {
    final Uri $url = Uri.parse('/settings/notifications/email');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<NotificationEmailSettings, NotificationEmailSettings>($request);
  }

  @override
  Future<Response<NotificationEmailSettings>> _settingsNotificationsEmailPost(
      {required NotificationEmailSettings? body}) {
    final Uri $url = Uri.parse('/settings/notifications/email');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client
        .send<NotificationEmailSettings, NotificationEmailSettings>($request);
  }

  @override
  Future<Response<dynamic>> _settingsNotificationsEmailTestPost(
      {required NotificationEmailSettings? body}) {
    final Uri $url = Uri.parse('/settings/notifications/email/test');
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
  Future<Response<DiscordSettings>> _settingsNotificationsDiscordGet() {
    final Uri $url = Uri.parse('/settings/notifications/discord');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<DiscordSettings, DiscordSettings>($request);
  }

  @override
  Future<Response<DiscordSettings>> _settingsNotificationsDiscordPost(
      {required DiscordSettings? body}) {
    final Uri $url = Uri.parse('/settings/notifications/discord');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<DiscordSettings, DiscordSettings>($request);
  }

  @override
  Future<Response<dynamic>> _settingsNotificationsDiscordTestPost(
      {required DiscordSettings? body}) {
    final Uri $url = Uri.parse('/settings/notifications/discord/test');
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
  Future<Response<PushbulletSettings>> _settingsNotificationsPushbulletGet() {
    final Uri $url = Uri.parse('/settings/notifications/pushbullet');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<PushbulletSettings, PushbulletSettings>($request);
  }

  @override
  Future<Response<PushbulletSettings>> _settingsNotificationsPushbulletPost(
      {required PushbulletSettings? body}) {
    final Uri $url = Uri.parse('/settings/notifications/pushbullet');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<PushbulletSettings, PushbulletSettings>($request);
  }

  @override
  Future<Response<dynamic>> _settingsNotificationsPushbulletTestPost(
      {required PushbulletSettings? body}) {
    final Uri $url = Uri.parse('/settings/notifications/pushbullet/test');
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
  Future<Response<PushoverSettings>> _settingsNotificationsPushoverGet() {
    final Uri $url = Uri.parse('/settings/notifications/pushover');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<PushoverSettings, PushoverSettings>($request);
  }

  @override
  Future<Response<PushoverSettings>> _settingsNotificationsPushoverPost(
      {required PushoverSettings? body}) {
    final Uri $url = Uri.parse('/settings/notifications/pushover');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<PushoverSettings, PushoverSettings>($request);
  }

  @override
  Future<Response<dynamic>> _settingsNotificationsPushoverTestPost(
      {required PushoverSettings? body}) {
    final Uri $url = Uri.parse('/settings/notifications/pushover/test');
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
  Future<
          Response<
              List<List<SettingsNotificationsPushoverSoundsGet$Response$Item>>>>
      _settingsNotificationsPushoverSoundsGet({required String? token}) {
    final Uri $url = Uri.parse('/settings/notifications/pushover/sounds');
    final Map<String, dynamic> $params = <String, dynamic>{'token': token};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<
        List<List<SettingsNotificationsPushoverSoundsGet$Response$Item>>,
        List<SettingsNotificationsPushoverSoundsGet$Response$Item>>($request);
  }

  @override
  Future<Response<GotifySettings>> _settingsNotificationsGotifyGet() {
    final Uri $url = Uri.parse('/settings/notifications/gotify');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<GotifySettings, GotifySettings>($request);
  }

  @override
  Future<Response<GotifySettings>> _settingsNotificationsGotifyPost(
      {required GotifySettings? body}) {
    final Uri $url = Uri.parse('/settings/notifications/gotify');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<GotifySettings, GotifySettings>($request);
  }

  @override
  Future<Response<dynamic>> _settingsNotificationsGotifyTestPost(
      {required GotifySettings? body}) {
    final Uri $url = Uri.parse('/settings/notifications/gotify/test');
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
  Future<Response<NtfySettings>> _settingsNotificationsNtfyGet() {
    final Uri $url = Uri.parse('/settings/notifications/ntfy');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<NtfySettings, NtfySettings>($request);
  }

  @override
  Future<Response<NtfySettings>> _settingsNotificationsNtfyPost(
      {required NtfySettings? body}) {
    final Uri $url = Uri.parse('/settings/notifications/ntfy');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<NtfySettings, NtfySettings>($request);
  }

  @override
  Future<Response<dynamic>> _settingsNotificationsNtfyTestPost(
      {required NtfySettings? body}) {
    final Uri $url = Uri.parse('/settings/notifications/ntfy/test');
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
  Future<Response<SlackSettings>> _settingsNotificationsSlackGet() {
    final Uri $url = Uri.parse('/settings/notifications/slack');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<SlackSettings, SlackSettings>($request);
  }

  @override
  Future<Response<SlackSettings>> _settingsNotificationsSlackPost(
      {required SlackSettings? body}) {
    final Uri $url = Uri.parse('/settings/notifications/slack');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<SlackSettings, SlackSettings>($request);
  }

  @override
  Future<Response<dynamic>> _settingsNotificationsSlackTestPost(
      {required SlackSettings? body}) {
    final Uri $url = Uri.parse('/settings/notifications/slack/test');
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
  Future<Response<TelegramSettings>> _settingsNotificationsTelegramGet() {
    final Uri $url = Uri.parse('/settings/notifications/telegram');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<TelegramSettings, TelegramSettings>($request);
  }

  @override
  Future<Response<TelegramSettings>> _settingsNotificationsTelegramPost(
      {required TelegramSettings? body}) {
    final Uri $url = Uri.parse('/settings/notifications/telegram');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<TelegramSettings, TelegramSettings>($request);
  }

  @override
  Future<Response<dynamic>> _settingsNotificationsTelegramTestPost(
      {required TelegramSettings? body}) {
    final Uri $url = Uri.parse('/settings/notifications/telegram/test');
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
  Future<Response<WebPushSettings>> _settingsNotificationsWebpushGet() {
    final Uri $url = Uri.parse('/settings/notifications/webpush');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<WebPushSettings, WebPushSettings>($request);
  }

  @override
  Future<Response<WebPushSettings>> _settingsNotificationsWebpushPost(
      {required WebPushSettings? body}) {
    final Uri $url = Uri.parse('/settings/notifications/webpush');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<WebPushSettings, WebPushSettings>($request);
  }

  @override
  Future<Response<dynamic>> _settingsNotificationsWebpushTestPost(
      {required WebPushSettings? body}) {
    final Uri $url = Uri.parse('/settings/notifications/webpush/test');
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
  Future<Response<WebhookSettings>> _settingsNotificationsWebhookGet() {
    final Uri $url = Uri.parse('/settings/notifications/webhook');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<WebhookSettings, WebhookSettings>($request);
  }

  @override
  Future<Response<WebhookSettings>> _settingsNotificationsWebhookPost(
      {required WebhookSettings? body}) {
    final Uri $url = Uri.parse('/settings/notifications/webhook');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<WebhookSettings, WebhookSettings>($request);
  }

  @override
  Future<Response<dynamic>> _settingsNotificationsWebhookTestPost(
      {required WebhookSettings? body}) {
    final Uri $url = Uri.parse('/settings/notifications/webhook/test');
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
  Future<Response<List<DiscoverSlider>>> _settingsDiscoverGet() {
    final Uri $url = Uri.parse('/settings/discover');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<DiscoverSlider>, DiscoverSlider>($request);
  }

  @override
  Future<Response<List<DiscoverSlider>>> _settingsDiscoverPost(
      {required List<DiscoverSlider>? body}) {
    final Uri $url = Uri.parse('/settings/discover');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<List<DiscoverSlider>, DiscoverSlider>($request);
  }

  @override
  Future<Response<DiscoverSlider>> _settingsDiscoverSliderIdPut({
    required num? sliderId,
    required SettingsDiscoverSliderIdPut$RequestBody? body,
  }) {
    final Uri $url = Uri.parse('/settings/discover/${sliderId}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<DiscoverSlider, DiscoverSlider>($request);
  }

  @override
  Future<Response<DiscoverSlider>> _settingsDiscoverSliderIdDelete(
      {required num? sliderId}) {
    final Uri $url = Uri.parse('/settings/discover/${sliderId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<DiscoverSlider, DiscoverSlider>($request);
  }

  @override
  Future<Response<DiscoverSlider>> _settingsDiscoverAddPost(
      {required SettingsDiscoverAddPost$RequestBody? body}) {
    final Uri $url = Uri.parse('/settings/discover/add');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<DiscoverSlider, DiscoverSlider>($request);
  }

  @override
  Future<Response<dynamic>> _settingsDiscoverResetGet() {
    final Uri $url = Uri.parse('/settings/discover/reset');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<SettingsAboutGet$Response>> _settingsAboutGet() {
    final Uri $url = Uri.parse('/settings/about');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<SettingsAboutGet$Response, SettingsAboutGet$Response>($request);
  }

  @override
  Future<Response<User>> _authMeGet() {
    final Uri $url = Uri.parse('/auth/me');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<User, User>($request);
  }

  @override
  Future<Response<User>> _authPlexPost(
      {required AuthPlexPost$RequestBody? body}) {
    final Uri $url = Uri.parse('/auth/plex');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<User, User>($request);
  }

  @override
  Future<Response<User>> _authJellyfinPost(
      {required AuthJellyfinPost$RequestBody? body}) {
    final Uri $url = Uri.parse('/auth/jellyfin');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<User, User>($request);
  }

  @override
  Future<Response<User>> _authLocalPost(
      {required AuthLocalPost$RequestBody? body}) {
    final Uri $url = Uri.parse('/auth/local');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<User, User>($request);
  }

  @override
  Future<Response<AuthLogoutPost$Response>> _authLogoutPost() {
    final Uri $url = Uri.parse('/auth/logout');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client
        .send<AuthLogoutPost$Response, AuthLogoutPost$Response>($request);
  }

  @override
  Future<Response<AuthResetPasswordPost$Response>> _authResetPasswordPost(
      {required AuthResetPasswordPost$RequestBody? body}) {
    final Uri $url = Uri.parse('/auth/reset-password');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<AuthResetPasswordPost$Response,
        AuthResetPasswordPost$Response>($request);
  }

  @override
  Future<Response<AuthResetPasswordGuidPost$Response>>
      _authResetPasswordGuidPost({
    required String? guid,
    required AuthResetPasswordGuidPost$RequestBody? body,
  }) {
    final Uri $url = Uri.parse('/auth/reset-password/${guid}');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<AuthResetPasswordGuidPost$Response,
        AuthResetPasswordGuidPost$Response>($request);
  }

  @override
  Future<Response<UserGet$Response>> _userGet({
    num? take,
    num? skip,
    String? sort,
    String? q,
    String? includeIds,
  }) {
    final Uri $url = Uri.parse('/user');
    final Map<String, dynamic> $params = <String, dynamic>{
      'take': take,
      'skip': skip,
      'sort': sort,
      'q': q,
      'includeIds': includeIds,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<UserGet$Response, UserGet$Response>($request);
  }

  @override
  Future<Response<List<User>>> _userPut({required UserPut$RequestBody? body}) {
    final Uri $url = Uri.parse('/user');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<List<User>, User>($request);
  }

  @override
  Future<Response<User>> _userPost({required UserPost$RequestBody? body}) {
    final Uri $url = Uri.parse('/user');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<User, User>($request);
  }

  @override
  Future<Response<List<User>>> _userImportFromPlexPost(
      {required UserImportFromPlexPost$RequestBody? body}) {
    final Uri $url = Uri.parse('/user/import-from-plex');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<List<User>, User>($request);
  }

  @override
  Future<Response<List<User>>> _userImportFromJellyfinPost(
      {required UserImportFromJellyfinPost$RequestBody? body}) {
    final Uri $url = Uri.parse('/user/import-from-jellyfin');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<List<User>, User>($request);
  }

  @override
  Future<Response<dynamic>> _userRegisterPushSubscriptionPost(
      {required UserRegisterPushSubscriptionPost$RequestBody? body}) {
    final Uri $url = Uri.parse('/user/registerPushSubscription');
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
  Future<Response<UserUserIdPushSubscriptionsGet$Response>>
      _userUserIdPushSubscriptionsGet({required num? userId}) {
    final Uri $url = Uri.parse('/user/${userId}/pushSubscriptions');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<UserUserIdPushSubscriptionsGet$Response,
        UserUserIdPushSubscriptionsGet$Response>($request);
  }

  @override
  Future<Response<UserUserIdPushSubscriptionEndpointGet$Response>>
      _userUserIdPushSubscriptionEndpointGet({
    required num? userId,
    required String? endpoint,
  }) {
    final Uri $url = Uri.parse('/user/${userId}/pushSubscription/${endpoint}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<UserUserIdPushSubscriptionEndpointGet$Response,
        UserUserIdPushSubscriptionEndpointGet$Response>($request);
  }

  @override
  Future<Response<dynamic>> _userUserIdPushSubscriptionEndpointDelete({
    required num? userId,
    required String? endpoint,
  }) {
    final Uri $url = Uri.parse('/user/${userId}/pushSubscription/${endpoint}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<User>> _userUserIdGet({required num? userId}) {
    final Uri $url = Uri.parse('/user/${userId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<User, User>($request);
  }

  @override
  Future<Response<User>> _userUserIdPut({
    required num? userId,
    required User? body,
  }) {
    final Uri $url = Uri.parse('/user/${userId}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<User, User>($request);
  }

  @override
  Future<Response<User>> _userUserIdDelete({required num? userId}) {
    final Uri $url = Uri.parse('/user/${userId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<User, User>($request);
  }

  @override
  Future<Response<UserUserIdRequestsGet$Response>> _userUserIdRequestsGet({
    required num? userId,
    num? take,
    num? skip,
  }) {
    final Uri $url = Uri.parse('/user/${userId}/requests');
    final Map<String, dynamic> $params = <String, dynamic>{
      'take': take,
      'skip': skip,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<UserUserIdRequestsGet$Response,
        UserUserIdRequestsGet$Response>($request);
  }

  @override
  Future<Response<UserUserIdQuotaGet$Response>> _userUserIdQuotaGet(
      {required num? userId}) {
    final Uri $url = Uri.parse('/user/${userId}/quota');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<UserUserIdQuotaGet$Response,
        UserUserIdQuotaGet$Response>($request);
  }

  @override
  Future<Response<BlacklistGet$Response>> _blacklistGet({
    num? take,
    num? skip,
    String? search,
    String? filter,
  }) {
    final Uri $url = Uri.parse('/blacklist');
    final Map<String, dynamic> $params = <String, dynamic>{
      'take': take,
      'skip': skip,
      'search': search,
      'filter': filter,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<BlacklistGet$Response, BlacklistGet$Response>($request);
  }

  @override
  Future<Response<dynamic>> _blacklistPost({required Blacklist? body}) {
    final Uri $url = Uri.parse('/blacklist');
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
  Future<Response<dynamic>> _blacklistTmdbIdGet({required String? tmdbId}) {
    final Uri $url = Uri.parse('/blacklist/${tmdbId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _blacklistTmdbIdDelete({required String? tmdbId}) {
    final Uri $url = Uri.parse('/blacklist/${tmdbId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<Watchlist>> _watchlistPost({required Watchlist? body}) {
    final Uri $url = Uri.parse('/watchlist');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<Watchlist, Watchlist>($request);
  }

  @override
  Future<Response<dynamic>> _watchlistTmdbIdDelete({required String? tmdbId}) {
    final Uri $url = Uri.parse('/watchlist/${tmdbId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<UserUserIdWatchlistGet$Response>> _userUserIdWatchlistGet({
    required num? userId,
    num? page,
  }) {
    final Uri $url = Uri.parse('/user/${userId}/watchlist');
    final Map<String, dynamic> $params = <String, dynamic>{'page': page};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<UserUserIdWatchlistGet$Response,
        UserUserIdWatchlistGet$Response>($request);
  }

  @override
  Future<Response<UserSettings>> _userUserIdSettingsMainGet(
      {required num? userId}) {
    final Uri $url = Uri.parse('/user/${userId}/settings/main');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<UserSettings, UserSettings>($request);
  }

  @override
  Future<Response<UserSettings>> _userUserIdSettingsMainPost({
    required num? userId,
    required UserSettings? body,
  }) {
    final Uri $url = Uri.parse('/user/${userId}/settings/main');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<UserSettings, UserSettings>($request);
  }

  @override
  Future<Response<UserUserIdSettingsPasswordGet$Response>>
      _userUserIdSettingsPasswordGet({required num? userId}) {
    final Uri $url = Uri.parse('/user/${userId}/settings/password');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<UserUserIdSettingsPasswordGet$Response,
        UserUserIdSettingsPasswordGet$Response>($request);
  }

  @override
  Future<Response<dynamic>> _userUserIdSettingsPasswordPost({
    required num? userId,
    required UserUserIdSettingsPasswordPost$RequestBody? body,
  }) {
    final Uri $url = Uri.parse('/user/${userId}/settings/password');
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
  Future<Response<dynamic>> _userUserIdSettingsLinkedAccountsPlexPost({
    required num? userId,
    required UserUserIdSettingsLinkedAccountsPlexPost$RequestBody? body,
  }) {
    final Uri $url = Uri.parse('/user/${userId}/settings/linked-accounts/plex');
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
  Future<Response<dynamic>> _userUserIdSettingsLinkedAccountsPlexDelete(
      {required num? userId}) {
    final Uri $url = Uri.parse('/user/${userId}/settings/linked-accounts/plex');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _userUserIdSettingsLinkedAccountsJellyfinPost({
    required num? userId,
    required UserUserIdSettingsLinkedAccountsJellyfinPost$RequestBody? body,
  }) {
    final Uri $url =
        Uri.parse('/user/${userId}/settings/linked-accounts/jellyfin');
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
  Future<Response<dynamic>> _userUserIdSettingsLinkedAccountsJellyfinDelete(
      {required num? userId}) {
    final Uri $url =
        Uri.parse('/user/${userId}/settings/linked-accounts/jellyfin');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<UserSettingsNotifications>>
      _userUserIdSettingsNotificationsGet({required num? userId}) {
    final Uri $url = Uri.parse('/user/${userId}/settings/notifications');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<UserSettingsNotifications, UserSettingsNotifications>($request);
  }

  @override
  Future<Response<UserSettingsNotifications>>
      _userUserIdSettingsNotificationsPost({
    required num? userId,
    required UserSettingsNotifications? body,
  }) {
    final Uri $url = Uri.parse('/user/${userId}/settings/notifications');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client
        .send<UserSettingsNotifications, UserSettingsNotifications>($request);
  }

  @override
  Future<Response<UserUserIdSettingsPermissionsGet$Response>>
      _userUserIdSettingsPermissionsGet({required num? userId}) {
    final Uri $url = Uri.parse('/user/${userId}/settings/permissions');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<UserUserIdSettingsPermissionsGet$Response,
        UserUserIdSettingsPermissionsGet$Response>($request);
  }

  @override
  Future<Response<UserUserIdSettingsPermissionsPost$Response>>
      _userUserIdSettingsPermissionsPost({
    required num? userId,
    required UserUserIdSettingsPermissionsPost$RequestBody? body,
  }) {
    final Uri $url = Uri.parse('/user/${userId}/settings/permissions');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<UserUserIdSettingsPermissionsPost$Response,
        UserUserIdSettingsPermissionsPost$Response>($request);
  }

  @override
  Future<Response<UserUserIdWatchDataGet$Response>> _userUserIdWatchDataGet(
      {required num? userId}) {
    final Uri $url = Uri.parse('/user/${userId}/watch_data');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<UserUserIdWatchDataGet$Response,
        UserUserIdWatchDataGet$Response>($request);
  }

  @override
  Future<Response<SearchGet$Response>> _searchGet({
    required String? query,
    num? page,
    String? language,
  }) {
    final Uri $url = Uri.parse('/search');
    final Map<String, dynamic> $params = <String, dynamic>{
      'query': query,
      'page': page,
      'language': language,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<SearchGet$Response, SearchGet$Response>($request);
  }

  @override
  Future<Response<SearchKeywordGet$Response>> _searchKeywordGet({
    required String? query,
    num? page,
  }) {
    final Uri $url = Uri.parse('/search/keyword');
    final Map<String, dynamic> $params = <String, dynamic>{
      'query': query,
      'page': page,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<SearchKeywordGet$Response, SearchKeywordGet$Response>($request);
  }

  @override
  Future<Response<SearchCompanyGet$Response>> _searchCompanyGet({
    required String? query,
    num? page,
  }) {
    final Uri $url = Uri.parse('/search/company');
    final Map<String, dynamic> $params = <String, dynamic>{
      'query': query,
      'page': page,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<SearchCompanyGet$Response, SearchCompanyGet$Response>($request);
  }

  @override
  Future<Response<DiscoverMoviesGet$Response>> _discoverMoviesGet({
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
    String? certificationMode,
  }) {
    final Uri $url = Uri.parse('/discover/movies');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'language': language,
      'genre': genre,
      'studio': studio,
      'keywords': keywords,
      'excludeKeywords': excludeKeywords,
      'sortBy': sortBy,
      'primaryReleaseDateGte': primaryReleaseDateGte,
      'primaryReleaseDateLte': primaryReleaseDateLte,
      'withRuntimeGte': withRuntimeGte,
      'withRuntimeLte': withRuntimeLte,
      'voteAverageGte': voteAverageGte,
      'voteAverageLte': voteAverageLte,
      'voteCountGte': voteCountGte,
      'voteCountLte': voteCountLte,
      'watchRegion': watchRegion,
      'watchProviders': watchProviders,
      'certification': certification,
      'certificationGte': certificationGte,
      'certificationLte': certificationLte,
      'certificationCountry': certificationCountry,
      'certificationMode': certificationMode,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<DiscoverMoviesGet$Response, DiscoverMoviesGet$Response>($request);
  }

  @override
  Future<Response<DiscoverMoviesGenreGenreIdGet$Response>>
      _discoverMoviesGenreGenreIdGet({
    required String? genreId,
    num? page,
    String? language,
  }) {
    final Uri $url = Uri.parse('/discover/movies/genre/${genreId}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'language': language,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<DiscoverMoviesGenreGenreIdGet$Response,
        DiscoverMoviesGenreGenreIdGet$Response>($request);
  }

  @override
  Future<Response<DiscoverMoviesLanguageLanguageGet$Response>>
      _discoverMoviesLanguageLanguageGet({
    required String? language,
    num? page,
    String? language$,
  }) {
    final Uri $url = Uri.parse('/discover/movies/language/${language}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'language': language$,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<DiscoverMoviesLanguageLanguageGet$Response,
        DiscoverMoviesLanguageLanguageGet$Response>($request);
  }

  @override
  Future<Response<DiscoverMoviesStudioStudioIdGet$Response>>
      _discoverMoviesStudioStudioIdGet({
    required String? studioId,
    num? page,
    String? language,
  }) {
    final Uri $url = Uri.parse('/discover/movies/studio/${studioId}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'language': language,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<DiscoverMoviesStudioStudioIdGet$Response,
        DiscoverMoviesStudioStudioIdGet$Response>($request);
  }

  @override
  Future<Response<DiscoverMoviesUpcomingGet$Response>>
      _discoverMoviesUpcomingGet({
    num? page,
    String? language,
  }) {
    final Uri $url = Uri.parse('/discover/movies/upcoming');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'language': language,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<DiscoverMoviesUpcomingGet$Response,
        DiscoverMoviesUpcomingGet$Response>($request);
  }

  @override
  Future<Response<DiscoverTvGet$Response>> _discoverTvGet({
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
    String? certificationMode,
  }) {
    final Uri $url = Uri.parse('/discover/tv');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'language': language,
      'genre': genre,
      'network': network,
      'keywords': keywords,
      'excludeKeywords': excludeKeywords,
      'sortBy': sortBy,
      'firstAirDateGte': firstAirDateGte,
      'firstAirDateLte': firstAirDateLte,
      'withRuntimeGte': withRuntimeGte,
      'withRuntimeLte': withRuntimeLte,
      'voteAverageGte': voteAverageGte,
      'voteAverageLte': voteAverageLte,
      'voteCountGte': voteCountGte,
      'voteCountLte': voteCountLte,
      'watchRegion': watchRegion,
      'watchProviders': watchProviders,
      'status': status,
      'certification': certification,
      'certificationGte': certificationGte,
      'certificationLte': certificationLte,
      'certificationCountry': certificationCountry,
      'certificationMode': certificationMode,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<DiscoverTvGet$Response, DiscoverTvGet$Response>($request);
  }

  @override
  Future<Response<DiscoverTvLanguageLanguageGet$Response>>
      _discoverTvLanguageLanguageGet({
    required String? language,
    num? page,
    String? language$,
  }) {
    final Uri $url = Uri.parse('/discover/tv/language/${language}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'language': language$,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<DiscoverTvLanguageLanguageGet$Response,
        DiscoverTvLanguageLanguageGet$Response>($request);
  }

  @override
  Future<Response<DiscoverTvGenreGenreIdGet$Response>>
      _discoverTvGenreGenreIdGet({
    required String? genreId,
    num? page,
    String? language,
  }) {
    final Uri $url = Uri.parse('/discover/tv/genre/${genreId}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'language': language,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<DiscoverTvGenreGenreIdGet$Response,
        DiscoverTvGenreGenreIdGet$Response>($request);
  }

  @override
  Future<Response<DiscoverTvNetworkNetworkIdGet$Response>>
      _discoverTvNetworkNetworkIdGet({
    required String? networkId,
    num? page,
    String? language,
  }) {
    final Uri $url = Uri.parse('/discover/tv/network/${networkId}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'language': language,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<DiscoverTvNetworkNetworkIdGet$Response,
        DiscoverTvNetworkNetworkIdGet$Response>($request);
  }

  @override
  Future<Response<DiscoverTvUpcomingGet$Response>> _discoverTvUpcomingGet({
    num? page,
    String? language,
  }) {
    final Uri $url = Uri.parse('/discover/tv/upcoming');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'language': language,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<DiscoverTvUpcomingGet$Response,
        DiscoverTvUpcomingGet$Response>($request);
  }

  @override
  Future<Response<DiscoverTrendingGet$Response>> _discoverTrendingGet({
    num? page,
    String? language,
  }) {
    final Uri $url = Uri.parse('/discover/trending');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'language': language,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<DiscoverTrendingGet$Response,
        DiscoverTrendingGet$Response>($request);
  }

  @override
  Future<Response<DiscoverKeywordKeywordIdMoviesGet$Response>>
      _discoverKeywordKeywordIdMoviesGet({
    required num? keywordId,
    num? page,
    String? language,
  }) {
    final Uri $url = Uri.parse('/discover/keyword/${keywordId}/movies');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'language': language,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<DiscoverKeywordKeywordIdMoviesGet$Response,
        DiscoverKeywordKeywordIdMoviesGet$Response>($request);
  }

  @override
  Future<Response<List<List<DiscoverGenresliderMovieGet$Response$Item>>>>
      _discoverGenresliderMovieGet({String? language}) {
    final Uri $url = Uri.parse('/discover/genreslider/movie');
    final Map<String, dynamic> $params = <String, dynamic>{
      'language': language
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<List<DiscoverGenresliderMovieGet$Response$Item>>,
        List<DiscoverGenresliderMovieGet$Response$Item>>($request);
  }

  @override
  Future<Response<List<List<DiscoverGenresliderTvGet$Response$Item>>>>
      _discoverGenresliderTvGet({String? language}) {
    final Uri $url = Uri.parse('/discover/genreslider/tv');
    final Map<String, dynamic> $params = <String, dynamic>{
      'language': language
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<List<DiscoverGenresliderTvGet$Response$Item>>,
        List<DiscoverGenresliderTvGet$Response$Item>>($request);
  }

  @override
  Future<Response<DiscoverWatchlistGet$Response>> _discoverWatchlistGet(
      {num? page}) {
    final Uri $url = Uri.parse('/discover/watchlist');
    final Map<String, dynamic> $params = <String, dynamic>{'page': page};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<DiscoverWatchlistGet$Response,
        DiscoverWatchlistGet$Response>($request);
  }

  @override
  Future<Response<RequestGet$Response>> _request$Get({
    num? take,
    num? skip,
    String? filter,
    String? sort,
    String? sortDirection,
    num? requestedBy,
    String? mediaType,
  }) {
    final Uri $url = Uri.parse('/request');
    final Map<String, dynamic> $params = <String, dynamic>{
      'take': take,
      'skip': skip,
      'filter': filter,
      'sort': sort,
      'sortDirection': sortDirection,
      'requestedBy': requestedBy,
      'mediaType': mediaType,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<RequestGet$Response, RequestGet$Response>($request);
  }

  @override
  Future<Response<MediaRequest>> _request$Post(
      {required RequestPost$RequestBody? body}) {
    final Uri $url = Uri.parse('/request');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<MediaRequest, MediaRequest>($request);
  }

  @override
  Future<Response<RequestCountGet$Response>> _requestCountGet() {
    final Uri $url = Uri.parse('/request/count');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<RequestCountGet$Response, RequestCountGet$Response>($request);
  }

  @override
  Future<Response<MediaRequest>> _requestRequestIdGet(
      {required String? requestId}) {
    final Uri $url = Uri.parse('/request/${requestId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<MediaRequest, MediaRequest>($request);
  }

  @override
  Future<Response<MediaRequest>> _requestRequestIdPut({
    required String? requestId,
    required RequestRequestIdPut$RequestBody? body,
  }) {
    final Uri $url = Uri.parse('/request/${requestId}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<MediaRequest, MediaRequest>($request);
  }

  @override
  Future<Response<dynamic>> _requestRequestIdDelete(
      {required String? requestId}) {
    final Uri $url = Uri.parse('/request/${requestId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<MediaRequest>> _requestRequestIdRetryPost(
      {required String? requestId}) {
    final Uri $url = Uri.parse('/request/${requestId}/retry');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<MediaRequest, MediaRequest>($request);
  }

  @override
  Future<Response<MediaRequest>> _requestRequestIdStatusPost({
    required String? requestId,
    required String? status,
  }) {
    final Uri $url = Uri.parse('/request/${requestId}/${status}');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<MediaRequest, MediaRequest>($request);
  }

  @override
  Future<Response<MovieDetails>> _movieMovieIdGet({
    required num? movieId,
    String? language,
  }) {
    final Uri $url = Uri.parse('/movie/${movieId}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'language': language
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<MovieDetails, MovieDetails>($request);
  }

  @override
  Future<Response<MovieMovieIdRecommendationsGet$Response>>
      _movieMovieIdRecommendationsGet({
    required num? movieId,
    num? page,
    String? language,
  }) {
    final Uri $url = Uri.parse('/movie/${movieId}/recommendations');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'language': language,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<MovieMovieIdRecommendationsGet$Response,
        MovieMovieIdRecommendationsGet$Response>($request);
  }

  @override
  Future<Response<MovieMovieIdSimilarGet$Response>> _movieMovieIdSimilarGet({
    required num? movieId,
    num? page,
    String? language,
  }) {
    final Uri $url = Uri.parse('/movie/${movieId}/similar');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'language': language,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<MovieMovieIdSimilarGet$Response,
        MovieMovieIdSimilarGet$Response>($request);
  }

  @override
  Future<Response<MovieMovieIdRatingsGet$Response>> _movieMovieIdRatingsGet(
      {required num? movieId}) {
    final Uri $url = Uri.parse('/movie/${movieId}/ratings');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<MovieMovieIdRatingsGet$Response,
        MovieMovieIdRatingsGet$Response>($request);
  }

  @override
  Future<Response<MovieMovieIdRatingscombinedGet$Response>>
      _movieMovieIdRatingscombinedGet({required num? movieId}) {
    final Uri $url = Uri.parse('/movie/${movieId}/ratingscombined');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<MovieMovieIdRatingscombinedGet$Response,
        MovieMovieIdRatingscombinedGet$Response>($request);
  }

  @override
  Future<Response<TvDetails>> _tvTvIdGet({
    required num? tvId,
    String? language,
  }) {
    final Uri $url = Uri.parse('/tv/${tvId}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'language': language
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<TvDetails, TvDetails>($request);
  }

  @override
  Future<Response<Season>> _tvTvIdSeasonSeasonNumberGet({
    required num? tvId,
    required num? seasonNumber,
    String? language,
  }) {
    final Uri $url = Uri.parse('/tv/${tvId}/season/${seasonNumber}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'language': language
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<Season, Season>($request);
  }

  @override
  Future<Response<TvTvIdRecommendationsGet$Response>>
      _tvTvIdRecommendationsGet({
    required num? tvId,
    num? page,
    String? language,
  }) {
    final Uri $url = Uri.parse('/tv/${tvId}/recommendations');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'language': language,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<TvTvIdRecommendationsGet$Response,
        TvTvIdRecommendationsGet$Response>($request);
  }

  @override
  Future<Response<TvTvIdSimilarGet$Response>> _tvTvIdSimilarGet({
    required num? tvId,
    num? page,
    String? language,
  }) {
    final Uri $url = Uri.parse('/tv/${tvId}/similar');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'language': language,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<TvTvIdSimilarGet$Response, TvTvIdSimilarGet$Response>($request);
  }

  @override
  Future<Response<TvTvIdRatingsGet$Response>> _tvTvIdRatingsGet(
      {required num? tvId}) {
    final Uri $url = Uri.parse('/tv/${tvId}/ratings');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<TvTvIdRatingsGet$Response, TvTvIdRatingsGet$Response>($request);
  }

  @override
  Future<Response<PersonDetails>> _personPersonIdGet({
    required num? personId,
    String? language,
  }) {
    final Uri $url = Uri.parse('/person/${personId}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'language': language
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<PersonDetails, PersonDetails>($request);
  }

  @override
  Future<Response<PersonPersonIdCombinedCreditsGet$Response>>
      _personPersonIdCombinedCreditsGet({
    required num? personId,
    String? language,
  }) {
    final Uri $url = Uri.parse('/person/${personId}/combined_credits');
    final Map<String, dynamic> $params = <String, dynamic>{
      'language': language
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<PersonPersonIdCombinedCreditsGet$Response,
        PersonPersonIdCombinedCreditsGet$Response>($request);
  }

  @override
  Future<Response<MediaGet$Response>> _mediaGet({
    num? take,
    num? skip,
    String? filter,
    String? sort,
  }) {
    final Uri $url = Uri.parse('/media');
    final Map<String, dynamic> $params = <String, dynamic>{
      'take': take,
      'skip': skip,
      'filter': filter,
      'sort': sort,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<MediaGet$Response, MediaGet$Response>($request);
  }

  @override
  Future<Response<dynamic>> _mediaMediaIdDelete({required String? mediaId}) {
    final Uri $url = Uri.parse('/media/${mediaId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _mediaMediaIdFileDelete({
    required String? mediaId,
    bool? is4k,
  }) {
    final Uri $url = Uri.parse('/media/${mediaId}/file');
    final Map<String, dynamic> $params = <String, dynamic>{'is4k': is4k};
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<MediaInfo>> _mediaMediaIdStatusPost({
    required String? mediaId,
    required String? status,
    required MediaMediaIdStatusPost$RequestBody? body,
  }) {
    final Uri $url = Uri.parse('/media/${mediaId}/${status}');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<MediaInfo, MediaInfo>($request);
  }

  @override
  Future<Response<MediaMediaIdWatchDataGet$Response>> _mediaMediaIdWatchDataGet(
      {required String? mediaId}) {
    final Uri $url = Uri.parse('/media/${mediaId}/watch_data');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<MediaMediaIdWatchDataGet$Response,
        MediaMediaIdWatchDataGet$Response>($request);
  }

  @override
  Future<Response<Collection>> _collectionCollectionIdGet({
    required num? collectionId,
    String? language,
  }) {
    final Uri $url = Uri.parse('/collection/${collectionId}');
    final Map<String, dynamic> $params = <String, dynamic>{
      'language': language
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<Collection, Collection>($request);
  }

  @override
  Future<Response<List<RadarrSettings>>> _serviceRadarrGet() {
    final Uri $url = Uri.parse('/service/radarr');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<RadarrSettings>, RadarrSettings>($request);
  }

  @override
  Future<Response<ServiceRadarrRadarrIdGet$Response>> _serviceRadarrRadarrIdGet(
      {required num? radarrId}) {
    final Uri $url = Uri.parse('/service/radarr/${radarrId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<ServiceRadarrRadarrIdGet$Response,
        ServiceRadarrRadarrIdGet$Response>($request);
  }

  @override
  Future<Response<List<SonarrSettings>>> _serviceSonarrGet() {
    final Uri $url = Uri.parse('/service/sonarr');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<SonarrSettings>, SonarrSettings>($request);
  }

  @override
  Future<Response<ServiceSonarrSonarrIdGet$Response>> _serviceSonarrSonarrIdGet(
      {required num? sonarrId}) {
    final Uri $url = Uri.parse('/service/sonarr/${sonarrId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<ServiceSonarrSonarrIdGet$Response,
        ServiceSonarrSonarrIdGet$Response>($request);
  }

  @override
  Future<Response<List<SonarrSeries>>> _serviceSonarrLookupTmdbIdGet(
      {required num? tmdbId}) {
    final Uri $url = Uri.parse('/service/sonarr/lookup/${tmdbId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<SonarrSeries>, SonarrSeries>($request);
  }

  @override
  Future<Response<List<List<RegionsGet$Response$Item>>>> _regionsGet() {
    final Uri $url = Uri.parse('/regions');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<List<RegionsGet$Response$Item>>,
        List<RegionsGet$Response$Item>>($request);
  }

  @override
  Future<Response<List<List<LanguagesGet$Response$Item>>>> _languagesGet() {
    final Uri $url = Uri.parse('/languages');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<List<LanguagesGet$Response$Item>>,
        List<LanguagesGet$Response$Item>>($request);
  }

  @override
  Future<Response<ProductionCompany>> _studioStudioIdGet(
      {required num? studioId}) {
    final Uri $url = Uri.parse('/studio/${studioId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<ProductionCompany, ProductionCompany>($request);
  }

  @override
  Future<Response<ProductionCompany>> _networkNetworkIdGet(
      {required num? networkId}) {
    final Uri $url = Uri.parse('/network/${networkId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<ProductionCompany, ProductionCompany>($request);
  }

  @override
  Future<Response<List<List<GenresMovieGet$Response$Item>>>> _genresMovieGet(
      {String? language}) {
    final Uri $url = Uri.parse('/genres/movie');
    final Map<String, dynamic> $params = <String, dynamic>{
      'language': language
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<List<GenresMovieGet$Response$Item>>,
        List<GenresMovieGet$Response$Item>>($request);
  }

  @override
  Future<Response<List<List<GenresTvGet$Response$Item>>>> _genresTvGet(
      {String? language}) {
    final Uri $url = Uri.parse('/genres/tv');
    final Map<String, dynamic> $params = <String, dynamic>{
      'language': language
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<List<GenresTvGet$Response$Item>>,
        List<GenresTvGet$Response$Item>>($request);
  }

  @override
  Future<Response<List<String>>> _backdropsGet() {
    final Uri $url = Uri.parse('/backdrops');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<String>, String>($request);
  }

  @override
  Future<Response<IssueGet$Response>> _issueGet({
    num? take,
    num? skip,
    String? sort,
    String? filter,
    num? requestedBy,
  }) {
    final Uri $url = Uri.parse('/issue');
    final Map<String, dynamic> $params = <String, dynamic>{
      'take': take,
      'skip': skip,
      'sort': sort,
      'filter': filter,
      'requestedBy': requestedBy,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<IssueGet$Response, IssueGet$Response>($request);
  }

  @override
  Future<Response<Issue>> _issuePost({required IssuePost$RequestBody? body}) {
    final Uri $url = Uri.parse('/issue');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<Issue, Issue>($request);
  }

  @override
  Future<Response<IssueCountGet$Response>> _issueCountGet() {
    final Uri $url = Uri.parse('/issue/count');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<IssueCountGet$Response, IssueCountGet$Response>($request);
  }

  @override
  Future<Response<Issue>> _issueIssueIdGet({required num? issueId}) {
    final Uri $url = Uri.parse('/issue/${issueId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<Issue, Issue>($request);
  }

  @override
  Future<Response<dynamic>> _issueIssueIdDelete({required String? issueId}) {
    final Uri $url = Uri.parse('/issue/${issueId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<Issue>> _issueIssueIdCommentPost({
    required num? issueId,
    required IssueIssueIdCommentPost$RequestBody? body,
  }) {
    final Uri $url = Uri.parse('/issue/${issueId}/comment');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<Issue, Issue>($request);
  }

  @override
  Future<Response<IssueComment>> _issueCommentCommentIdGet(
      {required String? commentId}) {
    final Uri $url = Uri.parse('/issueComment/${commentId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<IssueComment, IssueComment>($request);
  }

  @override
  Future<Response<IssueComment>> _issueCommentCommentIdPut({
    required String? commentId,
    required IssueCommentCommentIdPut$RequestBody? body,
  }) {
    final Uri $url = Uri.parse('/issueComment/${commentId}');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<IssueComment, IssueComment>($request);
  }

  @override
  Future<Response<dynamic>> _issueCommentCommentIdDelete(
      {required String? commentId}) {
    final Uri $url = Uri.parse('/issueComment/${commentId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<Issue>> _issueIssueIdStatusPost({
    required String? issueId,
    required String? status,
  }) {
    final Uri $url = Uri.parse('/issue/${issueId}/${status}');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<Issue, Issue>($request);
  }

  @override
  Future<Response<Keyword>> _keywordKeywordIdGet({required num? keywordId}) {
    final Uri $url = Uri.parse('/keyword/${keywordId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<Keyword, Keyword>($request);
  }

  @override
  Future<Response<List<WatchProviderRegion>>> _watchprovidersRegionsGet() {
    final Uri $url = Uri.parse('/watchproviders/regions');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<List<WatchProviderRegion>, WatchProviderRegion>($request);
  }

  @override
  Future<Response<List<WatchProviderDetails>>> _watchprovidersMoviesGet(
      {required String? watchRegion}) {
    final Uri $url = Uri.parse('/watchproviders/movies');
    final Map<String, dynamic> $params = <String, dynamic>{
      'watchRegion': watchRegion
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<List<WatchProviderDetails>, WatchProviderDetails>($request);
  }

  @override
  Future<Response<List<WatchProviderDetails>>> _watchprovidersTvGet(
      {required String? watchRegion}) {
    final Uri $url = Uri.parse('/watchproviders/tv');
    final Map<String, dynamic> $params = <String, dynamic>{
      'watchRegion': watchRegion
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<List<WatchProviderDetails>, WatchProviderDetails>($request);
  }

  @override
  Future<Response<CertificationResponse>> _certificationsMovieGet() {
    final Uri $url = Uri.parse('/certifications/movie');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<CertificationResponse, CertificationResponse>($request);
  }

  @override
  Future<Response<CertificationResponse>> _certificationsTvGet() {
    final Uri $url = Uri.parse('/certifications/tv');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<CertificationResponse, CertificationResponse>($request);
  }

  @override
  Future<Response<List<OverrideRule>>> _overrideRuleGet() {
    final Uri $url = Uri.parse('/overrideRule');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<OverrideRule>, OverrideRule>($request);
  }

  @override
  Future<Response<List<OverrideRule>>> _overrideRulePost() {
    final Uri $url = Uri.parse('/overrideRule');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<List<OverrideRule>, OverrideRule>($request);
  }

  @override
  Future<Response<List<OverrideRule>>> _overrideRuleRuleIdPut(
      {required num? ruleId}) {
    final Uri $url = Uri.parse('/overrideRule/${ruleId}');
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
    );
    return client.send<List<OverrideRule>, OverrideRule>($request);
  }

  @override
  Future<Response<OverrideRule>> _overrideRuleRuleIdDelete(
      {required num? ruleId}) {
    final Uri $url = Uri.parse('/overrideRule/${ruleId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<OverrideRule, OverrideRule>($request);
  }
}
