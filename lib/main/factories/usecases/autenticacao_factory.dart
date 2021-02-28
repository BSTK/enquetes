import 'package:enquetes/data/usecases/usecases.dart';
import 'package:enquetes/domain/usecases/usecases.dart';
import 'package:enquetes/infra/infra.dart';
import 'package:http/http.dart';

Autenticacao autenticacao() {
  const url = 'http://fordevs.herokuapp.com/api/login';

  final httpClient = HttpAdapter(client: Client());

  return AutenticarUsuarioRemoto(
    httpClient: httpClient,
    url: url
  );
}
