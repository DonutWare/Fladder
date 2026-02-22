import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/seerr/seerr_dashboard_model.dart';
import 'package:fladder/providers/seerr_api_provider.dart';
import 'package:fladder/providers/seerr_user_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/screens/shared/fladder_notification_overlay.dart';
import 'package:fladder/screens/shared/media/external_urls.dart';
import 'package:fladder/seerr/seerr_models.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/item_actions.dart';
import 'package:fladder/widgets/shared/modal_bottom_sheet.dart';
import 'package:fladder/widgets/shared/modal_side_sheet.dart';

Future<void> showMediaManagementSheet({
  required BuildContext context,
  required SeerrDashboardPosterModel mediaInfo,
  required VoidCallback onActionComplete,
}) async {
  if (AdaptiveLayout.viewSizeOf(context) != ViewSize.phone) {
    await showModalSideSheet(
      context,
      header: Column(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(child: Text(context.localized.settings)),
          Flexible(child: Text(mediaInfo.title, style: Theme.of(context).textTheme.headlineSmall)),
        ],
      ),
      content: _MediaManagementActions(
        poster: mediaInfo,
        onActionComplete: onActionComplete,
      ),
    );
  } else {
    await showBottomSheetPill(
      context: context,
      content: (context, scrollController) => _MediaManagementActions(
        poster: mediaInfo,
        onActionComplete: onActionComplete,
        scrollController: scrollController,
      ),
    );
  }
}

class _MediaManagementActions extends ConsumerStatefulWidget {
  final SeerrDashboardPosterModel poster;
  final VoidCallback onActionComplete;
  final ScrollController? scrollController;

  const _MediaManagementActions({
    required this.poster,
    required this.onActionComplete,
    this.scrollController,
  });

  @override
  ConsumerState<_MediaManagementActions> createState() => _MediaManagementActionsState();
}

class _MediaManagementActionsState extends ConsumerState<_MediaManagementActions> {
  bool _isLoading = false;
  String? _errorMessage;

  late final isTvSeries = widget.poster.type == SeerrMediaType.tvshow;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final canManageRequest = ref.watch(seerrUserProvider.select((value) => value?.canManageRequests ?? false));

    final mediaInfo = widget.poster.mediaInfo;
    final itemModel = widget.poster.itemBaseModel;

    if (mediaInfo == null) {
      return Center(
        child: Text(context.localized.unknown),
      );
    }

    final actions = [
      ItemActionButton(
        icon: const Icon(IconsaxPlusBold.discover),
        label: Text(context.localized.openInSeerr),
        backgroundColor: Colors.deepPurpleAccent.shade700,
        action: () {
          final seerrUrl = ref.read(userProvider.select((value) => value?.seerrCredentials?.serverUrl));
          if (isTvSeries) {
            launchUrl(context, '$seerrUrl/tv/${widget.poster.tmdbId}');
          } else {
            launchUrl(context, '$seerrUrl/movie/${widget.poster.tmdbId}');
          }
        },
      ),
      if (itemModel != null)
        ItemActionButton(
          icon: Icon(itemModel.type.icon),
          label: Text(context.localized.showDetails),
          action: () {
            itemModel.navigateTo(context);
          },
        ),
      if (canManageRequest) ...[
        if (mediaInfo.serviceUrl != null) ...[
          ItemActionDivider(),
          ItemActionButton(
            icon: const Icon(IconsaxPlusLinear.export_1),
            label: Text(isTvSeries ? context.localized.openInSonarr : context.localized.openInRadarr),
            action: _isLoading ? null : _openInExternalService,
          ),
          ItemActionButton(
            icon: const Icon(IconsaxPlusLinear.close_circle),
            backgroundColor: theme.colorScheme.errorContainer,
            foregroundColor: theme.colorScheme.onErrorContainer,
            label: Text(isTvSeries ? context.localized.removeFromSonarr : context.localized.removeFromRadarr),
            action: _isLoading ? null : _removeFromService,
          ),
        ],
        ItemActionDivider(),
        if (widget.poster.mediaStatus != SeerrMediaStatus.available)
          ItemActionButton(
            icon: const Icon(IconsaxPlusLinear.tick_circle),
            backgroundColor: Colors.green.shade900,
            label: Text(isTvSeries ? context.localized.markAllSeasonsAsAvailable : context.localized.markAsAvailable),
            action: _isLoading ? null : _markAsAvailable,
          ),
        ItemActionButton(
          icon: const Icon(IconsaxPlusLinear.trash),
          label: Text(context.localized.deleteData),
          backgroundColor: theme.colorScheme.errorContainer,
          foregroundColor: theme.colorScheme.onErrorContainer,
          action: _isLoading ? null : _deleteData,
        ),
      ],
    ];

    return ListView(
      controller: widget.scrollController,
      shrinkWrap: true,
      padding: const EdgeInsets.all(16),
      children: [
        if (_errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Material(
              color: theme.colorScheme.errorContainer,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(
                      IconsaxPlusLinear.danger,
                      color: theme.colorScheme.onErrorContainer,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _errorMessage!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onErrorContainer,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        if (_isLoading)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: CircularProgressIndicator(),
            ),
          )
        else
          ...actions
              .listTileItems(
                context,
                useIcons: true,
                shouldPop: false,
              )
              .addInBetween(const SizedBox(height: 6)),
      ],
    );
  }

  Future<void> _handleAction(Future<void> Function() action, String successMessage) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await action();
      if (mounted) {
        FladderSnack.show(successMessage);
        Navigator.of(context).pop();
        widget.onActionComplete();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _openInExternalService() async {
    final serviceUrl = widget.poster.mediaInfo?.serviceUrl;
    if (serviceUrl == null) return;

    launchUrl(context, serviceUrl);
  }

  Future<void> _removeFromService() async {
    final seerrService = ref.read(seerrApiProvider);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.localized.delete),
        content: Text(
          isTvSeries ? context.localized.removeSeriesFromSonarrConfirm : context.localized.removeMovieFromRadarrConfirm,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(context.localized.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(context.localized.delete),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    await _handleAction(
      () async {
        final mediaId = widget.poster.mediaInfo?.id;
        if (mediaId == null) throw Exception('Media ID is null');

        await seerrService.deleteMediaFile(mediaId: mediaId);
      },
      isTvSeries ? context.localized.removedFromSonarr : context.localized.removedFromRadarr,
    );
  }

  Future<void> _markAsAvailable() async {
    final seerrService = ref.read(seerrApiProvider);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.localized.delete),
        content: Text(
          isTvSeries ? context.localized.markAllSeasonsAsAvailableConfirm : context.localized.markAsAvailableConfirm,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(context.localized.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(context.localized.ok),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    await _handleAction(
      () async {
        final mediaId = widget.poster.mediaInfo?.id;
        if (mediaId == null) throw Exception('Media ID is null');
        await seerrService.updateMediaStatus(
          mediaId: mediaId,
          status: 'available',
          body: {},
        );
      },
      context.localized.markedAsAvailable,
    );
  }

  Future<void> _deleteData() async {
    final seerrService = ref.read(seerrApiProvider);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.localized.delete),
        content: Text(
          context.localized.deleteSeerrDataConfirm(isTvSeries ? "Sonarr" : "Radarr"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(context.localized.cancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(context.localized.delete),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    await _handleAction(
      () async {
        final mediaId = widget.poster.mediaInfo?.id;
        if (mediaId == null) throw Exception('Media ID is null');
        await seerrService.deleteMedia(mediaId: mediaId);
      },
      context.localized.dataDeleted,
    );
  }
}
