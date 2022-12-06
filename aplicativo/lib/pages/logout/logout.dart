import 'package:aplicativo/controller/validators.dart';
import 'package:aplicativo/model/user_manager.dart';
import 'package:aplicativo/model/usuario.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Logout extends StatelessWidget {
  Logout({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Usuario usuarioCadastro =
      Usuario(email: '', password: '', name: '', confirmPassword: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Logout'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(16),
              children: <Widget>[
                SizedBox(
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<UserManager>().logout(
                        onSuccess: () {
                          Navigator.of(context).pushNamed('/splash');
                        },
                        onFail: (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Falha no logout: $e'),
                            backgroundColor: Colors.red,
                          ));
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      disabledBackgroundColor:
                          Theme.of(context).primaryColor.withAlpha(100),
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    child: const Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
