import 'dart:convert';

import 'package:nodustmobileapp/Models/category.dart';

class Contact{
  String subject;
  String subject_id;
  List<Category> category;



  Contact(this.subject, this.subject_id ,[this.category]);

  factory Contact.fromJson(Map<String, dynamic> json) {
      //var tagObjsJson = json['category'] as List;
    if (json['category'] != null) {
      var tagObjsJson = json['category'] as List;
      // var tagsJson = jsonDecode(json)['category'] as List;
      List<Category> tags = tagObjsJson.map((tagJson) =>
          Category.fromJson(tagJson))
          .toList();

      return Contact(
          json['subject'] as String, json['subject_id'] as String, tags);
    }
    else
      return Contact(
          json['subject'] as String, json['subject_id'] as String);
  }
  Map<String, dynamic> toJson() => {
    'subject': subject,
    'subject_id': subject_id,
    'category': category,

  };


  String toString() {
    return '{${this.subject},${this.subject_id},${this.category}}';
  }

}