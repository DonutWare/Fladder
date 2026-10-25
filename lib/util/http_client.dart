import 'http_client_stub.dart' if (dart.library.io) 'http_client_io.dart' as impl;
import 'package:http/http.dart' as http;

http.Client createHttpClient() => impl.createHttpClient();
