import 'package:alpha_schedule/auth/account_create_screen.dart';
import 'package:alpha_schedule/auth/login_screen.dart';
import 'package:alpha_schedule/auth/logout_screen.dart';
import 'package:alpha_schedule/landing/splash_screen.dart';
import 'package:alpha_schedule/landing/welcome_screen.dart';
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
        builder: (context) => DrawerScreen(),
      );
    //Auth routes
    case accountCreateRoute:
      return MaterialPageRoute(
        builder: (context) => AccountCreateScreen(context),
      );
    case loginRoute:
      return MaterialPageRoute(
        builder: (context) => LoginScreen(context),
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
        builder: (context) => CalendarSettingScreen(),
      );
    case eventCreateRoute:
      return MaterialPageRoute(
        builder: (context) => EventCreateScreen(),
      );
    case eventDetailsRoute:
      return MaterialPageRoute(
        builder: (context) => EventDetailsScreen(),
      );
    case eventEditRoute:
      return MaterialPageRoute(
        builder: (context) => EventEditScreen(
            "title",
            TimeOfDay(hour: 9, minute: 36),
            TimeOfDay(hour: 16, minute: 44),
            "This is a description"),
      );
    case eventSearchRoute:
      return MaterialPageRoute(
        builder: (context) => EventSearchScreen(),
      );
    case eventSummaryRoute:
      return MaterialPageRoute(
        builder: (context) => EventSummaryScreen(context),
      );
    case passwordEditRoute:
      return MaterialPageRoute(
        builder: (context) => PasswordEditScreen(context),
      );
    case profileEditRoute:
      return MaterialPageRoute(
        builder: (context) => ProfileEditScreen(context),
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
