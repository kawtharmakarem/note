class BlogModel {
  final int? blogId;
  final String blogTitle;
  final String blogContent;
  final String blogDate;
  final String blogTime;
  final int? userId;
  final int? folderId;

  BlogModel({
    this.blogId,
    required this.blogTitle,
    required this.blogContent,
    required this.blogDate,
    required this.blogTime,
    required this.userId,
    required this.folderId,
  });
  factory BlogModel.fromJson(Map<String, dynamic> json) => BlogModel(
    blogId: json["blogId"],
    blogTitle: json["blogTitle"],
    blogContent: json["blogContent"],
    blogDate: json["blogDate"],
    blogTime: json["blogTime"],
    userId: json["userId"],
    folderId: json["folderId"],
  );
  Map<String, dynamic> toJson() => {
    "blogId": blogId,
    "blogTitle": blogTitle,
    "blogContent": blogContent,
    "blogDate": blogDate,
    "blogTime": blogTime,
    "userId": userId,
    "folderId": folderId,
  };
  BlogModel copyWith({
    int? blogId,
    String? blogTitle,
    String? blogContent,
    String? blogDate,
    String? blogTime,
    int? userId,
    int? folderId,
  }) {
    return BlogModel(
      blogId: blogId ?? this.blogId,
      blogTitle: blogTitle ?? this.blogTitle,
      blogContent: blogContent ?? this.blogContent,
      blogDate: blogDate ?? this.blogDate,
      blogTime: blogTime ?? this.blogTime,
      userId: userId ?? userId,
      folderId: folderId ?? this.folderId,
    );
  }
}
