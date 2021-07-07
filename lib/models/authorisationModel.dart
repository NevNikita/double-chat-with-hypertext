import "package:flutter/cupertino.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

bool userAuthorisated = false;

String emailPattern =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
String passwordPattern =
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{3,}$';

String easyPasswordPatter = r'/./g';

final _auth = FirebaseAuth.instance;

class User {
  String name;
  String password;
  String email;

  User({@required this.email, @required this.name, @required this.password});
}

Future<bool> loginUser(String login, String password) async {
  if (!RegExp(emailPattern).hasMatch(login)) {
    await _auth.signInWithEmailAndPassword(email: login, password: password);
    return true;
  } else {
    return false;
  }
}
