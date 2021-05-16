import 'package:double_chat_with_hypertext/models/authorisationModel.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();

  RegisterForm(this.submitForm);

  final void Function(
          String email, String login, String password, BuildContext context)
      submitForm;
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _passwordController;

  String _login = '';
  String _email = '';

  String _password = '';

  void _trySubmit() {
    FocusScope.of(context).unfocus();
    var isValid = _formKey.currentState.validate();
    if (isValid) {
      _formKey.currentState.save();
      widget.submitForm(_email, _login, _password, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                keyboardType: TextInputType.name,
                onSaved: (value) => _login = value,
                validator: (value) {
                  if (value != null && value.length > 4) {
                    return null;
                  } else
                    return 'Введите корректный login.';
                },
                //onSubmitted: (value) => enter(),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Логин',
                    hintText: 'Введите ваш email или логин'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 25, bottom: 0),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                onSaved: (value) => _email = value,
                validator: (value) {
                  if (RegExp(emailPattern).hasMatch(value)) {
                    return null;
                  } else
                    return 'Введите корректный e-mail.';
                },
                //onSubmitted: (value) => enter(),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Введите email'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 25, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: TextFormField(
                controller: _passwordController,
                onSaved: (value) => _password = value,
                validator: (value) {
                  if (!RegExp(passwordPattern).hasMatch(value)) {
                    return null;
                  } else
                    return 'Введите корректный password.';
                },
                obscureText: true,
                //onSubmitted: (value) => enter(),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Пароль',
                    hintText: 'Пароль'),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 25, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: TextFormField(
                  obscureText: true,
                  validator: (value) {
                    if (/*RegExp(passwordPattern).hasMatch(value) &&
                        value == _passwordController.text*/
                        true) {
                      return null;
                    } else
                      return 'Введите корректный password.';
                  },

                  //onSubmitted: (value) => enter(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Повторите пароль',
                  ),
                )),
            Container(
              height: 50,
              width: 400,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () => _trySubmit(),
                child: Text(
                  'Зарегистрироваться',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
