import 'package:aplicativo/controller/validators.dart';
import 'package:aplicativo/model/user_manager.dart';
import 'package:aplicativo/model/usuario.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cadastro extends StatelessWidget {
  Cadastro({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final Usuario usuarioCadastro =
      Usuario(email: '', password: '', name: '', confirmPassword: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pushNamed('/login'),
        ),
        title: const Text('Criar Conta'),
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
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Nome Completo'),
                  autocorrect: false,
                  validator: (name) {
                    if (name!.isEmpty) {
                      return 'Campo obrigatório';
                    } else if (name.trim().split(' ').length <= 1) {
                      return 'Preencha seu Nome Completo';
                    }
                    return null;
                  },
                  onSaved: (name) => usuarioCadastro.name = name!,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  validator: (email) {
                    if (email!.isEmpty) {
                      return 'Campo obrigatório';
                    } else if (!emailValid(email)) {
                      return 'E-mail inválido';
                    }
                    return null;
                  },
                  onSaved: (email) => usuarioCadastro.email = email!,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Senha'),
                  autocorrect: false,
                  obscureText: true,
                  validator: (pass) {
                    if (pass!.isEmpty) {
                      return 'Campo obrigatório';
                    } else if (pass.length < 6) {
                      return 'Senha muito fraca';
                    }
                    return null;
                  },
                  onSaved: (pass) => usuarioCadastro.password = pass!,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Repita a Senha'),
                  autocorrect: false,
                  obscureText: true,
                  validator: (pass) {
                    if (pass!.isEmpty) {
                      return 'Campo obrigatório';
                    } else if (pass.length < 6) {
                      return 'Senha muito fraca';
                    }
                    return null;
                  },
                  onSaved: (pass) => usuarioCadastro.confirmPassword = pass!,
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                      }
                      if (usuarioCadastro.password !=
                          usuarioCadastro.confirmPassword) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Senhas não coincidem!'),
                          backgroundColor: Colors.red,
                        ));
                      }
                      context.read<UserManager>().signUp(
                            user: usuarioCadastro,
                            onSuccess: () {
                              Navigator.of(context).pushNamed('/splash');
                            },
                            onFail: (e) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Falha ao cadastrar: $e'),
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
                      'Criar Conta',
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
