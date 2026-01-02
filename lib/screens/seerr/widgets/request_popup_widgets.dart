import 'package:flutter/material.dart';

import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:square_progress_indicator/square_progress_indicator.dart';

import 'package:fladder/models/seerr/seerr_dashboard_model.dart';
import 'package:fladder/seerr/seerr_models.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/localization_helper.dart';

class AutoApproveBanner extends StatelessWidget {
  final SeerrUserModel? user;
  final bool isTv;

  const AutoApproveBanner({required this.user, required this.isTv, super.key});

  @override
  Widget build(BuildContext context) {
    final hasGlobalAutoApprove = user?.hasPermission(SeerrPermission.autoApprove) ?? false;
    final hasMovieAutoApprove = user?.hasPermission(SeerrPermission.autoApproveMovie) ?? false;
    final hasSeriesAutoApprove = user?.hasPermission(SeerrPermission.autoApproveTv) ?? false;
    final hasAutoApprove = hasGlobalAutoApprove || (isTv ? hasSeriesAutoApprove : hasMovieAutoApprove);

    if (!hasAutoApprove) return const SizedBox.shrink();

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiaryContainer,
        borderRadius: FladderTheme.smallShape.borderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8,
          children: [
            Icon(IconsaxPlusLinear.tick_circle, color: Theme.of(context).colorScheme.onTertiaryContainer),
            Expanded(
              child: Text(
                'Requests you submit are auto-approved.',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onTertiaryContainer,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PermissionDeniedWarning extends StatelessWidget {
  const PermissionDeniedWarning({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.errorContainer,
            borderRadius: FladderTheme.smallShape.borderRadius,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 8,
              children: [
                Icon(IconsaxPlusBold.forbidden_2, color: Theme.of(context).colorScheme.onErrorContainer),
                Expanded(
                  child: Text(
                    'You do not have permission to request this media type.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Theme.of(context).colorScheme.onErrorContainer),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 6),
      ],
    );
  }
}

class QuotaLimitCard extends StatelessWidget {
  final SeerrQuotaEntry quota;
  final SeerrDashboardMediaType type;

  const QuotaLimitCard({
    required this.quota,
    required this.type,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final quotaRemaining = quota.remaining ?? 0;
    final quotaLimit = quota.limit ?? 0;
    final quotaDays = quota.days ?? 0;

    final limitReached = quota.limit != null && quota.remaining != null && quota.remaining! <= 0;

    final mediaTypeLabel = type == SeerrDashboardMediaType.movie
        ? context.localized.mediaTypeMovie(5)
        : context.localized.mediaTypeSeries(5);

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.75),
        borderRadius: FladderTheme.smallShape.borderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          spacing: 8,
          children: [
            Expanded(
              child: Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.localized.requestQuotaStatus(
                      quotaRemaining,
                      quotaLimit,
                      quotaDays,
                    ),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  if (limitReached)
                    Text(
                      context.localized.requestQuotaLimitReached(mediaTypeLabel.toLowerCase()),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.error,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimaryContainer.withValues(alpha: 0.15),
                borderRadius: FladderTheme.defaultShape.borderRadius,
              ),
              padding: const EdgeInsets.all(4),
              child: Stack(
                children: [
                  SquareProgressIndicator(
                    value: quotaLimit > 0 ? quotaRemaining / quotaLimit : 0,
                    color: limitReached ? Theme.of(context).colorScheme.error : Colors.greenAccent,
                    strokeCap: StrokeCap.round,
                    strokeWidth: 6,
                    borderRadius: 12,
                    width: 48,
                    height: 48,
                  ),
                  Positioned.fill(
                    child: Center(
                      child: Text(
                        "$quotaRemaining/$quotaLimit",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: limitReached
                                  ? Theme.of(context).colorScheme.error
                                  : Theme.of(context).colorScheme.onPrimaryContainer,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
