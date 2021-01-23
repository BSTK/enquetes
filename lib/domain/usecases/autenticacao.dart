import 'package:enquetes/domain/entidades/conta_autenticacao.dart';
import 'package:meta/meta.dart';

abstract class Autenticacao {

  Future<ContaAutenticacao> autenticar({
    @required final String email,
    @required final String senha
  });

}
