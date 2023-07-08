import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'landing/landing_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {

    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LandingPage()));
    });

    return Center(
      child: Container(
        child: SvgPicture.asset(
          'assets/logo.svg'
        ),
      ),
    );
  }
}
