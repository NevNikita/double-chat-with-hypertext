import 'package:flutter/cupertino.dart';

class ChatUsers {
  String name;
  String messageText;
  String imageURL;
  String time;

  ChatUsers(
      {@required this.name,
      @required this.messageText,
      @required this.imageURL,
      @required this.time});
}

List<ChatUsers> chatUsers = [
  ChatUsers(
      name: "Стасик (Мудак)",
      messageText: "меня опять отмудохали...",
      imageURL: "http://www.avotarov.ru/picture/avatar-64/kartinki/926.jpg",
      time: "Now"),
  ChatUsers(
      name: "Данилкукич",
      messageText: "Охуенная приложуха, бро!",
      imageURL: "images/userImage2.jpeg",
      time: "Yesterday"),
  ChatUsers(
      name: "Вова ЗАйцев",
      messageText: "Стас мудила хехе",
      imageURL: "images/userImage3.jpeg",
      time: "31 Mar"),
  ChatUsers(
      name: "Дима Зайцев",
      messageText: "Давай обсудим стасика",
      imageURL: "images/userImage4.jpeg",
      time: "28 Mar"),
  ChatUsers(
      name: "Ксюша (обосрала газон)",
      messageText: "сверху додики",
      imageURL: "images/userImage5.jpeg",
      time: "23 Mar"),
  ChatUsers(
      name: "босс",
      messageText: "Ты повышен.",
      imageURL: "images/userImage6.jpeg",
      time: "17 Mar"),
  ChatUsers(
      name: "Какой-то лох",
      messageText: "Привет, я Стас этой мой второй аккаунт...",
      imageURL: "images/userImage7.jpeg",
      time: "24 Feb"),
  ChatUsers(
      name: "Стив Джобс",
      messageText: "I AM ALIVE HELP I WAS CAPTURED BY STASIK?",
      imageURL: "images/userImage8.jpeg",
      time: "18 Feb"),
];
