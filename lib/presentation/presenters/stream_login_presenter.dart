import 'dart:async';

import 'package:enquetes/domain/usecases/usecases.dart';
import 'package:enquetes/presentation/presentation.dart';
import 'package:flutter/foundation.dart';

class StreamLoginPresenter {
  final Validation validation;
  final Autenticacao autenticacao;

  final _controller = StreamController<LoginState>.broadcast();

  var _state = LoginState();

  Stream<String> get emailErrorStream =>
      _controller.stream.map((state) => state.emailError).distinct();

  Stream<String> get senhaErrorStream =>
      _controller.stream.map((state) => state.senhaError).distinct();

  Stream<bool> get formularioValidoStream =>
      _controller.stream.map((state) => state.isformularioValido).distinct();

  StreamLoginPresenter({
    @required final this.validation,
    @required final this.autenticacao,
  });

  void validarEmail(final String email) {
    _state.email = email;
    _state.emailError = validation.validate(campo: 'email', valor: email);
    _controller.add(_state);
  }

  void validarSenha(final String senha) {
    _state.senha = senha;
    _state.senhaError = validation.validate(campo: 'senha', valor: senha);
    _controller.add(_state);
  }

  Future<void> autenticar() async {
    await this.autenticacao.autenticar(
        params: AutenticacaoParams(email: _state.email, senha: _state.senha));
  }

}
