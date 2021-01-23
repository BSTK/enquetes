# language: pt
  Funcionalidade: Login
    Como cliente
    Quero poder acessar minha conta para me manter logado
    Para que eu possa ver e responder enquetes de forma bem rápida

  Cenario: Credenciais Válidas
    Dado que o usuário informou as credenciais válidas
    Quando for solicitado para fazer o login
    Entao o sistema deve enviar o usuário para a tela de pesquisas
    E manter o usuário logado

  Cenario: Credenciais Inválidas
    Dado que o usuário informou as credenciais inválidas
    Quando for solicitado para fazer o login
    Entao o sistema deve retornar uma mensagem de erro
