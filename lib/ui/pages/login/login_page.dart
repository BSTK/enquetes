import 'package:enquetes/ui/components/components.dart';
import 'package:enquetes/ui/pages/pages.dart';
import 'package:flutter/material.dart';

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

          widget.presenter.mainErrorStream.listen((error) {
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
                LoginForm(widget.presenter)
              ],
            ),
          );
        },
      ),
    );
  }
}
