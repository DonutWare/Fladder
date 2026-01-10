import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class LiveTvScreen extends ConsumerWidget {
  final String viewId;
  const LiveTvScreen({
    @QueryParam() this.viewId = "",
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}
