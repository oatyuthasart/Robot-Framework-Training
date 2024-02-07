*** Settings ***
Library           SeleniumLibrary
Library    String
Resource          ${CURDIR}/Variables/p-beam-web-variables.robot
Resource          ${CURDIR}/Keywords/keywords-home-data-page.robot

#Suite Setup       Set Selenium Speed    0.03
Suite Setup       Set Selenium Speed    0.05
Suite Teardown    Close All Browsers
Test Setup        Open Browser Chrome
Test Teardown     Close Browser

*** Test Cases ***
TC-1 Notification
    [Documentation]    สำหรับการทดสอบเปิด Notification และปิด Notification
    [Tags]    Done
    Login Admin User
    Open Notification & Close

TC-2 Logout User
    [Documentation]    สำหรับการทดสอบ Logout User ออกจากระบบ
    [Tags]    Done
    Login Admin User
    Logout

TC-3 Search No Filter
    [Documentation]    สำหรับการทดสอบ Search แบบไม่ Filter ว่าจะขึ้น Data หรือไม่
    [Tags]    Search
    Login Admin User
    Click Search Button
    Wait Until Element Is Visible    ${first-column-in-table}

TC-4 Search and Clear Text
    [Documentation]    สำหรับการทดสอบ กด Clear Filter และเช็คว่าเป็น no rows หรือไม่
    [Tags]    Done    Search
    Login Admin User
    Search By Role    admin
    Click Search Button
    Cleat Filter

TC-5 Filter and Verify Data Case
    [Documentation]    สำหรับการทดสอบ Search ด้วย Filter และ  Verify ว่า Data ตรงตาม Filter
    [Tags]    Done    Search
    [Template]    Filter and Verify the Data
    author        ${EMPTY}      ${EMPTY}        Author          none          none
    ${EMPTY}      team          ${EMPTY}        none          Team          none
    ${EMPTY}      ${EMPTY}      inactive        none          none          Inactive
    admin         basic         ${EMPTY}        Admin         Basic         none
    ${EMPTY}      company       pending         none          Company       Pending
    subscriber    ${EMPTY}      active          Subscriber    none          Active
    editor        enterprise    pending         Editor        Enterprise    Pending

TC-6 Add Account and Verify
    [Documentation]    สำหรับการทดสอบ Add User และ Verify ว่า Data ตรงตามที่ Create
    [Tags]    Done    Add Account
    Login Admin User
    Add User    กนกนวล    อินขาน    Beam1234@gmail.com    ${role-admin}    ${plan-basic}    admin    basic
    Verify Register    กนกนวล    อินขาน    Beam1234@gmail.com    Admin    Basic

TC-7 Add Account No Required Field
    [Documentation]    สำหรับการทดสอบ Add User โดยไม่ใส่ Required Field
    [Tags]    Done    Add Account
    Login Admin User
    Input Register No Required Field

TC-8 Invalid Email Register
    [Documentation]    สำหรับการทดสอบ Invalid Email Address
    [Tags]    Done
    [Template]    Input Register Email Invalid
    1234    ${True}
    นี่คืออีเมล
    email.com

TC-9 Change Rows Per Page Then Verify Data Amount In Each Page
    [Documentation]    สำหรับการทดสอบ การเปลี่ยนจำนวนแถว Data ต่อ Page และ Verify ว่าจำนวน Data แต่ละหน้าถูกต้อง
    [Tags]    Done
    Login Admin User
    Change Rows Per Page and Verify



# TC-1 Filter Admin Role & Basic Plan
#     [Documentation]
#     Login Admin User
#     Search By Role    admin
#     Search By Plan    basic
#     Click Search Button
#     Verify Every Data's Role    Admin    Basic

# TC-2 Filter Basic Plan
#     Login Admin User
#     Search By Plan    basic
#     Click Search Button
#     Verify Every Data's Role    Basic    Plan

# TC-3 Filter Active Status
#     Login Admin User
#     Search By Status    active
#     Click Search Button
#     Verify Every Data's Role    filterValueStatus=Active

# Test002
#     ${original_string}=    Set Variable    11–13 of 13
#     ${split1}=    Split String    ${original_string}    of
#     Log To Console    Split 1${split1}
#     ${first}=    Set Variable   ${split1}[0]
#     Log To Console    first ${first}
#     ${split2}=    Split String    ${first}    –
#     ${yo1}=    Evaluate    ${split2}[1]-${split2}[0]+1
#     Log To Console    ${split2}[0]
#     Log To Console    ${split2}[1]
#     Log To Console    ${yo1}

# TC-2 Filter Basic Plan
#     Login Admin User
#     Search By Plan    basic
#     ${is-next-page-available}=    Run Keyword And Return Status   Element Should Be Visible    ${next-page}
#     Verify Every Data's Role    Basic    Plan
#     Log To Console    ${is-next-page-available}
    
#     #หากยังมีลูกศรให้กดดูหน้าต่อไป จะเข้า While Loop ไปเช็คหน้าถัดไปเรื่อยๆ
#     WHILE  ${is-next-page-available}
#         Click Element    ${next-page}
#         Verify Every Data's Role    Basic    Plan
#         ${is-next-page-available}=    Run Keyword And Return Status    Element Should Be Visible    ${next-page}
#     END