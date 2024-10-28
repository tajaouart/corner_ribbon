import 'dart:math';

import 'package:flutter/material.dart';

import '../corner_ribbon.dart';

class CornerRibbon extends StatelessWidget {
  final RibbonPosition position;
  final Decoration? decoration;
  final TextStyle? textStyle;
  final Color ribbonColor;
  final Widget child;
  final String label;
  final int maxLines;

  const CornerRibbon({
    super.key,
    required this.child,
    required this.label,
    this.position = RibbonPosition.topLeft,
    this.ribbonColor = Colors.blue,
    this.maxLines = 1,
    this.decoration,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double ribbonWidth = constraints.maxWidth * 1.2;
        final double ribbonHeight = constraints.maxHeight * 0.2;
        final double adjustedFontSize = (ribbonWidth + ribbonHeight) * 0.07;

        return Stack(
          alignment: _getStackAlignment(),
          children: [
            child,
            Positioned(
              right: _getRightPosition(ribbonWidth, ribbonHeight),
              left: _getLeftPosition(ribbonWidth, ribbonHeight),
              bottom: _getBottomPosition(ribbonWidth),
              top: _getTopPosition(ribbonWidth),
              child: Transform.rotate(
                angle: _getAngle(),
                child: Container(
                  height: ribbonHeight,
                  width: ribbonWidth,
                  alignment: Alignment.center,
                  decoration: decoration ??
                      BoxDecoration(
                        color: ribbonColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            offset: const Offset(3, 3),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    maxLines: maxLines,
                    style: textStyle ??
                        TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: adjustedFontSize,
                        ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  AlignmentGeometry _getStackAlignment() {
    switch (position) {
      case RibbonPosition.verticalRight:
        return AlignmentDirectional.centerEnd;
      case RibbonPosition.verticalCenter:
        return AlignmentDirectional.center;
      case RibbonPosition.verticalLeft:
        return AlignmentDirectional.centerStart;
      case RibbonPosition.horizontalBottom:
        return AlignmentDirectional.bottomCenter;
      case RibbonPosition.horizontalCenter:
        return AlignmentDirectional.center;
      case RibbonPosition.horizontalTop:
        return AlignmentDirectional.topCenter;
      case RibbonPosition.topRight:
      case RibbonPosition.bottomLeft:
      case RibbonPosition.bottomRight:
      case RibbonPosition.topLeft:
        return AlignmentDirectional.center;
    }
  }

  double _getAngle() {
    switch (position) {
      case RibbonPosition.topRight:
      case RibbonPosition.bottomLeft:
        return pi / 4;
      case RibbonPosition.bottomRight:
      case RibbonPosition.topLeft:
        return -pi / 4;
      case RibbonPosition.verticalRight:
      case RibbonPosition.verticalCenter:
      case RibbonPosition.verticalLeft:
        return -pi / 2;
      case RibbonPosition.horizontalBottom:
      case RibbonPosition.horizontalCenter:
      case RibbonPosition.horizontalTop:
        return 0;
    }
  }

  double? _getLeftPosition(double width, double ribbonHeight) {
    if (position == RibbonPosition.topLeft ||
        position == RibbonPosition.bottomLeft) {
      return -width * 0.2;
    }

    if (position == RibbonPosition.verticalLeft) {
      return (-width / 2) + ribbonHeight / 2;
    }

    return null;
  }

  double? _getRightPosition(double width, double ribbonHeight) {
    if (position == RibbonPosition.topRight ||
        position == RibbonPosition.bottomRight) {
      return -width * 0.2;
    }

    if (position == RibbonPosition.verticalRight) {
      return (-width / 2) + ribbonHeight / 2;
    }
    return null;
  }

  double? _getTopPosition(double width) {
    if (position == RibbonPosition.topLeft ||
        position == RibbonPosition.topRight) {
      return width * 0.15;
    }

    return null;
  }

  double? _getBottomPosition(double width) {
    if (position == RibbonPosition.bottomLeft ||
        position == RibbonPosition.bottomRight) {
      return width * 0.15;
    }
    return null;
  }
}
