*** Settings ***
Library    SeleniumLibrary
Library    String
Resource    ${CURDIR}/../Variables/p-beam-web-variables.robot
Resource    ${CURDIR}/keywords-register-page.robot

*** Keywords ***
Open Browser Chrome
    Open Browser    ${URL}    ${Browser}    options=add_argument("--ignore-certificate-errors"); add_argument("--disable-notifications")
    Maximize Browser Window
    
Open Notification & Close
    Wait Until Element Is Visible    ${noti-icon}
    Click Element    ${noti-icon}
    Element Should Be Visible    ${noti-box-ul}
    Wait Until Element Is Visible    ${read-all-noti-btn}
    Click Element    ${read-all-noti-btn}
    Wait Until Element Is Visible    ${noti-box-ul}

Filter and Verify the Data
    [Arguments]    ${searchRole}    ${searchPlan}    ${searchStatus}    ${verifyRole}    ${verifyPlan}    ${verifyStatus}
    Login Admin User
    Search By Role    ${searchRole}
    Search By Plan    ${searchPlan}
    Search By Status    ${searchStatus}
    Click Search Button
    ${numData}=    Get Count On Data Paging
    Log To Console    ${numData}
    IF  ${numData} == 0
        Wait Until Element Is Visible    ${no-rows-display}
    ELSE
        Click Search Button
        Verify Every Data's Role    ${verifyRole}    ${verifyPlan}    ${verifyStatus}
        Logout
    END

Cleat Filter
    Wait Until Element Is Visible    ${clear-btn}
    Click Element    ${clear-btn}
    Wait Until Element Is Visible    ${no-rows-display}

Login Admin User
    Wait Until Element Is Visible    ${input_email}
    Input Text    ${input_email}    ${email}
    Wait Until Element Is Visible    ${input_password}
    Input Text    ${input_password}    ${password}
    Click Button    ${login_btn}
    #If logged in, next page will show 'User' text at navbar
    Wait Until Element Is Visible    ${user_text_home_page}

Logout
    Wait Until Element Is Visible    ${profile-display}
    Click Element    ${profile-display}
    Wait Until Element Is Visible    ${logout-element}
    Click Element    ${logout-element}
    Wait Until Element Is Visible    ${welcome_to_kru_p_beam}

Search By Role 
    [Arguments]    ${roleArg}
    ${roleInput}=    Set Variable    ${roleArg}
    ${role-selection}=    Set Variable   xpath=//*[@data-value='${roleInput}']
    Wait Until Element Is Visible    ${role-filter}
    Click Element    ${role-filter}
    Wait Until Element Is Visible    ${role-selection}
    Click Element    ${role-selection}
    # Wait Until Element Is Visible    ${search-btn}
    # Click Element    ${search-btn}

Search By Plan
    [Arguments]    ${planArg}
    ${planInput}=    Set Variable    ${planArg}
    ${plan-selection}=    Set Variable   xpath=//*[@data-value='${planInput}']
    Wait Until Element Is Visible    ${plan-filter}
    Click Element    ${plan-filter}
    Wait Until Element Is Visible    ${plan-selection}
    Click Element    ${plan-selection}
    # Wait Until Element Is Visible    ${search-btn}
    # Click Element    ${search-btn}

Search By Status
    [Arguments]    ${statusArg}
    ${statusInput}=    Set Variable    ${statusArg}
    ${status-selection}=    Set Variable   xpath=//*[@data-value='${statusInput}']
    Wait Until Element Is Visible    ${status-filter}
    Click Element    ${status-filter}
    Wait Until Element Is Visible    ${status-selection}
    Click Element    ${status-selection}
    # Wait Until Element Is Visible    ${search-btn}
    # Click Element    ${search-btn}

Click Search Button
    Wait Until Element Is Visible    ${search-btn}
    Click Element    ${search-btn}

