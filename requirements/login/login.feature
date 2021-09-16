Feature: Login
Como um cliente
Quero poder acessar minha conta e me manter logado
Para que eu possa acessar a página principal do app

Cenário: Credenciais válidas
Dado que o cliente informou credenciais válidas
Quando solicitar para fazer login
Então o sistema deve enviar o usuário para a tela principal
E manter o usuário conectado

Cenário: Credenciais inválidas
Dado que o cliente informou credenciais inválidas
Quando solicitar para fazer login
Então o sistema deve retornar uma mensagem de erro