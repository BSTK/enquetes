import 'package:enquetes/data/usecases/usecases.dart';
import 'package:enquetes/infra/infra.dart';
import 'package:enquetes/presentation/presentation.dart';
import 'package:enquetes/ui/pages/pages.dart';
import 'package:enquetes/validation/validators/validators.dart';
import 'package:http/http.dart';

LoginPresenter loginPresenter() {
  const url = 'http://fordevs.herokuapp.com/api/login';

  final httpClient = HttpAdapter(client: Client());

  final autenticacaoRemota = AutenticarUsuarioRemoto(
    httpClient: httpClient,
    url: url
  );

  final validationComposite = ValidationComposite(
      validators: [
        EmailValidator(field: 'email'),
        RequiredFieldValidation(field: 'email'),
        RequiredFieldValidation(field: 'senha')
      ]
  );

  return StreamLoginPresenter(
    validation: validationComposite,
    autenticacao: autenticacaoRemota
  );
}
