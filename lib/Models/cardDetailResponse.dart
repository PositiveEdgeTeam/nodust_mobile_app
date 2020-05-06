import 'package:nodustmobileapp/Models/cardData_.dart';
import 'package:nodustmobileapp/carddata.dart';

class CardDataResponse {
  String state;
  String code;
  String message;
  CardData_ data;

  CardDataResponse(this.state, this.code, this.message, this.data);

  factory CardDataResponse.fromJson(dynamic json) {
      return CardDataResponse(
          json['state'] as String,
          json['code'] as String,
          json['message'] as String,
        CardData_.fromJson(json['data']),);

  }

  @override
  String toString() {
    return '{ ${this.state}, ${this.code},${this.message}, ${this.data} }';
  }
}