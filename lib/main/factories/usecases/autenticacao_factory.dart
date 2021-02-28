import 'package:enquetes/data/usecases/usecases.dart';
import 'package:enquetes/domain/usecases/usecases.dart';
import 'package:enquetes/main/factories/http/http.dart';

Autenticacao autenticacao() {
  return AutenticarUsuarioRemoto(
    httpClient: httpAdapter(),
    url: api('/login')
  );
}
