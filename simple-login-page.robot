*** Settings ***
Library    SeleniumLibrary
Resource    ${CURDIR}/Variables/p-beam-web-variables.robot
Resource    ${CURDIR}/Keywords/keywords-login-page.robot

*** Test Cases ***
TC-1 Check Default Page Element
    Open Chrome
    Element Check Default Page
    Close Browser

TC-2 Check If This Is Home Page
    Open Chrome
    Welcome Text Home Page
    Close Browser

TC-3 Input Email Text Box
    Open Chrome
    Is Email Text Show Up
    Close Browser

TC-4 Input Email Case Invalid Form
    [Setup]    Open Chrome
    [Template]    Input Email Invalid Form
    yo1234gmail.com
    นี่คืออีเมล
    123456789
    [Teardown]    Close Browser

TC-5 Password less than 4
    Open Chrome
    Input Password Less Than 4
    Close Browser

TC-6 Login Positive Case
    Open Chrome
    Login Positive Case
    Close Browser

TC-7 Login with not existing user
    Open Chrome
    Input Invalid User
    Close Browser

TC-8 Login Without Input Email
    Open Chrome
    Not Input Email and Press Login
    Close Browser

TC-9 Press Create Account
    Open Chrome
    Click Create Account and Verify Element
    Close Browser