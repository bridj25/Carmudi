*** Settings ***
Documentation    A resource file with reusable keywords and variables.

Resource    PageResource.robot
Library     String
Library     DateTime
Library     Collections
Library     Selenium2Library                timeout=40



*** Variables ***
#******************************** IPs and URLs *********************************
${URL}    https://www.carmudi.com.ph/all
${BROWSER}		 Chrome
#${BROWSER}		 Firefox
${priceRangeFrom}          3000000
${priceRangeTo}            4000000


*** Keywords ***
Open Page
    Open Browser                     ${URL}            ${BROWSER}
    Maximize Browser Window

Check Sorting	
    [Arguments]                ${list}                     ${list_count}       ${order}
    :FOR                       ${i}                        IN RANGE            0              ${list_count}-1
    \  ${x}=                   Evaluate                    ${list}[${i}]
    \  ${y}=                   Evaluate                    ${list}[${i}+1]
    \  Run Keyword If          "${order}"=="ascending"     Should Be True      "${x}" <= "${y}"
    \  ...  ELSE IF            "${order}"=="descending"    Should Be True      "${x}" >= "${y}"
    \  ...  ELSE               FAIL                        Invalid order name "${order}". Should be "ascending" or "descending" only