import 'package:payment/Features/payment/domain/entities/payment_intent_input.dart';
class PaymentIntentInputModel extends PaymentIntentInput
{
  const PaymentIntentInputModel({required super.amount, required super.currency, required super.customerId});



  toJson(){
    return {
      'amount': '${amount}00',
      'currency':currency,
      'customer': customerId,
    };
  }
}