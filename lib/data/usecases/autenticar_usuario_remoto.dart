import 'package:enquetes/data/http/http.dart';
import 'package:enquetes/domain/helper/helper.dart';
import 'package:enquetes/domain/usecases/usecases.dart';
import 'package:flutter/foundation.dart';

const String METODO_POST = 'POST';

class AutenticarUsuarioRemoto {
  final String url;
  final HttpClient httpClient;

  const AutenticarUsuarioRemoto({
    @required this.url,
    @required this.httpClient,
  });

  Future<void> autenticar(final AutenticacaoParams params) async {
    try {
      final body = AutenticarUsuarioRemotoParams.from(params).toJson();
      this.httpClient.request(url: this.url, method: METODO_POST, body: body);
    } on HttpError catch(error) {
      throw error == HttpError.unauthorized
        ? DomainError.invalidCredentials
        : DomainError.unexpected;
    }
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
