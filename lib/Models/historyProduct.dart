class HistoryProduct{
  String product_name;
  String quantity;
  String quantity_replaced;

  HistoryProduct(this.product_name,this.quantity,this.quantity_replaced);

  factory HistoryProduct.fromJson(dynamic json) {

      return HistoryProduct(
          json['product_name'] as String, json['quantity'] as String,
          json['quantity_replaced'] as String);


  }
  Map<String, dynamic> toJson() => {
    'product_name': product_name,
    'quantity': quantity,
    'quantity_replaced': quantity_replaced,
  };


  String toString() {
    return '{${this.product_name},${this.quantity},${this.quantity_replaced}}';
  }
}