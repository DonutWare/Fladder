import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fladder/models/seerr/seerr_dashboard_model.dart';
import 'package:fladder/models/seerr/seerr_item_models.dart';
import 'package:fladder/providers/seerr_api_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/seerr/seerr_models.dart';

part 'seerr_request_provider.freezed.dart';
part 'seerr_request_provider.g.dart';

@riverpod
class SeerrRequest extends _$SeerrRequest {
  late final api = ref.read(seerrApiProvider);

  @override
  SeerrRequestModel build() {
    return SeerrRequestModel();
  }

  Future<void> initialize(SeerrDashboardPosterModel poster) async {
    state = state.copyWith(poster: poster);

    final currentUser = await api.me();
    final currentUserBody = currentUser.body;
    final isTv = poster.type == SeerrDashboardMediaType.tv;

    SeerrDashboardPosterModel updatedPoster = poster;
    if (isTv) {
      final tvDetailsResponse = await api.tvDetails(tvId: poster.tmdbId);
      if (tvDetailsResponse.isSuccessful && tvDetailsResponse.body != null) {
        final details = tvDetailsResponse.body!;

        final Map<int, SeerrRequestStatus> seasonStatusMap = {
          for (final season in details.mediaInfo?.seasons ?? const <SeerrMediaInfoSeason>[])
            if (season.seasonNumber != null) season.seasonNumber!: SeerrRequestStatus.fromRaw(season.status),
        };

        final requests = details.mediaInfo?.requests ?? const <SeerrMediaRequest>[];
        if (requests.isNotEmpty) {
          for (final request in requests) {
            final requestStatus = SeerrRequestStatus.fromRaw(request.status);
            if (requestStatus == SeerrRequestStatus.pending || requestStatus == SeerrRequestStatus.processing) {
              seasonStatusMap.updateAll((key, value) {
                if (value != SeerrRequestStatus.available && value != SeerrRequestStatus.deleted) {
                  return requestStatus;
                }
                return value;
              });
            }
          }
        }

        updatedPoster = poster.copyWith(
          seasons: _resolveSeasonPosters(details.seasons),
          seasonStatuses: seasonStatusMap.isEmpty ? poster.seasonStatuses : seasonStatusMap,
          mediaInfo: details.mediaInfo,
        );
        state = state.copyWith(poster: updatedPoster);
      }
    } else if (!isTv) {
      final movieDetailsResponse = await api.movieDetails(tmdbId: poster.tmdbId);
      if (movieDetailsResponse.isSuccessful && movieDetailsResponse.body != null) {
        final details = movieDetailsResponse.body!;
        updatedPoster = poster.copyWith(mediaInfo: details.mediaInfo);
        state = state.copyWith(poster: updatedPoster);
      }
    }

    if (isTv) {
      _initializeSeasonSelection(updatedPoster);
    }

    if (isTv) {
      final servers = await api.sonarrServers();
      final nextState = state.copyWith(
        sonarrServers: servers,
        use4k: state.use4k && servers.firstWhereOrNull((s) => s.is4k == true) != null,
      );
      final selectedServer = nextState.activeSonarr;
      state = nextState.copyWith(
        selectedSonarrServer: selectedServer,
        selectedProfile: nextState.pickProfileForServer(selectedServer),
        selectedRootFolder: nextState.pickRootFolderForServer(selectedServer),
        currentUser: currentUserBody,
        selectedUser: currentUserBody,
      );
    } else {
      final servers = await api.radarrServers();
      final nextState = state.copyWith(
        radarrServers: servers,
        use4k: state.use4k && servers.firstWhereOrNull((s) => s.is4k == true) != null,
      );
      final selectedServer = nextState.activeRadarr;
      state = nextState.copyWith(
        selectedRadarrServer: selectedServer,
        selectedProfile: nextState.pickProfileForServer(selectedServer),
        selectedRootFolder: nextState.pickRootFolderForServer(selectedServer),
        currentUser: currentUserBody,
        selectedUser: currentUserBody,
      );
    }
  }

  Future<void> loadUsers() async {
    final users = await api.users();
    state = state.copyWith(availableUsers: users);
  }

  void selectProfile(SeerrServiceProfile profile) {
    state = state.copyWith(selectedProfile: profile);
  }

  void selectRootFolder(String folder) {
    state = state.copyWith(selectedRootFolder: folder);
  }

  void selectTags(List<SeerrServiceTag> tags) {
    state = state.copyWith(selectedTags: tags);
  }

