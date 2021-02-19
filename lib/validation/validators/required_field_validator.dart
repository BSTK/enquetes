import 'package:enquetes/validation/protocols/protocols.dart';

class RequiredFieldValidation implements FieldValidation {

  final String field;

  const RequiredFieldValidation({this.field});

  @override
  String validate(final String valor) {
    return (valor == null || valor.trim().isEmpty)
      ? 'Campo Obrigatório!'
      : null;
  }

}
