import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/translations_pigeon.g.dart',
    dartOptions: DartOptions(),
    kotlinOut: 'android/app/src/main/kotlin/nl/jknaapen/fladder/api/TranslationsPigeon.g.kt',
    kotlinOptions: KotlinOptions(
      includeErrorClass: false,
    ),
    dartPackageName: 'nl_jknaapen_fladder.settings',
  ),
)
@FlutterApi()
abstract class TranslationsPigeon {
  String next();
  String nextVideo();
  String close();

  String skip(String name);

  String subtitles();

  String off();
  String chapters(int count);

  String nextUpInSeconds(int seconds);

  String endsAt(String time);
}
