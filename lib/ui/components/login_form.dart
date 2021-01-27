import 'package:enquetes/ui/pages/pages.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {

  final LoginPresenter presenter;

  const LoginForm(this.presenter);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Form(
          child: Column(
            children: [
              StreamBuilder<String>(
                stream: presenter.emailErrorStream,
                builder: (context, snapshot) {
                  return TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      errorText: snapshot.data,
                      icon: Icon(Icons.email, color: Theme.of(context).primaryColorLight),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: presenter.validarEmail,
                  );
                }
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 32.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    icon: Icon(Icons.lock, color: Theme.of(context).primaryColorLight),
                  ),
                  obscureText: true,
                  onChanged: presenter.validarSenha,
                ),
              ),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  onPressed: null,
                  child: Text('Login'.toUpperCase()),
                ),
              ),
              Container(
                width: double.infinity,
                child: FlatButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.person),
                    label: Text('Criar conta')
                ),
              )
            ],
          )
      ),
    );
  }
}
