import 'package:nodustmobileapp/Models/cardDetails.dart';
import 'package:nodustmobileapp/Models/cardHistory.dart';
import 'package:nodustmobileapp/Models/cardProducts.dart';
import 'cardDetails.dart';

class CardData_{

  CardDetails details;
  List<CardProducts> products;
  List<CardHistory> history;

  CardData_(CardDetails _details, List<CardProducts> _products,  List<CardHistory> _history)
  {
    this.details = _details;
    this.products = _products;
    this.history = _history;
  }
  CardData_.withoutHistory(CardDetails _details, List<CardProducts> _products)
  {
    this.details = _details;
    this.products = _products;
  }
  CardData_.withoutProducts(CardDetails _details,   List<CardHistory> _history)
  {
    this.details = _details;
    this.history = _history;
  }
  CardData_.withoutboth(CardDetails _details)
  {
    this.details = _details;
  }
  CardData_.withoutall();



  factory CardData_.fromJson(dynamic json) {
    if (json['history'] != null && json['products'] != null) {
      var tagObjsJson = json['history'] as List;
      List<CardHistory> _histories = tagObjsJson.map((tagJson) => CardHistory.fromJson(tagJson))
          .toList();
      var tagObjsJson2 = json['products'] as List;
      List<CardProducts> _products = tagObjsJson2.map((tagJson) => CardProducts.fromJson(tagJson))
          .toList();
      return CardData_(
          CardDetails.fromJson(json['details']),
          _products,
          _histories
      );
    }
    else if(json['history'] != null){
      var tagObjsJson = json['history'] as List;
      List<CardHistory> _histories = tagObjsJson.map((tagJson) => CardHistory.fromJson(tagJson))
          .toList();
      return CardData_.withoutProducts(
          CardDetails.fromJson(json['details']),
          _histories
      );
    }
    else if(json['products'] != null){
      var tagObjsJson2 = json['products'] as List;
      List<CardProducts> _products = tagObjsJson2.map((tagJson) => CardProducts.fromJson(tagJson))
          .toList();
      return CardData_.withoutHistory(
          CardDetails.fromJson(json['details']),
        _products,
      );
    }
    else if(json['details'] != null){
      return CardData_.withoutboth(
          CardDetails.fromJson(json['details']));
    }
    else {
      return CardData_.withoutall();
    }
  }
  Map<String, dynamic> toJson() => {
    'details': details,
    'products': products,
    'history' : history,
  };


  String toString() {
    return '{${this.details},${this.products},${this.history}}';
  }
}