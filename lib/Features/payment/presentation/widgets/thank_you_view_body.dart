import 'package:flutter/material.dart';
import 'package:payment/Features/payment/presentation/widgets/thank_you_card.dart';

import 'custom_check_icon.dart';
import 'custome_dashed_line.dart';

class ThankYouViewBody extends StatelessWidget {
  const ThankYouViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.all(15.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const ThankYouCard(),

          Positioned(
            bottom: MediaQuery.sizeOf(context).height * .2 + 20,
            left: 28,
            right: 28,
            child: const CustomDashedLine(),
          ),

          Positioned(
            left: -20,
            bottom: MediaQuery.sizeOf(context).height * .2 ,
              child: const CircleAvatar(
              backgroundColor: Colors.white,
          )),

          Positioned(
              right: -20,
              bottom: MediaQuery.sizeOf(context).height * .2 ,
              child: const CircleAvatar(
                backgroundColor: Colors.white,
              )),

          const Positioned(
            top: -50,
            left: 0,
            right: 0,
            child: CustomCheckIcon(),
          ),
        ],
      ),
    );
  }
}
