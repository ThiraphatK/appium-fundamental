***Settings***
Resource    ${CURDIR}/../keywords/keywords.robot
Variables    ${CURDIR}/../testdata/android.yaml


***Test Cases***
Buy item from shopping app
    # login
    Open Saucelab Application
    Input Username
    Input Password
    Click Login
    Wait Until Element Is Visible    locator=accessibility_id=test-Modal Selector Button    timeout=5s
    # Click Element    locator=accessibility_id=test-Modal Selector Button
    # Wait Until Element Is Visible    locator=android=new UiSelector().text("Name (A to Z)")    timeout=5s
    # Click Element    locator=android=new UiSelector().text("Name (A to Z)")
    
    # find item and click item
    BuiltIn.Wait Until Keyword Succeeds    5x   3s   Run Keywords    
    ...    Swipe    1000    1000    1000    500
    ...    AND    Wait Until Element Is Visible    locator=android=new UiSelector().text("Test.allTheThings() T-Shirt (Red)")    timeout=5s
    ...    AND    Click Element    locator=android=new UiSelector().text("Test.allTheThings() T-Shirt (Red)")
    Wait Until Page Contains    text=Test.allTheThings() T-Shirt (Red)
    
    # click add to cart
    BuiltIn.Wait Until Keyword Succeeds    5x   3s   Run Keywords    
    ...    Swipe    1000    1000    1000    500
    ...    AND    Wait Until Element Is Visible    locator=accessibility_id=test-ADD TO CART    timeout=5s
    ...    AND    Click Element    locator=accessibility_id=test-ADD TO CART
    
    # get price
    ${items_price}=    Get text    locator=accessibility_id=test-Price
    ${items_price}=    String.remove string    ${items_price}    $

    # click cart
    Click Element    locator=accessibility_id=test-Cart
    Wait Until Element Is Visible    locator=accessibility_id=test-REMOVE    timeout=5s
    ${items_count}=  Get text    locator=android=new UiSelector().description("test-Cart").childSelector(new UiSelector().className("android.widget.TextView"))
    # challenge to use fromParent -> ใช้หา element ที่อยู่ใน parent เดียวกันของ element ที่เรากำหนด
    # new UiSelector().description("test-Cart").fromParent(new UiSelector().className("android.widget.TextView"))
    
    # find item in cart and verify price
    Wait Until Page Contains    text=Test.allTheThings() T-Shirt (Red)    timeout=5s
    ${shopping_price}=    Get text    locator=android=new UiSelector().description("test-Price").childSelector(new UiSelector().className("android.widget.TextView"))
    ${shopping_price}=    String.remove string    ${shopping_price}    $
    Should Be Equal As Numbers    ${items_price}    ${shopping_price}

    # checkout
    Wait Until Element Is Visible    locator=accessibility_id=test-CHECKOUT    timeout=5s
    Click Element    locator=accessibility_id=test-CHECKOUT

    #fill form
    Wait Until Element Is Visible    locator=accessibility_id=test-First Name    timeout=5s
    Input text    locator=accessibility_id=test-First Name    text=Robot
    Input text    locator=accessibility_id=test-Last Name    text=Framework
    Input text    locator=accessibility_id=test-Zip/Postal Code    text=10110
    
    # click continue button
    Click Element    locator=accessibility_id=test-CONTINUE

    # verify checkout
    Wait Until Page Contains    text=Test.allTheThings() T-Shirt (Red)    timeout=5s
    ${checkout_price}=    Get text    locator=android=new UiSelector().description("test-Price").childSelector(new UiSelector().className("android.widget.TextView"))
    ${checkout_price}=    String.remove string    ${checkout_price}    $
    Should Be Equal As Numbers    ${items_price}    ${checkout_price}

    # verify price checkout 
    Wait Until Element Is Visible    locator=android=new UiSelector().textContains("Item total:")    timeout=5s
    ${item_total}=    Get text    locator=android=new UiSelector().textContains("Item total:")
    Should Be Equal    Item total: $${items_price}    ${item_total}
    # verify tax
    ${CONSTANT_TAX}=    Set Variable    0.08
    Wait Until Element Is Visible    locator=android=new UiSelector().textContains("Tax:")    timeout=5s
    ${tax}=    Get text    locator=android=new UiSelector().textContains("Tax:")
    ${total}=    Get text    locator=android=new UiSelector().textStartsWith("Total:")
    ${cal_tax}=    Evaluate    round(${items_price}*${CONSTANT_TAX},2)
    ${cal_total}=    Evaluate    round(${items_price}+${cal_tax},2)
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