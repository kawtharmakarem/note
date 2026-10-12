import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '/core/utils/app_colors.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key, required this.image, required this.onClick});
  final File? image;
  final ValueChanged<ImageSource> onClick;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          buildImage(context),
          Positioned(bottom: -1, right: 0, child: buildEditIcon(context)),
        ],
      ),
    );
  }

  Widget buildImage(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (image == null) {
      return GestureDetector(
        onTap: () async {
          final source = await showImageSource(context);
          if (source == null) return;
          onClick(source);
        },
        child: CircleAvatar(
          radius: size.width * 0.11,
          backgroundColor: AppColors.paperColor.withValues(alpha: 0.5),
        ),
      );
    } else {
      String imagePath = image!.path;

      final img = imagePath.contains("https://")
          ? NetworkImage(imagePath)
          : FileImage(File(imagePath));
      return ClipOval(
        child: Material(
          color: Colors.transparent,
          child: Ink.image(
            image: img as ImageProvider,
            fit: BoxFit.cover,
            width: size.width * 0.22,
            height: size.width * 0.22,
            child: InkWell(
              onTap: () async {
                final source = await showImageSource(context);
                if (source == null) return;
                onClick(source);
              },
            ),
          ),
        ),
      );
    }
  }

  Widget buildEditIcon(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final source = await showImageSource(context);
        if (source == null) return;
        onClick(source);
      },
      child: buildCircle(
        padding: 3,
        color: AppColors.splashColor,
        child: buildCircle(
          padding: 4,
          color: AppColors.white,
          child: Icon(Icons.edit, color: AppColors.mainTextColor),
        ),
      ),
    );
  }

  ClipOval buildCircle({
    required double padding,
    required Color color,
    required Widget child,
  }) {
    return ClipOval(
      child: Container(
        padding: EdgeInsets.all(padding),
        color: color,
        child: child,
      ),
    );
  }

  Future<ImageSource?> showImageSource(BuildContext context) async {
    if (Platform.isIOS) {
      return showCupertinoModalPopup<ImageSource>(
        context: context,
        builder: (context) {
          return CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                onPressed: () => Navigator.of(context).pop(ImageSource.camera),
                child: Text("Camera"),
              ),
              CupertinoActionSheetAction(
                onPressed: () => Navigator.of(context).pop(ImageSource.gallery),
                child: Text("Gallery"),
              ),
            ],
          );
        },
      );
    } else {
      return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text("Camera"),
                onTap: () => Navigator.of(context).pop(ImageSource.camera),
              ),
              ListTile(
                leading: Icon(Icons.image),
                title: Text("Gallery"),
                onTap: () => Navigator.of(context).pop(ImageSource.gallery),
              ),
            ],
          );
        },
      );
    }
  }
}
