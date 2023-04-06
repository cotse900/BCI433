        DCL-F WaterDsp workstn;
        DCL-S Rate Zoned(3:2);
      /Copy BC435B29/LABWATER,WATERBILLP
        EXFMT GetData;
        DOW NOT(*IN03);
          IF CubicM <= 0;
            *IN98 = *ON;
            EXFMT GetData;
            *IN98 = *OFF;
            ITER;
          ElseIf Zone = ' ';
            *IN97 = *ON;
            EXFMT GetData;
            *IN97 = *OFF;
            ITER;
          ELSE;
            EXSR CalculateBill;
          ENDIF;
        *IN99 = *ON;
        *IN44 = *ON;
        Write GetData;
        EXFMT ShowResult;
        *IN99 = *OFF;
        *IN44 = *OFF;
        IF *IN04;
          EXFMT INFO;
        ENDIF;
        If NOT(*IN03);
          EXSR CLEAR;
          EXFMT GetData;
        ENDIF;
        ENDDO;
        *INLR = *ON;
        RETURN;

        BEGSR CalculateBill;
          EVAL(H) Gallons = CubicM * 219.969;
            If CubicM > 100;
              *IN55 = *ON;
            ELSE;
              *IN55 = *OFF;
            ENDIF;
          Rate = CalcRate(CubicM);          //UDF
          EVAL(H) WaterChg = CubicM * Rate;
          EVAL(H) SewerChg = CubicM * 2.76;
                  TotalDue = WaterChg + SewerChg;
          CapitalCst = CalcCapitalCost(Zone: TotalDue);
          TotalDue = TotalDue + CapitalCst; //UDF
          EVAL(H) Discount = TotalDue * .045;
          DueAftDsc = TotalDue - Discount;
        ENDSR;

        BEGSR Clear;
          CubicM = 0;
          Zone = ' ';
        ENDSR;
