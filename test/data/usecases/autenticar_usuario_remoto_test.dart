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

  Future<void> autenticar() async {
    this.httpClient.request(url: this.url);
  }
}

abstract class HttpClient {
  Future<void> request({
    @required final String url
  });
}

class HttpClientSpy extends Mock implements HttpClient {}

void main() {

  test('Test - Deve chamar o HttpClient com URL correta', () async {
    final httpClient = HttpClientSpy();
    final url = faker.internet.httpUrl();
    final sut = AutenticarUsuarioRemoto(httpClient: httpClient, url: url);

    sut.autenticar();

    verify(httpClient.request(url: url));
  });

}
