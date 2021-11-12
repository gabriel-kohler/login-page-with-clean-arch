import 'dart:async';

import 'package:login_page_with_mobx/ui/pages/login/login.dart';
import 'package:meta/meta.dart';

import '/domain/helpers/helpers.dart';
import '/domain/usecases/authentication.dart';

class LoginState {
  String email;
  String password;
  String emailError;
  String passwordError;
  String mainError;
  bool isLoading;

  bool get isValid => email != null && password != null && emailError == null && passwordError == null ? true : false;
}

class StreamLoginPresenter implements LoginPresenter {

  final validation;
  final authentication;
  
  StreamController<LoginState> _controller = StreamController<LoginState>.broadcast();
  LoginState _state = LoginState();

  StreamLoginPresenter({@required this.validation, @required this.authentication});

  Stream<String> get emailErrorStream => _controller?.stream?.map((state) => state?.emailError)?.distinct();
  Stream<String> get passwordErrorStream => _controller?.stream?.map((state) => state?.passwordError)?.distinct();
  Stream<String> get mainErrorStream => _controller?.stream?.map((state) => state?.mainError)?.distinct();
  Stream<bool> get isFormValidStream => _controller?.stream?.map((state) => state?.isValid)?.distinct();
  Stream<bool> get isLoadingStream => _controller?.stream?.map((state) => state?.isLoading)?.distinct();

  void updateStream() => _controller?.add(_state);

  void validateEmail(String email) {
    _state.email = email;
    _state.emailError = validation.validate(field: 'email', value: email);
    updateStream();
  }

  void validatePassword(String password) {
    _state.password = password;
    _state.passwordError = validation.validate(field: 'password', value: password);
    updateStream();
  }

  Future<void> auth() async {

    final params = AuthenticationParams(
      email: _state.email,
      password: _state.password,
    );

    _state.isLoading = true;
    updateStream();

    try {
      await authentication.auth(params); 
    } on DomainError catch (error) {
      _state.mainError = error.errorMessage;
    }

    _state.isLoading = false;
    updateStream();
  }

  void dispose() {
    _controller.close();
    _controller = null;
  }
}