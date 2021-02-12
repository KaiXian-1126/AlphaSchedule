import 'package:alpha_schedule/app/dependencies.dart';
import 'package:alpha_schedule/models/user.dart';
import 'package:alpha_schedule/services/user/user_service.dart';

import '../../viewmodel.dart';

class ProfileEditViewmodel extends Viewmodel {
  List<User> user;
  UserService get dataService => dependency();

  updateUserProfile(
      {String id,
      String name,
      String email,
      String phone,
      String gender}) async {
    turnBusy();
    await dataService.updateUserProfile(
        id: id, name: name, email: email, phone: phone, gender: gender);
    turnIdle();
  }

  get rebuild => notifyListeners();
}
