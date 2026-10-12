import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/utils/app_colors.dart';

import '../../../../core/common_widgets/custom_text_feild.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../splash/presentation/components/custom_button.dart';
import '../../cubit/details_cubit.dart';
import '../../cubit/details_state.dart';

class AddFolderWidget extends StatelessWidget {
  AddFolderWidget({super.key});
  final GlobalKey<FormState> _addFolderKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<DetailsCubit, DetailsState>(
      builder: (context, state) {
        final cubit = context.read<DetailsCubit>();
        return Container(
          padding: EdgeInsets.all(size.width * 0.05),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Form(
            key: _addFolderKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    AppStrings.addNewFolder,
                    style: AppStyles.semiBold(
                      context,
                      18,
                    ).copyWith(letterSpacing: 1.5),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                CustomTextFeild(
                  hintText: "FolderName",
                  labelText: "FolderName",
                  controller: cubit.addFolderNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "folderName is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    Text(
                      AppStrings.pickColor,
                      style: AppStyles.medium(context, 16),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(6, (colorIndex) {
                        return GestureDetector(
                          onTap: () {
                            cubit.changeFolderColorIndex(colorIndex);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: CircleAvatar(
                              backgroundColor: cubit.getFolderColor(colorIndex),
                              radius: 20,
                              child: cubit.folderColorIndex == colorIndex
                                  ? Icon(Icons.check, color: AppColors.white)
                                  : null,
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        title: "Save",
                        onPressed: () {
                          if (_addFolderKey.currentState!.validate()) {
                            cubit.addNewFolder(
                              context,
                              cubit.loggedUser!.userId,
                              cubit
                                  .getFolderColor(cubit.folderColorIndex)
                                  .toARGB32(),
                              cubit.addFolderNameController.text.trim(),
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: CustomButton(
                        title: "Cancel",
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

//  Widget addNewFolderContent(BuildContext context) {
//     return BlocBuilder<HomeCubit, HomeState>(
//       builder: (context, state) {
//         final cubit = context.watch<HomeCubit>();
//         return Form(
//           key: _addFolderKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CustomTextFeild(
//                 hintText: "FolderName",
//                 labelText: "FolderName",
//                 controller: cubit.folderNameController,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "folderName is required";
//                   }
//                   return null;
//                 },
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,

//                 children: [
//                   Text(
//                     AppStrings.pickColor,
//                     style: AppStyles.medium(context, 16),
//                   ),
//                   SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     padding: EdgeInsets.all(0),
//                     child: Row(
//                       children: List.generate(6, (colorIndex) {
//                         return GestureDetector(
//                           onTap: () {
//                             cubit.selectColor(colorIndex);
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.only(right: 8),
//                             child: CircleAvatar(
//                               backgroundColor: cubit.getColor(colorIndex),
//                               radius: 20,
//                               child: cubit.selectedColorIndex == colorIndex
//                                   ? Icon(Icons.check, color: AppColors.white)
//                                   : null,
//                             ),
//                           ),
//                         );
//                       }),
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: CustomButton(
//                       title: "Save",
//                       onPressed: () {
//                         if (_addFolderKey.currentState!.validate()) {
//                           cubit.insertFolder();
//                         }
//                       },
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   Expanded(
//                     child: CustomButton(
//                       title: "Cancel",
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
