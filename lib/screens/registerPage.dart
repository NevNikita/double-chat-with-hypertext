import 'package:double_chat_with_hypertext/widgets/registerForm.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
=======
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

TextEditingController _loginController = new TextEditingController();
TextEditingController _emailController = new TextEditingController();
TextEditingController _passwordController = new TextEditingController();
TextEditingController _passwordConfirmationController =
    new TextEditingController();

bool _loginValidation = true;
bool _emailValidation = true;
bool _passwordValidation = true;
bool _passwordConfirmationValidation = true;
>>>>>>> 20959eae8b38e8f742170a304190c18cad15c829

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = FirebaseAuth.instance;
<<<<<<< HEAD
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
=======

  Timer
      searchOnStoppedTypingLogin; //таймер который идёт заново после того как юзер печатает
  _onChangeLoginHandler(value) {
    const duration = Duration(
        seconds:
            3); //сколько ждать после того как пользователь прекратил писать
    if (searchOnStoppedTypingLogin != null) {
      setState(() => searchOnStoppedTypingLogin.cancel());
    }
    setState(() => searchOnStoppedTypingLogin = new Timer(
        duration,
        () => changeLogin(
            value))); //когда проходит время, запускается проверка валидации
  }

  changeLogin(value) {
    //проверка валидации
    setState(() {
      _loginValidation = nameValidation(value) ? true : false;
    });
  }

  //НИЖЕ ЕЩЁ НЕСКОЛЬКО ТАКИХ ЖЕ ФУНКЦИЙ

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
>>>>>>> 20959eae8b38e8f742170a304190c18cad15c829
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text("Регистрация")),
<<<<<<< HEAD
        body: RegisterForm(_registerUser));
=======
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 65.0),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  keyboardType: TextInputType.name,
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
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  onChanged: _onChangeEmailHandler,
                  //onSubmitted: (value) => enter(),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      /*errorText: _emailValidation
                          ? null
                          : emailValidation(_emailController.text),*/
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
                    onPressed: () => enter(),
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

//TODO если в полях ничего не писали то кнопка не работает и ошибки не показываются
  enter() {
    setState(() async {
      if (await registerUser(
          email: _emailController.text,
          name: _loginController.text,
          password: _passwordController.text)) Navigator.pop(context);
      /*
      if ((_passwordController.text == _passwordConfirmationController.text) &&
          registerUser(
              email: _emailController.text,
              name: _loginController.text,
              password: _passwordController.text)) Navigator.pop(context);
              */
    });
>>>>>>> 20959eae8b38e8f742170a304190c18cad15c829
  }
}
