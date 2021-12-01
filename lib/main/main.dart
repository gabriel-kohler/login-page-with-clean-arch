import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '/main/factories/factories.dart';

import '/ui/components/components.dart';
import '/utils/utils.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
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
      initialRoute: AppRoutes.SPLASH_PAGE,
      getPages: [
        GetPage(name: AppRoutes.WELCOME_PAGE, page: makeWelcomePage),
        GetPage(name: AppRoutes.SPLASH_PAGE, page: makeSplashPage),
        GetPage(name: AppRoutes.LOGIN_PAGE, page: makeLoginPage),
        GetPage(
          name: AppRoutes.HOME_PAGE,
          page: () => const Scaffold(
            body: Center(
              child: const Text('HomePage'),
            ),
          ),
        ),
      ],
    );
  }
}
