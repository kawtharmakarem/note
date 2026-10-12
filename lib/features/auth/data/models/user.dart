class User {
  final int? userId;
  final String username;
  final String? email;
  final String? imagePath;
  final String password;

  User({
    this.userId,
    required this.username,
    this.email,
    this.imagePath,
    required this.password,
  });
  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json['userId'],
    username: json['username'],
    email: json['email'],
    password: json['password'],
    imagePath: json['imagePath'],
  );
  Map<String, dynamic> toJson() => {
    'userId': userId,
    'username': username,
    'email': email,
    'imagePath': imagePath,
    'password': password,
  };
}
