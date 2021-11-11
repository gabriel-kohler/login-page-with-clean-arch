import 'dart:async';
import 'package:meta/meta.dart';

import '/presentation/dependencies/dependencies.dart';


class LoginState {
  String email;
  String password;
  String emailError;
  String passwordError;

  bool get isValid => email != null && password != null && emailError == null && passwordError == null ? true : false;
}

class StreamLoginPresenter {

  Stream<String> get emailErrorStream => _controller.stream.map((state) => state.emailError).distinct();
  Stream<String> get passwordErrorStream => _controller.stream.map((state) => state.passwordError).distinct();
  Stream<bool> get isFormValidStream => _controller.stream.map((state) => state.isValid).distinct();
  

  final Validation validation;
  final StreamController<LoginState> _controller = StreamController<LoginState>.broadcast();

  final _state = LoginState();

  StreamLoginPresenter({@required this.validation});

  void validateEmail(String email) {
    _state.email = email;
    _state.emailError = validation.validate(field: 'email', value: email);
    _controller.add(_state);
  }

  void validatePassword(String password) {
    _state.password = password;
    _state.passwordError = validation.validate(field: 'password', value: password);
    _controller.add(_state);
  }

  
}

