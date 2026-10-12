import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class SplashItem extends StatelessWidget {
  const SplashItem({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(left: width * 0.03),
          child: CircleAvatar(backgroundColor: AppColors.white, radius: 10),
        ),
        SizedBox(height: height * 0.005),
        Divider(thickness: 1, color: AppColors.white),
        SizedBox(height: height * 0.005),
      ],
    );
  }
}
