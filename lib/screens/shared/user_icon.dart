import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/account_model.dart';
import 'package:fladder/screens/shared/flat_button.dart';
import 'package:fladder/util/string_extensions.dart';

class UserIcon extends ConsumerWidget {
  final AccountModel? user;
  final Size size;
  final TextStyle? labelStyle;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double cornerRadius;
  const UserIcon({
    this.size = const Size(50, 50),
    this.labelStyle,
    this.cornerRadius = 5,
    this.onTap,
    this.onLongPress,
    required this.user,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget placeHolder() {
      return Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Center(
          child: Text(
            user?.name.getInitials() ?? "",
            style: (labelStyle ?? Theme.of(context).textTheme.titleMedium)?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
        ),
      );
    }

    return Hero(
      tag: Key(user?.id ?? "empty-user-avatar"),
      child: AspectRatio(
        aspectRatio: 1,
        child: Card(
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          child: SizedBox.fromSize(
            size: size,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: user?.avatar ?? "",
                  progressIndicatorBuilder: (context, url, progress) => placeHolder(),
                  errorWidget: (context, url, error) => placeHolder(),
                ),
                FlatButton(
                  onTap: onTap,
                  onLongPress: onLongPress,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
