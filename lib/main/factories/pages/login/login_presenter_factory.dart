import 'package:enquetes/main/factories/usecases/usecases.dart';
import 'package:enquetes/presentation/presentation.dart';
import 'package:enquetes/ui/pages/pages.dart';

import 'login.dart';

LoginPresenter loginPresenter() {
  return StreamLoginPresenter(
    validation: loginValidation(),
    autenticacao: autenticacao()
  );
}
