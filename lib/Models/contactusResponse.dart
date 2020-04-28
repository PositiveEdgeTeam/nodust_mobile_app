import 'package:nodustmobileapp/Models/channel.dart';
import 'package:nodustmobileapp/Models/contact.dart';

class contactusResponse{
  String state;
  String code;
  String message;
  List<Contact> data;


  contactusResponse(this.state, this.code,this.message, [this.data]);

  factory contactusResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      var tagObjsJson = json['data'] as List;
      List<Contact> _subjects = tagObjsJson.map((tagJson) => Contact.fromJson(tagJson))
          .toList();

      return contactusResponse(
          json['state'] as String,
          json['code'] as String,
          json['message'] as String,
          _subjects
      );
    }
    else{
      return contactusResponse(
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