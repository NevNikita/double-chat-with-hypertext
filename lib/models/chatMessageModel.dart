import 'package:flutter/cupertino.dart';

String chatInputField;

class ChatMessage {
  String messageContent;
  String messageType;
  ChatMessage({@required this.messageContent, @required this.messageType});
}

void createMessage(String input) {}

List<ChatMessage> messages = [
  ChatMessage(
      messageContent: "Привет, я лох лошара я тупая", messageType: "receiver"),
  ChatMessage(
      messageContent: "ой чё-то мне не хорошо....", messageType: "receiver"),
  ChatMessage(
      messageContent: "да чё с тобой случилось то оптфяь бля?",
      messageType: "sender"),
  ChatMessage(
      messageContent: "меня опять отмудохали...", messageType: "receiver"),
  ChatMessage(
      messageContent:
          "ой как ты заеба л сука ну не выходи ты из дом знаешь же что ты дебил тупой опять гавном закидают",
      messageType: "sender"),
];
