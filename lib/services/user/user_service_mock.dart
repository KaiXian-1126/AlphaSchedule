import 'package:alpha_schedule/models/user_mock.dart';
import 'package:alpha_schedule/models/mockdata.dart';

int _nextId = 5;

class UserServiceMock {
  List<User> getUserList() {
    return mockUsers;
  }

  User createUser({User user}) {
    user.userId = _nextId++;
    mockUsers.add(user);
    return user;
  }
}
