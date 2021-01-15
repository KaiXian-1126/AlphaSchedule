import 'package:alpha_schedule/models/user.dart';
import 'package:alpha_schedule/services/user/user_service_mock.dart';
import 'package:alpha_schedule/app/dependencies.dart' as di;
import 'package:flutter/material.dart';

class AddCollaboratorScreen extends StatefulWidget {
  @override
  _AddCollaboratorScreenState createState() => _AddCollaboratorScreenState();
}

class _AddCollaboratorScreenState extends State<AddCollaboratorScreen> {
  TextEditingController _emailController = TextEditingController();
  UserServiceMock dependency = di.dependency();
  User invitedUser;
  final _emailFormKey = GlobalKey<FormState>();

  // check from list of user email.
  bool checkUserEmail(String email) {
    bool checkValue = false;
    final user = dependency.getUserList();
    for (int i = 0; i < user.length; i++) {
      if (email == user[i].email) {
        checkValue = true;
        invitedUser = user[i];
        break;
      } else {
        invitedUser = null;
        checkValue = false;
      }
    }
    return checkValue;
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(border: Border.all(), color: Colors.blue);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Collaborator'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Container(
          // set margin of body
          margin: EdgeInsets.all(20),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(top: 70),
                child: Icon(
                  Icons.people_alt_outlined,
                  size: 154,
                  color: Colors.blue,
                ),
              ),
              //Email
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.blue)),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: 20, bottom: 8, left: 8, right: 8),
                      child: Text(
                        "Enter Email",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
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
                            } else if (!checkUserEmail(_emailController.text)) {
                              return "Error! Unable to find this email";
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
              BuildFlatButton(
                text: 'Add',
                color: Colors.blue,
                onPressedCallback: () {
                  // form validation
                  if (_emailFormKey.currentState.validate()) {
                    Navigator.pop(context, invitedUser);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

bool validateEmail(String email) {
  RegExp validation = RegExp(r'^[^@]+@[^@]+\.[^@]+');
  return (!validation.hasMatch(email)) ? false : true;
}

class BuildFlatButton extends StatelessWidget {
  final text, color, onPressedCallback;
  const BuildFlatButton(
      {this.text, this.color: Colors.grey, this.onPressedCallback});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 3, right: 3, top: 23, bottom: 50),
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
