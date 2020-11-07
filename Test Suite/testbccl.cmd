@echo off
SET TEST=

rem BCCL test script
rem ================
rem Requirements:
rem - Folder testdata with all.json, all.xml, all.csv

rem clean up temp folder
md temp >> NUL:
del temp\*.* /q


Echo Remember Login
BCCL -w "http://bc:7047/BC/WS/CRONUS Canada, Inc./Codeunit/bccl" -u demo -p demo --remember
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

Rem JSON Tests
Rem ==========

Echo putdata json
BCCL -t putdata -s table=80802 -i testdata\all.json > temp\inserted.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

Echo Verify insert
fc testdata\inserted.json temp\inserted.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

Echo getdata json
BCCL -t getdata -s table=80802 -o temp\all.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

Echo Compare Result
fc testdata\all.json temp\all.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

Echo deletedata json
BCCL -t deletedata -s table=80802 -i temp\all.json > temp\deleted.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

Echo Verify delete
fc testdata\deleted.json temp\deleted.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

del temp\*.* /q

Rem XML Tests
Rem ==========

Echo putdata xml
BCCL -t putdata -s table=80802 -i testdata\all.xml -r /BCCL_Test_Table_Hgd/Record > temp\inserted.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

Echo Verify insert
fc testdata\inserted.json temp\inserted.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

Echo getdata xml
BCCL -t getdata -s table=80802 -o temp\all.xml
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

Echo Compare Result
fc testdata\all.xml temp\all.xml
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

Echo deletedata xml
BCCL -t deletedata -s table=80802 -i temp\all.xml -r /BCCL_Test_Table_Hgd/Record > temp\deleted.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

Echo Verify delete
fc testdata\deleted.json temp\deleted.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

del temp\*.* /q

Rem CSV Tests
Rem ==========

Echo putdata csv
BCCL -t putdata -s table=80802 -i testdata\all.csv > temp\inserted.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

echo Verify insert
fc testdata\inserted.json temp\inserted.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

Echo getdata csv
BCCL -t getdata -s table=80802 -o temp\all.csv
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

Echo Compare Result
fc testdata\all.csv temp\all.csv
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

Echo deletedata csv
BCCL -t deletedata -s table=80802 -i temp\all.csv > temp\deleted.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

Echo Verify delete
fc testdata\deleted.json temp\deleted.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

del temp\*.* /q

rem Mapping File Test
Rem =================

Rem JSON Tests (Mapping)
Rem ==========

Echo putdata json (mapping)
BCCL -t putdata -s table=80802 -i testdata\all.json -m testdata\mapping.json > temp\inserted.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

Echo Verify insert (mapping)
fc testdata\inserted.json temp\inserted.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

Echo getdata json (mapping)
BCCL -t getdata -s table=80802 -o temp\all.json -m testdata\mapping.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

Echo Compare Result (mapping)
fc testdata\all.json temp\all.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

Echo deletedata json (mapping)
BCCL -t deletedata -s table=80802 -i temp\all.json -m testdata\mapping.json > temp\deleted.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

Echo Verify delete (mapping)
fc testdata\deleted.json temp\deleted.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

del temp\*.* /q

Rem XML Tests (mapping)
Rem ==========

Echo putdata xml (mapping)
BCCL -t putdata -s table=80802 -i testdata\all.xml -r /BCCL_Test_Table_Hgd/Record -m testdata\mapping.json > temp\inserted.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

Echo Verify insert (mapping)
fc testdata\inserted.json temp\inserted.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

Echo getdata xml (mapping)
BCCL -t getdata -s table=80802 -o temp\all.xml -m testdata\mapping.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

Echo Compare Result (mapping)
fc testdata\all.xml temp\all.xml
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

Echo deletedata xml (mapping)
BCCL -t deletedata -s table=80802 -i temp\all.xml -r /BCCL_Test_Table_Hgd/Record -m testdata\mapping.json > temp\deleted.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

Echo Verify delete (mapping)
fc testdata\deleted.json temp\deleted.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

del temp\*.* /q

Rem CSV Tests (Mapping)
Rem ==========

Echo putdata csv (mapping)
BCCL -t putdata -s table=80802 -i testdata\all.csv -m testdata\mapping.json > temp\inserted.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

echo Verify insert (mapping)
fc testdata\inserted.json temp\inserted.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

Echo getdata csv (mapping)
BCCL -t getdata -s table=80802 -o temp\all.csv -m testdata\mapping.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

Echo Compare Result (mapping)
fc testdata\all.csv temp\all.csv
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