Verify Every Data's Role
    [Arguments]    ${filterValue}=none     ${filterValuePlan}=none    ${filterValueStatus}=none 
    ${is-next-page-available}=    Set Variable   ${True}

    WHILE  ${is-next-page-available}

    ${is-next-page-available}=    Run Keyword And Return Status   Element Should Be Visible    ${next-page}
    Wait Until Element Is Visible    ${rows-per-page}
    
    ${actualNumsOfData}    ${actualNums2}=    Get Count On Data Paging
        #Loop เช็คว่า Role ทุกคอลัมน์ เป็นตามที่ Filter หรือไม่ เช่น เป็น Admin ทุกคอลัมน์
        FOR  ${index}  IN RANGE    1    ${actualNumsOfData}
            
            ${indexOfColumn}=    Set Variable    ${index}
            ${nameUser}=    Get Text    xpath=//*[@id="__next"]/div[1]/div[2]/main/div/div[2]/div/div[2]/div[2]/div[2]/div/div/div/div[${indexOfColumn}]/div[1]/div/div[2]/a[1]
            IF  '${filterValue}' != 'none'
                ${filter-column-role}=    Set Variable    xpath=//*[@id="__next"]/div[1]/div[2]/main/div/div[2]/div/div[2]/div[2]/div[2]/div/div/div/div[${indexOfColumn}]/div[3]/div/p
                ${roleText}=    Get Text    ${filter-column-role}
                Should Be Equal As Strings    ${roleText}    ${filterValue}
                Log To Console    ${nameUser}'s role: ${roleText}
            END
            IF  '${filterValuePlan}' != 'none'
                ${filter-column-plan}=    Set Variable    xpath=//*[@id="__next"]/div[1]/div[2]/main/div/div[2]/div/div[2]/div[2]/div[2]/div/div/div/div[${indexOfColumn}]/div[4]/h6
                ${planText}=    Get Text    ${filter-column-plan}
                Should Be Equal As Strings    ${planText}    ${filterValuePlan}
                Log To Console    ${nameUser}'s plan: ${planText}
            END
            IF  '${filterValueStatus}' != 'none'
                ${filter-column-status}=    Set Variable    xpath=//*[@id="__next"]/div[1]/div[2]/main/div/div[2]/div/div[2]/div[2]/div[2]/div/div/div/div[${indexOfColumn}]/div[5]/div/span
                ${statusText}=    Get Text    ${filter-column-status}
                Should Be Equal As Strings    ${statusText}    ${filterValueStatus}
                Log To Console    ${nameUser}'s status: ${statusText}
            END
            Log To Console    ------------------------------
        END
        Run Keyword If    ${is-next-page-available}
        ...    Click Element    ${next-page}
        
        Log To Console    ${is-next-page-available}

    END

Add User
    [Arguments]    ${firstN}    ${lastN}    ${emailAddress}    ${locator-role}    ${locator-plan}    ${roleValue}    ${planValue}
    Click Element    ${add-user-btn}
    Input Register Add User    ${firstN}    ${lastN}    ${emailAddress}    ${locator-role}    ${locator-plan}
    Click Sign Up and Back to Home Page
    ${roleValue}=    Convert To Lower Case    ${roleValue}
    ${planValue}=    Convert To Lower Case    ${planValue}
    Search By Role    ${roleValue}
    Search By Plan    ${planValue}
    Click Search Button

Verify Register
    [Arguments]    ${firstN}    ${lastN}    ${emailAddress}    ${roleValue}    ${planValue}
    ${is-next-page-available}=    Set Variable   ${True}

    WHILE  ${is-next-page-available}

    ${is-next-page-available}=    Run Keyword And Return Status   Element Should Be Visible    ${next-page}
    Wait Until Element Is Visible    ${rows-per-page}
    ${actualNumsOfData}    ${actualNum2}=    Get Count On Data Paging

    FOR  ${index}  IN RANGE    1    ${actualNumsOfData}
        ${emailColumn}=    Set Variable   xpath=//*[@id="__next"]/div[1]/div[2]/main/div/div[2]/div/div[2]/div[2]/div[2]/div/div/div/div[${index}]/div[2]/p
        ${emailColumnText}=    Get Text    ${emailColumn}
        IF  '${emailColumnText}' == '${emailAddress}'
            Log To Console    yo
            ${name}=    Get Text    xpath=//*[@id="__next"]/div[1]/div[2]/main/div/div[2]/div/div[2]/div[2]/div[2]/div/div/div/div[${index}]/div[1]/div/div[2]/a[1]
            ${display-role}=    Get Text    xpath=//*[@id="__next"]/div[1]/div[2]/main/div/div[2]/div/div[2]/div[2]/div[2]/div/div/div/div[${index}]/div[3]/div/p
            ${display-plan}=    Get Text    xpath=//*[@id="__next"]/div[1]/div[2]/main/div/div[2]/div/div[2]/div[2]/div[2]/div/div/div/div[${index}]/div[4]/h6
            Should Be Equal As Strings    ${name}    ${firstN} ${lastN}
            Should Be Equal As Strings    ${display-role}    ${roleValue}
            Should Be Equal As Strings    ${display-plan}    ${planValue}
        END
        
    END
    
    
    Run Keyword If    ${is-next-page-available}
    ...    Click Element    ${next-page}
    END
