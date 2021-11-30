import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:login_page_with_mobx/ui/pages/pages.dart';
import 'package:login_page_with_mobx/utils/app_routes.dart';
import 'package:mockito/mockito.dart';



class SplashPresenterSpy extends Mock implements SplashPresenter {}



void main() {

  SplashPresenter splashPresenterSpy;

  StreamController<String> navigateToController;

  Future<void> loadPage(WidgetTester tester) async {

    splashPresenterSpy = SplashPresenterSpy();

    navigateToController = StreamController<String>();

    when(splashPresenterSpy.navigateToStream).thenAnswer((_) => navigateToController.stream);

    final splashPage = GetMaterialApp(
      initialRoute: AppRoutes.SPLASH_PAGE,
      getPages: [
        GetPage(name: AppRoutes.SPLASH_PAGE, page: () => SplashPage(splashPresenter: splashPresenterSpy)),
        GetPage(name: '/any_route', page: () => Scaffold(
          body: Text('navigation test')),
        ),
      ],
    );

    await tester.pumpWidget(splashPage);
  }

  tearDown((){
    navigateToController.close();
  });

  testWidgets('Should present spinner on page load', (WidgetTester tester) async {

    await loadPage(tester);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should call loadCurrentAccount on page load', (WidgetTester tester) async {

    await loadPage(tester);

    verify(splashPresenterSpy.loadCurrentAccount()).called(1);

  });

  testWidgets('Should change page', (WidgetTester tester) async {

    await loadPage(tester);

    navigateToController.add('/any_route');
    await tester.pumpAndSettle();

    expect(Get.currentRoute, '/any_route');
    expect(find.text('navigation test'), findsOneWidget);

  });
  testWidgets('Should not change page', (WidgetTester tester) async {

    await loadPage(tester);

    navigateToController.add('');
    await tester.pump();
    expect(Get.currentRoute, AppRoutes.SPLASH_PAGE);

    navigateToController.add(null);
    await tester.pump();
    expect(Get.currentRoute, AppRoutes.SPLASH_PAGE);
    
  });
  
}
