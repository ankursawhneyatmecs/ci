*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported Selenium2Library.
Library           Selenium2Library
Library		      BuiltIn

*** Keywords ***	
Open Browser To Page		
    [Arguments]    					${URL}	${BROWSER}	${DELAY}
    Open Browser    				${URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    			${DELAY}

Page Should Be Open		
    [Arguments]    					${URL}	${TITLE}
    Location Should Be    			${URL}
    Title Should Be   				${TITLE}
	
Handle Failed Cases
    Take Screenshot					${TEST NAME}
    Close Application
