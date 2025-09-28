import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/error_log_model.dart';
import 'package:fladder/providers/crash_log_provider.dart';
import 'package:fladder/util/clipboard_helper.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/string_extensions.dart';
import 'package:fladder/widgets/shared/enum_selection.dart';
import 'package:fladder/widgets/shared/item_actions.dart';

final _selectedWarningProvider = StateProvider<ErrorType?>((ref) => null);

class CrashScreen extends ConsumerWidget {
  const CrashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(crashLogProvider.notifier);
    final selectedType = ref.watch(_selectedWarningProvider);
    final crashLogs =
        ref.watch(crashLogProvider).where((value) => selectedType == null ? true : value.type == selectedType);
    return Dialog.fullscreen(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              spacing: 8,
              children: [
                Text(
                  "Error logs",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: provider.clearLogs,
                  child: Text(context.localized.clear),
                ),
                EnumBox(
                  current: selectedType == null ? context.localized.all : selectedType.name.capitalize(),
                  itemBuilder: (context) => [
                    ItemActionButton(
                      label: Text(context.localized.all),
                      action: () => ref.read(_selectedWarningProvider.notifier).update((state) => null),
                    ),
                    ...ErrorType.values.map(
                      (entry) => ItemActionButton(
                        label: Text(entry.name.capitalize()),
                        action: () => ref.read(_selectedWarningProvider.notifier).update((state) => entry),
                      ),
                    )
                  ],
                ),
                const CloseButton(),
              ],
            ),
            const Divider(),
            if (crashLogs.isNotEmpty)
              Flexible(
                child: Card(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    shrinkWrap: true,
                    children: crashLogs
                        .map(
                          (e) => Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Card(
                                color: e.color.withValues(alpha: 0.1),
                                margin: const EdgeInsets.symmetric(vertical: 12),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Card(
                                              color: e.color.withValues(alpha: 0.2),
                                              child: Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                child: Text(
                                                  e.label,
                                                  style:
                                                      Theme.of(context).textTheme.titleLarge?.copyWith(color: e.color),
                                                ),
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () => context.copyToClipboard(e.clipBoard),
                                            icon: const Icon(Icons.copy_all_rounded),
                                          ),
                                        ],
                                      ),
                                      Text(e.content),
                                    ].addInBetween(const SizedBox(height: 16)),
                                  ),
                                ),
                              ),
                              const Divider(),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
              )
            else
              const Text("No crash-logs")
          ].addInBetween(const SizedBox(height: 12)),
        ),
      ),
    );
  }
}
