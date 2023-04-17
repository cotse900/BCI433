# Overview
- With the basis of lab 5, we make updates and complete lab 6.
- Last time, we had ```PAYSUMMARY```, ```PAYPRT1```, ```NIGHTS```, ```PAYROLLPGM```
- This time, we do
1. The other logical files ```AFTS```, ```DAYS```, ```ALLSHIFTS``` (not listed in the lab file)
2. Update PAYROLLPGM as ```PAYROLLPG2```
3. Update PAYRPT1 as ```PAYPRT2```
4. Write a new CLLE driver program named ```RUNPAYPGM2```
5. Literally copy PAYROLLPG2 and rename it as ```PAYROLLPG3```
6. Change the ```CALL``` lines in RUNPAYPGM2 as ```CALLPRC``` which now calls PAYROLLPG3 instead, and CALLPRC is a static call instead of a dynamic call.
7. Finally, compile RUNPAYPGM3 AND PAYROLLPG3 as modules, and, collectively, compile both of them in one module called ```PAYROLL```.
- This is the only time you use ```CRTCLMOD``` among all labs.
- In all other labs, you only do dynamic calls and only one other module.
