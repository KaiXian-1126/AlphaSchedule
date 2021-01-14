import 'package:alpha_schedule/app/dependencies.dart' as di;
import 'package:alpha_schedule/auth/account_create_screen.dart';
import 'package:alpha_schedule/constants.dart';
import 'package:alpha_schedule/models/mockdata.dart';
import 'package:alpha_schedule/models/user.dart';
import 'package:alpha_schedule/services/user/user_service_mock.dart';
import 'package:flutter/material.dart';

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
  bool validated = false;
  User user;
  UserServiceMock dependency = di.dependency();
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
                SizedBox(
                  height: 40,
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.black,
                      child: Text('Login'),
                      onPressed: () {
                        if (_nameFormKey.currentState.validate()) {
                          if (_passwordFormKey.currentState.validate()) {
                            final userList = dependency.getUserList();
                            if (userList != null) {
                              userList.forEach((e) {
                                if (e.name == nameController.text &&
                                    e.password == passwordController.text) {
                                  Navigator.popAndPushNamed(context, homeRoute,
                                      arguments: e);
                                }
                              });
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AccountCreateScreen(mockData)));
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ))
              ],
            )));
  }
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
