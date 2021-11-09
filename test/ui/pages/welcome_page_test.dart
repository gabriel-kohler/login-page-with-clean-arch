import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_page_with_mobx/ui/pages/pages.dart';
import 'package:login_page_with_mobx/ui/pages/welcome_page.dart';

void main() {
  
  testWidgets('Should WelcomePage with correct initial state',
      (WidgetTester tester) async {
    //signIn and signUp button need to be enabled and call correct methods
    final welcomePage = MaterialApp(home: WelcomePage());
    await tester.pumpWidget(welcomePage);

    final signInInkwellButton = tester.widget<InkWell>(find.byKey(ValueKey('signIn')));
    final signUpInkwellButton = tester.widget<InkWell>(find.byKey(ValueKey('signUp')));

    expect(find.text('Bem-vindo!'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
    expect(find.text('Sign Up'), findsOneWidget);

    expect(signInInkwellButton.onTap, isNotNull);
    expect(signUpInkwellButton.onTap, isNotNull);
  });
}
