       CTL-OPT NoMain  ;
      /COPY LAB8,PROTO
       DCL-Proc LANDTAXR Export;
         DCL-PI *N Packed(8:2);
           HousePrice Packed(7:0);
         END-PI;

       DCL-S TaxAmount Packed(8:2);
       SELECT;
         when HousePrice <= 55000;
           TaxAmount = HousePrice * 0.005;
         when HousePrice <= 250000;
           TaxAmount = HousePrice * 0.01;
         when HousePrice <= 400000;
           TaxAmount = HousePrice * 0.015;
         when HousePrice <= 2000000;
           TaxAmount = HousePrice * 0.02;
         when HousePrice <= 9999999;
           TaxAmount = HousePrice * 0.025;
       ENDSL;
       Return TaxAmount;

       END-PROC;

