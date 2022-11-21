import 'package:flutter/material.dart';
import 'package:aplicativo/controller/login_controle.dart';
import 'package:aplicativo/main.dart';

class Login extends StatelessWidget {
  LoginControle _controle = LoginControle();

  Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.all(28),
            color: Colors.deepPurple,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock,
                  size: 120,
                ),
                TextField(
                  decoration: InputDecoration(
                    label: Text('Login'),
                  ),
                  onChanged: _controle.setLogin,
                ),
                TextField(
                  decoration: InputDecoration(
                    label: Text('Senha'),
                  ),
                  obscureText: true,
                  onChanged: _controle.setSenha,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'login: admin \nsenha: admin',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: _controle.inLoader,
                  builder: (_, inLoader, __) => inLoader
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () {
                            _controle.auth().then(
                              (result) {
                                if (result) {
                                  Navigator.of(context)
                                      .pushReplacementNamed('/splash1');
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: const Text('Login recusado'),
                                    duration: const Duration(seconds: 1),
                                  ));
                                }
                              },
                            );
                          },
                          child: Icon(
                            Icons.lock_open_rounded,
                            size: 20,
                          ),
                        ),
                ),
              ],
            )));
  }
}
