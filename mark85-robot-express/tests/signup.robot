*** Settings ***
Documentation        Cenarios de teste do cadastro de usuários

Resource                          ../resources/base.resource

Test Setup                        Start Session
Test Teardown                     Take Screenshot

*** Test Cases ***
Deve poder cadastrar novo usuário
    ${user}                        Create Dictionary    
    ...                            name=Marcelo de Oliveira
    ...                            email=marcelo@gmail.com
    ...                            password=123456    
    
    Remove user from database      ${user}[email]

    Go to signup page
    Submit signup form             ${user}
    Notice should be               Boas vindas ao Mark85, o seu gerenciador de tarefas.

Não deve permitir cadastro de email duplicado
    [Tags]                         dup

    ${user}                        Create Dictionary
    ...                            name=Oliveira Marcelo
    ...                            email=oliveira@yahoo.com
    ...                            password=654321  

    Remove user from database      ${user}[email]
    Insert user from database      ${user}

    Go to signup page
    Submit signup form             ${user}
    Notice should be               Oops! Já existe uma conta com o e-mail informado.
Campos obrigatórios
    [Tags]                          required

    ${user}                         Create Dictionary    
    ...                             name=${EMPTY}
    ...                             email=${EMPTY}
    ...                             password=${EMPTY}
    
    Go to signup page
    Submit signup form              ${user}

    Alert should be                 Informe seu nome completo
    Alert should be                 Informe seu e-email
    Alert should be                 Informe uma senha com pelo menos 6 digitos

Não deve cadastrar com email incorreto
    [Tags]                          env_email

    ${user}                         Create Dictionary    
    ...                             name=João Paes da Silva
    ...                             email=joaopaes.com.br
    ...                             password=112233
    
    Go to signup page
    Submit signup form              ${user}

    Alert should be                 Digite um e-mail válido

Não deve cadastrar com senha de 1 dígito
    [Tags]                          short_pass
    [Template]                      
    Short password                  1

Não deve cadastrar com senha de 2 dígitos
    [Tags]                          short_pass
    [Template]                      
    Short password                  12

Não deve cadastrar com senha de 3 dígitos
    [Tags]                          short_pass
    [Template]                      
    Short password                  123

Não deve cadastrar com senha de 4 dígitos
    [Tags]                          short_pass
    [Template]                      
    Short password                  1234

Não deve cadastrar com senha de 5 dígitos
    [Tags]                          short_pass
    [Template]                      
    Short password                  12345

*** Keywords ***
Short password
    [Arguments]                      ${shor_pass}
    ${user}                          Create Dictionary    
    ...                             name=Paolo Rossi
    ...                             email=paulorossi@gmail.com
    ...                             password=${shor_pass}
    
    Go to signup page
    Submit signup form              ${user}

    Alert should be                 Informe uma senha com pelo menos 6 digitos