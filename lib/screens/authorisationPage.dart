import 'package:double_chat_with_hypertext/models/authorisationModel.dart';
import 'package:double_chat_with_hypertext/screens/registerPage.dart';
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
            TextButton(
              onPressed: () {
                //TODO Забыл пароль экранчек
              },
              child: Text(
                'Забыл пароль',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
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
              height: 300,
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => RegisterPage()));
              },
              child: Text(
                'Создать аккаунт',
                style: TextStyle(color: Colors.blueGrey[400], fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void enter() {
    setState(() {
      if (loginUser(_loginController.text, _passwordController.text) == "ok")
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => HomePage()));
      else
        _inputError = true;
      if ((_loginController.text == "") || (_passwordController.text == ""))
        _emptyError = true;
      else
        _emptyError = false;
    });
  }
}
