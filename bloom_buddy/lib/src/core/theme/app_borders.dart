import 'package:flutter/widgets.dart';

class AppBorders {
  AppBorders._();

  static const double radiusSmall = 8.0;
  static const double radiusMedium = 16;
  static const double radiusLarge = 24;
  static final BorderRadius circularSmall = BorderRadius.circular(radiusSmall);
  static final BorderRadius circularMedium = BorderRadius.circular(
    radiusMedium,
  );
  static final BorderRadius circularLarge = BorderRadius.circular(radiusLarge);
}
