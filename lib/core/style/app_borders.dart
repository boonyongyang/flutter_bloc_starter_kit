import 'package:flutter/material.dart';

class AppBorders {
  static BorderRadius roundedSmall = BorderRadius.circular(8);
  static BorderRadius roundedMedium = BorderRadius.circular(16);
  static BorderRadius roundedLarge = BorderRadius.circular(24);
  static BorderRadius angledCornersBorder = const BorderRadius.only(
    topLeft: Radius.circular(4),
    topRight: Radius.circular(16),
    bottomLeft: Radius.circular(16),
    bottomRight: Radius.circular(4),
  );
}
