import 'dart:async';

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

class LoginState {
  String emailError;
}

class ValidationSpy extends Mock implements Validation { }

class StreamLoginPresenter {
  final Validation validation;
  final _controller = StreamController<LoginState>.broadcast();

  var _state = LoginState();

  Stream<String> get emailErrorStream =>
      _controller.stream.map((state) => state.emailError);

  StreamLoginPresenter({
    @required final this.validation
  });

  void validarEmail(final String email) {
    _state.emailError = validation.validate(campo: 'email', valor: email);
    _controller.add(_state);
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

  test('Test - Deve emitir erro de validação ao validar email incorreto', () {
    when(validation.validate(campo: anyNamed('campo'), valor: anyNamed('valor')))
        .thenReturn('email_error');

    expectLater(sut.emailErrorStream, emits('email_error'));

    sut.validarEmail(email);
  });
}
