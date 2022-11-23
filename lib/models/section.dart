import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/section_item.dart';

class Section extends ChangeNotifier {
  Section({this.name, this.type, this.items}) {
    items = items ?? [];
  }
  Section.fromDocument(DocumentSnapshot document) {
    name = document['name'];
    type = document['type'];
    items = (document['items'] as List<dynamic> ?? [])
        .map((e) => SectionItem.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  String name;
  String type;
  List<SectionItem> items;

  Section clone() {
    return Section()
      ..name = name
      ..type = type
      ..items = items.map((e) => e.clone()).toList();
  }

  void addItem(SectionItem item) {
    items.add(item);
    notifyListeners();
  }

  void removeItem(SectionItem item) {
    items.remove(item);
    notifyListeners();
  }

  @override
  String toString() {
    return 'Section{name: $name, type: $type, items: $items}';
  }
}
