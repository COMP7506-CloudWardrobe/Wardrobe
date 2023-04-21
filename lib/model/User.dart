class User {
  int id;
  String? email;
  String? password;
  String? userName;
  String? userToken;

  User({
    required this.id,
    this.email,
    this.password,
    this.userName,
    this.userToken
  });
}