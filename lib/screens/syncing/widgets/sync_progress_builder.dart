import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/syncing/download_stream.dart';
import 'package:fladder/models/syncing/sync_item.dart';
import 'package:fladder/providers/sync/sync_provider_helpers.dart';

class SyncProgressBuilder extends ConsumerWidget {
  final SyncedItem item;
  final List<SyncedItem> children;
  final Widget Function(BuildContext context, DownloadStream? combinedStream) builder;
  const SyncProgressBuilder({required this.item, this.children = const [], required this.builder, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final syncStatus = ref.watch(syncDownloadStatusProvider(item, children));
    return builder(context, syncStatus);
  }
}
