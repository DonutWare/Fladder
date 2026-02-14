import 'package:flutter/material.dart';

import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/providers/control_panel/control_tuner_edit_provider.dart';
import 'package:fladder/screens/shared/outlined_text_field.dart';
import 'package:fladder/util/focus_provider.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/enum_selection.dart';
import 'package:fladder/widgets/shared/item_actions.dart';

class ListingProviderEditDialog extends StatefulWidget {
  final ListingsProviderInfo? provider;
  final List<TunerHostInfo>? availableTuners;

  const ListingProviderEditDialog({super.key, this.provider, this.availableTuners});

  @override
  State<ListingProviderEditDialog> createState() => _ListingProviderEditDialogState();
}

class _ListingProviderEditDialogState extends State<ListingProviderEditDialog> {
  late TextEditingController _pathController;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  late TextEditingController _userAgentController;
  late TextEditingController _moviePrefixController;
  late TextEditingController _movieCategoryController;
  late TextEditingController _newsCategoryController;
  late TextEditingController _sportsCategoryController;
  late TextEditingController _kidsCategoryController;

  late List<String> _movieCategories;
  late List<String> _newsCategories;
  late List<String> _sportsCategories;
  late List<String> _kidsCategories;

  bool _enableAllTuners = true;
  late List<String> _enabledTuners;

  EPGProviderType _selectedType = EPGProviderType.xmltv;

  @override
  void initState() {
    super.initState();
    _pathController = TextEditingController(text: widget.provider?.path ?? '');
    _usernameController = TextEditingController(text: widget.provider?.username ?? '');
    _passwordController = TextEditingController(text: widget.provider?.password ?? '');

    _userAgentController = TextEditingController(text: widget.provider?.userAgent ?? '');
    _moviePrefixController = TextEditingController(text: widget.provider?.moviePrefix ?? '');
    _movieCategoryController = TextEditingController();
    _newsCategoryController = TextEditingController();
    _sportsCategoryController = TextEditingController();
    _kidsCategoryController = TextEditingController();

    _movieCategories = List.from(widget.provider?.movieCategories ?? ["movies"]);
    _newsCategories =
        List.from(widget.provider?.newsCategories ?? ["news", "journalism", "documentary", "current affairs"]);
    _sportsCategories =
        List.from(widget.provider?.sportsCategories ?? ["sports", "basketball", "baseball", "football"]);
    _kidsCategories =
        List.from(widget.provider?.kidsCategories ?? ["kids", "family", "children", "childrens", "disney"]);

    _enableAllTuners = widget.provider?.enableAllTuners ?? true;
    _enabledTuners = List.from(widget.provider?.enabledTuners ?? []);

    _selectedType = EPGProviderType.fromString(widget.provider?.type);
  }

  @override
  void dispose() {
    _pathController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();

    _userAgentController.dispose();
    _moviePrefixController.dispose();
    _movieCategoryController.dispose();
    _newsCategoryController.dispose();
    _sportsCategoryController.dispose();
    _kidsCategoryController.dispose();

    super.dispose();
  }

  void _addTag(List<String> list, TextEditingController controller) {
    final text = controller.text.trim();
    if (text.isEmpty) return;
    if (!list.contains(text)) setState(() => list.add(text));
    controller.clear();
  }

  void _removeTag(List<String> list, String value) {
    setState(() => list.remove(value));
  }

