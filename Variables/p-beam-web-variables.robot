*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}                       https://automate-test.stpb-digital.com/login/
${Browser}                   gc
${email}                     user.test@krupbeam.com
${password}                  123456789
${input_email}               xpath=//*[@id="email"]
${input_password}            name=password
${login_btn}                 xpath=//*[@id="btn-login"]
${user_text_home_page}       xpath=//*[@id="__next"]/div[1]/div[1]/div/div[3]/div/ul/li[2]/a/div[2]/p
${create_account_href}       xpath=//a[text()='Create an account']
${welcome_to_kru_p_beam}     xpath=//h5[contains(text(), 'Welcome to Kru')]
${password_must_more_than_5}  xpath=//p[text()='password must be at least 5 characters']
${beam_valid_email}          xpath=//input[@value='Beam1234@gmail.com' and @id='email']
${email_must_be_valid}    xpath=//p[text()='email must be a valid email']
${email_is_a_required_field}    xpath=//p[text()='email is a required field']
${email_or_password_invalid}    xpath=//p[text()='Email or Password is invalid']

${firstname}                 id=firstname
${lastname}                  id=lastname
${email-signup}              id=email
${password-signup}           id=password
${mobilePhone-signup}        id=mobile-phone
${gender-groupname}          validation-basic-radio
${gender-label-locator}      xpath=//*[@id="__next"]/div[1]/div/div/div/div/div/div/form/div[6]/div
${gender-label-adduser}      xpath=//*[@id="__next"]/div[1]/div[2]/main/div/div[3]/div/div/div/form/div[6]/div
${gender-male-value}         male
${gender-female-value}       female
${nationality-listbox}       xpath=//div[@id='nationality']
${nationality-thai}          xpath=//*[@id="menu-"]/div[3]/ul/li[221]
${role-listbox}              xpath=//div[@id='select-role']
${role-admin}                xpath=//*[@id="menu-"]/div[3]/ul/li[1]
${plan-listbox}              xpath=//div[@id='select-plan']
${plan-basic}                xpath=//*[@id="menu-"]/div[3]/ul/li[1]
${signup-btn}                xpath=//*[@id="btn-sign-up"]
${signup-adduser}            //*[@id="__next"]/div[1]/div[2]/main/div/div[3]/div/div/div/form/button
${checkbox-label-locator}    xpath=//*[@id="__next"]/div[1]/div/div/div/div/div/div/form/div[7]/div
${checkbox-label-adduser}    xpath=//*[@id="__next"]/div[1]/div[2]/main/div/div[3]/div/div/div/form/div[7]/div
${checkbox-sql}              name=courses.SQL
${checkbox-testManual}       name=courses.Test Manual
${checkbox-automateTest}     name=courses.Automate Test
${checkbox-automateTest2}    name=courses.Automate Test2
${register-success}          xpath=//p[text()='Register Success']
${register-success-ok}       xpath=//*[@id="btn-ok"]
${reset-information}         id=reset

${firstname-required}        xpath=//*[@id="error-firstname"]
${lastname-required}         xpath=//*[@id="error-lastname"]
${password-required}         xpath=//*[@id="error-password"]
${email-required}            xpath=//*[@id="error-email"]
${email-invalid}             xpath=//p[text()='Invalid email address']
${mobilePhone-required}      xpath=//*[@id="error-mobile-phone"]
${gender-required}           xpath=//*[@id="validation-basic-gender"]
${checkbox-required}         xpath=//*[@id="validation-basic-courses"]
${nationality-required}      xpath=//*[@id="validation-basic-nationality"]
${role-required}             xpath=//*[@id="validation-role"]
${plan-required}             xpath=//*[@id="validation-plan"]

${role-filter}    xpath=//*[@id="select-role"]
${plan-filter}    xpath=//*[@id="select-plan"]
${status-filter}    xpath=//*[@id="select-status"]
${search-btn}    //*[@id="btn-search"]
${add-user-btn}    xpath=//*[@id="__next"]/div[1]/div[2]/main/div/div[2]/div/div[1]/div/a
${profile-display}    xpath=//*[@id="__next"]/div[1]/div[2]/header/div/div/div[2]/span/div/img
${logout-element}    xpath=/html/body/div[3]/div[3]/ul/li
${clear-btn}    xpath=//*[@id="btn-clear"]
${noti-icon}    xpath=//*[@id="__next"]/div[1]/div[2]/header/div/div/div[2]/button
${noti-box-ul}    xpath=/html/body/div[3]/div[3]/ul
${read-all-noti-btn}    xpath=/html/body/div[3]/div[3]/ul/li[2]/button

${role-admin-filter}    xpath=//*[@id="option-select-role-1"]
${rows-per-page}    xpath=/html/body/div[1]/div[1]/div[2]/main/div/div[2]/div/div[2]/div[3]/div/div[2]/div/div[2]/div
${25-rows-per-page}    xpath=//*[@id="menu-"]/div[3]/ul/li[2]
${1-25-text}    xpath=//p[@class='MuiTablePagination-displayedRows css-196rrgv' and contains(text(), '1–25')]
${nums-of-data}    xpath=//*[@id="__next"]/div[1]/div[2]/main/div/div[2]/div/div[2]/div[3]/div/div[2]/div/p[2]
${next-page}    xpath=//button[@title="Go to next page" and not(@disabled)]
${no-rows-display}    xpath=//*[@style='width: auto; height: 100px; min-height: 100%;']
${first-column-in-table}    xpath=//*[@data-id='1']