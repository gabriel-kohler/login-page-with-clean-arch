import 'dart:async';

import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '/domain/helpers/helpers.dart';
import '/domain/usecases/usecases.dart';

import '/presentation/dependencies/dependencies.dart';

import '/ui/pages/login/login.dart';


class GetxLoginPresenter extends GetxController implements LoginPresenter {

  final Validation validation;
  final Authentication authentication;
  final SaveCurrentAccount saveCurrentAccount;

  String _email;
  String _password;
  
  var _emailError = RxString(null);
  var _passwordError = RxString(null);
  var _mainError = RxString(null);
  var _isFormValid = false.obs;
  var _isLoading = false.obs;

  GetxLoginPresenter({@required this.validation, @required this.authentication, @required this.saveCurrentAccount});

  Stream<String> get emailErrorStream => _emailError.stream;
  Stream<String> get passwordErrorStream => _passwordError.stream;
  Stream<String> get mainErrorStream => _mainError.stream;
  Stream<bool> get isFormValidStream => _isFormValid.stream;
  Stream<bool> get isLoadingStream => _isLoading.stream;

  void validateEmail(String email) {
    _email = email;
    _emailError.value = validation.validate(field: 'email', value: email);
    _validateForm();
  }

  void validatePassword(String password) {
    _password = password;
    _passwordError.value = validation.validate(field: 'password', value: password);
    _validateForm();
  }

  void _validateForm() {
    _isFormValid.value = _email != null 
    && _password != null 
    && _emailError.value == null 
    && _passwordError.value == null;
  }

  Future<void> auth() async {

    final params = AuthenticationParams(
      email: _email,
      password: _password,
    );

    _isLoading.value = true;

    try {
      final account = await authentication.auth(params); 
      await saveCurrentAccount.save(account: account);
    } on DomainError catch (error) {
      _mainError.value = error.errorMessage;
    }

    _isLoading.value = false;
  }

  void dispose() {}
}