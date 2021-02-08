import 'package:alpha_schedule/app/dependencies.dart' as di;
import 'package:alpha_schedule/auth/account_create_screen.dart';
import 'package:alpha_schedule/constants.dart';
import 'package:alpha_schedule/models/User.dart';
import 'package:alpha_schedule/services/user/user_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen();

  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _nameFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();
  bool validated = true;

  User user;

  UserService dependency = di.dependency();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login With Your Account'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            BuildText("User Name"),
            Container(
                padding: EdgeInsets.all(10),
                child: Form(
                  key: _nameFormKey,
                  child: TextFormField(
                      keyboardType: TextInputType.name,
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "User Name cannot be empty";
                        } else {
                          return null;
                        }
                      }),
                )),
            SizedBox(
              height: 40,
            ),
            BuildText("Password"),
            Container(
                padding: EdgeInsets.all(10),
                child: Form(
                  key: _passwordFormKey,
                  child: TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Password cannot be empty";
                        } else {
                          return null;
                        }
                      }),
                )),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: SizedBox(
                child: validated
                    ? null
                    : Text(
                        "User Name or Password is not correct.",
                        style: TextStyle(color: Colors.red),
                      ),
                height: 40,
              ),
            ),
            Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: FlatButton(
                  textColor: Colors.white,
                  color: Colors.black,
                  child: Text('Login'),
                  onPressed: () async {
                    if (_nameFormKey.currentState.validate()) {
                      if (_passwordFormKey.currentState.validate()) {
                        final userList =
                            Provider.of<List<User>>(context, listen: false);
                        if (userList != null) {
                          for (int i = 0; i < userList.length; i++) {
                            if (userList[i].name == nameController.text &&
                                userList[i].password ==
                                    passwordController.text) {
                              validated = true;
                              final _user = Provider.of<ValueNotifier<User>>(
                                  context,
                                  listen: false);
                              _user.value = userList[i];

                              Navigator.popAndPushNamed(context, homeRoute);
                              break;
                            }
                            if (i == userList.length - 1) {
                              validated = false;
                              setState(() {});
                            }
                          }
                        }
                      }
                    }
                  },
                )),
            SizedBox(
              height: 30,
            ),
            Container(
                child: Row(
              children: <Widget>[
                Text('Does not have an account?'),
                FlatButton(
                  textColor: Colors.blue,
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, accountCreateRoute);
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ))
          ],
        ),
      ),
    );
  }
}

bool validateEmail(String email) {
  RegExp validation = RegExp(r'^[^@]+@[^@]+\.[^@]+');
  return (!validation.hasMatch(email)) ? false : true;
}

class BuildText extends StatelessWidget {
  final text;
  const BuildText(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 8, left: 8, right: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
