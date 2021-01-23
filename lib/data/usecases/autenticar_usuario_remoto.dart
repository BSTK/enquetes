import 'package:enquetes/data/http/http.dart';
import 'package:enquetes/domain/usecases/usecases.dart';
import 'package:flutter/foundation.dart';

class AutenticarUsuarioRemoto {
  final String url;
  final HttpClient httpClient;

  const AutenticarUsuarioRemoto({
    @required this.url,
    @required this.httpClient,
  });

  Future<void> autenticar(final AutenticacaoParams params) async {
    this.httpClient.request(
        url: this.url,
        method: 'POST',
        body: AutenticarUsuarioRemotoParams
                .from(params)
                .toJson()
    );
  }
}

class AutenticarUsuarioRemotoParams {
  final String email;
  final String senha;

  const AutenticarUsuarioRemotoParams({
    @required this.email,
    @required this.senha
  });

  factory AutenticarUsuarioRemotoParams.from(AutenticacaoParams params) =>
      AutenticarUsuarioRemotoParams(email: params.email, senha: params.senha);

  Map toJson() => { 'email': email, 'password': senha };

}
