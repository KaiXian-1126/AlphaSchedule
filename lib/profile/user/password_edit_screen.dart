import 'package:flutter/material.dart';

class PasswordEditScreen extends StatefulWidget {
  final _data;
  PasswordEditScreen(this._data);

  @override
  _PasswordEditScreenState createState() => _PasswordEditScreenState();
}

class _PasswordEditScreenState extends State<PasswordEditScreen> {
  TextEditingController _pwCurrentController = TextEditingController();
  TextEditingController _pwNewController = TextEditingController();
  TextEditingController _pwComfirmController = TextEditingController();
  final _pwCurrentFormKey = GlobalKey<FormState>();
  final _pwNewFormKey = GlobalKey<FormState>();
  final _pwComfirmFormKey = GlobalKey<FormState>();
  bool _secureCurrent = true;
  bool _secureNew = true;
  bool _secureComfirm = true;

  bool get secureCurrent => _secureCurrent;
  set secureCurrent(bool value) => setState(() => _secureCurrent = !value);
  bool get secureNew => _secureNew;
  set secureNew(bool value) => setState(() => _secureNew = !value);
  bool get secureComfirm => _secureComfirm;
  set secureComfirm(bool value) => setState(() => _secureComfirm = !value);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Change Password'),
          leading: Icon(Icons.arrow_back),
        ),
        body: Container(
          // set margin of body
          margin: EdgeInsets.all(20),
          child: ListView(
            children: [
              // old password
              BuildText("Enter current password"),
              UserInputbar(
                keys: _pwCurrentFormKey,
                controllers: _pwCurrentController,
                datas: widget._data.password,
                secures: _secureCurrent,
                index: 1,
                states: this,
              ),
              // new password
              BuildText("Enter new password"),
              UserInputbar(
                keys: _pwNewFormKey,
                controllers: _pwNewController,
                datas: widget._data.password,
                secures: _secureNew,
                index: 2,
                states: this,
              ),
              // Comfirm password
              BuildText("Comfirm new password"),
              UserInputbar(
                keys: _pwComfirmFormKey,
                controllers: _pwComfirmController,
                datas: _pwNewController.text,
                secures: _secureComfirm,
                index: 3,
                states: this,
              ),
            ],
          ),
        ),
        bottomNavigationBar: BuildFlatButton(
          text: 'Save',
          color: Colors.blue,
          onPressedCallback: () {
            // form validation
            if (_pwCurrentFormKey.currentState.validate()) {
              if (_pwNewFormKey.currentState.validate()) {
                if (_pwComfirmFormKey.currentState.validate()) {
                  widget._data.password = _pwNewController.text;
                  // Navigator.pop(context, widget._data);

                  // later make a alert box to prompt user
                }
              }
            }
          },
        ),
      ),
    );
  }
}

// function
String currentPassword(value, userPassword) {
  if (value.isEmpty) {
    return "This field cannot be empty";
  } else if (value != userPassword) {
    return "Incorrect password";
  } else {
    return null;
  }
}

String newPassword(value, userPassword) {
  if (value.isEmpty) {
    return "This field cannot be empty";
  } else if (value == userPassword) {
    return "New password cannot be same be current password";
  } else if (value.length < 8) {
    return "The password length must be atleast 8 character";
  } else {
    return null;
  }
}

String comfirmPassword(value, newPassword) {
  if (value.isEmpty) {
    return "This field cannot be empty";
  } else if (value != newPassword) {
    return "You must enter the same password in order to confirm it";
  } else {
    return null;
  }
}

class UserInputbar extends StatelessWidget {
  final keys, secures, controllers, datas, index, states;

  UserInputbar(
      {this.keys,
      this.secures,
      this.controllers,
      this.datas,
      this.index,
      this.states});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 15),
      child: Form(
        key: keys,
        child: TextFormField(
          obscureText: secures,
          controller: controllers,
          maxLines: 1,
          decoration: InputDecoration(
            suffixIcon: IconButton(
                icon: Icon(secures ? Icons.remove_red_eye : Icons.security),
                onPressed: () {
                  if (index == 1)
                    states.secureCurrent = secures;
                  else if (index == 2)
                    states.secureNew = secures;
                  else
                    states.secureComfirm = secures;
                }),
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (index == 1)
              return currentPassword(value, datas);
            else if (index == 2)
              return newPassword(value, datas);
            else
              return comfirmPassword(value, datas);
          },
        ),
      ),
    );
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
