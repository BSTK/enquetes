import 'package:flutter/material.dart';

class TextHeaderH1 extends StatelessWidget {
  final String texto;

  const TextHeaderH1(this.texto);

  @override
  Widget build(BuildContext context) {
    return Text(
      texto.toUpperCase(),
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headline1,
    );
  }
}
