import 'package:flutter/material.dart';

class AccountCreateScreen extends StatefulWidget {
  final _data;
  AccountCreateScreen(this._data);

  @override
  _AccountCreateScreen createState() => _AccountCreateScreen();
}

class _AccountCreateScreen extends State<AccountCreateScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmpasswordController = TextEditingController();
  final _nameFormKey = GlobalKey<FormState>();
  final _emailFormKey = GlobalKey<FormState>();
  final _phoneFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();
  final _confirmpasswordFormKey = GlobalKey<FormState>();
  List _genderDropDown = ['Male', 'Female'];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Create an Account'),
          leading: Icon(Icons.arrow_back),
        ),
        body: Container(
          // set margin of body
          margin: EdgeInsets.all(20),
          child: ListView(
            children: [
              // user name
              BuildText("User Name"),
              Container(
                padding: EdgeInsets.only(bottom: 15),
                child: Form(
                  key: _nameFormKey,
                  child: TextFormField(
                    controller: _nameController,
                    maxLines: 1,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "This field cannot be empty";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),

              //Email
              BuildText("Email"),
              Container(
                padding: EdgeInsets.only(bottom: 15),
                child: Form(
                  key: _emailFormKey,
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    maxLines: 1,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "This field cannot be empty";
                      } else if (!validateEmail(value)) {
                        return "Not a valid email";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),

              // Phone no
              BuildText("Phone No."),
              Container(
                padding: EdgeInsets.only(bottom: 15),
                child: Form(
                  key: _phoneFormKey,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _phoneController,
                    maxLines: 1,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "This field cannot be empty";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),

              // gender
              BuildText("Gender"),

              DropdownButtonFormField(
                decoration: InputDecoration(border: OutlineInputBorder()),
                dropdownColor: Colors.grey[200],
                elevation: 2,
                icon: Icon(Icons.arrow_drop_down),
                isExpanded: true,
                value: widget._data.gender,
                onChanged: (value) =>
                    setState(() => widget._data.gender = value),
                items: _genderDropDown.map((value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 15),
              BuildText("Password"),
              Container(
                padding: EdgeInsets.only(bottom: 15),
                child: Form(
                  key: _passwordFormKey,
                  child: TextFormField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "This field cannot be empty";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),
              BuildText("Confirm Password"),
              Container(
                padding: EdgeInsets.only(bottom: 15),
                child: Form(
                  key: _confirmpasswordFormKey,
                  child: TextFormField(
                    obscureText: true,
                    controller: _confirmpasswordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return "This field cannot be empty";
                      } else if (value != _passwordController.text) {
                        return "Password is not same";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BuildFlatButton(
          text: 'Sign up',
          color: Colors.black,
          onPressedCallback: () {
            // form validation
            if (_nameFormKey.currentState.validate()) {
              if (_emailFormKey.currentState.validate()) {
                if (_phoneFormKey.currentState.validate()) {
                  if (_passwordFormKey.currentState.validate()) {
                    if (_confirmpasswordFormKey.currentState.validate()) {
                      // can go to the home screen.
                    }
                  }
                }
              }
            }
          },
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

class BuildFlatButton extends StatelessWidget {
  final text, color, onPressedCallback;
  const BuildFlatButton(
      {this.text, this.color: Colors.grey, this.onPressedCallback});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 23, right: 23, top: 23, bottom: 50),
      height: 50,
      child: FlatButton(
        color: color,
        child: Text(
          text,
          style: TextStyle(fontSize: 20),
        ),
        onPressed: onPressedCallback,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }
}
