*** Settings ***
Library           SeleniumLibrary
Resource          ${CURDIR}/Variables/p-beam-web-variables.robot
Resource          ${CURDIR}/Keywords/keywords-register-page.robot

Suite Setup       Set Selenium Speed    0.15
Suite Teardown    Close All Browsers
Test Setup        Open Chrome    https://automate-test.stpb-digital.com/login/
Test Teardown     Close Browser

*** Test Cases ***

TC-1 Positive Case Register
    [Tags]    DONE
    [Documentation]    Register Case ที่เป็น Positive
    Input Register
    Click Sign Up and Back to Login Page

TC-2 Negative Required Field Register
    [Tags]    DONE
    [Documentation]    Register Case ที่ไม่ได้ใส่ Required Field
    Input Negative Required Field

TC-3 Negative Invalid Email Register
    [Setup]    Open Chrome    https://automate-test.stpb-digital.com/register/
    [Tags]    DONE
    [Documentation]    Register Case ที่ใส่ Email ผิด Format
    [Template]    Input Negative Invalid Email
    1234gmail.com
    นี่คืออีเมล
    42353245234

TC-4 Reset Information Case
    [Tags]    IN PROGRESS
    [Documentation]    รีเซ็ตข้อมูลตอน Register
    Input Register
    Reset Information