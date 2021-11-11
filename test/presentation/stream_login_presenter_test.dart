import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:login_page_with_mobx/domain/usecases/authentication.dart';
import 'package:login_page_with_mobx/domain/entities/account_entity.dart';

import 'package:login_page_with_mobx/presentation/presenters/presenters.dart';
import 'package:login_page_with_mobx/presentation/dependencies/dependencies.dart';



class ValidationSpy extends Mock implements Validation {}

class AuthenticationSpy extends Mock implements Authentication {}

void main() {

  StreamLoginPresenter sut;
  ValidationSpy validation;
  Authentication authentication;
  String email;
  String password;

  setUp(() {
    validation = ValidationSpy();
    authentication = AuthenticationSpy();
    sut = StreamLoginPresenter(validation: validation, authentication: authentication);
    email = faker.internet.email();
    password = faker.internet.password();
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

    sut.isFormValidStream.listen(
      expectAsync1(
        (isValid) {
          expect(isValid, false);
        },
      ),
    );

    expectLater(sut.emailErrorStream, emits('email error'));

    sut.validateEmail(email);
    sut.validateEmail(email);

  });

  test('Should emit null if email validation return success', () {
    when(validation.validate(field: anyNamed('field'), value: anyNamed('value'))).thenReturn(null);

    sut.emailErrorStream.listen(
      expectAsync1(
        (error) {
          expect(error, null);
        },
      ),
    );

    sut.isFormValidStream.listen(
      expectAsync1(
        (isValid) {
          expect(isValid, false);
        },
      ),
    );

    expectLater(sut.emailErrorStream, emits(null));

    sut.validateEmail(email);
    sut.validateEmail(email);
  });

  test('Should call password validation with correct values', () {

    sut.validatePassword(password);

    verify(validation.validate(field: 'password', value: password));
  });

  test('Should emits passwordError if password is invalid', () {

    when(validation.validate(field: anyNamed('field'), value: anyNamed('value'))).thenReturn('password error');

    sut.passwordErrorStream.listen(
      expectAsync1(
        (error) {
          expect(error, 'password error');
        },
      ),
    );

    sut.isFormValidStream.listen(
      expectAsync1((isValid){
        expect(isValid, false);
      }),
    );

    expectLater(sut.passwordErrorStream, emits('password error'));

    sut.validatePassword(password);
    sut.validatePassword(password);

  });

  test('Should emits null if password is valid', () {

    when(validation.validate(field: anyNamed('field'), value: anyNamed('value'))).thenReturn(null);

    sut.passwordErrorStream.listen(
      expectAsync1((error) {
        expect(error, null);
      }),
    );

    sut.isFormValidStream.listen(
      expectAsync1((isValid){
        expect(isValid, false);
      }),
    );

    expectLater(sut.passwordErrorStream, emits(null));
    
    sut.validatePassword(password);
    sut.validatePassword(password);
    
  });
  
  test('Should emits form invalid if any field is invalid', () {

    when(validation.validate(field: 'email', value: anyNamed('value'))).thenReturn('email error');
    when(validation.validate(field: 'password', value: anyNamed('value'))).thenReturn('password error');

    sut.emailErrorStream.listen(
      expectAsync1((error) { 
        expect(error, 'email error');
      }),
    );

    sut.passwordErrorStream.listen(
      expectAsync1((error) { 
        expect(error, 'password error');
      }),
    );
    sut.isFormValidStream.listen(
    expectAsync1((isValid) { 
      expect(isValid, false);
    }),
  );

  expectLater(sut.isFormValidStream, emits(false));

  sut.validateEmail(email);
  sut.validatePassword(password);

  });

  
  test('Should emits form invalid if email field is valid and password field is invalid', () {

    when(validation.validate(field: 'email', value: anyNamed('value'))).thenReturn(null);
    when(validation.validate(field: 'password', value: anyNamed('value'))).thenReturn('password error');

    sut.emailErrorStream.listen(
      expectAsync1((error) { 
        expect(error, null);
      }),
    );

    sut.passwordErrorStream.listen(
      expectAsync1((error) { 
        expect(error, 'password error');
      }),
    );
    sut.isFormValidStream.listen(
    expectAsync1((isValid) { 
      expect(isValid, false);
    }),
  );

  expectLater(sut.isFormValidStream, emits(false));

  sut.validateEmail(email);
  sut.validatePassword(password);

  });

  
  test('Should emits form invalid if email field is invalid and password field is valid', () {

    when(validation.validate(field: 'email', value: anyNamed('value'))).thenReturn('email error');
    when(validation.validate(field: 'password', value: anyNamed('value'))).thenReturn(null);

    sut.emailErrorStream.listen(
      expectAsync1((error) { 
        expect(error, 'email error');
      }),
    );

    sut.passwordErrorStream.listen(
      expectAsync1((error) { 
        expect(error, null);
      }),
    );
    sut.isFormValidStream.listen(
    expectAsync1((isValid) { 
      expect(isValid, false);
    }),
  );

  expectLater(sut.isFormValidStream, emits(false));

  sut.validateEmail(email);
  sut.validatePassword(password);

  });

  test('Should emits form valid if any field is valid', () async {

    when(validation.validate(field: 'email', value: anyNamed('value'))).thenReturn(null);
    when(validation.validate(field: 'password', value: anyNamed('value'))).thenReturn(null);

    sut.emailErrorStream.listen(
      expectAsync1((error) { 
        expect(error, null);
      }),
    );

    sut.passwordErrorStream.listen(
      expectAsync1((error) { 
        expect(error, null);
      }),
    );

    expectLater(sut.isFormValidStream, emitsInOrder([false, true]));

  sut.validateEmail(email);
  await Future.delayed(Duration.zero);
  sut.validatePassword(password);

  });

  test('Should call Authentication with correct values', () async {

    sut.validateEmail(email);
    sut.validatePassword(password);

    final params = AuthenticationParams(
      email: email, 
      password: password,
    );

    await sut.auth();

    verify(authentication.auth(params)).called(1);
  });

  test('Should emit correct events on Authentication success', () async {

    when(authentication.auth(any)).thenAnswer((_) async => AccountEntity('any value'));

    sut.validateEmail(email);
    sut.validatePassword(password);

    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));

    await sut.auth();

  });  

}