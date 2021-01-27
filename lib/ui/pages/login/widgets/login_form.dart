import 'package:enquetes/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets.dart';

class LoginForm extends StatelessWidget {

  final LoginPresenter presenter;

  const LoginForm(this.presenter);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Provider<LoginPresenter>(
        create: (_) => presenter,
        child: Form(
            child: Column(
              children: [
                EmailInput(),
                PasswordInput(),
                LoginButton(),
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
      ),
    );
  }
}
