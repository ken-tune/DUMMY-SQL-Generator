import module namespace generate-lib = "http://marklogic.com/SYTYCD/generate-lib" at "/generate-lib.xqy";

declare variable $schema-file := "c:\temp\sytycd.schema.sql";

declare variable $table-config := 
<root>
    <schema-name>SYTYCD</schema-name>
    <table rows="10">
        <table-name>CUSTOMER</table-name>
        <pkey>auto</pkey>
        <fields>
            <fkey content="counter:0">ADDRESS</fkey>
            <fkey content="range:1,10">BRANCH</fkey>
            <field content="/first-name.csv[2]">TITLE</field>
            <field content="/first-name.csv[3]">FIRST_NAME</field>
            <field random="W">INITIAL</field>
            <field content="/surname.csv[1]">SURNAME</field>
            <field content="/postcodes.csv[10]|random: dddddd">HOME_PHONE</field>
            <field content="random:07ddd dddddd">MOBILE_PHONE</field>
            <field content="/first-name.csv[3]|.|/surname.csv[1]|@|/domain.csv[1]">EMAIL</field>
            <field content="/maiden-name.csv[1]">MOTHERS_MAIDEN_NAME</field>
            <field content="range:1,28|/|range:1,12|/|range:1943,1970">DATE_OF_BIRTH</field>
            <field content="/first-name.csv[1]">GENDER</field>       
            <field content="random:WW dd dd dd W">NATIONAL-INSURANCE-NO</field>
            <field content="/occupation.csv[1]">OCCUPATION</field>                 
        </fields>
    </table>
    <table rows="13">
        <table-name>ADDRESS</table-name>
        <pkey>auto</pkey>
        <fields>
            <field content="range:1,80| |/roads.csv[1]">LINE_1</field>
            <field content="/postcodes.csv[6]">LINE_2</field>
            <field content="/postcodes.csv[7]">LINE_3</field>            
            <field content="/postcodes.csv[1]| |random:dWW">POSTCODE</field>
        </fields>
    </table>
    <table rows="3">
        <table-name>BRANCH</table-name>
        <pkey>auto</pkey>
        <fields>
            <fkey content="counter:100">ADDRESS</fkey>
            <fkey content="range:1,1">BANK</fkey>
        </fields>        
    </table>
    <table> 
        <table-name>TRANSACTION-TYPE</table-name>
        <pkey>auto</pkey>
        <enum>        
            <val>DirectDebit</val>
            <val>Payment</val>
            <val>CashWithdrawl</val>
            <val>Deposit</val>
        </enum>
    </table>
    <table> 
        <table-name>ACCOUNT-STATUS-TYPE</table-name>
        <pkey>auto</pkey>
        <enum>        
            <val>Active</val>
            <val>Closed</val>
        </enum>
    </table>    
    <table> 
        <table-name>ACCOUNT-TYPE</table-name>
        <pkey>auto</pkey>
        <enum>        
            <val>Current</val>
            <val>Savings</val>
        </enum>
    </table>        
    <table rows="10">
        <table-name>ACCOUNT</table-name>
        <pkey>auto</pkey>
        <fields>
            <field content="/sort-codes.csv[1]">SORT-CODE</field>
            <field content="random:dddddddd">ACCOUNT-NUMBER</field>
            <fkey content="weighted:1:9,2:1">ACCOUNT-STATUS</fkey>
            <fkey content="weighted:1:4,2:1">ACCOUNT-TYPE</fkey>
            <fkey content="counter:0">CUSTOMER</fkey>
            <field content="range:-100,1000|.|random:dd">BALANCE</field>
        </fields>
    </table>
    <table>
        <table-name>TRANSACTION</table-name>
        <pkey>auto</pkey>
        <fields>
            <fkey>ACCOUNT-NUMBER</fkey>
            <fkey>MERCHANT</fkey>
            <fkey>TRANSACTION-TYPE</fkey>
            <field>TRANSACTION-DATE</field>
            <field>TRANSACTION-AMOUNT</field>
        </fields>
    </table>
    <table>
        <table-name>MERCHANT</table-name>
        <pkey>auto</pkey>
        <enum>
            <val>Sainsburys</val>
            <val>Tesco</val>
            <val>Shell</val>
            <val>Waterstones</val>
            <val>Amazon</val>
            <val>John Lewis</val>
        </enum>
    </table>
    <table>
        <table-name>BANK</table-name>
        <pkey>auto</pkey>
        <enum>
            <val>National Kensington Bank</val>
        </enum>
    </table>
    <table>
        <table-name>POLICY-TYPE</table-name>
        <pkey>auto</pkey>
        <enum>
            <val>Car</val>
            <val>Home</val>
            <val>Life</val>
        </enum>
    </table>    
    <table>
        <table-name>POLICY</table-name>
        <pkey>POLICY-ID</pkey>
        <fields>
            <fkey content="1">POLICY-TYPE</fkey>
            <field content="function:dateLastYear,DUMMY">START-DATE</field>
            <field content="function:add-one-year,START-DATE">END-DATE</field>
            <field content="range:1,500|.|random:dd">PREMIUM</field>
        </fields>
    </table>  
    <table>
        <table-name>CAR-POLICY</table-name>
        <pkey>auto</pkey>
        <fields>
            <fkey>POLICY</fkey>
            <field>MAKE</field>
            <field>MODEL</field>
            <field>REGISTRATION</field>            
        </fields>
    </table>     
    <table>
        <table-name>MORTGAGE-TYPE</table-name>
        <pkey>auto</pkey>
        <enum>
            <val>Fixed</val>
            <val>Floating</val>
        </enum>
    </table>                
    
    <!-- Policy type 1 = Car --> 
    <data rows="10">
        <table-name>POLICY</table-name>
        <pkey content="counter:0">POLICY-ID</pkey>
        <fields>
            <fkey content="1">POLICY-TYPE</fkey>
            <fkey content="unique-id-from-map:">CUSTOMER</fkey>
            <field content="function:dateLastYear,DUMMY">START-DATE</field>
            <field content="function:add-one-year,START-DATE">END-DATE</field>
            <field content="range:1,500|.|random:dd">PREMIUM</field>
        </fields>
    </data>   
    <data rows="10">
        <table-name>CAR-POLICY</table-name>
        <pkey>auto</pkey>
        <fields>
            <fkey content="counter:0">POLICY</fkey>
            <field content="/car-make-model.csv[1]">MAKE</field>
            <field content="/car-make-model.csv[2]">MODEL</field>
            <field content="random:WW0d WWW">REGISTRATION</field>            
        </fields>
    </data>         
    <!-- Policy type 2 - home insurance -->
    <data rows="5">
        <table-name>POLICY</table-name>
        <pkey content="counter:10">POLICY-ID</pkey>
        <fields>
            <fkey content="2">POLICY-TYPE</fkey>
            <fkey content="unique-id-from-map:">CUSTOMER</fkey>            
            <field content="function:dateLastYear,DUMMY">START-DATE</field>
            <field content="function:add-one-year,START-DATE">END-DATE</field>
            <field content="range:1,500|.|random:dd">PREMIUM</field>
        </fields>
    </data>   
    <data rows="5">
        <table-name>POLICY</table-name>
        <pkey content="counter:15">POLICY-ID</pkey>
        <fields>
            <fkey content="3">POLICY-TYPE</fkey>
            <fkey content="unique-id-from-map:">CUSTOMER</fkey>            
            <field content="function:dateLastYear,DUMMY">START-DATE</field>
            <field content="function:add-one-year,START-DATE">END-DATE</field>
            <field content="range:1,500|.|random:dd">PREMIUM</field>
        </fields>
    </data>       
    <table rows="4">
        <table-name>MORTGAGE</table-name>
        <pkey>MORTGAGE-NUMBER</pkey>
        <fields>
            <fkey content="unique-id-from-map:">CUSTOMER</fkey>
            <fkey content="table-lookup:CUSTOMER,ADDRESS">ADDRESS</fkey>
            <fkey content="weighted:1:3,2:2">MORTGAGE-TYPE</fkey>
            <field content="function:dateLastThirtyYears">START-DATE</field>
            <field content="function:mortgageEndDate,START-DATE">END-DATE</field>
            <field content="function:interestRate,START-DATE">RATE</field>            
        </fields>
    </table>        
</root>;

let $null := xdmp:eval('import module namespace bespoke = "http://marklogic.com/SYTYCD/bespoke-generation" at "/bespoke.xqy"; 
declare variable $schema as element(root) external;
bespoke:create-sort-codes($schema)',

    (xs:QName("schema"),$table-config))
let $text := text{
    generate-lib:get-header($table-config),
    for $table in $table-config/table
    return
    generate-lib:create-table-statement($table),
    for $table in $table-config/table
    return
    generate-lib:insert-statements($table),
    for $table in $table-config/data
    return
    generate-lib:insert-statements($table)
    
    
}
return
xdmp:save($schema-file,$text),
$table-config//table-name/text()