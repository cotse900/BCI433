# Overview
- This is a rather short lab.
- The main task is to modify a master file based on a transaction file.
1. Using ```STRSQL```, ```CREATE COLLECTION``` + your chosen collection name which is the same as schema in SQL.
2. You will use ```CPYF``` to copy files from ```BCI433LIB/SALESSTAFF``` and ```BCI433LIB/LAB7CODE``` to your collection.
3. SALESSTAFF is the main file to work on.
4. You will write 3 files, which you can copy from the official library, to work with SALESSTAFF, namely a display file, a CLLE driver program, and a RPG.
5. ```UPDREPORT```: The display file is free. Just put your name.
6. ```RUNLAB7```: it contains the above CPYF command which copies files (as above) every time you call this program. 
7. It also does other things including ```OVRPRTF```, ```DSPSPLF``` spooled files, and ```DSPJRN``` journal entries.
8. ```SLSTRNPGM```: most of it, like RUNLAB7, is free code for copying except a few lines.
- It uses the master file and printer file, obviously.
- It has a new feature called ```DCL-DS```, data structure.
- ```FullKey``` is a composite key in SQL by combining, say, two files as a composite primary key.
- The data structures must follow the same column names in order, but in this case excludes the non-CHAR(acter) field phone number.
- We have no EXFMT this time. Just WRITE and READ.
- You will learn additional RPG commands ```%KDS```, ```%FOUND```, ```%DEC```, ```%ERROR```. The rest can look very similar to SQL.
- ```CHAIN %KDS``` is not actually explained in detail but it just means using FULLKEY to see how master file records match the composite key specified so far.
- You already know subroutines by now. In this case, we extract ```PHONE``` (numbers) data and write them into ```SALESTFR```. PHONE is the only non-CHAR column.
