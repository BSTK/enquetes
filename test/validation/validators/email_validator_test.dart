import 'package:enquetes/validation/protocols/protocols.dart';
import 'package:flutter_test/flutter_test.dart';

class EmailValidator implements FieldValidation {

  final String field;

  const EmailValidator({this.field});

  @override
  String validate(final String valor) {
    return null;
  }

}

void main () {

  test('Test - Deve retornar null quando o campo estiver (Vazio | Só Espaço | Nulo)', () {
    final sut = EmailValidator(field: 'campo_email');
    final errorVazio = sut.validate('');
    final errorEspaco = sut.validate('  ');
    final errorNulo = sut.validate(null);

    expect(errorVazio, null);
    expect(errorEspaco, null);
    expect(errorNulo, null);
  });

}
