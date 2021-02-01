import 'package:alpha_schedule/models/User.dart';

abstract class UserService {
  Future<List<User>> getUser();
  Future<User> createUser({User user});
  Future<User> updateUser();
}
