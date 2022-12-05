import 'package:aplicativo/model/user_manager.dart';
import 'package:aplicativo/model/usuario.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/validators.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrar'),
        centerTitle: true,
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/signup');
              },
              child: const Text(
                'Criar Conta',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ))
        ],
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (_, userManager, __) {
                return ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: <Widget>[
                    TextFormField(
                      controller: emailController,
                      enabled: !userManager.loading,
                      decoration: const InputDecoration(hintText: 'E-mail'),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      validator: (email) {
                        if (!emailValid(email!)) return 'E-mail invalido';
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: passController,
                      enabled: !userManager.loading,
                      decoration: const InputDecoration(hintText: 'Senha'),
                      autocorrect: false,
                      obscureText: true,
                      validator: (pass) {
                        if (pass!.isEmpty || pass.length < 6) {
                          return 'Senha invalida';
                        }

                        return null;
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          child: const Text('Esqueci minha senha')),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        onPressed: userManager.loading
                            ? null
                            : () {
                                if (formKey.currentState!.validate()) {
                                  userManager.signIn(
                                      user: Usuario(
                                          email: emailController.text,
                                          password: passController.text,
                                          name: '',
                                          confirmPassword: ''),
                                      onFail: (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text('Falha ao entrar: $e'),
                                          backgroundColor: Colors.red,
                                        ));
                                      },
                                      onSuccess: () {
                                        userManager.storedata(
                                            user1: Usuario(
                                                email: emailController.text,
                                                password: passController.text,
                                                name: '',
                                                confirmPassword: ''));
                                        Navigator.of(context)
                                            .pushNamed('/splash');
                                      });
                                }
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
                        child: userManager.loading
                            ? const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )
                            : const Text(
                                'Entrar',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
