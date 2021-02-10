import 'package:alpha_schedule/app/dependencies.dart';
import 'package:alpha_schedule/models/User.dart';

import 'package:alpha_schedule/services/user/user_service.dart';

import '../viewmodel.dart';

class AccountCreateViewmodel extends Viewmodel {
  List<User> users;
  UserService get dataService => dependency();

  void accountcreate(
      {String username,
      String uemail,
      uphone,
      upassword,
      ugender = "Male"}) async {
    await dataService.createUser(
      user: User(
        name: username,
        email: uemail,
        password: upassword,
        phone: uphone,
        gender: ugender,
        calendarList: [],
        collaboratorCalendarList: [],
      ),
    );
  }
  get rebuild => notifyListeners();
}
