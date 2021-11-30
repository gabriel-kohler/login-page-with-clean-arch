import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:login_page_with_mobx/utils/app_routes.dart';
import 'package:mockito/mockito.dart';

abstract class SplashPresenter {
  Future<void> loadCurrentAccount();
}

class SplashPresenterSpy extends Mock implements SplashPresenter {}

class SplashPage extends StatelessWidget {

  final SplashPresenter splashPresenter;

  SplashPage({@required this.splashPresenter});

  @override
  Widget build(BuildContext context) {
    splashPresenter.loadCurrentAccount();

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

  SplashPresenter splashPresenterSpy;

  Future<void> loadPage(WidgetTester tester) async {

    splashPresenterSpy = SplashPresenterSpy();

    final splashPage = GetMaterialApp(
      initialRoute: AppRoutes.SPLASH_PAGE,
      getPages: [
        GetPage(name: AppRoutes.SPLASH_PAGE, page: () => SplashPage(splashPresenter: splashPresenterSpy)),
      ],
    );

    await tester.pumpWidget(splashPage);
  }

  testWidgets('Should present spinner on page load', (WidgetTester tester) async {

    await loadPage(tester);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should call loadCurrentAccount on page load', (WidgetTester tester) async {

    await loadPage(tester);

    verify(splashPresenterSpy.loadCurrentAccount()).called(1);

  });
  
}
