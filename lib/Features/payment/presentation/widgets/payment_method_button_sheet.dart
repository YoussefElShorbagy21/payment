import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:payment/Features/payment/data/models/amount_model/AmountModel.dart';
import 'package:payment/Features/payment/data/models/amount_model/Details.dart';
import 'package:payment/Features/payment/data/models/item_list_model/ItemListModel.dart';
import 'package:payment/Features/payment/data/models/payment_intent_input_model.dart';
import 'package:payment/Features/payment/presentation/manager/payment_cubit.dart';
import 'package:payment/Features/payment/presentation/pages/paymob_toggle.dart';
import 'package:payment/Features/payment/presentation/pages/thank_you_view.dart';
import 'package:payment/Features/payment/presentation/widgets/payment_method_list_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_button.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';

import '../../data/models/item_list_model/Items.dart';

class PaymentMethodButtonSheet extends StatelessWidget {
  const PaymentMethodButtonSheet({super.key});
  @override
  Widget build(BuildContext context) {

    return  Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 16,
          ),
          PaymentMethodListView(),
          const SizedBox(
            height: 32,
          ),
          BlocConsumer<PaymentCubit, PaymentState>(
            listener: (context, state) {
              if(state is PaymentSuccess) {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ThankYouView()),
                );
              }

              if(state is PaymentError) {
                  Navigator.of(context).pop();
                  SnackBar snackBar = SnackBar(content: Text(state.errMessage));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }

              if(state is PaymentKeyPayMobSuccess){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PayMobToggle()),
                );
                BlocProvider.of<PaymentCubit>(context).getKioskPaymentsPayMob();
              }
            },
            builder: (context, state) {
              return  CustomButton(
                onTap: (){
                  if( BlocProvider.of<PaymentCubit>(context).activeIndex == 0)
                    {
                      PaymentIntentInputModel payment = const PaymentIntentInputModel(
                          amount: '100',
                          currency: 'USD',
                          customerId: 'cus_Ou4nHEQhdOGtTf'
                      );
                      BlocProvider.of<PaymentCubit>(context).makePayment(
                          paymentIntentInputModel: payment);
                    }
                  else if(BlocProvider.of<PaymentCubit>(context).activeIndex == 1){
                    var amount = AmountModel(
                        total: "100",
                        currency: 'USD',
                        details: Details(
                          shipping: "0",
                          shippingDiscount: 0,
                          subtotal: "100",
                        )
                    );
                    List<Items> items = [
                      Items(
                          name: "Apple",
                          quantity: 4,
                          price: '10',
                          currency: "USD"
                      ),
                      Items(
                          name: "Pineapple",
                          quantity: 5,
                          price: '12',
                          currency: "USD"
                      ),
                    ];
                    var itemList = ItemListModel(items: items);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => PaypalCheckoutView(
                        sandboxMode: true,
                        clientId: "AbsQzqYxDYw1AyVj0KjPWFP_pWTKmzResvjRyn7Zlo3o3egg4mLuotRQxXJ_K8KCm0jKcw4AHmhswFy_",
                        secretKey: "EIMmSmwqiklSIphXlm8efJQFiieg0QgHkybNUFvrxEQFlK3cMtqOGAxQb8O0UuH6rX_lkO8-KeGmGnq1",
                        transactions:  [
                          {
                            "amount": amount.toJson(),
                            "description": "The payment transaction description.",
                            "item_list": itemList.toJson(),
                          }
                        ],
                        note: "Contact us for any questions on your order.",
                        onSuccess: (Map params) async {
                          log("onSuccess: $params");
                          Navigator.pop(context);
                        },
                        onError: (error) {
                          log("onError: $error");
                          Navigator.pop(context);
                        },
                        onCancel: () {
                          print('cancelled:');
                          Navigator.pop(context);
                        },
                      ),
                    ));
                  }
                  else{
                    BlocProvider.of<PaymentCubit>(context).makePayMob();
                  }
                },
                  isLoading: state is PaymentLoading ? true : false,
                  title: 'Continue');
            },
          ),
        ],
      ),
    );
  }
}
