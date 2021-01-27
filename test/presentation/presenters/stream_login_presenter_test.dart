import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

abstract class Validation {
  String validate({
    @required final String campo,
    @required final String valor
  });
}

class ValidationSpy extends Mock implements Validation { }

class StreamLoginPresenter {
  final Validation validation;

  StreamLoginPresenter({
    @required final this.validation
  });

  void validarEmail(final String email) {
    validation.validate(campo: 'email', valor: email);
  }

  void validarSenha(final String senha) {
    validation.validate(campo: 'senha', valor: senha);
  }
}

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

  test('Test - Deve fazer validacao com email correto', () async {
    sut.validarEmail(email);

    verify(validation.validate(campo: 'email', valor: email)).called(1);
  });

  test('Test - Deve fazer validacao com senha correta', () async {
    sut.validarSenha(senha);

    verify(validation.validate(campo: 'senha', valor: senha)).called(1);
  });
}
