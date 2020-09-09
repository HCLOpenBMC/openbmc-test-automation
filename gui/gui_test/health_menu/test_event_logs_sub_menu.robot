*** Settings ***

Documentation  Test OpenBMC GUI "Event logs" sub-menu.

Resource        ../../lib/resource.robot

Suite Setup     Launch Browser And Login GUI
Suite Teardown  Close Browser
Test Setup      Test Setup Execution


*** Variables ***
${xpath_event_logs_heading}         //h1[text()="Event logs"]

*** Test Cases ***

Verify Navigation To Event Logs Page
    [Documentation]  Verify navigation to Event Logs page.
    [Tags]  Verify_Navigation_To_Event_Logs_Page

    Page Should Contain Element  ${xpath_event_logs_heading}


Verify Existence Of All Sections In Event Logs Page
    [Documentation]  Verify existence of all sections in Event Logs page.
    [Tags]  Verify_Existence_Of_All_Sections_In_Event_Logs_Page

    Page Should Contain  Event logs


*** Keywords ***

Test Setup Execution
    [Documentation]  Do test case setup tasks.

    Click Element  ${xpath_health_menu}
    Click Element  ${xpath_event_logs_sub_menu}
    Wait Until Keyword Succeeds  30 sec  5 sec  Location Should Contain  event-logs
