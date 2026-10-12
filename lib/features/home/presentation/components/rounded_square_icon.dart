import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class RoundedSquareIcon extends StatelessWidget {
  const RoundedSquareIcon({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(size.width * 0.02),
      height: size.width * 0.12,
      width: size.width * 0.12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,

        border: Border.all(color: AppColors.splashColor, width: 2),
      ),
      child: GridView(
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        children: List.generate(
          4,
          (index) => Container(
            margin: EdgeInsets.all(2),
            width: size.width * 0.02,
            height: size.width * 0.02,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index == 1 ? Colors.transparent : AppColors.black,
              border: Border.all(
                color: index == 1 ? AppColors.splashColor : AppColors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
