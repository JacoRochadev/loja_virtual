import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faker/faker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user.dart';
import 'package:loja_virtual/models/user_manager.dart';

class AdminUserManager extends ChangeNotifier {
  List<UserModel> users = [];
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void updateUser(UserManager userManager) {
    if (userManager.adminEnabled) {
      _listenToUsers();
    }
  }

  void _listenToUsers() {
    //gerando dados falsos
    // const faker = Faker();

    // for (int i = 0; i < 1000; i++) {
    //   users.add(
    //       UserModel(name: faker.person.name(), email: faker.internet.email()));
    // }
    firestore.collection('users').get().then((snapshot) {
      users = snapshot.docs.map((e) => UserModel.fromDocument(e)).toList();
      users.sort(
          ((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase())));
      notifyListeners();
    });
  }

  List<String> get names => users.map((e) => e.name).toList();
}
