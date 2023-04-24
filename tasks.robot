*** Settings ***
Documentation       Template robot main suite.
Library    RPA.Browser.Selenium    auto_close=${FALSE}
Library    RPA.HTTP
Library    RPA.Excel.Files
Library    RPA.Word.Application

*** Tasks ***

Robo da Maria
    Loga na pagina
    Baixar aquivo excel
    Abrir planilha
    Preencher e enviar formulario

*** Keywords ***
Loga na pagina
    Open Available Browser  https://robotsparebinindustries.com/
    Input Text    username    maria
    Input Password    password    thoushallnotpass
    Submit Form

Preencher e enviar formulario
    Open Workbook    SalesData.xlsx
    ${sales_reps} =    Read Worksheet As Table  header=true
    FOR    ${sales_rep}    IN    @{sales_reps}
        Preencher e enviar formulario para uma pessoa  ${sales_rep}
    END
    Close Workbook

Preencher e enviar formulario para uma pessoa 
    [Arguments]    ${sales_rep}
    Wait Until Element Is Visible    firstname
    Input Text    firstname    ${sales_rep}[First Name]
    Input Text    lastname    ${sales_rep}[Last Name]
    Input Text    salesresult    ${sales_rep}[Sales]
    Select From List By Value    salestarget    ${sales_rep}[Sales Target]
    Click Button    Submit

Baixar aquivo excel
    Download  https://robotsparebinindustries.com/SalesData.xlsx  overwrite=true

Abrir planilha
    Open Workbook    SalesData.xlsx
    ${sales_reps} =    Read Worksheet As Table  header=true
    Close Workbook