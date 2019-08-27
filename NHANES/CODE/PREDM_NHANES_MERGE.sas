**Prediabetes Cost of Prevention Study**
*Merge and sorting the NHANEs Dataset to find population with undiagnosed prediabetes*
*Variables are stored in E:\NHANES\ for easy access for individual projects*
*Saved libraries correspond to years of NHANES

*Step 1: Sort SEQN variables*

proc sort 
data = NH1516.DEMO_I;
by SEQN; 
run;
proc sort data = NH1516.DIQ_I;
    by SEQN; 
run;
proc sort 
data = NH1516.GHB_I;    
by SEQN; 
run;
proc sort 
data = NH1516.GLU_I;
by SEQN; 
run;
proc sort 
data = NH1516.HIQ_I;
by SEQN; 
run;
proc sort 
data = NH1516.HUQ_I;
by SEQN; 
run;
proc sort 
data = NH1516.INS_I;
by SEQN; 
run;
proc sort 
data = NH1516.OGTT_I;
by SEQN; 
run;
proc sort 
data = NH1516.BMX_I;
by SEQN; 
run;


*Step 2: Merge Variables into one dataset*

data Predm.MERGE;
merge NH1516.DEMO_I NH1516.GHB_I NH1516.DIQ_I NH1516.GLU_I NH1516.HIQ_I NH1516.HUQ_I NH1516.INS_I NH1516.OGTT_I NH1516.BMX_I; 
by SEQN;
run;

*Step Extra: Export to CSV*

proc export data = NH.MERGE dbms = csv
outfile = "C:\Users\andrewcistola\GitHub\PreDM\_data\nhanes_merged_raw.csv"
replace;

run;

