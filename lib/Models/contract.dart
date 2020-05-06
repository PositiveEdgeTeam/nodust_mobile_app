import 'dart:convert';

class Contract{
  String card_no;
  String card_value;
  String status;

  Contract(this.card_no,this.card_value,this.status);

  factory Contract.fromJson(dynamic json) {
    return Contract(
        json['card_no'] as String, json['card_value'] as String,json['status'] as String);
  }
  Map<String, dynamic> toJson() => {
    'card_no': card_no,
    'card_value': card_value,
    'status' : status,
  };


  String toString() {
    return '{${this.card_no},${this.card_value},${this.status}}';
  }

}