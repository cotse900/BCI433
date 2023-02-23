       DCL-F   restatedsp   workstn;
       agentrate = 5;//initialize rate outside saleinfo
       EXFMT SALEINFO;
       DOW NOT (*IN03);
         //don't put agent rate here
         if HousePrice = 0;
           *IN81 = *ON;
           EXFMT SaleInfo;
           *IN81 = *OFF;
           ITER;
           elseif residence = ' ';
             *IN82 = *ON;
             EXFMT SaleInfo;
             *IN82 = *OFF;
             ITER;
           elseif firsttime = ' ';
             *IN83 = *ON;
             EXFMT SaleInfo;
             *IN83 = *OFF;
             ITER;
           elseif *IN06 = '1';
             LegalFees = 900;
             SurveyFee = 850;
             TitleIns = 265;
             Inspection = 425;
             exfmt SaleInfo;
             *IN06 = *OFF;
             ITER;
           else;
             exsr buyersr;
             exsr sellersr;
             *IN79 = *ON;
             write SaleInfo;
             exfmt result;
             *IN79 = *OFF;//also turns off the first F3 - Exit assigned IN79
         ENDIF;

       if *IN03 = *OFF;
         exsr clear;
         exfmt SaleInfo;
       endif;
       enddo;
       *INLR = *ON;
       RETURN;
       //subroutines start here
       BEGSR BuyerSr;

         Select;
           when HousePrice <= 55000;
             LandTax = HousePrice * 0.005;
           when HousePrice <= 250000;
             LandTax = HousePrice * 0.01;
           when HousePrice <= 400000;
             LandTax = HousePrice * 0.015;
           when HousePrice <= 2000000;
             LandTax = HousePrice * 0.02;
           when HousePrice <= 9999999;
             LandTax = HousePrice * 0.025;
         ENDSL;

         if FirstTime = 'Y';
           LandTax = 0;
         endif;

         Commission = HousePrice * (AgentRate / 100);

         TotalCost = LegalFees + SurveyFee + TitleIns + Inspection;
         buyer = HousePrice + TotalCost + LandTax;

         if TotalCost < 1000;
           *IN99 = *ON;
         ENDIF;

       ENDSR;

       BEGSR SellerSr;
         if residence = 'N';
           CapitalGns = HousePrice / 2 * 0.07;
         endif;

         seller = HousePrice - Commission - Capitalgns;
       ENDSR;

       BEGSR clear;
         HousePrice = 0;
         residence = ' ';
         firsttime = ' ';
         AgentRate = 5;
         TotalCost = 0;
         LegalFees = 0;
         SurveyFee = 0;
         TitleIns = 0;
         Inspection = 0;
         seller = 0;
         buyer = 0;
       ENDSR;
