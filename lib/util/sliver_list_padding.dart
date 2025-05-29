import 'package:flutter/material.dart';

import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';

class DefautlSliverBottomPadding extends StatelessWidget {
  const DefautlSliverBottomPadding({super.key});

  @override
  Widget build(BuildContext context) {
    return (AdaptiveLayout.viewSizeOf(context) != ViewSize.phone)
        ? SliverPadding(padding: EdgeInsets.only(bottom: 35 + MediaQuery.of(context).padding.bottom))
        : SliverPadding(padding: EdgeInsets.only(bottom: 85 + MediaQuery.of(context).padding.bottom));
  }
}

class DefaultSliverTopBadding extends StatelessWidget {
  const DefaultSliverTopBadding({super.key});

  @override
  Widget build(BuildContext context) {
    return (AdaptiveLayout.viewSizeOf(context) == ViewSize.phone)
        ? const SliverToBoxAdapter()
        : SliverPadding(padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top));
  }
}
