*** Settings ***
Documentation                       Cenários de cadastro de tarefa

Resource                            ../../resources/base.resource
Test Setup                          Start Session
Test Teardown                       Take Screenshot

*** Test Cases ***
Deve poder cadastrar uma nova tarefa

    ${data}                         Get fixture                            tasks                create

    Clean user from database        ${data}[user][email]
    Insert user from database       ${data}[user]

    Submit login form               ${data}[user]
    User should be logged in        ${data}[user][name]

    Go to task form

    Submit task form                ${data}[task]

    Task should be registered       ${data}[task][name]

Não deve cadastrar tarefa com nome duplicado
    [Tags]                           dup
    ${data}                          Get fixture                           tasks                 duplicate

    Remove user from database        ${data}[user][email]
    Insert user from database        ${data}[user]

    Submit login form                ${data}[user]
    User should be logged in         ${data}[user][name]

    POST user session                ${data}[user]
    POST a new task                  ${data}[task]

    Go to task form
    Submit task form                 ${data}[task]

    Notice should be                 Oops! Tarefa duplicada.

Não deve cadastrar uma nova tarefa quando atinge limite de tags
    [Tags]                           tags_limit
    ${data}                          Get fixture                           tasks                 tags_limit

    Remove user from database        ${data}[user][email]
    Insert user from database        ${data}[user]

    Submit login form                ${data}[user]
    User should be logged in         ${data}[user][name]

    Go to task form
    Submit task form                 ${data}[task]

    Notice should be                 Oops! Limite de tags atingido.