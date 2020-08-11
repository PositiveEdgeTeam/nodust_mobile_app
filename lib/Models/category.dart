import 'dart:convert';

import 'package:flutter/foundation.dart';

class Category{
  String category_id;
  String category_name;
  String request_type_id;


  Category(this.category_id, this.category_name,this.request_type_id);

  factory Category.fromJson(Map<String, dynamic> json) {
      //var tagObjsJson = json['category'] as List;
   // var tagObjsJson = json['category'] as List;
     // var tagsJson = jsonDecode(json)['category'] as List;
    //  List<String> tags = tagObjsJson != null ? List.from(tagObjsJson) : null;

    return Category(
        json['category_id'] as String, json['category_name'] as String ,json['request_type_id'] as String);
  }
  Map<String, dynamic> toJson() => {
    'category_id': category_id,
    'category_name': category_name,
    'request_type_id':request_type_id,

  };


  String toString() {
    return '{${this.category_id},${this.category_name},${this.request_type_id}}';
  }

}