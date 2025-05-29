import 'package:fladder/models/items/photos_model.dart';
import 'package:fladder/models/view_model.dart';
import 'package:fladder/providers/library_provider.dart';
import 'package:fladder/screens/photo_viewer/photo_viewer_screen.dart';
import 'package:fladder/screens/shared/flat_button.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:fladder/util/fladder_image.dart';
import 'package:fladder/util/sticky_header_text.dart';
import 'package:fladder/widgets/shared/pull_to_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sticky_headers/sticky_headers.dart';

class TimelineTab extends ConsumerStatefulWidget {
  final ViewModel viewModel;

  const TimelineTab({required this.viewModel, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TimelineTabState();
}

class _TimelineTabState extends ConsumerState<TimelineTab> with AutomaticKeepAliveClientMixin {
  final itemScrollController = ItemScrollController();
  double get posterCount {
    if (AdaptiveLayout.viewSizeOf(context) == ViewSize.desktop) {
      return 200;
    }
    return 125;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final timeLine = ref.watch(libraryProvider(widget.viewModel.id))?.timelinePhotos ?? [];
    final items = groupedItems(timeLine);

    return PullToRefresh(
      onRefresh: () async {
        await ref.read(libraryProvider(widget.viewModel.id).notifier).loadTimeline(widget.viewModel);
      },
      child: ScrollablePositionedList.builder(
        itemScrollController: itemScrollController,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items.entries.elementAt(index);
          return Padding(
            padding: const EdgeInsets.only(bottom: 64.0),
            child: StickyHeader(
              header: StickyHeaderText(
                  label: item.key.year != DateTime.now().year
                      ? DateFormat('E dd MMM. y').format(item.key)
                      : DateFormat('E dd MMM.').format(item.key)),
              content: StaggeredGrid.count(
                crossAxisCount: MediaQuery.of(context).size.width ~/ posterCount,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                axisDirection: AxisDirection.down,
                children: item.value
                    .map(
                      (e) => Hero(
                        tag: e.id,
                        child: AspectRatio(
                          aspectRatio: e.primaryRatio ?? 0.0,
                          child: Card(
                            margin: const EdgeInsets.all(4),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            clipBehavior: Clip.hardEdge,
                            child: Stack(
                              children: [
                                FladderImage(image: e.thumbnail?.primary),
                                FlatButton(
                                  onLongPress: () {},
                                  onTap: () async {
                                    final position = await Navigator.of(context, rootNavigator: true).push(
                                      PageTransition(
                                          child: PhotoViewerScreen(
                                            items: timeLine,
                                            indexOfSelected: timeLine.indexOf(e),
                                          ),
                                          type: PageTransitionType.fade),
                                    );
                                    getParentPosition(items, timeLine, position);
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          );
        },
      ),
    );
  }

  void getParentPosition(Map<DateTime, List<PhotoModel>> items, List<PhotoModel> timeLine, int position) {
    items.forEach(
      (key, value) {
        if (value.contains(timeLine[position])) {
          itemScrollController.scrollTo(
              index: items.keys.toList().indexOf(key), duration: const Duration(milliseconds: 250));
        }
      },
    );
  }

  Map<DateTime, List<PhotoModel>> groupedItems(List<PhotoModel> items) {
    Map<DateTime, List<PhotoModel>> groupedItems = {};
    for (int i = 0; i < items.length; i++) {
      DateTime curretDate = items[i].dateTaken ?? DateTime.now();
      DateTime key = DateTime(curretDate.year, curretDate.month, curretDate.day);
      if (!groupedItems.containsKey(key)) {
        groupedItems[key] = [items[i]];
      } else {
        groupedItems[key]?.add(items[i]);
      }
    }
    return groupedItems;
  }

  @override
  bool get wantKeepAlive => true;
}
