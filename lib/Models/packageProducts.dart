class PackageProducts{
  String product_name;
  String treatment;
  PackageProducts(this.product_name,this.treatment);
  factory PackageProducts.fromJson(dynamic json) {
    return PackageProducts(
        json['product_name'] as String, json['treatment'] as String,);
  }
  Map<String, dynamic> toJson() => {
    'product_name': product_name,
    'treatment': treatment,
  };


  String toString() {
    return '{${this.product_name},${this.treatment}}';
  }
}