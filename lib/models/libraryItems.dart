import "package:flutter/cupertino.dart";

class LibraryItem {
  String code;
  String name;
  String description;
  LibraryItem({@required this.code, @required this.name, this.description});
}

List<LibraryItem> libraryItems = [
  LibraryItem(code: "Отель", name: "Триваго"),
  LibraryItem(
      code: "code",
      name: "value",
      description: "value will accept at code in chat"),
];
