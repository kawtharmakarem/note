import 'package:flutter/material.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';

class CustomSearchTextFeild extends StatelessWidget {
  const CustomSearchTextFeild({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextFormField(
      decoration: InputDecoration(
        hint: Text(AppStrings.searchHint, style: AppStyles.light(context, 14)),
        suffixIconConstraints: BoxConstraints(
          minHeight: size.width * 0.06,
          minWidth: size.width * 0.06,
        ),

        suffixIcon: Padding(
          padding: EdgeInsets.only(right: size.width * 0.03),
          child: Image.asset(
            AppAssets.search,
            width: size.width * 0.06,
            height: size.width * 0.06,
            fit: BoxFit.cover,
            color: AppColors.mainTextColor,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: AppColors.splashColor, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: AppColors.splashColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: AppColors.splashColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: AppColors.red, width: 1),
        ),
      ),
    );
  }
}
