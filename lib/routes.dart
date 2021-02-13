import 'package:alpha_schedule/screens/event/event_create/event_create_view.dart';
import 'package:alpha_schedule/screens/event/event_detail/event_detail_view.dart';
import 'package:alpha_schedule/screens/event/event_edit/event_edit_view.dart';
import 'package:alpha_schedule/screens/event/event_search/event_search_view.dart';
import 'package:alpha_schedule/screens/home/home_view.dart';
import 'package:alpha_schedule/screens/event/event_summary/event_summary_view.dart';
import 'package:alpha_schedule/screens/login/login_view.dart';
import 'package:alpha_schedule/screens/calendar/calendar_create/calendar_create_view.dart';
import 'package:alpha_schedule/screens/calendar/calendar_setting/calendar_setting_view.dart';
import 'package:alpha_schedule/screens/calendar/calendar_collaborator/calendar_collaborator_view.dart';
import 'package:alpha_schedule/screens/calendar/add_collaborator/add_collaborator_view.dart';
import 'package:alpha_schedule/screens/createacc/acc_create_view.dart';
import 'package:alpha_schedule/screens/logout/logout_view.dart';
import 'package:alpha_schedule/screens/splash/splash_view.dart';
import 'package:alpha_schedule/screens/useredit/passwordedit/password_edit_view.dart';
import 'package:alpha_schedule/screens/userprofile/profile_view.dart';
import 'package:alpha_schedule/screens/useredit/profileedit/profile_edit_view.dart';
import 'package:alpha_schedule/screens/welcome/welcome_view.dart';

import 'package:flutter/material.dart';
import 'constants.dart';

Route<dynamic> createRoute(settings) {
  switch (settings.name) {
    //Landing routes
    case splashRoute:
      return AlphaSplashScreen.route();
    case welcomeRoute:
      return WelcomeScreen.route();
    case homeRoute:
      return DrawerScreen.route();
    //Auth routes
    case accountCreateRoute:
      return AccountCreateScreen.route();
    case loginRoute:
      return LoginScreen.route();
    case logoutRoute:
      return LogoutScreen.route();
    //Profile routes
    case calendarCollaboratorRoute:
      return CalendarCollaboratorScreen.route();

    case calendarCreateRoute:
      return CalendarCreateScreen.route();

    case calendarSettingsRoute:
      return CalendarSettingScreen.route();

    case eventCreateRoute:
      return MaterialPageRoute(
        builder: (context) => EventCreateScreen(
          date: settings.arguments,
        ),
      );
    case eventDetailsRoute:
      return EventDetailsScreen.route();
    case eventEditRoute:
      return EventEditScreen.route();
    case eventSearchRoute:
      return EventSearchScreen.route();

    case eventSummaryRoute:
      return EventSummaryScreen.route();
    case passwordEditRoute:
      return PasswordEditScreen.route();
    case profileEditRoute:
      return ProfileEditScreen.route();
    case userProfileRoute:
      return ProfileScreen.route();
    case addCollaboratorRoute:
      return AddCollaboratorScreen.route();

    default:
      return MaterialPageRoute(
        builder: (context) => AlphaSplashScreen(),
      );
  }
}
