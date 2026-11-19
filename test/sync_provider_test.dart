import 'dart:io';

import 'package:material_ui/material_ui.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fladder/l10n/generated/app_localizations.dart';
import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/providers/connectivity_provider.dart' as connectivity;
import 'package:fladder/providers/sync_provider.dart';
import 'package:fladder/screens/shared/fladder_notification_overlay.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout_model.dart';
import 'package:fladder/util/poster_defaults.dart';

class _FolderPicker extends FilePickerPlatform {
  int calls = 0;

  @override
  Future<String?> getDirectoryPath({
    String? dialogTitle,
    String? initialDirectory,
    AndroidOptions androidOptions = const AndroidOptions(),
    WindowsOptions windowsOptions = const WindowsOptions(),
    LinuxOptions linuxOptions = const LinuxOptions(),
    WebOptions webOptions = const WebOptions(),
  }) async {
    calls++;
    return null;
  }
}

class _OfflineConnectivity extends connectivity.ConnectivityStatus {
  @override
  connectivity.ConnectionState build() => connectivity.ConnectionState.offline;
}

class _SyncNotifier extends SyncNotifier {
  _SyncNotifier(Ref ref) : super(ref, Directory.systemTemp);

  @override
  Directory? get saveDirectory => null;

  @override
  Future<void> cleanupTemporaryFiles() async {}

  @override
  Future<void> updateSyncStates() async {}
}

class _Item extends Fake implements ItemBaseModel {
  @override
  String detailedName(AppLocalizations l10n) => 'Test item';
}

void main() {
  testWidgets('Canceling the download folder picker does not start syncing', (tester) async {
    final originalPicker = FilePickerPlatform.instance;
    final picker = _FolderPicker();
    FilePickerPlatform.instance = picker;
    addTearDown(() => FilePickerPlatform.instance = originalPicker);
    addTearDown(FladderSnack().clearAll);

    final container = ProviderContainer.test(
      overrides: [
        connectivity.connectivityStatusProvider.overrideWith(_OfflineConnectivity.new),
        syncProvider.overrideWith(_SyncNotifier.new),
      ],
    );
    late BuildContext context;
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        builder: (_, child) => AdaptiveLayout(
          data: const AdaptiveLayoutModel(
            viewSize: ViewSize.desktop,
            layoutMode: LayoutMode.single,
            inputDevice: InputDevice.pointer,
            platform: TargetPlatform.linux,
            isDesktop: true,
            posterDefaults: PosterDefaults(size: 1, ratio: 1),
            controller: {},
            sideBarWidth: 0,
            topBarHeight: 0,
            statusBarHeight: 0,
          ),
          child: child!,
        ),
        home: Builder(
          builder: (itemContext) {
            context = itemContext;
            return const SizedBox.shrink();
          },
        ),
      ),
    );
    await container.read(syncProvider.notifier).addSyncItem(context, _Item());
    await tester.pumpAndSettle();

    final l10n = AppLocalizations.of(context);
    expect(picker.calls, 1);
    expect(find.text(l10n.syncNoFolderSetup), findsOneWidget);
    expect(find.text(l10n.syncAddItemForSyncing('Test item')), findsNothing);
    FladderSnack().clearAll();
  });
}
