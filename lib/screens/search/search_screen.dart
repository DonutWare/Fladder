import 'package:fladder/providers/search_provider.dart';
import 'package:fladder/screens/shared/media/poster_grid.dart';
import 'package:fladder/util/debouncer.dart';
import 'package:fladder/util/string_extensions.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  final Debouncer searchDebouncer = Debouncer(const Duration(milliseconds: 500));

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(searchProvider.notifier).clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchResults = ref.watch(searchProvider);
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Stack(
            children: [
              Transform.translate(
                offset: const Offset(0, 4),
                child: Container(
                  height: 1,
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -4),
                child: AnimatedOpacity(
                  opacity: searchResults.loading ? 1 : 0,
                  duration: const Duration(milliseconds: 250),
                  child: Transform.translate(
                    offset: const Offset(0, 5),
                    child: const LinearProgressIndicator(),
                  ),
                ),
              ),
            ],
          ),
        ),
        title: TextField(
          controller: _controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: "Search library...",
            border: InputBorder.none,
          ),
          onSubmitted: (value) {
            ref.read(searchProvider.notifier).searchQuery();
          },
          onChanged: (query) {
            ref.read(searchProvider.notifier).setQuery(query);
            searchDebouncer.run(() {
              ref.read(searchProvider.notifier).searchQuery();
            });
          },
        ),
      ),
      body: ListView(
        children: searchResults.results.entries
            .map(
              (e) => PosterGrid(
                stickyHeader: false,
                name: e.key.name.capitalize(),
                posters: e.value,
              ),
            )
            .toList(),
      ),
    );
  }
}
