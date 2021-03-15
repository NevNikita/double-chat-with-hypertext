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
      name: "Стас",
      messageText: "да",
      imageURL: "https://randomuser.me/api/portraits/men/5.jpg",
      time: "Сейчас"),
];
