import 'package:faker/faker.dart';
import 'package:login_page_with_mobx/domain/entities/account_entity.dart';
import 'package:login_page_with_mobx/domain/helpers/domain_error.dart';
import 'package:login_page_with_mobx/domain/usecases/authentication.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

import 'package:login_page_with_mobx/presentation/presenters/presenters.dart';
import 'package:login_page_with_mobx/presentation/dependencies/dependencies.dart';

class ValidationSpy extends Mock implements Validation {}

class AuthenticationSpy extends Mock implements Authentication {}

void main() {


  Validation validation;
  AuthenticationSpy authentication;
  StreamLoginPresenter sut;
  String email;
  String password;

  PostExpectation mockValidationCall({String field}) => when(validation.validate(field: field != null ? field : anyNamed('field'), value : anyNamed('value')));

  void mockValidation({String returnValue, String field}) => mockValidationCall(field: field).thenReturn(returnValue);

  PostExpectation mockAuthenticationCall() => when(authentication.auth(any));

  void mockAuthentication() => mockAuthenticationCall().thenAnswer((_) async => AccountEntity('any value'));

  void mockAuthenticationError(DomainError error) => mockAuthenticationCall().thenThrow(error);

  setUp(() {
    validation = ValidationSpy();
    authentication = AuthenticationSpy();
    sut = StreamLoginPresenter(validation: validation, authentication: authentication);
    email = faker.internet.email();
    password = faker.internet.password();
    mockValidation();
  });

  test('Should call Validation with correct values', () {

    sut.validateEmail(email);

    verify(validation.validate(field: 'email', value: email)).called(1);
  });

  test('Should emit email error if email validation fails', () {

    mockValidation(field: 'email', returnValue: 'email error');

    sut.emailErrorStream.listen(
      expectAsync1((error) {
        expect(error, 'email error');
      }),    
    );

    sut.isFormValidStream.listen(
      expectAsync1((isValid){
        expect(isValid, false);
      }),    
    );

    expectLater(sut.emailErrorStream, emits('email error'));

    sut.validateEmail(email);
    sut.validateEmail(email);

  });

  test('Should emit null if validation return success', () {

    sut.emailErrorStream.listen(
      expectAsync1((error) {
        expect(error, null);
      }),    
    );

    sut.isFormValidStream.listen(
      expectAsync1((isValid){
        expect(isValid, false);
      }),    
    );

    expectLater(sut.emailErrorStream, emits(null));

    sut.validateEmail(email);
    sut.validateEmail(email);
    
  });

  test('Should call password validation with correct values', () {
    
    sut.validatePassword(password);

    verify(validation.validate(field: 'password', value: password));
  });

  test('Should emit password error if password validation fails ', () {

    mockValidation(field: 'password', returnValue: 'password error');

    sut.passwordErrorStream.listen(
      expectAsync1((error) {
        expect(error, 'password error');
      }),  
    );

    expectLater(sut.passwordErrorStream, emits('password error'));

    sut.validatePassword(password);
    sut.validatePassword(password);
  });

  test('Should emit null if password validation return success', () {

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

    expectLater(sut.passwordErrorStream, emits(null));

    sut.validatePassword(password);
    sut.validatePassword(password);
    
  });

  test('Should emit form invalid if any field is invalid', () {

    mockValidation(field: 'email', returnValue: 'email error');
    mockValidation(field: 'password', returnValue: 'password error');

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

    sut.validateEmail(email);
    sut.validatePassword(password);
    
  });

  test('Should emit form invalid if email is invalid and password is valid', () {
    mockValidation(field: 'email', returnValue: 'email error');
    mockValidation(field: 'password');

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

    sut.validateEmail(email);
    sut.validatePassword(password);

  });

  test('Should emit form invalid if email is valid and password is invalid', () {
    mockValidation(field: 'email');
    mockValidation(field: 'password', returnValue: 'password error');

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

    sut.validateEmail(email);
    sut.validatePassword(password);

  });

  test('Should emit form valid if any field is valid', () async {

    mockValidation(field: 'email');
    mockValidation(field: 'password');

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

    await sut.auth();

    verify(
      authentication.auth(
        AuthenticationParams(
          email: email, 
          password: password
        ),
      ),
    ).called(1);

  });

  test('Should emit correct events if Authentication return success', () async {
    
    mockAuthentication();

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

    sut.isFormValidStream.listen(
      expectAsync1((isValid) { 
        expect(isValid, true);
      }),
    );

    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));

    sut.validateEmail(email);
    sut.validatePassword(password);

    await sut.auth();
  });

  test('Should emit correct events on InvalidCredentialError', () async {

    mockAuthenticationError(DomainError.invalidCredentials);
   
    sut.mainErrorStream.listen(
      expectAsync1((mainError) {
        expect(mainError, 'Credenciais inválidas');
      }),
    );

    sut.validateEmail(email);
    sut.validatePassword(password);
    await sut.auth();
  });

  test('Should emit correct events on UnexpectedError', () async {

    mockAuthenticationError(DomainError.unexpected);

    sut.mainErrorStream.listen(
      expectAsync1((mainError) { 
        expect(mainError, 'Ocorreu um erro. Tente novamente em breve');
      }),
    );

    sut.validateEmail(email);
    sut.validatePassword(password);
    await sut.auth();
    
  });

  test('Should not emit after dispose', () {

    expectLater(sut.emailErrorStream, neverEmits(null));

    sut.dispose();
    sut.validateEmail(email);

  });



}