import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:aplicativo/model/user_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

String nome = '';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({super.key});

  Future<String> loadNome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('userdata') ?? "";
    Map<String, dynamic> decodedMap = json.decode(username);
    return decodedMap['name'];
  }

  @override
  Widget build(BuildContext context) {
    loadNome().then((path) {
      nome = path;
    });
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 24, 16, 8),
      height: 200,
      child: Consumer<UserManager>(
        builder: (_, userManager, __) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const Text(
                'Aplicativo Fitness',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Olá, $nome',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
