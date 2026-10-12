import 'package:flutter/material.dart';

import '/features/details/data/models/blog_model.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class BlogItem extends StatelessWidget {
  const BlogItem({super.key, required this.blogModel});
  final BlogModel blogModel;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 110),
            height: size.height * 0.4,
            width: size.width * 0.6,
            decoration: BoxDecoration(
              color: AppColors.splashColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                blogModel.blogContent,
                style: AppStyles.semiBold(context, 16).copyWith(height: 1.5),
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 20,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.mainTextColor,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(10),
                ),
              ),
              child: Text(
                blogModel.blogTitle,
                style: AppStyles.medium(
                  context,
                  16,
                ).copyWith(color: AppColors.white),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 5,
            right: 5,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.mainTextColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        blogModel.blogDate,
                        style: AppStyles.semiBold(
                          context,
                          14,
                        ).copyWith(color: AppColors.white),
                      ),
                      Text(
                        blogModel.blogTime,
                        style: AppStyles.semiBold(
                          context,
                          14,
                        ).copyWith(color: AppColors.white),
                      ),
                    ],
                  ),

                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    height: 40,
                    width: 2,
                    decoration: BoxDecoration(
                      color: AppColors.white70,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
                    onPressed: () {},
                    child: Text(
                      "DeleteBlog",
                      style: AppStyles.regular(
                        context,
                        14,
                      ).copyWith(color: AppColors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
