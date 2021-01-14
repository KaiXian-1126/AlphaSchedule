import 'package:alpha_schedule/services/calendar/calendar_service_mock.dart';
import 'package:alpha_schedule/services/user/user_service_mock.dart';
import 'package:get_it/get_it.dart';

GetIt dependency = GetIt.instance;

void init() {
  dependency.registerLazySingleton(() => UserServiceMock());
  dependency.registerLazySingleton(() => CalendarServiceMock());
}
