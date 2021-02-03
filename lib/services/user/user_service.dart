//import 'package:alpha_schedule/models/user.dart';

import 'package:alpha_schedule/models/user_mock.dart';

abstract class UserService {
  Future<List<User>> getUserList();
  Future<User> getUser({String id});
  Future<User> createUser({User user});
  Future<User> updateUserProfile(
      {String id, String a, String b, int c, String d});
  Future<User> updateUserPassword({String id, String a});
}
