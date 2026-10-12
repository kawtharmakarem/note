import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/features/home/data/models/folder_model.dart';

import '../../../../core/common_widgets/custom_text_feild.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../splash/presentation/components/custom_button.dart';
import '../../cubit/details_cubit.dart';
import '../../cubit/details_state.dart';

class AddBlogWidget extends StatelessWidget {
  AddBlogWidget({super.key, required this.folderModel});
  final FolderModel folderModel;
  final GlobalKey<FormState> _addBlogKey = GlobalKey();

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
            key: _addBlogKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    AppStrings.addNewBlog,
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
                  controller: cubit.blogTitleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.blogTitleRequired;
                    }
                    return null;
                  },
                ),
                SizedBox(height: size.height * 0.02),

                CustomTextFeild(
                  hintText: AppStrings.content,
                  labelText: AppStrings.content,
                  maxLines: 4,
                  controller: cubit.blogContentController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.blogContentRequired;
                    }
                    return null;
                  },
                ),
                SizedBox(height: size.height * 0.02),

                CustomTextFeild(
                  hintText: AppStrings.date,
                  labelText: AppStrings.date,
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.dateRequired;
                    }
                    return null;
                  },
                  controller: cubit.blogDateController,
                  onTap: () {
                    cubit.getBlogDate(context);
                  },
                  suffixIcon: Icon(Icons.calendar_month),
                ),
                SizedBox(height: size.height * 0.02),

                CustomTextFeild(
                  hintText: AppStrings.time,
                  labelText: AppStrings.time,
                  readOnly: true,
                  suffixIcon: Icon(Icons.lock_clock),
                  controller: cubit.blogTimeController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.timeRequired;
                    }
                    return null;
                  },
                  onTap: () => cubit.getBlogTime(context),
                ),
                SizedBox(height: size.height * 0.02),

                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        title: AppStrings.save,
                        onPressed: () {
                          if (_addBlogKey.currentState!.validate()) {
                            cubit.insertNewBlog(
                              folderModel.userId,
                              folderModel.folderId,
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
