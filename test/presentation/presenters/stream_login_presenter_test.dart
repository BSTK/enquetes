import 'package:enquetes/domain/entidades/entidades.dart';
import 'package:enquetes/domain/helper/domain_error.dart';
import 'package:enquetes/domain/usecases/usecases.dart';
import 'package:enquetes/presentation/presentation.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class ValidationSpy extends Mock implements Validation { }

class AutenticacaoSpy extends Mock implements Autenticacao { }

void main() {

  String email;
  String senha;
  ValidationSpy validation;
  AutenticacaoSpy autenticacao;
  StreamLoginPresenter sut;

  setUp(() {
    validation = ValidationSpy();
    autenticacao = AutenticacaoSpy();
    sut = StreamLoginPresenter(
        validation: validation,
        autenticacao: autenticacao
    );
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

    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, 'email_error')));
    sut.senhaErrorStream.listen(expectAsync1((error) => expect(error, 'senha_error')));
    sut.formularioValidoStream.listen(expectAsync1((isValido) => expect(isValido, false)));

    sut.validarEmail(email);
    sut.validarEmail(email);
    sut.validarEmail(email);

    sut.validarSenha(senha);
    sut.validarSenha(senha);
    sut.validarSenha(senha);
  });

  test('Test - Deve emitir null na validação ao validar email correto', () {
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.formularioValidoStream.listen(expectAsync1((isValido) => expect(isValido, false)));

    sut.validarEmail(email);
    sut.validarEmail(email);
    sut.validarEmail(email);
  });

  test('Test - Deve emitir null na validação ao validar senha correta', () {
    sut.senhaErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.formularioValidoStream.listen(expectAsync1((isValido) => expect(isValido, false)));

    sut.validarSenha(senha);
    sut.validarSenha(senha);
    sut.validarSenha(senha);
  });

  test('Test - Deve emitir error na validação ao validar email incorreto e senha correta', () {
    when(validation.validate(campo: 'email', valor: email)).thenReturn('email_error');

    sut.senhaErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, 'email_error')));
    sut.formularioValidoStream.listen(expectAsync1((isValido) => expect(isValido, false)));

    sut.validarEmail(email);
    sut.validarSenha(senha);
  });

  test('Test - Deve emitir error na validação ao validar senha incorreta e email correto', () {
    when(validation.validate(campo: 'senha', valor: senha)).thenReturn('senha_error');

    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.senhaErrorStream.listen(expectAsync1((error) => expect(error, 'senha_error')));
    sut.formularioValidoStream.listen(expectAsync1((isValido) => expect(isValido, false)));

    sut.validarEmail(email);
    sut.validarEmail(email);

    sut.validarSenha(senha);
    sut.validarSenha(senha);
  });

  test('Test - Deve emitir null na validação ao validar email e senha válidos', () async {
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.senhaErrorStream.listen(expectAsync1((error) => expect(error, null)));
    
    expectLater(sut.formularioValidoStream, emitsInOrder([false, true]));

    sut.validarEmail(email);
    await Future.delayed(Duration.zero);
    sut.validarSenha(senha);
  });

  test('Test - Deve chamar o autenticar() com email e senha corretos', () async {
    sut.validarEmail(email);
    sut.validarSenha(senha);
    await sut.autenticar();

    verify(autenticacao.autenticar(params: AutenticacaoParams(email: email, senha: senha)))
      .called(1);
  });

  test('Test - Deve emitir events ao autenticar com dados corretos', () async {
    when(autenticacao.autenticar(params: anyNamed('params')))
        .thenAnswer((_) async => ContaAutenticacada(token: faker.guid.guid()));

    sut.validarEmail(email);
    sut.validarSenha(senha);

    expectLater(sut.loadingStream, emitsInOrder([true, false]));

    await sut.autenticar();
  });

  test('Test - Deve disparar um DomainError de Credencias Invalidas', () async {
    when(autenticacao.autenticar(params: anyNamed('params')))
      .thenThrow(DomainError.invalidCredentials);

    sut.validarEmail(email);
    sut.validarSenha(senha);

    expectLater(sut.loadingStream, emitsInOrder([false]));
    sut.mainErrorStream.listen(expectAsync1((error) => expect(error, DomainError.invalidCredentials.description)));

    await sut.autenticar();
  });

  test('Test - Deve disparar um DomainError de Erro Inesperado', () async {
    when(autenticacao.autenticar(params: anyNamed('params')))
        .thenThrow(DomainError.unexpected);

    sut.validarEmail(email);
    sut.validarSenha(senha);

    expectLater(sut.loadingStream, emitsInOrder([false]));
    sut.mainErrorStream.listen(expectAsync1((error) => expect(error, DomainError.unexpected.description)));

    await sut.autenticar();
  });

  test('Test - Deve para de disparar eventos de stream quando o controlador for fechado', () async {
    expectLater(sut.loadingStream, neverEmits(null));
    expectLater(sut.mainErrorStream, neverEmits(null));
    expectLater(sut.emailErrorStream, neverEmits(null));
    expectLater(sut.senhaErrorStream, neverEmits(null));
    expectLater(sut.formularioValidoStream, neverEmits(null));

    sut.dispose();
    sut.validarEmail(email);
  });

}
