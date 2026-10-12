import 'package:flutter/material.dart';

import 'entities/magazine.dart';

class MagazineCoverImage extends StatelessWidget {
  const MagazineCoverImage({super.key, required this.magazine, this.height});
  final Magazine magazine;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: AspectRatio(
        aspectRatio: 0.75,
        child: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(magazine.assetImage),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 40,
                offset: Offset(-20, 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
