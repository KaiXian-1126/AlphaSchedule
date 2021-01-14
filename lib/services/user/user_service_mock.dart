import 'package:alpha_schedule/app/dependencies.dart';
import 'package:alpha_schedule/models/mockdata.dart';
import 'package:alpha_schedule/models/user.dart';
import 'package:alpha_schedule/services/user/user_service.dart';

class UserServiceMock implements UserServive {
  Future<List<User>> getUserList() async {
    final mockData = await mockUsers;
    return mockData;
  }

  Future<List<User>> getUser() {
    return null;
  }

  Future<User> createUser() {
    return null;
  }

  Future<User> updateUser() {
    return null;
  }
}
