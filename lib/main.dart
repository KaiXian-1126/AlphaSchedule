import 'package:alpha_schedule/app/dependencies.dart' as di;
<<<<<<< HEAD
import 'package:alpha_schedule/models/user.dart';
=======
import 'package:alpha_schedule/models/User.dart';
import 'package:alpha_schedule/profile/home_screen.dart';
>>>>>>> remotes/origin/backend-kaixian
import 'package:alpha_schedule/routes.dart';
import 'package:alpha_schedule/services/user/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  di.init();
  runApp(
    MultiProvider(
      providers: [
        FutureProvider<List<User>>(
            create: (_) => di.dependency<UserService>().getUserList()),
        ChangeNotifierProvider<ValueNotifier<User>>(
          create: (_) => ValueNotifier<User>(null),
        ),
      ],
      child: MyApp(),
    ),
  );
}

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
