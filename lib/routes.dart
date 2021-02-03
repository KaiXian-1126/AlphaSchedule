import 'package:alpha_schedule/auth/account_create_screen.dart';
import 'package:alpha_schedule/auth/login_screen.dart';
import 'package:alpha_schedule/auth/logout_screen.dart';
import 'package:alpha_schedule/landing/splash_screen.dart';
import 'package:alpha_schedule/landing/welcome_screen.dart';

import 'package:alpha_schedule/profile/event/add_collaborator_screen.dart';
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

Route<dynamic> createRoute(settings) {
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
        builder: (context) => DrawerScreen(),
      );
    //Auth routes
    case accountCreateRoute:
      return MaterialPageRoute(
        builder: (context) => AccountCreateScreen(),
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
        builder: (context) => CalendarCollaboratorScreen(
            calendar: settings.arguments[0],
            calendarOwner: settings.arguments[1]),
      );
    case calendarCreateRoute:
      return MaterialPageRoute(
        builder: (context) =>
            CalendarCreateScreen(calendar: settings.arguments),
      );
    case calendarSettingsRoute:
      return MaterialPageRoute(
        builder: (context) =>
            CalendarSettingScreen(calender: settings.arguments),
      );
    case eventCreateRoute:
      return MaterialPageRoute(
        builder: (context) => EventCreateScreen(
          event: settings.arguments[0],
          date: settings.arguments[1],
        ),
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
        builder: (context) => EventSummaryScreen(settings.arguments),
      );
    case passwordEditRoute:
      return MaterialPageRoute(
        builder: (context) => PasswordEditScreen(settings.arguments),
      );
    case profileEditRoute:
      return MaterialPageRoute(
        builder: (context) => ProfileEditScreen(settings.arguments),
      );
    case userProfileRoute:
      return MaterialPageRoute(
        builder: (context) => ProfileScreen(settings.arguments),
      );
    case addCollaboratorRoute:
      return MaterialPageRoute(
        builder: (context) => AddCollaboratorScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => AlphaSplashScreen(),
      );
  }
}
