import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/seerr/seerr_models.dart';
import 'package:fladder/util/localization_helper.dart';

class SeerrUserLabel extends StatelessWidget {
  final SeerrUserModel? user;

  const SeerrUserLabel({
    required this.user,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final avatarUrl = user?.avatar;
    final placeholder = CircleAvatar(
      radius: 18,
      child: Icon(
        FladderItemType.person.icon,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );

    final avatar = avatarUrl == null || avatarUrl.isEmpty
        ? placeholder
        : ClipOval(
            child: CachedNetworkImage(
              imageUrl: avatarUrl,
              cacheKey: 'seerr-user-avatar-${user?.id ?? avatarUrl}',
              width: 28,
              height: 28,
              fit: BoxFit.cover,
              placeholder: (_, __) => placeholder,
              errorWidget: (_, __, ___) => placeholder,
            ),
          );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        avatar,
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            user?.label ?? context.localized.unknown,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
