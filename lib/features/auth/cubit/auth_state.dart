import '../data/models/user.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthToggleState extends AuthState {}

//login
final class LoginObsecureState extends AuthState {}

final class LoginCheckboxValueState extends AuthState {}

final class OpenUrlState extends AuthState {
  final String message;
  OpenUrlState({this.message = ""});
}

//register
final class RegisterObsecureState extends AuthState {}

final class RegisterConfirmObsecureState extends AuthState {}

//pickImage

final class ProfileLoadingState extends AuthState {}

final class ProfileImageSavedState extends AuthState {
  final String imagePath;
  ProfileImageSavedState({this.imagePath = ""});
}

final class ProfileErrorState extends AuthState {
  final String errorMessage;

  ProfileErrorState({required this.errorMessage});
}

final class GetProfileLoadingState extends AuthState {}

final class GetProfileLoadedState extends AuthState {
  final String? imagePath;
  GetProfileLoadedState({this.imagePath});
}

final class GetProfileErrorState extends AuthState {
  final String errMessage;

  GetProfileErrorState({required this.errMessage});
}

//registe
final class RegisterLoadingState extends AuthState {}

final class RegisterSuccessState extends AuthState {}

final class RegisterFailureState extends AuthState {
  final String errMessage;

  RegisterFailureState({required this.errMessage});
}

//login
final class LoginLoadingState extends AuthState {}

final class LoginSuccessfullyState extends AuthState {
  final User user;

  LoginSuccessfullyState({required this.user});
}

final class LoginFailureState extends AuthState {
  final String errMessage;

  LoginFailureState({required this.errMessage});
}

//getLoggedUser
final class GetLoggedUserLoadingState extends AuthState {}

final class GetLoggedUserSuccessState extends AuthState {
  final User loggedUser;

  GetLoggedUserSuccessState({required this.loggedUser});
}

final class GetUserFailureState extends AuthState {
  final String errMessage;

  GetUserFailureState({required this.errMessage});
}

final class UnAuthenticatedState extends AuthState {}

//load default folders
final class DefaultFoldersLoading extends AuthState {}

final class DefaultFoldersSuccess extends AuthState {}

final class DefaultFoldersError extends AuthState {
  final String errMessage;

  DefaultFoldersError({required this.errMessage});
}
