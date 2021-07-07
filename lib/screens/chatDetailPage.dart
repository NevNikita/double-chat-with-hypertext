import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:double_chat_with_hypertext/models/chatMessageModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatDetailPage extends StatefulWidget {
  String chatId = '';
  String name = '';

  ChatDetailPage(this.chatId, this.name);

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

// TODO: Перенести всю логику написания сообщения в отдельный класс (модел)

ScrollController _scrollController = new ScrollController();
TextEditingController _textFieldController = new TextEditingController();
GlobalKey _textInputKey = GlobalKey();
GlobalKey _messageListKey = GlobalKey();
FocusNode myFocusNode = new FocusNode();
double height = 70;

class _ChatDetailPageState extends State<ChatDetailPage> {
  @override
  Widget build(BuildContext context) {
    Timestamp timestamp = Timestamp.now();
    timestamp.toDate().toLocal();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://randomuser.me/api/portraits/men/5.jpg"),
                  maxRadius: 20,
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Text(
                    widget.name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                Icon(
                  Icons.settings,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),
      ),

      // примерно здесь должно быть разделение на несколько чатов
      body: new GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Stack(
          children: <Widget>[
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('chats/${widget.chatId}/messages')
                    .orderBy('createdAt', descending: true)
                    .snapshots(),
                builder: (ctx, chatSnapshot) {
                  if (chatSnapshot.connectionState == ConnectionState.waiting)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  final docs = chatSnapshot.data.docs;
                  var userId = FirebaseAuth.instance.currentUser.uid;
                  print(userId);
                  return ListView.builder(
                    key: _messageListKey,
                    controller: _scrollController,
                    reverse: true,
                    itemCount: docs.length,
                    shrinkWrap: false,
                    padding: EdgeInsets.only(top: 10, bottom: height),
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ChatBubble(
                          messageUserId: docs[index]['userId'],
                          messageText: docs[index]['text'],
                          senderName: docs[index]['sender'],
                          timeSent: docs[index]['createdAt'].toString(),
                          userId: userId);
                    },
                  );
                }),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                //height: 60,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Flexible(
                      child: LayoutBuilder(
                        key: _textInputKey,
                        builder: (context, constraints) {
                          return new ConstrainedBox(
                            constraints: new BoxConstraints(
                              // minWidth: size.width,
                              // maxWidth: size.width,
                              minHeight: 25.0,
                              maxHeight: 135.0,
                            ),
                            child: new Scrollbar(
                              child: new TextField(
                                onChanged: (ctx) {
                                  setState(() {
                                    height = _textInputKey
                                            .currentContext.size.height +
                                        30;
                                  });
                                },
                                cursorColor: Colors.red,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                controller: _textFieldController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                      top: 2.0,
                                      left: 13.0,
                                      right: 13.0,
                                      bottom: 2.0),
                                  hintText: "Пишите ваше сообщуха",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        sendMessage();
                      },
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 18,
                      ),
                      backgroundColor: Colors.blue,
                      elevation: 0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sendMessage() {
    setState(() {
      if (_textFieldController.text == '') {
        return;
      }
      var time = Timestamp.now();
      var user = FirebaseAuth.instance.currentUser;
      FirebaseFirestore.instance
          .collection('chats/${widget.chatId}/messages')
          .add({
        'sender': user.displayName,
        'text': _textFieldController.text,
        'userId': user.uid,
        'createdAt': time
      });
      FirebaseFirestore.instance
          .collection('chats')
          .doc('${widget.chatId}')
          .update({
        'lastMessage': _textFieldController.text,
        'lastMessageTime': time,
      });
      _textFieldController.clear();
      myFocusNode.requestFocus();
      _scrollController.animateTo(0.0,
          curve: Curves.easeOut, duration: const Duration(milliseconds: 300));
    });
  }
}

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key key,
    @required this.messageUserId,
    @required this.userId,
    @required this.senderName,
    @required this.messageText,
    @required this.timeSent,
  });

  final String messageUserId;
  final String userId;
  final String senderName;
  final String messageText;
  final String timeSent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
      child: Align(
        alignment:
            (messageUserId != userId ? Alignment.topLeft : Alignment.topRight),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: (messageUserId != userId
                ? Colors.grey.shade200
                : Colors.blue[200]),
          ),
          padding: EdgeInsets.all(16),
          child: Text(
            messageText,
            style: TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }
}
