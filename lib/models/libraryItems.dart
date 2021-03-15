import "package:flutter/cupertino.dart";

class LibraryItem {
  String code;
  String name;
  String description;
  LibraryItem({@required code, @required name});
}

List<LibraryItem> libraryItems = [LibraryItem(code: "отель", name: "триваго")];
