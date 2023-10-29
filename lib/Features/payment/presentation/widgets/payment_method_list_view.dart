import 'package:flutter/material.dart';
import 'package:payment/Features/payment/presentation/manager/payment_cubit.dart';
import 'package:payment/Features/payment/presentation/widgets/payment_method_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/checkout_repo_impl.dart';

class PaymentMethodListView extends StatelessWidget {
  PaymentMethodListView({super.key,});

  final List<String> paymentMethodItems = [
    'assets/images/card.svg',
    'assets/images/paypal.svg',
    'assets/images/pay.svg'
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SizedBox(
          height: 62,
          child: ListView.builder(
              itemCount: paymentMethodItems.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                      onTap: () {
                        BlocProvider.of<PaymentCubit>(context).changeActiveIndex(index);
                      },
                      child: PaymentMethodItem(
                        image: paymentMethodItems[index],
                        isActive:  BlocProvider.of<PaymentCubit>(context).activeIndex == index,)),
                );
              }),
        );
      },
    );
  }
}