  void toggleSeason(int seasonNumber, bool value) {
    if (state.isRequestedAlready(seasonNumber)) return;
    final current = Map<int, bool>.from(state.selectedSeasons);
    current[seasonNumber] = value;
    state = state.copyWith(selectedSeasons: current);
  }

  void selectUser(SeerrUser user) {
    state = state.copyWith(selectedUser: user);
  }

  void selectServer(SeerrServer? server) {
    if (server == null) {
      state = state.copyWith(use4k: false);
      return;
    }

    if (server is SeerrSonarrServer) {
      state = state.copyWith(
        selectedSonarrServer: server,
        selectedProfile: state.pickProfileForServer(server),
        selectedRootFolder: state.pickRootFolderForServer(server),
        use4k: server.is4k == true && state.has4k,
      );
    } else if (server is SeerrRadarrServer) {
      state = state.copyWith(
        selectedRadarrServer: server,
        selectedProfile: state.pickProfileForServer(server),
        selectedRootFolder: state.pickRootFolderForServer(server),
        use4k: server.is4k == true && state.has4k,
      );
    }
  }

  void toggle4k(bool enabled) {
    final poster = state.poster;
    if (poster == null) return;

    final nextState = state.copyWith(use4k: enabled && state.has4k);

    if (poster.type == SeerrDashboardMediaType.tv) {
      final selectedServer = nextState.activeSonarr;
      state = nextState.copyWith(
        selectedSonarrServer: selectedServer,
        selectedProfile: nextState.pickProfileForServer(selectedServer),
        selectedRootFolder: nextState.pickRootFolderForServer(selectedServer),
      );
    } else {
      final selectedServer = nextState.activeRadarr;
      state = nextState.copyWith(
        selectedRadarrServer: selectedServer,
        selectedProfile: nextState.pickProfileForServer(selectedServer),
        selectedRootFolder: nextState.pickRootFolderForServer(selectedServer),
      );
    }
  }

  Future<void> submitRequest() async {
    final poster = state.poster;
    if (poster == null) return;

    final userId = state.selectedUser?.id ?? state.currentUser?.id;
    final tags = state.selectedTags.map((t) => t.id).whereType<int>().toList();
    final profileId = state.selectedProfile?.id;
    final rootFolder = state.selectedRootFolder;

    final isTv = poster.type == SeerrDashboardMediaType.tv;

    if (isTv) {
      await api.requestSeries(
        tmdbId: poster.tmdbId,
        is4k: state.selectedSonarrServer?.is4k,
        userId: userId,
        serverId: state.selectedSonarrServer?.id,
        profileId: profileId,
        rootFolder: rootFolder,
        tags: tags,
        seasons: state.selectedSeasonNumbers,
      );
    } else {
      await api.requestMovie(
        tmdbId: poster.tmdbId,
        is4k: state.selectedRadarrServer?.is4k,
        userId: userId,
        serverId: state.selectedRadarrServer?.id,
        profileId: profileId,
        rootFolder: rootFolder,
        tags: tags,
      );
    }
  }

  List<SeerrSeason>? _resolveSeasonPosters(List<SeerrSeason>? seasons) {
    if (seasons == null) return null;
    final serverUrl = ref.read(userProvider)?.seerrCredentials?.serverUrl;
    return seasons
        .map(
          (season) => SeerrSeason(
            id: season.id,
            name: season.name,
            overview: season.overview,
            seasonNumber: season.seasonNumber,
            posterPath: resolveImageUrl(
              path: season.posterPath,
              serverUrl: serverUrl,
              tmdbBase: 'https://image.tmdb.org/t/p/w500',
            ),
            episodeCount: season.episodeCount,
            mediaId: season.mediaId,
          ),
        )
        .toList(growable: false);
  }

  void _initializeSeasonSelection(SeerrDashboardPosterModel poster) {
    final seasons = poster.seasons ?? const <SeerrSeason>[];
    final statuses = poster.seasonStatuses ?? const <int, SeerrRequestStatus>{};

    final selection = <int, bool>{};
    for (final season in seasons) {
      final number = season.seasonNumber;
      if (number == null) continue;
      final status = statuses[number];
      final locked = status != null && (status != SeerrRequestStatus.unknown && status != SeerrRequestStatus.deleted);
      selection[number] = locked;
    }

    state = state.copyWith(
      selectedSeasons: selection,
      seasonStatuses: statuses,
    );
  }
}

@Freezed(copyWith: true)
abstract class SeerrRequestModel with _$SeerrRequestModel {
  const SeerrRequestModel._();

