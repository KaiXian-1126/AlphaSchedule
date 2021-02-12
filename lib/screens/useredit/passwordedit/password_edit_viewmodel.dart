import 'package:alpha_schedule/app/dependencies.dart';
import 'package:alpha_schedule/models/user.dart';
import 'package:alpha_schedule/services/user/user_service.dart';

import '../../viewmodel.dart';

class PasswordEditViewmodel extends Viewmodel {
  List<User> user;
  UserService get dataService => dependency();

  updateUserPassword({String id, String password}) async {
    turnBusy();
    await dataService.updateUserPassword(id: id, password: password);
    turnIdle();
  }

  get rebuild => notifyListeners();
}
