import 'package:nodustmobileapp/Models/packageProducts.dart';

class CardProducts{
  String item_name;
  String treatment;
  String package_no;
  String quantity;
  String price;
  List<PackageProducts> packageProducts;
  CardProducts(this.item_name,this.treatment,this.package_no,this.quantity,this.price,[this.packageProducts]);

  factory CardProducts.fromJson(dynamic json) {
    if (json['packageProducts'] != null ) {
      var tagObjsJson = json['packageProducts'] as List;
      List<PackageProducts> _packageProducts = tagObjsJson.map((tagJson) => PackageProducts.fromJson(tagJson))
          .toList();
      return CardProducts(
          json['item_name'] as String, json['treatment'] as String,
          json['package_no'] as String, json['quantity'] as String,
          json['price'] as String , _packageProducts);

      }
      else {
        return CardProducts(
            json['item_name'] as String, json['treatment'] as String,
            json['package_no'] as String, json['quantity'] as String,
            json['price'] as String);
      }
  }
  Map<String, dynamic> toJson() => {
    'item_name': item_name,
    'treatment': treatment,
    'package_no': package_no,
    'quantity':quantity,
    'price': price,
    'packageProducts' : packageProducts,
  };


  String toString() {
    return '{${this.item_name},${this.treatment},${this.package_no},${this.quantity},${this.price},${this.packageProducts}}';
  }
}