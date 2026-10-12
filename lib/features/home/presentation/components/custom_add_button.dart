import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class CustomAddButton extends StatefulWidget {
  const CustomAddButton({super.key, required this.onClicked});
  final VoidCallback onClicked;

  @override
  State<CustomAddButton> createState() => _CustomAddButtonState();
}

class _CustomAddButtonState extends State<CustomAddButton> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          isPressed = false;
          widget.onClicked();
        });
      },
      child: Container(
        height: isPressed ? size.width * 0.2 : size.width * 0.17,
        width: isPressed ? size.width * 0.2 : size.width * 0.17,
        // transform: Matrix4.translationValues(
        //   isPressed ? 3 : 0,
        //   isPressed ? 3 : 0,
        //   0,
        // ),
        decoration: BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: Offset(3, 2),
            ),
          ],
        ),
        child: Icon(Icons.add, size: 40),
      ),
    );
  }
}
