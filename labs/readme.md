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
