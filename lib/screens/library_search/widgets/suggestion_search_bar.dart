import 'package:flutter/material.dart';

import 'package:ficonsax/ficonsax.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:page_transition/page_transition.dart';

import 'package:fladder/models/item_base_model.dart';
import 'package:fladder/providers/library_search_provider.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/debouncer.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/localization_helper.dart';

class SuggestionSearchBar extends ConsumerStatefulWidget {
  final String? title;
  final bool autoFocus;
  final TextEditingController? textEditingController;
  final Duration debounceDuration;
  final SuggestionsController<ItemBaseModel>? suggestionsBoxController;
  final Function(String value)? onSubmited;
  final Function(String value)? onChanged;
  final Function(ItemBaseModel value)? onItem;
  const SuggestionSearchBar({
    this.title,
    this.autoFocus = false,
    this.textEditingController,
    this.debounceDuration = const Duration(milliseconds: 250),
    this.suggestionsBoxController,
    this.onSubmited,
    this.onChanged,
    this.onItem,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchBarState();
}

class _SearchBarState extends ConsumerState<SuggestionSearchBar> {
  late final Debouncer debouncer = Debouncer(widget.debounceDuration);
  late final SuggestionsController<ItemBaseModel> suggestionsBoxController =
      widget.suggestionsBoxController ?? SuggestionsController<ItemBaseModel>();
  late final TextEditingController textEditingController = widget.textEditingController ?? TextEditingController();
  bool isEmpty = true;
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.autoFocus) {
      focusNode.requestFocus();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(librarySearchProvider(widget.key!).select((value) => value.searchQuery), (previous, next) {
      if (textEditingController.text != next) {
        setState(() {
          textEditingController.text = next;
        });
      }
    });
    return Card(
      elevation: 2,
      shadowColor: Colors.transparent,
      child: TypeAheadField<ItemBaseModel>(
        focusNode: focusNode,
        hideOnEmpty: isEmpty,
        emptyBuilder: (context) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "${context.localized.noSuggestionsFound}...",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        suggestionsController: suggestionsBoxController,
        decorationBuilder: (context, child) => DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: FladderTheme.defaultShape.borderRadius,
          ),
          child: child,
        ),
        builder: (context, controller, focusNode) => TextField(
          focusNode: focusNode,
          controller: controller,
          onSubmitted: (value) {
            widget.onSubmited!(value);
            suggestionsBoxController.close();
          },
          onChanged: (value) {
            setState(() {
              isEmpty = value.isEmpty;
            });
          },
          decoration: InputDecoration(
            hintText: widget.title ?? "${context.localized.search}...",
            prefixIcon: const Icon(IconsaxOutline.search_normal),
            contentPadding: const EdgeInsets.only(top: 13),
            suffixIcon: controller.text.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      widget.onSubmited?.call('');
                      controller.text = '';
                      suggestionsBoxController.close();
                      setState(() {
                        isEmpty = true;
                      });
                    },
                    icon: const Icon(Icons.clear))
                : null,
            border: InputBorder.none,
          ),
        ),
        loadingBuilder: (context) => const SizedBox(
          height: 50,
          child: Center(child: CircularProgressIndicator(strokeCap: StrokeCap.round)),
        ),
        onSelected: (suggestion) {
          suggestionsBoxController.close();
        },
        itemBuilder: (context, suggestion) {
          return ListTile(
            onTap: () {
              if (widget.onItem != null) {
                widget.onItem?.call(suggestion);
              } else {
                Navigator.of(context)
                    .push(PageTransition(child: suggestion.detailScreenWidget, type: PageTransitionType.fade));
              }
            },
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            title: SizedBox(
              height: 50,
              child: Row(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    child: AspectRatio(
                      aspectRatio: 0.8,
                      child: FladderImage(
                        image: suggestion.images?.primary,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Flexible(
                            child: Text(
                          suggestion.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )),
                        if (suggestion.overview.yearAired.toString().isNotEmpty)
                          Flexible(
                              child:
                                  Opacity(opacity: 0.45, child: Text(suggestion.overview.yearAired?.toString() ?? ""))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        suggestionsCallback: (pattern) async {
          if (pattern.isEmpty) return [];
          if (widget.key != null) {
            return (await ref.read(librarySearchProvider(widget.key!).notifier).fetchSuggestions(pattern));
          }
          return [];
        },
      ),
    );
  }
}
