        // ********************************************************************
        //  Customer23 READ BY NATIVE LANGUAGE (ILE RPG)
        // Contacts23 ROW RETRIEVED WITH EMBEDDED SQL
        //  DETAIL REPORT LINE INCLUDES INFORMATION FROM Customer23 AND CONTACTW
        //  SUMMARRY REPORT INFORMATION RETRIEVED WITH EMBEDDED SQL STATEMENTS

           DCL-F PHNREPORT  PRINTER OFLIND(*IN01) ;
           DCL-F Customer23 DISK(*EXT) KEYED USAGE(*INPUT)
                 RENAME(Customer23:CUSTR);
       // data structure for host variables fromContacts23
           DCL-DS CONTACTS23 EXT END-DS;
       // Standalone fields for indicator variables
           DCL-S INDLDCalled BINDEC(4:0);
           DCL-S INDNextCDate BINDEC(4:0);
           DCL-S Dummy  Zoned(1);
        //**********************************************************************
        //*                        ***   M A I N   R O U T I N E   ***
        //**********************************************************************

                EXSR SummaryInfo;
                WRITE NEWPAGE;
                READ Customer23;
                DOW NOT %EOF;
                    EXSR SQLSelect;
                    IF LDCalled = OldestDate;
                       HIGHLIGHT = '<-------';
                    ELSE;
                       HIGHLIGHT = ' ';
                    ENDIF;
                    IF *IN01 = *ON;
                       Write NEWPAGE;
                       *IN01 = *OFF;
                    ENDIF;
                    Write RPTLINE;
                   READ Customer23;
                ENDDO;
                Write SUMMARY;
                *INLR = *ON;
                RETURN;
        //**********************************************************************
        //   S Q L S E L E C T   S U B R O U T I N E
        //********************************************************************
                       BEGSR    SQLSelect ;
         // A row from the Contacts table that has the same customer number as t
         // record read from the Customer23 file is retrieved to find out the last
         // called, phone number, comments and the salesperson number.

         //  The call back interval is added to the last date called to determin
         //  next date to call.  Since null values may be stored in the last dat
         // indicator variables are used.
           ErrorMsg = ' ';
           EXEC SQL
             SELECT  LDCalled + CallBInt DAYS,
                     LDCalled,
                     Phone,
                     SlsNumber
             INTO   :NEXTCDATE :INDNEXTCDATE,
                    :LDCalled  :INDLDCalled,
                    :Phone,
                    :SlsNumber
             FROM    BCI433LIB/CONTACTS23
             WHERE   CustNumber = :CstNum;

             SELECT;
               WHEN SQLSTATE = '00000';
                 DUMMY = 0;
               WHEN SQLSTATE = '02000';
                 ErrorMsg = 'MATCH NOT FOUND';
                 Phone = 9999999999;
                 NextCDate = D'9999-09-09';
                 LDCalled = D'9999-09-09';
                 SlsNumber = -999;
               WHEN %Subst(SQLState :1 :2) = '01';
                 ErrorMsg = 'Warning Occurred';
                 NextCDate = D'9999-09-09';
                 LDCalled = D'9999-09-09';
                 SlsNumber = -999;
               OTHER;
                 ErrorMsg = 'ERROR OCCURRED';
               //Phone = 9999999999;
                 NextCDate = D'9999-09-09';
                 LDCalled = D'9999-09-09';
                 SlsNumber = -999;
             ENDSL;

             IF INDLDCalled = -1;
                ErrorMsg = 'UNKNOWN DATE';
                NextCDate = D'9999-09-09';
                LDCalled = D'9999-09-09';
             ELSE;
               IF INDLDCalled <> 0;
                ErrorMsg = 'DATE PROBLEM';
                NextCDate = D'9999-09-09';
                LDCalled = D'9999-09-09';
               ENDIF;
             ENDIF;
           ENDSR ;
        //**********************************************************************
        // S U M M A R Y I N F O   S U B R O U T I N E
        //**********************************************************************
                         BEGSR  SummaryInfo;

        //  D E T E R M I N E   T O T A L S   F O R  Contacts23 & Customer23
        EXEC SQL
          SELECT COUNT(*) INTO :CONTACTT
            FROM BCI433LIB/CONTACTS23;
          IF (SQLCODE <> 0) OR (SQLWN0 = 'W');
             CONTACTT = -9999;
          ENDIF;
        EXEC SQL
          SELECT COUNT(*) INTO :CUSTOMERT
            FROM BCI433LIB/CUSTOMER23;
          IF (SQLCODE <> 0) OR (SQLWN0 = 'W');
             CUSTOMERT = -9999;
          ENDIF;
        // D E T E R M I N E   N U M B E R   O F   U N K N O W N   LAST DATE CAL

        EXEC SQL
        SELECT COUNT(*)
          INTO :UNKNOWNT
          FROM BCI433LIB/CONTACTS23
          WHERE LDCALLED IS NULL;

          IF (SQLCODE <> 0) OR (SQLWN0 = 'W');
            UNKNOWNT = -99999;
          ENDIF;
        //  D E T E R M I N E   O L D E S T   &  M O S T   R E C E N T  LAST DAT
        EXEC SQL
          SELECT MIN(LDCalled) INTO :OLDESTDATE
            FROM BCI433LIB/CONTACTS23;
          IF (SQLCODE <> 0) OR (SQLWN0 = '0') AND (SQLWN2 <> 'W');
            OLDESTDATE = D'9999-09-09';
          ENDIF;
        EXEC SQL
          SELECT MAX(LDCalled) INTO :MOSTRECENT
            FROM BCI433LIB/CONTACTS23;
          IF (SQLCODE <> 0) OR (SQLWN0 = '0') AND (SQLWN2 <> 'W');
            MOSTRECENT = D'9999-09-09';
          ENDIF;
       // D E T E R M I N E   T H E   U S E R   S E R V E R   &   T I M E S T A
       // SYSIBM/SYSDUMMY1 from System registers,Don't need check SQLCODE
       EXEC SQL
         SELECT USER, CURRENT TIMESTAMP, CURRENT SERVER
           INTO :USER, :TIMESTAMP, :SERVER
           FROM SYSIBM/SYSDUMMY1;
       ENDSR;
