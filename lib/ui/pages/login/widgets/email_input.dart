import 'package:enquetes/ui/pages/pages.dart';
import 'package:flutter/material.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({
    Key key,
    @required this.presenter,
  }) : super(key: key);

  final LoginPresenter presenter;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
        stream: presenter.emailErrorStream,
        builder: (context, snapshot) {
          return TextFormField(
            decoration: InputDecoration(
              labelText: 'Email',
              errorText: snapshot.data?.isNotEmpty == true ? snapshot.data : null,
              icon: Icon(Icons.email, color: Theme.of(context).primaryColorLight),
            ),
            keyboardType: TextInputType.emailAddress,
            onChanged: presenter.validarEmail,
          );
        }
    );
  }
}
