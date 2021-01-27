import 'package:flutter/foundation.dart';

abstract class Validation {
  String validate({
    @required final String campo,
    @required final String valor
  });
}
