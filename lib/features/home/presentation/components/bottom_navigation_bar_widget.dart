import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/features/home/cubit/home_cubit.dart';

import '../../../../core/utils/app_colors.dart';
import 'custom_icon_button.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cubit = context.read<HomeCubit>();
    return ClipPath(
      clipper: MyCustomClipper(),
      child: Container(
        height: 100,
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.08,
          vertical: size.height * 0.03,
        ),
        decoration: BoxDecoration(color: AppColors.black),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            3,
            (index) => CustomIconButton(
              iconData: cubit.getIcon(index),
              color: index == cubit.bottomBarIndex
                  ? AppColors.white
                  : AppColors.lightWhite,
              onTap: () {
                cubit.togglePage(index);
              },
            ),
          ),
        ),
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path()
      ..moveTo(0, size.height)
      ..lineTo(0, size.height - 75)
      ..quadraticBezierTo(
        size.width / 2,
        size.height - 100,
        size.width,
        size.height - 75,
      )
      ..lineTo(size.width, size.height)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<dynamic> oldClipper) => false;
}
