import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:login_page_with_mobx/utils/app_routes.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

void main() {

  Future<void> loadPage(WidgetTester tester) async {
     final splashPage = GetMaterialApp(
      initialRoute: AppRoutes.SPLASH_PAGE,
      getPages: [
        GetPage(name: AppRoutes.SPLASH_PAGE, page: () => SplashPage()),
      ],
    );

    await tester.pumpWidget(splashPage);
  }

  testWidgets('Should present spinner on page load', (WidgetTester tester) async {

    await loadPage(tester);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
