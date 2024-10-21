import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:ficonsax/ficonsax.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/credentials_model.dart';
import 'package:fladder/providers/discovery_provider.dart';
import 'package:fladder/util/fladder_config.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/theme_extensions.dart';

class DiscoverServersWidget extends ConsumerWidget {
  final List<CredentialsModel> serverCredentials;
  final Function(DiscoveryInfo server) onPressed;
  const DiscoverServersWidget({
    required this.serverCredentials,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (FladderConfig.baseUrl?.isNotEmpty == true) return const SizedBox.shrink();
    final existingServers = serverCredentials
        .map(
          (credentials) => DiscoveryInfo(
              id: credentials.serverId,
              name: credentials.serverName,
              address: credentials.server,
              endPointAddress: null),
        )
        .toSet()
        .toList();
    final discoverdServersStream = ref.watch(serverDiscoveryProvider);
    return ListView(
      padding: const EdgeInsets.all(6),
      shrinkWrap: true,
      children: [
        if (existingServers.isNotEmpty) ...[
          Row(
            children: [
              Text(
                context.localized.saved,
                style: context.textTheme.bodyLarge,
              ),
              const Spacer(),
              const Opacity(opacity: 0.65, child: Icon(IconsaxOutline.bookmark, size: 16)),
            ],
          ),
          const SizedBox(height: 4),
          ...existingServers
              .map(
                (server) => _ServerInfoCard(
                  server: server,
                  onPressed: onPressed,
                ),
              )
              .toList()
              .addInBetween(const SizedBox(height: 4)),
        ],
        if (!kIsWeb) ...[
          const Divider(),
          Row(
            children: [
              Text(
                context.localized.discovered,
                style: context.textTheme.bodyLarge,
              ),
              const Spacer(),
              const Opacity(opacity: 0.65, child: Icon(IconsaxBold.airdrop, size: 16)),
            ],
          ),
          const SizedBox(height: 4),
          discoverdServersStream.when(
            data: (data) {
              final servers = data.where((discoverdServer) => !existingServers.contains(discoverdServer));
              return servers.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...servers.map(
                          (serverInfo) => _ServerInfoCard(
                            server: serverInfo,
                            onPressed: onPressed,
                          ),
                        )
                      ].toList().addInBetween(const SizedBox(height: 4)),
                    )
                  : Center(
                      child: Opacity(
                      opacity: 0.65,
                      child: Text(
                        context.localized.noServersFound,
                        style: context.textTheme.bodyLarge,
                      ),
                    ));
            },
            error: (error, stackTrace) => Text(context.localized.error),
            loading: () => const Center(
              child: SizedBox.square(
                dimension: 24.0,
                child: CircularProgressIndicator.adaptive(strokeCap: StrokeCap.round),
              ),
            ),
          ),
        ],
        const SizedBox(height: 32),
      ],
    );
  }
}

class _ServerInfoCard extends StatelessWidget {
  final Function(DiscoveryInfo server) onPressed;
  final DiscoveryInfo server;
  const _ServerInfoCard({
    required this.server,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => onPressed(server),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Card(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    IconsaxBold.driver,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      server.name,
                      style: context.textTheme.bodyLarge,
                    ),
                    Opacity(
                      opacity: 0.6,
                      child: Text(
                        server.address,
                        style: context.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(IconsaxOutline.edit_2, size: 16)
            ].addInBetween(const SizedBox(width: 12)),
          ),
        ),
      ),
    );
  }
}
