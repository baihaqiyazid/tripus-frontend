import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../bloc/user_bloc.dart';
import '../helper/easy_loading.dart';
import '../helper/theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');

  Timer? _timer;

  void initState() {
    super.initState();
    EasyLoading.addStatusCallback((status) {
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    handleLogin() {
      FocusScope.of(context).unfocus();

      BlocProvider.of<UserBloc>(context).add(UserPostLogin(
        emailController.text,
        passwordController.text,
      ));
    }

    Widget emailInput() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            border: Border.all(color: textSecondaryColor),
            borderRadius: BorderRadius.circular(9)),
        child: TextFormField(
          controller: emailController,
          style: primaryTextStyle,
          decoration: InputDecoration.collapsed(
              hintText: "Email",
              hintStyle: hintTextStyle.copyWith(
                fontSize: 14,
              )),
          textAlign: TextAlign.start,
        ),
      );
    }

    Widget passwordInput() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            border: Border.all(color: textSecondaryColor),
            borderRadius: BorderRadius.circular(9)),
        child: TextFormField(
          controller: passwordController,
          style: primaryTextStyle,
          obscureText: true,
          decoration: InputDecoration.collapsed(
              hintText: "password",
              hintStyle: hintTextStyle.copyWith(
                fontSize: 14,
              )),
          textAlign: TextAlign.start,
        ),
      );
    }

    Widget buttonLogin() {
      return Container(
        margin: EdgeInsets.only(top: 16, left: 30, right: 30),
        child: ElevatedButton(
          onPressed: () {
            if (emailController.text.isEmpty) {
              Loading.showInfo("Email field is required");
            } else if (!EmailValidator.validate(emailController.text)) {
              Loading.showInfo("Incorrect email format");
            } else if (passwordController.text.isEmpty) {
              Loading.showInfo("Password field is required");
            } else {
              handleLogin();
            }
          },
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(
                  vertical: 12), // Set the desired padding values
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(17), // Set the desired border radius
              ),
            ),
            backgroundColor:
            MaterialStateProperty.all<Color>(textButtonSecondaryColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login",
                style: buttonPrimaryTextStyle.copyWith(
                    fontSize: 22, fontWeight: semibold),
              ),
              SizedBox(
                width: 12,
              ),
              Icon(
                Icons.arrow_forward_sharp,
                color: Colors.white,
              )
            ],
          ),
        ),
      );
    }

    Widget footer() {
      return Container(
          margin: EdgeInsets.only(left: 30, top: 16, right: 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Forgot Password",
                      style: secondaryTextStyle.copyWith(fontSize: 14)),
                  SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      print("di tap");
                    },
                    child: Text(
                      "Get New",
                      style: buttonSecondaryTextStyle.copyWith(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("You don't have an account?",
                      style: secondaryTextStyle.copyWith(fontSize: 14)),
                  SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Text(
                      "Sign Up",
                      style: buttonSecondaryTextStyle.copyWith(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ));
    }

    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            reverse: true,
            child: SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              child: Container(
                margin: EdgeInsets.only(top: 53),
                child: SingleChildScrollView(
                  child: BlocConsumer<UserBloc, UserState>(
                    listener: (context, state) {
                      if (state is UserPostError) {
                        _timer?.cancel();
                        EasyLoading.instance
                          ..loadingStyle = EasyLoadingStyle.custom
                          ..backgroundColor = Colors.redAccent;
                        EasyLoading.showError(state.code,
                            maskType: EasyLoadingMaskType.black);
                        EasyLoading.dismiss();
                      } else if (state is UserPostLoading) {
                        _timer?.cancel();
                        EasyLoading.instance
                          ..loadingStyle = EasyLoadingStyle.custom
                          ..backgroundColor = Colors.black;
                        EasyLoading.show(
                          status: 'loading...',
                        );
                        print('EasyLoading show');
                      } else if (state is UserPostSuccess) {
                        print("success");
                        Navigator.pushNamed(context, '/home');
                        EasyLoading.dismiss();
                      }
                    },
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(child: Image.asset('assets/walking.png')),
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: Text(
                                "Login",
                                style: primaryTextStylePlusJakartaSans.copyWith(
                                    fontWeight: FontWeight.w800, fontSize: 32),
                              )),
                          emailInput(),
                          passwordInput(),
                          buttonLogin(),
                          // Footer()
                          footer(),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
