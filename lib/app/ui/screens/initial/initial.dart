import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/auth/auth.dart';
import '../home/home_main.dart';
import '../login/login.dart';
import '../on_boarding/on_boarding.dart';


class InitialLoginTest extends StatefulWidget {
  const InitialLoginTest({Key? key}) : super(key: key);

  @override
  _InitialLoginTestState createState() => _InitialLoginTestState();
}

class _InitialLoginTestState extends State<InitialLoginTest> {
  String? isLogin;

  @override
  Widget build(BuildContext context) {
    print('initial auth test');
    return Scaffold(
      body: GetBuilder<AuthController>(
          init: AuthController(),
          initState: (state) async {
            bool login = await AuthController.to.loginCheck();
            print("auth token value $login");
            bool onBoarding = await AuthController.to.checkOnBoarding();
            print("onBoarding value $onBoarding");
            if (onBoarding == true) {
              setState(() {
                isLogin = 'onBoarding';
              });
            } else if (login == true) {
              setState(() {
                isLogin = "isLogin";
              });
            } else {
              print("logged in $isLogin");
            }
          },
          builder: (controller) => isLogin == "onBoarding"
              ? const OnBoardingPage()
              : isLogin == "isLogin"
              ? const HomeMain()
              : const LoginPage()),
    );
  }
}
