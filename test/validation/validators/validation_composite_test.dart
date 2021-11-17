import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:login_page_with_mobx/validation/dependencies/dependencies.dart';

import 'package:login_page_with_mobx/presentation/dependencies/dependencies.dart';

class FieldValidationSpy extends Mock implements FieldValidation {}

class ValidationComposite implements Validation {

  final List<FieldValidation> validations;

  ValidationComposite({this.validations});

  @override
  String validate({String field, String value}) {
    String error;
    for (final validation in validations) {
      error = validation.validate(value: value);
      if (error?.isNotEmpty == true) {
        return error;
      } else {
        return null;
      }
    }
    return error;
  }

}


void main() {

  FieldValidationSpy validation1;
  FieldValidationSpy validation2;
  List<FieldValidation> validations;
  ValidationComposite sut;

  void mockValidation1(String error) => when(validation1.validate(value: anyNamed('value'))).thenReturn(error);
  void mockValidation2(String error) => when(validation2.validate(value: anyNamed('value'))).thenReturn(error);


  setUp(() {
    validation1 = FieldValidationSpy();
    validation2 = FieldValidationSpy();
    validations = [validation1, validation2];

    when(validation1.field).thenReturn('other_field');
    mockValidation1(null);
    when(validation2.field).thenReturn('any_field');
    mockValidation2(null);

    sut = ValidationComposite(validations: validations);

  });

  test('Should call validate with correct values', () {

    sut.validate(field: 'other_field', value: 'any_value');

    verify(validation1.validate(value: 'any_value')).called(1);
  });

  test('Should return null if all validations returns null', () {
    mockValidation1('');
    mockValidation2('');

    final error = sut.validate(field: 'any_field', value: 'any_value');

    expect(error, null);
  });

  test('Should return first error if validation return error', () {
    mockValidation1('error1');
    mockValidation2('error2');

    final error = sut.validate(field: 'any_field', value: 'any_value');

    expect(error, 'error1');
  });

}