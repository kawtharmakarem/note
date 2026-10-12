import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/features/details/cubit/details_cubit.dart';
import '/features/home/data/models/folder_model.dart';

import 'f_card.dart';

class FolderContent extends StatefulWidget {
  const FolderContent({super.key, required this.folderModel});
  final FolderModel folderModel;

  @override
  State<FolderContent> createState() => _FolderContentState();
}

class _FolderContentState extends State<FolderContent> {
  int selectedIndex = 0;
  //final double collapseHeight = 90;
  //final double expandedHeight = 450;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DetailsCubit>();
    final screenHeight = MediaQuery.of(context).size.height * 0.75;
    final expandedHeight = screenHeight * 0.4;
    final collapseHeight = cubit.loadedFolders.length < 2
        ? 80.0
        : (screenHeight - expandedHeight) / (cubit.loadedFolders.length - 1);
    return SizedBox(
      height: cubit.loadedFolders.length * 220,
      // height:
      //     expandedHeight + (cubit.loadedFolders.length - 1) * collapseHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ...List.generate(cubit.loadedFolders.length, (index) {
            final bool isSelected = selectedIndex == index;
            double topOffset = 0;
            for (int i = 0; i < index; i++) {
              topOffset += i == selectedIndex ? expandedHeight : collapseHeight;
            }
            return Positioned(
              left: 0,
              right: 0,
              top: topOffset,
              bottom: 0,
              //bottom: bottomOffset,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: isSelected ? expandedHeight : collapseHeight,
                  child: FCard(folderModel: cubit.loadedFolders[index]),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
