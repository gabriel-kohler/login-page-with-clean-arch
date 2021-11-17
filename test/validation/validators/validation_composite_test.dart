import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:login_page_with_mobx/validation/dependencies/dependencies.dart';
import 'package:login_page_with_mobx/validation/validators/validators.dart';

class FieldValidationSpy extends Mock implements FieldValidation {}

void main() {

  FieldValidationSpy validation1;
  FieldValidationSpy validation2;
  FieldValidationSpy validation3;
  List<FieldValidation> validations;
  ValidationComposite sut;

  void mockValidation1(String error) => when(validation1.validate(value: anyNamed('value'))).thenReturn(error);
  void mockValidation2(String error) => when(validation2.validate(value: anyNamed('value'))).thenReturn(error);
  void mockValidation3(String error) => when(validation3.validate(value: anyNamed('value'))).thenReturn(error);


  setUp(() {
    validation1 = FieldValidationSpy();
    validation2 = FieldValidationSpy();
    validation3 = FieldValidationSpy();
    validations = [validation1, validation2, validation3];

    when(validation1.field).thenReturn('other_field');
    mockValidation1(null);
    when(validation2.field).thenReturn('any_field');
    mockValidation2(null);
    when(validation3.field).thenReturn('any_field');
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

  test('Should returns the first error of the correct field', () {
    mockValidation1('error1');
    mockValidation2('error2');
    mockValidation3('error3');

    final error = sut.validate(field: 'any_field', value: 'any_value');

    expect(error, 'error2');
  });

}