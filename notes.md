# Intro
- My notes are not exhaustive but it can help with reading the long lab files which I think are like appliance manuals.
- These apply to labs in 2023 Winter. Topics do change until the final end of this course.

# lab1
- First, understand this course is about very old formats of a very old OS. Or it works like a separate OS unlike today's OS.
- Library CRTLIB -> object CRTSRCPF -> member CLLE/PPGLE/JAVA/C…
- ```STRPDM``` -> library (```WRKLIBPDM```)/object (```WRKOBJPDM```) /member (```WRKMBRPDM```)
- They are all called CL commands
- How to recognize objects of the same name (same userid) by object type:
- BC435Bxx: *USRPRF, *LIB, *MSGQ, *OUTQ
- Current library doesn’t contain another library except qsys
- After you create a program in a library, that program’s type is *PGM

```
Call secondpdm
Call sysvalprg
```
- In case you disconnected/turned off your laptop before or sth, I think the best practice is to restart RDi to avoid confusion with saved states/files. It is easy to run into errors. See also lab files on the subject of RemoteSystemsTempFiles.
- RDi is the main thing for use after lab 2. ACS is also called green screen since most texts are green by default. Refer also to my activation file.

# lab2
- workspace
- compile: rpgle->right click->compile->```CRTBNDRPG```
- if successful, you can see ```students.*module``` under your personal library (commands log and error list are NOT sufficient) refer to the end of lab2
- library list objects->right click->initial library list, bci433lib, ```call strjob```
- command run: ```runqry *n students```, strsql, rdi students.*file.pf-dta ->right click->show in table->data
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

# lab4 / weeks 4-5
- ```chgusrprf```
- ```DSPUSRPRF USRPRF(Lydia_li) TYPE(*ALL) OUTPUT(*PRINT``` (keyword notation)
- ```WRKMBRPDM```
- Check Library QGPL for ```LAB4DSP```, or simply use RDi to know what it is (display file code)
- ```chgcurlib bci433lib```
- ```call lab4cl21``` (It is called Run Water Bill Application) (this is the closest thing in the official library)

# lab5+6 / week 6
- ```ADDLIBLE SENECAPAY``` for lab5, lab6
- ```RUNQRY *N SENECAPAY/SHIFTWEEK``` (check lecture 5)
- directory: SENECAPAY/SHIFTRATE
- write ```PAYROLLPGM .rpgle```, this name
- PAYRPT.prtf is the printer file
- ```QGPL/PAYSUMMARY.dspf```  <- copy this code from the official library
- ```Call payrollpgm```
- Print just 20 lines: ```OVRPRTF``` overwrite printer file
- ```RTVSYSVAL``` then F4 and then F4 whatever to find further values; ```RTVUSRPRF```
- Test: official reference sheet
- Example: ```DSPUSRPRF USRPRF TYPE OUTPUT```

# wrap up for midterm (labs 1-4)
- compile display: ```CRTDSPF```
- compile CL: ```CRTBNDCL```
- compile RPGLE: ```CRTBNDRPG```
- compile prtf: ```CRTPRTF```

## how to write .dspf
(assume 10 characters in ```Functions```)
- You would see the top line as follows in RDi. If you have a test paper, this line may also appear.
- ```.....AAN01N02N03..Name++++++RLen++TDpBLinPosFunctions++++++++++Comments+++++++++++++```
- first ```A```: it appears in every line
- 01 in ```N01```: indicators 01-99
- ```..```after ```N03```: R means RECORD (very often default is RECORD1)
- Name: the name of the record, and so on
- ++ in ```Len++```: length
- T: A
- B after Dp: can be B..oth or O..utput
- Lin: line
- Pos: position, but this one is arbitrary/up to you
- Functions: the exact functionality of it can be just a description that you give to a certain element.

# lab7 / week 9
- To begin, use ```STRSQL``` and create your own database collection. (Recall database concepts from, say, DBS211) Remember the collection name and don't mix up with your home library name.
- The gist of this lab is to use your collection, copy from ```BCI433LIB```'s ```SALESSTAFF``` as ```SALESSTAF2```, and make a journal applying changes through a RPG which is 90%+ done.
- use ```WRKMBRPDM``` and copy from ```LAB7CODE```
- The printer file this time is free and complete. The RPG and CLLE only miss a few lines.
```
FULLKEY = TDept + TSalesId;
CHAIN %KDS(FULLKEY) SALESSTAF2;
```
- ```FULLKEY``` is a composite key in database.
- the next line is chaining the key data structure in the master file. As the complete code shows, the RPG here looks for master file's matching records to this composite key.
- In the CLLE driver program this time, just write a ```CPYF``` command
```
CPYF       FROMFILE(BCI433LIB/SALESSTAFF) +
           TOFILE(BCUB29/SALESSTAF2) MBROPT(*REPLACE) +
           CRTFILE(*YES)
```
- The CLLE has a line on ```DSPJRN``` display journal.

