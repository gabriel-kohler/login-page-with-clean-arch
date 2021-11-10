
import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:login_page_with_mobx/ui/pages/login/login_presenter.dart';
import 'package:login_page_with_mobx/ui/pages/pages.dart';

class LoginPresenterSpy extends Mock implements LoginPresenter {}

void main() {
  
  LoginPresenterSpy loginPresenter;

  StreamController<String> emailErrorController;
  StreamController<String> passwordErrorController;
  StreamController<String> mainErrorController;
  StreamController<bool> isFormValidController;
  StreamController<bool> isLoadingController;

  Future<void> loadPage(WidgetTester tester) async {
    loginPresenter = LoginPresenterSpy();

    emailErrorController = StreamController<String>();
    passwordErrorController = StreamController<String>();
    isFormValidController = StreamController<bool>();
    isLoadingController = StreamController<bool>();
    mainErrorController = StreamController<String>();

    when(loginPresenter.emailErrorStream).thenAnswer((_) => emailErrorController.stream);
    when(loginPresenter.passwordErrorStream).thenAnswer((_) => passwordErrorController.stream);
    when(loginPresenter.isFormValidStream).thenAnswer((_) => isFormValidController.stream);
    when(loginPresenter.isLoadingStream).thenAnswer((_) => isLoadingController.stream);
    when(loginPresenter.mainErrorStream).thenAnswer((_) => mainErrorController.stream);


    final loginPage = MaterialApp(
      home: LoginPage(loginPresenter),
    );
    await tester.pumpWidget(loginPage);


  }

  tearDown(() {
    emailErrorController.close();
    passwordErrorController.close();
    isFormValidController.close();
    isLoadingController.close();
    mainErrorController.close();
  });
  
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

  testWidgets('Should present error if email is invalid', (WidgetTester tester) async {
    await loadPage(tester);

    emailErrorController.add('email error');
    await tester.pump();

    expect(find.text('email error'), findsOneWidget);
  });

  testWidgets('Should present no error if email is valid', (WidgetTester tester) async {
    await loadPage(tester);

    final emailTextChildren = find.descendant(of: find.bySemanticsLabel('Email'), matching: find.byType(Text));

    emailErrorController.add('');
    await tester.pump();
    expect(emailTextChildren, findsOneWidget);

    emailErrorController.add(null);
    await tester.pump();
    expect(emailTextChildren, findsOneWidget);
  });

  testWidgets('Should present error if password is invalid', (WidgetTester tester) async {
    await loadPage(tester);

    passwordErrorController.add('password error');
    await tester.pump();

    expect(find.text('password error'), findsOneWidget);
  });

  testWidgets('Should presents no error if password is valid', (WidgetTester tester) async {
    await loadPage(tester);

    final passwordTextChildren = find.descendant(of: find.bySemanticsLabel('Senha'), matching: find.byType(Text));

    passwordErrorController.add('');
    await tester.pump();
    expect(passwordTextChildren, findsOneWidget);

    passwordErrorController.add(null);
    await tester.pump();
    expect(passwordTextChildren, findsOneWidget);
  });

  testWidgets('Should enable LoginButton if form is valid', (WidgetTester tester) async {
    await loadPage(tester);

    isFormValidController.add(true);
    await tester.pump();

    final loginButton = tester.widget<InkWell>(
      find.byKey(
        ValueKey('login'),
      ),
    );

    expect(loginButton.onTap, isNotNull);
  });

  testWidgets('Should disable button if form is invalid', (WidgetTester tester) async {
    await loadPage(tester);

    isFormValidController.add(false);
    await tester.pump();
    
    final loginButton = tester.widget<InkWell>(
      find.byKey(
        ValueKey('login'),
      ),
    );

    expect(loginButton.onTap, null);
  });

  testWidgets('Should call Authentication on form submit', (WidgetTester tester) async {
    await loadPage(tester);

    isFormValidController.add(true);
    await tester.pump();

    final loginButton = tester.widget<InkWell>(
      find.byKey(
        ValueKey('login'),
      ),
    );

    loginButton.onTap(); 

    verify(loginPresenter.auth()).called(1);
  });

  testWidgets('Should present loading', (WidgetTester tester) async {
    await loadPage(tester);

    isLoadingController.add(true);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Should hide loading', (WidgetTester tester) async {
    await loadPage(tester);

    isLoadingController.add(true);
    await tester.pump();

    isLoadingController.add(false);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('Should error message if Authentication fails', (WidgetTester tester) async {
    await loadPage(tester);

    mainErrorController.add('login error');
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('login error'), findsOneWidget);

  });

  testWidgets('Should LoginPage close streams', (WidgetTester tester) async {
    await loadPage(tester);

    addTearDown(() {
      verify(loginPresenter.dispose()).called(1);
    });
  });

}
