import 'package:double_chat_with_hypertext/models/authorisationModel.dart';
import 'package:double_chat_with_hypertext/screens/authorisationPage.dart';
import 'package:flutter/material.dart';
import 'dart:async';

TextEditingController _loginController = new TextEditingController();
TextEditingController _emailController = new TextEditingController();
TextEditingController _passwordController = new TextEditingController();
TextEditingController _passwordConfirmationController =
    new TextEditingController();

bool _loginValidation = true;
bool _emailValidation = true;
bool _passwordValidation = true;
bool _passwordConfirmationValidation = true;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Timer searchOnStoppedTypingLogin;
  _onChangeLoginHandler(value) {
    const duration = Duration(seconds: 3);
    if (searchOnStoppedTypingLogin != null) {
      setState(() => searchOnStoppedTypingLogin.cancel());
    }
    setState(() => searchOnStoppedTypingLogin =
        new Timer(duration, () => changeLogin(value)));
  }

  changeLogin(value) {
    setState(() {
      _loginValidation = nameValidation(value) ? true : false;
    });
  }

  Timer searchOnStoppedTypingEmail;
  _onChangeEmailHandler(value) {
    const duration = Duration(seconds: 3);
    if (searchOnStoppedTypingEmail != null) {
      setState(() => searchOnStoppedTypingEmail.cancel());
    }
    setState(() => searchOnStoppedTypingEmail =
        new Timer(duration, () => changeEmail(value)));
  }

  changeEmail(value) {
    setState(() {
      _emailValidation =
          (emailValidation(_emailController.text) == "ok") ? true : false;
    });
  }

  Timer searchOnStoppedTypingPassword;
  _onChangePasswordHandler(value) {
    const duration = Duration(seconds: 3);
    if (searchOnStoppedTypingPassword != null) {
      setState(() => searchOnStoppedTypingPassword.cancel());
    }
    setState(() => searchOnStoppedTypingPassword =
        new Timer(duration, () => changePassword(value)));
  }

  changePassword(value) {
    setState(() {
      _passwordValidation =
          passwordValidation(_passwordController.text) ? true : false;
    });
  }

  Timer searchOnStoppedTypingPasswordConfirmation;
  _onChangePasswordConfirmationHandler(value) {
    const duration = Duration(seconds: 3);
    if (searchOnStoppedTypingPasswordConfirmation != null) {
      setState(() => searchOnStoppedTypingPasswordConfirmation.cancel());
    }
    setState(() => searchOnStoppedTypingPasswordConfirmation =
        new Timer(duration, () => changePasswordConfirmation(value)));
  }

  changePasswordConfirmation(value) {
    setState(() {
      _passwordConfirmationValidation =
          (_passwordController.text == _passwordConfirmationController.text)
              ? true
              : false;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text("Регистрация")),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 65.0),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  controller: _loginController,
                  onChanged: _onChangeLoginHandler,
                  //onSubmitted: (value) => enter(),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Логин',
                      errorText: _loginValidation
                          ? null
                          : "Пользователь с таким логином уже существует",
                      hintText: 'Введите ваш email или логин'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 25, bottom: 0),
                child: TextField(
                  controller: _emailController,
                  onChanged: _onChangeEmailHandler,
                  //onSubmitted: (value) => enter(),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      errorText: _emailValidation
                          ? null
                          : emailValidation(_emailController.text),
                      hintText: 'Введите email'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 25, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: TextField(
                  controller: _passwordController,
                  onChanged: _onChangePasswordHandler,
                  obscureText: true,
                  //onSubmitted: (value) => enter(),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Пароль',
                      errorText: _passwordValidation
                          ? null
                          : "Пароль не соответствует требованиям",
                      hintText: 'Пароль'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 25, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: TextField(
                  controller: _passwordConfirmationController,
                  onChanged: _onChangePasswordConfirmationHandler,
                  obscureText: true,
                  //onSubmitted: (value) => enter(),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Повторите пароль',
                      errorText: _passwordConfirmationValidation
                          ? null
                          : _passwordValidation
                              ? "Пароли не совпадают"
                              : null,
                      hintText: 'Пароль'),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 90, horizontal: 15),
                child: Container(
                  height: 50,
                  width: 400,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                    onPressed: () =>
                        Future.delayed(Duration(seconds: 5), () => enter()),
                    child: Text(
                      'Зарегистрироваться',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void enter() {
    if (_loginValidation &&
        _passwordValidation &&
        _emailValidation &&
        _passwordConfirmationValidation) {
      setState(() {
        registerUser(
            email: _emailController.text,
            name: _loginController.text,
            password: _passwordController.text);
      });
    }
  }
}
