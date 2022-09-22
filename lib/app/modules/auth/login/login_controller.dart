// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:todolist_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todolist_provider/app/exception/auth_exception.dart';

import 'package:todolist_provider/app/service/user/user_service.dart';

class LoginController extends DefaultChangeNotifier {
  final UserService _userService;
  LoginController({required UserService userService})
      : _userService = userService;

  Future<void> login(String email, String password) async {
    try {
      showLoadingAndResetState();
      notifyListeners();

      final user = await _userService.login(email, password);

      if (user != null) {
        sucess();
      } else {
        setError('Usuário ou senha inválidos');
      }
    } on AuthException catch (e) {
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
