import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/cache/cache_helper.dart';
import '/core/services/services_locator.dart';
import '/core/utils/app_colors.dart';
import '/core/utils/app_constants.dart';
import '/core/utils/app_strings.dart';
import '/core/utils/app_styles.dart';
import '/core/utils/functions.dart';
import '/features/auth/presentation/screens/auth_screen.dart';
import '/features/home/cubit/home_cubit.dart';
import '/features/home/presentation/screens/main_screen.dart';
import '/features/splash/presentation/components/custom_button.dart';

import 'dart:math' as math;

import 'paper_widget.dart';

class MobileSplashScreen extends StatelessWidget {
  const MobileSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          PaperWidget(),
          Positioned(
            right: 0,
            bottom: 0,
            child: CustomPaint(painter: MyCustomPaint()),
          ),
          Transform.rotate(
            angle: -math.pi / 6,
            child: Center(
              child: Text(
                AppStrings.splashText,
                textAlign: TextAlign.center,

                style: AppStyles.splashText(context),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            right: 75,
            left: 75,
            child: CustomButton(
              title: AppStrings.getStarted,
              onPressed: () {
                final userId = instance<CacheHelper>().getData(key: "login");
                if (userId != null) {
                  replacementNavigation(
                    context,
                    BlocProvider.value(
                      value: context.read<HomeCubit>()
                        ..getLoggedUser(context, userId)
                        ..loadFolders(userId),

                      child: MainScreen(),
                    ),
                    Duration(seconds: AppConstants.pageDuration),
                  );
                } else {
                  replacementNavigation(
                    context,
                    AuthScreen(),
                    Duration(seconds: AppConstants.pageDuration),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MyCustomPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path whitePath = Path()
      ..moveTo(size.width - 150, size.height)
      ..quadraticBezierTo(
        size.width - 50,
        size.height - 50,
        size.width,
        size.height - 100,
      )
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawPath(whitePath, Paint()..color = AppColors.white);
    Path orangePath = Path()
      ..moveTo(size.width - 150, size.height)
      ..quadraticBezierTo(
        size.width - 75,
        size.height - 75,
        size.width - 50,
        size.height - 125,
      )
      ..quadraticBezierTo(
        size.width - 50,
        size.height - 125,
        size.width,
        size.height - 100,
      )
      ..quadraticBezierTo(
        size.width - 50,
        size.height - 50,
        size.width - 150,
        size.height,
      )
      ..close();

    canvas.drawPath(orangePath, Paint()..color = AppColors.paperColor);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
