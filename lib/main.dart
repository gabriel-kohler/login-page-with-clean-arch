import 'package:flutter/material.dart';
import 'package:login_page_with_mobx/utils/app_routes.dart';
import 'package:login_page_with_mobx/view/login_page.dart';
import 'package:login_page_with_mobx/view/welcome_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      routes: {
        AppRoutes.WELCOME_PAGE: (context) => WelcomePage(),
        AppRoutes.LOGIN_PAGE: (context) => LoginPage(),
      },
    );
  }
}
