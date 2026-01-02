import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/models/seerr/seerr_dashboard_model.dart';
import 'package:fladder/providers/seerr/seerr_request_provider.dart';
import 'package:fladder/screens/seerr/widgets/request_configuration_section.dart';
import 'package:fladder/screens/seerr/widgets/request_popup_widgets.dart';
import 'package:fladder/screens/seerr/widgets/seasons_section.dart';
import 'package:fladder/screens/shared/adaptive_dialog.dart';
import 'package:fladder/seerr/seerr_models.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/filled_button_await.dart';
import 'package:fladder/widgets/shared/pull_to_refresh.dart';

Future<void> openSeerrRequestPopup(
  BuildContext context,
  SeerrDashboardPosterModel poster,
) {
  return showDialogAdaptive(
    context: context,
    builder: (context) => SeerrRequestPopup(
      requestModel: poster,
    ),
  );
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
      child: Padding(
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
                          ClipRRect(
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
                                    if (model.status != SeerrRequestStatus.unknown)
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                            decoration: BoxDecoration(
                                              color: model.status.color.withAlpha(200),
                                              borderRadius: FladderTheme.smallShape.borderRadius,
                                            ),
                                            child: Text(
                                              model.status.label,
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
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primaryContainer,
                                  borderRadius: FladderTheme.smallShape.borderRadius,
                                ),
                                child: Text(
                                  model.type == SeerrDashboardMediaType.movie
                                      ? context.localized.mediaTypeMovie(1)
                                      : context.localized.mediaTypeSeries(1),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
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
                    if (model.type == SeerrDashboardMediaType.tv && seasons.isNotEmpty) ...[
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
            if (requestState.canDeleteRequest) ...[
              FilledButtonAwait(
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.errorContainer,
                  foregroundColor: Theme.of(context).colorScheme.onErrorContainer,
                ),
                onPressed: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (dialogContext) => AlertDialog(
                      title: Text(context.localized.delete),
                      content: Text(context.localized.deleteRequestConfirmation),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(dialogContext).pop(false),
                          child: Text(context.localized.cancel),
                        ),
                        FilledButton.tonal(
                          style: FilledButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.error,
                            foregroundColor: Theme.of(context).colorScheme.onError,
                          ),
                          onPressed: () => Navigator.of(dialogContext).pop(true),
                          child: Text(context.localized.delete),
                        ),
                      ],
                    ),
                  );

                  if (confirm != true) return;

                  await notifier.deleteRequest();
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 8,
                  children: [
                    const Icon(IconsaxPlusBold.trash),
                    Text(context.localized.delete),
                  ],
                ),
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
              onPressed: () => context.pop(),
              child: Text(context.localized.close),
            )
          ],
        ),
      ),
    );
  }
}
