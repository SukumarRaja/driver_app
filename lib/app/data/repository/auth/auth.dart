import 'dart:convert';
import '../../../services/api_service.dart';
import '../../../services/http_service.dart';

class AuthRepository {
  static final HttpHelper helper = HttpHelper();

  Future<dynamic> login({required bodyData}) async {
    var res = await helper.post(url: ApiService.login, body: bodyData);
    // LoginRes response = LoginRes.fromMap(jsonDecode(res));
    var response = jsonDecode(res);
    return response;
  }

  Future<dynamic> register({required bodyData}) async {
    var res = await helper.post(url: ApiService.register, body: bodyData);
    // LoginRes response = LoginRes.fromMap(jsonDecode(res));
    var response = jsonDecode(res);

    return response;
  }

  Future<dynamic> logout() async {
    var res = await helper.get(url: ApiService.logout, auth: true);
    // LoginRes response = LoginRes.fromMap(jsonDecode(res));
    var response = jsonDecode(res);

    return response;
  }
}
