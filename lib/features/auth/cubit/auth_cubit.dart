import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '/core/database/sqflite_repository.dart';
import '/core/utils/app_strings.dart';
import '/features/auth/data/models/user.dart';

import 'package:url_launcher/url_launcher.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._sqfliteRepository) : super(AuthInitial());
  final SqfliteRepository _sqfliteRepository;

  bool showFirst = true;
  bool obsecureText = true;
  bool obsecureConfirmText = true;
  bool obsecureRegisterText = true;
  bool checkboxValue = false;
  File? img;

  //loginFeilds
  TextEditingController loginUserNameController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  //register feild
  TextEditingController registerUsernameController = TextEditingController();
  TextEditingController registerEmailController = TextEditingController();
  TextEditingController registerPasswordController = TextEditingController();
  TextEditingController registerConfirmController = TextEditingController();

  //login
  void toggle() {
    showFirst = !showFirst;
    emit(AuthToggleState());
  }

  void toggleObsecure() {
    obsecureText = !obsecureText;
    emit(LoginObsecureState());
  }

  void toggleCheckBoxValue(bool val) {
    checkboxValue = val;
    emit(LoginCheckboxValueState());
  }

  Future<void> openUrl(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        emit(OpenUrlState(message: "Could not launch $url"));
      } else {
        emit(OpenUrlState(message: 'URL opened successfully'));
      }
    } catch (e) {
      emit(OpenUrlState(message: "Error opening URL : $e"));
    }
  }

  //register
  void toggleRegisterObsecure() {
    obsecureRegisterText = !obsecureRegisterText;
    emit(RegisterObsecureState());
  }

  void toggleConfirmObsecure() {
    obsecureConfirmText = !obsecureConfirmText;
    emit(RegisterConfirmObsecureState());
  }

  //pickImage
  Future pickImage(ImageSource source) async {
    emit(ProfileLoadingState());
    try {
      XFile? image = await ImagePicker().pickImage(source: source);
      if (image == null) {
        emit(AuthInitial());
        return;
      }
      File imagePermanent = await _sqfliteRepository.saveImagePermanently(
        image.path,
      );
      img = imagePermanent;
      log(img!.path.toString());

      emit(ProfileImageSavedState(imagePath: img!.path));
    } on PlatformException catch (e) {
      emit(ProfileErrorState(errorMessage: e.message ?? 'Image pick failed'));
    } catch (e) {
      emit(ProfileErrorState(errorMessage: e.toString()));
    }
  }

  //getProfileImage
  // Future<void> getProfileImage(int userId) async {
  //   emit(GetProfileLoadingState());
  //   try {
  //     String? imagePath = await _sqfliteRepository.getProfileImage(userId);
  //     if (imagePath == null) {
  //       emit(GetProfileLoadedState(imagePath: null));
  //       return;
  //     }
  //     emit(GetProfileLoadedState(imagePath: imagePath));
  //   } catch (e) {
  //     emit(GetProfileErrorState(errMessage: e.toString()));
  //   }
  // }

  //register method
  Future<void> register() async {
    emit(RegisterLoadingState());
    try {
      int result = await _sqfliteRepository.register(
        User(
          username: registerUsernameController.text.trim(),
          email: registerEmailController.text.trim(),

          password: registerPasswordController.text.trim(),
          imagePath: img?.path ?? "",
        ),
      );
      if (result > 0) {
        emit(RegisterSuccessState());
        await _sqfliteRepository.insertDefaultFoldersForUser(result);
        registerUsernameController.clear();
        registerEmailController.clear();
        registerPasswordController.clear();
        registerConfirmController.clear();
        img = null;
      } else {
        emit(
          RegisterFailureState(
            errMessage: "Some thing went wrong please try again later!",
          ),
        );
      }
    } catch (e) {
      emit(RegisterFailureState(errMessage: e.toString()));
    }
  }

  //login
  Future<void> login() async {
    emit(LoginLoadingState());
    try {
      final User? user = await _sqfliteRepository.login(
        User(
          username: loginUserNameController.text.trim(),
          password: loginPasswordController.text.trim(),
        ),
      );
      if (user != null) {
        emit(LoginSuccessfullyState(user: user));
        loginUserNameController.clear();
        loginPasswordController.clear();
      } else {
        emit(LoginFailureState(errMessage: AppStrings.loginError));
      }
    } catch (e) {
      emit(LoginFailureState(errMessage: e.toString()));
    }
  }

  Future<void> getLoggedUser(int userId) async {
    emit(GetLoggedUserLoadingState());
    try {
      final User logUser = await _sqfliteRepository.getLoggedUser(userId);
      emit(GetLoggedUserSuccessState(loggedUser: logUser));
    } catch (e) {
      emit(GetUserFailureState(errMessage: e.toString()));
    }
  }

  void logout() {
    emit(UnAuthenticatedState());
  }
}
