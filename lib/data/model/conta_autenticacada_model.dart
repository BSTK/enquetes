import 'package:enquetes/data/http/http.dart';
import 'package:enquetes/domain/entidades/entidades.dart';
import 'package:meta/meta.dart';

class ContaAutenticacadaModel {
  final String acessToken;

  const ContaAutenticacadaModel({
    @required this.acessToken
  });

  factory ContaAutenticacadaModel.fromJson(final Map json) {
    if (!json.containsKey('acessToken')) {
      throw HttpError.invalidData;
    }

    return ContaAutenticacadaModel(acessToken: json['acessToken']);
  }

  ContaAutenticacada toEntity() => ContaAutenticacada(token: acessToken);

}
