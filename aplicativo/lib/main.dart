import 'dart:io';

import 'package:aplicativo/model/user_manager.dart';
import 'package:aplicativo/pages/base/base_screen.dart';
import 'package:aplicativo/pages/cadastro/cadastro.dart';
import 'package:aplicativo/pages/login/login.dart';
import 'package:aplicativo/pages/splash/splashlogin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:permission_handler/permission_handler.dart';

FirebaseAuth auth = FirebaseAuth.instance;
createUser({email, password}) async {}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static Future initialGetSavedData() async {}

  const MyApp({super.key});

  Future<Object> requestPermission() async {
    PermissionStatus result;
    if (Platform.isAndroid) {
      result = await Permission.activityRecognition.request();
      return result;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: requestPermission(),
        builder: (context, AsyncSnapshot<Object> permission) {
          if (permission.hasData) {
            return ChangeNotifierProvider(
              create: (_) => UserManager(),
              child: MaterialApp(
                title: 'Fitness App',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  primaryColor: const Color.fromRGBO(96, 63, 255, 1),
                  fontFamily: 'Poppins',
                  // scaffoldBackgroundColor: const Color.fromRGBO(96, 63, 255, 1),
                  appBarTheme: const AppBarTheme(
                    elevation: 0,
                  ),
                  colorScheme: ColorScheme.fromSwatch(
                          primarySwatch: Colors.purple)
                      .copyWith(secondary: const Color.fromARGB(255, 0, 0, 0)),
                ),
                initialRoute: '/splash',
                onGenerateRoute: (settings) {
                  switch (settings.name) {
                    case '/login':
                      return MaterialPageRoute(builder: (_) => Login());
                    case '/splash':
                      return MaterialPageRoute(builder: (_) => Splash1());
                    case '/signup':
                      return MaterialPageRoute(builder: (_) => Cadastro());
                    case '/base':
                    default:
                      return MaterialPageRoute(builder: (_) => BaseScreen());
                  }
                },
              ),
            );
          } else if (permission.hasError) {
            return Center(
              child: Text(
                "Erro:${permission.hasError}",
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

//aa
