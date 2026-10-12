import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/utils/app_colors.dart';
import '/features/details/cubit/details_cubit.dart';
import '/features/home/data/models/folder_model.dart';
import '/features/splash/presentation/components/custom_button.dart';

import '../../../../core/common_widgets/custom_text_feild.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../cubit/details_state.dart';

class AddNoteWidget extends StatelessWidget {
  AddNoteWidget({super.key, required this.folderModel});
  final FolderModel folderModel;

  final GlobalKey<FormState> _addNoteKey = GlobalKey<FormState>();

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
            key: _addNoteKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    AppStrings.addNewNote,
                    style: AppStyles.semiBold(
                      context,
                      18,
                    ).copyWith(letterSpacing: 1.5),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                CustomTextFeild(
                  hintText: AppStrings.title,
                  labelText: AppStrings.title,
                  controller: cubit.noteTitleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.noteTitleRequired;
                    }
                    return null;
                  },
                ),
                SizedBox(height: size.height * 0.02),

                CustomTextFeild(
                  hintText: AppStrings.content,
                  labelText: AppStrings.content,
                  maxLines: 4,
                  controller: cubit.noteContentController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.noteContentRequired;
                    }
                    return null;
                  },
                ),
                SizedBox(height: size.height * 0.02),

                CustomTextFeild(
                  hintText: AppStrings.date,
                  labelText: AppStrings.date,
                  readOnly: true,
                  controller: cubit.noteDateController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.dateRequired;
                    }
                    return null;
                  },
                  onTap: () {
                    cubit.getNoteDate(context);
                  },
                  suffixIcon: Icon(Icons.calendar_month),
                ),
                SizedBox(height: size.height * 0.02),

                CustomTextFeild(
                  hintText: AppStrings.time,
                  labelText: AppStrings.time,
                  readOnly: true,
                  suffixIcon: Icon(Icons.lock_clock),
                  controller: cubit.noteTimeController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.timeRequired;
                    }
                    return null;
                  },
                  onTap: () => cubit.getTime(context),
                ),
                SizedBox(height: size.height * 0.02),

                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.pickColor,
                      style: AppStyles.medium(context, 16),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(6, (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: GestureDetector(
                              onTap: () {
                                cubit.selectColorIndex(index);
                              },
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: cubit.getNoteColor(index),
                                child: cubit.noteColorIndex == index
                                    ? Icon(Icons.check, color: AppColors.white)
                                    : null,
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.02),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        title: AppStrings.save,
                        onPressed: () {
                          if (_addNoteKey.currentState!.validate()) {
                            cubit.insertNote(
                              folderModel.folderId,
                              folderModel.userId,
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(width: size.width * 0.01),
                    Expanded(
                      child: CustomButton(
                        title: AppStrings.cancel,
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
