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
    this.client.post(url);
  }
}

void main () {
  group('HttpMethod - POST', () {

    test('Test - Deve fazer uma chamada POST com os dados corretos', () {
      final client = ClientSpy();
      final url = faker.internet.httpUrl();
      final sut = HttpAdapter(client: client);

      sut.request(url: url, method: 'POST');

      verify(client.post(url));
    });

  });

  group('HttpMethod - GET', () { });
}
