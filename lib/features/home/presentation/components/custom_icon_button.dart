import 'package:flutter/material.dart';

import '/core/utils/app_colors.dart';

class CustomIconButton extends StatefulWidget {
  const CustomIconButton({
    super.key,
    required this.iconData,
    required this.onTap,
    this.color = AppColors.lightWhite,
  });
  final IconData iconData;
  final VoidCallback onTap;
  final Color color;

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() {
        isPressed = true;
      }),
      onTapUp: (_) => setState(() {
        isPressed = false;
        widget.onTap();
      }),
      child: Container(
        transform: Matrix4.translationValues(
          isPressed ? 3 : 0,
          isPressed ? 3 : 0,
          0,
        ),
        child: Icon(widget.iconData, size: 30, color: widget.color),
      ),
    );
  }
}
