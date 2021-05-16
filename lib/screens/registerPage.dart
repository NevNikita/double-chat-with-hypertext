import 'package:double_chat_with_hypertext/widgets/registerForm.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  void _registerUser(
      String email, String login, String password, BuildContext ctx) async {
    try {
      final regResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      var users = await _firestore
          .collection('users')
          .doc(regResult.user.uid)
          .set({'username': login, 'email': email});
    } on PlatformException catch (e) {
      var message = 'An error occured.';
      if (e.message != null) message = e.message;
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(ctx).errorColor,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text("Регистрация")),
        body: RegisterForm(_registerUser));
  }
}
