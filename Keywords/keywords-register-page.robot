*** Settings ***
Library    SeleniumLibrary
Resource    ${CURDIR}/../Variables/p-beam-web-variables.robot
*** Keywords ***
Open Chrome
    [Arguments]    ${link}
    Open Browser    ${link}    ${Browser}    options=add_argument("--ignore-certificate-errors"); add_argument("--disable-notifications")
    Maximize Browser Window
    Set Selenium Speed    0.15

Clear Text
    [Arguments]    ${element}
    Press Keys    ${element}    CTRL+a+BACKSPACE

Click Sign Up and Back to Login Page
    #Click Sign Up and Back to Login Page
    Wait Until Element Is Visible    ${signup-btn}
    Click Element    ${signup-btn}
    #Register Success
    Wait Until Element Is Visible    ${register-success}
    Click Element    ${register-success}
    Wait Until Element Is Visible    ${register-success-ok}
    Click Element    ${register-success-ok}
    #Back to Login
    Wait Until Element Is Visible    ${welcome_to_kru_p_beam}
    Click Element    ${welcome_to_kru_p_beam}

Input Register
    Click Create Account
    #firstname
    Wait Until Element Is Visible    ${firstname}
    Input Text    ${firstname}    กนกนวล
    #lastname
    Wait Until Element Is Visible    ${lastname}
    Input Text    ${lastname}    อินขาน
    #email
    Wait Until Element Is Visible    ${email-signup}
    Input Text    ${email-signup}    Beam1234@gmail.com
    #password
    Wait Until Element Is Visible    ${password-signup}
    Input Text    ${password-signup}    1234567890
    #mobile phone
    Wait Until Element Is Visible   ${mobilePhone-signup} 
    Input Text    ${mobilePhone-signup}    08222222222
    #Gender
    Wait Until Element Is Visible    ${gender-label-locator}
    Select Radio Button    ${gender-groupname}    ${gender-male-value}
    Radio Button Should Be Set To    ${gender-groupname}    ${gender-male-value}
    #Checkbox
    Wait Until Element Is Visible    ${checkbox-label-locator}
    Select Checkbox    ${checkbox-sql}
    Checkbox Should Not Be Selected    ${checkbox-testManual}
    Checkbox Should Not Be Selected    ${checkbox-automateTest}
    Checkbox Should Not Be Selected    ${checkbox-automateTest2}
    #Nationality
    Wait Until Element Is Visible    ${nationality-listbox}
    Click Element    ${nationality-listbox}
    Wait Until Element Is Visible    ${nationality-thai}
    Click Element    ${nationality-thai}
    #Role
    Wait Until Element Is Visible    ${role-listbox}
    Click Element    ${role-listbox}
    Wait Until Element Is Visible    ${role-admin}
    Click Element    ${role-admin}
    #Plan
    Wait Until Element Is Visible    ${plan-listbox}
    Click Element    ${plan-listbox}
    Wait Until Element Is Visible    ${plan-basic}
    Click Element    ${plan-basic}

Input Negative Required Field
    #Register
    Click Create Account
    #Click Sign Up and Back to Login Page
    Wait Until Element Is Visible    ${signup-btn}
    Click Element    ${signup-btn}
    #Required Field Error
    Wait Until Element Is Visible    ${firstname-required}
    Wait Until Element Is Visible    ${lastname-required}
    Wait Until Element Is Visible    ${password-required}
    Wait Until Element Is Visible    ${email-required}
    Wait Until Element Is Visible    ${mobilePhone-required}
    Wait Until Element Is Visible    ${gender-required}
    Wait Until Element Is Visible    ${checkbox-required}
    Wait Until Element Is Visible    ${nationality-required}
    Wait Until Element Is Visible    ${role-required}
    Wait Until Element Is Visible    ${plan-required}

Input Negative Invalid Email
    [Arguments]    ${emailText}
    #email
    Wait Until Element Is Visible    ${email-signup}
    Input Text    ${email-signup}    ${emailText}
    #test sign up with invalid email
    Wait Until Element Is Visible    ${signup-btn}
    Click Element    ${signup-btn}
    #check error message
    Wait Until Element Is Visible    ${email-invalid}
    #Clear Email Text
    Clear Text    ${email-signup}

Reset Information
    Click Element    ${reset-information}

Click Create Account
    Wait Until Element Is Visible    ${create_account_href}
    Click Element    ${create_account_href}