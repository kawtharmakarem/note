import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/features/home/data/models/folder_model.dart';

import '../../../../core/common_widgets/custom_text_feild.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../splash/presentation/components/custom_button.dart';
import '../../cubit/details_cubit.dart';
import '../../cubit/details_state.dart';

class AddTodoWidget extends StatelessWidget {
  AddTodoWidget({super.key, required this.folderModel});
  final FolderModel folderModel;
  final GlobalKey<FormState> _addTodoKey = GlobalKey();

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
            key: _addTodoKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    AppStrings.addNewTodo,
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
                  controller: cubit.todoTitleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.todoTitleRequired;
                    }
                    return null;
                  },
                ),
                SizedBox(height: size.height * 0.02),

                CustomTextFeild(
                  hintText: AppStrings.content,
                  labelText: AppStrings.content,
                  maxLines: 4,
                  controller: cubit.todoContentController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.todoContentRequired;
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
                  controller: cubit.todoDateController,
                  onTap: () {
                    cubit.getTodoDate(context);
                  },
                  suffixIcon: Icon(Icons.calendar_month),
                ),
                SizedBox(height: size.height * 0.02),

                CustomTextFeild(
                  hintText: AppStrings.time,
                  labelText: AppStrings.time,
                  readOnly: true,
                  suffixIcon: Icon(Icons.lock_clock),
                  controller: cubit.todoTimeController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppStrings.timeRequired;
                    }
                    return null;
                  },
                  onTap: () => cubit.getTodoTime(context),
                ),
                SizedBox(height: size.height * 0.02),

                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        title: AppStrings.save,
                        onPressed: () {
                          if (_addTodoKey.currentState!.validate()) {
                            cubit.insertNewTodo(
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
