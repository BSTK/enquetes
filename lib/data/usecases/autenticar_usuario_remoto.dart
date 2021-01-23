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
        body: params.toJson()
    );
  }
}
