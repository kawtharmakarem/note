class NoteModel {
  final int? noteId;
  final String noteTitle;
  final String noteContent;
  final int noteColor;
  final String noteDate;
  final String noteTime;
  final int? folderId;
  final int? userId;

  NoteModel({
    this.noteId,
    required this.noteTitle,
    required this.noteContent,
    required this.noteColor,
    required this.noteDate,
    required this.noteTime,
    required this.folderId,
    required this.userId,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) => NoteModel(
    noteId: json["noteId"],
    noteTitle: json["noteTitle"],
    noteContent: json["noteContent"],
    noteColor: json["noteColor"],
    noteDate: json["noteDate"],
    noteTime: json["noteTime"],
    folderId: json["folderId"],
    userId: json["userId"],
  );
  Map<String, dynamic> toJson() => {
    "noteId": noteId,
    "noteTitle": noteTitle,
    "noteContent": noteContent,
    "noteColor": noteColor,
    "noteDate": noteDate,
    "noteTime": noteTime,
    "folderId": folderId,
    "userId": userId,
  };

  NoteModel copyWith({
    int? noteId,
    String? noteTitle,
    String? noteContent,
    int? noteColor,
    String? noteDate,
    String? noteTime,

    int? folderId,
    int? userId,
  }) {
    return NoteModel(
      noteId: noteId ?? this.noteId,
      noteTitle: noteTitle ?? this.noteTitle,
      noteContent: noteContent ?? this.noteContent,
      noteColor: noteColor ?? this.noteColor,
      noteDate: noteDate ?? this.noteDate,
      noteTime: noteTime ?? this.noteDate,
      folderId: folderId ?? this.folderId,
      userId: userId ?? this.userId,
    );
  }
}
