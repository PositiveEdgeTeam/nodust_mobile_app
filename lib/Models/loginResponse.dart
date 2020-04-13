import 'package:nodustmobileapp/Models/user.dart';

class LoginResponse {
  String state;
  String code;
  String message;
  User data;

  LoginResponse(this.state, this.code,this.message, this.data);

  factory LoginResponse.fromJson(dynamic json) {

    return LoginResponse(
        json['state'] as String,
        json['code'] as String,
        json['message'] as String,
        User.fromJson(json['data'])
    );

  }

  @override
  String toString() {
    return '{ ${this.state}, ${this.code},${this.message}, ${this.data} }';
  }
}