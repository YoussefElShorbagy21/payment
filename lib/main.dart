import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:payment/bloc_observer.dart';
import 'package:paymob_payment/paymob_payment.dart';

import 'Features/payment/presentation/pages/my_cart_view.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() {
  PaymobPayment.instance.initialize(
    apiKey: "ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2T1RNME1EQTRMQ0p1WVcxbElqb2lhVzVwZEdsaGJDSjkuU29aa2NvQnBGNHkzRHJydUF0YkhTLUxhYnI3RHdiVzBpY0dRSUVzVXRlVnlPS3UzaHJ3aThrYUpwS2dXM2lvMXBWSnNGRUVOWDVqd1NTUnVrb0RkZEE=",
    integrationID: 4314804,
    iFrameID: 797448,
  );
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = 'pk_test_51O5tjHJwZVfLNCiD8S7ovlFwi1l1DWphj2TBXMgsYx4LqP37PD3RX6pCl2iyV9cVOkhVEErDHOKpW1ufCrfwGCiA007JQNtZmh';
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyCartView(),
    );
  }
}