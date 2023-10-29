import 'package:flutter/material.dart';
import 'package:payment/Features/payment/presentation/widgets/thank_you_view_body.dart';
import 'package:flutter_svg/flutter_svg.dart';
class ThankYouView extends StatelessWidget {
  const ThankYouView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:GestureDetector(onTap: (){
          Navigator.of(context).pop();
        },child: Center(child: SvgPicture.asset('assets/images/arrow.svg',))),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Transform.translate(
          offset: const Offset(0, -16),
          child: const ThankYouViewBody()),
    );
  }
}
