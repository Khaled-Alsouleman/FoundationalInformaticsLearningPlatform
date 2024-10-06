import 'package:flutter/material.dart';

class AppDimensions {
  // Padding
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 48.0;

  // Flexible BorderRadius Definitionen
  static const BorderRadius borderRadiusAll = BorderRadius.all(Radius.circular(15));
  static const BorderRadius borderRadiusNone = BorderRadius.zero; // Keine abgerundeten Ecken
  static const BorderRadius borderRadiusTop = BorderRadius.vertical(top: Radius.circular(15));
  static const BorderRadius borderRadiusBottom = BorderRadius.vertical(bottom: Radius.circular(15));
  static const BorderRadius borderRadiusLeft = BorderRadius.horizontal(left: Radius.circular(15));
  static const BorderRadius borderRadiusRight = BorderRadius.horizontal(right: Radius.circular(15));

  // Einzelne Ecken
  static const BorderRadius borderRadiusTopLeft = BorderRadius.only(topLeft: Radius.circular(15));
  static const BorderRadius borderRadiusTopRight = BorderRadius.only(topRight: Radius.circular(15));
  static const BorderRadius borderRadiusBottomLeft = BorderRadius.only(bottomLeft: Radius.circular(15));
  static const BorderRadius borderRadiusBottomRight = BorderRadius.only(bottomRight: Radius.circular(15));

  // Kombinierte Ecken
  static const BorderRadius borderRadiusTopLeftBottomRight = BorderRadius.only(
    topLeft: Radius.circular(15),
    bottomRight: Radius.circular(15),
  );
}
