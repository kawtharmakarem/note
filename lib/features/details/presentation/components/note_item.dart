import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/services/services_locator.dart';
import '/core/utils/app_colors.dart';
import '/core/utils/app_styles.dart';
import '/features/details/cubit/details_cubit.dart';
import '/features/details/data/models/note_model.dart';

import '../../../../core/utils/app_assets.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({super.key, required this.noteModel});
  final NoteModel noteModel;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {},
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 5),

            width: size.width * 0.5,

            height: size.height * 0.25,
            decoration: BoxDecoration(
              color: Color(noteModel.noteColor),
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.5),
                  blurRadius: 15,
                  offset: Offset(5, 8),
                ),
              ],
            ),
          ),
          Container(
            width: size.width * 0.5,
            height: size.height * 0.25,

            padding: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  noteModel.noteTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: AppStyles.bold(context, 16),
                ),
                Text(
                  noteModel.noteContent,

                  maxLines: 7,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: AppStyles.medium(context, 16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          noteModel.noteDate,
                          style: AppStyles.regular(context, 14),
                        ),
                        Text(
                          noteModel.noteTime,
                          style: AppStyles.regular(context, 14),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => BlocProvider.value(
                            value: instance<DetailsCubit>(),
                            child: AlertDialog(
                              title: Text(
                                "Delete Note",
                                style: AppStyles.medium(context, 16),
                              ),
                              content: Text(
                                "Are you sure ? ",
                                style: AppStyles.regular(context, 16),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Cancel",
                                    style: AppStyles.regular(context, 14),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    context.read<DetailsCubit>().deleteNote(
                                      noteModel,
                                    );
                                  },
                                  child: Text(
                                    "Yes",
                                    style: AppStyles.regular(context, 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },

                      icon: Icon(Icons.delete, color: AppColors.mainTextColor),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Positioned(
            top: -35,
            left: 80,
            child: Image.asset(
              AppAssets.pin,
              height: 70,
              width: 70,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}

//-8 * pi / 180,
