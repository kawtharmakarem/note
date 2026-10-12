import 'package:flutter/material.dart';

import '/core/utils/app_colors.dart';
import '/core/utils/app_styles.dart';
import '/features/home/data/models/folder_model.dart';

class FolderCard extends StatelessWidget {
  const FolderCard(this.folderModel, this.onTap, {super.key});
  final FolderModel folderModel;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Material(
        elevation: 2,

        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: size.width * 0.02,
          ),
          height: size.height * 0.3,
          width: size.width * 0.5,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(folderModel.folderColor), AppColors.lightGrey],
              stops: [0.3, 1],
              begin: AlignmentGeometry.topCenter,
              end: AlignmentGeometry.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'All ${folderModel.folderName}',
                  style: AppStyles.semiBold(context, 16),
                ),
                SizedBox(height: size.height * 0.03),
                //todo later
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//  return SizedBox(
//       height: height,
//       child: AspectRatio(
//         aspectRatio: 0.75,
//         child: DecoratedBox(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage(magazine.assetImage),
//               fit: BoxFit.cover,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black54,
//                 blurRadius: 40,
//                 offset: Offset(-20, 20),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
