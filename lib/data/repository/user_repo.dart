import 'dart:convert';

import 'package:tripusfrontend/helper/theme.dart';
import 'package:tripusfrontend/data/models/user.dart';
import 'package:http/http.dart' as http;

import '../singleton/user_storage.dart';


abstract class UserRepository {
  Future<UserModel> register(
      String name,
      String email,
      String password,
     );
}

class UserRepositoryImpl extends UserRepository{
  @override
  Future<UserModel> register(
      String name,
      String email,
      String password,
      ) async {
    final response = await http.post(Uri.parse('$baseUrl/register'), body: {
      "name": name,
      "email": email,
      "password": password
    });
    print("response: ${response.body}");
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];

      UserModel user = UserModel.fromJson(data['user']);
      user.token = data['token_type'] + " " + data['access_token'];

      UserData.setToken(user.token);
      UserData.saveUser(user);

      return user;
    } else {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      List<dynamic> errors = responseData['data']['errors'].values.toList();
      String firstError = errors[0][0];
      throw Exception(firstError);
    }
  }

  Future<bool> verify(
      String otpCode
      ) async {
    String token = await UserData.getToken();

    final response = await http.post(Uri.parse('$baseUrl/verify'), body: {
      "otp_code": otpCode,
    }, headers: {'Authorization': token});
    print("response: ${response.body}");
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return true;
    } else {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      List<dynamic> errors = responseData['data']['errors'].values.toList();
      String firstError = errors[0][0];
      throw Exception(firstError);
    }
  }

  Future<UserModel> login(String email, password) async {
    final response = await http.post(Uri.parse('$baseUrl/login'), body: {
      "email": email,
      "password": password,
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = data['token_type'] + " " + data['access_token'];
      UserData.setToken(user.token);
      await UserData.updateUser(user); // save data user yang sudah login ke shared preference
      // print("UserData: ${UserData.user!.favorite![0].userId}");
      return user;
    } else {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      throw Exception(responseData['data']['errors']);
    }
  }

}