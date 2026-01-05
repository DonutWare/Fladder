import 'package:flutter/material.dart';

import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/seerr/seerr_dashboard_model.dart';
import 'package:fladder/screens/seerr/widgets/seerr_request_banner_card.dart';
import 'package:fladder/seerr/seerr_models.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/refresh_state.dart';
import 'package:fladder/widgets/shared/modal_bottom_sheet.dart';
import 'package:fladder/widgets/shared/modal_side_sheet.dart';

Future<void> showSeerrRequestsSheet({
  required BuildContext context,
  required SeerrDashboardPosterModel poster,
  required List<SeerrMediaRequest> requests,
  required Future<void> Function(int requestId) onApprove,
  required Future<void> Function(int requestId) onDecline,
}) async {
  final sheetContent = _SeerrRequestsSheet(
    poster: poster,
    requests: requests,
    onApprove: onApprove,
    onDecline: onDecline,
  );

  if (AdaptiveLayout.viewSizeOf(context) != ViewSize.phone) {
    await showModalSideSheet(
      context,
      header: Text(context.localized.manageRequest),
      content: sheetContent,
    );
  } else {
    await showBottomSheetPill(
      context: context,
      content: (context, scrollController) => _SeerrRequestsSheet(
        poster: poster,
        requests: requests,
        onApprove: onApprove,
        onDecline: onDecline,
        scrollController: scrollController,
      ),
    );
  }
  context.refreshData();
}

class _SeerrRequestsSheet extends StatelessWidget {
  const _SeerrRequestsSheet({
    required this.poster,
    required this.requests,
    required this.onApprove,
    required this.onDecline,
    this.scrollController,
  });

  final SeerrDashboardPosterModel poster;
  final List<SeerrMediaRequest> requests;
  final Future<void> Function(int requestId) onApprove;
  final Future<void> Function(int requestId) onDecline;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    final useParentScroll = scrollController != null;

    return ListView.separated(
      controller: useParentScroll ? scrollController : null,
      physics: useParentScroll ? const NeverScrollableScrollPhysics() : const ClampingScrollPhysics(),
      shrinkWrap: useParentScroll,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final request = requests[index];
        final requestStatus = SeerrRequestStatus.fromRaw(request.status);
        final requestId = request.id;
        final isPending = requestStatus == SeerrRequestStatus.pending;

        final requestPoster = poster.copyWith(
          requestStatus: requestStatus,
          requestedBy: request.requestedBy,
          requestedSeasons: request.seasons,
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            ExcludeFocus(
              child: IgnorePointer(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minHeight: 125,
                    maxHeight: 225,
                  ),
                  child: SeerrRequestBannerCard(poster: requestPoster),
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 8,
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                        icon: const Icon(IconsaxPlusBold.close_circle),
                        label: Text(context.localized.decline),
                        onPressed: requestId != null
                            ? () {
                                onDecline(requestId);
                                Navigator.of(context).pop();
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.errorContainer,
                          foregroundColor: Theme.of(context).colorScheme.onErrorContainer,
                        )),
                  ),
                  Expanded(
                    child: FilledButton.icon(
                      autofocus: index == 0 && AdaptiveLayout.inputDeviceOf(context) == InputDevice.dPad,
                      icon: const Icon(IconsaxPlusBold.tick_circle),
                      label: Text(context.localized.approve),
                      onPressed: isPending && requestId != null
                          ? () {
                              onApprove(requestId);
                              Navigator.of(context).pop();
                            }
                          : null,
                      style: FilledButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
      separatorBuilder: (_, __) => const Divider(),
      itemCount: requests.length,
    );
  }
}
