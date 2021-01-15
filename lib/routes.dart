import 'package:alpha_schedule/auth/account_create_screen.dart';
import 'package:alpha_schedule/auth/login_screen.dart';
import 'package:alpha_schedule/auth/logout_screen.dart';
import 'package:alpha_schedule/landing/splash_screen.dart';
import 'package:alpha_schedule/landing/welcome_screen.dart';
import 'package:alpha_schedule/models/mockdata.dart';
import 'package:alpha_schedule/profile/event/calendar_collaborator_screen.dart';
import 'package:alpha_schedule/profile/event/calendar_create_screen.dart';
import 'package:alpha_schedule/profile/event/calendar_settings_screen.dart';
import 'package:alpha_schedule/profile/event/event_create_screen.dart';
import 'package:alpha_schedule/profile/event/event_details_screen.dart';
import 'package:alpha_schedule/profile/event/event_edit_screen.dart';
import 'package:alpha_schedule/profile/event/event_search_screen.dart';
import 'package:alpha_schedule/profile/event/event_summary_screen.dart';
import 'package:alpha_schedule/profile/home_screen.dart';
import 'package:alpha_schedule/profile/user/password_edit_screen.dart';
import 'package:alpha_schedule/profile/user/profile_edit_screen.dart';
import 'package:alpha_schedule/profile/user/user_profile_screen.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'models/mockdata.dart';

Route<dynamic> createRoute(settings) {
  print(settings.name);
  switch (settings.name) {
    //Landing routes
    case splashRoute:
      return MaterialPageRoute(
        builder: (context) => AlphaSplashScreen(),
      );
    case welcomeRoute:
      return MaterialPageRoute(
        builder: (context) => WelcomeScreen(),
      );
    case homeRoute:
      return MaterialPageRoute(
        builder: (context) => DrawerScreen(settings.arguments),
      );
    //Auth routes
    case accountCreateRoute:
      return MaterialPageRoute(
        builder: (context) => AccountCreateScreen(context),
      );
    case loginRoute:
      return MaterialPageRoute(
        builder: (context) => LoginScreen(),
      );
    case logoutRoute:
      return MaterialPageRoute(
        builder: (context) => LogoutScreen(),
      );
    //Profile routes
    case calendarCollaboratorRoute:
      return MaterialPageRoute(
        builder: (context) => CalendarCollaboratorScreen(),
      );
    case calendarCreateRoute:
      return MaterialPageRoute(
        builder: (context) => CalendarCreateScreen(),
      );
    case calendarSettingsRoute:
      return MaterialPageRoute(
        builder: (context) =>
            CalendarSettingScreen(calender: settings.arguments),
      );
    case eventCreateRoute:
      return MaterialPageRoute(
        builder: (context) => EventCreateScreen(),
      );
    case eventDetailsRoute:
      return MaterialPageRoute(
        builder: (context) => EventDetailsScreen(event: settings.arguments),
      );
    case eventEditRoute:
      return MaterialPageRoute(
        builder: (context) => EventEditScreen(event: settings.arguments),
      );
    case eventSearchRoute:
      return MaterialPageRoute(
        builder: (context) => EventSearchScreen(eventList: settings.arguments),
      );
    case eventSummaryRoute:
      return MaterialPageRoute(
        builder: (context) => EventSummaryScreen(mycalender),
      );
    case passwordEditRoute:
      return MaterialPageRoute(
        builder: (context) => PasswordEditScreen(mockData),
      );
    case profileEditRoute:
      return MaterialPageRoute(
        builder: (context) => ProfileEditScreen(mockData),
      );
    case userProfileRoute:
      return MaterialPageRoute(
        builder: (context) => ProfileScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => AlphaSplashScreen(),
      );
  }
}
