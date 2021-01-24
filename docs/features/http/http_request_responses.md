# HTTP

> ## Sucesso
1. ✅ Fazer um request com verbo http valido (POST)
2. Enviar nos headers o content type JSON
3. Enviar nos headers o body correto
4. HttpStatus 200 - OK: Resposta com os dados
5. HttpStatus 204 - OK: Resposta sem dados

> ## Erros
1. Bad Request - HttpStatus 400
2. Unauthorized - HttpStatus 401
3. Forbidden - HttpStatus 403
4. Not Found - HttpStatus 404
5. Internal Server Error - HttpStatus 500

> ## Execeção - Com HttpStatus diferente dos citados acima
1. Internal Server Error - HttpStatus 500

> ## Execeção - Http request que deu alguma exceção não tratada
1. Internal Server Error - HttpStatus 500

> ## Exceção - Verbo Http inválido
1. Internal Server Error - HttpStatus 500
