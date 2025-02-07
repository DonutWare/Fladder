import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/media_playback_model.dart';
import 'package:fladder/models/settings/home_settings_model.dart';
import 'package:fladder/providers/video_player_provider.dart';
import 'package:fladder/util/adaptive_layout.dart';
import 'package:fladder/widgets/navigation_scaffold/components/floating_player_bar.dart';

class NestedScaffold extends ConsumerWidget {
  final Widget body;
  const NestedScaffold({required this.body, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerState = ref.watch(mediaPlaybackProvider.select((value) => value.state));

    return Card(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: switch (AdaptiveLayout.layoutOf(context)) {
          ViewSize.phone => null,
          _ => switch (playerState) {
              VideoPlayerState.minimized => const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: FloatingPlayerBar(),
                ),
              _ => null,
            },
        },
        body: body,
      ),
    );
  }
}
