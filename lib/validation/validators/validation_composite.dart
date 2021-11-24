import '/presentation/dependencies/dependencies.dart';

import '/validation/dependencies/dependencies.dart';

class ValidationComposite implements Validation {

  final List<FieldValidation> validations;

  ValidationComposite({this.validations});

  @override
  String validate({String field, String value}) {
    String error;
    for (final validation in validations.where((v) => v.field == field)) {
      error = validation.validate(value: value);
      if (error?.isNotEmpty == true) {
        return error;
      }
    }
    return error;
  }

}