import 'dart:async';

import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

abstract class Validation {
  String validate({@required String field, @required String value});
}

class ValidationSpy extends Mock implements Validation {}

class LoginState {
  String emailError;
}

class StreamLoginPresenter {

  Stream<String> get emailErrorStream => _controller.stream.map((state) => state.emailError);

  final Validation validation;
  final StreamController<LoginState> _controller = StreamController<LoginState>.broadcast();

  final _state = LoginState();

  StreamLoginPresenter({@required this.validation});

  void validateEmail(String email) {
    _state.emailError = validation.validate(field: 'email', value: email);
    _controller.add(_state);
  }

  
}

void main() {

  StreamLoginPresenter sut;
  ValidationSpy validation;
  String email;

  setUp(() {
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();
  });

  test('Should call Validation with correct values', () { 

    sut.validateEmail(email);

    verify(validation.validate(field: 'email', value: email)).called(1);
    
  });

  test('Should emit email error if Validation fails', () {

    when(validation.validate(field: anyNamed('field'), value: anyNamed('value'))).thenReturn('email error');

    expectLater(sut.emailErrorStream, emits('email error'));

    sut.validateEmail(email);

  });

}