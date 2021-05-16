import 'package:double_chat_with_hypertext/models/authorisationModel.dart';
import 'package:double_chat_with_hypertext/screens/authorisationPage.dart';
import 'package:double_chat_with_hypertext/screens/homePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
        future: _initialization,
        builder: (context, appSnapshot) {
          return MaterialApp(
            title: 'DChat',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            debugShowCheckedModeBanner: false,
            home: /* appSnapshot.connectionState != ConnectionState.done ?  SplashScreen() : */ userAuthorisated
                ? HomePage()
                : AuthorisationPage(),
          );
        });
  }
}
