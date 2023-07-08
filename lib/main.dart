import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tripusfrontend/bloc/user_bloc.dart';
import 'package:tripusfrontend/data/repository/user_repo.dart';
import 'package:tripusfrontend/pages/main_page.dart';
import 'package:tripusfrontend/pages/register_page.dart';
import 'package:tripusfrontend/pages/splash_page.dart';
import 'package:tripusfrontend/pages/verify_page.dart';


void main() {
  runApp(MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.blue.withOpacity(0.3)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {

  final UserRepositoryImpl userRepository = UserRepositoryImpl();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      routes: {
        '/': (context) => MainPage(),
        '/register': (context) => BlocProvider<UserBloc>(
              create: (context) => UserBloc(userRepository),
              child: RegisterPage(),
            ),
        '/verify': (context) => BlocProvider<UserBloc>(
          create: (context) => UserBloc(userRepository),
          child: VerifyPage(),
        ),
      },
    );
  }
}
