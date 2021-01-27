import 'package:enquetes/ui/components/components.dart';
import 'package:enquetes/ui/pages/pages.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {

  final LoginPresenter presenter;

  const LoginPage(this.presenter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          presenter.loadingStream.listen((isLoading) {
            if (isLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                child: SimpleDialog(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10.0),
                        Text('Aguarde ...', textAlign: TextAlign.center)
                      ],
                    )
                  ],
                )
              );
            } else {
              if (Navigator.canPop(context)) {
                Navigator.of(context).pop();
              }
            }
          });

          presenter.mainErrorStream.listen((error) {
            if (error != null && error.isNotEmpty) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.redAccent[900],
                  content: Text(error, textAlign: TextAlign.center)
                )
              );
            }
          });

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LoginHeader(),
                TextHeaderH1('Login'),
                LoginForm(presenter)
              ],
            ),
          );
        },
      ),
    );
  }
}
