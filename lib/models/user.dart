class User {
  late final  int id;
  late final String name;
  late final String user_name;
  late final String password;

  static final columns = ["id", "name", "userName", "password"];
  Map<String, dynamic> toMap()=> {
    "id": id,
    "name": name,
    "userName": user_name,
    "password": password
  };
}