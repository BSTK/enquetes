import 'package:enquetes/domain/usecases/autenticacao.dart';
import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

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

abstract class HttpClient {
  Future<void> request({
    @required final String url,
    @required final String method,
    Map body,
  });
}

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  String url;
  HttpClientSpy httpClient;

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
  });

  test('Test - Deve chamar o HttpClient com parâmetros corretos', () async {
    final sut = AutenticarUsuarioRemoto(httpClient: httpClient, url: url);
    final params = AutenticacaoParams(
        email: faker.internet.email(),
        senha: faker.internet.password(length: 10)
    );

    sut.autenticar(params);

    verify(httpClient.request(
      url: url,
      method: 'POST',
      body: { 'email': params.email, 'password': params.senha }
    ));
  });

}
