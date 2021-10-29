LIBNAME Entiera ODBC user = "carlsonqa" password = "uI#Ykegx" dsn='ENTIERA_Prod' schema='truevalue';
/***************************************************************************************/
/*              GET ZIP CODE DISTANCES AND MERGE TO STORE ZIP CODE                     */
/***************************************************************************************/

DATA ALL_ZIPS;
SET SASHELP.ZIPCODE (KEEP=ZIP);
RUN;

DATA ALL_ZIPS2 (RENAME=(ZIP=ZIP2));
SET SASHELP.ZIPCODE (KEEP=ZIP);
RUN;

DATA OUT.ALL_USZIP_COMBINATIONS;
SET ALL_ZIPS;
	DO I=1 TO N;
SET ALL_ZIPS2 POINT=I NOBS=N;
	OUTPUT;
	END;
RUN;

DATA OUT.ALL_USZIP_DISTANCES;
SET OUT.ALL_USZIP_COMBINATIONS;
	DISTANCE=ZIPCITYDISTANCE(ZIP,ZIP2);
RUN;

/* MERGE DATASET OF ALL US ZIP CODE DISTANCE TO STORE ZIP CODES TO FIND CLOSED ZIP */
PROC SORT DATA=TVR_STORES OUT=STORES; BY ZIP; RUN;

DATA STORES_ZIP;
SET STORES;
	ZIP2=SUBSTR(ZIP,1,5);
	FORMAT ZIP5 Z5.;
	ZIP5=ZIP2;
	DROP ZIP ZIP2;
	RENAME ZIP5=ZIP;
RUN;

PROC SORT DATA=STORES_ZIP OUT=TVR_STORES_NODUP NODUPKEY; BY ZIP; RUN;

PROC SQL;
CREATE TABLE DISTANCE AS
SELECT
	A.ZIP,
	A.DISTANCE,
	B.STORE_ZIP
FROM OUT.ALL_USZIP_DISTANCES A INNER JOIN TVR_STORES_NODUP B
	ON A.ZIP2=B.STORE_ZIP
ORDER BY ZIP, DISTANCE;
QUIT;

PROC SORT DATA=DISTANCE OUT=MIN_DISTANCES NODUPKEY; BY ZIP; RUN;

/***************************************************************************************/
/*                            END ZIP CODE AND DISTANCE CODE                           */
/***************************************************************************************/
