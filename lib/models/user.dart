class User {
  String name;
  String email;
  String password;
  String phone;
  String gender;

  User({this.name, this.email, this.password, this.phone, this.gender});
  User.clone(User from)
      : this(
            name: from.name,
            email: from.email,
            password: from.password,
            phone: from.phone,
            gender: from.gender);
}
