import 'package:double_chat_with_hypertext/models/authorisationModel.dart';
import 'package:double_chat_with_hypertext/screens/registerPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'homePage.dart';

TextEditingController _loginController = new TextEditingController();
TextEditingController _passwordController = new TextEditingController();
bool _inputError = false;
bool _emptyError = false;

class AuthorisationPage extends StatefulWidget {
  @override
  _AuthorisationPageState createState() => _AuthorisationPageState();
}

class _AuthorisationPageState extends State<AuthorisationPage> {
  @override
  void initState() {
    super.initState();
  }

  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Авторизация"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _loginController,
                onSubmitted: (value) => enter(),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Логин',
                    errorText: _inputError ? "" : null,
                    hintText: 'Введите ваш email или логин'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                onSubmitted: (value) => enter(),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Пароль',
                    errorText: _inputError
                        ? _emptyError
                            ? "Заполните формы"
                            : "Неправильный логин или пароль"
                        : null,
                    hintText: 'Пароль'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                //TODO Забыл пароль экранчек
              },
              child: Text(
                'Забыл пароль',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () => enter(),
                child: Text(
                  'Войти',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(
              height: 390,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => RegisterPage()));
                },
                child: Text(
                  'Создать аккаунт',
                  style: TextStyle(color: Colors.blueGrey[400], fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void enter() {
    setState(() async {
      try {
        final user = await _auth.signInWithEmailAndPassword(
            email: _loginController.text, password: _passwordController.text);

        Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
      } catch (e) {
        print(e);
      }

      /*
      if (loginUser(_loginController.text, _passwordController.text) == "ok")
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => HomePage()));
      else
        _inputError = true;
      if ((_loginController.text == "") || (_passwordController.text == ""))
        _emptyError = true;
      else
        _emptyError = false;*/
    });
  }
}
