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
  String senhaError;
}

class ValidationSpy extends Mock implements Validation { }

class StreamLoginPresenter {
  final Validation validation;
  final _controller = StreamController<LoginState>.broadcast();

  var _state = LoginState();

  Stream<String> get emailErrorStream =>
      _controller.stream.map((state) => state.emailError);

  Stream<String> get senhaErrorStream =>
      _controller.stream.map((state) => state.senhaError);

  StreamLoginPresenter({
    @required final this.validation
  });

  void validarEmail(final String email) {
    _state.emailError = validation.validate(campo: 'email', valor: email);
    _controller.add(_state);
  }

  void validarSenha(final String senha) {
    _state.senhaError = validation.validate(campo: 'senha', valor: senha);
    _controller.add(_state);
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
