class FolderModel {
  final int? folderId;
  String folderName;
  int folderColor;
  final int? userId;

  FolderModel({
    this.folderId,
    required this.folderName,
    required this.folderColor,
    this.userId,
  });
  factory FolderModel.fromJson(Map<String, dynamic> json) => FolderModel(
    folderId: json["folderId"],
    folderName: json["folderName"],
    folderColor: json["folderColor"],
    userId: json["userId"],
  );
  Map<String, dynamic> toJson() => {
    "folderId": folderId,
    "folderName": folderName,
    "folderColor": folderColor,
    "userId": userId,
  };

  FolderModel copyWith({
    int? folderId,
    String? folderName,
    int? folderColor,
    int? userId,
  }) => FolderModel(
    folderId: folderId ?? this.folderId,
    folderName: folderName ?? this.folderName,
    folderColor: folderColor ?? this.folderColor,
    userId: userId ?? this.userId,
  );
}
