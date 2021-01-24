import 'package:enquetes/domain/entidades/conta_autenticacada.dart';
import 'package:meta/meta.dart';

abstract class Autenticacao {

  Future<ContaAutenticacada> autenticar({
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
}
