/*EXPORT TO EXCEL*/
PROC EXPORT DATA=status_change
                 OUTFILE = "V:\Share2\TrueValue\Adhocs\Lighthouse - DS\#197 - Carr 900 Series status change\20111219 Status Change.xlsx" 
                 DBMS=EXCELCS REPLACE;
                 port=9621;
                 server=S605181CH3SW99;
RUN;

/*IMPORT FROM EXCEL*/
PROC IMPORT OUT= CERTS 
            DATAFILE= "V:\Share2\TrueValue\Adhocs\Lighthouse - DS\#196 - Cape stores Rewards\potentialfraud_121211.xls" 
            DBMS=EXCELCS REPLACE;
     RANGE="Rewards$"; 
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

/*EXPORT TO TEXT  - PIPE DELIMITED*/
PROC EXPORT DATA=OUT.EXPORT_DATASET_1118
			OUTFILE="E:\Volumes\Shared2-QOS4\Share2\TrueValue\Manual Campaigns\Welcome\&month.2012\Welcome_DM_20111118.TXT"
			DBMS=DLM
			REPLACE;
			DELIMITER='|';
RUN;

/*IMPORT FROM TEXT - PIPE DELIMITED*/
data TVR_data_in;
	infile 'V:\Share2\TrueValue\Report Testing\New Report Development\Homepage Dashboard\entiera_roi_data_clus - Mar 2012 Release FINAL Version.txt' 
		DLM = '|';
	input Store_ID Store_Cluster Gross_Margin Incremental_Net_Sales ;
run;

/*IMPORT FROM CSV*/
proc import datafile="V:\Share2\TrueValue\Manual Campaigns\Segments\Load Segments 20120214\CRM Rejects from 02152012 segment load.csv"
     out=rejects
     dbms=csv
     replace;
     getnames=no;
run;
/*OR*/
DATA WORK.ALL_ACCOUNTS;
LENGTH TVR_CARD_NO $32 STATUS $10.; 
INFILE "Y:\Enterprise\Apps\17TVR\AccProd\Decision Sciences\CRM Households\CRM All accounts &today..csv"
DLM=',' DSD TRUNCOVER;
INPUT TVR_CARD_NO $ STATUS $ PRIMARY_STORE_ID $;
RUN;
