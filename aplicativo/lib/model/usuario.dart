import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  String? id;
  late String email;
  late String password;
  String? name;
  String? passos;

  String? confirmPassword;

  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.doc('users/$id');

  Usuario(
      {required this.email,
      required this.password,
      this.name,
      this.confirmPassword,
      this.passos,
      this.id});

  Usuario.fromDocument(DocumentSnapshot document) {
    id = document.id;
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'name': name,
        'passos': passos ?? 0,
      };

  Usuario.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Future<void> saveData() async {
    await firestoreRef.set(toJson());
  }
}
