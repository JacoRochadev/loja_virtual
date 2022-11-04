import 'package:cloud_firestore/cloud_firestore.dart';

class Section {
  Section.fromDocument(DocumentSnapshot document) {
    name = document['name'];
    type = document['type'];
  }

  String name;
  String type;
}
