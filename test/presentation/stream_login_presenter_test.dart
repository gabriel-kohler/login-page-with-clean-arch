import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:login_page_with_mobx/presentation/presenters/presenters.dart';
import 'package:login_page_with_mobx/presentation/dependencies/dependencies.dart';


class ValidationSpy extends Mock implements Validation {}

void main() {

  StreamLoginPresenter sut;
  ValidationSpy validation;
  String email;

  setUp(() {
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();
  });

  test('Should call email validation with correct values', () { 

    sut.validateEmail(email);

    verify(validation.validate(field: 'email', value: email)).called(1);
    
  });

  test('Should emit email error if email validation fails', () {

    when(validation.validate(field: anyNamed('field'), value: anyNamed('value'))).thenReturn('email error');

    sut.emailErrorStream.listen(
      expectAsync1(
        (error) {
          expect(error, 'email error');
        },
      ),
    );

    expectLater(sut.emailErrorStream, emits('email error'));

    sut.validateEmail(email);
    sut.validateEmail(email);

  });

  test('Should emit no error if email validation return success', () {
    when(validation.validate(field: anyNamed('field'), value: anyNamed('value'))).thenReturn(null);

    expectLater(sut.emailErrorStream, emits(null));

    sut.validateEmail(email);
  });

}