import 'package:alpha_schedule/app/dependencies.dart' as di;
import 'package:alpha_schedule/constants.dart';
import 'package:alpha_schedule/models/Calendar.dart';
import 'package:alpha_schedule/models/Event.dart';
import 'package:alpha_schedule/models/User.dart';

import 'package:alpha_schedule/routes.dart';

import 'package:alpha_schedule/services/user/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  di.init();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: createRoute,
      initialRoute: splashRoute,
      debugShowCheckedModeBanner: false,
      title: 'AlphaSchedule',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
