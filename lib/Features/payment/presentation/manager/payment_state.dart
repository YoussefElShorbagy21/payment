part of 'payment_cubit.dart';

@immutable
abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}
class PaymentSuccess extends PaymentState {}
class PaymentError extends PaymentState {
  final String errMessage;

  PaymentError(this.errMessage);
}

class ChangeActiveIndexState extends PaymentState {}


class PayMobLoadingAuth extends PaymentState {}
class PayMobSuccessAuth extends PaymentState {}
class PayMobErrorAuth extends PaymentState {}


class OrderRegistrationIdPayMobLoading extends PaymentState {}
class OrderRegistrationIdPayMobSuccess extends PaymentState {}
class OrderRegistrationIdPayMobError extends PaymentState {}

class PaymentKeyPayMobLoading extends PaymentState {}
class PaymentKeyPayMobSuccess extends PaymentState {}
class PaymentKeyPayMobError extends PaymentState {}



class KioskPaymentsLoading extends PaymentState {}
class KioskPaymentsSuccess extends PaymentState {}
class KioskPaymentsError extends PaymentState {}