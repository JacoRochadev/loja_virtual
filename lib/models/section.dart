import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/models/section_item.dart';

class Section {
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

  @override
  String toString() {
    return 'Section{name: $name, type: $type, items: $items}';
  }
}
