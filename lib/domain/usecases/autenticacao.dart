import 'package:enquetes/domain/entidades/conta_autenticacao.dart';
import 'package:meta/meta.dart';

abstract class Autenticacao {

  Future<ContaAutenticacao> autenticar({
    @required final AutenticacaoParams params
  });

}

class AutenticacaoParams {
  final String email;
  final String senha;

  const AutenticacaoParams({
    @required this.email,
    @required this.senha
  });

  Map toJson() => { 'email': email, 'password': senha };

}
