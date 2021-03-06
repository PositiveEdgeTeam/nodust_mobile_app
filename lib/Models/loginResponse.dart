import 'package:nodustmobileapp/Models/user.dart';

class LoginResponse {
  String state;
  String code;
  String message;
  List<User> data;

  LoginResponse(this.state, this.code,this.message, [this.data]);

  factory LoginResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      var tagObjsJson = json['data'] as List;
      List<User> _users = tagObjsJson.map((tagJson) => User.fromJson(tagJson))
          .toList();

      return LoginResponse(
          json['state'] as String,
          json['code'] as String,
          json['message'] as String,
          _users
      );
    }
    else{
      return LoginResponse(
          json['state'] as String,
          json['code'] as String,
          json['message'] as String);
    }

  }

  @override
  String toString() {
    return '{ ${this.state}, ${this.code},${this.message}, ${this.data} }';
  }
}