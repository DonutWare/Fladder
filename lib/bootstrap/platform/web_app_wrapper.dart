import 'dart:convert';

import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:universal_html/html.dart' as html;

import 'package:fladder/bootstrap/platform/base_app_wrapper.dart';
import 'package:fladder/util/fladder_config.dart';

class WebAppWrapper extends BaseAppWrapper {
  const WebAppWrapper({super.key, required super.builder});

  @override
  ConsumerState<WebAppWrapper> createState() => _WebAppWrapperState();
}

class _WebAppWrapperState extends BaseAppWrapperState<WebAppWrapper> {
  @override
  bool get enableNotifications => false;

  @override
  Future<void> platformInit() async {
    html.document.onContextMenu.listen((event) => event.preventDefault());
    final result = await _loadConfig();
    FladderConfig.fromJson(result);
  }

  Future<Map<String, dynamic>> _loadConfig() async {
    final configString = await rootBundle.loadString('config/config.json');
    return jsonDecode(configString);
  }
}
