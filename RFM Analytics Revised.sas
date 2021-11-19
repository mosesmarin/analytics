/* Generated Code (IMPORT) */
/* Source File: RFM_Exercise_data.csv */
/* Source Path: /home/u59299458 */
/* Code generated on: 11/18/21, 7:50 PM */

%web_drop_table(WORK.IMPORT);


FILENAME REFFILE '/home/u59299458/RFM_Exercise_data.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.IMPORT;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.IMPORT; RUN;


%web_open_table(WORK.IMPORT);


data a; set WORK.IMPORT;
trf_recency=-1*Last_Pur;


Title 'Analysis of frequency variable Num_Pur';
proc freq data=a;
tables Num_Pur;
run;


Title 'Analysis of recency variable Last_Pur';
proc freq data=a;
tables Last_Pur;
run;

Title 'Analysis of recency variable -Last_Pur';
proc freq data=a;
tables trf_recency;
run;

Title 'Analysis of monetary variable Tot_Dollars';
proc freq data=a;
tables Tot_Dollars;
run;


Title 'Quantiles for Frequency';
proc univariate data=a;
    var Num_Pur;
    output out=percentilesF pctlpts=0 to 100 by 20 pctlpre=F;
    Proc print data=percentilesF;
run;

Title 'Quantiles for Recency';
proc univariate data=a;
    var Last_Pur;
    output out=percentilesF pctlpts=0 to 100 by 20 pctlpre=F;
    Proc print data=percentilesF;
run;

Title 'Quantiles for -Recency';
proc univariate data=a;
    var trf_recency;
    output out=percentilesF pctlpts=0 to 100 by 20 pctlpre=F;
    Proc print data=percentilesF;
run;


Title 'Quantiles for Monetary';
proc univariate data=a;
    var Tot_Dollars;
    output out=percentilesF pctlpts=0 to 100 by 20 pctlpre=F;
    Proc print data=percentilesF;
run;

proc rank data=a groups=5 ties=low out=ranked_catalogue;
     var trf_recency Num_Pur Tot_Dollars ;
     ranks rank_R rank_F rank_M;
run;


Title 'Analysis of R, F and M codes separately';
proc freq; tables rank_R rank_F rank_M;
run;

data Temp; set ranked_catalogue;
rank_R=rank_R+1;
rank_F=rank_F+1;
rank_M=rank_M+1;


Title 'Analysis of R, F and M codes separately after making sure all of them start at 1';
proc freq; tables rank_R rank_F rank_M;
run;

Data temp1; set temp;
Title 'Response by RFM groups';
RFM = rank_R||rank_F||rank_M;
proc sort; by RFM;
proc Means; var Last_response; by RFM;
run;









