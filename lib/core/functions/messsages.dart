import 'package:flutter/material.dart';

import '/core/utils/app_colors.dart';
import '/core/utils/app_styles.dart';

void showSnakMessage(BuildContext context, {required String text}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: AppColors.mainTextColor,
      content: Center(
        child: Text(
          text,
          style: AppStyles.medium(context, 14).copyWith(color: AppColors.white),
        ),
      ),
    ),
  );
}
