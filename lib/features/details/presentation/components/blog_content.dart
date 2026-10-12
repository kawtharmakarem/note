import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '/features/details/cubit/details_cubit.dart';
import '/features/details/presentation/components/blog_item.dart';

class BlogContent extends StatelessWidget {
  const BlogContent({super.key});

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
        ...List.generate(cubit.blogs.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: BlogItem(blogModel: cubit.blogs[index]),
          );
        }),
      ],
    );
    //return BlogItem(blogModel: blogModel);
  }
}

// "I once wanted to become a pro badminton player although every dream doesn't come true, I am happy that at least I learn to play.",
