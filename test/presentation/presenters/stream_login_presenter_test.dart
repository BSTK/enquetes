import 'package:enquetes/presentation/presentation.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class ValidationSpy extends Mock implements Validation { }

void main() {

  String email;
  String senha;
  ValidationSpy validation;
  StreamLoginPresenter sut;

  setUp(() {
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();
    senha = faker.internet.password();
  });

  test('Test - Deve fazer validacao com email/senha corretos', () async {
    sut.validarEmail(email);
    verify(validation.validate(campo: 'email', valor: email)).called(1);

    sut.validarSenha(senha);
    verify(validation.validate(campo: 'senha', valor: senha)).called(1);
  });

  test('Test - Deve emitir erro de validação ao validar email/senha incorreto', () {
    when(validation.validate(campo: 'email', valor: email)).thenReturn('email_error');
    when(validation.validate(campo: 'senha', valor: senha)).thenReturn('senha_error');

    expectLater(sut.emailErrorStream, emits('email_error'));
    expectLater(sut.senhaErrorStream, emits('senha_error'));

    sut.validarEmail(email);
    sut.validarSenha(senha);
  });
}
