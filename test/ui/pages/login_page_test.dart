import 'dart:async';

import 'package:enquetes/ui/pages/pages.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class LoginPresenterSpy extends Mock implements LoginPresenter {}

void main() {

  LoginPresenter presenter;
  StreamController<String> emailErrorController;
  StreamController<String> senhaErrorController;

  Future<void> carregarLoginPage(final WidgetTester tester) async {
    presenter = LoginPresenterSpy();
    emailErrorController = StreamController<String>();
    senhaErrorController = StreamController<String>();
    when(presenter.emailErrorStream).thenAnswer((_) => emailErrorController.stream);
    when(presenter.senhaErrorStream).thenAnswer((_) => senhaErrorController.stream);

    final loginPage = MaterialApp(home: LoginPage(presenter));
    await tester.pumpWidget(loginPage);
  }

  tearDown(() {
    emailErrorController.close();
    senhaErrorController.close();
  });

  testWidgets('Test - Deve validadar login com dados corretos', (WidgetTester tester) async {
    await carregarLoginPage(tester);

    final email = faker.internet.email();
    await tester.enterText(find.bySemanticsLabel('Email'), email);
    verify(presenter.validarEmail(email));

    final senha = faker.internet.password();
    await tester.enterText(find.bySemanticsLabel('Senha'), senha);
    verify(presenter.validarSenha(senha));
  });

  testWidgets('Test - Deve validar o login caso o email seja inválido', (WidgetTester tester) async {
    await carregarLoginPage(tester);

    emailErrorController.add('email_error');
    await tester.pump();
    
    expect(find.text('email_error'), findsOneWidget);
  });

  testWidgets('Test - Deve validar o login caso o email válido', (WidgetTester tester) async {
    await carregarLoginPage(tester);

    emailErrorController.add(null);
    await tester.pump();

    expect(
        find.descendant(of: find.bySemanticsLabel('Email'), matching: find.byType(Text)),
        findsOneWidget
    );
  });

  testWidgets('Test - Deve validar o login caso o email válido (com string vazia)', (WidgetTester tester) async {
    await carregarLoginPage(tester);

    emailErrorController.add('');
    await tester.pump();

    expect(
        find.descendant(of: find.bySemanticsLabel('Email'), matching: find.byType(Text)),
        findsOneWidget
    );
  });

  testWidgets('Test - Deve validar o login caso o senha seja inválida', (WidgetTester tester) async {
    await carregarLoginPage(tester);

    senhaErrorController.add('senha_error');
    await tester.pump();

    expect(find.text('senha_error'), findsOneWidget);
  });

  testWidgets('Test - Deve validar o login caso o senha válida', (WidgetTester tester) async {
    await carregarLoginPage(tester);

    senhaErrorController.add(null);
    await tester.pump();

    expect(
        find.descendant(of: find.bySemanticsLabel('Senha'), matching: find.byType(Text)),
        findsOneWidget
    );
  });

  testWidgets('Test - Deve validar o login caso o senha válida (com string vazia)', (WidgetTester tester) async {
    await carregarLoginPage(tester);

    senhaErrorController.add('');
    await tester.pump();

    expect(
        find.descendant(of: find.bySemanticsLabel('Senha'), matching: find.byType(Text)),
        findsOneWidget
    );
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
