import 'package:flutter_test/flutter_test.dart';

abstract class FieldValidation {
  String get field;
  String validate(final String valor);
}

class RequiredFieldValidation implements FieldValidation {

  final String field;

  const RequiredFieldValidation({this.field});

  @override
  String validate(final String valor) {
    return (valor == null || valor.trim().isEmpty)
      ? 'Campo Obrigatório!'
      : null;
  }

}

void main () {

  test('Test - Deve retornar null quando o campo não estiver vazio', () {
    final sut = RequiredFieldValidation(field: 'qualquer_campo');
    final error = sut.validate('valor');

    expect(error, null);
  });

  test('Test - Deve retornar erro Campo Obrigatorio quando o campo estiver inválido (Vazio | Só Espaço | Nulo)', () {
    final sut = RequiredFieldValidation(field: 'qualquer_campo');
    final errorVazio = sut.validate('');
    final errorEspaco = sut.validate('  ');
    final errorNulo = sut.validate(null);

    expect(errorVazio, 'Campo Obrigatório!');
    expect(errorEspaco, 'Campo Obrigatório!');
    expect(errorNulo, 'Campo Obrigatório!');
  });
}
