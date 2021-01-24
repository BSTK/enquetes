import 'package:flutter/foundation.dart';

abstract class HttpClient {
  Future<Map> request({
    @required final String url,
    @required final String method,
    Map body,
  });
}
