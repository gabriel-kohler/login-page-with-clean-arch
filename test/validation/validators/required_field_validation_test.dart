import 'package:test/test.dart';

import 'package:login_page_with_mobx/validation/validators/validators.dart';

void main() {

  RequiredFieldValidation sut;

  setUp(() {
    sut = RequiredFieldValidation('any_field');
  });

  test('Should return error if value is null', () {

    final error = sut.validate(value: null);

    expect(error, 'Campo obrigatório');

  });

  test('Should return error if value is empty', () {
    
    final error = sut.validate(value: '');

    expect(error, 'Campo obrigatório');
  });

  test('Should return null if value is not empty', () {
    
    final error = sut.validate(value: 'any_value');

    expect(error, null);
  });

}