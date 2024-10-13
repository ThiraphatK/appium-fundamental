***Settings***
Resource     ${CURDIR}/../import/import.resource

***Keywords***
Open Saucelab Application
    [Arguments]    ${remote_url}    ${andriod_device}    ${user_name}    ${password}
    Open Application    ${remote_url}    &{andriod_device}
    Input Username    ${user_name}
    Input Password    ${password}
    Click Login

Input Username
    [Arguments]    ${user_name}
    Wait Until Element Is Visible    locator=accessibility_id=test-Username    timeout=5s
    Input Text    locator=accessibility_id=test-Username    text=${USERNAME}

Input Password
    [Arguments]    ${password}
    Wait Until Element Is Visible    locator=accessibility_id=test-Password    timeout=5s
    Input Text    locator=accessibility_id=test-Password    text=${PASSWORD}

Click Login
    Wait Until Element Is Visible    locator=accessibility_id=test-LOGIN    timeout=5s
    Click Element    locator=accessibility_id=test-LOGIN