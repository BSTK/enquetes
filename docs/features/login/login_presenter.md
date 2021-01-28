# Login Page

> ## Regras de validação
1. ✅ Chamar Validation ao alterar o email
2. ✅ Notificar o emailErrorStream com o mesmo erro do Validation, caso retorne erro
3. ✅ Notificar o emailErrorStream com null , caso o Validation não retorne erro
4. ✅ Não notificar o emailErrorStream se o valor for igual ao último
5. ✅ Notificar o formularioValidoStream após alterar o email
6. ✅ Chamar Validation ao alterar a senha
7. ✅ Notificar o senhaErrorStream com o mesmo erro do Validation, caso retorne erro
8. ✅ Notificar o senhaErrorStream com null , caso o Validation não retorne erro
9. ✅ Não notificar o senhaErrorStream se o valor for igual ao último
10. ✅ Notificar o formularioValidoStream após alterar a senha
11. ✅ Para o formulário estar válido, todos os Streams de erro precisam estar null e todos os campos
obrigatórios não podem estar vazios
12. ✅ Não notificar o formularioValidoStreamse o valor for igual ao último
13. Chamar o Autenticar com email e senha corretos
14. Notificar o isLoadingStream com true anter de chamar o Autenticar
15. Notificar o isLoadingStream com false no fim do Autenticar
16. Notificar o mainErrorStream caso o Autenticar retorner um DomainError
17. Fechar todos os Streams no dispose
18. ⛔ Gravar a ContaAutenticada no cache em caso de sucesso
19. ⛔ Redirecionar o usuário para a tela de Enquetes em caso de sucesso
