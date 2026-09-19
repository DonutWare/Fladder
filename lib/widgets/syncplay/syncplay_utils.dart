import 'package:flutter/material.dart';

import 'package:fladder/widgets/syncplay/syncplay_group_sheet.dart';

/// Show the SyncPlay group management bottom sheet
void showSyncPlaySheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    builder: (context) => const SyncPlayGroupSheet(),
  );
}
