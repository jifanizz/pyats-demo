*** Settings ***
Library        ats.robot.pyATSRobot
Library        genie.libs.robot.GenieRobot
Library        unicon.robot.UniconRobot
Variables      Config.yaml
Suite setup    Setup

*** Variables ***
${testbed}    ./virl-tb.yaml

*** Test Cases ***
Send show version
    ${output}=    execute "show version" on device "xr1"
    Should Contain  ${output}    Version 6.3.1

Verify interface description
    ${output}=    execute "show running interface Lo0" on device "xr1"
    Should Contain  ${output}    Hello


Count ospf neighbor
    ${output}=    execute "show ospf neighbor" on device "xr1"
    Should Contain  ${output}  FULL

Verify bgp all
    ${output}=    execute "show bgp all all" on device "xr1"
    Should match regexp  ${output}  \\*> 11.11.11.11/32\\s+10.111.111.2

*** Keywords ***
Setup
    use genie testbed "${testbed}"
    connect to devices "xr1"
