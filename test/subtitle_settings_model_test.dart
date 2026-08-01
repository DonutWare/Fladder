import 'package:fladder/models/settings/subtitle_settings_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('preserves bold font weight when serialized and restored', () {
    const settings = SubtitleSettingsModel(fontWeight: FontWeight.bold);

    final restored = SubtitleSettingsModel.fromJson(settings.toJson());

    expect(restored.fontWeight, FontWeight.bold);
  });
}
