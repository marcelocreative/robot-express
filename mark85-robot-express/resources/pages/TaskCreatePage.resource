*** Settings ***
Documentation              Ações e elementos da página de cadastro de tarefas
Library                    Browser

*** Keywords ***
Submit task form
    [Arguments]            ${task}

    Fill Text              css=input[placeholder$=tarefa]                    ${task}[name]

    ${task_element}        Set Variable                                      css=input[name=tags]

    FOR    ${tag}    IN    @{task}[tags]
        
        Fill Text        ${task_element}         ${tag}
        Sleep            1
        Press Keys       ${task_element}         Enter 
    END

    Click                  css=button >> text=Cadastrar