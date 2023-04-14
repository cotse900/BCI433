           DCL-F SHIFTWEEK USAGE(*INPUT) KEYED RENAME(SHIFTWEEK:SHIFTWEEKR);
           DCL-F PAYSUMMARY WORKSTN;
           DCL-F SHIFTRATES DISK USAGE(*INPUT) RENAME(SHIFTRATES:SHIFTRATER);
           DCL-F PAYRPT2 PRINTER OFLIND(*IN01);
           DCL-S HOURSOVER PACKED(3);
           //LAB6 EDIT//
           DCL-PI MAIN EXTPGM('PAYROLLPG3'); //matching file name
             ShiftType char(30); //ShiftType matches new code in PAYPRT2, PAYSUMMAR2
           END-PI;
           READ SHIFTRATES;
           WRITE TITLE;
           WRITE COLHDG;

           READ SHIFTWEEK;

           DOW NOT %EOF;
             EXSR PaySr;
             IF *IN01 = *ON;//if it is on, print the title output record and any other needed
             //heading records and then ensure the indicator is turned off
               WRITE TITLE;
               WRITE COLHDG;
               *IN01 = *OFF;
             ENDIF;
             WRITE EMPDETAIL;
             READ SHIFTWEEK;
           ENDDO;

           TOTWKPAY = TOTREGPAY + TOTOVTPAY;
           WRITE TOTALS;
           EXFMT INFO;//paysummary and wait for user input
           *INLR = *ON;
           RETURN;

           BEGSR PaySr;
             SELECT;
               WHEN WORKSHIFT = '1';
                 HourlyRate = DAYHRS;
               WHEN WORKSHIFT = '2';
                 HourlyRate = AFTHRS;
               WHEN WORKSHIFT = '3';
                 HourlyRate = NIGHTHRS;
             ENDSL;

             SELECT;
               WHEN PAYGRADE = 'A';
                 EVAL(h) HourlyRate = HourlyRate * 1.094; //rounding numbers
               WHEN PAYGRADE = 'B';
                 EVAL(h) HourlyRate = HourlyRate * 1.062;
               WHEN PAYGRADE = 'C';
                 EVAL(h) HourlyRate = HourlyRate * 1.043;
               WHEN PAYGRADE = 'D';
                 HourlyRate = HourlyRate;
             ENDSL;

             IF HRSWORKED <= 40;
               OVERPAY = 0;
               HOURSOVER = 0;
               REGULARPAY = HRSWORKED * HOURLYRATE;
             ELSE;
               HOURSOVER = HRSWORKED - 40;
               OVERPAY = HOURSOVER * (1.5 * HOURLYRATE);
               REGULARPAY = 40 * HOURLYRATE;
             ENDIF;

             WEEKLYPAY = REGULARPAY + OVERPAY;
             TOTREGPAY += regularpay;
             TOTOVTPAY += overpay;
           ENDSR;
