import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tripusfrontend/helper/easy_loading.dart';
import 'package:tripusfrontend/helper/theme.dart';

import '../bloc/user_bloc.dart';
import '../data/models/user.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({super.key});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  TextEditingController otp1 = TextEditingController(text: '');
  TextEditingController otp2 = TextEditingController(text: '');
  TextEditingController otp3 = TextEditingController(text: '');
  TextEditingController otp4 = TextEditingController(text: '');

  Timer? _timer;
  String otp = "";

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
    void handleVerify() {
      otp = otp1.text + otp2.text + otp3.text + otp4.text;
      print("otp: $otp");
      BlocProvider.of<UserBloc>(context).add(UserVerifyEvent(
          otp
      ));
    }

    Widget header() {
      return Container(
        margin: const EdgeInsets.only(bottom: 166, left: 10),
        child: Row(children: [
          IconButton(
              onPressed: () => Navigator.pushNamed(context, '/'),
              icon: const Icon(Icons.arrow_back)),
          Text(
            "OTP Verification",
            style: primaryTextStyle.copyWith(
                fontSize: 18, fontWeight: FontWeight.bold),
          )
        ]),
      );
    }

    Widget headerInput() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "OTP",
              style: buttonSecondaryTextStyle.copyWith(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "We have send OTP to your email, check your email message",
              style: secondaryTextStyle,
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 25),
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      color: Color(0xffE7E7E7),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: TextFormField(
                      controller: otp1,
                      style: primaryTextStyle,
                      decoration: InputDecoration.collapsed(
                          hintText: "",
                          hintStyle: hintTextStyle.copyWith(
                            fontSize: 20,
                          )),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      autofocus: true,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 25),
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      color: Color(0xffE7E7E7),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: TextFormField(
                      controller: otp2,
                      style: primaryTextStyle,
                      decoration: InputDecoration.collapsed(
                          hintText: "",
                          hintStyle: hintTextStyle.copyWith(
                            fontSize: 20,
                          )),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      autofocus: true,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 25),
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      color: Color(0xffE7E7E7),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: TextFormField(
                      controller: otp3,
                      style: primaryTextStyle,
                      decoration: InputDecoration.collapsed(
                          hintText: "",
                          hintStyle: hintTextStyle.copyWith(
                            fontSize: 20,
                          )),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      autofocus: true,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      color: Color(0xffE7E7E7),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: TextFormField(
                      controller: otp4,
                      style: primaryTextStyle,
                      decoration: InputDecoration.collapsed(
                          hintText: "",
                          hintStyle: hintTextStyle.copyWith(
                            fontSize: 20,
                          )),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      autofocus: true,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }

    Widget footer() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Didn’t receive a OTP?",
              style: secondaryTextStyle.copyWith(fontSize: 14)),
          TextButton(
            onPressed: () {},
            child: Text("Resend OTP",
                style: buttonSecondaryTextStyle.copyWith(fontSize: 14)),
          )
        ],
      );
    }

    Widget buttonSend() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: ElevatedButton(
          onPressed: () {
            if (otp1.text == "" ||
                otp2.text == "" ||
                otp3.text == "" ||
                otp4.text == "") {
              Loading.showInfo("Sorry, the code is wrong");
            } else {
              handleVerify();
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
                "Send Verification",
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
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
          child: Container(
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
                  // hasNavigatedToVerify = true;
                  // BlocProvider.of<UserBloc>(context)
                  //     .add(ResetStateEvent());
                  // SchedulerBinding.instance.addPostFrameCallback((_) {
                  //   Navigator.pushNamed(context, '/verify').then((_) {
                  //     hasNavigatedToVerify = false;
                  //   });
                  // });
                  _timer?.cancel();
                  EasyLoading.instance
                    ..loadingStyle = EasyLoadingStyle.custom
                    ..backgroundColor = Colors.black;
                  EasyLoading.showSuccess(
                    'Email verified successfully',
                  );
                  EasyLoading.dismiss();
                }
                return Column(
                  children: [header(), headerInput(), footer(), buttonSend()],
                );
              },
            ),
          )),
    );
  }
}
