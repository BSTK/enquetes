import 'package:enquetes/validation/validators/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main () {

  test('Test - Deve retornar null quando o email estiver (Vazio | Só Espaço | Nulo)', () {
    final sut = EmailValidator(field: 'campo_email');
    final errorVazio = sut.validate('');
    final errorEspaco = sut.validate('  ');
    final errorNulo = sut.validate(null);

    expect(errorVazio, null);
    expect(errorEspaco, null);
    expect(errorNulo, null);
  });

  test('Test - Deve retornar null quando for passado um email valido', () {
    final sut = EmailValidator(field: 'campo_email');
    final error = sut.validate('bsilva.se@gmail.com');
    expect(error, null);
  });

  test('Test - Deve retornar erro quando for passado um email inválido', () {
    final sut = EmailValidator(field: 'campo_email');
    final errorSemArroba = sut.validate('meuemail.contatogmail');
    final errorSemDominio = sut.validate('meuemail.contato@');
    expect(errorSemArroba, 'Campo Obrigatório!');
    expect(errorSemDominio, 'Campo Obrigatório!');
  });

}
