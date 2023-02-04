# Intro
- My notes are not exhaustive but it can help with reading the long lab files which I think are like appliance manuals.
- These apply to labs in 2023 Winter. Topics do change until the final end of this course.

# lab1
- First, understand this course is about very old formats of a very old OS. Or it works like a separate OS unlike today's OS.
- Library CRTLIB -> object CRTSRCPF -> member CLLE/PPGLE/JAVA/C…
- STRPDM -> library (WRKLIBPDM)/object (WRKOBJPDM) /member (WRKMBRPDM)
- They are all called CL commands
- How to recognize objects of the same name (same userid) by object type:
- BC435Bxx: *USRPRF, *LIB, *MSGQ, *OUTQ
- Current library doesn’t contain another library except qsys
- After you create a program in a library, that program’s type is *PGM

```
Call secondpdm
Call sysvalprg
```

# lab2
- workspace
- compile: rpgle->right click->compile->CRTBNDRPG
- if successful, you can see ```students.*module``` under your personal library (commands log and error list are NOT sufficient) refer to the end of lab2
- library list objects->right click->initial library list, bci433lib, call strjob
- command run: runqry *n students, strsql, rdi students.*file.pf-dta ->right click->show in table->data
- When viewing data in ACS, you can use “shift to column” and enter the column number (say, column 10, column 100…)
- students file with records

# lab3A
- how to call demo and your work 
```
chgcurlib bci433lib
call realestat1
```
```
chgcurlib yourlibrary
call yourwork
```
- some commands to consider if you run into issues: ```wrkoutq``` and ```crtoutq```
- lab3A and lab3B are also important for the midterm.
- how to make your extra F3 disappear: assign the name field for F3 to ```IN79``` which is assigned to the sundry fees when you code the rpgle file.
- where to put ```overlay```: actually only put in the result, and remember not to overlap ```SaleInfo``` and ```Result``` or Result replaces SaleInfo when you click. In other words, when IN79 is off, F3 with ```DSPATR(ND)``` is also off

# lab3B
- how to call demo and your work 
```
chgcurlib bci433lib
call realestat2
```
```
chgcurlib yourlibrary
call yourwork
```
- in your rpgle, write something like a clear subroutine which is practically a function
1. initialize agent rate right after first line
2. 
