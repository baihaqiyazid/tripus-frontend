import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tripusfrontend/pages/landing/landing_page.dart';

import 'login_page.dart';
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Penundaan selama 3 detik
    Future.delayed(Duration(seconds: 3), () {
      // Pindah ke halaman login setelah penundaan selesai
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => LandingPage(),
        ),
      );
    });

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Align(
              alignment: Alignment.center,
              child: SvgPicture.asset('assets/logo.svg'),
            ),
          ),
        ),
      ),
    );
  }
}
