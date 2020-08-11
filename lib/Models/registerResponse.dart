import 'package:nodustmobileapp/Models/channel.dart';

class RegisterResponse{
  String state;
  String code;
  String message;
  String data;


  RegisterResponse(this.state, this.code,this.message, this.data);

  factory RegisterResponse.fromJson(dynamic json) {

      return RegisterResponse(
          json['state'] as String,
          json['code'] as String,
          json['message'] as String,
          json['data'] as String);


  }

  @override
  String toString() {
    return '{ ${this.state}, ${this.code},${this.message}, ${this.data} }';
  }
}