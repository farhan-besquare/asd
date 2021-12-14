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
Buy Rise Contract (Task 2)
    wait until page contains element    xpath=//*[@class="acc-switcher__wrapper acc-switcher__wrapper--enter-done"]     30
    wait until page does not contain element    xpath=//*[@class="chart-container__loader"]     30
    click element   xpath=//*[@class="stx-subholder"]
    click element   xpath=//*[@class="cq-symbol-select-btn"]
    click element   xpath=//*[text()="Synthetic Indices"]
    click element   xpath=//*[text()="Volatility 10 (1s) Index"]
    wait until page does not contain element    xpath=//*[@class="chart-container__loader"]     30
    click element   id=dt_purchase_call_button
Buy Lower Contract (Task 3)
    wait until page contains element    xpath=//*[@class="dc-result__caption-wrapper"]      30
    click element   xpath=//*[@class="cq-symbol-select-btn"]
    click element   xpath=//*[text()="Forex"]
    click element   xpath=//*[text()="AUD/USD"]
    wait until page does not contain element    xpath=//*[@class="chart-container__loader"]
    click element   id=dt_contract_dropdown
    wait until page contains element    xpath=//*[@class="contract-type-dialog contract-type-dialog--enterDone"]
    click element   id=dc_all_link
    click element   id=dt_contract_high_low_item
    click element   xpath=//*[@class="dc-input__field"]
    wait until page contains element    xpath=//*[@class="dc-datepicker__picker dc-datepicker__picker--left dc-datepicker__picker--enter-done dc-datepicker__picker--left-enter-done"]
    click element   xpath=//*[@data-duration="2 Days"]
    click element   id=dc_payout_toggle_item
    ${current_value}=   get element attribute      id=dt_amount_input   value
    ${value_length}=    get length      ${current_value}
    repeat keyword      ${value_length}    press keys      id=dt_amount_input      BACKSPACE
#    repeat keyword      1       press keys      id=dt_amount_input       PLUS
#    click element   id=dt_amount_input
#    press keys      id=dt_amount_input     BACKSPACE
#    press keys      id=dt_amount_input     BACKSPACE
    input text      id=dt_amount_input     text=15.50
    wait until page does not contain element    xpath=//*[@class="trade-container__fieldset-wrapper trade-container__fieldset-wrapper--disabled"]
    click element   id=dt_purchase_put_button
Check Relative Barrier Error (Task 4)
#    click element   id=dt_barrier_1_input
    ${current_value}=   get element attribute      id=dt_barrier_1_input   value
    ${value_length}=    get length      ${current_value}
    repeat keyword      ${value_length}    press keys      id=dt_barrier_1_input      BACKSPACE
    repeat keyword      1       press keys      id=dt_barrier_1_input       +1
#    press keys      id=dt_barrier_1_input      CTRL+ARROW_LEFT
#    input text      id=dt_barrier_1_input       text=+
    wait until page contains        Contracts more than 24 hours in duration would need an absolute barrier        30
    wait until page contains element    xpath=//*[@class="trade-container__fieldset-wrapper trade-container__fieldset-wrapper--disabled"]       30
Check Multiplier Contract Parameter (Task 5)
    click element   xpath=//*[@class="cq-symbol-select-btn"]
    click element   xpath=//*[text()="Synthetic Indices"]
    click element   xpath=//*[text()="Volatility 50 Index"]
    wait until page does not contain element    xpath=//*[@class="chart-container__loader"]
    click element   id=dt_contract_dropdown
    wait until page contains element    xpath=//*[@class="contract-type-dialog contract-type-dialog--enterDone"]
    click element   id=dc_all_link
    click element   id=dt_contract_multiplier_item
    element text should be      xpath=//*[@class="trade-container__fieldset-info trade-container__fieldset-info--left"]     Stake








