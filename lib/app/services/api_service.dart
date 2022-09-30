import '../config/config.dart';

class ApiService {
  static const login = "${AppConfig.baseUrl}login";
  static const register = "${AppConfig.baseUrl}register";
  static const logout = "${AppConfig.baseUrl}logout";
  static const updateProfile = "${AppConfig.baseUrl}profile/update";
}
