import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:fladder/widgets/shared/middle_mouse_autoscroll.dart';

void main() {
  late ScrollController vertical;
  late ScrollController horizontal;
  late int taps;

  Widget buildApp({TextDirection textDirection = TextDirection.ltr}) {
    return MaterialApp(
      scrollBehavior: const FladderScrollBehavior(),
      home: Directionality(
        textDirection: textDirection,
        child: SingleChildScrollView(
          controller: vertical,
          child: Column(
            children: [
              const SizedBox(height: 200),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  controller: horizontal,
                  scrollDirection: Axis.horizontal,
                  itemCount: 50,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => taps++,
                    child: SizedBox(width: 100, child: Text('$index')),
                  ),
                ),
              ),
              const SizedBox(height: 2000),
            ],
          ),
        ),
      ),
    );
  }

  setUp(() {
    vertical = ScrollController();
    horizontal = ScrollController();
    taps = 0;
  });

  tearDown(() {
    vertical.dispose();
    horizontal.dispose();
  });

  /// Presses the middle button at [origin], moves the pointer by [offset] and holds for [hold].
  Future<TestGesture> hold(WidgetTester tester, Offset origin, Offset offset,
      {Duration hold = const Duration(milliseconds: 500)}) async {
    final gesture = await tester.startGesture(origin, kind: PointerDeviceKind.mouse, buttons: kMiddleMouseButton);
    await gesture.moveBy(offset);
    for (var i = 0; i < 5; i++) {
      await tester.pump(hold ~/ 5);
    }
    return gesture;
  }

  Future<void> release(WidgetTester tester, TestGesture gesture) async {
    await gesture.up();
    await tester.pump();
  }

  testWidgets('holding the middle button scrolls the row and the page towards the pointer', (tester) async {
    await tester.pumpWidget(buildApp());

    final gesture = await hold(tester, const Offset(400, 250), const Offset(100, 60));

    expect(horizontal.offset, greaterThan(0));
    expect(vertical.offset, greaterThan(0));
    expect(taps, 0);

    await release(tester, gesture);
  });

  testWidgets('releasing the button stops the scroll', (tester) async {
    await tester.pumpWidget(buildApp());

    final gesture = await hold(tester, const Offset(400, 250), const Offset(100, 60));
    await release(tester, gesture);
    final horizontalAfter = horizontal.offset;
    final verticalAfter = vertical.offset;

    await tester.pump(const Duration(milliseconds: 500));

    expect(horizontal.offset, horizontalAfter);
    expect(vertical.offset, verticalAfter);
  });

  testWidgets('the further the pointer is from the origin, the faster it scrolls', (tester) async {
    await tester.pumpWidget(buildApp());

    final near = await hold(tester, const Offset(400, 250), const Offset(40, 0));
    final nearOffset = horizontal.offset;
    await release(tester, near);
    horizontal.jumpTo(0);
    await tester.pump();

    final far = await hold(tester, const Offset(400, 250), const Offset(140, 0));
    expect(horizontal.offset, greaterThan(nearOffset));
    await release(tester, far);
  });

  testWidgets('small movements inside the dead zone do not scroll', (tester) async {
    await tester.pumpWidget(buildApp());

    final gesture = await hold(tester, const Offset(400, 250), const Offset(5, 5));

    expect(horizontal.offset, 0);
    expect(vertical.offset, 0);

    await release(tester, gesture);
  });

  testWidgets('a stray middle click only flashes the marker', (tester) async {
    await tester.pumpWidget(buildApp());

    final gesture = await tester.startGesture(
      const Offset(400, 250),
      kind: PointerDeviceKind.mouse,
      buttons: kMiddleMouseButton,
    );
    await tester.pump();
    expect(find.byType(AutoscrollMarker), findsOneWidget);

    await release(tester, gesture);
    expect(find.byType(AutoscrollMarker), findsNothing);
    expect(horizontal.offset, 0);
    expect(vertical.offset, 0);
  });

  testWidgets('holding outside the row only scrolls the page', (tester) async {
    await tester.pumpWidget(buildApp());

    final gesture = await hold(tester, const Offset(400, 100), const Offset(100, 60));

    expect(horizontal.offset, 0);
    expect(vertical.offset, greaterThan(0));

    await release(tester, gesture);
  });

  testWidgets('scrolling clamps at the scroll extents', (tester) async {
    await tester.pumpWidget(buildApp());

    final gesture = await hold(tester, const Offset(400, 250), const Offset(-100, -60));

    expect(horizontal.offset, 0);
    expect(vertical.offset, 0);

    await release(tester, gesture);
  });

  testWidgets('right-to-left rows scroll towards the pointer too', (tester) async {
    await tester.pumpWidget(buildApp(textDirection: TextDirection.rtl));

    final gesture = await hold(tester, const Offset(400, 250), const Offset(-100, 0));

    expect(horizontal.offset, greaterThan(0));

    await release(tester, gesture);
  });

  testWidgets('primary mouse drag and click are left alone', (tester) async {
    await tester.pumpWidget(buildApp());

    final gesture = await tester.startGesture(
      const Offset(400, 250),
      kind: PointerDeviceKind.mouse,
      buttons: kPrimaryMouseButton,
    );
    await gesture.moveBy(const Offset(100, 60));
    await tester.pump(const Duration(milliseconds: 500));
    await gesture.up();
    await tester.pumpAndSettle();

    expect(horizontal.offset, 0);
    expect(vertical.offset, 0);
    expect(find.byType(AutoscrollMarker), findsNothing);

    await tester.tap(find.text('3'), kind: PointerDeviceKind.mouse);
    expect(taps, 1);
  });
}
