# Overview
- Depending on class arrangement, you will eventually have a lab on user-defined functions which are literally a replacement of subroutines but using another new thing called prototypes.
- You will rewrite one prior lab and use UDFs instead of subroutines.
- Again, like some prior labs, you will copy display files and some other partial code to work on.

## EBSDIC
```
DCL-PI Main ExtPgm('ORDERSSQLH');
  LimitIn Packed(15:5);
END-PI;   
```
The justification is that, when typing ```call ORDERSSQLH```, it takes EBSDIC code which needs more data length than just ASCII.
