import 'dart:convert';

import 'package:flutter/foundation.dart';

class Category{
  String category_id;
  String category_name;


  Category(this.category_id, this.category_name);

  factory Category.fromJson(Map<String, dynamic> json) {
      //var tagObjsJson = json['category'] as List;
   // var tagObjsJson = json['category'] as List;
     // var tagsJson = jsonDecode(json)['category'] as List;
    //  List<String> tags = tagObjsJson != null ? List.from(tagObjsJson) : null;

    return Category(
        json['category_id'] as String, json['category_name'] as String );
  }
  Map<String, dynamic> toJson() => {
    'category_id': category_id,
    'category_name': category_name,

  };


  String toString() {
    return '{${this.category_id},${this.category_name}}';
  }

}