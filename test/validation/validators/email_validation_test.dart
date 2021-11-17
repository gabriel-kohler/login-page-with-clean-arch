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

  test('Should return null if value is null', () {

    final sut = EmailValidation('any_field');

    final error = sut.validate(value: null);
    
    expect(error, null);
  });

}