abstract class LoginPresenter {
  Stream get emailErrorStream;
  Stream get senhaErrorStream;
  Stream get formularioValidoStream;

  void autenticar();
  void validarEmail(final String email);
  void validarSenha(final String email);
}
