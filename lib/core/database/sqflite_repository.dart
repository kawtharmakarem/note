import 'dart:io';

import '/core/database/sqflite_helper.dart';
import '/core/database/tables.dart';
import '/core/services/services_locator.dart';
import '/features/auth/data/models/user.dart';
import '/features/details/data/models/blog_model.dart';
import '/features/details/data/models/note_model.dart';
import '/features/details/data/models/todo_model.dart';
import '/features/home/data/models/folder_model.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../utils/app_colors.dart';

class SqfliteRepository {
  final DBHelper dbHelper = instance<DBHelper>();

  //login
  Future<User?> login(User user) async {
    final db = await dbHelper.getDB();

    List<Map<String, dynamic>> result = await db.query(
      Tables.tableUsers,
      where: 'username = ? AND password = ?',
      whereArgs: [user.username, user.password],
      limit: 1,
    );
    if (result.isNotEmpty) {
      return User.fromJson(result.first);
    }
    return null;
  }

  //register
  Future<int> register(User user) async {
    final db = await dbHelper.getDB();
    final existing = await db.query(
      Tables.tableUsers,
      where: 'username = ?',
      whereArgs: [user.username],
      limit: 1,
    );
    if (existing.isNotEmpty) {
      throw Exception("User with ${user.username} is already exists!");
    }
    return await db.insert(
      Tables.tableUsers,
      user.toJson(),
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  //getLoggedUser
  Future<User> getLoggedUser(int userId) async {
    final db = await dbHelper.getDB();
    final result = await db.query(
      Tables.tableUsers,
      where: 'userId = ?',
      whereArgs: [userId],
      limit: 1,
    );
    if (result.isNotEmpty) {
      return User.fromJson(result.first);
    } else {
      throw Exception("User with $userId is not found");
    }
  }

  //save image
  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');
    return File(imagePath).copy(image.path);
  }

  Future<String?> getProfileImage(int userId) async {
    final db = await dbHelper.getDB();
    final result = await db.query(
      Tables.tableUsers,
      where: 'userId = ?',
      whereArgs: [userId],
      limit: 1,
    );
    if (result.isNotEmpty) {
      return result.first['imagePath'] as String?;
    }
    return null;
  }

  Future<void> insertDefaultFoldersForUser(int userId) async {
    final db = await dbHelper.getDB();
    List<String> defaultFolders = ["Folders", "Notes", "ToDo", "Blogs"];
    for (String folder in defaultFolders) {
      await db.insert(Tables.tableFolders, {
        "folderName": folder,
        "folderColor": getColor(folder),
        "userId": userId,
      }, conflictAlgorithm: ConflictAlgorithm.ignore);
    }
  }

  Future<List<FolderModel>> getAllFolders(int userId) async {
    final db = await dbHelper.getDB();
    final result = await db.query(
      Tables.tableFolders,
      where: "userId = ?",
      whereArgs: [userId],
    );
    return result.map((folder) => FolderModel.fromJson(folder)).toList();
  }

  //insert new folder
  Future<bool> insertNewFolder(FolderModel folder) async {
    final db = await dbHelper.getDB();
    final int result = await db.insert(
      Tables.tableFolders,
      folder.toJson(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
    return result > 0;
  }

  //note methods
  Future<int> addNewNote(NoteModel note) async {
    final db = await dbHelper.getDB();
    return await db.insert(Tables.tableNotes, note.toJson());
  }

  Future<List<Map<String, dynamic>>> getAllNotes(
    int userId,
    int folderId,
  ) async {
    final db = await dbHelper.getDB();
    List<Map<String, dynamic>> result = await db.query(
      Tables.tableNotes,
      where: 'userId = ? AND folderId = ?',
      whereArgs: [userId, folderId],
      orderBy: 'noteId DESC',
    );
    return result;
  }

  Future<int> updateNoteState(NoteModel note) async {
    final db = await dbHelper.getDB();
    return await db.rawUpdate(
      "UPDATE ${Tables.tableNotes} SET isCompleted=1 WHERE noteId = ?",
      [note.noteId],
    );
  }

  Future<bool> deleteNote(int noteId) async {
    final db = await dbHelper.getDB();
    final int result = await db.delete(
      Tables.tableNotes,
      where: "noteId = ?",
      whereArgs: [noteId],
    );
    return result > 0;
  }

  Future<bool> updateNote(NoteModel note) async {
    final db = await dbHelper.getDB();
    final int result = await db.update(
      Tables.tableNotes,
      note.toJson(),
      where: 'noteId = ?',
      whereArgs: [note.noteId],
    );
    return result > 0;
  }

  Future<int> getNotesCount(int userId) async {
    final db = await dbHelper.getDB();
    final List<Map<String, dynamic>> result = await db.rawQuery(
      "SELECT COUNT(*) FROM ${Tables.tableNotes} WHERE userId = ? ",
      [userId],
    );
    return Sqflite.firstIntValue(result) ?? 0;
  }

  //blogs model
  Future<int> getBlogsCount(int userId) async {
    final db = await dbHelper.getDB();
    final List<Map<String, dynamic>> result = await db.rawQuery(
      "SELECT COUNT(*) FROM ${Tables.tableBlogs} WHERE userId = ?",
      [userId],
    );
    return Sqflite.firstIntValue(result) ?? 0;
  }

  //getTodos Count
  Future<int> getTodosCount(int userId) async {
    final db = await dbHelper.getDB();
    final List<Map<String, dynamic>> result = await db.rawQuery(
      "SELECT COUNT(*) FROM ${Tables.tableTodo} WHERE userId = ?",
      [userId],
    );
    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<int> insertNewBlog(BlogModel blogModel) async {
    final db = await dbHelper.getDB();
    final int result = await db.insert(Tables.tableBlogs, blogModel.toJson());
    return result;
  }

  Future<List<Map<String, dynamic>>> getAllBlogs(
    int userId,
    int folderId,
  ) async {
    final db = await dbHelper.getDB();
    final List<Map<String, dynamic>> result = await db.query(
      Tables.tableBlogs,
      where: 'userId = ? AND folderId = ?',
      whereArgs: [userId, folderId],
    );
    return result;
  }

  //todos
  Future<int> insertTodo(TodoModel todo) async {
    final db = await dbHelper.getDB();
    return await db.insert(Tables.tableTodo, todo.toJson());
  }

  Future<List<Map<String, dynamic>>> getAllTodos(
    int userId,
    int folderId,
  ) async {
    final db = await dbHelper.getDB();
    final List<Map<String, dynamic>> result = await db.query(
      Tables.tableTodo,
      where: 'userId = ? AND folderId = ?',
      whereArgs: [userId, folderId],
    );
    return result;
  }
}

int getColor(String folderName) {
  switch (folderName) {
    case "Folders":
      return AppColors.white70.toARGB32();
    case "Notes":
      return AppColors.lightBlue.toARGB32();
    case "ToDo":
      return AppColors.lightBrown.toARGB32();
    case "Blogs":
      return AppColors.lightGreen.toARGB32();
    default:
      return AppColors.lightBlue.toARGB32();
  }
}
