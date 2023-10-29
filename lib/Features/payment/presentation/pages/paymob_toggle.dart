import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payment/Features/payment/presentation/pages/refcode_screen.dart';
import 'package:payment/core/utils/constant.dart';
import '../../../../core/utils/styles.dart';
import 'package:paymob_payment/paymob_payment.dart';

class PayMobToggle extends StatefulWidget {
  PayMobToggle({super.key});

  @override
  State<PayMobToggle> createState() => _PayMobToggleState();
}

class _PayMobToggleState extends State<PayMobToggle> {
  PaymobResponse response = PaymobResponse(success: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: GestureDetector(onTap: (){
            Navigator.of(context).pop();
          },child: Center(child: SvgPicture.asset('assets/images/arrow.svg',))),
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text(
            'PayMob',
            textAlign: TextAlign.center,
            style: Styles.style24,
          ),
        ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const ReferenceScreen()),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color:Colors.green,width: 2.0),
                      borderRadius: BorderRadius.circular(15.0)
                    ),
                    child: Image.network(Constant.refCodeImage),
                  ),
                ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: GestureDetector(
                onTap: ()  {
                  PaymobPayment.instance.pay(
                    context: context,
                    billingData: PaymobBillingData(
                      email: "claudette09@exa.com",
                      apartment: "803",
                      floor: "42",
                      street: "Ethan Land",
                      building:  "8028",
                      shippingMethod: "PKG",
                      city: "Jaskolskiburgh",
                      country: "CR",
                      state: "Utah",
                      phoneNumber: "+86(8)9135210487",
                      postalCode: "01898",
                      firstName: "Clifford",
                      lastName: "Nicolas",
                    ),
                    currency: "EGP",
                    amountInCents: "20000", // 200 EGP
                    onPayment: (response) => setState(() => this.response = response), // Optional
                  );
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color:Colors.green,width: 2.0),
                      borderRadius: BorderRadius.circular(15.0)
                  ),
                  child: Image.network(Constant.visaImage),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
