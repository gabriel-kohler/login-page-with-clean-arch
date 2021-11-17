import 'package:faker/faker.dart';
import 'package:test/test.dart';

import 'package:login_page_with_mobx/validation/dependencies/field_validation.dart';


class EmailValidation implements FieldValidation {
  final String field;

  EmailValidation(this.field);

  @override
  String validate({String value}) {
    final regex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    final isValid = value?.isNotEmpty != true || regex.hasMatch(value);
    return isValid ? null : 'Campo inválido';
  }
}

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