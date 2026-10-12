import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '/core/database/sqflite_repository.dart';
import '/core/services/local_notification_services.dart';
import '/core/utils/app_colors.dart';
import '/features/auth/cubit/auth_cubit.dart';
import '/features/auth/cubit/auth_state.dart';
import '/features/details/cubit/details_state.dart';
import '/features/details/data/models/blog_model.dart';
import '/features/details/data/models/note_model.dart';
import '/features/home/cubit/home_cubit.dart';
import '/features/home/data/models/folder_model.dart';

import '../../auth/data/models/user.dart';
import '../../home/cubit/home_state.dart';
import '../data/models/todo_model.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit(
    this._sqfliteRepository,
    AuthCubit authCubit,
    HomeCubit homeCubit,
  ) : super(DetailsInitial()) {
    _authSub = authCubit.stream.listen(_onAuthChanges);
    _homeSub = homeCubit.stream.listen(_onHomeChanges);
  }

  final SqfliteRepository _sqfliteRepository;
  late final StreamSubscription _authSub;
  late final StreamSubscription _homeSub;
  //for folder inset
  int folderColorIndex = 0;
  User? loggedUser;

  int noteColorIndex = 0;
  List<NoteModel> notes = [];
  List<BlogModel> blogs = [];
  List<TodoModel> todos = [];
  int notesCount = 0;
  int blogsCount = 0;
  int todosCount = 0;

  TextEditingController addFolderNameController = TextEditingController();
  //notes
  TextEditingController noteTitleController = TextEditingController();
  TextEditingController noteContentController = TextEditingController();
  TextEditingController noteDateController = TextEditingController();
  TextEditingController noteTimeController = TextEditingController();
  //blogs
  TextEditingController blogTitleController = TextEditingController();
  TextEditingController blogContentController = TextEditingController();
  TextEditingController blogDateController = TextEditingController();
  TextEditingController blogTimeController = TextEditingController();
  //todos
  TextEditingController todoTitleController = TextEditingController();
  TextEditingController todoContentController = TextEditingController();
  TextEditingController todoDateController = TextEditingController();
  TextEditingController todoTimeController = TextEditingController();

  DateTime noteCurrentDate = DateTime.now();
  DateTime blogCurrentDate = DateTime.now();
  DateTime todoCurrentDate = DateTime.now();

  String noteTime = DateFormat("hh:mm a").format(DateTime.now());
  String blogTime = DateFormat("hh:mm a").format(DateTime.now());
  String todoTime = DateFormat("hh:mm a").format(DateTime.now());

  List<FolderModel> loadedFolders = [];

  @override
  Future<void> close() {
    _authSub.cancel();
    _homeSub.cancel();
    return super.close();
  }

  void _onAuthChanges(AuthState state) {
    if (state is LoginSuccessfullyState) {
      loggedUser = state.user;
      emit(DetailUserLoaded());
    }
    if (state is GetLoggedUserSuccessState) {
      loggedUser = state.loggedUser;
      emit(DetailUserLoaded());
    }
    if (state is UnAuthenticatedState) {
      clearUser();
    }
  }

  void clearUser() {
    loggedUser = null;
    emit(DetailsInitial());
  }

  void getLoggedUser(BuildContext context, int userId) {
    context.read<AuthCubit>().getLoggedUser(userId);
  }

  void _onHomeChanges(HomeState state) {
    if (state is FoldersLoaded) {
      loadedFolders = state.folders;
      emit(DetailsLoadedFolders());
    }
  }

  void loadFolders(BuildContext context, int userId) {
    context.read<HomeCubit>().loadFolders(userId);
  }

  void addNewFolder(
    BuildContext context,
    int? userId,
    int? color,
    String? name,
  ) {
    if (userId == null || color == null || name == null) return;
    context.read<HomeCubit>().insertNewFolder(userId, name, color);
  }

  Color getFolderColor(int index) {
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

  void changeFolderColorIndex(int index) {
    folderColorIndex = index;
    emit(ChangeFolderColorIndex());
  }

  //note methods
  Color getNoteColor(int index) {
    switch (index) {
      case 0:
        return AppColors.blueNote;
      case 1:
        return AppColors.orangeNote;
      case 2:
        return AppColors.accentGreenNote;
      case 3:
        return AppColors.greenNote;
      case 4:
        return AppColors.purpleNote;
      case 5:
        return AppColors.accentOrangeNote;

      default:
        return AppColors.splashColor;
    }
  }

  void selectColorIndex(int index) {
    noteColorIndex = index;
    emit(SelectNoteColor());
  }

  late TimeOfDay scheduledTime;
  void getNoteDate(BuildContext context) async {
    emit(GetNoteDateLoading());
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2028),
    );
    if (pickedDate != null) {
      noteCurrentDate = pickedDate;
      noteDateController.text = DateFormat.yMMMd().format(noteCurrentDate);
      emit(GetNoteDateSuccess());
    } else {
      emit(GetNoteDateError());
    }
  }

  void getBlogDate(BuildContext context) async {
    emit(BlogDateLoading());
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2028),
    );
    if (pickedDate != null) {
      blogCurrentDate = pickedDate;
      blogDateController.text = DateFormat.yMMMd().format(blogCurrentDate);
      emit(BlogDateSuccess());
    } else {
      emit(BlogDateError(errMessage: "Some thing went wrong"));
    }
  }

  void getTodoDate(BuildContext context) async {
    emit(GetTodoDateLoading());
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2028),
    );
    if (pickedDate != null) {
      todoCurrentDate = pickedDate;
      todoDateController.text = DateFormat.yMMMd().format(todoCurrentDate);
      emit(GetTodoDateSuccess());
    } else {
      emit(GetTodoDateError(errMessage: "Some thing went wrong !"));
    }
  }

  void getTime(BuildContext context) async {
    emit(GetNoteTimeLoading());
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,

      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    );
    if (pickedTime != null) {
      noteTime = pickedTime.format(context);
      noteTimeController.text = noteTime;
      scheduledTime = pickedTime;
      emit(GetNoteDateSuccess());
    } else {
      scheduledTime = TimeOfDay(
        hour: noteCurrentDate.hour,
        minute: noteCurrentDate.minute,
      );
      emit(GetNoteTimeError());
    }
  }

  void getBlogTime(BuildContext context) async {
    emit(BlogTimeLoading());
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    );
    if (pickedTime != null) {
      blogTime = pickedTime.format(context);
      blogTimeController.text = blogTime;
      emit(BlogTimeSuccess());
    } else {
      emit(BlogTimeError(errMessage: "some thing went error"));
    }
  }

  void getTodoTime(BuildContext context) async {
    emit(GetTodoTimeLoading());
    TimeOfDay? pickedtime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    );
    if (pickedtime != null) {
      todoTime = pickedtime.format(context);
      todoTimeController.text = todoTime;
      emit(GetTodoDateSuccess());
    } else {
      emit(GetTodoTimeError(errMessage: "Some thing went wrong !"));
    }
  }

  //insertnewnote
  Future<void> insertNote(int? folderId, int? userId) async {
    if (userId == null || folderId == null) return;
    emit(InsertNoteLoading());
    try {
      final newNote = NoteModel(
        noteTitle: noteTitleController.text.trim(),
        noteContent: noteContentController.text.trim(),
        noteColor: getNoteColor(noteColorIndex).toARGB32(),
        noteDate: DateFormat.yMMMd().format(noteCurrentDate),
        noteTime: noteTime,
        folderId: folderId,
        userId: userId,
      );
      final int noteId = await _sqfliteRepository.addNewNote(newNote);
      if (noteId > 0) {
        emit(InsertNoteSucces());

        final DateTime? scheduledDateTime = buildScheduledDateTime(
          noteDateController.text.trim(),
          noteTimeController.text.trim(),
        );
        if (scheduledDateTime == null ||
            scheduledDateTime.isBefore(DateTime.now())) {
          return;
        }
        final insertedNote = newNote.copyWith(noteId: noteId);
        await showScheduledNotification(
          scheduledDateTime,
          insertedNote.noteId,
          insertedNote.noteTitle,
          insertedNote.noteContent,
        );
        await getAllNotes(folderId, userId);

        noteTitleController.clear();
        noteContentController.clear();
        noteDateController.clear();
        noteTimeController.clear();
        noteColorIndex = 0;
      } else {
        emit(InsertNoteError(errMessage: "Some thing went wrong !"));
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(InsertNoteError(errMessage: e.toString()));
    }
  }

  Future<void> getAllNotes(int? folderId, int? userId) async {
    if (userId == null || folderId == null) return;
    emit(GetAllNotesLoading());
    try {
      final List<Map<String, dynamic>> value = await _sqfliteRepository
          .getAllNotes(userId, folderId);
      final List<NoteModel> fetchNotes = value
          .map((e) => NoteModel.fromJson(e))
          .toList();
      notes = List.from(fetchNotes);
      emit(GetAllNotesSuccess(notes: notes));
    } catch (e) {
      emit(GetAllNotesError(errMessage: e.toString()));
    }
  }

  Future<void> deleteNote(NoteModel note) async {
    if (note.noteId == null) return;
    emit(DeleteNoteLoading());
    try {
      final bool result = await _sqfliteRepository.deleteNote(note.noteId!);
      if (result) {
        await getAllNotes(note.folderId, note.userId);
        emit(DeleteNoteSuccess());
      } else {
        emit(DeleteNoteError(errMessage: "Something went error!"));
      }
    } catch (e) {
      emit(DeleteNoteError(errMessage: e.toString()));
    }
  }

  Future<void> getNotesCount(int? userId) async {
    if (userId == null) return;
    emit(CountNotesLoading());
    try {
      final int result = await _sqfliteRepository.getNotesCount(userId);
      notesCount = result;
      emit(CountNotesSuccess(count: result));
    } catch (e) {
      emit(CountNotesError(errMessage: e.toString()));
    }
  }

  Future<void> getBlogsCount(int? userId) async {
    if (userId == null) return;
    emit(BlogCountLoading());
    try {
      final int result = await _sqfliteRepository.getBlogsCount(userId);
      blogsCount = result;
      emit(BlogCountSuccess(count: blogsCount));
    } catch (e) {
      emit(BlogCountError(errMessage: e.toString()));
    }
  }

  Future<void> getTodosCount(int? userId) async {
    if (userId == null) return;
    emit(TodoCountLoading());
    try {
      final int result = await _sqfliteRepository.getTodosCount(userId);
      todosCount = result;
      emit(TodoCountSuccess(count: todosCount));
    } catch (e) {
      emit(TodoCountError(errMessage: e.toString()));
    }
  }

  DateTime? buildScheduledDateTime(String date, String time) {
    if (date.isEmpty || time.isEmpty) {
      return null;
    }
    try {
      DateTime mydate = DateFormat.yMMMd().parse(date);
      DateTime mytime = DateFormat.jm().parse(time);
      return DateTime(
        mydate.year,
        mydate.month,
        mydate.day,
        mytime.hour,
        mytime.minute,
      );
    } catch (e) {
      debugPrint("Scehdualed date error $e");
      return null;
    }
  }

  Future<void> showScheduledNotification(
    DateTime scheduledDateTime,
    int? id,
    String title,
    String content,
  ) async {
    if (id == null) return;

    if (scheduledDateTime.isBefore(DateTime.now())) return;
    try {
      await LocalNotificationServices.showScheduledNotification(
        id: id,
        title: title,
        content: content,
        scheduledDateTime: scheduledDateTime,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  int getCount(String folderName) {
    switch (folderName) {
      case "Notes":
        return notesCount;
      case "ToDo":
        return todosCount;
      case "Blogs":
        return blogsCount;
      default:
        return 0;
    }
  }

  //blogs
  Future<void> insertNewBlog(int? userId, int? folderId) async {
    if (userId == null || folderId == null) return;
    emit(InsertBlogLoading());
    try {
      final newBlog = BlogModel(
        blogTitle: blogTitleController.text.trim(),
        blogContent: blogContentController.text.trim(),
        blogDate: DateFormat.yMMMd().format(blogCurrentDate),
        blogTime: blogTime,
        userId: userId,
        folderId: folderId,
      );
      final blogId = await _sqfliteRepository.insertNewBlog(newBlog);
      if (blogId > 0) {
        emit(InsertBlogSuccess());
        DateTime? scheduledDateTime = buildScheduledDateTime(
          blogDateController.text.trim(),
          blogTimeController.text.trim(),
        );
        if (scheduledDateTime == null ||
            scheduledDateTime.isBefore(DateTime.now())) {
          return;
        }
        final insertedBlog = newBlog.copyWith(blogId: blogId);
        await showScheduledNotification(
          scheduledDateTime,
          insertedBlog.blogId,
          insertedBlog.blogTitle,
          insertedBlog.blogContent,
        );
        await getAllBlogs(userId, folderId);
        blogTitleController.clear();
        blogContentController.clear();
        blogDateController.clear();
        blogTimeController.clear();
      }
    } catch (e) {
      debugPrint(e.toString());
      emit(InsertBlogError(errMessage: e.toString()));
    }
  }

  //getAllBlogs
  Future<void> getAllBlogs(int? userId, int? folderId) async {
    if (userId == null || folderId == null) return;
    emit(GetAllBlogsLoading());
    try {
      final List<Map<String, dynamic>> result = await _sqfliteRepository
          .getAllBlogs(userId, folderId);
      final List<BlogModel> fetchBlogs = result
          .map((e) => BlogModel.fromJson(e))
          .toList();
      blogs = List.from(fetchBlogs);
      emit(GetAllBlogsSuccess(blogs: blogs));
    } catch (e) {
      emit(GetAllBlogsError(errMessage: e.toString()));
    }
  }

  Future<void> insertNewTodo(int? userId, int? folderId) async {
    if (userId == null || folderId == null) return;
    emit(InsertTodoLoading());
    try {
      final newTodo = TodoModel(
        todoTitle: todoTitleController.text.trim(),
        todoContent: todoContentController.text.trim(),
        todoDate: DateFormat.yMMMd().format(todoCurrentDate),
        todoTime: todoTime,
        isCompleted: 0,
        userId: userId,
        folderId: folderId,
      );
      final int result = await _sqfliteRepository.insertTodo(newTodo);
      if (result > 0) {
        emit(InsertTodoSuccess());
        DateTime? scheduledDateTime = buildScheduledDateTime(
          todoDateController.text.trim(),
          todoTimeController.text.trim(),
        );
        if (scheduledDateTime == null ||
            scheduledDateTime.isBefore(DateTime.now())) {
          return;
        }
        final insertedTodo = newTodo.copyWith(todoId: result);
        await getAllTodos(userId, folderId);

        await showScheduledNotification(
          scheduledDateTime,
          insertedTodo.todoId,
          insertedTodo.todoTitle,
          insertedTodo.todoContent,
        );

        todoTitleController.clear();
        todoContentController.clear();
        todoDateController.clear();
        todoTimeController.clear();
      } else {
        emit(
          InsertTodoError(errMessage: "Some thing went wrong try again later"),
        );
      }
    } catch (e) {
      emit(InsertTodoError(errMessage: e.toString()));
    }
  }

  Future<void> getAllTodos(int? userId, int? folderId) async {
    if (userId == null || folderId == null) return;
    emit(GetAllTodosLoading());
    try {
      final List<Map<String, dynamic>> result = await _sqfliteRepository
          .getAllTodos(userId, folderId);
      final List<TodoModel> todosList = result
          .map((e) => TodoModel.fromJson(e))
          .toList();
      todos = List.from(todosList);
      emit(GetAllTodosSuccess(todos: todos));
    } catch (e) {
      emit(GetAllTodosError(errMessage: e.toString()));
    }
  }
}
