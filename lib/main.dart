<<<<<<< HEAD
import 'package:alpha_schedule/routes.dart';

=======
import 'package:alpha_schedule/auth/logout_screen.dart';
import 'package:alpha_schedule/landing/splash_screen.dart';
import 'package:alpha_schedule/models/mockdata.dart';
import 'package:alpha_schedule/profile/event/calendar_collaborator_screen.dart';
import 'package:alpha_schedule/profile/event/event_create_screen.dart';
import 'package:alpha_schedule/profile/event/event_edit_screen.dart';
import 'package:alpha_schedule/profile/event/event_search_screen.dart';
import 'package:alpha_schedule/profile/event/event_summary_screen.dart';
import 'package:alpha_schedule/profile/user/password_edit_screen.dart';
import 'package:alpha_schedule/profile/user/profile_edit_screen.dart';

import 'models/mockdata.dart';
import 'profile/home_screen.dart';
>>>>>>> 4d1005b7623d122b509826451ed1c470b1b1698a
import 'package:flutter/material.dart';

<<<<<<< HEAD
void main() => runApp(MyApp());
=======
import 'profile/home_screen.dart';
import 'profile/user/user_profile_screen.dart';

void main() {
  runApp(MaterialApp(home: EventSummaryScreen(mycalender)));
}
>>>>>>> 4d1005b7623d122b509826451ed1c470b1b1698a

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: createRoute,
      debugShowCheckedModeBanner: false,
      title: 'AlphaSchedule',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
