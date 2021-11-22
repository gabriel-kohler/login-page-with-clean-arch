import 'package:test/test.dart';

import 'package:login_page_with_mobx/main/factories/factories.dart';
import 'package:login_page_with_mobx/validation/validators/validators.dart';

void main() {

  test('Should return ValidationComposite with correct validations', () {
    final validations = makeLoginValidations();

    expect(validations, [
      RequiredFieldValidation('email'),
      EmailValidation('email'),
      RequiredFieldValidation('password'),
      ],
    );


  });
}