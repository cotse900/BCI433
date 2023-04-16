000100230327       DCL-F   RESTATEDS2   workstn;
000200230327       DCL-PI Main extPgm('REALESTAT2');
000300230327
000400230327       END-PI;
000500230327      /COPY LAB8,PROTO
000600230203       agentrate = 5;//initialize rate outside saleinfo
000700230213       EXFMT SALEINFO;
000800230203       DOW NOT (*IN03);
000900230203         //don't put agent rate here
001000230203         if HousePrice = 0;
001100230203           *IN81 = *ON;
001200230203           EXFMT SaleInfo;
001300230203           *IN81 = *OFF;
001400230213           ITER;
001500230203           elseif residence = ' ';
001600230203             *IN82 = *ON;
001700230203             EXFMT SaleInfo;
001800230203             *IN82 = *OFF;
001900230203             ITER;
002000230203           elseif firsttime = ' ';
002100230203             *IN83 = *ON;
002200230203             EXFMT SaleInfo;
002300230203             *IN83 = *OFF;
002400230203             ITER;
002500230203           elseif *IN06 = '1';
002600230203             LegalFees = 900;
002700230203             SurveyFee = 850;
002800230203             TitleIns = 265;
002900230203             Inspection = 425;
003000230203             exfmt SaleInfo;
003100230203             *IN06 = *OFF;
003200230213             ITER;
003300230203           else;
003400230203             exsr buyersr;
003500230203             exsr sellersr;
003600230203             *IN79 = *ON;
003700230203             write SaleInfo;
003800230203             exfmt result;
003900230203             *IN79 = *OFF;//also turns off the first F3 - Exit assigned IN79
004000230203         ENDIF;
004100230213
004200230203       if *IN03 = *OFF;
004300230203         exsr clear;
004400230203         exfmt SaleInfo;
004500230213       endif;
004600230213       enddo;
004700230203       *INLR = *ON;
004800230213       RETURN;
004900230202       //subroutines start here
005000230327       BEGSR BuyerSr;
005100230203         if FirstTime = 'Y';
005200230203           LandTax = 0;
005300230327         else;
005400230327           LandTax = LANDTAXR(HousePrice);
005500230203         endif;
005600230213
005700230203         Commission = HousePrice * (AgentRate / 100);
005800230213
005900230203         TotalCost = LegalFees + SurveyFee + TitleIns + Inspection;
006000230203         buyer = HousePrice + TotalCost + LandTax;
006100230203
006200230210         if TotalCost < 1000;
006300230203           *IN99 = *ON;
006400230327         ENDIF;
006500230202       ENDSR;
006600230203
006700230203       BEGSR SellerSr;
006800230203         if residence = 'N';
006900230203           CapitalGns = HousePrice / 2 * 0.07;
007000230203         endif;
007100230203
007200230203         seller = HousePrice - Commission - Capitalgns;
007300230203       ENDSR;
007400230203
007500230203       BEGSR clear;
007600230203         HousePrice = 0;
007700230203         residence = ' ';
007800230203         firsttime = ' ';
007900230203         AgentRate = 5;
008000230203         TotalCost = 0;
008100230203         LegalFees = 0;
008200230203         SurveyFee = 0;
008300230203         TitleIns = 0;
008400230203         Inspection = 0;
008500230203         seller = 0;
008600230203         buyer = 0;
008700230203       ENDSR;
