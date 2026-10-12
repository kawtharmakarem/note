import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/features/home/cubit/home_cubit.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class UserNameWidget extends StatelessWidget {
  const UserNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cubit = context.read<HomeCubit>();

    String imagePath = cubit.loggedUser?.imagePath ?? "";

    return Container(
      height: size.height * 0.05,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.splashColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: size.height * 0.025,
            backgroundColor: AppColors.paperColor.withValues(alpha: 0.5),
            backgroundImage: imagePath == ""
                ? null
                : FileImage(File(cubit.loggedUser!.imagePath!)),
          ),
          SizedBox(width: size.width * 0.02),
          Text(
            cubit.loggedUser?.username ?? "no user",
            style: AppStyles.regular(context, 14),
          ),
          SizedBox(width: size.width * 0.02),
        ],
      ),
    );
  }
}
