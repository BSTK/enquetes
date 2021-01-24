import 'dart:convert';
import 'dart:io';

import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

class ClientSpy extends Mock implements Client { }

class HttpAdapter {
  final Client client;

  HttpAdapter({
    @required this.client
  });

  Future<void> request({
    @required final String url,
    @required final String method,
    Map body
  }) async {
    final headers = {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader : 'application/json'
    };

    final bodyJson = body != null ? jsonEncode(body) : null;
    this.client.post(url, headers: headers, body: bodyJson);
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

  });

  group('HttpMethod - GET', () { });
}
