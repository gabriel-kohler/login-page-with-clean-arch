import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:login_page_with_mobx/validation/validators/validators.dart';
import 'package:login_page_with_mobx/validation/dependencies/dependencies.dart';

import 'package:login_page_with_mobx/presentation/dependencies/dependencies.dart';

class FieldValidationSpy extends Mock implements FieldValidation {}

class ValidationComposite implements Validation {

  final List<FieldValidation> validations;

  ValidationComposite({this.validations});

  @override
  String validate({String field, String value}) {
    validations.first.validate(value: value);
    return null;
  }

}


void main() {

  test('Should call validate with correct values', () {

    final FieldValidationSpy validation1 = FieldValidationSpy();
    final FieldValidationSpy validation2 = FieldValidationSpy();
    final List<FieldValidation> validations = [validation1, validation2];

    final sut = ValidationComposite(validations: validations);

    sut.validate(field: 'any_field', value: 'any_value');

    verify(validation1.validate(value: 'any_value')).called(1);
  });
}