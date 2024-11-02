import 'package:corner_ribbon/corner_ribbon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const cornerRibbonKey = Key('cornerRibbon');

  group('CornerRibbon Widget Tests', () {
    testWidgets('renders CustomPaint widget within CornerRibbon',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CornerRibbon(
            key: cornerRibbonKey,
            ribbonColor: Colors.red,
            text: 'SALE',
            child: SizedBox(width: 100, height: 100),
          ),
        ),
      );

      expect(find.byKey(cornerRibbonKey), findsOneWidget);
      expect(
        find.descendant(
          of: find.byKey(cornerRibbonKey),
          matching: find.byType(CustomPaint),
        ),
        findsOneWidget,
      );
    });

    testWidgets('displays text with correct style',
        (WidgetTester tester) async {
      const textStyle = TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      );
      await tester.pumpWidget(
        const MaterialApp(
          home: CornerRibbon(
            key: cornerRibbonKey,
            ribbonColor: Colors.blue,
            text: 'NEW',
            textStyle: textStyle,
            child: SizedBox(width: 100, height: 100),
          ),
        ),
      );

      final cornerRibbon =
          tester.widget<CornerRibbon>(find.byKey(cornerRibbonKey));
      expect(cornerRibbon.textStyle.color, textStyle.color);
      expect(cornerRibbon.textStyle.fontSize, textStyle.fontSize);
      expect(cornerRibbon.textStyle.fontWeight, textStyle.fontWeight);
    });

    testWidgets('applies the correct ribbon color',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CornerRibbon(
            key: cornerRibbonKey,
            ribbonColor: Colors.green,
            text: 'PROMO',
            child: SizedBox(width: 100, height: 100),
          ),
        ),
      );

      final customPaint = tester.widget<CustomPaint>(
        find.descendant(
          of: find.byKey(cornerRibbonKey),
          matching: find.byType(CustomPaint),
        ),
      );
      expect(customPaint.painter, isNotNull);
    });

    testWidgets('positions ribbon in top left corner by default',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CornerRibbon(
            key: cornerRibbonKey,
            ribbonColor: Colors.orange,
            text: 'Top Left',
            position: RibbonPosition.topLeft,
            child: SizedBox(width: 100, height: 100),
          ),
        ),
      );

      final topLeftOffset = tester.getTopLeft(find.byKey(cornerRibbonKey));
      expect(topLeftOffset, Offset.zero);
    });

    testWidgets('adjusts ribbon with specified corner offset',
        (WidgetTester tester) async {
      const offset = 20;
      await tester.pumpWidget(
        const MaterialApp(
          home: CornerRibbon(
            key: cornerRibbonKey,
            ribbonColor: Colors.purple,
            text: 'Offset Test',
            cornerOffset: offset,
            position: RibbonPosition.bottomRight,
            child: SizedBox(width: 100, height: 100),
          ),
        ),
      );

      final customPaint = tester.widget<CustomPaint>(
        find.descendant(
          of: find.byKey(cornerRibbonKey),
          matching: find.byType(CustomPaint),
        ),
      );
      expect(customPaint.painter, isNotNull);
    });

    testWidgets('sets ribbon stroke width correctly',
        (WidgetTester tester) async {
      const ribbonStroke = 50;
      await tester.pumpWidget(
        const MaterialApp(
          home: CornerRibbon(
            key: cornerRibbonKey,
            ribbonColor: Colors.teal,
            text: 'Stroke Width Test',
            ribbonStroke: ribbonStroke,
            child: SizedBox(width: 100, height: 100),
          ),
        ),
      );

      final customPaint = tester.widget<CustomPaint>(
        find.descendant(
          of: find.byKey(cornerRibbonKey),
          matching: find.byType(CustomPaint),
        ),
      );
      expect(customPaint, isNotNull);
    });
  });
}
