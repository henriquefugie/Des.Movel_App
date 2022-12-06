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
    loadCurrentUser();
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
      await loadCurrentUser(user: result.user);

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

  Future<void> loadCurrentUser({User? user}) async {
    final User currentUser = user ?? auth.currentUser!;
    firestore
        .collection('users')
        .doc(currentUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        var data = documentSnapshot.data() as Map;
        Usuario user = Usuario(
          email: data['email'],
          password: data["password"],
          name: data['name'],
          passos: data['passos'],
        );
        storedata(user1: user);
      } else {
        print('Document does not exist on the database');
      }
    });
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
      storedata(user1: user);
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
      passos: user1.passos,
    );

    String userdata = json.encode(user);
    prefs.setString('userdata', userdata);
  }

  void saveData(Usuario user) {
    final cadastro = FirebaseFirestore.instance.collection('users').doc();
    user.id = cadastro.id;
    final data = user.toJson();
    cadastro.set(data);
  }

  Future<void> logout(
      {required Function onFail, required Function onSuccess}) async {
    try {
      await auth.signOut();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      onSuccess();
    } on PlatformException catch (error) {
      onFail(verifyErroCode(error.code));
    }
  }
}
