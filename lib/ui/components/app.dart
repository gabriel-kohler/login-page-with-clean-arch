import 'package:flutter/material.dart';

import '/ui/pages/pages.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Auth with Clean arch, using unit tests and design patterns',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: LoginPage(null),
      // routes: {
      //   AppRoutes.WELCOME_PAGE: (context) => WelcomePage(),
      //   AppRoutes.LOGIN_PAGE: (context) => LoginPage(null),
      // },
    );
  }
}