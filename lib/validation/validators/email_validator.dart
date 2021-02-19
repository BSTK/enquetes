import 'package:enquetes/validation/protocols/protocols.dart';

class EmailValidator implements FieldValidation {

  final String field;

  const EmailValidator({this.field});

  @override
  String validate(final String valor) {
    final regex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    final emailNuloVazio = (valor == null || valor.trim().isEmpty);
    final valido = emailNuloVazio || regex.hasMatch(valor);
    return valido ? null : 'Campo Obrigatório!';
  }

}
