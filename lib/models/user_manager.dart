import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/helpers/firebase_errors.dart';
import 'package:loja_virtual/models/user.dart';

class UserManager extends ChangeNotifier {
  UserManager() {
    _loadCurrentUser();
  }
  final FirebaseAuth auth = FirebaseAuth.instance;

  UserModel userModel;
  bool _loading = false;
  bool get loading => _loading;
  bool get isLoggedIn => userModel != null;

  Future<void> signIn(
      {UserModel userModel, Function onFail, Function onSucess}) async {
    loading = true;
    try {
      final UserCredential result = await auth.signInWithEmailAndPassword(
        email: userModel.email,
        password: userModel.password,
      );
      await Future.delayed(const Duration(seconds: 2));
      await _loadCurrentUser(userFirebase: result.user);
      onSucess();
    } on FirebaseAuthException catch (e) {
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  Future<void> signUp(
      {UserModel userModel, Function onFail, Function onSucess}) async {
    loading = true;
    try {
      final UserCredential result = await auth.createUserWithEmailAndPassword(
        email: userModel.email,
        password: userModel.password,
      );
      userModel.id = result.user.uid;
      this.userModel = userModel;
      await userModel.saveData();
      onSucess();
    } on FirebaseAuthException catch (e) {
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  void signOut() {
    auth.signOut();
    userModel = null;
    notifyListeners();
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> _loadCurrentUser({User userFirebase}) async {
    final User currentUser = userFirebase ?? auth.currentUser;

    final DocumentSnapshot docUser =
        await FirebaseFirestore.instance.doc('users/${currentUser.uid}').get();
    userModel = UserModel.fromDocument(docUser);
    notifyListeners();
  }
}