Echo deletedata csv (mapping)
BCCL -t deletedata -s table=80802 -i temp\all.csv -m testdata\mapping.json > temp\deleted.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

Echo Verify delete (mapping)
fc testdata\deleted.json temp\deleted.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

del temp\*.* /q

Rem Dimension Test

:DIMENSION

BCCL -t putdata -s table=348 -i testdata\dimensions.json
BCCL -t putdata -s table=349 -i testdata\dimension-values.json 

echo putdata json (dimension)
bccl -t putdata -i testdata\sales-orders.json -m testdata\table36.map.json -s table=36 > temp\inserted.table36.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

echo Verify insert (dimension)
fc testdata\inserted.table36.json temp\inserted.table36.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

Echo getdata json (dimension)
BCCL -t getdata -s table=36 "view=where(field1=0(1),field3=1(TEST*))" -o temp\sales-orders.json -m testdata\table36.map.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

Echo Compare Result (dimension)
fc testdata\sales-orders.json temp\sales-orders.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

Echo deletedata json (dimension)
bccl -t deletedata -i testdata\sales-orders.json -m testdata\table36.map.json -s table=36 > temp\deleted.table36.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

Echo Verify delete (dimension)
fc testdata\deleted.table36.json temp\deleted.table36.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

echo putdata xml (dimension)
bccl -t putdata -i testdata\sales-orders.xml -m testdata\table36.map.json -s table=36 -r /Sales_Header/Record > temp\inserted.table36.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

echo Verify insert (dimension)
fc testdata\inserted.table36.json temp\inserted.table36.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

Echo getdata xml (dimension)
BCCL -t getdata -s table=36 "view=where(field1=0(1),field3=1(TEST*))" -o temp\sales-orders.xml -m testdata\table36.map.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

Echo Compare Result (dimension)
fc testdata\sales-orders.xml temp\sales-orders.xml
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

Echo deletedata xml (dimension)
bccl -t deletedata -i testdata\sales-orders.xml -m testdata\table36.map.json -s table=36 -r /Sales_Header/Record > temp\deleted.table36.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

Echo Verify delete (dimension)
fc testdata\deleted.table36.json temp\deleted.table36.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

echo putdata csv (dimension)
bccl -t putdata -i testdata\sales-orders.csv -m testdata\table36.map.json -s table=36 > temp\inserted.table36.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

echo Verify insert (dimension)
fc testdata\inserted.table36.json temp\inserted.table36.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

Echo getdata csv (dimension)
BCCL -t getdata -s table=36 "view=where(field1=0(1),field3=1(TEST*))" -o temp\sales-orders.csv -m testdata\table36.map.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

Echo Compare Result (dimension)
fc testdata\sales-orders.json temp\sales-orders.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

Echo deletedata csv (dimension)
bccl -t deletedata -i testdata\sales-orders.csv -m testdata\table36.map.json -s table=36 > temp\deleted.table36.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

Echo Verify delete (dimension)
fc testdata\deleted.table36.json temp\deleted.table36.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

REM Excel Test
rem Making sure the customers are deleted
bccl -t deletedata -s table=18 -i testdata\Customers.xlsx -m testdata\excel-mapping.json -x Customers -y A2..D50  > temp\pre-deleted.excel.json


echo putdata (excel)
bccl -t putdata -s table=18 -i testdata\Customers.xlsx -m testdata\excel-mapping.json -x Customers -y A2..D50 > temp\inserted.excel.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

echo Verify insert (excel)
fc testdata\inserted.excel.json temp\inserted.excel.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

Echo deletedata json (excel)
bccl -t deletedata -s table=18 -i testdata\Customers.xlsx -m testdata\excel-mapping.json -x Customers -y A2..D50  > temp\deleted.excel.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

Echo Verify delete (excel)
fc testdata\deleted.excel.json temp\deleted.excel.json
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

BCCL -t deletedata -s table=348 -i testdata\dimensions.json
BCCL -t deletedata -s table=349 -i testdata\dimension-values.json 

del temp\*.* /q


echo **************************************
echo All tests completed successfully
echo **************************************
SET TEST=SUCCESS

GOTO DONE
:ERROR

echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
echo Error Happend, testing aborted.
echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
SET TEST=FAIL

Rem Try to Clean Up!
BCCL -t deletedata -s table=80802 -i testdata\all.csv
BCCL -t deletedata -i testdata\sales-orders.json -m testdata\table36.map.json -s table=36

:DONE
