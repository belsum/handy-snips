PROC IMPORT OUT= /*table*/ 
        DATAFILE=/*"Path and File Name.xls"*/ 
        DBMS=EXCEL REPLACE;
      SHEET=/*"Sheet Name"*/; 
      GETNAMES=YES;
      MIXED=NO;
      SCANTEXT=YES;
      USEDATE=YES;
      SCANTIME=YES;
RUN;

PROC EXPORT DATA= /*table*/ 
			OUTFILE=/*"Path and File Name.xls"*/ 
			DBMS=EXCEL2000 REPLACE;
			SHEET=/*"Sheet Name"*/; 
RUN;

PROC IMPORT OUT= /*table*/
            DATATABLE= /*"Table Name"*/ 
            DBMS=access2000 REPLACE;
     DATABASE=/*"Path and File Name.mdb"*/; 
     SCANMEMO=YES;
     USEDATE=NO;
     SCANTIME=YES;
RUN;

PROC EXPORT data= /*table*/
	outtable=/*"Table Name"*/
	dbms=access2000 replace;
	database=/*"Path and File Name.mdb"*/;
RUN;
