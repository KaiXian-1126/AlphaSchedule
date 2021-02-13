import 'package:alpha_schedule/app/dependencies.dart';
import 'package:alpha_schedule/models/User.dart';
import 'package:alpha_schedule/screens/login/login_viewmodel.dart';
import 'package:alpha_schedule/screens/useredit/profileedit/profile_edit_viewmodel.dart';
import 'package:flutter/material.dart';

import '../../view.dart';

class ProfileEditScreen extends StatefulWidget {
  static Route<dynamic> route() =>
      MaterialPageRoute(builder: (_) => ProfileEditScreen());

  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  final _nameFormKey = GlobalKey<FormState>();
  final _emailFormKey = GlobalKey<FormState>();
  final _phoneFormKey = GlobalKey<FormState>();
  List _genderDropDown = ['Male', 'Female'];

  @override
  Widget build(BuildContext context) {
    User user = dependency<LoginViewmodel>().user;
    _nameController.text = user.name;
    _emailController.text = user.email;
    _phoneController.text = user.phone;

    return View<ProfileEditViewmodel>(builder: (context, viewmodel, _) {
      return Container(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Edit Profile'),
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
                      onChanged: (value) => user.name = value,
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
                      onChanged: (value) => user.email = value,
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
                      onChanged: (value) => user.phone = value,
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
                  value: user.gender,
                  onChanged: (value) => setState(() => user.gender = value),
                  items: _genderDropDown.map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          bottomNavigationBar: BuildFlatButton(
            text: 'Save',
            color: Colors.blue,
            onPressedCallback: () async {
              // form validation
              if (_nameFormKey.currentState.validate()) {
                if (_emailFormKey.currentState.validate()) {
                  if (_phoneFormKey.currentState.validate()) {
                    user.name = _nameController.text;
                    user.email = _emailController.text;
                    user.phone = _phoneController.text;

                    viewmodel.updateUserProfile(
                        id: "${user.userId}",
                        name: user.name,
                        email: user.email,
                        phone: user.phone,
                        gender: user.gender);
                    dependency<LoginViewmodel>().user.name = user.name;
                    dependency<LoginViewmodel>().user.email = user.email;
                    dependency<LoginViewmodel>().user.phone = user.phone;
                    dependency<LoginViewmodel>().user.gender = user.gender;
                    Navigator.pop(context, user);
                  }
                }
              }
            },
          ),
        ),
      );
    });
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
