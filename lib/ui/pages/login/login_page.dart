import 'package:enquetes/ui/pages/pages.dart';
import 'package:enquetes/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'widgets/widgets.dart';

class LoginPage extends StatefulWidget {

  final LoginPresenter presenter;

  const LoginPage(this.presenter);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  void dispose() {
    super.dispose();
    widget.presenter.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          widget.presenter.loadingStream.listen((isLoading) {
            if (isLoading) {
              showLoadingDialog(context);
            } else {
              hideLoadingDialog(context);
            }
          });

          widget.presenter.mainErrorStream.listen((error) {
            if (error != null && error.isNotEmpty) {
              showErrorDialog(context, error);
            }
          });

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LoginHeader(),
                TextHeaderH1('Login'),
                LoginForm(widget.presenter)
              ],
            ),
          );
        },
      ),
    );
  }
}
