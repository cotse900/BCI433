      **free
        // Protos for water bill calculations
         Dcl-Pr CalcRate Zoned(3:2);
           CubicM Packed(3);
         END-PR;

         Dcl-Pr CalcCapitalCost Zoned(7:2);
           Zone Char(1);
           TotalDue Packed(8:2);
         END-PR;
