import 'package:enquetes/ui/pages/pages.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class LoginPresenterSpy extends Mock implements LoginPresenter { }

void main() {

  LoginPresenter presenter;

  Future<void> carregarLoginPage(final WidgetTester tester) async {
    presenter = LoginPresenterSpy();
    final loginPage = MaterialApp(home: LoginPage(presenter));
    await tester.pumpWidget(loginPage);
  }

  testWidgets('Test - Deve validadar login com dados corretos', (WidgetTester tester) async {
    await carregarLoginPage(tester);

    final email = faker.internet.email();
    await tester.enterText(find.bySemanticsLabel('Email'), email);
    verify(presenter.validarEmail(email));

    final senha = faker.internet.password();
    await tester.enterText(find.bySemanticsLabel('Senha'), senha);
    verify(presenter.validarSenha(senha));
  });

  testWidgets('Test - Deve carrgar a tela de login com estado inicial', (WidgetTester tester) async {
    await carregarLoginPage(tester);
    
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
