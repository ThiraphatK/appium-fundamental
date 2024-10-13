***Settings***
Resource     ${CURDIR}/../import/import.resource

***Keywords***
Login to the app
    Wait Until Element Is Visible    locator=accessibility_id=test-Username    timeout=5s
    Input Text    locator=accessibility_id=test-Username    text=${USERNAME}
    Wait Until Element Is Visible    locator=accessibility_id=test-Password    timeout=5s
    Input Text    locator=accessibility_id=test-Password    text=${PASSWORD}
    Wait Until Element Is Visible    locator=accessibility_id=test-LOGIN    timeout=5s
    Click Element    locator=accessibility_id=test-LOGIN