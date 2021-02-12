import 'package:alpha_schedule/app/dependencies.dart' as di;
import 'package:alpha_schedule/constants.dart';
import 'package:alpha_schedule/models/User.dart';
import 'package:alpha_schedule/screens/login/login_viewmodel.dart';
import 'package:alpha_schedule/screens/view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (_) => LoginScreen());
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final _emailFormKey = GlobalKey<FormState>();
    final _passwordFormKey = GlobalKey<FormState>();
    bool validated = true;
    return Scaffold(
      appBar: AppBar(
        title: Text('Login With Your Account'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: View<LoginViewmodel>(
          initViewmodel: (viewmodel) => viewmodel.getUserList(),
          builder: (context, viewmodel, _) {
            return Container(
              margin: EdgeInsets.all(10),
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  BuildText("User Email"),
                  Container(
                      padding: EdgeInsets.all(10),
                      child: Form(
                        key: _emailFormKey,
                        child: TextFormField(
                            keyboardType: TextInputType.name,
                            controller: emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Email cannot be empty";
                              } else if (!validateEmail(value)) {
                                return "Not a valid email";
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
                              "Email or Password is not correct.",
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
                        if (_emailFormKey.currentState.validate()) {
                          if (_passwordFormKey.currentState.validate()) {
                            validated = viewmodel.login(
                                email: emailController.text,
                                password: passwordController.text);
                            if (validated) {
                              Navigator.popAndPushNamed(context, homeRoute);
                            } else {
                              viewmodel.rebuild();
                            }
                          }
                        }
                      },
                    ),
                  ),
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
            );
          }),
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
