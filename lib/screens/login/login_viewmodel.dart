import 'package:alpha_schedule/screens/viewmodel.dart';
import '../../app/dependencies.dart';
import '../../services/user/user_service.dart';
import '../../models/User.dart';

class LoginViewmodel extends Viewmodel {
  List<User> users = [];
  int _selected;
  UserService get dataService => dependency();

  void getUserList() async {
    turnBusy();
    users = await dataService.getUserList();
    _selected = null;
    turnIdle();
  }

  User get user =>
      (users != null) && (_selected != null) ? users[_selected] : null;

  bool login({String email, String password}) {
    for (int i = 0; i < users.length; i++) {
      if (users[i].email == email) {
        if (users[i].password == password) {
          _selected = i;
          return true;
        }
      }
    }
    return false;
  }

  get rebuild => notifyListeners();
}
