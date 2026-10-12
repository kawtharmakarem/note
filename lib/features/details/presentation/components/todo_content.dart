import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '/features/details/cubit/details_cubit.dart';
import '/features/details/presentation/components/too_item.dart';

class TodoContent extends StatelessWidget {
  const TodoContent({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cubit = context.read<DetailsCubit>();
    return MasonryGridView(
      shrinkWrap: true,
      gridDelegate: SliverSimpleGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: size.width,
      ),
      children: [
        ...List.generate(
          cubit.todos.length,
          (index) => Padding(
            padding: EdgeInsetsGeometry.only(bottom: 20),
            child: TodoItem(todoModel: cubit.todos[index]),
          ),
        ),
      ],
    );
  }
}
