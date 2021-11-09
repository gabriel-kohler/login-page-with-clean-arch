
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:login_page_with_mobx/ui/pages/login/login_presenter.dart';
import 'package:login_page_with_mobx/ui/pages/pages.dart';

class LoginPresenterSpy extends Mock implements LoginPresenter {}

void main() {
  
  LoginPresenterSpy loginPresenter;

  Future<void> loadPage(WidgetTester tester) async {
    loginPresenter = LoginPresenterSpy();

    final loginPage = MaterialApp(
      home: LoginPage(loginPresenter),
    );
    await tester.pumpWidget(loginPage);
  }
  
  testWidgets('Should LoginPage with correct initial state', (WidgetTester tester) async {
    await loadPage(tester);

    final emailTextChildren = find.descendant(of: find.bySemanticsLabel('Email'), matching: find.byType(Text));
    //emailTextChildren = captura os filhos do tipo text do componente que contem uma String com valor "Email" (textfield nesse caso)
    //por padrão um textformfield sempre vai ter um filho do tipo text, que é o labelText, se ele tiver mais de um é porque
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

  testWidgets('Should call validate with correct values', (WidgetTester tester) async {
    await loadPage(tester);

    final email = faker.internet.email();
    final password = faker.internet.password();

    await tester.enterText(find.bySemanticsLabel('Email'), email);
    verify(loginPresenter.validateEmail(email)).called(1);

    await tester.enterText(find.bySemanticsLabel('Senha'), password);
    verify(loginPresenter.validatePassword(password)).called(1);
  });


}
