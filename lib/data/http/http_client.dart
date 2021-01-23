import 'package:flutter/foundation.dart';

abstract class HttpClient {
  Future<void> request({
    @required final String url,
    @required final String method,
    Map body,
  });
}
