import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../home/data/models/folder_model.dart';
import '../../cubit/details_cubit.dart';

class FCard extends StatelessWidget {
  const FCard({super.key, required this.folderModel});
  final FolderModel folderModel;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DetailsCubit>();
    return folderModel.folderName == "Folders"
        ? SizedBox()
        : Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              border: Border.all(color: AppColors.mainTextColor, width: 2),
              color: Color(folderModel.folderColor),
            ),
            child: Column(
              children: [
                Text(
                  folderModel.folderName,
                  style: AppStyles.bold(context, 18),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Align(
                  alignment: AlignmentGeometry.center,
                  child: Text(
                    "You have ${cubit.getCount(folderModel.folderName)}  ${folderModel.folderName}",
                    style: AppStyles.medium(context, 16),
                  ),
                ),
              ],
            ),
          );
  }
}
