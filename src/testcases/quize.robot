***Settings***
Resource    ${CURDIR}/../import/import.resource
Variables    ${CURDIR}/../testdata/android.yaml

***Test Cases***
Buy 2 items from shopping app
    # open application
    Open Saucelab Application
    # fill username and password
    Input Username
    Input Password
    # login
    Click Login
    Wait Until Element Is Visible    locator=accessibility_id=test-Modal Selector Button    timeout=5s
    # add items to cart
    Add Items To Cart   item_name=Sauce Labs Fleece Jacket
    # add items to cart
    Add Items To Cart    item_name=Sauce Labs Onesie
    # click cart
    Click Element    locator=accessibility_id=test-Cart
    Wait Until Element Is Visible    locator=accessibility_id=test-REMOVE    timeout=5
    # verify items in cart
    Verify Items Count In Cart    expected_count=2
    Verify Items In Cart    item_name=Sauce Labs Fleece Jacket    instance=0    price=49.99
    Verify Items In Cart    item_name=Sauce Labs Onesie     instance=1    price=7.99
    # checkout
    BuiltIn.Wait Until Keyword Succeeds    5x   3s   Run Keywords    
    ...    Swipe    1000    1000    1000    500
    ...    AND    Wait Until Element Is Visible    locator=accessibility_id=test-CHECKOUT    timeout=5s
    ...    AND    Click Element    locator=accessibility_id=test-CHECKOUT
    # fill form
    Wait Until Element Is Visible    locator=accessibility_id=test-First Name    timeout=5s
    Input text    locator=accessibility_id=test-First Name    text=Robot
    Input text    locator=accessibility_id=test-Last Name    text=Framework
    Input text    locator=accessibility_id=test-Zip/Postal Code    text=10110
    # click continue button
    Click Element    locator=accessibility_id=test-CONTINUE

    # verify checkout
    Wait Until Page Contains    text=Sauce Labs Fleece Jacket    timeout=5s
    Verify price checkout    instance=0    items_price=49.99
    Verify price checkout  instance=1  items_price=7.99

    # verify price checkout
    BuiltIn.Wait Until Keyword Succeeds    5x   3s   Run Keywords    
    ...    Swipe    1000    1000    1000    500
    ...    AND    Wait Until Element Is Visible    locator=android=new UiSelector().textContains("Tax:")    timeout=5s

    ${all_items_price}=    Evaluate    49.99+7.99
    Wait Until Element Is Visible    locator=android=new UiSelector().textContains("Item total:")    timeout=5s
    ${item_total}=    Get text    locator=android=new UiSelector().textContains("Item total:")
    Should Be Equal    Item total: $${all_items_price}    ${item_total}
    # verify tax
    ${CONSTANT_TAX}=    Set Variable    0.08
    Wait Until Element Is Visible    locator=android=new UiSelector().textContains("Tax:")    timeout=5s
    ${tax}=    Get text    locator=android=new UiSelector().textContains("Tax:")
    ${total}=    Get text    locator=android=new UiSelector().textStartsWith("Total:")
    ${cal_tax}=    Evaluate    round(${all_items_price}*${CONSTANT_TAX},2)
    ${cal_total}=    Evaluate    round(${all_items_price}+${cal_tax},2)
    Should Be Equal    Tax: $${cal_tax}    ${tax}
    Should Be Equal    Total: $${cal_total}    ${total}

    # click finish button
    BuiltIn.Wait Until Keyword Succeeds    5x   3s   Run Keywords    
    ...    Swipe    1000    1000    1000    500
    ...    AND    Wait Until Element Is Visible    locator=accessibility_id=test-FINISH    timeout=5s
    ...    AND    Click Element    locator=accessibility_id=test-FINISH

    # verify finish
    Wait Until Page Contains    text=THANK YOU FOR YOU ORDER    timeout=5s

    # click back to home
    Wait Until Element Is Visible    locator=accessibility_id=test-BACK HOME    timeout=5s
    Click Element    locator=accessibility_id=test-BACK HOME
    # verify back to home
    Wait Until Element Is Visible    locator=accessibility_id=test-Modal Selector Button    timeout=5s
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

Add Items To Cart
    [Arguments]    ${item_name}
    BuiltIn.Wait Until Keyword Succeeds    5x   3s   Run Keywords    
    ...    Swipe    1000    1000    1000    500
    ...    AND    Wait Until Element Is Visible    locator=android=new UiSelector().text("${item_name}")    timeout=5s
    ...    AND    Click Element    locator=android=new UiSelector().text("${item_name}").fromParent(new UiSelector().description("test-ADD TO CART"))

Verify Items Count In Cart
    [Arguments]    ${expected_count}
    Wait Until Element Is Visible    locator=accessibility_id=test-Cart    timeout=5s
    ${items_count}=  Get text    locator=android=new UiSelector().description("test-Cart").childSelector(new UiSelector().className("android.widget.TextView"))
    ${items_count}=    String.remove string    ${items_count}    $
    Should Be Equal    ${expected_count}    ${items_count}

Verify Items In Cart
    [Arguments]    ${item_name}    ${instance}    ${price}
    Wait Until Page Contains    text=${item_name}    timeout=5s
    ${shopping_price}=    Get text    locator=android=new UiSelector().description("test-Price").instance(${instance}).childSelector(new UiSelector().className("android.widget.TextView"))
    ${shopping_price}=    String.remove string    ${shopping_price}    $
    Should Be Equal As Numbers    ${price}    ${shopping_price}

Verify price checkout
    [Arguments]    ${instance}    ${items_price}
    ${price}=    Get text    locator=android=new UiSelector().description("test-Price").instance(${instance}).childSelector(new UiSelector().className("android.widget.TextView"))
    ${price}=    String.remove string    ${price}    $
    Should Be Equal As Numbers    ${items_price}    ${price}
