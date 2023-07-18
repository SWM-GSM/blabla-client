import 'package:blabla/styles/colors.dart';
import 'package:flutter/material.dart';

class CustomSliderThumbWidget extends SliderComponentShape {
  CustomSliderThumbWidget();

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size.fromRadius(12);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    final canvas = context.canvas;
    final path = Path();

    final double radius = 12;

    final fillPaint = Paint()..color = BlaColor.orange ..style = PaintingStyle.fill;
    final borderPaint = Paint()..color = BlaColor.white ..strokeWidth = 2 ..style = PaintingStyle.stroke;

    path.addOval(Rect.fromCircle(center: center, radius: radius + 2));

    canvas.drawShadow(path, BlaColor.black.withOpacity(0.16), 1.0, true);
    canvas.drawCircle(center, radius, fillPaint);
    canvas.drawCircle(center, radius, borderPaint);
  }
}
