*** Settings ***

Library                            Browser
Library                            libs/databse.py
Library                            JSONLibrary

Resource                           env.resource
Resource                           pages/SignupPage.resource
Resource                           pages/LoginPage.resource
Resource                           pages/TaskCreatePage.resource
Resource                           pages/TasksPage.resource

Resource                           pages/components/Notice.resource
Resource                           pages/components/Alert.resource
Resource                           pages/components/Header.resource

*** Keywords ***
Start Session
    New Browser                    browser=chromium                               headless=False
    New Page                       ${URL_BASE}

Get fixture
    [Arguments]                    ${file_name}                                   ${scenario}

    ${data}                        Load Json From File                            ${EXECDIR}/resources/fixtures/${file_name}.Json        encoding=utf-8

    [Return]                       ${data}[${scenario}]