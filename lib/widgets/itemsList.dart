import 'package:double_chat_with_hypertext/screens/itemDetailPage.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ItemsList extends StatefulWidget {
  int index;
  String code;
  String name;
  String description;
  ItemsList(
      {@required this.index,
      @required this.code,
      @required this.name,
      @required this.description});
  @override
  _ItemsListState createState() => _ItemsListState();
}

class _ItemsListState extends State<ItemsList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return ItemDetailPage(
            index: widget.index,
          );
        }));
      },
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  //CircleAvatar(),
                  //SizedBox(width: 16,),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.code == null ? "" : widget.code,
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            widget.name == null ? "" : widget.name,
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              widget.description == null ? "" : widget.description,
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
