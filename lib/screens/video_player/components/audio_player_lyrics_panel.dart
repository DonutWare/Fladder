import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/models/items/audio_model.dart';
import 'package:fladder/providers/audio_lyrics_provider.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/localization_helper.dart';

class AudioPlayerLyricsPanel extends ConsumerStatefulWidget {
  const AudioPlayerLyricsPanel({
    required this.currentItem,
    required this.state,
    super.key,
  });

  final AudioModel currentItem;
  final AudioLyricsState state;

  @override
  ConsumerState<AudioPlayerLyricsPanel> createState() => _AudioPlayerLyricsPanelState();
}

class _AudioPlayerLyricsPanelState extends ConsumerState<AudioPlayerLyricsPanel> {
  static const _itemHeight = 68.0;

  final ScrollController _controller = ScrollController();
  bool _programmaticScroll = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToActive(animated: false);
    });
  }

  @override
  void didUpdateWidget(covariant AudioPlayerLyricsPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    final shouldSyncToActive = widget.state.autoFollow &&
        widget.state.activeLineIndex >= 0 &&
        widget.state.activeLineIndex != oldWidget.state.activeLineIndex;

    if (shouldSyncToActive) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToActive(animated: true);
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _scrollToActive({required bool animated}) async {
    if (!_controller.hasClients) {
      return;
    }

    final index = widget.state.activeLineIndex;
    if (index < 0 || index >= widget.state.lines.length) {
      return;
    }

    final centerOffset = (_controller.position.viewportDimension / 2) - (_itemHeight / 2);
    final target = (index * _itemHeight) - centerOffset;
    final clamped = target.clamp(0, _controller.position.maxScrollExtent).toDouble();

    _programmaticScroll = true;
    if (animated) {
      await _controller.animateTo(
        clamped,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
      );
    } else {
      _controller.jumpTo(clamped);
    }
    _programmaticScroll = false;
  }

  @override
  Widget build(BuildContext context) {
    return _buildExpanded(context);
  }

  Widget _buildExpanded(BuildContext context) {
    final lines = widget.state.lines;
    final activeIndex = widget.state.activeLineIndex;

    return Stack(
      children: [
        NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            final manualDrag = notification.direction != ScrollDirection.idle && !_programmaticScroll;
            if (manualDrag) {
              ref.read(audioLyricsProvider.notifier).detachSync();
            }
            return false;
          },
          child: ListView.builder(
            controller: _controller,
            padding: const EdgeInsets.fromLTRB(0, 6, 0, 84),
            itemCount: lines.length,
            itemBuilder: (context, index) {
              final line = lines[index];
              final isActive = index == activeIndex;
              final isPast = index < activeIndex;
              final isInstrumental = line.isInstrumentalGap;

              return SizedBox(
                height: _itemHeight,
                child: FocusButton(
                  onTap: () async {
                    ref.read(audioLyricsProvider.notifier).returnToSync();
                    await ref.read(audioLyricsProvider.notifier).seekToLine(line);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).colorScheme.primaryContainer.withAlpha(isActive ? 190 : 0),
                    ),
                    alignment: Alignment.centerLeft,
                    child: isInstrumental
                        ? Row(
                            spacing: 4,
                            children: List.generate(
                              4,
                              (index) => Icon(
                                Icons.music_note_rounded,
                                size: 20,
                                color: isActive
                                    ? Theme.of(context).colorScheme.onPrimaryContainer
                                    : Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          )
                        : Text(
                            line.text,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  fontWeight: isActive ? FontWeight.bold : FontWeight.w400,
                                  fontSize: 17,
                                  color: isActive
                                      ? Theme.of(context).colorScheme.onPrimaryContainer
                                      : Theme.of(context).colorScheme.onSurface.withAlpha(
                                            isPast
                                                ? 100
                                                : isActive
                                                    ? 255
                                                    : 175,
                                          ),
                                ),
                          ),
                  ),
                ),
              );
            },
          ),
        ),
        if (!widget.state.autoFollow && widget.state.activeLineIndex >= 0)
          Positioned(
            left: 0,
            right: 0,
            bottom: 18,
            child: Center(
              child: FilledButton.icon(
                onPressed: () async {
                  ref.read(audioLyricsProvider.notifier).returnToSync();
                  await _scrollToActive(animated: true);
                },
                icon: const Icon(IconsaxPlusLinear.arrow_up_3),
                label: Text(context.localized.returnToSyncedLyrics),
              ),
            ),
          ),
      ],
    );
  }
}

class AudioPlayerLyricsPreviewCard extends ConsumerWidget {
  const AudioPlayerLyricsPreviewCard({
    required this.state,
    required this.onTap,
    super.key,
  });

  final AudioLyricsState state;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeIndex = state.activeLineIndex;
    final lines = state.lines;
    final hasActiveLine = activeIndex >= 0 && activeIndex < lines.length;
    final currentLine = hasActiveLine ? lines[activeIndex] : null;

    int? nextLyricIndexFrom(int startIndex) {
      for (var i = startIndex; i < lines.length; i++) {
        if (!lines[i].isInstrumentalGap) {
          return i;
        }
      }
      return null;
    }

    final currentLyricIndex = hasActiveLine ? activeIndex : nextLyricIndexFrom(0);
    final currentLyricLine = currentLyricIndex != null ? lines[currentLyricIndex] : null;
    final upcomingLyricIndex = hasActiveLine
        ? nextLyricIndexFrom(activeIndex + 1)
        : currentLyricIndex != null
            ? nextLyricIndexFrom(currentLyricIndex + 1)
            : null;
    final upcomingLine = upcomingLyricIndex != null ? lines[upcomingLyricIndex] : null;

    Widget currentPreviewLine() {
      if (currentLine != null && currentLine.isInstrumentalGap) {
        final primary = Theme.of(context).colorScheme.primary;
        return Row(
          spacing: 4,
          children: List.generate(
            3,
            (index) => Icon(Icons.music_note_rounded, size: 18, color: primary),
          ),
        );
      }

      if (currentLyricLine != null) {
        return Text(
          currentLyricLine.text,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodyMedium,
        );
      }

      return Text(
        context.localized.noSyncedLyrics,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
      );
    }

    Widget? nextPreviewLine() {
      if (upcomingLine == null) {
        return null;
      }

      return Text(
        upcomingLine.text,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
      );
    }

    return Material(
      color: Colors.transparent,
      child: FocusButton(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          ref.read(audioLyricsProvider.notifier).returnToSync();
          onTap();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withAlpha(160),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant.withAlpha(120),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Row(
                spacing: 8,
                children: [
                  Expanded(child: currentPreviewLine()),
                  const Icon(Icons.expand_more_rounded),
                ],
              ),
              if (nextPreviewLine() case final preview?)
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: preview,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
