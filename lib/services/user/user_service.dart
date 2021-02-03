<<<<<<< HEAD
import 'package:alpha_schedule/models/user.dart';
=======
//import 'package:alpha_schedule/models/user.dart';

import 'package:alpha_schedule/models/User.dart';
>>>>>>> remotes/origin/backend-kaixian

abstract class UserService {
  Future<List<User>> getUserList();
  Future<User> getUser({String id});
  Future<User> createUser({User user});
  Future<User> updateUserProfile(
      {String id, String a, String b, int c, String d});
  Future<User> updateUserPassword({String id, String a});
}
