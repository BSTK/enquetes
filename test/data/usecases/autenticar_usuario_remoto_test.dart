import 'package:enquetes/data/http/http.dart';
import 'package:enquetes/data/usecases/usecases.dart';
import 'package:enquetes/domain/helper/helper.dart';
import 'package:enquetes/domain/usecases/autenticacao.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class HttpClientSpy extends Mock implements HttpClient { }

void main() {
  String url;
  HttpClientSpy httpClient;
  AutenticacaoParams params;
  AutenticarUsuarioRemoto sut;

  setUp(() {
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();

    sut = AutenticarUsuarioRemoto(httpClient: httpClient, url: url);
    params = AutenticacaoParams(
        email: faker.internet.email(),
        senha: faker.internet.password(length: 10)
    );
  });

  test('Test - Deve chamar o HttpClient com parâmetros corretos', () async {
    when(httpClient.request(
        url: anyNamed('url'),
        method: anyNamed('method'),
        body: anyNamed('body')
    )).thenAnswer((_) async => {
      'acessToken': faker.person.name(),
      'name': faker.guid.guid()
    });

    sut.autenticar(params);

    verify(httpClient.request(
      url: url,
      method: 'POST',
      body: { 'email': params.email, 'password': params.senha }
    ));
  });

  test('Test - Deve lançar erro quando HttpClient retornar código 400', () async {
    when(httpClient.request(
        url: anyNamed('url'),
        method: anyNamed('method'),
        body: anyNamed('body')
    )).thenThrow(HttpError.badRequest);

    final future = sut.autenticar(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Test - Deve lançar erro quando HttpClient retornar código 404', () async {
    when(httpClient.request(
        url: anyNamed('url'),
        method: anyNamed('method'),
        body: anyNamed('body')
    )).thenThrow(HttpError.notFound);

    final future = sut.autenticar(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Test - Deve lançar erro quando HttpClient retornar código 500', () async {
    when(httpClient.request(
        url: anyNamed('url'),
        method: anyNamed('method'),
        body: anyNamed('body')
    )).thenThrow(HttpError.serverError);

    final future = sut.autenticar(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Test - Deve lançar erro quando HttpClient retornar código 401', () async {
    when(httpClient.request(
        url: anyNamed('url'),
        method: anyNamed('method'),
        body: anyNamed('body')
    )).thenThrow(HttpError.unauthorized);

    final future = sut.autenticar(params);

    expect(future, throwsA(DomainError.invalidCredentials));
  });

  test('Test - Deve lançar erro quando HttpClient retornar código 200 mas com dados inválidos', () async {
    when(httpClient.request(
        url: anyNamed('url'),
        method: anyNamed('method'),
        body: anyNamed('body')
    )).thenAnswer((_) async => {
      'invalid_key': 'invalid_value'
    });

    final future = sut.autenticar(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Test - Deve retornar uma conta autenticada quando HttpClient retornar código 200', () async {
    final name = faker.person.name();
    final acessToken = faker.guid.guid();

    when(httpClient.request(
        url: anyNamed('url'),
        method: anyNamed('method'),
        body: anyNamed('body')
    )).thenAnswer((_) async => {
      'acessToken': acessToken,
      'name': name
    });

    final contaAutenticada = await sut.autenticar(params);

    expect(contaAutenticada.token, equals(acessToken));
  });

}
