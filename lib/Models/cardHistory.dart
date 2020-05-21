import 'package:nodustmobileapp/Models/historyProduct.dart';

class CardHistory{
  String assignment_id;
  String assign_id;
  String status;
  String assign_date;
  List<HistoryProduct> historyProducts;
  CardHistory(this.assignment_id,this.assign_id,this.status,this.assign_date,[this.historyProducts]);

  factory CardHistory.fromJson(dynamic json) {
    if (json['historyProducts'] != null) {
      var tagObjsJson = json['historyProducts'] as List;
      List<HistoryProduct> _historyProducts = tagObjsJson.map((tagJson) =>
          HistoryProduct.fromJson(tagJson))
          .toList();
      return CardHistory(
        json['assignment_id'] as String, json['assign_id'] as String,
        json['status'] as String, json['assign_date'] as String, _historyProducts);
    }
    else {
      return CardHistory(
        json['assignment_id'] as String, json['assign_id'] as String,
        json['status'] as String, json['assign_date'] as String,);
    }
  }
  Map<String, dynamic> toJson() => {
    'assignment_id': assignment_id,
    'assign_id': assign_id,
    'status': status,
    'assign_date':assign_date,
  };


  String toString() {
    return '{${this.assignment_id},${this.assign_id},${this.status},${this.assign_date}}';
  }
}