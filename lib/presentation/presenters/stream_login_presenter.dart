import 'dart:async';
import 'package:meta/meta.dart';

import '/presentation/dependencies/dependencies.dart';


class LoginState {
  String emailError;
  bool get isValid => false;
}

class StreamLoginPresenter {

  Stream<String> get emailErrorStream => _controller.stream.map((state) => state.emailError).distinct();
  Stream<bool> get isFormValidStream => _controller.stream.map((state) => state.isValid).distinct();

  final Validation validation;
  final StreamController<LoginState> _controller = StreamController<LoginState>.broadcast();

  final _state = LoginState();

  StreamLoginPresenter({@required this.validation});

  void validateEmail(String email) {
    _state.emailError = validation.validate(field: 'email', value: email);
    _controller.add(_state);
  }

  
}

