import 'package:payment/Features/payment/data/models/ephemeral_keys_model/EphemeralKeys.dart';
import 'package:payment/Features/payment/data/models/payment_intent_input_model.dart';
import 'package:payment/Features/payment/data/models/payment_intent_model/PaymentIntentModel.dart';
import 'package:payment/core/utils/api_service.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:dio/dio.dart';
class StripeService
{
 final ApiService apiService = ApiService();
 Future<PaymentIntentModel> createPaymentIntent(PaymentIntentInputModel paymentIntentInputModel) async {
  var response =  await apiService.post(
      body: paymentIntentInputModel.toJson(),
      contentType: Headers.formUrlEncodedContentType,
      url: 'https://api.stripe.com/v1/payment_intents',
      token: 'sk_test_51O5tjHJwZVfLNCiDCGcir9GzTrjjIxMmtibkLJ9G0nPE8yAArQS4HhyTsIgMWA1koUKIv5i3rAErFDUrnfzbLrqN00lS65XIat'
  );

 var paymentIntentModel = PaymentIntentModel.fromJson(response.data);

 return paymentIntentModel ;
 }


 Future initPaymentSheet({required String paymentIntentClientSecret , required String? ephemeralKeySecret
 ,required String customerId,
 }) async {
  await Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(
   paymentIntentClientSecret: paymentIntentClientSecret,
   customerEphemeralKeySecret: ephemeralKeySecret,
   customerId: customerId,
   merchantDisplayName: 'youssef',
  ));
 }

 Future displayPaymentSheet() async {
  await Stripe.instance.presentPaymentSheet();
 }

 Future makePayment({required PaymentIntentInputModel paymentIntentInputModel ,}) async{
  var paymentIntentModel = await createPaymentIntent(paymentIntentInputModel);
  var ephemeralKeys = await createEphemeralKey(customerId: paymentIntentInputModel.customerId);
  await initPaymentSheet(paymentIntentClientSecret: paymentIntentModel.clientSecret!, 
   ephemeralKeySecret: ephemeralKeys.secret,
   customerId: 'cus_Ou4nHEQhdOGtTf',
  );
  await displayPaymentSheet();
  }


 Future<EphemeralKeys> createEphemeralKey({required String customerId}) async {
  var response =  await apiService.post(
      body: {
       'customer' : customerId
      },
      headers: {
       'Authorization' : "Bearer sk_test_51O5tjHJwZVfLNCiDCGcir9GzTrjjIxMmtibkLJ9G0nPE8yAArQS4HhyTsIgMWA1koUKIv5i3rAErFDUrnfzbLrqN00lS65XIat",
       'Stripe-Version': '2023-10-16'
      },
      contentType: Headers.formUrlEncodedContentType,
      url: 'https://api.stripe.com/v1/ephemeral_keys',
      token: 'sk_test_51O5tjHJwZVfLNCiDCGcir9GzTrjjIxMmtibkLJ9G0nPE8yAArQS4HhyTsIgMWA1koUKIv5i3rAErFDUrnfzbLrqN00lS65XIat'
  );

  var  ephemeralKeys= EphemeralKeys.fromJson(response.data);

  return ephemeralKeys ;
 }
}