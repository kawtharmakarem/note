import 'dart:math';

import 'package:flutter/material.dart';

import '../../../core/shared/entities/magazine.dart';
import '../../../core/shared/magazine_cover_image.dart';
import '../../../core/shared/menu_button.dart';
import '../../../core/theme/vice_icons.dart';
import '../../../features/home/presentation/components/infinite_slider.dart';
import '/core/constants/vice_ui_consts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    this.enableEntryAnimation = false,
    this.initialIndex = 0,
  });
  final bool enableEntryAnimation;
  final int initialIndex;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Magazine> magazines = Magazine.fakeMagazineValues;
  late int currentIndex;
  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: ViceUiConsts.gradientDecoration,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _AppBar(),
        body: Column(
          children: [
            SizedBox(height: 12),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(prefixIcon: Icon(ViceIcons.search)),
              ),
            ),
            SizedBox(height: 20),
            Text("THE ARCHIVE"),
            SizedBox(height: 12),
            //infinit slider
            Expanded(
              child: InfiniteSlider(
                itemBuilder: (context, index) => MagazineCoverImage(
                  magazine: Magazine.fakeMagazineValues[index],
                ),
                itemCount: Magazine.fakeMagazineValues.length,
              ),
            ),
            SizedBox(height: 52),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  ...List.generate(
                    magazines.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: MagazineCoverImage(magazine: magazines[index]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: SizedBox(
            height: kToolbarHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.home)),
                IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
                IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSize {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      clipBehavior: Clip.none,
      title: Image.asset(
        "assets/img/vice/vice-logo.png",
        height: 30,
        color: Colors.white,
      ),
      actions: [MenuButton()],
    );
  }

  @override
  Widget get child => this;

  @override
  Size get preferredSize => Size.fromHeight(kTextTabBarHeight);
}
