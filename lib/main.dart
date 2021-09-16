import 'package:flutter/material.dart';
import 'package:login_page_with_mobx/ui/pages/login_page.dart';
import 'package:login_page_with_mobx/ui/pages/welcome_page.dart';
import 'package:login_page_with_mobx/utils/app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
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
