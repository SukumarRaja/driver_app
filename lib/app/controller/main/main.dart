import 'package:get/get.dart';

class MainController extends GetxController {
  static MainController get to => Get.put(MainController());

  final _changeIndex = 1.obs;

  get changeIndex => _changeIndex.value;

  set changeIndex(value) {
    _changeIndex.value = value;
  }

  final _statusCode = 0.obs;

  get statusCode => _statusCode.value;

  set statusCode(value) {
    _statusCode.value = value;
  }

  final _signUp = false.obs;

  get signUp => _signUp.value;

  set signUp(value) {
    _signUp.value = value;
  }
}
