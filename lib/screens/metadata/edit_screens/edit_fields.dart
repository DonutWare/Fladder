import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:intl/intl.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/models/items/item_shared_models.dart';
import 'package:fladder/providers/edit_item_provider.dart';
import 'package:fladder/screens/settings/settings_list_tile.dart';
import 'package:fladder/screens/shared/focused_outlined_text_field.dart';
import 'package:fladder/screens/shared/media/external_urls.dart';
import 'package:fladder/screens/shared/outlined_text_field.dart';
import 'package:fladder/util/jelly_id.dart';
import 'package:fladder/util/list_extensions.dart';
import 'package:fladder/util/string_extensions.dart';
import 'package:fladder/widgets/shared/adaptive_date_picker.dart';
import 'package:fladder/widgets/shared/enum_selection.dart';
import 'package:fladder/widgets/shared/item_actions.dart';

class EditFields extends ConsumerStatefulWidget {
  final Map<String, dynamic> fields;
  final Map<String, dynamic>? json;
  const EditFields({
    required this.fields,
    required this.json,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditGeneralState();
}

class _EditGeneralState extends ConsumerState<EditFields> {
  TextEditingController? currentController = TextEditingController();
  String? currentEditingKey;
  List<String> expandedKeys = [];

  final personName = TextEditingController();
  PersonKind personType = PersonKind.actor;
  final personRole = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shrinkWrap: true,
            children: [
              if (widget.json != null)
                ...widget.fields.entries.map(
                  (e) {
                    final keyLabel = e.key.toUpperCaseSplit();
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: switch (e.value) {
                        Map<String, bool> _ => Builder(builder: (context) {
                            final map = e.value as Map<String, bool>;
                            return SettingsListTile(
                              label: Text(keyLabel),
                              trailing: EnumBox(
                                current: map.entries.firstWhereOrNull((element) => element.value == true)?.key ?? "",
                                itemBuilder: (context) => [
                                  ItemActionButton(
                                    label: const Text(""),
                                    action: () => ref.read(editItemProvider.notifier).updateField(MapEntry(e.key, "")),
                                  ),
                                  ...map.entries.map(
                                    (mapEntry) => ItemActionButton(
                                      label: Text(mapEntry.key),
                                      action: () => ref
                                          .read(editItemProvider.notifier)
                                          .updateField(MapEntry(e.key, mapEntry.key)),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                        List<String> _ => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 21),
                            child: Builder(builder: (context) {
                              final expanded = expandedKeys.contains(e.key);
                              final list = e.value as List<String>;
                              return Card(
                                child: InkWell(
                                  onTap: () => setState(() => expandedKeys = expandedKeys.toggle(e.key)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              keyLabel,
                                              style: Theme.of(context).textTheme.titleLarge,
                                            ),
                                            const Spacer(),
                                            IconButton(
                                              onPressed: () =>
                                                  setState(() => expandedKeys = expandedKeys.toggle(e.key)),
                                              icon: Icon(expanded
                                                  ? Icons.keyboard_arrow_up_rounded
                                                  : Icons.keyboard_arrow_down_rounded),
                                            )
                                          ],
                                        ),
                                        if (expanded) ...{
                                          const SizedBox(height: 6),
                                          ...list.map(
                                            (genre) => Row(
                                              children: [
                                                Text(genre.toString()),
                                                const Spacer(),
                                                IconButton(
                                                    onPressed: () => ref.read(editItemProvider.notifier).updateField(
                                                          MapEntry(e.key, list..remove(genre)),
                                                        ),
                                                    icon: const Icon(Icons.remove_rounded))
                                              ],
                                            ),
                                          ),
                                          OutlinedTextField(
                                            label: "Add",
                                            controller: TextEditingController(),
                                            onSubmitted: (value) {
                                              ref.read(editItemProvider.notifier).updateField(
                                                    MapEntry(e.key, list..add(value)),
                                                  );
                                            },
                                          )
                                        },
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        List<Person> _ => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 21),
                            child: Builder(builder: (context) {
                              final expanded = expandedKeys.contains(e.key);
                              final list = e.value as List<Person>;

                              List<Map<String, dynamic>> listToMap(List<Person> people) {
                                return people.map((e) => e.toPerson().toJson()).toList();
                              }

                              return Card(
                                child: InkWell(
                                  onTap: () => setState(() => expandedKeys = expandedKeys.toggle(e.key)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              keyLabel,
                                              style: Theme.of(context).textTheme.titleLarge,
                                            ),
                                            const Spacer(),
                                            IconButton(
                                              onPressed: () =>
                                                  setState(() => expandedKeys = expandedKeys.toggle(e.key)),
                                              icon: Icon(expanded
                                                  ? Icons.keyboard_arrow_up_rounded
                                                  : Icons.keyboard_arrow_down_rounded),
                                            )
                                          ],
                                        ),
                                        if (expanded) ...{
                                          const SizedBox(height: 6),
                                          ...list.map(
                                            (person) => Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 6),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    height: 50,
                                                    width: 50,
                                                    child: Card(
                                                      elevation: 2,
                                                      color: Theme.of(context).colorScheme.onPrimary,
                                                      child: Center(
                                                        child: Text(
                                                          person.name.getInitials(),
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .bodyMedium
                                                              ?.copyWith(fontWeight: FontWeight.bold),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 6),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(person.name),
                                                      Opacity(
                                                        opacity: 0.65,
                                                        child: Text(person.role.isNotEmpty
                                                            ? "${person.role} (${person.type}) "
                                                            : person.type?.value ?? ""),
                                                      ),
                                                    ],
                                                  ),
                                                  const Spacer(),
                                                  IconButton(
                                                      onPressed: () {
                                                        ref.read(editItemProvider.notifier).updateField(
                                                            MapEntry(e.key, listToMap(list..remove(person))));
                                                      },
                                                      icon: const Icon(Icons.remove_rounded))
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: OutlinedTextField(
                                                  label: "Name",
                                                  controller: personName,
                                                ),
                                              ),
                                              const SizedBox(width: 16),
                                              Flexible(
                                                child: EnumBox<PersonKind>(
                                                  current: personType.name.toUpperCaseSplit(),
                                                  itemBuilder: (context) => [
                                                    ...PersonKind.values
                                                        .whereNot(
                                                            (element) => element == PersonKind.swaggerGeneratedUnknown)
                                                        .map(
                                                          (entry) => ItemActionButton(
                                                            label: Text(entry.name.toUpperCaseSplit()),
                                                            action: () {
                                                              setState(() {
                                                                personType = entry;
                                                              });
                                                            },
                                                          ),
                                                        )
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 16),
                                              IconButton(
                                                onPressed: () {
                                                  ref.read(editItemProvider.notifier).updateField(MapEntry(
                                                      e.key,
                                                      listToMap(list
                                                        ..add(
                                                          Person(
                                                            id: jellyId,
                                                            name: personName.text,
                                                            type: personType,
                                                            role: personRole.text,
                                                          ),
                                                        ))));
                                                  setState(() {
                                                    personName.text = "";
                                                    personType = PersonKind.actor;
                                                    personRole.text = "";
                                                  });
                                                },
                                                icon: const Icon(Icons.add_rounded),
                                              )
                                            ],
                                          ),
                                        },
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        List<ExternalUrls> _ => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 21),
                            child: Builder(builder: (context) {
                              final expanded = expandedKeys.contains(e.key);
                              final list = e.value as List<ExternalUrls>;
                              final name = TextEditingController();
                              final url = TextEditingController();
                              return Card(
                                child: InkWell(
                                  onTap: () => setState(() => expandedKeys = expandedKeys.toggle(e.key)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              keyLabel,
                                              style: Theme.of(context).textTheme.titleLarge,
                                            ),
                                            const Spacer(),
                                            IconButton(
                                              onPressed: () =>
                                                  setState(() => expandedKeys = expandedKeys.toggle(e.key)),
                                              icon: Icon(expanded
                                                  ? Icons.keyboard_arrow_up_rounded
                                                  : Icons.keyboard_arrow_down_rounded),
                                            )
                                          ],
                                        ),
                                        if (expanded) ...{
                                          const SizedBox(height: 6),
                                          ...list.map(
                                            (externalUrl) => Row(
                                              children: [
                                                Text(externalUrl.name),
                                                const Spacer(),
                                                Tooltip(
                                                  message: "Open in browser",
                                                  child: IconButton(
                                                      onPressed: () => launchUrl(context, externalUrl.url),
                                                      icon: const Icon(Icons.open_in_browser_rounded)),
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                      ref.read(editItemProvider.notifier).updateField(
                                                            MapEntry(
                                                                e.key,
                                                                (list..remove(externalUrl))
                                                                    .map((e) => e.toMap())
                                                                    .toList()),
                                                          );
                                                    },
                                                    icon: const Icon(Icons.remove_rounded))
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Flexible(
                                                child: OutlinedTextField(
                                                  label: "Name",
                                                  controller: name,
                                                ),
                                              ),
                                              const SizedBox(width: 16),
                                              Flexible(
                                                child: OutlinedTextField(
                                                  label: "Url",
                                                  controller: url,
                                                ),
                                              ),
                                              const SizedBox(width: 16),
                                              IconButton(
                                                onPressed: () {
                                                  ref.read(editItemProvider.notifier).updateField(
                                                        MapEntry(
                                                            e.key,
                                                            (list
                                                                  ..add(
                                                                    ExternalUrls(name: name.text, url: url.text),
                                                                  ))
                                                                .map((e) => e.toMap())
                                                                .toList()),
                                                      );
                                                },
                                                icon: const Icon(Icons.add_rounded),
                                              )
                                            ],
                                          ),
                                        },
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        List<Studio> _ => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 21),
                            child: Builder(builder: (context) {
                              final expanded = expandedKeys.contains(e.key);

                              final list = e.value as List<Studio>;

                              void setMapping(List<Studio> newList) {
                                ref.read(editItemProvider.notifier).updateField(
                                      MapEntry(e.key, newList.map((e) => e.toMap()).toList()),
                                    );
                              }

                              return Card(
                                child: InkWell(
                                  onTap: () => setState(() => expandedKeys = expandedKeys.toggle(e.key)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              keyLabel,
                                              style: Theme.of(context).textTheme.titleLarge,
                                            ),
                                            const Spacer(),
                                            IconButton(
                                              onPressed: () =>
                                                  setState(() => expandedKeys = expandedKeys.toggle(e.key)),
                                              icon: Icon(expanded
                                                  ? Icons.keyboard_arrow_up_rounded
                                                  : Icons.keyboard_arrow_down_rounded),
                                            )
                                          ],
                                        ),
                                        if (expanded) ...[
                                          const SizedBox(height: 6),
                                          ...list.map(
                                            (studio) => Row(
                                              children: [
                                                Text(studio.name),
                                                const Spacer(),
                                                IconButton(
                                                    onPressed: () => setMapping(list..remove(studio)),
                                                    icon: const Icon(Icons.remove_rounded))
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          OutlinedTextField(
                                            label: "Add",
                                            controller: TextEditingController(),
                                            onSubmitted: (value) =>
                                                setMapping(list..add(Studio(id: jellyId, name: value))),
                                          )
                                        ]
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        int value => Builder(builder: (context) {
                            final controller = currentEditingKey == e.key
                                ? currentController
                                : TextEditingController(text: value.toString());
                            return FocusedOutlinedTextField(
                              label: switch (e.key) {
                                "IndexNumber" => "Episode Number",
                                "ParentIndexNumber" => "Season Number",
                                _ => keyLabel,
                              },
                              controller: controller,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              onFocus: (focused) {
                                if (focused) {
                                  currentController = controller;
                                  currentEditingKey = e.key;
                                } else {
                                  currentController = null;
                                  currentEditingKey = null;
                                }
                              },
                              onSubmitted: (value) {
                                final newYear = int.tryParse(value);
                                if (newYear != null) {
                                  ref.read(editItemProvider.notifier).updateField(
                                        MapEntry(e.key, newYear),
                                      );
                                }
                              },
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                if (currentEditingKey != e.key) {
                                  currentEditingKey = e.key;
                                  currentController = controller;
                                }
                                final newYear = int.tryParse(value);
                                if (newYear != null) {
                                  ref.read(editItemProvider.notifier).updateField(
                                        MapEntry(e.key, newYear),
                                      );
                                }
                              },
                            );
                          }),
                        double value => Builder(builder: (context) {
                            final controller = currentEditingKey == e.key
                                ? currentController
                                : TextEditingController(text: value.toString());
                            return FocusedOutlinedTextField(
                              label: keyLabel,
                              controller: controller,
                              onFocus: (focused) {
                                if (focused) {
                                  currentController = controller;
                                  currentEditingKey = e.key;
                                } else {
                                  currentController = null;
                                  currentEditingKey = null;
                                }
                              },
                              onSubmitted: (newValue) {
                                final newRating = double.tryParse(newValue);
                                if (newRating != null) {
                                  ref.read(editItemProvider.notifier).updateField(
                                        MapEntry(e.key, newRating),
                                      );
                                } else {
                                  controller?.text = value.toString();
                                }
                                currentController = null;
                              },
                              keyboardType: TextInputType.number,
                            );
                          }),
                        DateTime _ => Row(
                            children: [
                              Flexible(
                                child: FocusedOutlinedTextField(
                                  label: keyLabel,
                                  onTap: () async {
                                    FocusScope.of(context).requestFocus(FocusNode());
                                    final newDate = await showAdaptiveDatePicker(
                                      context,
                                      initialDateTime: e.value,
                                    );
                                    if (newDate == null) return;
                                    ref
                                        .read(editItemProvider.notifier)
                                        .updateField(MapEntry(e.key, newDate.toIso8601String()));
                                  },
                                  controller:
                                      TextEditingController(text: DateFormat.yMMMEd().format((e.value as DateTime))),
                                ),
                              ),
                              const SizedBox(width: 12),
                              IconButton(
                                  onPressed: () async {
                                    final newDate = await showDatePicker(
                                      context: context,
                                      currentDate: DateTime.now(),
                                      initialDate: e.value,
                                      firstDate: DateTime(1950),
                                      lastDate: DateTime(2100),
                                    );
                                    if (newDate == null) return;
                                    ref
                                        .read(editItemProvider.notifier)
                                        .updateField(MapEntry(e.key, newDate.toIso8601String()));
                                  },
                                  icon: const Icon(IconsaxPlusLinear.calendar_2))
                            ],
                          ),
                        DisplayOrder _ => Builder(builder: (context) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SettingsListTile(
                                  label: Text(keyLabel),
                                  trailing: EnumBox(
                                    current: (e.value as DisplayOrder).value.toUpperCaseSplit(),
                                    itemBuilder: (context) => DisplayOrder.values
                                        .map(
                                          (mapEntry) => ItemActionButton(
                                            label: Text(mapEntry.value.toUpperCaseSplit()),
                                            action: () => ref
                                                .read(editItemProvider.notifier)
                                                .updateField(MapEntry(e.key, mapEntry.value)),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: Text("Order episodes by air date, DVD order, or absolute numbering."),
                                )
                              ],
                            );
                          }),
                        ShowStatus _ => Builder(builder: (context) {
                            return SettingsListTile(
                              label: Text(keyLabel),
                              trailing: EnumBox(
                                current: (e.value as ShowStatus).value,
                                itemBuilder: (context) => ShowStatus.values
                                    .map(
                                      (mapEntry) => ItemActionButton(
                                        label: Text(mapEntry.value),
                                        action: () => ref
                                            .read(editItemProvider.notifier)
                                            .updateField(MapEntry(e.key, mapEntry.value)),
                                      ),
                                    )
                                    .toList(),
                              ),
                            );
                          }),
                        bool _ => SettingsListTile(
                            label: Text(keyLabel),
                            trailing: Switch.adaptive(
                              value: e.value as bool,
                              onChanged: (value) =>
                                  ref.read(editItemProvider.notifier).updateField(MapEntry(e.key, value)),
                            ),
                          ),
                        Duration _ => Builder(builder: (context) {
                            final valueInMinutes = (e.value as Duration).inMinutes.toString();
                            final controller = currentEditingKey == e.key
                                ? currentController
                                : TextEditingController(text: valueInMinutes);
                            return FocusedOutlinedTextField(
                              label: keyLabel,
                              controller: controller,
                              onFocus: (focused) {
                                if (focused) {
                                  currentController = controller;
                                  currentEditingKey = e.key;
                                } else {
                                  currentController = null;
                                  currentEditingKey = null;
                                }
                              },
                              keyboardType: TextInputType.number,
                              onSubmitted: (value) {
                                final newMinutes = int.tryParse(value);
                                if (newMinutes != null) {
                                  ref.read(editItemProvider.notifier).updateField(
                                        MapEntry(e.key, Duration(minutes: newMinutes).inMilliseconds * 10000),
                                      );
                                } else {
                                  controller?.text = valueInMinutes;
                                }
                              },
                            );
                          }),
                        Map<EditorLockedFields, bool> _ => Builder(builder: (context) {
                            final map = e.value as Map<EditorLockedFields, bool>;
                            return Card(
                              child: InkWell(
                                onTap: () => setState(() => expandedKeys = expandedKeys.toggle(e.key)),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(keyLabel, style: Theme.of(context).textTheme.titleLarge),
                                      const SizedBox(height: 6),
                                      const Text(
                                        "Uncheck a field to lock it and prevent its data from being changed.",
                                      ),
                                      const SizedBox(height: 6),
                                      Column(
                                        children: map.entries
                                            .map((values) => Row(
                                                  children: [
                                                    Text(values.key.value),
                                                    const Spacer(),
                                                    Switch.adaptive(
                                                      value: !values.value,
                                                      onChanged: (value) {
                                                        final newEntries = map;
                                                        newEntries.update(values.key, (value) => !value);
                                                        final newValues = newEntries.entries
                                                            .where((element) => element.value == true)
                                                            .map((e) => e.key.value);
                                                        ref
                                                            .read(editItemProvider.notifier)
                                                            .updateField(MapEntry(e.key, newValues.toList()));
                                                      },
                                                    )
                                                  ],
                                                ))
                                            .toList(),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        String value => Builder(builder: (context) {
                            final controller =
                                currentEditingKey == e.key ? currentController : TextEditingController(text: value);
                            return FocusedOutlinedTextField(
                              label: keyLabel,
                              maxLines: e.key == "Overview" ? 5 : 1,
                              controller: controller,
                              onFocus: (focused) {
                                if (focused) {
                                  currentEditingKey = e.key;
                                  currentController = controller;
                                } else {
                                  currentController = null;
                                  currentEditingKey = null;
                                }
                              },
                              onSubmitted: (value) =>
                                  ref.read(editItemProvider.notifier).updateField(MapEntry(e.key, value)),
                              onChanged: (value) {
                                if (currentEditingKey != e.key) {
                                  currentEditingKey = e.key;
                                  currentController = controller;
                                }
                                return ref.read(editItemProvider.notifier).updateField(MapEntry(e.key, value));
                              },
                            );
                          }),
                        _ => Text("Not supported ${e.value.runtimeType}: ${e.value}"),
                      },
                    );
                  },
                )
              else
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: CircularProgressIndicator.adaptive(strokeCap: StrokeCap.round),
                  ),
                ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }
}
