      //***********************************************************************
      //* THIS PROGRAM USES A CURSOR TO LOAD A TEMPORARY RESULT TABLE FROM 3
      //* SEPARATE TABLES, CUSTOMER2, ORDER1 AND ORDERLINE. A NUMBER IS PASSED
      //* TO THE PROGRAM TO DETERMINE WHICH RECORDS ARE INLCUDED
      //***********************************************************************
           DCL-F CUSTREPORT PRINTER OFLIND(*IN01) ;
           DCL-S OrderNumH    PACKED(5:0);
      // Declare an indicator to handle end of result set (file)
           DCL-S EndOfFile IND;
      // All Host Variables available under a single name
           DCL-DS OrdersRecord;
             CustName Char(31);
             OrderNum Packed(5:0);
             OrderDate Date;
             PartNum Char(4);
             Quantity Packed(3:0);
             QtPrice Packed(6:2);
             ExtPrice Packed(7:2);
           END-DS;

       // LimitIn is passed to the program
           DCL-PI Main ExtPgm('ORDERSSQLH');
             LimitIn Packed(15:5);
           END-PI;

       // M A I N    R O U T I N E

                SpendLimit = LimitIn;
                EXSR PrepareFiles;
                Write ReporTitle;
                Write ColHeading;
                EXSR GetRow;
                If NOT EndOfFile;
                  Write NextCust;
                  OrderNumH = OrderNum;
                EndIf;
                DOW NOT EndOfFile;
                    IF *IN01 = *ON;
                        Write ReporTitle;
                        Write ColHeading;
                       *IN01 = *OFF;
                    ENDIF;
                    // Handle Control Breaks on Order Number
                IF OrderNumH = OrderNum;
                  WRITE OrdDetail;
                ELSE;
                  OrderNumH = OrderNum;
                  WRITE OrdTotal;
                  TotalAll += TotalOrd;
                  TotalOrd = 0;
                  WRITE NextCust;
                  WRITE OrdDetail;
                ENDIF;
                TotalOrd += ExtPrice;
                EXSR GetRow;
                ENDDO;
                Write OrdTotal;
                TotalAll += TotalOrd;
                Write AllOrders;
                EXSR   WRAPUP;
                Write NotInclude;
                *INLR = *ON;
                RETURN;
        //**********************************************************************
        // O P E N F I L E S   S U B R O U T I N E
        //**********************************************************************
         BEGSR  PrepareFiles;
        // S E T   U P   T H E   T E M P O R A R Y   R E S U L T  S T R U C T U
        //CUSTOMER2: FIRST_NAME, LAST_NAME, CUSTOMER_NUMBER
        //ORDER1: ORDER_NUMBER, ORDER_DATE, CUSTOMER_NUMBER
        //ORDERLINE: ORDER_NUMBER, PART_NUMBER, NUMBERED_ORDERED, QUOTED_PRICE
         EXEC SQL
           DECLARE OrdersCursor CURSOR
             FOR
               SELECT TRIM(FIRST_NAME) || ' ' || TRIM(LAST_NAME) AS CUSTNAME,
                 O.ORDER_NUMBER, ORDER_DATE, PART_NUMBER, NUMBER_ORDERED,
                 QUOTED_PRICE, NUMBER_ORDERED * QUOTED_PRICE
               FROM BCI433LIB/CUSTOMER2 C, BCI433LIB/ORDER1 O,
                    BCI433LIB/ORDERLINE OL
               WHERE C.CUSTOMER_NUMBER = O.CUSTOMER_NUMBER AND
                     O.ORDER_NUMBER = OL.ORDER_NUMBER AND
                     NUMBER_ORDERED * QUOTED_PRICE > :SPENDLIMIT
               FOR READ ONLY;
        // A   T E M P O R A R Y   R E S U L T   T A B L E   I S   C R E A T E D
        EXEC SQL
          OPEN OrdersCursor;
          IF (SQLCODE <> 0) OR (SQLWN0 = 'W');
            EndOfFile = *ON;
          ENDIF;
            ENDSR;
        //**********************************************************************
        //   G E T     R O W    S U B R O U T I N E
        //**********************************************************************
            BEGSR     GETROW;
            EXEC SQL
              FETCH NEXT
                FROM OrdersCursor
                INTO :OrdersRecord;
            IF (SQLCODE <> 0) OR (SQLWN0 = 'W');
              EndOfFile = *ON;
            ENDIF;
             ENDSR;
        //**********************************************************************
        // W R A P U P     S U B R O U T I N E
        //**********************************************************************
           BEGSR WRAPUP;
           EXEC SQL
             CLOSE OrdersCursor;
               IF (SQLCODE <> 0) OR (SQLWN0 = 'W');
                 EndOfFile = *ON;
               ENDIF;
           EXEC SQL
             SELECT COUNT(*) INTO :UNDERLIMIT
               FROM BCI433LIB/ORDERLINE OL
               WHERE NUMBER_ORDERED * QUOTED_PRICE <= :SPENDLIMIT;
          ENDSR;
