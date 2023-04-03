# Export files
- In RDi, File -> Export -> General -> File System -> Next -> 
- My advice: if you select ```RemoteSystemsTempFiles```, you are likely to see, under Zeus (domain name of your class/course/school), things like ```QCLLESRC.FILE```, ```QDDSSRC.FILE```, ```QPRGLESRC.FILE```, and the file names may look confusing if you deleted or moved files before. At least I did this before.
- So, what? In the above remote systems temp files, you may also see your current saved lab files, if you have any. Those are the ones you should export if you want.
- Again, in the remote system, right click your file, and there is an option ```Make Available Offline```. Once you do, you may see these offline lines under ```File System``` above.

## remove line numbers
- In general, in exported ```.CLLE```, ```.DSPF```, ```.RPGLE```, ```.PRTF``` files, etc., every file starts with 12 numbers such as ```002100230216``` and it means 00 ```line 21``` 00 date ```230216```.
- Regardless of file type, maybe a batch command may help: ```sed -i 's/^.\{12\}//' *.*``` (remove first 12 characters/replace with nothing).
- That's just for easier reading outside RDi.


# How-to

## save your workspace in a USB drive
- as of 2023, still.
- the whole purpose is to save config and stuff, but also for this class.

## how to clean up spooled file (in lab 4)
- right click Commands in RDi -> New -> Command Set
- ```CLROUTQ your-library (typically BCxxxBxx)```
- Use default settings and click finish
- you can restart to see the effect

## how to use error message properly
- In CL, just don't use ```ERRMSG```. It interferes with things like ```DSPATR```.
- sample code may already show that you use an onscreen prompt aka text activatable by indicator x ```INx```.

## how to compile CL properly
- long story short, use the tab button or add space when necessary. A lot of code doesn't compile because you type something together and RDi can't read two things together without space.

## how to exclude N lines
- in RDi, on any line you prefer, type ```x``` on the line number
- if you want to exclude multiple lines, type ```x6``` to hide 6 lines
- hit enter
- that's what a prof would do in showing a lab code partially

## how to resequence lines in RDi
- when you delete lines, some line numbers "disappear". To rearrange, use this:
- Window -> Preferences -> Remote Systems -> Remote Systems LPEX Editor
- check ```Resequence lines at save```

# RDi V9.6 login error
- Since you need to switch workspace at home or during the labs, it can happen that RDi crashes trying to load your workspace on your USB stick.
- In that case, try to use the default workspace, usually on ```C:```, on a school computer's RDi
- Connect to this default workspace with your login
- ***When prompted, check "remember password". Login.***
- Restart with your original USB workspace, say, on ```D:```.
- This applies when you have used "remember password" for your workspace, and with a certain bug, RDi can fail to know if automatic password is needed, and causes some exception error.
