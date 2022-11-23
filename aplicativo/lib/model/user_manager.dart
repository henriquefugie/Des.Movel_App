import 'dart:convert';

import 'package:aplicativo/controller/firebase_errors.dart';
import 'package:aplicativo/model/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserManager extends ChangeNotifier {
  UserManager() {
    _loadCurrentUser();
  }
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  late Usuario usuarioAtual;

  bool _loading = false;
  bool get loading => _loading;

  Future<void> signIn(
      {required Usuario user,
      required Function onFail,
      required Function onSuccess}) async {
    loading = true;
    try {
      final UserCredential result = await auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);

      await _loadCurrentUser(user: result.user);

      onSuccess();
    } on FirebaseAuthException catch (error) {
      onFail(verifyErroCode(error.code));
    }
    loading = false;
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> _loadCurrentUser({User? user}) async {
    final User currentUser = user ?? auth.currentUser!;
    if (currentUser != null) {
      final DocumentSnapshot docUser =
          await firestore.collection('users').doc(currentUser.uid).get();
      usuarioAtual = Usuario.fromDocument(docUser);
      print(usuarioAtual.name);
      notifyListeners();
    }
  }

  Future<void> signUp(
      {required Usuario user,
      required Function onFail,
      required Function onSuccess}) async {
    loading = true;
    try {
      final UserCredential result = await auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);

      user.id = result.user!.uid;
      usuarioAtual = user;

      await user.saveData();

      onSuccess();
    } on PlatformException catch (error) {
      onFail(verifyErroCode(error.code));
    }
    loading = false;
  }

  Future<void> storedata({required Usuario user1}) async {
    final prefs = await SharedPreferences.getInstance();
    Usuario user = Usuario(
        email: user1.email,
        password: user1.password,
        name: user1.name,
        confirmPassword: user1.confirmPassword);

    String userdata = json.encode(user);

    prefs.setString('userdata', userdata);
  }

  void saveData(Usuario user) {
    final cadastro = FirebaseFirestore.instance.collection('users').doc();
    user.id = cadastro.id;
    final data = user.toJson();
    cadastro.set(data);
  }
}
