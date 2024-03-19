*** Settings ***
Documentation                     Ações e elementos da página de login

Library                           Browser
Library                           String

*** Keywords ***
Submit login form
    [Arguments]                   ${user}

    Fill Text                     css=input[placeholder="E-mail"]        ${user}[email]
    Fill Text                     css=input[placeholder=Senha]           ${user}[password]
    Click                         css=button >> text=Entrar