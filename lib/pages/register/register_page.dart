import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripusfrontend/bloc/user_bloc.dart';
import 'package:tripusfrontend/helper/theme.dart';
import 'package:tripusfrontend/helper/snackbar.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../helper/easy_loading.dart';
import '../login_page.dart';

// class RegisterPage extends StatefulWidget {
//   RegisterPage({super.key});

//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }


class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');

  String message = "null";

  bool hasNavigatedToVerify = false;

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
    handleRegister(String message) {

      FocusScope.of(context).unfocus();

      BlocProvider.of<UserBloc>(context).add(UserPostRegister(
        nameController.text,
        emailController.text,
        passwordController.text,
      ));

      print(message);
    }

    Widget header() {
      return Container(
        margin: EdgeInsets.only(top: 50),
        child: Image.asset('assets/image_standing.png'),
      );
    }

    Widget headerText() {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Sign Up",
                style: primaryTextStyle.copyWith(
                    fontSize: 32, fontWeight: extraBold)),
            Text(
              "Please fill in using your email address and input password",
              style: secondaryTextStyle.copyWith(fontSize: 12),
            )
          ],
        ),
      );
    }

    Widget nameInput() {
      return Container(
        margin: const EdgeInsets.only(top: 18, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name*",
              style: secondaryTextStyle.copyWith(fontSize: 14),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  border: Border.all(color: textSecondaryColor),
                  borderRadius: BorderRadius.circular(9)),
              child: TextFormField(
                controller: nameController,
                style: primaryTextStyle,
                decoration: InputDecoration.collapsed(
                    hintText: "your name",
                    hintStyle: hintTextStyle.copyWith(
                      fontSize: 14,
                    )),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      );
    }

    Widget emailInput() {
      return Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Email*",
              style: secondaryTextStyle.copyWith(fontSize: 14),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  border: Border.all(color: textSecondaryColor),
                  borderRadius: BorderRadius.circular(9)),
              child: TextFormField(
                controller: emailController,
                style: primaryTextStyle,
                decoration: InputDecoration.collapsed(
                    hintText: "name@gmail.com",
                    hintStyle: hintTextStyle.copyWith(
                      fontSize: 14,
                    )),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      );
    }

    Widget passwordInput() {
      return Container(
        margin: const EdgeInsets.only(top: 10, bottom: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Password*",
              style: secondaryTextStyle.copyWith(fontSize: 14),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  border: Border.all(color: textSecondaryColor),
                  borderRadius: BorderRadius.circular(9)),
              child: TextFormField(
                controller: passwordController,
                obscureText: true,
                style: primaryTextStyle,
                decoration: InputDecoration.collapsed(
                    hintText: "password",
                    hintStyle: hintTextStyle.copyWith(
                      fontSize: 14,
                    )),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      );
    }

    Widget footer() {
      return Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("You have an account?",
                style: secondaryTextStyle.copyWith(fontSize: 14)),
            const SizedBox(width: 2,),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/login'),
              child: Text("Login",
                  style: buttonSecondaryTextStyle.copyWith(fontSize: 14)),
            )
          ],
        ),
      );
    }

    Widget buttonContinue(String message) {
      return ElevatedButton(
        onPressed: () {
          if(nameController.text == ''){
            Loading.showInfo("Name field is required");
          }else if(emailController.text == ''){
            Loading.showInfo("Email field is required");
          }else if(passwordController.text == ''){
            Loading.showInfo("Password field is required");
          }
          else{
            handleRegister(message);
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
              "Continue",
              style: buttonPrimaryTextStyle.copyWith(
                  fontSize: 22, fontWeight: semibold),
            ),
            const SizedBox(
              width: 12,
            ),
            const Icon(
              Icons.arrow_forward,
              color: Colors.white,
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
            reverse: true,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: BlocConsumer<UserBloc, UserState>(
                    listener: (context, state) {},
                    builder: (context, state) {
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
                        hasNavigatedToVerify = true;
                        BlocProvider.of<UserBloc>(context)
                            .add(ResetStateEvent());
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          Navigator.pushNamed(context, '/verify').then((_) {
                            hasNavigatedToVerify = false;
                          });
                        });
                        EasyLoading.dismiss();
                      }
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            header(),
                            headerText(),
                            nameInput(),
                            emailInput(),
                            passwordInput(),
                            buttonContinue(message),
                            const SizedBox(height: 8,),
                            footer()
                          ],
                        ),
                      );
                    },
                  )),
            )),
      ),
    );
  }
}
