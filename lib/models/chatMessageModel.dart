import 'package:flutter/cupertino.dart';

String chatInputField;

class ChatMessage {
  String messageContent;
  String messageType;
  ChatMessage({@required this.messageContent, @required this.messageType});
}

void createMessage(String input) {}

List<ChatMessage> messages = [
  ChatMessage(messageContent: "да?", messageType: "sender"),
  ChatMessage(messageContent: "да", messageType: "receiver"),
];
