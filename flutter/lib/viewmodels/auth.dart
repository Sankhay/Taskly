import 'package:taskly/services/auth.dart';
import '../models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel {
  final AuthService _authService = AuthService();

  Future<bool> login(String email, String password)async {

    final user = UserLoginDTO(email: email, password: password);
    final response = await _authService.login(user);

    if (response.statusCode == 200) {
        final authorizationToken = response.headers['authorization']!;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("authorizationToken", authorizationToken);
        return true;
    }
    return false;
  }

  Future<bool> register(String name, String email ,String password) async {

    final user = User(name: name, password: password, email: email);
    final response = await _authService.register(user);

    if (response.statusCode == 201) {
        return true;
    }
    return false;
  }
}
