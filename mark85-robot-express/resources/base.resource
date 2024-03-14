*** Settings ***

Library         Browser
Library         libs/databse.py

Resource        env.resource
Resource        pages/SignupPage.resource


*** Keywords ***
Start Session
    New Browser                    browser=chromium                   headless=False
    New Page                       ${URL_BASE}