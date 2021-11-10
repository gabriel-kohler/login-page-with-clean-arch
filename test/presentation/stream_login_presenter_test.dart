import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

abstract class Validation {
  String validate({@required String field, @required String value});
}

class ValidationSpy extends Mock implements Validation {}

class StreamLoginPresenter {

  final Validation validation;

  StreamLoginPresenter({@required this.validation});

  void validateEmail(String email) {
    validation.validate(field: 'email', value: email);
  }

  
}

void main() {

  StreamLoginPresenter sut;
  ValidationSpy validation;

  setUp(() {
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
  });

  test('Should call Validation with correct values', () {

    final email = faker.internet.email();

    sut.validateEmail(email);

    verify(validation.validate(field: 'email', value: email)).called(1);
    
  });

}