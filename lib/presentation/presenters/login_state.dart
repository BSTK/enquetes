class LoginState {
  String email;
  String senha;
  String emailError;
  String senhaError;

  bool get isformularioValido
    => emailError == null
    && senhaError == null
    && email != null
    && senha != null;
}