Get Count On Data Paging
    #จำนวนแถว
    ${rowsPerPage}=    Get Text    ${rows-per-page}
    #เอาไป loop ต้อง +1
    ${loopIndexCount}=    Evaluate    ${rowsPerPage}+1
    #หาจำนวน Data ที่ Search เจอ
    ${textOfData}=    Get Text   ${nums-of-data}
    #Split ด้วย of
    ${splitTextOfData}=    Split String    ${textOfData}    of
    #เอามาแค่ 1-x
    ${rangeOfCurrentData}=    Set Variable   ${splitTextOfData}[0]
    ${numDataz}=    Set Variable    ${splitTextOfData}[1]
    
    #Split ด้วย –
    ${splitRangeOfCurrentData}=    Split String    ${rangeOfCurrentData}    –
    #ได้จำนวน Data ในหน้าปัจจุบัน + เพิ่มไว้ loop count
    ${actualNumsOfData}=    Set Variable   ${splitRangeOfCurrentData}[1]-${splitRangeOfCurrentData}[0]+2
    #ได้จำนวน Data ในหน้าปัจจุบัน
    ${actualNumsOfData2}=    Evaluate    ${splitRangeOfCurrentData}[1]-${splitRangeOfCurrentData}[0]+1
    IF  ${numDataz} == 0
        RETURN    0
    ELSE
        RETURN    ${actualNumsOfData}    ${actualNumsOfData2}
    END

Change Rows Per Page and Verify
    Click Search Button
    Wait Until Element Is Visible    ${rows-per-page}
    Click Element    ${rows-per-page}
    Wait Until Element Is Visible    ${25-rows-per-page}
    Click Element    ${25-rows-per-page}
    #Verify that table shown as 25 rows per page
    Wait Until Element Is Visible    ${1-25-text}
    
    ${is-next-page-available}=    Set Variable    ${True}
    WHILE  ${is-next-page-available}
        ${is-next-page-available}=    Run Keyword And Return Status    Element Should Be Visible    ${next-page}
        #Wait Until Element Is Visible    ${first-column-in-table}
        ${numOfDataForLoop}    ${actualNumOfData}=    Get Count On Data Paging
        FOR  ${index}  IN RANGE     1    ${numOfDataForLoop}
            ${data-row}=    Set Variable    xpath=//*[@id="__next"]/div[1]/div[2]/main/div/div[2]/div/div[2]/div[2]/div[2]/div/div/div/div[${index}]
            Wait Until Element Is Visible    ${data-row}
            Log To Console    ${data-row}
        END
    Run Keyword If    ${is-next-page-available}
    ...    Click Element    ${next-page}    
    END
    
    

Click Sign Up and Back to Home Page
    #Click Sign Up and Back to Login Page
    Wait Until Element Is Visible    ${signup-adduser}
    Click Element    ${signup-adduser}
    #Register Success
    Wait Until Element Is Visible    ${register-success}
    Click Element    ${register-success}
    Wait Until Element Is Visible    ${register-success-ok}
    Click Element    ${register-success-ok}
    Wait Until Element Is Visible    ${user_text_home_page}

Input Register Add User
    [Arguments]    ${firstN}    ${lastN}    ${emailAddress}    ${locator-role}    ${locator-plan}
    Run Keyword If  '${TEST_NAME}' == 'Add Account'  Click Create Account
    #firstname
    Wait Until Element Is Visible    ${firstname}
    Input Text    ${firstname}    ${firstN}
    #lastname
    Wait Until Element Is Visible    ${lastname}
    Input Text    ${lastname}    ${lastN}
    #email
    Wait Until Element Is Visible    ${email-signup}
    Input Text    ${email-signup}    ${emailAddress}
    #password
    Wait Until Element Is Visible    ${password-signup}
    Input Text    ${password-signup}    1234567890
    #mobile phone
    Wait Until Element Is Visible   ${mobilePhone-signup} 
    Input Text    ${mobilePhone-signup}    08222222222
    #Gender
    Wait Until Element Is Visible    ${gender-label-adduser}
    Select Radio Button    ${gender-groupname}    ${gender-male-value}
    Radio Button Should Be Set To    ${gender-groupname}    ${gender-male-value}
    #Checkbox
    Wait Until Element Is Visible    ${checkbox-label-adduser}
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
    Wait Until Element Is Visible    ${locator-role}
    Click Element    ${locator-role}
    #Plan
    Wait Until Element Is Visible    ${plan-listbox}
    Click Element    ${plan-listbox}
    Wait Until Element Is Visible    ${locator-plan}
    Click Element    ${locator-plan}

Input Register No Required Field
    Wait Until Element Is Visible    ${add-user-btn}
    Click Element    ${add-user-btn}
    Wait Until Element Is Visible    ${signup-adduser}
    Click Element    ${signup-adduser}

    #check required
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

Input Register Email Invalid
    [Arguments]    ${emailAddress}    ${isFirstLoop}=${False}
    IF  ${isFirstLoop}
        Login Admin User
        Wait Until Element Is Visible    ${add-user-btn}
        Click Element    ${add-user-btn}
    END
    Wait Until Element Is Visible    ${email-signup}
    Input Text    ${email-signup}    ${emailAddress}
    Wait Until Element Is Visible    ${signup-adduser}
    Click Element    ${signup-adduser}
    Wait Until Element Is Visible    ${email-invalid}
    Clear Text    ${email-signup}