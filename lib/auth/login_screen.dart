import 'package:alpha_schedule/auth/account_create_screen.dart';
import 'package:alpha_schedule/models/mockdata.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final _data;
  LoginScreen(this._data);

  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _nameFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login With Your Account'),
          leading: Icon(
            Icons.arrow_back,
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
                            } else if (value != widget._data.name) {
                              return "Not a valid user name";
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
                            } else if (value != widget._data.password) {
                              return "Did not found username or password";
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
                            //Navigate to home screen
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
