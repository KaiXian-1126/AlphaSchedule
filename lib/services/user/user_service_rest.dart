import 'package:alpha_schedule/app/dependencies.dart';
import 'package:alpha_schedule/models/User.dart';
import 'package:alpha_schedule/services/rest_service.dart';
import 'package:alpha_schedule/services/user/user_service.dart';

class UserServiceRest implements UserServive {
  final rest = dependency<RestService>();
  Future<List<User>> getUser() async {
    final result = await rest.get("user");
    return (result as List).map((e) => User.fromJson(e)).toList();
  }

  Future<User> createUser() async {
    final result = await rest.post("user/create");
    //Need to do validation to ensure the email is unique.
    return User.fromJson(result);
  }

  Future<User> updateUserProfile(
      {String id, String a, String b, int c, String d}) async {
    final result = await rest.patch('user/$id',
        data: {'name': a, 'email': b, 'phone': c, 'gender': d});
    return User.fromJson(result);
  }

  Future<User> updateUserPassword({String id, String a}) async {
    final result = await rest.patch('user/$id', data: {'password': a});
    return User.fromJson(result);
  }
}
