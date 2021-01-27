abstract class LoginPresenter {
  Stream get emailErrorStream;
  Stream get senhaErrorStream;

  void validarEmail(final String email);
  void validarSenha(final String email);
}
