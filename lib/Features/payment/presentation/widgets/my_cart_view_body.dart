import 'package:flutter/material.dart';
import 'package:payment/Features/payment/data/repositories/checkout_repo_impl.dart';
import 'package:payment/Features/payment/presentation/manager/payment_cubit.dart';
import 'package:payment/Features/payment/presentation/widgets/cart_info_item.dart';
import 'package:payment/Features/payment/presentation/widgets/cart_total_price.dart';
import 'package:payment/Features/payment/presentation/widgets/payment_method_button_sheet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_button.dart';

class MyCartViewBody extends StatelessWidget {
  const MyCartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Expanded(child: Image.asset('assets/images/Group 6.png')),
          const SizedBox(
            height: 25,
          ),
          const OrderInfoItem(title: 'Order Subtotal', value: '42.97',),
          const SizedBox(
            height: 3,
          ),
          const OrderInfoItem(title: 'Discount', value: '0',),
          const SizedBox(
            height: 3,
          ),
          const OrderInfoItem(title: 'Shipping', value: '8',),
          const Divider(
            thickness: 2,
            color: Color(0xFFC6C6C6),
            height: 34,
          ),
          const SizedBox(
            height: 15,
          ),
          const TotalPrice(title: 'Total', value: '50.97',),
          const SizedBox(
            height: 16,
          ),
          CustomButton(title: 'Complete Payment',
          onTap: (){
/*            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const PaymentDetailsView()),
            );*/

          showModalBottomSheet(context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            builder: (context) =>
          BlocProvider(
            create: (context) => PaymentCubit(CheckOutRepoImpl()),
              child:  const PaymentMethodButtonSheet()),
          );
          }
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}




