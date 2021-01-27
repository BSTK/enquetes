import 'package:enquetes/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);
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
