import 'package:enquetes/ui/components/components.dart';
import 'package:enquetes/ui/pages/pages.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {

  final LoginPresenter presenter;

  const LoginPage(this.presenter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LoginHeader(),
            TextHeaderH1('Login'),
            LoginForm(presenter)
          ],
        ),
      ),
    );
  }
}
