*** Settings ***
Documentation    A resource file of locators (xpaths).


*** Variables ***
${clearFilters}             xpath=//a[@class="black reset-results"]
${applyFilter}              xpath=//a[@class="button refresh-results expand" and contains(text(),"Apply filters")]
${vehicleColapse}           xpath=//div[@class="title" and contains(text(),"Vehicles")]
${priceColapse}             xpath=//div[@class="title" and contains(text(),"Price")]
${priceRangeFromInputbox}   xpath=//input[@placeholder="From:" and @data-min-value="price"]
${priceRangeToInputbox}     xpath=//input[@placeholder="To:" and @data-max-value="price"]
${vihecleDisplaybox}        //div[@class="catalog-listing-item row image-loaded"]
${saveSearchButton}         xpath=//a[@class="button save-search-button"]
${sortDropDown}             xpath=//a[@data-dropdown="sort-dropdown"]
${dropDownList}             xpath=//ul[@id="sort-dropdown"]
${priceLowestFirst}         xpath=//ul[@id="sort-dropdown"]/li[3]/a  
${priceHighestFirst}        xpath=//ul[@id="sort-dropdown"]/li[4]/a