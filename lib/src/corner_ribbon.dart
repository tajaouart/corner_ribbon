import 'dart:math';

import 'package:flutter/material.dart';

import '../corner_ribbon.dart';

/// A widget that displays a customizable corner ribbon with text.
///
/// The `CornerRibbon` widget can be positioned at any corner of its parent
/// with customizable colors, text styles, and offsets. The widget also allows
/// for a `child` widget over which the ribbon is displayed.
class CornerRibbon extends StatelessWidget {
  /// The position of the ribbon relative to the corner or side of the parent widget.
  ///
  /// Options are provided by the `RibbonPosition` enum, which includes:
  /// - `RibbonPosition.topLeft`: Top-left corner.
  /// - `RibbonPosition.topRight`: Top-right corner.
  /// - `RibbonPosition.bottomLeft`: Bottom-left corner.
  /// - `RibbonPosition.bottomRight`: Bottom-right corner.
  /// - Additional horizontal and vertical options like `horizontalTop`, `verticalCenter`, etc.
  ///
  /// Defaults to `RibbonPosition.topLeft`.
  final RibbonPosition position;

  /// The style of the text displayed on the ribbon.
  ///
  /// Customize the font size, color, weight, etc., using the `TextStyle` class.
  /// Defaults to a bold, black font with size 16.
  final TextStyle textStyle;

  /// The color of the ribbon.
  ///
  /// This sets the background color of the ribbon. Defaults to `Colors.blue`.
  final Color ribbonColor;

  /// The offset distance of the ribbon from the corner.
  ///
  /// The ribbon will start this distance away from the specified corner, allowing
  /// for a "detached" look. If set to 0, the ribbon will touch the corner directly.
  /// Defaults to 0.
  final int cornerOffset;

  /// The stroke width (thickness) of the ribbon.
  ///
  /// This determines the width of the ribbon shape extending from the corner.
  /// Increasing the value makes the ribbon appear thicker.
  /// Defaults to 200.
  final int ribbonStroke;

  /// The main content widget over which the ribbon will be displayed.
  ///
  /// This widget is positioned below the ribbon in the `Stack` layout, allowing the ribbon
  /// to overlay any provided child widget.
  final Widget child;

  /// The text displayed on the ribbon.
  ///
  /// Text that appears on the ribbon, usually used for labels or messages like "SALE", "NEW",
  /// or any other relevant text.
  final String text;

  /// Creates a customizable corner ribbon widget.
  ///
  /// Example usage:
  /// ```dart
  /// CornerRibbon(
  ///   ribbonColor: Colors.red,
  ///   text: "SALE",
  ///   child: Container(color: Colors.white),
  ///   position: RibbonPosition.bottomRight,
  ///   ribbonStroke: 150,
  ///   cornerOffset: 10,
  ///   textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  /// )
  /// ```
  const CornerRibbon({
    required this.ribbonColor,
    required this.child,
    required this.text,
    this.position = RibbonPosition.topLeft,
    this.cornerOffset = 100,
    this.ribbonStroke = 75,
    this.textStyle = const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        CustomPaint(
          painter: _RibbonPainter(
            ribbonStroke: ribbonStroke,
            cornerOffset: cornerOffset,
            ribbonColor: ribbonColor,
            textStyle: textStyle,
            position: position,
            text: text,
          ),
          child: Container(), // This ensures the CustomPaint fills the area
        ),
      ],
    );
  }
}

class _RibbonPainter extends CustomPainter {
  final RibbonPosition position;
  final TextStyle textStyle;
  final Color ribbonColor;
  final int cornerOffset;
  final int ribbonStroke;
  final String text;

