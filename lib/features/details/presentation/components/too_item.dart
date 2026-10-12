import 'package:flutter/material.dart';

import '/features/details/data/models/todo_model.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({super.key, required this.todoModel});
  final TodoModel todoModel;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      alignment: AlignmentGeometry.center,
      children: [
        Container(
          height: size.height * 0.3,
          width: size.width * 0.9,
          decoration: BoxDecoration(
            color: AppColors.splashColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                spreadRadius: 2,
                offset: Offset(0, 2),
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          right: 0,
          bottom: 0,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 5,
              right: 5,
              top: 5,
              bottom: 5,
            ),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                todoItemLine(context, "Title", todoModel.todoTitle),
                todoItemLine(context, "Date", todoModel.todoDate),
                todoItemLine(context, "Time", todoModel.todoTime),
                todoItemLine(context, "Content", todoModel.todoContent),
                // Row(
                //   children: [
                //     TextButton(onPressed: () {}, child: Text("Todo")),
                //     IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget todoItemLine(BuildContext context, String label, String content) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: size.width * 0.02),
              child: CircleAvatar(backgroundColor: AppColors.white, radius: 10),
            ),
            SizedBox(width: 5),
            Row(
              children: [
                Text("$label : ", style: AppStyles.medium(context, 16)),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Text(
                    content,
                    style: AppStyles.regular(context, 16),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
              ],
            ),
          ],
        ),
        //SizedBox(height: height * 0.01),
        Container(
          alignment: Alignment.center,
          width: size.width * 0.8,
          height: 2,
          color: AppColors.white,
        ),
        SizedBox(height: size.height * 0.03),
      ],
    );
  }
}
