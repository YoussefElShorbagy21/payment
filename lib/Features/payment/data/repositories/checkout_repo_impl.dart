import 'package:dartz/dartz.dart';
import 'package:payment/Features/payment/data/models/payment_intent_input_model.dart';
import 'package:payment/Features/payment/domain/repositories/checkout_repo.dart';
import 'package:payment/core/error/failures.dart';
import 'package:payment/core/utils/stripe_service.dart';

class CheckOutRepoImpl implements CheckOutRepo{
  final StripeService stripeService = StripeService();
  @override
  Future<Either<Failure, void>> makePayment({required PaymentIntentInputModel paymentIntentInputModel})
  async {
    try {
      await stripeService.makePayment(
          paymentIntentInputModel: paymentIntentInputModel);
      return right(null);
    }catch(e)
    {
      return left(ServiceFailure(errMessage: e.toString()));
    }
  }
  
}