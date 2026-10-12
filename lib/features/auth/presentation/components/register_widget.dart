import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/common_widgets/custom_card.dart';
import '/features/auth/cubit/auth_cubit.dart';
import '/features/auth/presentation/components/profile_widget.dart';

import '../../../../core/common_widgets/custom_text_feild.dart';
import '../../../../core/common_widgets/social_button.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../splash/presentation/components/custom_button.dart';

class RegisterWidget extends StatelessWidget {
  RegisterWidget({super.key});
  final GlobalKey<FormState> registerKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cubit = context.read<AuthCubit>();

    return CustomCard(
      child: Form(
        key: registerKey,
        child: Column(
          children: [
            Text(
              textAlign: TextAlign.center,
              AppStrings.registerTitle,
              style: AppStyles.semiBold(context, 20),
            ),
            SizedBox(height: size.height * 0.01),
            ProfileWidget(
              image: cubit.img,
              onClick: (source) => cubit.pickImage(source),
            ),

            SizedBox(height: size.height * 0.01),
            CustomTextFeild(
              controller: cubit.registerUsernameController,
              hintText: AppStrings.name,
              labelText: AppStrings.name,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppStrings.usernameRequired;
                }
                return null;
              },
            ),
            SizedBox(height: size.height * 0.01),

            CustomTextFeild(
              hintText: AppStrings.emailHint,
              labelText: AppStrings.email,
              controller: cubit.registerEmailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppStrings.emailRequired;
                }
                return null;
              },
            ),
            SizedBox(height: size.height * 0.01),
            CustomTextFeild(
              controller: cubit.registerPasswordController,
              obscureText: cubit.obsecureRegisterText,
              hintText: AppStrings.password,
              labelText: AppStrings.password,
              suffixIcon: IconButton(
                onPressed: cubit.toggleRegisterObsecure,
                icon: Icon(
                  !cubit.obsecureRegisterText
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppStrings.passwordRequired;
                }
                if (value.length < 6) {
                  return AppStrings.passwordLengthRequired;
                }
                return null;
              },
            ),
            SizedBox(height: size.height * 0.01),
            CustomTextFeild(
              controller: cubit.registerConfirmController,
              validator: (value) {
                if (value != cubit.registerConfirmController.text.trim()) {
                  return AppStrings.confirmPassword;
                }
                return null;
              },
              obscureText: cubit.obsecureConfirmText,
              hintText: AppStrings.confirm,
              labelText: AppStrings.confirm,
              suffixIcon: IconButton(
                onPressed: () {
                  cubit.toggleConfirmObsecure();
                },
                icon: Icon(
                  !cubit.obsecureConfirmText
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
              ),
            ),

            SizedBox(height: size.height * 0.02),
            CustomButton(
              title: AppStrings.register,
              onPressed: () {
                if (registerKey.currentState!.validate()) {
                  cubit.register();
                }
              },
            ),
            SizedBox(height: size.height * 0.01),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: AppStrings.haveAccount,
                    style: AppStyles.regular(context, 14),
                  ),
                  TextSpan(
                    text: AppStrings.login,
                    style: AppStyles.bold(context, 14),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        cubit.toggle();
                      },
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.02),

            Row(
              children: [
                Expanded(child: Divider()),
                Text(AppStrings.signIn, style: AppStyles.regular(context, 14)),
                Expanded(child: Divider()),
              ],
            ),
            //SizedBox(height: size.height * 0.01),
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
          ],
        ),
      ),
    );
  }
}
