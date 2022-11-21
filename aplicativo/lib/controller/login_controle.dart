import 'package:flutter/widgets.dart';

class LoginControle {
  ValueNotifier<bool> inLoader = ValueNotifier<bool>(false);
  String? _login;
  setLogin(String value) => _login = value;

  String? _senha;
  setSenha(String value) => _senha = value;

  Future<bool> auth() async {
    inLoader.value = true;
    await Future.delayed(Duration(seconds: 2));
    inLoader.value = false;
    return _login == 'admin' && _senha == 'admin';
  }
}
