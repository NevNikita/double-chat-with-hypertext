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
      imageURL: "https://randomuser.me/api/portraits/men/5.jpg",
      time: "Now"),
  ChatUsers(
      name: "Данилкукич",
      messageText: "Охуенная приложуха, бро!",
      imageURL: "https://randomuser.me/api/portraits/men/1.jpg",
      time: "Yesterday"),
  ChatUsers(
      name: "Вова ЗАйцев",
      messageText: "Стас мудила хехе",
      imageURL: "https://randomuser.me/api/portraits/men/2.jpg",
      time: "31 Mar"),
  ChatUsers(
      name: "Дима Зайцев",
      messageText: "Давай обсудим стасика",
      imageURL: "https://randomuser.me/api/portraits/men/3.jpg",
      time: "28 Mar"),
  ChatUsers(
      name: "Ксюша (обосрала газон)",
      messageText: "сверху додики",
      imageURL: "https://randomuser.me/api/portraits/women/1.jpg",
      time: "23 Mar"),
  ChatUsers(
      name: "босс",
      messageText: "Ты повышен.",
      imageURL: "https://randomuser.me/api/portraits/men/4.jpg",
      time: "17 Mar"),
  ChatUsers(
      name: "Какой-то лох",
      messageText: "Привет, я Стас этой мой второй аккаунт...",
      imageURL: "https://randomuser.me/api/portraits/men/5.jpg",
      time: "24 Feb"),
  ChatUsers(
      name: "Стив Джобс",
      messageText: "I AM ALIVE HELP I WAS CAPTURED BY STASIK?",
      imageURL:
          "https://upload.wikimedia.org/wikipedia/commons/d/dc/Steve_Jobs_Headshot_2010-CROP_%28cropped_2%29.jpg",
      time: "18 Feb"),
];
