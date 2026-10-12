import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/cache/cache_helper.dart';
import '/core/database/sqflite_repository.dart';
import '/core/services/services_locator.dart';
import '/features/auth/cubit/auth_cubit.dart';
import '/features/auth/cubit/auth_state.dart';
import '/features/auth/data/models/user.dart';
import '/features/home/cubit/home_state.dart';
import '/features/home/data/models/folder_model.dart';
import '/features/home/presentation/components/account_page.dart';
import '/features/home/presentation/components/home_page.dart';
import '/features/home/presentation/components/order_page.dart';

import '../../../core/utils/app_colors.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._sqfliteRepository, AuthCubit authCubit)
    : super(HomeInitial()) {
    _authSub = authCubit.stream.listen(_onAuthChanged);
  }
  late final StreamSubscription _authSub;
  final SqfliteRepository _sqfliteRepository;

  User? loggedUser;
  int? notesCount;

  List<FolderModel> folders = [];

  //addFolder
  TextEditingController folderNameController = TextEditingController();
  final ScrollController folderController = ScrollController();
  int selectedColorIndex = 0;
  int folderIndex = 0;
  int bottomBarIndex = 0;

  void _onAuthChanged(AuthState state) {
    if (state is GetLoggedUserSuccessState) {
      _handleAuthenticatedUser(state.loggedUser);
    }
    if (state is LoginSuccessfullyState) {
      _handleAuthenticatedUser(state.user);
    }

    if (state is UnAuthenticatedState) {
      clearUser();
    }
  }

  void _handleAuthenticatedUser(User user) async {
    loggedUser = user;
    emit(HomeUserLoadedState());
  }

  void clearUser() {
    loggedUser = null;

    emit(HomeInitial());
  }

  void getLoggedUser(BuildContext context, int userId) {
    context.read<AuthCubit>().getLoggedUser(userId);
  }

  @override
  Future<void> close() {
    _authSub.cancel();
    return super.close();
  }

  //changeCategoryIndex
  void changeFolderIndex(int index) {
    folderIndex = index;
    emit(ChangeFolderIndex());
  }

  Widget getPage(int index) {
    switch (index) {
      case 0:
        return HomePage();
      case 1:
        return OrderPage();
      case 2:
        return AccountPage();
      default:
        return HomePage();
    }
  }

  IconData getIcon(int index) {
    switch (index) {
      case 0:
        return Icons.home_filled;
      case 1:
        return Icons.list_alt;
      case 2:
        return Icons.person_2_outlined;
      default:
        return Icons.home_filled;
    }
  }

  Color getColor(int index) {
    switch (index) {
      case 0:
        return Colors.greenAccent;
      case 1:
        return Colors.amber;
      case 2:
        return Colors.blueGrey;
      case 3:
        return AppColors.splashColor;
      case 4:
        return Colors.purpleAccent;
      case 5:
        return Colors.blueAccent;
      default:
        return Colors.blue;
    }
  }

  void selectColor(int index) {
    selectedColorIndex = index;
    emit(ColorSelectedState());
  }

  void togglePage(int pageIndex) {
    bottomBarIndex = pageIndex;
    emit(TogglePageState());
  }

  Future<void> loadFolders(int userId) async {
    emit(FoldersLoading());
    try {
      List<FolderModel> result = await _sqfliteRepository.getAllFolders(userId);
      if (result.isEmpty) {
        await _sqfliteRepository.insertDefaultFoldersForUser(userId);
        result = await _sqfliteRepository.getAllFolders(userId);
      }
      folders = result;

      emit(FoldersLoaded(folders: result));
    } catch (e) {
      emit(FoldersError(errMessage: e.toString()));
    }
  }

  //insertNewfolder
  // Future<void> insertFolder(int? userId) async {
  //   if (userId == null) return;
  //   final name = folderNameController.text.trim();
  //   if (name.isEmpty) return;
  //   if (folders
  //       .map((e) => e.folderName.trim().toLowerCase())
  //       .contains(name.toLowerCase())) {
  //     throw Exception("This Folder is Existed");
  //   }

  //   emit(InsertFolderLoading());
  //   try {
  //     final bool result = await _sqfliteRepository.insertNewFolder(
  //       FolderModel(
  //         folderName: name,
  //         folderColor: getColor(selectedColorIndex).toARGB32(),
  //         userId: userId,
  //       ),
  //     );
  //     if (result) {
  //       await loadFolders(userId);
  //       final index = folders.indexWhere((f) => f.folderName == name);
  //       if (index != -1) {
  //         changeFolderIndex(index);
  //       }
  //       emit(InsertFolderSuccess());
  //     } else {
  //       emit(InsertFolderError(errMessage: "Some this went error"));
  //     }
  //   } catch (e) {
  //     emit(InsertFolderError(errMessage: e.toString()));
  //   }
  // }

  Future<void> insertNewFolder(int? userId, String? name, int? color) async {
    if (userId == null || color == null || name == null) return;
    //name = folderNameController.text.trim();
    if (name.isEmpty) return;
    if (folders
        .map((e) => e.folderName.trim().toLowerCase())
        .contains(name.toLowerCase())) {
      throw Exception("This Folder is Existed");
    }

    emit(InsertFolderLoading());
    try {
      final bool result = await _sqfliteRepository.insertNewFolder(
        FolderModel(folderName: name, folderColor: color, userId: userId),
      );
      if (result) {
        await loadFolders(userId);
        final index = folders.indexWhere((f) => f.folderName == name);
        if (index != -1) {
          changeFolderIndex(index);
        }
        emit(InsertFolderSuccess());
      } else {
        emit(InsertFolderError(errMessage: "Some this went error"));
      }
    } catch (e) {
      emit(InsertFolderError(errMessage: e.toString()));
    }
  }

  void logout(BuildContext context) {
    instance<CacheHelper>().clearData();
    context.read<AuthCubit>().logout();
  }
}
