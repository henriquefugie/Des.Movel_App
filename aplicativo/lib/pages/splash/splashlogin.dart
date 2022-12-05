import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash1 extends StatefulWidget {
  @override
  _Splash1State createState() => _Splash1State();
}

class _Splash1State extends State<Splash1> {
  Future checkingTheSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var username = prefs.getString('email');
    print(username);
    if (username == null) {
      Navigator.of(context).pushNamed('/login');
    } else {
      Navigator.of(context).pushNamed('/base');
    }
  }

  @override
  void initState() {
    super.initState();
    checkingTheSavedData();

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
