*** Settings ***
Library    SeleniumLibrary
Resource    ${CURDIR}/../Variables/p-beam-web-variables.robot

*** Keywords ***
Open Chrome
    Open Browser    ${URL}    ${Browser}    options=add_argument("--ignore-certificate-errors"); add_argument("--disable-notifications")
    Maximize Browser Window
    Set Selenium Speed    0.15

Clear Text
    [Arguments]    ${element}
    Press Keys    ${element}    CTRL+a+BACKSPACE

Element Check Default Page
    Element Should Be Visible    ${welcome_to_kru_p_beam}
    Element Should Be Visible    ${input_email}
    Element Should Be Visible    ${input_password}
    Element Should Be Visible    ${login_btn}
    Element Should Be Visible    ${create_account_href}

Welcome Text Home Page
    Wait Until Page Contains    Welcome to Kru P' Beam

Is Email Text Show Up
    Wait Until Element Is Visible    ${input_email}
    Input Text    ${input_email}    Beam1234@gmail.com
    Wait Until Element Is Visible    ${beam_valid_email}

Input Email Invalid Form
    [Arguments]    ${emailAddress}
    Wait Until Element Is Visible    ${input_email}
    Input Text    ${input_email}    ${emailAddress}
    Set Focus To Element    ${input_password}
    Wait Until Element Is Visible    ${email_must_be_valid}
    Clear Text    ${input_email}

Input Password Less Than 4
    Wait Until Element Is Visible    ${input_password}
    Input Text    ${input_password}    1234
    Set Focus To Element    ${input_email}
    Wait Until Element Contains    ${password_must_more_than_5}    text=password must be at least 5 characters
    
Login Positive Case
    Wait Until Element Is Visible    ${input_email}
    Input Text    ${input_email}    ${email}
    Wait Until Element Is Visible    ${input_password}
    Input Text    ${input_password}    ${password}
    Click Button    ${login_btn}
    #If logged in, next page will show 'User' text at navbar
    Wait Until Element Is Visible    ${user_text_home_page}

Input Invalid User
    Wait Until Element Is Visible    ${input_email}
    Input Text    ${input_email}    Beam12345678@gmail.com
    Wait Until Element Is Visible    ${input_password}
    Input Text    ${input_password}    12345678900
    Click Button    ${login_btn}
    Wait Until Element Is Visible    ${email_or_password_invalid}

Not Input Email and Press Login
    Click Button    ${login_btn}
    Wait Until Element Is Visible    ${email_is_a_required_field}

Click Create Account and Verify Element
    Wait Until Element Is Visible    ${create_account_href}
    Click Element    ${create_account_href}
    Wait Until Element Is Visible    ${signup-btn}