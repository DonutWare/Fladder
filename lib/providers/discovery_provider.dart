import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/providers/service_provider.dart';

part 'discovery_provider.g.dart';
part 'discovery_provider.mapper.dart';

@riverpod
class ServerDiscovery extends _$ServerDiscovery {
  final String discoveryMessage = 'Who is JellyfinServer?';
  final int discoveryPort = 7359;
  final int maxServerCount = 25;
  final Duration timeOut = const Duration(seconds: 5);
  late final JellyService api = JellyService(ref, JellyfinOpenApi.create());

  @override
  Stream<List<DiscoveryInfo>> build() async* {
    final List<DiscoveryInfo> discoveredServers = [];
    final StreamController<List<DiscoveryInfo>> controller = StreamController<List<DiscoveryInfo>>();

    // Bind the socket and start listening
    final RawDatagramSocket socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0);
    socket.broadcastEnabled = true;

    // Send the broadcast message
    socket.send(
      utf8.encode(discoveryMessage),
      InternetAddress('255.255.255.255'), // Broadcast address
      discoveryPort,
    );

    // log('Discovery message sent. Waiting for response...');

    // Set a timer to close the socket after the timeout
    Timer timer = Timer(timeOut, () {
      // log('Timeout reached, closing socket.');
      if (discoveredServers.isEmpty) {
        controller.add([]);
      }
      socket.close();
      controller.close(); // Close the stream controller when done
    });

    socket.listen((RawSocketEvent event) {
      if (event == RawSocketEvent.read) {
        Datagram? dg = socket.receive();
        if (dg != null) {
          // Decode the response
          String response = utf8.decode(dg.data);
          Map<String, dynamic> jsonResponse = jsonDecode(response);

          final discovery = DiscoveryInfo.fromMap(jsonResponse);

          discoveredServers.add(discovery);
          controller.add(List<DiscoveryInfo>.from(discoveredServers)); // Emit the updated list

          if (discoveredServers.length >= maxServerCount) {
            log('Max servers found, closing socket.');
            timer.cancel();
            socket.close();
            controller.close(); // Close the stream controller
          }
        }
      }
    });

    yield* controller.stream;

    // Handle disposal when the provider is no longer needed
    ref.onDispose(() {
      timer.cancel();
      socket.close();
      controller.close();
    });
  }
}

@MappableClass(generateMethods: GenerateMethods.encode | GenerateMethods.decode)
class DiscoveryInfo with DiscoveryInfoMappable {
  @MappableField(key: 'Id')
  final String id;
  @MappableField(key: 'Name')
  final String name;
  @MappableField(key: 'Address')
  final String address;
  @MappableField(key: "EndpointAddress")
  final String? endPointAddress;

  const DiscoveryInfo({
    required this.id,
    required this.name,
    required this.address,
    required this.endPointAddress,
  });

  factory DiscoveryInfo.fromMap(Map<String, dynamic> map) => DiscoveryInfoMapper.fromMap(map);
  factory DiscoveryInfo.fromJson(String json) => DiscoveryInfoMapper.fromJson(json);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DiscoveryInfo && other.id == id && other.address == address;
  }

  @override
  int get hashCode => id.hashCode ^ address.hashCode;
}
