import 'package:enquetes/presentation/protocols/validation.dart';
import 'package:enquetes/validation/protocols/protocols.dart';
import 'package:flutter/foundation.dart';

class ValidationComposite implements Validation {

  final List<FieldValidation> validators;

  ValidationComposite({this.validators});

  @override
  String validate({@required String campo, @required String valor}) {
    for (final validator in validators.where((v) => v.field == campo)) {
      final error = validator.validate(valor);
      if (error != null && error.isNotEmpty) {
        return error;
      }
    }

    return null;
  }

}