# lab8
- UDF
- Set out the prototype, the main code, and the UDF with matching data types in the display file.
- ```CRTPRGMOD``` for both main code and UDF. Never compile the prototype.
- ```CRTPGM``` + module name + ```module(main code UDF)```

# lab9a
- embedded SQL ```.sqlrpgle``` file format
- printer files are given
- Declare files like in lab6
- Declare data structure for host variables from data file ```DCL-DS CONTACTS23 EXT END-DS;```
- Declare standalone variables
```
DCL-S INDLDCalled BINDEC(4:0);
DCL-S INDNextCDate BINDEC(4:0);
DCL-S Dummy  Zoned(1);
```
- In the main routine, there is ```HIGHLIGHT``` which is an arrow if it is ```OldestDate``` or else blank. It is mainly on writing in ```newpage```, ```rptline```, and ```summary```.
- Subroutines: ```SQLSelect``` and ```SummaryInfo```
- We use the SQL command ```EXEC SQL``` in RPG.
- Like in previous labs, retrieve column fields from the data file and use ```select``` (recall DBS311 content stored procedures and functions) to select fields ```into``` the the local variables which are preceded by ```:```. See code for reference.
- However, the twist is we need to communicate with AS400's SQL functionalities. Refer to lab9 for ```SQLNotes```. When ```SQLState``` is of a certain numerical code (but as strings), you need set fields for errors/match not found/warning, etc.
- In ```SummaryInfo```, you have a similar subroutine but this time you calculate totals and number of unknowns using ```COUNT(*)```. Here, the error code in SQL is ```SQLCODE <> 0) or (SQLWN0 = 'W')```, while if there is a matching oldest/most recent date, you need to add ```(OR) SQLWN0 = '0'``` for a matching record.
- Lastly, there is a given command for showing user, timestamp and server.
```
EXEC SQL
   SELECT USER, CURRENT TIMESTAMP, CURRENT SERVER
   INTO :USER, :TIMESTAMP, :SERVER
   FROM SYSIBM/SYSDUMMY1;
ENDSR;
```
- Lab9a's ```phonesqlh``` has no parameter. If you compile in ACS without a message, it compiles but the result only shows in spooled file. Check for discrepancies.
- Compile using ```CRTSQLRPGI```.

# lab9b
- Similar to 9a but this time ```orderssqlh``` has a ```LimitIn``` (double) parameter to pass, and we need to define a cursor. Also recall DBS311 or DBS501 content if you ever do.
- Also refer to 9b code for reference. ```LimitIn``` has to be Packed(15:5) because of the EBSDIC requirement which takes a longer data length.
- We set ```EndOfFile``` internal variable for reading and also set another data structure (DCL-DS) for SQL stuff. Notice that the order of columns is important but lab9b's doc file, or I should say the printer file itself, doesn't reflect the exact order. If you use the wrong DS, you will still compile but the end product will have no data but just the headings.
- In the main routine, half is given and the work is on matching ```spendlimit``` with ```limitin``` and ```OrderNumH``` and ```OrderNum```, as well as using ```EndOfFile```. We will use 3 subroutines.
- ```PrepareFiles```: The column names are given in a comment. Start with ```EXEC SQL``` as usual and declare a cursor ```FOR``` a ```Select``` statement of columns (merge first name and last name also) from 3 course library files ```customer2```, ```order1```, and ```orderline``` (also given in the comment) ```where``` you would match things like customer number. End this cursor with ```FOR READ ONLY``` since we don't want to change the data.
- After the "temporary result table is created" (this is a comment), we open the cursor to check for ```SQLCODE <> 0``` and ```SQLWN0 = 'W'``` in which case ```endoffile``` applies. This also applies in the next subroutines.
- ```GetRow```: ```EXEC SQL```, then ```fetch next``` from the cursor above into the ```ordersrecord``` and check for end of file. Again, recall your knowledge of cursor.
- ```WRAPUP```: Close the cursor, check for end of file, and the next ```EXEC SQL``` is on counting from ```orderline``` how many total prices are not greater than ```spendlimit``` (refer to LimitIn). When you ```call orderssqlh 10/100``` you also pass 10 or 100 as the ```spendlimit```. It must pass a number in this case.
- Like ```phonesqlh```, ACS shows nothing on screen if it compiles but makes a spooled file with a report.
