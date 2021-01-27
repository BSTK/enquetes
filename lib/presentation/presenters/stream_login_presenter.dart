import 'dart:async';

import 'package:enquetes/presentation/presentation.dart';
import 'package:flutter/foundation.dart';

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
