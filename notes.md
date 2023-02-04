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
- In case you disconnected/turned off your laptop before or sth, I think the best practice is to restart RDi to avoid confusion with saved states/files. It is easy to run into errors.
- RDi is the main thing for use after lab 2. ACS is also called green screen since most texts are green by default. Refer also to my activation file.

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
- For ```DCL-F yourfile workstn;```, do remember to, for instance, have both .dspf and .rpgle files in the same folder, or the rpgle won't detect the dspf file.

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
- F6 is in SaleInfo and in red
- in your rpgle, write something like a clear subroutine which is practically a function
1. initialize agent rate (=5) right after first line, or 0.05 if you prefer not dealing with percentage when calculating costs
2. refer to IN79 above
3. indicators are basically like boolean or flags in C++ or Java. The difference is while IBM has iteration ```ITER``` and subroutine aka function ```BEGSR ENDSR```, it may look a little primitive to you. But think of it this way, Oracle SQL or IBM(!) SQL has no flag to use. I personally did DBS501 with a lot of pain.
