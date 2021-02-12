import 'package:alpha_schedule/app/dependencies.dart';
import 'package:alpha_schedule/models/User.dart';
import 'package:alpha_schedule/services/user/user_service.dart';

import '../viewmodel.dart';

class ProfileViewmodel extends Viewmodel {
  User users;
  UserService get dataService => dependency();
  void getUserList({String id}) async {
    turnBusy();
    users = await dataService.getUser(id: id);
    turnIdle();
  }

  get rebuild => notifyListeners();
}
