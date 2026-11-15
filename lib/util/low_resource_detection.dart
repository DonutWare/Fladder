import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:device_info_plus/device_info_plus.dart';

const _lowResourceRamMb = 3 * 1024;

Future<bool> resolveLowResourceDevice() async {
  try {
    final deviceInfo = DeviceInfoPlugin();
    if (kIsWeb) {
      final memoryGb = (await deviceInfo.webBrowserInfo).deviceMemory;
      return memoryGb != null && memoryGb * 1024 <= _lowResourceRamMb;
    }
    return switch (defaultTargetPlatform) {
      TargetPlatform.android => await deviceInfo.androidInfo.then(
          (info) => info.isLowRamDevice || _isLowRam(info.physicalRamSize),
        ),
      TargetPlatform.iOS => _isLowRam((await deviceInfo.iosInfo).physicalRamSize),
      TargetPlatform.macOS => _isLowRam((await deviceInfo.macOsInfo).memorySize ~/ (1024 * 1024)),
      TargetPlatform.windows => _isLowRam((await deviceInfo.windowsInfo).systemMemoryInMegabytes),
      TargetPlatform.linux => _isLowRam(await _linuxRamMb()),
      _ => false,
    };
  } catch (e) {
    print('Low resource detection failed: $e');
    return false;
  }
}

bool _isLowRam(int? ramMb) => ramMb != null && ramMb > 0 && ramMb <= _lowResourceRamMb;

Future<int?> _linuxRamMb() async {
  final memInfo = await File('/proc/meminfo').readAsLines();
  final totalLine = memInfo.firstWhere((line) => line.startsWith('MemTotal:'), orElse: () => '');
  final totalKb = int.tryParse(RegExp(r'\d+').firstMatch(totalLine)?.group(0) ?? '');
  return totalKb == null ? null : totalKb ~/ 1024;
}
