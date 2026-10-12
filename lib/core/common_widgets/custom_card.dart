import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      color: AppColors.white,
      elevation: 2,
      clipBehavior: Clip.hardEdge,
      shadowColor: AppColors.paperColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(25),
      ),
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.03),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.03,
          vertical: size.height * 0.01,
        ),
        child: child,
      ),
    );
  }
}
