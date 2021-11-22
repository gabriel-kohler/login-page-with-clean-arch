import 'package:login_page_with_mobx/presentation/dependencies/dependencies.dart';

import '/validation/validators/validators.dart';

Validation makeLoginValidation() {
  final emailValidation = EmailValidation('email');
  final passwordFieldValidation = RequiredFieldValidation('password');
  final emailFieldValidation = RequiredFieldValidation('email');

  return ValidationComposite(validations: [emailValidation, passwordFieldValidation, emailFieldValidation]);

}