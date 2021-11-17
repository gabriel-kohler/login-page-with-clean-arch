import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:login_page_with_mobx/utils/app_routes.dart';

import '/ui/components/components.dart';

import '/main/factories/pages/login/login.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {

  final ThemeData theme = ThemeData();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Auth with Clean arch, using unit tests and design patterns',
      debugShowCheckedModeBanner: false,
      theme: makeAppTheme(),
      initialRoute: AppRoutes.WELCOME_PAGE,
      getPages: [
        GetPage(name: AppRoutes.WELCOME_PAGE, page: makeWelcomePage),
        GetPage(name: AppRoutes.LOGIN_PAGE, page: makeLoginPage),
      ],      
    );
  }
}


