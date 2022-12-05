import 'package:aplicativo/controller/pedrometro.dart';
import 'package:aplicativo/model/page_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common/custom_drawer/custom_drawer.dart';
import '../dashboard/dashboard.dart';
import '../login/login.dart';

class BaseScreen extends StatelessWidget {
  BaseScreen({super.key});

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          const Dashboard(),
          Pedometro(),
          Scaffold(
            drawer: const CustomDrawer(),
            appBar: AppBar(
              title: const Text('Configuracoes'),
            ),
          ),
        ],
      ),
    );
  }
}
