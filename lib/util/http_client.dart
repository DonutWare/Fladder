import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cronet_http/cronet_http.dart';

http.Client createHttpClient() {
  if (Platform.isAndroid) {
    // Use Cronet on Android devices to trust user-installed root CA certificates
    return CronetClient.defaultCronetEngine();
  }

  return http.Client();
}
