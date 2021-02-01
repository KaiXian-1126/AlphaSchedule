import 'package:alpha_schedule/services/calendar/calendar_service_mock.dart';
import 'package:alpha_schedule/services/rest_service.dart';
import 'package:alpha_schedule/services/user/user_service.dart';
import 'package:alpha_schedule/services/user/user_service_rest.dart';
import 'package:get_it/get_it.dart';

GetIt dependency = GetIt.instance;

void init() {
  dependency.registerLazySingleton<RestService>(() => RestService());
  dependency.registerLazySingleton<UserService>(() => UserServiceRest());
  dependency.registerLazySingleton(() => CalendarServiceMock());
}
