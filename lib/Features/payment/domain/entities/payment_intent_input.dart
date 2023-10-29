import 'package:equatable/equatable.dart';
class PaymentIntentInput extends Equatable
{
  final String amount ;
  final String currency;

  final String customerId ;
  const PaymentIntentInput({required this.customerId,required this.amount, required this.currency});

  @override
  List<Object?> get props => throw UnimplementedError();


}