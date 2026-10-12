import 'package:flutter/material.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';

class TitleSection extends StatelessWidget {
  const TitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentGeometry.centerLeft,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: AppStrings.createAndDesign,
              style: AppStyles.regular(context, 38),
            ),
            TextSpan(
              text: AppStrings.notes,
              style: AppStyles.semiBold(context, 38),
            ),
            TextSpan(
              text: AppStrings.easly,
              style: AppStyles.regular(context, 38),
            ),
          ],
        ),
      ),
    );
  }
}
