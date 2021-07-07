import 'package:double_chat_with_hypertext/widgets/loginForm.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthorisationPage extends StatefulWidget {
  @override
  _AuthorisationPageState createState() => _AuthorisationPageState();
}

class _AuthorisationPageState extends State<AuthorisationPage> {
  final _auth = FirebaseAuth.instance;
  bool isLoading = false;

  void _submitAuthForm(String login, String password, BuildContext ctx) async {
    try {
      print('GO GO');
      setState(() {
        isLoading = true;
      });
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: login, password: password);
      setState(() {
        isLoading = false;
      });
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
      appBar: AppBar(
        title: Text("Авторизация"),
      ),
      body: LoginForm(_submitAuthForm, isLoading),
    );
  }
}
