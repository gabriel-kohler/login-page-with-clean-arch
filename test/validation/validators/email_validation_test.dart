import 'package:test/test.dart';

import 'package:login_page_with_mobx/validation/dependencies/field_validation.dart';


class EmailValidation implements FieldValidation {
  final String field;

  EmailValidation(this.field);

  @override
  String validate({String value}) {
    return null;
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

}