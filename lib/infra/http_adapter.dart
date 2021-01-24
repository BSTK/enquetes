import 'dart:convert';
import 'dart:io';

import 'package:enquetes/data/http/http.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

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
    return _handleresponse(response);
  }

  Map _handleresponse(final Response response) {
    final responseJsonDecode = response.body.isNotEmpty
        ? jsonDecode(response.body)
        : null;

    if (HttpStatus.badRequest == response.statusCode) {
      throw HttpError.badRequest;
    }

    if (HttpStatus.ok == response.statusCode) {
      return HttpStatus.ok == response.statusCode
          ? responseJsonDecode
          : null;
    }
  }
}
