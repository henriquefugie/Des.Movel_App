import 'package:flutter/material.dart';
import 'package:aplicativo/pages/dashboard.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.fromLTRB(25, 100, 25, 25),
        child: Center(
            child: Column(
          children: <Widget>[
            Image.asset(
              'assets/img/illustration.png',
              width: 300,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 50),
            ),
            Text(
              'Seu Aplicativo',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Fitness'.toUpperCase(),
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 48,
                fontFamily: 'Bebas',
                fontWeight: FontWeight.bold,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 50),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Dashboard(),
                  ),
                );
              },
              minWidth: double.infinity,
              height: 50,
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              child: Text('Iniciar'.toUpperCase()),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            MaterialButton(
              onPressed: () {},
              minWidth: double.infinity,
              height: 50,
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              child: Text('Criar conta'.toUpperCase()),
            ),
          ],
        )),
      )),
    );
  }
}
