import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:login_page_with_mobx/ui/pages/login/login_presenter.dart';
import 'package:login_page_with_mobx/ui/pages/pages.dart';

class LoginPresenterSpy extends Mock implements LoginPresenter {}

void main() {
  
  Future<void> loadPage(WidgetTester tester) async {
    final loginPage = MaterialApp(home: LoginPage());
    await tester.pumpWidget(loginPage);
  }
  
  testWidgets('Should LoginPage with correct initial state', (WidgetTester tester) async {
    await loadPage(tester);

    final emailTextChildren = find.descendant(of: find.bySemanticsLabel('Email'), matching: find.byType(Text));
    //emailTextChildren = captura os filhos do tipo text do componente que contem uma String com valor "Email"
    //por padrão um textformfield sempre vai ter um filho do tipo text, que é o labelText, se ele tiver mais um é porque
    //o segundo filho do tipo text corresponde ao errorText, ou seja, ele tem um erro
    // seguindo a lógica, se o textformfield tem mais de um filho do tipo text, é porque ele tem um erro

    expect(
      emailTextChildren, 
      findsOneWidget,
      reason: 'TextFields should have no errors in the initial state',
    );

    final passwordTextChildren = find.descendant(of: find.bySemanticsLabel('Senha'), matching: find.byType(Text));
    expect(passwordTextChildren, findsOneWidget);

    final loginButton = tester.widget<InkWell>(
      find.byKey(
        ValueKey('login'),
      ),
    );

    expect(loginButton.onTap, null);
    expect(find.byType(CircularProgressIndicator), findsNothing);

  });

  testWidgets('Should present error if email is invalid', (WidgetTester tester) async {

  });


}
