import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/common_widgets/custom_card.dart';
import '/core/common_widgets/social_button.dart';
import '/core/utils/app_assets.dart';
import '/core/utils/app_colors.dart';
import '/core/utils/app_strings.dart';
import '/core/utils/app_styles.dart';
import '/features/auth/cubit/auth_cubit.dart';
import '/features/splash/presentation/components/custom_button.dart';

import '../../../../core/common_widgets/custom_text_feild.dart';

class LoginWidget extends StatelessWidget {
  LoginWidget({super.key});
  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return CustomCard(child: loginWidgetContent(context, cubit));
  }

  Widget loginWidgetContent(BuildContext context, AuthCubit cubit) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: loginKey,
      child: Column(
        children: [
          Text(
            textAlign: TextAlign.center,
            AppStrings.loginTitle,
            style: AppStyles.semiBold(context, 20),
          ),
          SizedBox(height: size.height * 0.05),
          CustomTextFeild(
            hintText: AppStrings.name,
            labelText: AppStrings.name,
            controller: cubit.loginUserNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppStrings.emailRequired;
              }
              return null;
            },
          ),
          SizedBox(height: size.height * 0.03),
          CustomTextFeild(
            controller: cubit.loginPasswordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppStrings.passwordRequired;
              }

              return null;
            },
            obscureText: cubit.obsecureText,
            hintText: AppStrings.password,
            labelText: AppStrings.password,
            suffixIcon: IconButton(
              onPressed: cubit.toggleObsecure,
              icon: Icon(
                !cubit.obsecureText ? Icons.visibility : Icons.visibility_off,
              ),
            ),
          ),
          SizedBox(height: size.height * 0.001),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    value: cubit.checkboxValue,
                    activeColor: AppColors.splashColor,
                    onChanged: (value) => cubit.toggleCheckBoxValue(value!),
                  ),
                  Text(
                    AppStrings.rememberMe,
                    style: AppStyles.regular(context, 14),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  AppStrings.forgotPassword,
                  style: AppStyles.medium(context, 14),
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.03),
          CustomButton(
            title: AppStrings.login,
            onPressed: () {
              if (loginKey.currentState!.validate()) {
                cubit.login();
              }
            },
          ),
          SizedBox(height: size.height * 0.01),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: AppStrings.noAccount,
                  style: AppStyles.regular(context, 14),
                ),
                TextSpan(
                  text: AppStrings.register,
                  style: AppStyles.bold(context, 14),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      cubit.toggle();
                    },
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.05),

          Row(
            children: [
              Expanded(child: Divider()),
              Text(AppStrings.signIn, style: AppStyles.regular(context, 14)),
              Expanded(child: Divider()),
            ],
          ),
          SizedBox(height: size.height * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SocialButton(
                icon: AppAssets.google,
                onTap: () {
                  cubit.openUrl('https://www.google.com');
                },
              ),
              SocialButton(
                icon: AppAssets.facebook,
                onTap: () {
                  cubit.openUrl('https://www.facebook.com');
                },
              ),
              SocialButton(
                icon: AppAssets.apple,
                onTap: () {
                  cubit.openUrl('https://www.instagram.com');
                },
              ),
            ],
          ),
          SizedBox(height: size.height * 0.02),
        ],
      ),
    );
  }
}
