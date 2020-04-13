class User {
  String customer_id;
  String customer_name;
  String customer_mobile;
  String customer_phone;
  String customer_credit;
  String customer_points;
  User(this.customer_id,this.customer_name,this.customer_mobile,this.customer_phone,this.customer_credit, this.customer_points);

  /*factory User.fromJson(dynamic json) {
    return User(json['customer_id'] as String,json['customer_name'] as String,json['customer_mobile'] as String,json['customer_phone'] as String);
  }*/
  User.fromJson(Map<String, dynamic> json)
      : customer_id = json['customer_id'],
        customer_name = json['customer_name'],
        customer_mobile = json['customer_mobile'],
        customer_phone = json['customer_phone'],
        customer_credit= json['customer_credit'],
        customer_points = json['customer_points'];

  Map<String, dynamic> toJson() => {
    'customer_id': customer_id,
    'customer_name': customer_name,
    'customer_mobile': customer_mobile,
    'customer_phone': customer_phone,
    'customer_credit' : customer_credit,
    'customer_points' : customer_points,

  };

  @override
  String toString() {
    return '{${this.customer_id},${this.customer_name},${this.customer_mobile},${this.customer_phone},${this.customer_credit},${this.customer_points}';
  }
}