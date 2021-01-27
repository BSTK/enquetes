import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:enquetes/presentation/presentation.dart';

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

    sut.emailErrorStream.listen(
        expectAsync1((error) => expect(error, 'email_error')));

    sut.senhaErrorStream.listen(
        expectAsync1((error) => expect(error, 'senha_error')));

    sut.formularioValidoStream.listen(
        expectAsync1((isValido) => expect(isValido, false)));

    sut.validarEmail(email);
    sut.validarEmail(email);
    sut.validarEmail(email);

    sut.validarSenha(senha);
    sut.validarSenha(senha);
    sut.validarSenha(senha);
  });

  test('Test - Deve emitir null na validação ao validar email correto', () {
    sut.emailErrorStream.listen(
        expectAsync1((error) => expect(error, null)));

    sut.formularioValidoStream.listen(
        expectAsync1((isValido) => expect(isValido, false)));

    sut.validarEmail(email);
    sut.validarEmail(email);
    sut.validarEmail(email);
  });

  test('Test - Deve emitir null na validação ao validar senha correta', () {
    sut.senhaErrorStream.listen(
        expectAsync1((error) => expect(error, null)));

    sut.formularioValidoStream.listen(
        expectAsync1((isValido) => expect(isValido, false)));

    sut.validarSenha(senha);
    sut.validarSenha(senha);
    sut.validarSenha(senha);
  });

  test('Test - Deve emitir error na validação ao validar email incorreto e senha correta', () {
    when(validation.validate(campo: 'email', valor: email)).thenReturn('email_error');

    sut.emailErrorStream.listen(
        expectAsync1((error) => expect(error, 'email_error')));

    sut.senhaErrorStream.listen(
        expectAsync1((error) => expect(error, null)));

    sut.formularioValidoStream.listen(
        expectAsync1((isValido) => expect(isValido, false)));

    sut.validarEmail(email);
    sut.validarSenha(senha);
  });

  test('Test - Deve emitir error na validação ao validar senha incorreta e email correto', () {
    when(validation.validate(campo: 'senha', valor: senha)).thenReturn('senha_error');

    sut.senhaErrorStream.listen(
        expectAsync1((error) => expect(error, 'senha_error')));

    sut.emailErrorStream.listen(
        expectAsync1((error) => expect(error, null)));

    sut.formularioValidoStream.listen(
        expectAsync1((isValido) => expect(isValido, false)));

    sut.validarEmail(email);
    sut.validarEmail(email);

    sut.validarSenha(senha);
    sut.validarSenha(senha);
  });
}
