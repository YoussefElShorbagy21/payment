import 'Details.dart';

class AmountModel {
  AmountModel({
      String? total, 
      String? currency, 
      Details? details,}){
    _total = total;
    _currency = currency;
    _details = details;
}

  AmountModel.fromJson(dynamic json) {
    _total = json['total'];
    _currency = json['currency'];
    _details = json['details'] != null ? Details.fromJson(json['details']) : null;
  }
  String? _total;
  String? _currency;
  Details? _details;

  String? get total => _total;
  String? get currency => _currency;
  Details? get details => _details;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = _total;
    map['currency'] = _currency;
    if (_details != null) {
      map['details'] = _details?.toJson();
    }
    return map;
  }

}