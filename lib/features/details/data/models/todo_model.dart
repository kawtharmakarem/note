class TodoModel {
  final int? todoId;
  final String todoTitle;
  final String todoContent;
  final String todoDate;
  final String todoTime;
  final int isCompleted;

  final int userId;
  final int folderId;

  TodoModel({
    this.todoId,
    required this.todoTitle,
    required this.todoContent,
    required this.todoDate,
    required this.todoTime,
    required this.isCompleted,
    required this.userId,
    required this.folderId,
  });
  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
    todoId: json["todoId"],
    todoTitle: json["todoTitle"],
    todoContent: json["todoContent"],
    todoDate: json["todoDate"],
    todoTime: json["todoTime"],
    isCompleted: json["isCompleted"],
    userId: json["userId"],
    folderId: json["folderId"],
  );
  Map<String, dynamic> toJson() => {
    "todoId": todoId,
    "todoTitle": todoTitle,
    "todoContent": todoContent,
    "todoDate": todoDate,
    "todoTime": todoTime,
    "isCompleted": isCompleted,
    "userId": userId,
    "folderId": folderId,
  };
  TodoModel copyWith({
    int? todoId,
    String? todoTitle,
    String? todoContent,
    String? todoDate,
    String? todoTime,
    int? isCompleted,
    int? userId,
    int? folderId,
  }) => TodoModel(
    todoId: todoId ?? this.todoId,
    todoTitle: todoTitle ?? this.todoTime,
    todoContent: todoContent ?? this.todoContent,
    todoDate: todoDate ?? this.todoDate,
    todoTime: todoTime ?? this.todoTime,
    isCompleted: isCompleted ?? this.isCompleted,
    userId: userId ?? this.userId,
    folderId: folderId ?? this.folderId,
  );
}
