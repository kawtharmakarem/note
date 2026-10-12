class Tables {
  //tabels name
  static const String tableUsers = "users";
  static const String tableFolders = "folders";
  static const String tableNotes = "notes";
  static const String tableBlogs = "blogs";
  static const String tableTodo = "todos";

  //Queries
  static const userQuery =
      '''
CREATE TABLE IF NOT EXISTS $tableUsers(
userId INTEGER PRIMARY KEY AUTOINCREMENT,
username TEXT,
email TEXT,
imagePath TEXT,
password TEXT UNIQUE
)
''';
  static const folderQuery =
      '''
CREATE TABLE IF NOT EXISTS $tableFolders(
folderId INTEGER PRIMARY KEY AUTOINCREMENT,
folderName TEXT,
folderColor INTEGER,
userId INTEGER,
UNIQUE(folderName, userId),
FOREIGN KEY (userId) REFERENCES $tableUsers(userId) ON DELETE CASCADE)
''';
  static const noteQuery =
      '''
CREATE TABLE IF NOT EXISTS $tableNotes(
noteId INTEGER PRIMARY KEY AUTOINCREMENT,
noteTitle TEXT,
noteContent TEXT,
noteColor INTEGER,
noteDate TEXT,
noteTime TEXT,
folderId INTEGER,
userId INTEGER,
FOREIGN KEY (userId) REFERENCES $tableUsers(userId) ON DELETE CASCADE,
FOREIGN KEY (folderId) REFERENCES $tableFolders(folderId) ON DELETE CASCADE
)
''';
  static const blogQuery =
      '''
CREATE TABLE IF NOT EXISTS $tableBlogs (
blogId INTEGER PRIMARY KEY AUTOINCREMENT,
blogTitle TEXT,
blogContent TEXT,
blogDate TEXT,
blogTime TEXT,
folderId INTEGER,
userId INTEGER,
FOREIGN KEY (userId) REFERENCES $tableUsers(userId) ON DELETE CASCADE,
FOREIGN KEY (folderId) REFERENCES $tableFolders(folderId) ON DELETE CASCADE
)
''';
  static const todoQuery =
      '''
CREATE TABLE IF NOT EXISTS $tableTodo (
todoId INTEGER PRIMARY KEY AUTOINCREMENT,
todoTitle TEXT,
todoContent TEXT,
todoDate TEXT,
todoTime TEXT,
userId INTEGER,
folderId INTEGER,
isCompleted INTEGER DEFAULT 0,
FOREIGN KEY (folderId) REFERENCES $tableTodo(folderId) ON DELETE CASCADE,
FOREIGN KEY (userId) REFERENCES $tableUsers(userId) ON DELETE CASCADE
)
''';
}
