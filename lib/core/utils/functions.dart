import 'package:flutter/material.dart';

void replacementNavigation(
  BuildContext context,
  Widget newScreen,
  Duration duration,
) {
  Navigator.of(context).pushReplacement(
    PageRouteBuilder(
      pageBuilder: (_, animation, _) {
        return newScreen;
      },
      transitionDuration: duration,
      transitionsBuilder: (_, animation, _, child) =>
          FadeTransition(opacity: animation, child: child),
    ),
  );
}
