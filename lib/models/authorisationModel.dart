import "package:flutter/cupertino.dart";

bool userAuthorisated = false;

String emailPattern =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
String passwordPattern =
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{3,}$';

class User {
  String name;
  String password;
  String email;

  User({@required this.email, @required this.name, @required this.password});
}

List<User> users = [
  User(email: "flavel@gmail.com", name: "Flavel", password: "1234"),
  User(email: "flovel@gmail.com", name: "Flovel", password: "12344")
];

String emailValidation(String email) {
  var contain = users.where((element) => element.email == email);
  if (contain.isNotEmpty) return "Email уже используется";
  if (!RegExp(emailPattern).hasMatch(email))
    return "Неправильный email";
  else
    return "ok";
}

bool nameValidation(String name) {
  var contain = users.where((element) => element.name == name);
  if (contain.isNotEmpty) return false;
  return true;
}

bool passwordValidation(String password) {
  if (!RegExp(passwordPattern).hasMatch(password)) return false;
  return true;
}

void registerUser(
    {@required String email,
    @required String name,
    @required String password}) {
  users.add(User(email: email, name: name, password: password));
}

String loginUser(String login, String password) {
  if (RegExp(emailPattern).hasMatch(login)) {
    var contain = users.where(
        (element) => element.email == login && element.password == password);
    return contain.isNotEmpty ? "ok" : "Логин или пароль неверный";
  } else {
    var contain = users.where(
        (element) => element.name == login && element.password == password);
    return contain.isNotEmpty ? "ok" : "Логин или пароль неверный";
  }
}
