import 'package:firebase_auth/firebase_auth.dart';
import 'package:todolist_provider/app/repository/user/user_repository.dart';
import 'package:todolist_provider/app/repository/user/user_repository_impl.dart';

import './user_service.dart';

class UserServiceImpl implements UserService {
  final UserRepository _userRepository;
  UserServiceImpl({required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<User?> register(String email, String password) =>
      _userRepository.register(email, password);
}
