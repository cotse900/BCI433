# display file reference
- in .dspf, there are three fields to specify. ```Properties```->```Reference```->```Reference type: Database reference```
- Referenced field
1. Library: ```SENECAPAY```
2. File: ```SHIFTRATES```
3. Record: ```SHIFTRATES```
4. Field: ```DAYHRS/NIGHTHRS/AFTHRS```
- click Apply. Once it works, you should see .dspf has new coding like ```REFFLD(SHIFTRATES/NIGHTHRS + SENECAPAY/SHIFTRATES)```
- Caution: basically, if you see in Properties "Reference information: Unable to resolve reference", it can only be a combination of three reasons:
1. You did not add ```SENECAPAY``` library in your library list to work on anything. It is an external file relative to your ```Remote Systems```
2. An issue of file names. Maybe in semester A it was named ```DAYRATE/NIGHTRATE/AFTNRATE```, then this semester they are now ```DAYHRS/NIGHTHRS/AFTHRS```.
3. Typos.
- In 2023, think of this as dead links.
