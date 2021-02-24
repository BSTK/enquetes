import 'package:enquetes/presentation/protocols/validation.dart';
import 'package:enquetes/validation/protocols/protocols.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class ValidationComposite implements Validation {

  final List<FieldValidation> validators;

  ValidationComposite({this.validators});

  @override
  String validate({@required String campo, @required String valor}) {
    return null;
  }

}

class FieldValidationSpy extends Mock implements FieldValidation {}

void main() {

  FieldValidation mockValidation(final String valor) {
    final validationNull = FieldValidationSpy();
    when(validationNull.field).thenReturn(valor);
    return validationNull;
  }

  test('Test - Deve retornar null se todas as validações retornarem nulo ou vazio', () {
    final sut = ValidationComposite(validators: [
      mockValidation(null),
      mockValidation(''),
      mockValidation('  ')
    ]);

    final error = sut.validate(campo: 'campo', valor: 'valor');

    expect(error, null);
  });
}
