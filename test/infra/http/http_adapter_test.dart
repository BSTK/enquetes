import 'dart:convert';
import 'dart:io';

import 'package:enquetes/data/http/http.dart';
import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

class ClientSpy extends Mock implements Client { }

class HttpAdapter implements HttpClient {
  final Client client;

  HttpAdapter({
    @required this.client
  });

  @override
  Future<Map> request({
    @required final String url,
    @required final String method,
    Map body
  }) async {
    final headers = {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader : 'application/json'
    };

    final bodyJson = body != null ? jsonEncode(body) : null;
    final response = await this.client.post(url, headers: headers, body: bodyJson);

    return response.body.isNotEmpty
        ? jsonDecode(response.body)
        : null;
  }
}

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

    test('Test - Deve fazer uma chamada POST com os dados corretos', () {
      when(client.post(
          any,
          body: anyNamed('body'),
          headers: anyNamed('headers')
      )).thenAnswer((_) async => Response('{"key":"value"}', 200));

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
      when(client.post(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => Response('{"key":"value"}', 200));

      sut.request(url: url, method: 'POST');

      verify(client.post(
          any,
          headers: anyNamed('headers')
      ));
    });

    test('Test - Deve fazer uma chamada POST com dados de retorno', () async {
      when(client.post(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => Response('{"key":"value"}', 200));

      final response = await sut.request(url: url, method: 'POST');

      expect(response, {'key': 'value'});
    });

    test('Test - Deve fazer uma chamada POST sem dados de retorno e HttpSatus 200', () async {
      when(client.post(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => Response('', 200));

      final response = await sut.request(url: url, method: 'POST');

      expect(response, null);
    });

  });

  group('HttpMethod - GET', () { });
}
