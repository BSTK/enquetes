import 'package:enquetes/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);
    return Container(
      width: double.infinity,
      child: StreamBuilder<bool>(
          stream: presenter.formularioValidoStream,
          builder: (context, snapshot) {
            return RaisedButton(
              onPressed: snapshot.data == true
                  ? presenter.autenticar
                  : null,
              child: Text('Login'.toUpperCase()),
            );
          }
      ),
    );
  }
}
