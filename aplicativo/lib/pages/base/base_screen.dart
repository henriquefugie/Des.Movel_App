import 'package:aplicativo/model/page_manager.dart';
import 'package:aplicativo/pages/logout/logout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../dashboard/dashboard.dart';

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
          Logout(),
        ],
      ),
    );
  }
}
