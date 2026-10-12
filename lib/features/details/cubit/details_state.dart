import '/features/details/data/models/blog_model.dart';
import '/features/details/data/models/note_model.dart';
import '/features/details/data/models/todo_model.dart';

sealed class DetailsState {}

final class DetailsInitial extends DetailsState {}

//noteStates
final class AddNoteLoadingState extends DetailsState {}

final class AddNoteSuccessState extends DetailsState {}

final class AddNoteErrorState extends DetailsState {
  final String errMessage;

  AddNoteErrorState({required this.errMessage});
}

//note color
final class SelectNoteColor extends DetailsState {}

final class DetailsLoadedUser extends DetailsState {}

//note date
final class GetNoteDateLoading extends DetailsState {}

final class GetNoteDateSuccess extends DetailsState {}

final class GetNoteDateError extends DetailsState {
  final String errMessage;

  GetNoteDateError({this.errMessage = ""});
}

//note time
final class GetNoteTimeLoading extends DetailsState {}

final class GetNoteTimeSuccess extends DetailsState {}

final class GetNoteTimeError extends DetailsState {
  final String errMessage;

  GetNoteTimeError({this.errMessage = ""});
}

//insertNote
final class InsertNoteLoading extends DetailsState {}

final class InsertNoteSucces extends DetailsState {
  InsertNoteSucces();
}

final class InsertNoteError extends DetailsState {
  final String errMessage;

  InsertNoteError({required this.errMessage});
}

//getAllNote
final class GetAllNotesLoading extends DetailsState {}

final class GetAllNotesSuccess extends DetailsState {
  final List<NoteModel> notes;

  GetAllNotesSuccess({required this.notes});
}

final class GetAllNotesError extends DetailsState {
  final String errMessage;

  GetAllNotesError({required this.errMessage});
}

final class DeleteNoteLoading extends DetailsState {}

final class DeleteNoteSuccess extends DetailsState {}

final class DeleteNoteError extends DetailsState {
  final String errMessage;

  DeleteNoteError({required this.errMessage});
}

final class CountNotesLoading extends DetailsState {}

final class CountNotesSuccess extends DetailsState {
  final int count;

  CountNotesSuccess({required this.count});
}

final class CountNotesError extends DetailsState {
  final String errMessage;

  CountNotesError({required this.errMessage});
}

final class DetailsLoadedFolders extends DetailsState {}

final class ChangeFolderColorIndex extends DetailsState {}

final class DetailUserLoaded extends DetailsState {}

//blgs
final class InsertBlogLoading extends DetailsState {}

final class InsertBlogSuccess extends DetailsState {
  InsertBlogSuccess();
}

final class InsertBlogError extends DetailsState {
  final String errMessage;

  InsertBlogError({required this.errMessage});
}

final class BlogDateLoading extends DetailsState {}

final class BlogDateSuccess extends DetailsState {}

final class BlogDateError extends DetailsState {
  final String errMessage;

  BlogDateError({required this.errMessage});
}

final class BlogTimeLoading extends DetailsState {}

final class BlogTimeSuccess extends DetailsState {}

final class BlogTimeError extends DetailsState {
  final String errMessage;

  BlogTimeError({required this.errMessage});
}

final class GetAllBlogsLoading extends DetailsState {}

final class GetAllBlogsSuccess extends DetailsState {
  final List<BlogModel> blogs;

  GetAllBlogsSuccess({required this.blogs});
}

final class GetAllBlogsError extends DetailsState {
  final String errMessage;

  GetAllBlogsError({required this.errMessage});
}

final class BlogCountLoading extends DetailsState {}

final class BlogCountSuccess extends DetailsState {
  final int count;

  BlogCountSuccess({required this.count});
}

final class BlogCountError extends DetailsState {
  final String errMessage;

  BlogCountError({required this.errMessage});
}

final class TodoCountLoading extends DetailsState {}

final class TodoCountSuccess extends DetailsState {
  final int count;

  TodoCountSuccess({required this.count});
}

final class TodoCountError extends DetailsState {
  final String errMessage;

  TodoCountError({required this.errMessage});
}

final class GetTodoDateLoading extends DetailsInitial {}

final class GetTodoDateSuccess extends DetailsInitial {}

final class GetTodoDateError extends DetailsInitial {
  final String errMessage;

  GetTodoDateError({required this.errMessage});
}

final class GetTodoTimeLoading extends DetailsState {}

final class GetTodoTimeSuccess extends DetailsState {}

final class GetTodoTimeError extends DetailsState {
  final String errMessage;

  GetTodoTimeError({required this.errMessage});
}

final class InsertTodoLoading extends DetailsState {}

final class InsertTodoSuccess extends DetailsState {}

final class InsertTodoError extends DetailsState {
  final String errMessage;

  InsertTodoError({required this.errMessage});
}

final class GetAllTodosLoading extends DetailsState {}

final class GetAllTodosSuccess extends DetailsState {
  final List<TodoModel> todos;

  GetAllTodosSuccess({required this.todos});
}

final class GetAllTodosError extends DetailsState {
  final String errMessage;

  GetAllTodosError({required this.errMessage});
}
