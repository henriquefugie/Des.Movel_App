import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;

class Splash1 extends StatefulWidget {
  const Splash1({super.key});

  @override
  _Splash1State createState() => _Splash1State();
}

class _Splash1State extends State<Splash1> {
  Future checkingTheSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final User? currentUser = auth.currentUser;
    firestore
        .collection('users')
        .doc(currentUser?.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        String username = prefs.getString('userdata') ?? "";
        if (username.isNotEmpty) {
          Navigator.of(context).pushNamed('/base');
        } else {
          Navigator.of(context).pushNamed('/login');
        }
      } else {
        Navigator.of(context).pushNamed('/login');
      }
    });
  }

  @override
  void initState() {
    super.initState();

    //espera 3 segundos do splash
    Future.delayed(const Duration(seconds: 4)).then((_) {
      // muda para a proxima tela
      // if (val)
      //   Navigator.of(context).pushNamed('/base');
      // else
      //   Navigator.of(context).pushNamed('/login');
      checkingTheSavedData();
    });
  }

  //constroe a tela do splash
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/img/run.png",
            width: 200,
            color: Colors.white,
          ),
          const SizedBox(
            height: 32,
          ),
          const Padding(
            padding: EdgeInsets.all(20),
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
