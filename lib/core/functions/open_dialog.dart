import 'package:flutter/material.dart';

void openAnimatedDialog(
  BuildContext context, {
  required Widget title,
  required Widget content,
}) {
  Size size = MediaQuery.of(context).size;
  showGeneralDialog(
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) => content,
    transitionDuration: const Duration(milliseconds: 500),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return ScaleTransition(
        scale: Tween<double>(begin: 0, end: 1).animate(animation),
        child: FadeTransition(
          opacity: Tween<double>(begin: 0.5, end: 1).animate(animation),
          child: AlertDialog(
            contentPadding: EdgeInsets.all(10),

            title: title,
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            content: SizedBox(
              height: size.height * 0.4,
              width: size.width,

              child: child,
            ),
          ),
        ),
      );
    },
  );
}
