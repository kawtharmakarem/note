import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/utils/app_constants.dart';
import '/core/utils/app_styles.dart';
import '/core/utils/functions.dart';
import '/features/home/cubit/home_cubit.dart';
import '/features/splash/presentation/components/custom_button.dart';
import '/features/splash/presentation/screens/splash_screen.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text("AccountPage", style: AppStyles.splashText(context)),
        ),
        CustomButton(
          title: "Logout",
          onPressed: () {
            context.read<HomeCubit>().logout(context);
            replacementNavigation(
              context,
              SplashScreen(),
              Duration(seconds: AppConstants.splashDuration),
            );
          },
        ),
      ],
    );
  }
}
