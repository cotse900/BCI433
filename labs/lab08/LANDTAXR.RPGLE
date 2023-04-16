000100230327       CTL-OPT NoMain  ;
000200230327      /COPY LAB8,PROTO
000300230327       DCL-Proc LANDTAXR Export;
000400230327         DCL-PI *N Packed(8:2);
000500230327           HousePrice Packed(7:0);
000600230327         END-PI;
000700230327
000800230327       DCL-S TaxAmount Packed(8:2);
000900230327       SELECT;
001000230327         when HousePrice <= 55000;
001100230327           TaxAmount = HousePrice * 0.005;
001200230327         when HousePrice <= 250000;
001300230327           TaxAmount = HousePrice * 0.01;
001400230327         when HousePrice <= 400000;
001500230327           TaxAmount = HousePrice * 0.015;
001600230327         when HousePrice <= 2000000;
001700230327           TaxAmount = HousePrice * 0.02;
001800230327         when HousePrice <= 9999999;
001900230327           TaxAmount = HousePrice * 0.025;
002000230327       ENDSL;
002100230327       Return TaxAmount;
002200230327
002300230327       END-PROC;
002400230327