  _RibbonPainter({
    required this.ribbonStroke,
    required this.cornerOffset,
    required this.ribbonColor,
    required this.textStyle,
    required this.position,
    required this.text,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final offset = cornerOffset.toDouble();
    final ribbonWidth = ribbonStroke.toDouble();
    final paint = Paint()
      ..color = ribbonColor
      ..style = PaintingStyle.fill;

    final path = Path();

    // Define the path based on the ribbon position.
    switch (position) {
      case RibbonPosition.topLeft:
        path.moveTo(0, offset);
        path.lineTo(offset, 0);
        path.lineTo(offset + ribbonWidth, 0);
        path.lineTo(0, offset + ribbonWidth);
        path.close();
        break;

      case RibbonPosition.topRight:
        path.moveTo(size.width, offset);
        path.lineTo(size.width - offset, 0);
        path.lineTo(size.width - offset - ribbonWidth, 0);
        path.lineTo(size.width, offset + ribbonWidth);
        path.close();
        break;

      case RibbonPosition.bottomLeft:
        path.moveTo(0, size.height - offset);
        path.lineTo(offset, size.height);
        path.lineTo(offset + ribbonWidth, size.height);
        path.lineTo(0, size.height - offset - ribbonWidth);
        path.close();
        break;

      case RibbonPosition.bottomRight:
        path.moveTo(size.width, size.height - offset);
        path.lineTo(size.width - offset, size.height);
        path.lineTo(size.width - offset - ribbonWidth, size.height);
        path.lineTo(size.width, size.height - offset - ribbonWidth);
        path.close();
        break;

      case RibbonPosition.horizontalTop:
        path.moveTo(0, offset);
        path.lineTo(size.width, offset);
        path.lineTo(size.width, offset + ribbonWidth);
        path.lineTo(0, offset + ribbonWidth);
        path.close();
        break;

      case RibbonPosition.horizontalCenter:
        final centerY = size.height / 2;
        path.moveTo(0, centerY - ribbonWidth / 2);
        path.lineTo(size.width, centerY - ribbonWidth / 2);
        path.lineTo(size.width, centerY + ribbonWidth / 2);
        path.lineTo(0, centerY + ribbonWidth / 2);
        path.close();
        break;

      case RibbonPosition.horizontalBottom:
        path.moveTo(0, size.height - offset);
        path.lineTo(size.width, size.height - offset);
        path.lineTo(size.width, size.height - offset - ribbonWidth);
        path.lineTo(0, size.height - offset - ribbonWidth);
        path.close();
        break;

      case RibbonPosition.verticalLeft:
        path.moveTo(offset, 0);
        path.lineTo(offset + ribbonWidth, 0);
        path.lineTo(offset + ribbonWidth, size.height);
        path.lineTo(offset, size.height);
        path.close();
        break;

      case RibbonPosition.verticalCenter:
        final centerX = size.width / 2;
        path.moveTo(centerX - ribbonWidth / 2, 0);
        path.lineTo(centerX + ribbonWidth / 2, 0);
        path.lineTo(centerX + ribbonWidth / 2, size.height);
        path.lineTo(centerX - ribbonWidth / 2, size.height);
        path.close();
        break;

      case RibbonPosition.verticalRight:
        path.moveTo(size.width - offset, 0);
        path.lineTo(size.width - offset - ribbonWidth, 0);
        path.lineTo(size.width - offset - ribbonWidth, size.height);
        path.lineTo(size.width - offset, size.height);
        path.close();
        break;
    }

    canvas.drawPath(path, paint);

    // Draw the centered text on the ribbon
    final textSpan = TextSpan(text: text, style: textStyle);
    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();

    final pathBounds = path.getBounds();
    var textX = pathBounds.center.dx;
    var textY = pathBounds.center.dy;

    switch (position) {
      case RibbonPosition.topLeft:
        textX -= ribbonStroke / 4;
        textY -= ribbonStroke / 4;
        break;
      case RibbonPosition.topRight:
        textX += ribbonStroke / 4;
        textY -= ribbonStroke / 4;
        break;
      case RibbonPosition.bottomLeft:
        textX -= ribbonStroke / 4;
        textY += ribbonStroke / 4;
        break;
      case RibbonPosition.bottomRight:
        textX += ribbonStroke / 4;
        textY += ribbonStroke / 4;
        break;
      default:
        // No adjustment needed for non-corner positions
        break;
    }

    canvas.save();
    canvas.translate(textX, textY);

    switch (position) {
      case RibbonPosition.topLeft:
      case RibbonPosition.bottomRight:
        canvas.rotate(-pi / 4);
        break;
      case RibbonPosition.topRight:
      case RibbonPosition.bottomLeft:
        canvas.rotate(pi / 4);
        break;
      case RibbonPosition.horizontalTop:
      case RibbonPosition.horizontalCenter:
      case RibbonPosition.horizontalBottom:
        canvas.rotate(0);
        break;
      case RibbonPosition.verticalLeft:
      case RibbonPosition.verticalCenter:
      case RibbonPosition.verticalRight:
        canvas.rotate(-pi / 2);
        break;
    }

    textPainter.paint(
      canvas,
      Offset(
        -textPainter.width / 2,
        -textPainter.height / 2,
      ),
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _RibbonPainter oldDelegate) {
    return oldDelegate.ribbonColor != ribbonColor ||
        oldDelegate.cornerOffset != cornerOffset ||
        oldDelegate.ribbonStroke != ribbonStroke ||
        oldDelegate.position != position ||
        oldDelegate.text != text ||
        oldDelegate.textStyle != textStyle;
  }
}
