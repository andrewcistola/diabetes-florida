libname NH "C:\Users\andrewcistola\GitHub\PreDM\NHANES\DATA";
libname XP xport "C:\Users\andrewcistola\GitHub\PreDM\NHANES\TEMP\GHB_I.xpt";
run;

proc copy in = XP out = NH;

run;

proc datasets library = NH;

contents data = ghb_i;

run;

libname NH "C:\Users\andrewcistola\GitHub\PreDM\NHANES\DATA";
libname XP xport "C:\Users\andrewcistola\GitHub\PreDM\NHANES\TEMP\DEMO_I.xpt";
proc copy in = XP out = NH;
run;
libname XP xport "C:\Users\andrewcistola\GitHub\PreDM\NHANES\TEMP\DIQ_I.xpt";
proc copy in = XP out = NH;
run;
libname XP xport "C:\Users\andrewcistola\GitHub\PreDM\NHANES\TEMP\GLU_I.xpt";
proc copy in = XP out = NH;
run;
libname XP xport "C:\Users\andrewcistola\GitHub\PreDM\NHANES\TEMP\HIQ_I.xpt";
proc copy in = XP out = NH;
run;
libname XP xport "C:\Users\andrewcistola\GitHub\PreDM\NHANES\TEMP\HUQ_I.xpt";
proc copy in = XP out = NH;
run;
libname XP xport "C:\Users\andrewcistola\GitHub\PreDM\NHANES\TEMP\INS_I.xpt";
proc copy in = XP out = NH;
run;
libname XP xport "C:\Users\andrewcistola\GitHub\PreDM\NHANES\TEMP\OGTT_I.xpt";
proc copy in = XP out = NH;
run;

proc sort data = NH.DEMO_I;
    by SEQN; 
run;
proc sort data = NH.DIQ_I;
    by SEQN; 
run;
proc sort data = NH.GHB_I;
    by SEQN; 
run;
proc sort data = NH.GLU_I;
    by SEQN; 
run;
proc sort data = NH.HIQ_I;
    by SEQN; 
run;
proc sort data = NH.HUQ_I;
    by SEQN; 
run;
proc sort data = NH.INS_I;
    by SEQN; 
run;
proc sort data = NH.OGTT_I;
    by SEQN; 
run;

data NH.MERGE;
merge NH.DEMO_I NH.GHB_I NH.DIQ_I NH.GLU_I NH.HIQ_I NH.HUQ_I NH.INS_I NH.OGTT_I; 
by SEQN;
run;

proc contents data = NH.MERGE varnum;
run;

proc means data = NH.MERGE N Nmiss min max maxdec = 2;
run;

proc export data = NH.MERGE dbms = csv

outfile = "C:\Users\andrewcistola\GitHub\PreDM\_data\nhanes_megred_raw.csv"

replace;

run;

