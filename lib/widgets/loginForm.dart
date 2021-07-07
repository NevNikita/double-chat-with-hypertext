import 'package:double_chat_with_hypertext/models/authorisationModel.dart';
import 'package:double_chat_with_hypertext/screens/registerPage.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  LoginForm(this.submitForm, this.isLoading);

  final isLoading;

  final void Function(String login, String password, BuildContext ctx)
      submitForm;

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  String _login = '';

  String _password = '';

  void _trySubmit() {
    FocusScope.of(context).unfocus();
    var isValid = _formKey.currentState.validate();
    if (isValid) {
      _formKey.currentState.save();
      widget.submitForm(_login, _password, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                onSaved: (value) => _login = value,
                validator: (value) {
                  if (RegExp(emailPattern).hasMatch(value)) {
                    return null;
                  } else
                    return 'Введите корректный e-mail.';
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Логин',
                    hintText: 'Введите ваш email или логин'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                onSaved: (value) => _password = value,
                validator: (value) {
                  if (!RegExp(passwordPattern).hasMatch(value)) {
                    return null;
                  } else
                    return 'Введите корректный пароль.';
                },
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Пароль',
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
                onPressed: () => _trySubmit(),
                child: Text(
                  'Войти',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          TextButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => RegisterPage()));
            },
            child: Text(
              'Создать аккаунт',
              style: TextStyle(color: Colors.blueGrey[400], fontSize: 15),
            ),
          ),
        ]),
      ),
    ]);
  }
}
