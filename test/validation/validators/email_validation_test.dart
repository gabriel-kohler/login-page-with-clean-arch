import 'package:faker/faker.dart';
import 'package:test/test.dart';

import 'package:login_page_with_mobx/validation/validators/validators.dart';

void main() {

  EmailValidation sut;

  setUp(() {
    sut = EmailValidation('any_field');
  });

  test('Should return null if value is null', () {

    final error = sut.validate(value: null);
    
    expect(error, null);
  });

   test('Should return null if value is empty', () {
    
    final error = sut.validate(value: '');

    expect(error, null);
  });

  test('Should return error if email is invalid', () {
    
    final error = sut.validate(value: 'kohler2018gmailcom');

    expect(error, 'Campo inválido');
  });

  test('Should return null if email is valid', () {
    
    final email = faker.internet.email();
    final error = sut.validate(value: email);

    expect(error, null);
  });

}