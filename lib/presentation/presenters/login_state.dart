class LoginState {
  String email;
  String senha;
  String mainError;
  String emailError;
  String senhaError;
  bool isLoading = false;

  bool get isformularioValido
    => emailError == null
    && senhaError == null
    && email != null
    && senha != null;
}
