import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:fladder/widgets/shared/deferred_build.dart';

void main() {
  const itemCount = 300;
  const itemHeight = 100.0;
  late ScrollController controller;
  late Set<int> built;

  Widget item(int index) {
    return DeferredBuild(
      placeholderHeight: itemHeight,
      builder: (context) {
        built.add(index);
        return SizedBox(height: itemHeight, child: Text('item $index'));
      },
    );
  }

  Widget page(Widget child) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(controller: controller, child: child),
      ),
    );
  }

  setUp(() {
    controller = ScrollController();
    built = {};
  });

  tearDown(() => controller.dispose());

  testWidgets('only items near the viewport are built', (tester) async {
    await tester.pumpWidget(page(Column(children: List.generate(itemCount, item))));
    await tester.pump();

    // The test viewport is 600 tall and the look-ahead is 1.5 viewports, so about 15 items.
    expect(built, contains(0));
    expect(built, contains(5));
    expect(built.length, lessThan(30));
    expect(built, isNot(contains(100)));
    expect(find.text('item 0'), findsOneWidget);
    expect(find.text('item 100'), findsNothing);
  });

  testWidgets('placeholders keep the list at its full height', (tester) async {
    await tester.pumpWidget(page(Column(children: List.generate(itemCount, item))));
    await tester.pump();

    expect(controller.position.maxScrollExtent, itemCount * itemHeight - 600);
  });

  testWidgets('scrolling builds the items that come into reach and keeps the earlier ones', (tester) async {
    await tester.pumpWidget(page(Column(children: List.generate(itemCount, item))));
    await tester.pump();

    controller.jumpTo(100 * itemHeight);
    await tester.pump();

    expect(built, contains(100));
    expect(built, contains(105));
    expect(built, contains(0));
    expect(built, isNot(contains(200)));
    expect(find.text('item 100'), findsOneWidget);
  });

  testWidgets('a non-scrolling list inside the page is measured against the page', (tester) async {
    await tester.pumpWidget(page(
      Column(
        children: [
          const SizedBox(height: 300),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: itemCount,
            itemBuilder: (context, index) => item(index),
          ),
        ],
      ),
    ));
    await tester.pump();

    expect(built, contains(0));
    expect(built.length, lessThan(30));
    expect(built, isNot(contains(100)));

    controller.jumpTo(300 + 100 * itemHeight);
    await tester.pump();

    expect(built, contains(100));
    expect(built, isNot(contains(200)));
  });
}
