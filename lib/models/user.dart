import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/models/adress.dart';

class UserModel {
  UserModel({this.name, this.email, this.password, this.id});

  UserModel.fromDocument(DocumentSnapshot document) {
    id = document.id;
    name = document['name'] as String;
    email = document['email'] as String;
    cpf = document['cpf'] as String;
    if (document.data().toString().contains('adress')) {
      adress = Adress.fromMap(document['adress'] as Map<String, dynamic>);
    }
  }

  String id;
  String name;
  String email;
  String password;
  String confirmPassword;
  Adress adress;
  String cpf;

  bool admin = false;

  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.doc('users/$id');

  CollectionReference get cartReference => firestoreRef.collection('cart');

  Future<void> saveData() async {
    await firestoreRef.set(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      if (adress != null) 'adress': adress.toMap(),
      if (cpf != null) 'cpf': cpf,
    };
  }

  void setAdress(Adress adress) {
    this.adress = adress;
    saveData();
  }

  void setCpf(String cpf) {
    this.cpf = cpf;
    saveData();
  }
}
