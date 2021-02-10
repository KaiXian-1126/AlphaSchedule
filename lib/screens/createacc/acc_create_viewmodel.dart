import 'package:alpha_schedule/app/dependencies.dart';
import 'package:alpha_schedule/models/User.dart';

import 'package:alpha_schedule/services/user/user_service.dart';

import '../viewmodel.dart';

class AccountCreateViewmodel extends Viewmodel {
  List<User> users;
  UserService get dataService => dependency();

  createUser({User user}) async {
    turnBusy();
    await dataService.createUser(user: user);
    turnIdle();
  }

  get rebuild => notifyListeners();
}
