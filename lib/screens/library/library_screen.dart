import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.enums.swagger.dart';
import 'package:fladder/providers/views_provider.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/screens/shared/flat_button.dart';
import 'package:fladder/screens/shared/nested_scaffold.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/widgets/shared/pull_to_refresh.dart';

@RoutePage()
class LibraryScreen extends ConsumerStatefulWidget {
  const LibraryScreen({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends ConsumerState<LibraryScreen> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final viewsState = ref.read(viewsProvider);
    final views = viewsState.views.whereNot((e) => e.collectionType == CollectionType.folders).toList();
    final spacing = 16.0;

    return NestedScaffold(
      body: PullToRefresh(
        refreshOnStart: true,
        onRefresh: () => ref.read(viewsProvider.notifier).fetchViews(),
        child: SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: (MediaQuery.sizeOf(context).width ~/ 350).clamp(1, 5),
                  mainAxisSpacing: spacing / 2,
                  crossAxisSpacing: spacing,
                  childAspectRatio: 1.5,
                ),
                itemCount: views.length,
                itemBuilder: (context, index) {
                  final view = views[index];
                  return Card(
                    elevation: 5,
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: FlatButton(
                      onTap: () => context.router.push(LibrarySearchRoute(viewModelId: view.id)),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Column(
                          spacing: 8,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Flexible(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: FladderImage(
                                  image: view.imageData?.primary,
                                  fit: BoxFit.fitHeight,
                                  blurFit: BoxFit.cover,
                                  placeHolder: Center(
                                    child: Text(
                                      view.name,
                                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (view.imageData?.primary != null)
                                  Text(view.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const SizedBox(height: 0),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
