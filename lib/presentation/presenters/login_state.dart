class LoginState {
  String email;
  String senha;
  String emailError;
  String senhaError;
  bool loadingStream = false;

  bool get isformularioValido
    => emailError == null
    && senhaError == null
    && email != null
    && senha != null;
}
