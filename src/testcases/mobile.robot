***Settings***
Library  AppiumLibrary
Variables    ${CURDIR}/device.yaml



***Test Cases***
Buy something
    Open Saucelab Application
    Input Username
    Input Password
    Click Login
    Wait Until Element Is Visible    locator=android=new UiSelector().description("test-Cart drop zone").childSelector(new UiSelector().text("PRODUCTS"))    timeout=5s
    Wait Until Element Is Visible    locator=accessibility_id=test-Menu    timeout=5s
    Click Element    locator=accessibility_id=test-Menu
    Wait Until Element Is Visible    locator=accessibility_id=test-WEBVIEW    timeout=5s
    Click Element    locator=accessibility_id=test-WEBVIEW
    Input Text    locator=accessibility_id=test-enter a https url here...    text=https://www.google.com    
    Wait Until Element Is Visible    locator=accessibility_id=test-GO TO SITE    timeout=5s
    Click Element    locator=accessibility_id=test-GO TO SITE
    Sleep    3s
    Wait Until Element Is Visible    locator=android=new UiSelector().resourceId("tsf").childSelector(new UiSelector().className("android.widget.EditText"))    timeout=5s
    Input Text    locator=android=new UiSelector().resourceId("tsf").childSelector(new UiSelector().className("android.widget.EditText"))    text=robot framework
    Click Element    locator=android=new UiSelector().resourceId("tsf").childSelector(new UiSelector().text("ค้นหาด้วย Google"))
    Press Keycode    66
    Swipe    1000    1000    1000    500
    Swipe    1000    1000    1000    500
    Swipe    1000    1000    1000    500
    Wait Until Page Contains    text=Robot Framework
    Sleep    5s
    [Teardown]    Close Application



***Keywords***
Open Saucelab Application
    Open Application    ${REMOTE_URL}    &{ANDROID_DEVICE}

Input Username
    Wait Until Element Is Visible    locator=accessibility_id=test-Username    timeout=5s
    Input Text    locator=accessibility_id=test-Username    text=${USERNAME}

Input Password
    Wait Until Element Is Visible    locator=accessibility_id=test-Password    timeout=5s
    Input Text    locator=accessibility_id=test-Password    text=${PASSWORD}

Click Login
    Wait Until Element Is Visible    locator=accessibility_id=test-LOGIN    timeout=5s
    Click Element    locator=accessibility_id=test-LOGIN