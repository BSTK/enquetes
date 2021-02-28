import 'package:enquetes/ui/pages/pages.dart';
import 'package:enquetes/ui/widgets/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return MaterialApp(
      title: 'Enquetes',
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      home: LoginPage(null),
    );
  }

}
