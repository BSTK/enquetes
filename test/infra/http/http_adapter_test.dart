import 'dart:io';

import 'package:enquetes/infra/infra.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

class ClientSpy extends Mock implements Client { }

void main () {
  String url;
  HttpAdapter sut;
  ClientSpy client;

  setUp(() {
    client = ClientSpy();
    url = faker.internet.httpUrl();
    sut = HttpAdapter(client: client);
  });

  group('HttpMethod - POST', () {

    void mockWhen({
      final int statusCode = 200,
      final String responseBody = '{"key":"value"}'}) {

      when(client.post(
          any,
          body: anyNamed('body'),
          headers: anyNamed('headers')
      )).thenAnswer((_) async => Response(responseBody, statusCode));
    }

    setUp(() => mockWhen());

    test('Test - Deve fazer uma chamada POST com os dados corretos', () {
      sut.request(url: url, method: 'POST', body: {'key': 'value'});

      verify(client.post(
        url,
        headers: {
            HttpHeaders.contentTypeHeader : 'application/json',
            HttpHeaders.acceptHeader: 'application/json'
        },
        body: '{"key":"value"}'
      ));
    });

    test('Test - Deve fazer uma chamada POST sem dados no body', () {
      sut.request(url: url, method: 'POST');

      verify(client.post(
          any,
          headers: anyNamed('headers')
      ));
    });

    test('Test - Deve fazer uma chamada POST com dados de retorno', () async {
      final response = await sut.request(url: url, method: 'POST');
      expect(response, {'key': 'value'});
    });

    test('Test - Deve fazer uma chamada POST sem dados de retorno e HttpSatus 200', () async {
      mockWhen(responseBody: '');

      final response = await sut.request(url: url, method: 'POST');
      expect(response, null);
    });

    test('Test - Deve fazer uma chamada POST sem dados de retorno e HttpSatus 204', () async {
      mockWhen(statusCode: 204, responseBody: '');

      final response = await sut.request(url: url, method: 'POST');
      expect(response, null);
    });

    test('Test - Deve fazer uma chamada POST com dados de retorno e HttpSatus 204', () async {
      mockWhen(statusCode: 204);

      final response = await sut.request(url: url, method: 'POST');
      expect(response, null);
    });

  });

  group('HttpMethod - GET', () {

  });
}
