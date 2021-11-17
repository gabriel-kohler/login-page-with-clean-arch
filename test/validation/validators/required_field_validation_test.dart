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
    return 'Campo obrigatório';
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

}