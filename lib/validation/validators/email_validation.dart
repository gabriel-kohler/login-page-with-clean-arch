import 'package:equatable/equatable.dart';

import '/validation/dependencies/dependencies.dart';

class EmailValidation extends Equatable implements FieldValidation {
  final String field;

  EmailValidation(this.field);

  @override
  String validate({String value}) {
    final regex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    final isValid = value?.isNotEmpty != true || regex.hasMatch(value);
    return isValid ? null : 'Campo inválido';
  }

  @override
  List get props => [field];
}