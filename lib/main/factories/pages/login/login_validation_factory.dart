import 'package:enquetes/presentation/presentation.dart';
import 'package:enquetes/validation/validators/validators.dart';

Validation loginValidation() {
  return ValidationComposite(
      validators: [
        EmailValidator(field: 'email'),
        RequiredFieldValidation(field: 'email'),
        RequiredFieldValidation(field: 'senha')
      ]
  );
}
