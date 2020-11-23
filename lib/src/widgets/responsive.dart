import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

class Responsive {
  final double width, heigth, inch;

  Responsive(
      {@required this.width, @required this.heigth, @required this.inch});

  factory Responsive.of(BuildContext context) {
    MediaQueryData data = MediaQuery.of(context);
    final size = data.size;
    final inch = math.sqrt(math.pow(size.width, 2) + math.pow(size.height, 2));
    return Responsive(width: size.width, heigth: size.height, inch: inch);
  }

  double wp(double percent) {
    return this.width * percent / 100;
  }

  double hp(double percent) {
    return this.heigth * percent / 100;
  }

  double ip(double percent) {
    return this.inch * percent / 100;
  }
}
