*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${email}    id=txtEmail
${password}     id=txtPass
${token_name_input}   xpath=//*[@class="dc-input__field"]
*** Keyword ***
login
    click element    id=dt_login_button
    wait until page contains element    ${email}
    wait until page contains element    ${password}
    input text      //*[@type="email"]     text=farhan@besquare.com.my
    input password  id=txtPass   password=b3gCBKYVtZm7q6d
    click button    //*[@type="submit"]
Check is Selected
    click element      xpath=//*[text()="Read"]
    wait until page contains element    xpath=//*[@class="dc-checkbox__box dc-checkbox__box--active"]
    click element      xpath=//*[text()="Read"]
Token Name Field Only Accept Letters,Numbers and Underscores
    click element   ${token_name_input}
    repeat keyword     2        press keys      ${token_name_input}     @
    wait until page contains        Only letters, numbers, and underscores are allowed.     30
    click element   ${token_name_input}
    repeat keyword     2        press keys      ${token_name_input}     BACKSPACE
Boundary Testing of Token Name
    click element   ${token_name_input}
    input text      ${token_name_input}     A
    page should contain element     xpath=//*[@class="dc-input da-api-token__input dc-input--error"]
    click element   ${token_name_input}
    repeat keyword     33        press keys     ${token_name_input}       A
    page should contain element     xpath=//*[@class="dc-input da-api-token__input dc-input--error"]
Create Token Button Disabled if No Scope Selected
    click element    ${token_name_input}
    repeat keyword     4        press keys      ${token_name_input}     BACKSPACE
    page should contain element     xpath=//*[@disabled]
    page should not contain element     xpath=//*[@class="dc-input da-api-token__input dc-input--error"]
Token Can Be Successfully Created
    click element      xpath=//*[text()="Read"]
    ${current_value}=     get element attribute     ${token_name_input}     value
    ${value_length}=      get length        ${current_value}
    repeat keyword     ${value_length}    press keys        ${token_name_input}        BACKSPACE
    input text       ${token_name_input}        test
    wait until page does not contain element       xpath=//*[@disabled]
    click element       xpath=//*[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large da-api-token__button"]
    wait until page does not contain element        xpath=//*[@class="initial-loader__barspinner--rect barspinner__rect barspinner__rect--5 rect5"]
    table should contain    xpath=//*[@class="da-api-token__table"]     test
Token Can Be Copied
    click element       xpath=//*[@class="dc-icon dc-clipboard da-api-token__clipboard"]
    page should contain element     xpath=//*[@style="--fill-color1:var(--status-success);"]
    click element    ${token_name_input}
    press keys      ${token_name_input}     CTRL+V
    ${token_sample}=    get text       //*[@class="da-api-token__clipboard-wrapper"]
    element attribute value should be      ${token_name_input}     value        ${token_sample}
Token Can Be Deleted
    click element       xpath=//*[@class="dc-btn dc-btn--secondary dc-btn__small"]
    wait until page contains element      xpath=//*[text()="Yes"]     30
    click element       xpath=//*[@id="app_contents"]/div/div/div/div/div[2]/div/div[2]/div/section/div/div/form/div/div[3]/div[2]/div/div/table/tbody/tr/td[5]/div/button[2]
    wait until page does not contain element       //*[@class="da-api-token__table-cell-row"]       30

*** Test Cases ***
Open Deriv
    open browser    url=https://app.deriv.com   browser=chrome
    set window size     1280    1028
    wait until page contains element    id=dt_login_button
    login
    wait until page does not contain element    id=dt_core_header_acc-info-preloader       30
    wait until page contains element    id=dt_core_account-info_acc-info   30
    click element   id=dt_core_account-info_acc-info
    click element   id=real_account_tab
    click element   id=dt_core_account-switcher_demo-tab
    wait until page contains element    xpath=//*[@class="acc-switcher__wrapper acc-switcher__wrapper--enter-done"]     30
    wait until page does not contain element    xpath=//*[@class="chart-container__loader"]     30
    click element   xpath=//*[@class="stx-subholder"]
Task 1
    click element   xpath=//*[@class="account-settings-toggle"]
    wait until page contains element     id=dc_api-token_link       30
    click element   id=dc_api-token_link
    wait until page does not contain element    xpath=//*[@class="initial-loader account__initial-loader"]
    Check is Selected
    Token Name Field Only Accept Letters,Numbers and Underscores
    Boundary Testing of Token Name
    Create Token Button Disabled if No Scope Selected
    Token Can Be Successfully Created
    Token Can Be Copied
    Token Can Be Deleted



