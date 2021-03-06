import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:double_chat_with_hypertext/screens/chatDetailPage.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ConversationList extends StatefulWidget {
  String name;
  String messageText;
  String chatId;
  String imageUrl;
  Timestamp time;
  bool isMessageRead;
  ConversationList(
      {@required this.name,
      @required this.messageText,
      @required this.chatId,
      @required this.imageUrl,
      @required this.time,
      @required this.isMessageRead});
  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    String dateConvert(Timestamp ts) {
      var time = ts.toDate().toLocal();
      if (time.month == DateTime.now().month &&
          time.day == DateTime.now().day) {
        print(DateTime.now().month);
        return '${time.hour}:${time.minute}';
      } else
        return '${time.day}.${time.month}.${time.year}';
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ChatDetailPage(widget.chatId, widget.name);
        }));
      },
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.imageUrl),
                    maxRadius: 30,
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.name,
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            widget.messageText,
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                                fontWeight: widget.isMessageRead
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              dateConvert(widget.time),
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: widget.isMessageRead
                      ? FontWeight.bold
                      : FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
