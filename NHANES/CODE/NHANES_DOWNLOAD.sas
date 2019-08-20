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
run;


proc copy in = XP out = NH;

run;

proc datasets library = NH;

contents data = DEMO_I;

run;

proc sort data = NH.DEMO_I;
    by SEQN; 
run;

proc sort data = NH.GHB_I;
    by SEQN; 
run;

data NH.DEMO_GHB;
merge NH.DEMO_I NH.GHB_I; 
by SEQN;
run;

proc contents data = NH.DEMO_GHB varnum;
run;

proc means data =DEMO_BP N Nmiss min max maxdec = 2;
run;

proc export data = NH.DEMO_GHB dbms = csv

outfile = "C:\Users\andrewcistola\GitHub\PreDM\_data\nhanes_hba1c_raw.csv"

replace;

run;

