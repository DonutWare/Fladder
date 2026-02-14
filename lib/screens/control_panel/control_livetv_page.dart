import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/providers/control_panel/control_livetv_provider.dart';
import 'package:fladder/screens/control_panel/control_livetv/listing_provider_card.dart';
import 'package:fladder/screens/control_panel/control_livetv/listing_provider_edit_dialog.dart';
import 'package:fladder/screens/control_panel/control_livetv/refresh_guide_button.dart';
import 'package:fladder/screens/control_panel/control_livetv/tuner_host_card.dart';
import 'package:fladder/screens/control_panel/control_livetv/tuner_host_edit_dialog.dart';
import 'package:fladder/screens/control_panel/widgets/control_panel_card.dart';
import 'package:fladder/screens/settings/settings_scaffold.dart';
import 'package:fladder/screens/shared/fladder_notification_overlay.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/refresh_state.dart';
import 'package:fladder/widgets/shared/pull_to_refresh.dart';

@RoutePage()
class ControlLiveTvPage extends ConsumerWidget {
  const ControlLiveTvPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liveTvState = ref.watch(controlLiveTvProvider);
    final provider = ref.read(controlLiveTvProvider.notifier);

    final tunerHosts = liveTvState.liveTvOptions?.tunerHosts ?? [];
    final listingProviders = liveTvState.liveTvOptions?.listingProviders ?? [];

    return PullToRefresh(
      onRefresh: () => provider.loadConfiguration(),
      child: (context) => SettingsScaffold(
        label: context.localized.liveTV,
        itemSpacing: 16,
        items: [
          ControlPanelCard(
            title: context.localized.tunerDevices,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (tunerHosts.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(context.localized.noTunerDevicesConfigured),
                  )
                else
                  ...tunerHosts.map(
                    (tuner) => TunerHostCard(
                      tunerHost: tuner,
                      onEdit: () => _editTunerHost(context, ref, tuner),
                      onDelete: () => _deleteTunerHost(context, ref, tuner),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton.icon(
                    onPressed: () => _addTunerHost(context, ref),
                    icon: const Icon(IconsaxPlusLinear.add),
                    label: Text(context.localized.addTunerDevice),
                  ),
                ),
              ],
            ),
          ),
          ControlPanelCard(
            title: context.localized.epgGuideProviders,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (listingProviders.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(context.localized.noEpgProvidersConfigured),
                  )
                else
                  ...listingProviders.map(
                    (provider) => ListingProviderCard(
                      provider: provider,
                      onEdit: () => _editListingProvider(context, ref, provider),
                      onDelete: () => _deleteListingProvider(context, ref, provider),
                    ),
                  ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: RefreshGuideButton(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _addTunerHost(BuildContext context, WidgetRef ref) async {
    final result = await showDialog<TunerHostInfo>(
      context: context,
      builder: (context) => const TunerHostEditDialog(),
    );

    if (result != null && context.mounted) {
      final response = await FladderSnack.showResponse<TunerHostInfo>(
        ref.read(controlLiveTvProvider.notifier).addTunerHost(result),
        successTitle: context.localized.tunerHostAddedSuccessfully,
        errorTitle: (err) => context.localized.failedToAddTunerHost(err),
      );
      if (response.isSuccess && context.mounted) {
        await context.refreshData();
      }
    }
  }

  Future<void> _editTunerHost(BuildContext context, WidgetRef ref, TunerHostInfo tunerHost) async {
    final result = await showDialog<TunerHostInfo>(
      context: context,
      builder: (context) => TunerHostEditDialog(tunerHost: tunerHost),
    );

    if (result != null && context.mounted) {
      final response = await FladderSnack.showResponse<TunerHostInfo>(
        ref.read(controlLiveTvProvider.notifier).updateTunerHost(tunerHost, result),
        successTitle: context.localized.tunerHostUpdatedSuccessfully,
        errorTitle: (err) => context.localized.failedToUpdateTunerHost(err),
      );
      if (response.isSuccess && context.mounted) {
        await context.refreshData();
      }
    }
  }

  Future<void> _deleteTunerHost(BuildContext context, WidgetRef ref, TunerHostInfo tunerHost) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.localized.deleteTunerHost),
        content: Text(context.localized.deleteTunerHostConfirm(tunerHost.friendlyName ?? tunerHost.url ?? '')),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(context.localized.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(context.localized.delete),
          ),
        ],
      ),
    );

    if (confirmed == true && tunerHost.id != null && context.mounted) {
      final response = await FladderSnack.showResponse<dynamic>(
        ref.read(controlLiveTvProvider.notifier).deleteTunerHost(tunerHost.id!),
        successTitle: context.localized.tunerHostDeletedSuccessfully,
        errorTitle: (err) => context.localized.failedToDeleteTunerHost(err),
      );
      if (response.isSuccess && context.mounted) {
        await context.refreshData();
      }
    }
  }

  Future<void> _editListingProvider(BuildContext context, WidgetRef ref, ListingsProviderInfo provider) async {
    final result = await showDialog<ListingsProviderInfo>(
      context: context,
      builder: (context) => ListingProviderEditDialog(provider: provider),
    );

    if (result != null && context.mounted) {
      final response = await FladderSnack.showResponse<ListingsProviderInfo>(
        ref.read(controlLiveTvProvider.notifier).updateListingProvider(provider, result),
        successTitle: context.localized.epgProviderUpdatedSuccessfully,
        errorTitle: (err) => context.localized.failedToUpdateEpgProvider(err),
      );
      if (response.isSuccess && context.mounted) {
        await context.refreshData();
      }
    }
  }

  Future<void> _deleteListingProvider(BuildContext context, WidgetRef ref, ListingsProviderInfo provider) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.localized.deleteEpgProvider),
        content: Text(context.localized.deleteEpgProviderConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(context.localized.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(context.localized.delete),
          ),
        ],
      ),
    );

    if (confirmed == true && provider.id != null && context.mounted) {
      final response = await FladderSnack.showResponse<dynamic>(
        ref.read(controlLiveTvProvider.notifier).deleteListingProvider(provider.id!),
        successTitle: context.localized.epgProviderDeletedSuccessfully,
        errorTitle: (err) => context.localized.failedToDeleteEpgProvider(err),
      );
      if (response.isSuccess && context.mounted) {
        await context.refreshData();
      }
    }
  }
}
