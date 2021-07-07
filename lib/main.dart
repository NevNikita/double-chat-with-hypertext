import 'package:double_chat_with_hypertext/screens/authorisationPage.dart';
import 'package:double_chat_with_hypertext/screens/homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/splashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
        future: _initialization,
        builder: (context, userSnapshot) {
          return MaterialApp(
              title: 'DChat',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              debugShowCheckedModeBanner: false,
              home: userSnapshot.connectionState != ConnectionState.done
                  ? SplashScreen()
                  : StreamBuilder(
                      stream: FirebaseAuth.instance.authStateChanges(),
                      builder: (ctx, userSnapshot) {
                        if (userSnapshot.hasData)
                          return HomePage();
                        else
                          return AuthorisationPage();
                      },
                    ));
        });
  }
}
