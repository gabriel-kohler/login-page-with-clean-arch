import '/presentation/dependencies/dependencies.dart';
import '/validation/dependencies/dependencies.dart';
import '/validation/validators/validators.dart';

Validation makeLoginValidation() {
  return ValidationComposite(validations: makeLoginValidations());
}

List<FieldValidation> makeLoginValidations() {
  return [
    EmailValidation('email'),
    RequiredFieldValidation('password'),
    RequiredFieldValidation('email'),
  ];
}