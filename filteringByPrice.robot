*** Settings ***
Documentation    A test suite for testing Filtering by Price

Resource          PageResource.robot
Resource          resources.robot

Suite Setup       Run Keywords		Open Page 
#Suite Teardown    Close All Browsers



*** Test Cases ***
Filter Price Default
     Wait Until Element Is Visible       ${clearFilters} 
     Click Element                       ${vehicleColapse}
     Click Element                       ${priceColapse}
     Page Should Contain Element         ${priceRangeFromInputbox}
     Page Should Contain Element         ${priceRangeToInputbox}
     Wait Until Element Is Visible       ${priceRangeFromInputbox}
     Input Text							 ${priceRangeFromInputbox}        ${priceRangeFrom} 
     Input Text							 ${priceRangeToInputbox}          ${priceRangeTo}
     Click Element                       ${applyFilter}
     Wait Until Element Is Visible       ${saveSearchButton} 
     Sleep    20s
      Location Should Be                  ${URL}/price:${priceRangeFrom}-${priceRangeTo}/?sort=suggested
     ${numberOfDisplay}=                 Get Matching Xpath Count          ${vihecleDisplaybox}
     :FOR       ${item}                  IN RANGE         ${numberOfDisplay}    0    -1
	  \  ${VehiclePrice}=                 Get Text		  xpath=${vihecleDisplaybox}[${item}]/div[3]//h4/a
      \  ${VehiclePrice}=                 Remove String    ${VehiclePrice}   ,
      \  ${VehiclePrice}=                 Remove String    ${VehiclePrice}   ₱ 
      \  ${priceRange}=                   Evaluate           ${priceRangeFrom} <= ${VehiclePrice} <= ${priceRangeTo}			               
	  \  Should Be True                   ${priceRange}  
	  \  Sleep    2s



Filter Price Lowest First
     Click Element                       ${sortDropDown} 
     Click Element                       ${priceLowestFirst}
     Wait Until Element Is Visible       ${saveSearchButton} 
     Sleep    20s
     Location Should Be                  ${URL}/price:${priceRangeFrom}-${priceRangeTo}/?sort=price-low
     @{priceList}      Create List       ${EMPTY} 
     ${numberOfDisplay}=                 Get Matching Xpath Count          ${vihecleDisplaybox}
     :FOR       ${item}                  IN RANGE         ${numberOfDisplay}    0    -1
	  \  ${VehiclePrice}=                 Get Text		  xpath=${vihecleDisplaybox}[${item}]/div[3]//h4/a
      \  ${VehiclePrice}=                 Remove String    ${VehiclePrice}   ,
      \  ${VehiclePrice}=                 Remove String    ${VehiclePrice}   ₱ 
      \  Append To List                   ${priceList}       ${VehiclePrice}
      \  Log 					${priceList} 
      \  ${priceRange}=                   Evaluate           ${priceRangeFrom} <= ${VehiclePrice} <= ${priceRangeTo}			               
	  \  Should Be True                   ${priceRange}  
	  \  Sleep    2s
     Check Sorting      ${priceList}      ${numberOfDisplay}        ascending

     
Filter Price Highest First
     Click Element                       ${sortDropDown} 
     Click Element                       ${priceHighestFirst} 
     Wait Until Element Is Visible       ${saveSearchButton} 
     Sleep    20s
     @{priceList}      Create List       ${EMPTY} 
     Location Should Be                  ${URL}/price:${priceRangeFrom}-${priceRangeTo}/?sort=price-high
     ${numberOfDisplay}=                 Get Matching Xpath Count          ${vihecleDisplaybox}
     :FOR       ${item}                  IN RANGE         ${numberOfDisplay}    0    -1
	  \  ${VehiclePrice}=                 Get Text		  xpath=${vihecleDisplaybox}[${item}]/div[3]//h4/a
      \  ${VehiclePrice}=                 Remove String    ${VehiclePrice}   ,
      \  ${VehiclePrice}=                 Remove String    ${VehiclePrice}   ₱ 
      \  ${priceRange}=                   Evaluate           ${priceRangeFrom} <= ${VehiclePrice} <= ${priceRangeTo}			               
	  \  Append To List                   ${priceList}       ${VehiclePrice}
      \  Log 					          ${priceList} 
	  \  Should Be True                   ${priceRange}  
	  \  Sleep    2s
      Check Sorting      ${priceList}      ${numberOfDisplay}        descending    


Filter Price Highest First Failing test
	     Click Element                       ${sortDropDown} 
     Click Element                       ${priceLowestFirst} 
     Wait Until Element Is Visible       ${saveSearchButton} 
     Sleep    20s
     @{priceList}      Create List       ${EMPTY} 
     Location Should Be                  ${URL}/price:${priceRangeFrom}-${priceRangeTo}/?sort=price-high	       