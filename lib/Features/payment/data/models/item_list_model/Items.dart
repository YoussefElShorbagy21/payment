class Items {
  Items({
      String? name, 
      num? quantity, 
      String? price, 
      String? currency,}){
    _name = name;
    _quantity = quantity;
    _price = price;
    _currency = currency;
}

  Items.fromJson(dynamic json) {
    _name = json['name'];
    _quantity = json['quantity'];
    _price = json['price'];
    _currency = json['currency'];
  }
  String? _name;
  num? _quantity;
  String? _price;
  String? _currency;

  String? get name => _name;
  num? get quantity => _quantity;
  String? get price => _price;
  String? get currency => _currency;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['quantity'] = _quantity;
    map['price'] = _price;
    map['currency'] = _currency;
    return map;
  }

}