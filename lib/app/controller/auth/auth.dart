import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/repository/auth/auth.dart';
import '../../ui/screens/home/home_main.dart';
import '../../ui/screens/login/login.dart';
import '../../ui/widgets/common_print.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.put(AuthController());

  final repository = AuthRepository();

  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  TextEditingController name = TextEditingController();
  TextEditingController signUpEmail = TextEditingController();
  TextEditingController signUpPassword = TextEditingController();

  final _loginLoading = false.obs;

  get loginLoading => _loginLoading.value;

  set loginLoading(value) {
    _loginLoading.value = value;
  }

  final _logoutLoading = false.obs;

  get logoutLoading => _logoutLoading.value;

  set logoutLoading(value) {
    _logoutLoading.value = value;
  }

  // final _loginDetails = Data().obs;
  //
  // get loginDetails => _loginDetails.value;
  //
  // set loginDetails(value) {
  //   _loginDetails.value = value;
  // }

  final _isSignUp = false.obs;

  get isSignUp => _isSignUp.value;

  set isSignUp(value) {
    _isSignUp.value = value;
  }

  final _isOtpSend = false.obs;

  get isOtpSend => _isOtpSend.value;

  set isOtpSend(value) {
    _isOtpSend.value = value;
  }

  final _isResendOtp = true.obs;

  get isResendOtp => _isResendOtp.value;

  set isResendOtp(value) {
    _isResendOtp.value = value;
  }

  loginCheck() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString('token');
    if (kDebugMode) {
      print("token $token");
    }
    if (token != null && token.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  checkOnBoarding() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString('on_boarding');
    if (token == null) {
      return true;
    } else {
      return false;
    }
  }

  setOnBoardDataAfterScreenCompleted() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("on_boarding", "onBoarding");
    var onBoard = preferences.getString('on_boarding');
    if (kDebugMode) {
      print("on boarding data $onBoard");
    }
    await Get.off(() => const LoginPage());
    return onBoard;
  }

  storeLocalDevice({required Map body}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    body.forEach((key, value) {
      if (kDebugMode) {
        print('index=$key, value=$value');
      }
      preferences.setString(key, value);
    });
  }

  loginFieldsEmpty() {
    email.text = "";
    password.text = "";
  }

  login() async {
    loginLoading = true;
    try {
      Map<String, dynamic> bodyData = {
        "emailMobileUsername": email.text.trimRight(),
        "password": password.text.trimRight()
      };
      var res = await repository.login(bodyData: bodyData);
      if (res.status == "success") {
        loginLoading = false;
        Map storedData = {"token": "${res.data!.token}"};
        storeLocalDevice(body: storedData);
        commonPrint(status: "${res.status}", msg: "${res.message}");
        Get.off(() => const HomeMain());

        if (res.data == null) {
          commonPrint(status: "${res.status}", msg: "But No Data");
        } else if (res.data != null) {
          commonPrint(status: "${res.status}", msg: "${res.data}");
          // loginDetails = res.data;
        }
      } else {
        loginLoading = false;
        commonPrint(status: "${res.status}", msg: "${res.message}");
      }
    } catch (e) {
      loginLoading = false;
      if (kDebugMode) {
        print("Error from server on login");
      }
    }
  }

  clearToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('token');
    await Get.off(() => const LoginPage());
    // commonSnackBar(title: "Success", msg: "Logout Successfully");
  }

  logout() async {
    logoutLoading = true;
    try {
      var res = await repository.logout();
      if (res.status == "success") {
        logoutLoading = false;
        await clearToken();
        commonPrint(status: "${res.status}", msg: "${res.data}");
      } else {
        logoutLoading = false;
        commonPrint(status: "${res.status}", msg: "${res.data}");
      }
    } catch (e) {
      logoutLoading = false;
      commonPrint(status: "Failure", msg: "Error from server on logout $e");
    }
  }

  register() async {
    loginLoading = true;
    try {
      Map<String, dynamic> bodyData = {
        "firstName": name.text.trimRight(),
        "email": signUpEmail.text.trimRight(),
        "password": signUpPassword.text.trimRight()
      };

      var res = await repository.register(bodyData: bodyData);
      if (res.status == "success") {
        loginLoading = false;
        // Map storedData = {"token": "${res.data!.token}"};
        // storeLocalDevice(body: storedData);
        // commonPrint(status: "${res.status}", msg: "${res.message}");
        // Get.off(() => const HomeMain());
        if (res.data == null) {
          commonPrint(status: "${res.status}", msg: "But No Data");
        } else if (res.data != null) {
          commonPrint(status: "${res.status}", msg: "${res.data}");
          // loginDetails = res.data;
        }
      } else {
        loginLoading = false;
        commonPrint(status: "${res.status}", msg: "${res.message}");
      }
    } catch (e) {
      loginLoading = false;
      if (kDebugMode) {
        print("Error from server on register");
      }
    }
  }
}
