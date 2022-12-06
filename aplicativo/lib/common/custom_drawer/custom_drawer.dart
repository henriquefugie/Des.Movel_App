import 'package:aplicativo/common/custom_drawer/custo_drawer_header.dart';
import 'package:aplicativo/common/custom_drawer/drawer_tile.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: const <Widget>[
          CustomDrawerHeader(),
          DrawerTile(
            iconData: Icons.dashboard,
            title: 'Dashboard',
            page: 0,
          ),
          SizedBox(
            height: 450,
          ),
          DrawerTile(
            iconData: Icons.logout,
            title: 'Log out',
            page: 1,
          ),
        ],
      ),
    );
  }
}
