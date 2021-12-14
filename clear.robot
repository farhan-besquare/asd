*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${email}    id=txtEmail
${password}     id=txtPass

*** Keyword ***
login

    click element    id=dt_login_button
    wait until page contains element    ${email}
    wait until page contains element    ${password}
    input text      //*[@type="email"]     text=${test_email}
    input password  id=txtPass   password=${test_pw}
    click button    //*[@type="submit"]

*** Test Cases ***
Open Deriv
    open browser    url=https://app.deriv.com   browser=chrome
    set window size     1280    1028
    wait until page contains element    id=dt_login_button
Login and Switching Accounts (Task 1)
    login
    wait until page does not contain element    id=dt_core_header_acc-info-preloader       30
    wait until page contains element    id=dt_core_account-info_acc-info   30
    click element   id=dt_core_account-info_acc-info
    click element   id=real_account_tab
    click element   id=dt_core_account-switcher_demo-tab
    wait until page contains element    xpath=//*[@class="acc-switcher__wrapper acc-switcher__wrapper--enter-done"]     30
    wait until page does not contain element    xpath=//*[@class="chart-container__loader"]     30
    click element   xpath=//*[@class="stx-subholder"]
Testing
    element text should be      dt_contract_dropdown    Rise/Fall
#    click element       id=dt_amount_input
#    ${current_value}=   Get Element Attribute      id=dt_amount_input   value
#    ${value_length}=    Get Length      ${current_value}
#    repeat keyword      ${value_length}    press keys      id=dt_amount_input      ARROW_LEFT
##    repeat keyword      1       press keys      id=dt_amount_input       +
