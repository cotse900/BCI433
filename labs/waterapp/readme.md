# How to write UDFs
- prepare the UDF file, prototype, main rpg
- ```CRTRPGMOD``` for the UDF and main rpg
- ```CRTPGM``` + program name + module(main UDF)
- Example:
```
CRTRPGMOD  MODULE(LANDTAXR) SRCFILE(LAB8) SRCMBR(LANDTAXR)
CRTRPGMOD  MODULE(REALESTAT2) SRCFILE(LAB8) SRCMBR(REALESTAT2)
CRTPGM     LANDTA2 module(REALESTAT2 LANDTAXR)
```
