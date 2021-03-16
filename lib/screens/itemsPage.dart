import 'package:double_chat_with_hypertext/models/libraryItems.dart';
import 'package:double_chat_with_hypertext/widgets/itemsList.dart';
import 'package:flutter/material.dart';

import 'itemDetailPage.dart';

class ItemPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Ссылки",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
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
                        TextButton(
                          onPressed: () => Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ItemDetailPage(index: -1);
                          })),
                          child: Text(
                            "Добавить",
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                                height: 0.85,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
            ListView.builder(
              itemCount: libraryItems.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ItemsList(
                    index: index,
                    code: libraryItems[index].code,
                    name: libraryItems[index].name,
                    description: libraryItems[index].description);
              },
            )
          ],
        ),
      ),
    );
  }
}
