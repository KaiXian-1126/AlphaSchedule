import 'package:alpha_schedule/models/User.dart';

abstract class UserService {
  Future<List<User>> getUser();
  Future<User> createUser({User user});
  Future<User> updateUserProfile(
      {String id, String a, String b, int c, String d});
  Future<User> updateUserPassword({String id, String a});
}
