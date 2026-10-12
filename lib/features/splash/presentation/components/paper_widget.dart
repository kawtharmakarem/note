import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import 'splashItem.dart';

class PaperWidget extends StatelessWidget {
  const PaperWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(color: AppColors.splashColor),
      child: ListView.builder(
        padding: EdgeInsets.only(top: size.height * 0.03),
        physics: NeverScrollableScrollPhysics(),
        itemCount: 25,
        itemBuilder: (context, index) => SplashItem(),
      ),
    );
  }
}
