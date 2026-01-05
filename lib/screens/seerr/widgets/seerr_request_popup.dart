import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/seerr/seerr_dashboard_model.dart';
import 'package:fladder/providers/seerr/seerr_request_provider.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/screens/seerr/widgets/request_configuration_section.dart';
import 'package:fladder/screens/seerr/widgets/request_popup_widgets.dart';
import 'package:fladder/screens/seerr/widgets/seasons_section.dart';
import 'package:fladder/screens/shared/adaptive_dialog.dart';
import 'package:fladder/screens/shared/media/external_urls.dart';
import 'package:fladder/seerr/seerr_models.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/refresh_state.dart';
import 'package:fladder/widgets/shared/filled_button_await.dart';
import 'package:fladder/widgets/shared/pull_to_refresh.dart';

Future<void> openSeerrRequestPopup(
  BuildContext context,
  SeerrDashboardPosterModel poster,
) async {
  await showDialogAdaptive(
    context: context,
    builder: (context) => SeerrRequestPopup(
      requestModel: poster,
    ),
  );
  await context.refreshData();
}

class SeerrRequestPopup extends ConsumerStatefulWidget {
  final SeerrDashboardPosterModel requestModel;
  const SeerrRequestPopup({
    required this.requestModel,
    super.key,
  });

  @override
  ConsumerState<SeerrRequestPopup> createState() => _SeerrRequestPopupState();
}

class _SeerrRequestPopupState extends ConsumerState<SeerrRequestPopup> {
  final FocusNode _closeButtonFocusNode = FocusNode();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _ensureCloseButtonFocus();
  }

  void _ensureCloseButtonFocus() {
    if (AdaptiveLayout.inputDeviceOf(context) != InputDevice.dPad) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _closeButtonFocusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    _closeButtonFocusNode.dispose();
    super.dispose();
  }

  Future<void> openSeerrLink(BuildContext context, SeerrDashboardPosterModel model) async {
    final seerrUrl = ref.read(userProvider)?.seerrCredentials?.serverUrl;
    if (seerrUrl != null && seerrUrl.isNotEmpty) {
      final mediaType = model.type == SeerrMediaType.movie ? 'movie' : 'tv';
      final url = '$seerrUrl/$mediaType/${model.tmdbId}';
      launchUrl(context, url);
    }
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(seerrRequestProvider.notifier);
    final requestState = ref.watch(seerrRequestProvider);
    final model = requestState.poster ?? widget.requestModel;
    final seasons = requestState.poster?.seasons ?? const <SeerrSeason>[];
    final seasonStatuses = requestState.seasonStatuses;

    final currentUser = requestState.currentUser;
    final canShowAdvancedConfiguration = currentUser?.canManageRequests ?? false;

    return PullToRefresh(
      onRefresh: () => notifier.initialize(widget.requestModel),
      child: (context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  spacing: 8,
                  children: [
                    AutoApproveBanner(user: currentUser, isTv: requestState.isTv),
                    if (requestState.activeQuota != null && requestState.activeQuota?.hasRestrictions == true)
                      QuotaLimitCard(
                        quota: requestState.activeQuota!,
                        type: model.type,
                      ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 16,
                      children: [
                        if (model.images.primary != null)
                          FocusButton(
                            onTap: () => openSeerrLink(context, model),
                            borderRadius: BorderRadius.circular(8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: SizedBox(
                                width: 100,
                                height: 150,
                                child: FladderImage(
                                  image: model.images.primary,
                                  placeHolder: Container(
                                    color: Colors.grey,
                                    child: Icon(FladderItemType.movie.icon),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            spacing: 4,
                            children: [
                              Flexible(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        model.title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    if (model.hasDisplayStatus)
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                            decoration: BoxDecoration(
                                              color: model.displayStatusColor.withAlpha(200),
                                              borderRadius: FladderTheme.smallShape.borderRadius,
                                            ),
                                            child: Text(
                                              model.displayStatusLabel(context),
                                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                              Wrap(
                                spacing: 8,
                                runSpacing: 4,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.primaryContainer,
                                      borderRadius: FladderTheme.smallShape.borderRadius,
                                    ),
                                    child: Text(
                                      model.type == SeerrMediaType.movie
                                          ? context.localized.mediaTypeMovie(1)
                                          : context.localized.mediaTypeSeries(1),
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                  ),
                                  if (requestState.voteAverage != null && requestState.voteAverage! > 0)
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.secondaryContainer,
                                        borderRadius: FladderTheme.smallShape.borderRadius,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        spacing: 4,
                                        children: [
                                          Icon(
                                            IconsaxPlusBold.star_1,
                                            size: 16,
                                            color: Theme.of(context).colorScheme.onSecondaryContainer,
                                          ),
                                          Text(
                                            requestState.voteAverage!.toStringAsFixed(1),
                                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (requestState.contentRating != null && requestState.contentRating!.isNotEmpty)
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.tertiaryContainer,
                                        borderRadius: FladderTheme.smallShape.borderRadius,
                                      ),
                                      child: Text(
                                        requestState.contentRating!,
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                              color: Theme.of(context).colorScheme.onTertiaryContainer,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ),
                                  if (requestState.releaseDate != null && requestState.releaseDate!.isNotEmpty)
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.surfaceContainerHighest,
                                        borderRadius: FladderTheme.smallShape.borderRadius,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        spacing: 4,
                                        children: [
                                          Icon(
                                            IconsaxPlusBold.calendar,
                                            size: 14,
                                            color: Theme.of(context).colorScheme.onSurface,
                                          ),
                                          Text(
                                            DateTime.tryParse(requestState.releaseDate!)?.year.toString() ??
                                                requestState.releaseDate!,
                                            style: Theme.of(context).textTheme.bodyMedium,
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                              if (requestState.genres.isNotEmpty)
                                Wrap(
                                  spacing: 4,
                                  runSpacing: 4,
                                  children: requestState.genres.map((genre) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.surfaceContainerHighest,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        genre.name ?? '',
                                        style: Theme.of(context).textTheme.bodySmall,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              SelectableText(
                                model.overview.trim().isEmpty ? context.localized.noOverviewAvailable : model.overview,
                                style: Theme.of(context).textTheme.bodyMedium,
                                maxLines: 4,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (model.type == SeerrMediaType.tvshow && seasons.isNotEmpty) ...[
                      const Divider(),
                      SeerrSeasonsSection(
                        model: model,
                        requestState: requestState,
                        seasons: seasons,
                        seasonStatuses: seasonStatuses,
                      ),
                    ],
                    if (canShowAdvancedConfiguration) ...[
                      const Divider(),
                      RequestConfigurationSection(
                        requestState: requestState,
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const Divider(),
            if (requestState.hasRequestPermission == false) ...[
              const PermissionDeniedWarning(),
            ],
            if (requestState.isAnime) ...[
              Text(
                context.localized.seerrAnimeSeriesNote,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
            ],
            FilledButtonAwait(
              onPressed: requestState.canSubmitRequest
                  ? () async {
                      await notifier.submitRequest();
                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    }
                  : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 8,
                children: [
                  const Icon(IconsaxPlusBold.send_2),
                  Text(context.localized.submitRequest),
                ],
              ),
            ),
            ElevatedButton(
              autofocus: AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad,
              focusNode: _closeButtonFocusNode,
              onPressed: () => context.pop(),
              child: Text(context.localized.close),
            )
          ],
        ),
      ),
    );
  }
}
