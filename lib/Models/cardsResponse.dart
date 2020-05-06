import 'package:nodustmobileapp/Models/contract.dart';

class CardResponse {
  String state;
  String code;
  String message;
  List<Contract> data;

  CardResponse(this.state, this.code,this.message, [this.data]);

  factory CardResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      var tagObjsJson = json['data'] as List;
      List<Contract> _contract = tagObjsJson.map((tagJson) => Contract.fromJson(tagJson))
          .toList();

      return CardResponse(
          json['state'] as String,
          json['code'] as String,
          json['message'] as String,
          _contract
      );
    }
    else{
      return CardResponse(
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