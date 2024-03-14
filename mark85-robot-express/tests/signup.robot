*** Settings ***
Documentation        Cenarios de teste do cadastro de usuários

Resource                          ../resources/base.resource

Test Setup                        Start Session
Test Teardown                     Take Screenshot

*** Test Cases ***
Deve poder cadastrar novo usuário
    ${user}                        Create Dictionary    
    ...    name=Marcelo de Oliveira
    ...    email=marcelo@gmail.com
    ...    password=123456    
    
    Remove user from database      ${user}[email]

    Go to signup page
    Submit signup form             ${user}
    Notice should be               Boas vindas ao Mark85, o seu gerenciador de tarefas.

Não deve permitir cadastro de email duplicado
    [Tags]                         dup

    ${user}                        Create Dictionary
    ...    name=Oliveira Marcelo
    ...    email=oliveira@yahoo.com
    ...    password=654321  

    Remove user from database      ${user}[email]
    Insert user from database      ${user}

    Go to signup page
    Submit signup form             ${user}
    Notice should be               Oops! Já existe uma conta com o e-mail informado.
Campos obrigatórios
    [Tags]                          required

    ${user}                         Create Dictionary    
    ...    name=${EMPTY}
    ...    email=${EMPTY}
    ...    password=${EMPTY}
    
    Go to signup page
    Submit signup form              ${user}

    Alert should be                 Informe seu nome completo
    Alert should be                 Informe seu e-email
    Alert should be                 Informe uma senha com pelo menos 6 digitos