  factory SeerrRequestModel({
    SeerrDashboardPosterModel? poster,
    @Default([]) List<SeerrSonarrServer> sonarrServers,
    @Default([]) List<SeerrRadarrServer> radarrServers,
    SeerrSonarrServer? selectedSonarrServer,
    SeerrRadarrServer? selectedRadarrServer,
    SeerrServiceProfile? selectedProfile,
    String? selectedRootFolder,
    @Default([]) List<SeerrServiceTag> selectedTags,
    @Default({}) Map<int, bool> selectedSeasons,
    @Default({}) Map<int, SeerrRequestStatus> seasonStatuses,
    SeerrUser? currentUser,
    SeerrUser? selectedUser,
    @Default([]) List<SeerrUser> availableUsers,
    @Default(false) bool use4k,
  }) = _SeerrRequestModel;

  bool get isTv => poster?.type == SeerrDashboardMediaType.tv;

  SeerrSonarrServer? get fourKSonarr => sonarrServers.firstWhereOrNull((s) => s.is4k == true);
  SeerrRadarrServer? get fourKRadarr => radarrServers.firstWhereOrNull((s) => s.is4k == true);

  SeerrSonarrServer? get defaultSonarr =>
      sonarrServers.firstWhereOrNull((s) => s.isDefault == true) ?? sonarrServers.firstOrNull;
  SeerrRadarrServer? get defaultRadarr =>
      radarrServers.firstWhereOrNull((s) => s.isDefault == true) ?? radarrServers.firstOrNull;

  SeerrSonarrServer? get activeSonarr => (use4k ? fourKSonarr : null) ?? defaultSonarr ?? fourKSonarr;
  SeerrRadarrServer? get activeRadarr => (use4k ? fourKRadarr : null) ?? defaultRadarr ?? fourKRadarr;

  bool get has4k => isTv ? fourKSonarr != null : fourKRadarr != null;

  List<SeerrServer> get availableServers => isTv ? sonarrServers : radarrServers;

  SeerrServer? get activeServer => isTv ? selectedSonarrServer : selectedRadarrServer;

  List<SeerrServiceProfile> get availableProfiles =>
      isTv ? (selectedSonarrServer?.profiles ?? const []) : (selectedRadarrServer?.profiles ?? const []);

  List<SeerrServiceTag> get availableTags =>
      isTv ? (selectedSonarrServer?.tags ?? const []) : (selectedRadarrServer?.tags ?? const []);

  List<int>? get selectedSeasonNumbers {
    final enabled =
        selectedSeasons.entries.where((e) => e.value && !isRequestedAlready(e.key)).map((e) => e.key).toList();
    if (enabled.isEmpty) return null;
    return enabled;
  }

  bool isRequestedAlready(int seasonNumber) {
    final status = seasonStatuses[seasonNumber];
    return status != null && status != SeerrRequestStatus.unknown && status != SeerrRequestStatus.deleted;
  }

  bool get canSubmitRequest {
    if (isTv) {
      return selectedSeasonNumbers?.isNotEmpty ?? false;
    }

    final requests = poster?.mediaInfo?.requests ?? const [];
    if (requests.isEmpty) return true;

    final currentUserId = currentUser?.id;
    if (currentUserId == null) return true;

    final hasUserRequest = requests.any((request) => request.requestedBy?.id == currentUserId);
    return !hasUserRequest;
  }

  List<SeerrRootFolder> get availableRootFoldersRaw =>
      isTv ? (selectedSonarrServer?.rootFolders ?? const []) : (selectedRadarrServer?.rootFolders ?? const []);

  List<String> get availableRootFolders => availableRootFoldersRaw.map((r) => r.path).whereType<String>().toList();

  String serverLabel(SeerrServer? server) {
    if (server == null) return 'Select Server';
    final name = server.name;
    final is4k = server.is4k;
    final suffix = is4k == true ? ' (4K)' : '';
    return '${name ?? 'Server'}$suffix';
  }

  SeerrServiceProfile? pickProfileForServer(SeerrServer? server) {
    final profiles = server?.profiles;
    final activeId = server?.activeProfileId;

    if (profiles == null || profiles.isEmpty) return null;
    if (activeId == null) return profiles.first;
    return profiles.firstWhereOrNull(
      (p) => p.id == activeId,
    );
  }

  String? pickRootFolderForServer(SeerrServer? server) {
    final folders = server?.rootFolders;
    final activeDirectory = server?.activeDirectory;

    final available = folders ?? const [];
    if (available.isEmpty) return activeDirectory;

    final match = available.firstWhereOrNull((r) => r.path == activeDirectory);

    return match?.path ?? activeDirectory ?? available.first.path;
  }
}
