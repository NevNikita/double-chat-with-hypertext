import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:double_chat_with_hypertext/models/chatMessageModel.dart';
import 'package:double_chat_with_hypertext/models/chatUserModel.dart';
import 'package:double_chat_with_hypertext/widgets/conversationList.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Комнаты",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.pink[50],
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.add,
                            color: Colors.pink,
                            size: 20,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            "Добавить",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Поиск комнат",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey.shade100)),
                ),
              ),
            ),
            StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('chats').snapshots(),
                builder: (ctx, chatSnapshot) {
                  if (chatSnapshot.connectionState == ConnectionState.waiting)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  final docs = chatSnapshot.data.docs;
                  return ListView.builder(
                    itemCount: docs.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 16),
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ConversationList(
                        name: docs[index]['name'],
                        messageText: docs[index]['lastMessage'],
                        chatId: docs[index].id,
                        imageUrl: chatUsers[index].imageURL,
                        time: docs[index]['lastMessageTime'],
                        isMessageRead:
                            (index == 0 || index == 3) ? true : false,
                      );
                    },
                  );
                })
          ],
        ),
      ),
    );
  }
}
