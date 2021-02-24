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
    for (final validator in validators.where((v) => v.field == campo)) {
      final error = validator.validate(valor);
      if (error != null && error.isNotEmpty) {
        return error;
      }
    }

    return null;
  }

}

class FieldValidationSpy extends Mock implements FieldValidation {}

void main() {

  FieldValidation mockValidation({final String campo, final String valor}) {
    final validationNull = FieldValidationSpy();
    when(validationNull.validate(any)).thenReturn(valor);
    when(validationNull.field).thenReturn(campo);
    return validationNull;
  }

  test('Test - Deve retornar null se todas as validações retornarem nulo ou vazio', () {
    final sut = ValidationComposite(validators: [
      mockValidation(campo: 'campo_a', valor: null),
      mockValidation(campo: 'campo_b', valor: ''),
      mockValidation(campo: 'campo_c', valor: '  ')
    ]);

    final error = sut.validate(campo: 'campo', valor: 'valor');

    expect(error, null);
  });

  test('Test - Deve retornar erro quando a primeira validação der erro', () {
    final sut = ValidationComposite(validators: [
      mockValidation(campo: 'campo_a', valor: 'campo_invalido'),
      mockValidation(campo: 'campo_b', valor: ''),
      mockValidation(campo: 'campo_c', valor: null)
    ]);

    final error = sut.validate(campo: 'campo', valor: 'valor');

    expect(error, 'campo_invalido');
  });

  test('Test - Deve retornar erro quando a segunda validação der erro', () {
    final sut = ValidationComposite(validators: [
      mockValidation(campo: 'campo_a', valor: ''),
      mockValidation(campo: 'campo_b', valor: 'campo_2_invalido'),
      mockValidation(campo: 'campo_c', valor: null)
    ]);

    final error = sut.validate(campo: 'campo', valor: 'valor');

    expect(error, 'campo_2_invalido');
  });
}
