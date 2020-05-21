import 'dart:convert';

class Contact{
  String subject;
  List<String> category;



  Contact(this.subject,[this.category]);

  factory Contact.fromJson(Map<String, dynamic> json) {
      //var tagObjsJson = json['category'] as List;
    var tagObjsJson = json['category'] as List;
     // var tagsJson = jsonDecode(json)['category'] as List;
      List<String> tags = tagObjsJson != null ? List.from(tagObjsJson) : null;

    return Contact(
        json['subject'] as String, tags);
  }
  Map<String, dynamic> toJson() => {
    'subject': subject,
    'category': category,
  };


  String toString() {
    return '{${this.subject},${this.category}}';
  }

}