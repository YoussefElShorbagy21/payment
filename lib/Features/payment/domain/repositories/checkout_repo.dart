import 'package:dartz/dartz.dart';
import 'package:payment/Features/payment/data/models/payment_intent_input_model.dart';

import '../../../../core/error/failures.dart';
abstract class CheckOutRepo
{
  Future<Either<Failure,void>> makePayment({required PaymentIntentInputModel paymentIntentInputModel});
}


