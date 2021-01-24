import 'package:meta/meta.dart';

class ContaAutenticacada {
  final String token;

  const ContaAutenticacada({
    @required this.token
  });

  factory ContaAutenticacada.fromJson(final Map json) =>
      ContaAutenticacada(token: json['acessToken']);

}
