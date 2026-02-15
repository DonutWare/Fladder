import 'package:flutter/material.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/localization_helper.dart';

class TunerHostCard extends StatelessWidget {
  final TunerHostInfo tunerHost;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TunerHostCard({
    super.key,
    required this.tunerHost,
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
          title: Text(tunerHost.friendlyName ?? tunerHost.type ?? context.localized.unknown),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (tunerHost.url != null) Text('${context.localized.url}: ${tunerHost.url}'),
              if (tunerHost.type != null) Text('${context.localized.type(1)}: ${tunerHost.type}'),
              if (tunerHost.tunerCount != null)
                Text('${context.localized.maxConcurrentStreamsLabel}: ${tunerHost.tunerCount}'),
            ],
          ),
        ),
      ),
    );
  }
}
