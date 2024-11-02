import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension DeviceOrientationExtension on DeviceOrientation {
  String label(BuildContext context) => switch (this) {
        DeviceOrientation.portraitUp => throw UnimplementedError(),
        DeviceOrientation.landscapeLeft => throw UnimplementedError(),
        DeviceOrientation.portraitDown => throw UnimplementedError(),
        DeviceOrientation.landscapeRight => throw UnimplementedError(),
      };
}
