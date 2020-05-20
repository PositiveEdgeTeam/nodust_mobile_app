class ContractAddress{
  String address;
  String active;
  String address_id;
  ContractAddress(this.address,this.active,this.address_id);
  factory ContractAddress.fromJson(dynamic json) {
    return ContractAddress(
        json['address'] as String, json['active'] as String, json['address_id'] as String);
  }
  Map<String, dynamic> toJson() => {
    'address': address,
    'active': active,
    'address_id': address_id,
  };


  String toString() {
    return '{${this.address},${this.active},${this.address_id}}';
  }

}