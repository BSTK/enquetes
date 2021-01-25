import 'package:enquetes/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  testWidgets('Test - Deve carrgar a tela de login com estado inicial', (WidgetTester tester) async {
    final loginPage = MaterialApp(
        home: LoginPage()
    );

    await tester.pumpWidget(loginPage);
    
    final emailTextChildren = find.descendant(
        of: find.bySemanticsLabel('Email'),
        matching: find.byType(Text)
    );

    expect(
      emailTextChildren,
      findsOneWidget,
      reason:
        'Quando o TextFormField tiver apenas um filho do tipo Text, '
        'então significa que não há erros, pois sempre terá apenas um '
        'elemento filho que será o labelText'
    );

    final senhaTextChildren = find.descendant(
        of: find.bySemanticsLabel('Senha'),
        matching: find.byType(Text)
    );

    expect(
        senhaTextChildren,
        findsOneWidget,
        reason:
        'Quando o TextFormField tiver apenas um filho do tipo Text, '
        'então significa que não há erros, pois sempre terá apenas um '
        'elemento filho que será o labelText'
    );

    final buttonLogin = tester.widget<RaisedButton>(find.byType(RaisedButton));
    expect(buttonLogin.onPressed, null);
  });

}
