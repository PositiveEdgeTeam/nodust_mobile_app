import 'dart:convert';


UserDb clientFromJson(String str) {
  final jsonData = json.decode(str);
  return UserDb.fromMap(jsonData);
}

String clientToJson(UserDb data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class UserDb {
  static String table = 'accounts';

  int id;
  String username;
  String password;
  String classification;

  UserDb({
    this.id,
    this.username,
    this.password,
    this.classification
  });

  factory UserDb.fromMap(Map<String, dynamic> json) => new UserDb(
    id:json["id"],
    username: json["username"],
    password: json["password"],
    classification : json['classification'],
  );

  Map<String, dynamic> toMap() => {
    "id":id,
    "username": username,
    "password": password,
    "classification": classification,
  };
}