import 'package:flutter/material.dart';

import '/core/utils/app_colors.dart';
import '/core/utils/app_constants.dart';

class SocialButton extends StatefulWidget {
  const SocialButton({super.key, required this.icon, required this.onTap});
  final String icon;
  final VoidCallback onTap;

  @override
  State<SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> {
  double scale = 1.0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTapDown: (_) => setState(() {
        scale = 0.95;
      }),
      onTapUp: (_) => setState(() {
        scale = 1.0;
        widget.onTap();
      }),
      onTapCancel: () => setState(() {
        scale = 1.0;
      }),
      child: AnimatedScale(
        scale: scale,
        duration: Duration(milliseconds: AppConstants.socialTime),
        child: Container(
          width: size.width * 0.17,
          height: size.width * 0.17,
          padding: EdgeInsets.all(size.width * 0.05),
          decoration: BoxDecoration(
            color: AppColors.lightGrey,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.1),
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Image.asset(widget.icon),
        ),
      ),
    );
  }
}
