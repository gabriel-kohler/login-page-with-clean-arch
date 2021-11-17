import 'package:test/test.dart';
import 'package:meta/meta.dart';

abstract class FieldValidation {
  String get field;
  String validate({@required String value});
}

class RequiredFieldValidation implements FieldValidation {
  final String field;

  RequiredFieldValidation(this.field);

  @override
  String validate({String value}) {
    return value?.isNotEmpty == true ? null : 'Campo obrigatório';
  }


}

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