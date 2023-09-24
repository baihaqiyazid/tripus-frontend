import 'dart:ffi';

import 'package:flutter/material.dart';

import '../../helper/theme.dart';
import 'landing_signup.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 30),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/background_landing.png', fit: BoxFit.cover, width:  double.infinity, height: MediaQuery.of(context).size.height,
              ),
              Positioned(
                top: 0,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 590, bottom: 17),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(
                                vertical: 12, horizontal: 150), // Set the desired padding values
                          ),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(17), // Set the desired border radius
                            ),
                          ),
                          backgroundColor:
                          MaterialStateProperty.all<Color>(backgroundColor),
                        ),
                        child: Text("Login", style: buttonSecondaryTextStyle.copyWith(
                          fontSize: 22, fontWeight: FontWeight.w600
                        ),),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LandingSignUp()));
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.symmetric(
                              vertical: 12, horizontal: 135), // Set the desired padding values
                        ),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(17), // Set the desired border radius
                          ),
                        ),
                        backgroundColor:
                        MaterialStateProperty.all<Color>(backgroundColor),
                      ),
                      child: Text("Sign Up", style: buttonSecondaryTextStyle.copyWith(
                          fontSize: 22, fontWeight: FontWeight.w600
                      ),),
                    ),
                  ],
                ),
              )
            ]
          ),
        ),
      ),
    );
  }
}
