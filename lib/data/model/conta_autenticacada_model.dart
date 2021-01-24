import 'package:enquetes/domain/entidades/entidades.dart';
import 'package:meta/meta.dart';

class ContaAutenticacadaModel {
  final String acessToken;

  const ContaAutenticacadaModel({
    @required this.acessToken
  });

  factory ContaAutenticacadaModel.fromJson(final Map json) =>
      ContaAutenticacadaModel(acessToken: json['acessToken']);

  ContaAutenticacada toEntity() => ContaAutenticacada(token: acessToken);

}
