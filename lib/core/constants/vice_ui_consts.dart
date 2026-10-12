import 'package:flutter/material.dart';

import '/core/theme/vice_colors.dart';

class ViceUiConsts {
  ViceUiConsts._();
  static BoxDecoration gradientDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: ViceColor.scaffoldColor,
      begin: AlignmentGeometry.topCenter,
      end: AlignmentGeometry.bottomCenter,
      stops: [0.3, 1],
    ),
  );
  static double headerHight(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.65;
  }
}
