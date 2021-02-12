import 'package:alpha_schedule/screens/event/event_create/event_create_viewmodel.dart';
import 'package:alpha_schedule/screens/event/event_detail/event_detail_viewmodel.dart';
import 'package:alpha_schedule/screens/event/event_edit/event_edit_viewmodel.dart';
import 'package:alpha_schedule/screens/createacc/acc_create_viewmodel.dart';
import 'package:alpha_schedule/screens/event/event_search/event_search_viewmodel.dart';
import 'package:alpha_schedule/screens/home/home_viewmodel.dart';
import 'package:alpha_schedule/screens/event/event_summary/event_summary_viewmodel.dart';
import 'package:alpha_schedule/screens/login/login_viewmodel.dart';
import 'package:alpha_schedule/screens/calendar/calendar_create/calendar_create_viewmodel.dart';
import 'package:alpha_schedule/screens/calendar/calendar_setting/calendar_setting_viewmodel.dart';
import 'package:alpha_schedule/screens/calendar/calendar_collaborator/calendar_collaborator_viewmodel.dart';
import 'package:alpha_schedule/screens/calendar/add_collaborator/add_collaborator_viewmodel.dart';
import 'package:alpha_schedule/screens/useredit/passwordedit/password_edit_viewmodel.dart';
import 'package:alpha_schedule/screens/useredit/profileedit/profile_edit_viewmodel.dart';
import 'package:alpha_schedule/screens/userprofile/profile_viewmodel.dart';
import 'package:alpha_schedule/services/calendar/calendar_service.dart';
import 'package:alpha_schedule/services/calendar/calendar_service_rest.dart';
import 'package:alpha_schedule/services/event/event_service.dart';
import 'package:alpha_schedule/services/event/event_service_rest.dart';
import 'package:alpha_schedule/services/rest_service.dart';
import 'package:alpha_schedule/services/user/user_service.dart';
import 'package:alpha_schedule/services/user/user_service_rest.dart';
import 'package:get_it/get_it.dart';

GetIt dependency = GetIt.instance;

void init() {
  //Services
  dependency.registerLazySingleton<RestService>(() => RestService());
  dependency.registerLazySingleton<UserService>(() => UserServiceRest());
  dependency
      .registerLazySingleton<CalendarService>(() => CalendarServiceRest());
  dependency.registerLazySingleton<EventService>(() => EventServiceRest());

  //Viewmodels
  dependency.registerLazySingleton(() => LoginViewmodel());
  dependency.registerLazySingleton(() => HomeViewmodel());
  dependency.registerLazySingleton(() => EventSearchViewmodel());
  dependency.registerLazySingleton(() => AccountCreateViewmodel());
  dependency.registerLazySingleton(() => EventSummaryViewmodel());
  dependency.registerLazySingleton(() => CalendarCreateViewmodel());
  dependency.registerLazySingleton(() => CalendarSettingViewmodel());
  dependency.registerLazySingleton(() => CalendarCollaboratorViewmodel());
  dependency.registerLazySingleton(() => AddCollaboratorViewmodel());
  dependency.registerLazySingleton(() => EventCreateViewmodel());
  dependency.registerLazySingleton(() => EventDetailsViewmodel());
  dependency.registerLazySingleton(() => EventEditViewmodel());
  dependency.registerLazySingleton(() => ProfileViewmodel());
  dependency.registerLazySingleton(() => ProfileEditViewmodel());
  dependency.registerLazySingleton(() => PasswordEditViewmodel());
}
