import 'package:taskly/models/user.dart';
import 'package:taskly/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  Future login(UserLoginDTO user) async {
      return await http.post(
        Uri.parse("${Constants.apiUrl}/auth/login"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user)
      ).timeout(Constants.returnApiTimeoutDuration);
    }

  Future register(User user) async {

      return await http.post(
        Uri.parse("${Constants.apiUrl}/auth/register"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user)
      ).timeout(Constants.returnApiTimeoutDuration);
}
} 
