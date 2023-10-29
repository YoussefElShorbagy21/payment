class Details {
  Details({
      String? subtotal, 
      String? shipping, 
      num? shippingDiscount,}){
    _subtotal = subtotal;
    _shipping = shipping;
    _shippingDiscount = shippingDiscount;
}

  Details.fromJson(dynamic json) {
    _subtotal = json['subtotal'];
    _shipping = json['shipping'];
    _shippingDiscount = json['shipping_discount'];
  }
  String? _subtotal;
  String? _shipping;
  num? _shippingDiscount;

  String? get subtotal => _subtotal;
  String? get shipping => _shipping;
  num? get shippingDiscount => _shippingDiscount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['subtotal'] = _subtotal;
    map['shipping'] = _shipping;
    map['shipping_discount'] = _shippingDiscount;
    return map;
  }

}