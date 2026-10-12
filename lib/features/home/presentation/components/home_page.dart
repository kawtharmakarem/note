import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/common_widgets/custom_text_feild.dart';
import '/core/functions/navigate.dart';
import '/core/functions/open_dialog.dart';
import '/core/services/services_locator.dart';
import '/core/utils/app_colors.dart';
import '/core/utils/app_constants.dart';
import '/core/utils/app_strings.dart';
import '/core/utils/app_styles.dart';
import '/features/details/cubit/details_cubit.dart';
import '/features/home/presentation/components/custom_add_button.dart';
import '/features/details/presentation/screen/details_page.dart';
import '/features/home/presentation/components/folder_card.dart';
import '/features/home/presentation/components/infinite_slider.dart';
import '/features/splash/presentation/components/custom_button.dart';

import '../../cubit/home_cubit.dart';
import '../../cubit/home_state.dart';
import 'folder_item.dart';
import 'custom_search_text_feild.dart';
import 'rounded_square_icon.dart';
import 'title_section.dart';
import 'user_name_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final GlobalKey<FormState> _addFolderKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cubit = context.read<HomeCubit>();
    if (cubit.loggedUser?.userId == null) return SizedBox();
    log(cubit.notesCount.toString());

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [RoundedSquareIcon(), UserNameWidget()],
            ),
            SizedBox(height: size.height * 0.03),
            TitleSection(),
            SizedBox(height: size.height * 0.03),
            CustomSearchTextFeild(),
            SizedBox(height: size.height * 0.03),
            SingleChildScrollView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              controller: cubit.folderController,
              child: Row(
                children: [
                  ...List.generate(
                    cubit.folders.length,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: FolderItem(
                        folderModel: cubit.folders[index],
                        onTap: () {
                          cubit.changeFolderIndex(index);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Stack(
              alignment: AlignmentGeometry.bottomCenter,
              clipBehavior: Clip.none,
              children: [
                InfiniteSlider(
                  index: cubit.folderIndex,
                  itemBuilder: (context, index) {
                    return cubit.folders.isEmpty
                        ? Center(
                            child: Text(
                              "No Folders yet !",
                              style: AppStyles.semiBold(context, 20),
                            ),
                          )
                        : FolderCard(cubit.folders[index], () {
                            pushNavigation(
                              context,
                              BlocProvider(
                                create: (_) => instance<DetailsCubit>()
                                  ..getLoggedUser(
                                    context,
                                    cubit.loggedUser!.userId!,
                                  )
                                  ..getNotesCount(cubit.loggedUser!.userId)
                                  ..getBlogsCount(cubit.loggedUser!.userId)
                                  ..getTodosCount(cubit.loggedUser!.userId),

                                child: DetailsPage(
                                  folderModel: cubit.folders[index],
                                ),
                              ),
                              Duration(seconds: AppConstants.splashDuration),
                            );
                          });
                  },
                  itemCount: cubit.folders.length,
                ),
                Positioned(
                  bottom: -30,
                  child: CustomAddButton(
                    onClicked: () {
                      openAnimatedDialog(
                        context,
                        title: Text(
                          AppStrings.addNewFolder,
                          style: AppStyles.semiBold(context, 20),
                        ),
                        content: BlocProvider.value(
                          value: context.read<HomeCubit>(),
                          child: addNewFolderContent(context),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget addNewFolderContent(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = context.watch<HomeCubit>();
        return Form(
          key: _addFolderKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFeild(
                hintText: "FolderName",
                labelText: "FolderName",
                controller: cubit.folderNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "folderName is required";
                  }
                  return null;
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,

                children: [
                  Text(
                    AppStrings.pickColor,
                    style: AppStyles.medium(context, 16),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.all(0),
                    child: Row(
                      children: List.generate(6, (colorIndex) {
                        return GestureDetector(
                          onTap: () {
                            cubit.selectColor(colorIndex);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: CircleAvatar(
                              backgroundColor: cubit.getColor(colorIndex),
                              radius: 20,
                              child: cubit.selectedColorIndex == colorIndex
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
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      title: "Save",
                      onPressed: () {
                        if (_addFolderKey.currentState!.validate()) {
                          //cubit.insertFolder(cubit.loggedUser!.userId);
                          cubit.insertNewFolder(
                            cubit.loggedUser!.userId,
                            cubit.folderNameController.text.trim(),
                            cubit.getColor(cubit.selectedColorIndex).toARGB32(),
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
        );
      },
    );
  }
}