  @override
  Widget build(BuildContext context) {
    final availableTuners = widget.availableTuners ?? [];

    return AlertDialog(
      title: Text(widget.provider == null ? context.localized.addEpgProvider : context.localized.editEpgProvider),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 8,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    context.localized.type(1),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                EnumBox(
                  current: _selectedType.value,
                  itemBuilder: (context) => widget.provider != null
                      ? []
                      : EPGProviderType.values
                          .map(
                            (type) => ItemActionButton(
                              label: Text(type.value),
                              action: () => setState(() => _selectedType = type),
                            ),
                          )
                          .toList(),
                ),
              ],
            ),
            if (_selectedType != EPGProviderType.schedulesDirect)
              OutlinedTextField(
                controller: _pathController,
                label: context.localized.xmltvPathUrl,
              ),
            if (_selectedType != EPGProviderType.xmltv) ...[
              OutlinedTextField(
                controller: _usernameController,
                label: context.localized.username,
              ),
              OutlinedTextField(
                controller: _passwordController,
                label: context.localized.password,
                keyboardType: TextInputType.visiblePassword,
              ),
            ],
            if (_selectedType == EPGProviderType.xmltv) ...[
              OutlinedTextField(
                controller: _userAgentController,
                label: context.localized.userAgentOptional,
              ),
              OutlinedTextField(
                controller: _moviePrefixController,
                label: context.localized.moviePrefix,
                subLabel: context.localized.moviePrefixSubLabel,
              ),
              const Divider(),
              _TagInput(
                label: context.localized.movieCategories,
                subLabel: context.localized.movieCategoriesSubLabel,
                items: _movieCategories,
                controller: _movieCategoryController,
                onAdd: () => _addTag(_movieCategories, _movieCategoryController),
                onRemove: (tag) => _removeTag(_movieCategories, tag),
              ),
              _TagInput(
                label: context.localized.newsCategories,
                subLabel: context.localized.newsCategoriesSubLabel,
                items: _newsCategories,
                controller: _newsCategoryController,
                onAdd: () => _addTag(_newsCategories, _newsCategoryController),
                onRemove: (tag) => _removeTag(_newsCategories, tag),
              ),
              _TagInput(
                label: context.localized.sportsCategories,
                subLabel: context.localized.sportsCategoriesSubLabel,
                items: _sportsCategories,
                controller: _sportsCategoryController,
                onAdd: () => _addTag(_sportsCategories, _sportsCategoryController),
                onRemove: (tag) => _removeTag(_sportsCategories, tag),
              ),
              _TagInput(
                label: context.localized.kidsCategories,
                subLabel: context.localized.kidsCategoriesSubLabel,
                items: _kidsCategories,
                controller: _kidsCategoryController,
                onAdd: () => _addTag(_kidsCategories, _kidsCategoryController),
                onRemove: (tag) => _removeTag(_kidsCategories, tag),
              ),
              SwitchListTile(
                value: _enableAllTuners,
                onChanged: (enable) => setState(() => _enableAllTuners = enable),
                title: Text(context.localized.enableAllTuners),
              ),
              if (!_enableAllTuners) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(context.localized.enabledTuners, style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 8),
                    ...availableTuners.map((tuner) {
                      final id = tuner.id ?? tuner.url ?? tuner.friendlyName ?? '';
                      final enabled = _enabledTuners.contains(id);
                      return SwitchListTile(
                        value: enabled,
                        onChanged: (value) {
                          setState(() {
                            if (value) {
                              if (!_enabledTuners.contains(id)) _enabledTuners.add(id);
                            } else {
                              _enabledTuners.remove(id);
                            }
                          });
                        },
                        title: Text(tuner.friendlyName ?? tuner.url ?? id),
                        subtitle: tuner.url != null ? Text(tuner.url!) : null,
                      );
                    }),
                    Wrap(
                      spacing: 8,
                      children: _enabledTuners
                          .where((id) => !availableTuners.any((t) => (t.id ?? t.url ?? t.friendlyName) == id))
                          .map((id) => InputChip(label: Text(id)))
                          .toList(),
                    ),
                  ],
                ),
              ],
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.localized.cancel),
        ),
        TextButton(
          onPressed: () {
            final provider = ListingsProviderInfo(
              id: widget.provider?.id,
              type: _selectedType.value,
              path: _pathController.text.isEmpty ? null : _pathController.text,
              username: _usernameController.text.isEmpty ? null : _usernameController.text,
              password: _passwordController.text.isEmpty ? null : _passwordController.text,
              userAgent: _userAgentController.text.isEmpty ? null : _userAgentController.text,
              moviePrefix: _moviePrefixController.text.isEmpty ? null : _moviePrefixController.text,
              movieCategories: _movieCategories.isEmpty ? null : _movieCategories,
              newsCategories: _newsCategories.isEmpty ? null : _newsCategories,
              sportsCategories: _sportsCategories.isEmpty ? null : _sportsCategories,
              kidsCategories: _kidsCategories.isEmpty ? null : _kidsCategories,
              enableAllTuners: _enableAllTuners,
              enabledTuners: _enabledTuners.isEmpty ? null : _enabledTuners,
            );
            Navigator.of(context).pop(provider);
          },
          child: Text(context.localized.save),
        ),
      ],
    );
  }
}

class _TagInput extends StatelessWidget {
  final String label;
  final String subLabel;
  final List<String> items;
  final TextEditingController controller;
  final VoidCallback onAdd;
  final void Function(String) onRemove;

  const _TagInput({
    Key? key,
    required this.label,
    required this.subLabel,
    required this.items,
    required this.controller,
    required this.onAdd,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        OutlinedTextField(
          controller: controller,
          label: label,
          subLabel: subLabel,
          onSubmitted: (_) => onAdd(),
        ),
        if (items.isEmpty)
          Text(
            context.localized.noCategories,
            style: Theme.of(context).textTheme.bodyMedium,
          )
        else
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: items
                .map(
                  (t) => FocusButton(
                    borderRadius: BorderRadius.circular(32),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer.withAlpha(175),
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 8,
                          children: [
                            Text(t),
                            const Icon(
                              IconsaxPlusLinear.close_square,
                              size: 18,
                            )
                          ],
                        ),
                      ),
                    ),
                    onTap: () => onRemove(t),
                  ),
                )
                .toList(),
          ),
        const Divider(),
      ],
    );
  }
}
