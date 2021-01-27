import 'package:flutter/material.dart';

void showLoadingDialog(final BuildContext context) {
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
}

void hideLoadingDialog(final BuildContext context) {
  if (Navigator.canPop(context)) {
    Navigator.of(context).pop();
  }
}

void showErrorDialog(final BuildContext context, final String mensagem) {
  Scaffold.of(context).showSnackBar(
    SnackBar(
       backgroundColor: Colors.redAccent[900],
       content: Text(mensagem, textAlign: TextAlign.center)
    )
  );
}
