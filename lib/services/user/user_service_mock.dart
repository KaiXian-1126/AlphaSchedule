import 'package:alpha_schedule/models/User.dart';
import 'package:alpha_schedule/models/mockdata.dart';

int _nextId = 5;

class UserServiceMock {
  List<User> getUserList() {
    return mockUsers;
  }

  User createUser({User user}) {
    user.userId = "1";
    mockUsers.add(user);
    return user;
  }
}
