import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/seerr/seerr_dashboard_model.dart';
import 'package:fladder/screens/seerr/widgets/seerr_request_banner_card.dart';
import 'package:fladder/widgets/shared/horizontal_list.dart';

class SeerrRequestBannerRow extends ConsumerWidget {
  final List<SeerrDashboardPosterModel> posters;
  final String label;
  final EdgeInsets contentPadding;
  final void Function(SeerrDashboardPosterModel poster)? onTap;
  final void Function(SeerrDashboardPosterModel focused)? onFocused;
  final void Function(SeerrDashboardPosterModel focused)? onRequestAddTap;
  final void Function()? onLabelClick;

  const SeerrRequestBannerRow({
    required this.posters,
    required this.label,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16),
    this.onTap,
    this.onFocused,
    this.onRequestAddTap,
    this.onLabelClick,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        HorizontalList<SeerrDashboardPosterModel>(
          label: label,
          items: posters,
          height: 200,
          contentPadding: contentPadding,
          onLabelClick: onLabelClick,
          onFocused: onFocused != null ? (index) => onFocused?.call(posters[index]) : null,
          itemBuilder: (context, index) {
            final poster = posters[index];
            return SizedBox(
              width: 350,
              child: SeerrRequestBannerCard(
                key: Key(poster.id),
                poster: poster,
                onTap: onTap,
              ),
            );
          },
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
