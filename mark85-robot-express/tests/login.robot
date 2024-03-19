*** Settings ***
Documentation                       Cenários de autenticação do usuário
                           
Library                             Collections
Resource                            ../resources/base.resource

Test Setup                          Start Session
Test Teardown                       Take Screenshot

*** Test Cases ***
Deve poder logar com um usuário pré-cadastrato
    ${user}                         Create Dictionary    
    ...    name=Marcelo Oliveira
    ...    email=marcelo_creative@yahoo.com.br
    ...    password=123456

    Remove user from database       ${user}[email]
    Insert user from database       ${user}

    Submit login form               ${user}
    User should be logged in        ${user}[name]

Não deve logar com senha inválida
    ${user}                          Create Dictionary    
    ...    name=Gaspar Kundera
    ...    email=gkundera@gmail.com
    ...    password=g12345
    
    Remove user from database        ${user}[email]
    Insert user from database        ${user}

    Set To Dictionary                ${user}            password=g12346
    Submit login form                ${user}

    Notice should be                 Ocorreu um erro ao fazer login, verifique suas credenciais.