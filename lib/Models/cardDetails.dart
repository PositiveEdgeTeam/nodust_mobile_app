class CardDetails{
  String card_no;
  String client_name;
  String contract_phone;
  String contract_mobile;
  String contract_email;
  String contract_date;
  String last_changed_date;
  String next_delivery_date;
  String city_name;
  String region_name;
  String area_name;
  String street_name;
  String home_no;
  String flat_no;
  String floor_no;
  String address;

  CardDetails(this.card_no,this.client_name,this.contract_phone,this.contract_mobile,this.contract_email,this.contract_date,this.last_changed_date,
      this.next_delivery_date,this.city_name,this.region_name,this.area_name,this.street_name,this.home_no,this.flat_no,this.floor_no,this.address);

  factory CardDetails.fromJson(dynamic json) {
    return CardDetails(
        json['card_no'] as String, json['client_name'] as String,
      json['contract_phone'] as String, json['contract_mobile'] as String,
      json['contract_email'] as String, json['contract_date'] as String,
      json['last_changed_date'] as String, json['next_delivery_date'] as String,
      json['city_name'] as String, json['region_name'] as String,
      json['area_name'] as String, json['street_name'] as String,
      json['home_no'] as String, json['flat_no'] as String,
      json['floor_no'] as String, json['address'] as String,);
  }
  Map<String, dynamic> toJson() => {
    'card_no': card_no,
    'client_name': client_name,
    'contract_phone': contract_phone,
    'contract_mobile':contract_mobile,
    'contract_email' : contract_email,
    'contract_date' : contract_date,
    'last_changed_date' : last_changed_date,
    'next_delivery_date' : next_delivery_date,
    'city_name' : city_name,
    'region_name' : region_name,
    'area_name' : area_name,
    'street_name': street_name,
    'home_no':home_no,
    'flat_no': flat_no,
    'floor_no' : floor_no,
    'address' : address,
      };


  String toString() {
    return '{${this.card_no},${this.client_name},${this.contract_phone},${this.contract_mobile},${this.contract_email},${this.contract_date},${this.last_changed_date},${this.next_delivery_date},${this.city_name},${this.region_name},${this.area_name},${this.street_name},${this.home_no},${this.flat_no},${this.floor_no},${this.address}}';
  }
}