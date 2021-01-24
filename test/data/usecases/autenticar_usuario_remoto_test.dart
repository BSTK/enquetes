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

  void mockWhenSucesso(final Map mock) {
    when(httpClient.request(
        url: anyNamed('url'),
        method: anyNamed('method'),
        body: anyNamed('body')
    )).thenAnswer((_) async => mock);
  }

  void mockWhenErro(final HttpError error) {
    when(httpClient.request(
        url: anyNamed('url'),
        method: anyNamed('method'),
        body: anyNamed('body')
    )).thenThrow(error);
  }

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
    mockWhenSucesso({ 'acessToken': faker.person.name(), 'name': faker.guid.guid()});

    sut.autenticar(params);

    verify(httpClient.request(
      url: url,
      method: 'POST',
      body: { 'email': params.email, 'password': params.senha }
    ));
  });

  test('Test - Deve lançar erro quando HttpClient retornar código 400', () async {
    mockWhenErro(HttpError.badRequest);

    final future = sut.autenticar(params);
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Test - Deve lançar erro quando HttpClient retornar código 404', () async {
    mockWhenErro(HttpError.notFound);

    final future = sut.autenticar(params);
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Test - Deve lançar erro quando HttpClient retornar código 500', () async {
    mockWhenErro(HttpError.serverError);

    final future = sut.autenticar(params);
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Test - Deve lançar erro quando HttpClient retornar código 401', () async {
    mockWhenErro(HttpError.unauthorized);

    final future = sut.autenticar(params);
    expect(future, throwsA(DomainError.invalidCredentials));
  });

  test('Test - Deve lançar erro quando HttpClient retornar código 200 mas com dados inválidos', () async {
    mockWhenSucesso({'invalid_key': 'invalid_value'});

    final future = sut.autenticar(params);
    expect(future, throwsA(DomainError.unexpected));
  });

  test('Test - Deve retornar uma conta autenticada quando HttpClient retornar código 200', () async {
    final name = faker.person.name();
    final acessToken = faker.guid.guid();

    mockWhenSucesso({ 'acessToken': acessToken, 'name': name});

    final contaAutenticada = await sut.autenticar(params);
    expect(contaAutenticada.token, equals(acessToken));
  });

}
