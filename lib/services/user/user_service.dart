//import 'package:alpha_schedule/models/user.dart';

import 'package:alpha_schedule/models/User.dart';

abstract class UserService {
  Future<List<User>> getUserList();
  Future<User> getUser({String id});
  Future<User> createUser({User user});
  Future<User> updateUserProfile(
      {String id, String name, String email, String phone, String gender});
  Future<User> updateUserPassword({String id, String password});
}
