import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../cubit/home_cubit.dart';
import '../../data/models/folder_model.dart';

class FolderItem extends StatelessWidget {
  const FolderItem({super.key, required this.folderModel, required this.onTap});

  final FolderModel folderModel;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            folderModel.folderName,
            style: cubit.folderIndex == cubit.folders.indexOf(folderModel)
                ? AppStyles.medium(context, 18)
                : AppStyles.light(context, 18),
          ),
          if (cubit.folderIndex == cubit.folders.indexOf(folderModel))
            AnimatedContainer(
              duration: Duration(milliseconds: 500),

              height: 3,
              width: size.width * 0.1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColors.splashColor,
              ),
            ),
        ],
      ),
    );
  }
}
