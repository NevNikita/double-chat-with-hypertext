import 'dart:async';
import 'package:double_chat_with_hypertext/models/libraryItems.dart';
import 'package:flutter/material.dart';
import 'itemsPage.dart';

class ItemDetailPage extends StatefulWidget {
  int index;
  @override
  _ItemDetailPageState createState() => _ItemDetailPageState(index: index);
  ItemDetailPage({@required this.index});
}

class _ItemDetailPageState extends State<ItemDetailPage> {
  int index;

  TextEditingController _descriptionController;
  TextEditingController _codeController;
  TextEditingController _nameController;

  bool _codeValidation = true;

  Timer
      searchOnStoppedTypingCode; //таймер который идёт заново после того как юзер печатает

  _onChangeCodeHandler(value) {
    if (index < 0) {
      const duration = Duration(
          seconds:
              3); //сколько ждать после того как пользователь прекратил писать
      if (searchOnStoppedTypingCode != null) {
        setState(() => searchOnStoppedTypingCode.cancel());
      }
      setState(() => searchOnStoppedTypingCode = new Timer(
          duration,
          () => changeCode(
              value))); //когда проходит время, запускается проверка валидации
    } else
      _codeController.text = libraryItems[index].code;
  }

  changeCode(value) {
    //проверка валидации
    setState(() {
      _codeValidation = (libraryItems
              .where((element) => element.code == _codeController.text)
              .isEmpty)
          ? true
          : false;
    });
  }

  @override
  void initState() {
    super.initState();
    _codeController = new TextEditingController(
        text: index < 0 ? "" : libraryItems[index].code);
    _nameController = new TextEditingController(
        text: index < 0 ? "" : libraryItems[index].name);
    _descriptionController = new TextEditingController(
        text: index < 0 ? "" : libraryItems[index].description);
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
                  controller: _codeController,
                  onChanged: _onChangeCodeHandler,
                  onSubmitted: (value) => enter(index),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Фраза',
                      errorText: _codeValidation
                          ? null
                          : "На эту фразу уже есть запись",
                      hintText: ""),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 25, bottom: 0),
                child: TextField(
                  controller: _nameController,
                  onSubmitted: (value) => enter(index),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Значение',
                      hintText: ''),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 25, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: TextField(
                  controller: _descriptionController,
                  //onChanged: _onChangeDescriptionHandler,
                  onSubmitted: (value) => enter(index),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Описание',
                      //errorText:
                      hintText: ''),
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
                    onPressed: () => enter(index),
                    child: Text(
                      'Сохранить',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  enter(int index) {
    if (libraryItems
        .where((element) => element.code == _codeController.text)
        .isEmpty) {
      libraryItems.add(LibraryItem(
          code: _codeController.text,
          name: _nameController.text,
          description: _descriptionController.text));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ItemPage(),
        ),
      );
    } else if (index >= 0) {
      libraryItems[index].code = _codeController.text;
      libraryItems[index].name = _nameController.text;
      libraryItems[index].description = _descriptionController.text;
      setState(() {
        libraryItems = libraryItems;
        update();
        Navigator.pop(context);
      });
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => ItemPage(),
      //   ),
      // );
    }

    setState(() {
      libraryItems;

      _codeValidation = false;
    });
  }

  _ItemDetailPageState({@required this.index});
}
