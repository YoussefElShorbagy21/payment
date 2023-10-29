import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:payment/Features/payment/data/models/payment_intent_input_model.dart';
import 'package:payment/Features/payment/domain/repositories/checkout_repo.dart';
import 'package:dio/dio.dart';
import 'package:payment/core/utils/constant.dart';
import '../../../../core/utils/api_service.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.checkOutRepo) : super(PaymentInitial());


  final CheckOutRepo checkOutRepo;

  int activeIndex = 0;

  void changeActiveIndex(index) {
    activeIndex = index;
    emit(ChangeActiveIndexState());
  }

  Future makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async
  {
    emit(PaymentLoading());
    var data = await checkOutRepo.makePayment(
        paymentIntentInputModel: paymentIntentInputModel);

    data.fold((l) => emit(PaymentError(l.errMessage)),
            (r) => emit(PaymentSuccess()));
  }

  final ApiService apiService = ApiService();

  Future<void> getAuthPayMob() async {
    emit(PayMobLoadingAuth());
    await apiService.dio2.post(
      'auth/tokens',
      data: {
          "api_key": "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2T1RNME1EQTRMQ0p1WVcxbElqb2lhVzVwZEdsaGJDSjkuU29aa2NvQnBGNHkzRHJydUF0YkhTLUxhYnI3RHdiVzBpY0dRSUVzVXRlVnlPS3UzaHJ3aThrYUpwS2dXM2lvMXBWSnNGRUVOWDVqd1NTUnVrb0RkZEE="
      },
    ).then((value) {
      Constant.auth = value.data['token'] ;
      print('Constant.auth : ${Constant.auth}');
      emit(PayMobSuccessAuth());
    }).catchError((onError) {
      print(onError.toString());
      emit(PayMobErrorAuth());
    });
  }


  Future<void> getOrderRegistrationIdPayMob() async {
    emit(OrderRegistrationIdPayMobLoading());
    await apiService.dio2.post(
      'ecommerce/orders',
      data: {
          "auth_token":  Constant.auth,
          "amount_cents": "100",
          "delivery_needed": "false",
          "items" : []
      },
    ).then((value) {
      Constant.id = value.data['id'].toString() ;
      print('Constant.id : ${Constant.id}');
      emit(OrderRegistrationIdPayMobSuccess());
    }).catchError((onError) {
      print(onError.toString());
      emit(OrderRegistrationIdPayMobError());
    });
  }


  Future<void> getPaymentKeyPayMob() async {
    emit(PaymentKeyPayMobLoading());
    await apiService.dio2.post(
      'acceptance/payment_keys',
      data: {
          "auth_token": Constant.auth,
          "amount_cents": "100",
          "expiration": 3600,
          "order_id": Constant.id,
          "billing_data": {
            "apartment": "803",
            "email": "claudette09@exa.com",
            "floor": "42",
            "first_name": "Clifford",
            "street": "Ethan Land",
            "building": "8028",
            "phone_number": "+86(8)9135210487",
            "shipping_method": "PKG",
            "postal_code": "01898",
            "city": "Jaskolskiburgh",
            "country": "CR",
            "last_name": "Nicolas",
            "state": "Utah"
          },
          "currency": "EGP",
          "integration_id": 4314804
      },
    ).then((value) {
      Constant.finalAuth = value.data['token'] ;
      print('Constant.finalAuth : ${Constant.finalAuth}');
      emit(PaymentKeyPayMobSuccess());
    }).catchError((onError) {
      print(onError.toString());
      emit(PaymentKeyPayMobError());
    });
  }



  Future<void> getKioskPaymentsPayMob() async {
    emit(KioskPaymentsLoading());
    await apiService.dio2.post(
      '/acceptance/payments/pay',
      data: {
        "source": {
          "identifier": "AGGREGATOR",
          "subtype": "AGGREGATOR"
        },
        "payment_token": Constant.finalAuth
      },
    ).then((value) {
      Constant.refCode = value.data['id'].toString() ;
      print('Constant.refCode : ${Constant.refCode}');
      emit(KioskPaymentsSuccess());
    }).catchError((onError) {
      print(onError.toString());
      emit(KioskPaymentsError());
    });
  }


  Future<void> makePayMob() async {
    await getAuthPayMob();
    await getOrderRegistrationIdPayMob();
    await getPaymentKeyPayMob();
  }

}
