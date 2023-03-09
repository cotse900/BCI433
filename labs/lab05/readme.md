# display file reference
- in .dspf, there are three fields to specify. ```Properties```->```Reference```->```Reference type: Database reference```
- Referenced field
1. Library: ```SENECAPAY```
2. File: ```SHIFTRATES```
3. Record: ```SHIFTRATES```
4. Field: ```DAYHRS/NIGHTHRS/AFTHRS```
- click Apply. Once it works, you should see .dspf has new coding like 

```REFFLD(SHIFTRATES/NIGHTHRS +``` (notice they are two lines!)

```SENECAPAY/SHIFTRATES)```

- Caution: basically, if you see in Properties "Reference information: Unable to resolve reference", it can only be any combination of these reasons:
1. You did not add ```SENECAPAY``` library in your library list to work on anything. It is an external file relative to your ```Remote Systems```
2. An issue of file names. Maybe in semester A it was named ```DAYRATE/NIGHTRATE/AFTNRATE```, then in this semester B they are now renamed ```DAYHRS/NIGHTHRS/AFTHRS```. ```PAYCLASS``` or ```PAYGRADE```, 1/2/3/4 or A/B/C/D. You know what I am saying?
3. Typos.

- Another compiling error is your REFFLD code above is jammed together, like 20+ characters, and it won't work in RDi. Sometimes, RDi can run a bug.

- In 2023, think of unresolved reference as dead links. If it doesn't compile, it could be another RDi bug or your fault/you confused yourself/unclear instructions/un-updated/borderline misleading instructions.

# declaring files
- I personally captured my screens for reference. The notes say
> Solve the SQL problem

> Specifying RENAME option on the RPGLE file definition so that the format is defined with a different name internal to the RPG program:

> KEYWORDS: RENAME(fileName:newRecName)

- Apparently, while it is alright to declare ```SHIFTWEEK```, put it as input, put keyed, and rename it to something else, either you don't have to rename ```SHIFTRATES``` or you must to avoid compiling errors.

```DCL-F SHIFTWEEK  USAGE(*INPUT) KEYED RENAME(SHIFTWEEK:SHIFTWEEKR);```

```DCL-F SHIFTRATES DISK USAGE(*INPUT); // RENAME(SHIFTRATES:SHIFTRATER);```

- My guess is it also changes every semester like DAYRATE and friends. You'll still have 00 Severity errors but they are perfectly fine.
