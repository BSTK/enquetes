import 'package:enquetes/ui/pages/pages.dart';
import 'package:flutter/material.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({
    Key key,
    @required this.presenter,
  }) : super(key: key);

  final LoginPresenter presenter;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 32.0),
      child: StreamBuilder<String>(
          stream: presenter.senhaErrorStream,
          builder: (context, snapshot) {
            return TextFormField(
              decoration: InputDecoration(
                labelText: 'Senha',
                errorText: snapshot.data?.isNotEmpty == true ? snapshot.data : null,
                icon: Icon(Icons.lock, color: Theme.of(context).primaryColorLight),
              ),
              obscureText: true,
              onChanged: presenter.validarSenha,
            );
          }
      ),
    );
  }
}