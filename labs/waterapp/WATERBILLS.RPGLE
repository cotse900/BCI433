         Ctl-Opt NoMain;
         // (D) copy in prototypes
      /Copy BC435B29/LABWATER,WATERBILLP
         Dcl-Proc CalcRate Export;
           Dcl-Pi *N Zoned(3:2);
             CubicM Packed(3);
           END-PI;
           Dcl-S Rate Zoned(3:2);
           Select;
             When CubicM >= 76;
               Rate = 2.85;
             When CubicM >= 60;
               Rate = 2.77;
             When CubicM >= 30;
               Rate = 2.66;
             When CubicM >= 16;
               Rate = 2.54;
             Other;
               Rate = 2.3;
           ENDSL;
         Return Rate;
         END-PROC;

         // Same changes as at (E) for this procedure too
         Dcl-Proc CalcCapitalCost Export;
           Dcl-Pi *N Zoned(7:2);
             Zone Char(1);
             TotalDue Packed(8:2);
           END-PI;
           Dcl-S CapitalCst Zoned(7:2);
           Select;
              When ZONE = 'A' OR ZONE = 'B' OR ZONE = 'C';
                CAPITALCST = 18.75;
              When ZONE = 'E' OR ZONE = 'F';
                EVAL(H) CapitalCst = TotalDue * .08;
              When ZONE = 'G' OR ZONE = 'H';
                EVAL(H) CapitalCst = TotalDue * .055;
              When ZONE = 'D';
                CapitalCst = 0;
           ENDSL;
         Return CapitalCst;
         END-PROC;
