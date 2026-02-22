import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/providers/control_panel/control_device_discovery_provider.dart';
import 'package:fladder/util/localization_helper.dart';

class DeviceDiscoveryDialog extends ConsumerStatefulWidget {
  final Future<List<TunerHostInfo>> Function() onDiscover;

  const DeviceDiscoveryDialog({super.key, required this.onDiscover});

  @override
  ConsumerState<DeviceDiscoveryDialog> createState() => _DeviceDiscoveryDialogState();
}

class _DeviceDiscoveryDialogState extends ConsumerState<DeviceDiscoveryDialog> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(controlDeviceDiscoveryProvider.notifier).discoverDevices(widget.onDiscover);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(controlDeviceDiscoveryProvider);

    return AlertDialog(
      title: Text(context.localized.discoveredDevices),
      content: SizedBox(
        width: double.maxFinite,
        height: 300,
        child: state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : state.devices.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.devices_other, size: 48),
                        const SizedBox(height: 16),
                        Text(context.localized.noDevicesFound),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: state.devices.length,
                    itemBuilder: (context, index) {
                      final device = state.devices[index];
                      return ListTile(
                        title: Text(device.friendlyName ?? device.url ?? context.localized.unknown),
                        subtitle: Text('${device.type?.toUpperCase() ?? ''} • ${device.url ?? ''}'),
                        onTap: () => Navigator.of(context).pop(device),
                      );
                    },
                  ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.localized.cancel),
        ),
      ],
    );
  }
}
