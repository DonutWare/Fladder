import 'package:flutter/material.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/localization_helper.dart';

class ListingProviderCard extends StatelessWidget {
  final ListingsProviderInfo provider;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ListingProviderCard({
    super.key,
    required this.provider,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return FocusButton(
      onTap: onEdit,
      onLongPress: onDelete,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).colorScheme.surfaceContainer,
        ),
        child: ListTile(
          title: Text(provider.type ?? 'XMLTV'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (provider.path != null) Text('${context.localized.path}: ${provider.path}'),
              if (provider.username != null) Text('${context.localized.username}: ${provider.username}'),
            ],
          ),
        ),
      ),
    );
  }
}
