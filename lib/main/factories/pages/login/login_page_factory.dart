import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '/infra/http/http.dart';
import '/data/usecases/usecases.dart';
import '/presentation/presenters/presenters.dart';
import '/validation/validators/validators.dart';
import '/ui/pages/pages.dart';

Widget makeLoginPage() {
  final emailValidation = EmailValidation('email');
  final passwordFieldValidation = RequiredFieldValidation('password');
  final emailFieldValidation = RequiredFieldValidation('email');

  final validationComposite = ValidationComposite(validations: [emailValidation, passwordFieldValidation, emailFieldValidation]);

  final client = Client();
  final httpClient = HttpAdapter(client);
  //final url = 'https://fordevs.herokuapp.com/api/login';
  final url = 'https://firebaselink.com';

  final authentication = RemoteAuthentication(httpClient: httpClient, url: url);

  final loginPresenter = StreamLoginPresenter(validation: validationComposite, authentication: authentication);

  return LoginPage(loginPresenter);
}