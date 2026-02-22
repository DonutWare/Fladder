import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/battery_optimization_pigeon.g.dart',
    dartOptions: DartOptions(),
    kotlinOut: 'android/app/src/main/kotlin/nl/jknaapen/fladder/api/BatteryOptimizationPigeon.g.kt',
    kotlinOptions: KotlinOptions(
      includeErrorClass: false,
    ),
    dartPackageName: 'nl_jknaapen_fladder.settings',
  ),
)
@HostApi()
abstract class BatteryOptimizationPigeon {
  bool isIgnoringBatteryOptimizations();

  void openBatteryOptimizationSettings();
}
