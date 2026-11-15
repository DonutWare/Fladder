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
  @asyncCallback
  String next();
  @asyncCallback
  String nextVideo();
  @asyncCallback
  String close();

  @asyncCallback
  String skip(String name);

  @asyncCallback
  String subtitles();

  @asyncCallback
  String off();
  @asyncCallback
  String chapters(int count);

  @asyncCallback
  String nextUpInSeconds(int seconds);
  @asyncCallback
  String hoursAndMinutes(String time);

  @asyncCallback
  String endsAt(String time);

  @asyncCallback
  String switchChannel();
  @asyncCallback
  String switchChannelDesc(String programName, String channelName);
  @asyncCallback
  String watch();
  @asyncCallback
  String now();
  @asyncCallback
  String decline();
}
