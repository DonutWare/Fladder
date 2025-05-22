import 'package:animations/animations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/routes/auto_router.gr.dart';
import 'package:fladder/screens/search/search_screen.dart';
import 'package:fladder/util/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FloatingSearchBar extends ConsumerStatefulWidget {
  final List<Widget> trailing;
  final String hintText;
  final bool showLoading;
  final bool showUserIcon;
  final bool automaticallyImplyLeading;
  final double height;
  const FloatingSearchBar({
    this.trailing = const [],
    this.showLoading = false,
    this.showUserIcon = true,
    this.height = 50,
    required this.hintText,
    this.automaticallyImplyLeading = true,
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FloatingSearchBarState();
}

class _FloatingSearchBarState extends ConsumerState<FloatingSearchBar> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return Hero(
      tag: "FloatingSearchBarHome",
      child: SizedBox(
        height: widget.height,
        width: double.infinity,
        child: OpenContainer(
          openBuilder: (context, action) {
            return const SearchScreen();
          },
          openColor: Colors.transparent,
          openElevation: 0,
          closedColor: Colors.transparent,
          closedElevation: 0,
          closedBuilder: (context, openAction) => Card(
            clipBehavior: Clip.hardEdge,
            shadowColor: Colors.transparent,
            elevation: 5,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(500)),
            child: InkWell(
              onTap: () => openAction(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (context.router.canPop())
                    IconButton(
                      onPressed: () => context.router.maybePop(),
                      icon: const Icon(Icons.arrow_back),
                    ),
                  const SizedBox(width: 8),
                  Expanded(
                      child: Text(
                    widget.hintText,
                    style: Theme.of(context).textTheme.bodyLarge,
                  )),
                  IconButton(
                    onPressed: () => openAction(),
                    icon: const Icon(
                      Icons.search_rounded,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      context.router.push(const SecuritySettingsRoute());
                    },
                    icon: ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: CachedNetworkImage(
                        imageUrl: user?.avatar ?? "",
                        memCacheHeight: 125,
                        imageBuilder: (context, imageProvider) => Image(image: imageProvider),
                        errorWidget: (context, url, error) => CircleAvatar(
                          child: Text(user?.name.getInitials() ?? ""),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
