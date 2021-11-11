import 'dart:async';
import 'package:meta/meta.dart';

import '/presentation/dependencies/dependencies.dart';
import '/domain/usecases/usecases.dart';


class LoginState {
  String email;
  String password;
  String emailError;
  String passwordError;
  bool isLoading;

  bool get isValid => email != null && password != null && emailError == null && passwordError == null ? true : false;
}

class StreamLoginPresenter {

  Stream<String> get emailErrorStream => _controller.stream.map((state) => state.emailError).distinct();
  Stream<String> get passwordErrorStream => _controller.stream.map((state) => state.passwordError).distinct();
  Stream<bool> get isFormValidStream => _controller.stream.map((state) => state.isValid).distinct();
  Stream<bool> get isLoadingStream => _controller.stream.map((state) => state.isLoading).distinct();
  

  final Validation validation;
  final Authentication authentication;
  final StreamController<LoginState> _controller = StreamController<LoginState>.broadcast();

  final _state = LoginState();

  StreamLoginPresenter({@required this.validation, @required this.authentication});

  _updateStream() => _controller.add(_state);

  void validateEmail(String email) {
    _state.email = email;
    _state.emailError = validation.validate(field: 'email', value: email);
    _updateStream();
  }

  void validatePassword(String password) {
    _state.password = password;
    _state.passwordError = validation.validate(field: 'password', value: password);
    _updateStream();
  }

  Future<void> auth() async {

    final params = AuthenticationParams(email: _state.email, password: _state.password);
    _state.isLoading = true;
    _updateStream();
    await authentication.auth(params);
    _state.isLoading = false;
    _updateStream();
  }

}

