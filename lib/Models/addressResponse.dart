import 'package:nodustmobileapp/Models/cardData_.dart';
import 'package:nodustmobileapp/Models/contractAddress.dart';
import 'package:nodustmobileapp/carddata.dart';

class AddressResponse {
  String state;
  String code;
  String message;
  List<ContractAddress> data;

  AddressResponse(this.state, this.code, this.message, [this.data]);

  factory AddressResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      var tagObjsJson = json['data'] as List;
      List<ContractAddress> _addresses = tagObjsJson.map((tagJson) => ContractAddress.fromJson(tagJson))
          .toList();

      return AddressResponse(
          json['state'] as String,
          json['code'] as String,
          json['message'] as String,
          _addresses
      );
    }
    else{
      return AddressResponse(
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