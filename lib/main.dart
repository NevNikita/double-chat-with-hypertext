import 'package:double_chat_with_hypertext/models/authorisationModel.dart';
import 'package:double_chat_with_hypertext/screens/authorisationPage.dart';
import 'package:double_chat_with_hypertext/screens/homePage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DChat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: userAuthorisated ? HomePage() : AuthorisationPage(),
    );
  }
}
