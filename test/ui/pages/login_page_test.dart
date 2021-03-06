import 'dart:async';

import 'package:enquetes/ui/pages/pages.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class LoginPresenterSpy extends Mock implements LoginPresenter {}

void main() {

  LoginPresenter presenter;
  StreamController<bool> loadingController;
  StreamController<bool> formularioValidoController;

  StreamController<String> mainErrorController;
  StreamController<String> emailErrorController;
  StreamController<String> senhaErrorController;

  void inicializarStreams() {
    mainErrorController = StreamController<String>();
    emailErrorController = StreamController<String>();
    senhaErrorController = StreamController<String>();

    loadingController = StreamController<bool>();
    formularioValidoController = StreamController<bool>();
  }

  void mockWhenStreams() async {
    when(presenter.mainErrorStream).thenAnswer((_) => mainErrorController.stream);
    when(presenter.emailErrorStream).thenAnswer((_) => emailErrorController.stream);
    when(presenter.senhaErrorStream).thenAnswer((_) => senhaErrorController.stream);

    when(presenter.loadingStream).thenAnswer((_) => loadingController.stream);
    when(presenter.formularioValidoStream).thenAnswer((_) => formularioValidoController.stream);
  }

  void finalizarStreams() {
    mainErrorController.close();
    emailErrorController.close();
    senhaErrorController.close();

    loadingController.close();
    formularioValidoController.close();
  }

  Future<void> carregarLoginPage(final WidgetTester tester) async {
    presenter = LoginPresenterSpy();

    inicializarStreams();
    mockWhenStreams();

    final loginPage = MaterialApp(home: LoginPage(presenter));
    await tester.pumpWidget(loginPage);
  }

  tearDown(() => finalizarStreams());

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

  testWidgets('Test - Deve habilitar o botao de login caso os dados estejam válidos', (WidgetTester tester) async {
    await carregarLoginPage(tester);

    formularioValidoController.add(true);
    await tester.pump();

    final buttonLogin = tester.widget<RaisedButton>(find.byType(RaisedButton));
    expect(buttonLogin.onPressed, isNotNull);
  });

  testWidgets('Test - Deve desabilitar o botao de login caso os dados estejam inválidos', (WidgetTester tester) async {
    await carregarLoginPage(tester);

    formularioValidoController.add(false);
    await tester.pump();

    final buttonLogin = tester.widget<RaisedButton>(find.byType(RaisedButton));
    expect(buttonLogin.onPressed, null);
  });

  testWidgets('Test - Deve autenticar o usuário quando o formulario for submetido', (WidgetTester tester) async {
    await carregarLoginPage(tester);

    formularioValidoController.add(true);
    await tester.pump();
    await tester.tap(find.byType(RaisedButton));
    await tester.pump();

    verify(presenter.autenticar()).called(1);
  });

  testWidgets(
      'Test - Deve mostrar/esconder um CircularProgressIndicator(loagind) quando o '
      'usuário estiver se autenticando ', (WidgetTester tester) async {
    await carregarLoginPage(tester);

    loadingController.add(true);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    loadingController.add(false);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets(
      'Test - Deve mostrar uma mensagem de erro quando der '
      'falha na autenticação do usuário', (WidgetTester tester) async {
    await carregarLoginPage(tester);

    mainErrorController.add('main_error');
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
  });

  testWidgets('Test - Deve fechar todos os streams quando a tela for destruida',
          (WidgetTester tester) async {
    await carregarLoginPage(tester);

    addTearDown(() {
      verify(presenter.dispose()).called(1);
    });
  });

}
