import '../data/models/folder_model.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class TogglePageState extends HomeState {}

//categoryIndex
final class ChangeFolderIndex extends HomeState {}

//Get User
final class HomeUserLoadedState extends HomeState {}

//loadFolders
final class FoldersLoading extends HomeState {}

final class FoldersLoaded extends HomeState {
  final List<FolderModel> folders;

  FoldersLoaded({required this.folders});
}

final class FoldersError extends HomeState {
  final String errMessage;

  FoldersError({required this.errMessage});
}

final class InsertFolderLoading extends HomeState {}

final class InsertFolderSuccess extends HomeState {}

final class InsertFolderError extends HomeState {
  final String errMessage;

  InsertFolderError({required this.errMessage});
}

//getCurrentFolder

final class ColorSelectedState extends HomeState {}

final class FoldersUpdateState extends HomeState {}

final class HomeNoteCountState extends HomeState {}
