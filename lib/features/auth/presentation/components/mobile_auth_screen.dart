import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/cache/cache_helper.dart';
import '/core/functions/messsages.dart';
import '/core/utils/app_colors.dart';
import '/core/utils/app_constants.dart';
import '/core/utils/app_strings.dart';
import '/core/utils/app_styles.dart';
import '/core/utils/functions.dart';
import '/features/auth/cubit/auth_cubit.dart';
import '/features/auth/presentation/components/login_widget.dart';
import '/features/auth/presentation/components/register_widget.dart';
import '/features/home/presentation/screens/main_screen.dart';

import '../../../../core/services/services_locator.dart';
import '../../../home/cubit/home_cubit.dart';
import '../../cubit/auth_state.dart';

class MobileAuthScreen extends StatelessWidget {
  const MobileAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            showSnakMessage(context, text: AppStrings.successfullyRegisterd);
          } else if (state is RegisterFailureState) {
            showSnakMessage(context, text: state.errMessage);
          }
          if (state is LoginSuccessfullyState) {
            instance<CacheHelper>().saveData(
              key: "login",
              value: state.user.userId,
            );
            replacementNavigation(
              context,
              BlocProvider.value(
                value: context.read<HomeCubit>()
                  ..getLoggedUser(context, state.user.userId!)
                  ..loadFolders(state.user.userId!),
                // create: (context) => instance<HomeCubit>()
                //   ..getLoggedUser(context, state.user.userId!)
                //   ..loadFolders(state.user.userId!),
                child: MainScreen(),
              ),
              Duration(seconds: AppConstants.pageDuration),
            );
          } else if (state is LoginFailureState) {
            showSnakMessage(context, text: state.errMessage);
          }
        },
        builder: (context, state) {
          final cubit = context.read<AuthCubit>();
          return Container(
            width: size.width,
            height: size.height,
            color: AppColors.splashColor,
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    AppStrings.aPPTitle,
                    style: AppStyles.splashText(context),
                  ),
                  AnimatedCrossFade(
                    firstChild: LoginWidget(),
                    secondChild: RegisterWidget(),
                    crossFadeState: cubit.showFirst
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: Duration(milliseconds: 500),
                    firstCurve: Curves.easeIn,
                    secondCurve: Curves.easeOut,
                    sizeCurve: Curves.easeInOut,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
