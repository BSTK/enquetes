abstract class LoginPresenter {
  Stream<String> get mainErrorStream;
  Stream<String> get emailErrorStream;
  Stream<String> get senhaErrorStream;

  Stream<bool> get loadingStream;
  Stream<bool> get formularioValidoStream;

  void autenticar();
  void validarEmail(final String email);
  void validarSenha(final String email);
}
