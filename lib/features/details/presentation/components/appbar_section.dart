import 'package:flutter/material.dart';

import '/core/utils/app_assets.dart';
import '/core/utils/app_styles.dart';

import '../../../../core/utils/app_colors.dart';

class AppbarSection extends StatelessWidget {
  const AppbarSection({
    super.key,
    required this.title,
    required this.onSearch,
    required this.onAdd,
  });
  final String title;
  final VoidCallback onSearch;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomIcon(
          child: Image.asset(
            AppAssets.keyboardArrowLeft,
            height: 40,
            width: 40,
            color: AppColors.mainTextColor,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        Text(
          title,
          style: AppStyles.splashText(context).copyWith(fontSize: 40),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomIcon(
              onTap: onSearch,
              child: Image.asset(
                AppAssets.search,
                height: 20,
                width: 20,
                color: AppColors.mainTextColor,
              ),
            ),
            SizedBox(width: 5),
            CustomIcon(
              onTap: onAdd,
              child: Image.asset(
                AppAssets.add,
                height: 30,
                width: 30,
                color: AppColors.mainTextColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CustomIcon extends StatelessWidget {
  const CustomIcon({super.key, required this.child, required this.onTap});
  final Widget child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(size.width * 0.02),
        height: size.width * 0.12,
        width: size.width * 0.12,
        decoration: BoxDecoration(
          shape: BoxShape.circle,

          border: Border.all(color: AppColors.splashColor, width: 2),
        ),
        child: child,
      ),
    );
  }
}
