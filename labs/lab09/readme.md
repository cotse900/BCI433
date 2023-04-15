# lab9a
- ```PHNREPORT.prtf``` and ```PHONESQL.sqlrpgle```
# lab9b
## EBSDIC
```
DCL-PI Main ExtPgm('ORDERSSQLH');
  LimitIn Packed(15:5);
END-PI;   
```
The justification is that, when typing ```call ORDERSSQLH```, it takes EBSDIC code which needs more data length than just ASCII.
