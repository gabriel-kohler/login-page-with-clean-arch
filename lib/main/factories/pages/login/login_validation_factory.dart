import 'package:login_page_with_mobx/main/builders/validation_builder.dart';

import '/presentation/dependencies/dependencies.dart';
import '/validation/dependencies/dependencies.dart';
import '/validation/validators/validators.dart';

Validation makeLoginValidation() {
  return ValidationComposite(validations: makeLoginValidations());
}

List<FieldValidation> makeLoginValidations() {
  return [
    ... ValidationBuilder.field('email').required().email().build(),
    ... ValidationBuilder.field('password').required().build(),
  ];
}