import 'package:enquetes/validation/validators/validators.dart';
import 'package:flutter_test/flutter_test.dart';

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
