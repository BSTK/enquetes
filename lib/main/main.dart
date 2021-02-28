import 'package:enquetes/ui/widgets/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return GetMaterialApp(
      title: 'Enquetes',
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: loginPage)
      ],
    );
  }

}
