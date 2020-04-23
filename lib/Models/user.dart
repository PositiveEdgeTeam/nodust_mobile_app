class User {
  String customer_id;
  String customer_name;
  String customer_mobile;
  String customer_phone;
  String customer_balance;
  String customer_points;
  String customer_classification;
  String selected;
  String cards;
  String collection;
  User(this.customer_id,this.customer_name,this.customer_mobile,this.customer_phone,this.customer_balance, this.customer_points
      ,this.customer_classification,this.selected,this.cards,this.collection);

  factory User.fromJson(dynamic json) {
    return User(json['customer_id'] as String,json['customer_name'] as String,json['customer_mobile'] as String,json['customer_phone'] as String, json['customer_balance'] as String,
        json['customer_points'] as String , json['customer_classification'] as String,json['selected'] as String ,json['cards'] as String,
        json['collection'] as String);
  }
 /* User.fromJson(Map<String, dynamic> json)
      : customer_id = json['customer_id'],
        customer_name = json['customer_name'],
        customer_mobile = json['customer_mobile'],
        customer_phone = json['customer_phone'],
        customer_balance= json['customer_balance'],
        customer_points = json['customer_points'],
        customer_classification = json['customer_classification'],
        selected = json['selected'],
        cards = json['cards'],
        collection = json['collection'];*/

  Map<String, dynamic> toJson() => {
    'customer_id': customer_id,
    'customer_name': customer_name,
    'customer_mobile': customer_mobile,
    'customer_phone': customer_phone,
    'customer_balance' : customer_balance,
    'customer_points' : customer_points,
    'customer_classification' : customer_classification,
    'selected' : selected,
    'cards' : cards,
    'collection' : collection,

  };

  @override
  String toString() {
    return '{${this.customer_id},${this.customer_name},${this.customer_mobile},${this.customer_phone},${this.customer_balance},${this.customer_points},${this.customer_classification},${this.selected},${this.cards},${this.collection}}';
  }
}