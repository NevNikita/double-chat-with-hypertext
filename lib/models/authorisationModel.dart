import "package:flutter/cupertino.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
=======
>>>>>>> 20959eae8b38e8f742170a304190c18cad15c829

bool userAuthorisated = false;

String emailPattern =
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
String passwordPattern =
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{3,}$';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

class User {
  String name;
  String password;
  String email;

  User({@required this.email, @required this.name, @required this.password});
}

<<<<<<< HEAD
=======
CollectionReference<Map<String, String>> users = _firestore.collection('users');

Future<String> emailValidation(String email) async {
  var contain =
      await _firestore.collection('users').where((item) => item.key == email);
}

bool nameValidation(String name) {
  return true;
}

bool passwordValidation(String password) {
  if (!RegExp(passwordPattern).hasMatch(password)) return false;
  return true;
}

Future<bool> registerUser(
    {@required String email,
    @required String name,
    @required String password}) async {
  try {
    await users.add({'email': email, 'login': name});
  } catch (e) {
    print(e);
  }
  try {
    final user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    if (user != null) {
      return true;
    }
  } catch (e) {
    print(e);
    return false;
  }
}

>>>>>>> 20959eae8b38e8f742170a304190c18cad15c829
Future<bool> loginUser(String login, String password) async {
  if (!RegExp(emailPattern).hasMatch(login)) {
    await _auth.signInWithEmailAndPassword(email: login, password: password);
    return true;
  } else {
<<<<<<< HEAD
    var user =
        _firestore.collection('users').where((field) => field.key == login);
=======
    var user = users.where((field) => field.key == login);
>>>>>>> 20959eae8b38e8f742170a304190c18cad15c829
    return false;
  }
}
