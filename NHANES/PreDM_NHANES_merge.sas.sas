***Prediabetes Cost of Prevention Study - NHANES Population COunts

*Merge and sorting the NHANEs Dataset to find population with undiagnosed prediabetes
*Variables are stored in E:\NHANES\ for easy access for individual projects
*Saved libraries correspond to years of NHANES

**Prep Code: Set Libraries;

libname NH "E:\NHANES\2015-2016\DATA";
libname PD "E:\PreDM\NHANES";
run;

**Step 1: Sort SEQN variables;

proc sort 
data = NH.DEMO_I;
by SEQN; 
run;
proc sort data = NH.DIQ_I;
    by SEQN; 
run;
proc sort 
data = NH.GHB_I;    
by SEQN; 
run;
proc sort 
data = NH.GLU_I;
by SEQN; 
run;
proc sort 
data = NH.HIQ_I;
by SEQN; 
run;
proc sort 
data = NH.HUQ_I;
by SEQN; 
run;
proc sort 
data = NH.INS_I;
by SEQN; 
run;
proc sort 
data = NH.OGTT_I;
by SEQN; 
run;
proc sort 
data = NH.BMX_I;
by SEQN; 
run;


**Step 2: Merge Variables into one dataset;

*Megre Data by Variable;

data PD.Merge;
merge NH.DEMO_I NH.GHB_I NH.DIQ_I NH.GLU_I NH.HIQ_I NH.HUQ_I NH.INS_I NH.OGTT_I NH.BMX_I; 
by SEQN;
run;

*Check contents of Dataset;

proc contents data = PD.Merge;
run;


**Step Optional: Create Categorical Variables based on Conditions;

*Use Coniditons to Create New Variabe 1;

data PD.ifthen;
set PD.merge;
If DIQ010 = 1 then DMStat = 1; *1 = Diagnosed Diabetes;
Else If DIQ160 = 1 then DMStat = 2; *2 = Diagnosed Prediabetes;
Else If LBXGH >= 6.4 and DIQ010 ~= 1 then DMStat = 3; *3 = Undiagnosed Diabetes;
Else If LBXGH < 6.4 and LBXGH >= 5.7 and DIQ160 ~= 1 then DMStat = 4; *4 = Undiagnosed Prediabetes;
Else If (LBXGH < 6.4 and LBXGH >= 5.7 and DIQ160 = 2) or (LBXGH > 6.4 and DIQ160 = 1) then DMStat = 5; *5 = Misdiagnosed;
Else If LBXGH < 5.7 then DMStat = 6; *6 = Healthy;
Else If LBXGH = . then DMStat = 7; *7 Unknown;
run;

*Use Coniditons to Create New Variabe Varible 2;

data Pd.ifthen2;
set PD.ifthen;
If RIDAGEYR > 40 and RIDAGEYR < 70 and BMXBMI > 25 then DMRisk = 1; *At risk;
Else DMRisk = 2; *Not at risk;
run;

*Get frequency of Unique Values in tables;

proc freq data = PD.ifthen2;
tables DMStat DMRisk;
run;

**Step 3: Set Formats and labels based on Categorical Variables;

*Set formats;

proc format;                                                                                       
value Status	
	1 = Diagnosed Diabetes                          
	2 = Diagnosed Prediabetes                      
    3 = Undiagnosed Diabetes
	4 = Undiagnosed Prediabetes
	5 = Misdiagnosed
	6 = Healthy
	7 = Unknown;
value Risk 	 	
	1 = At risk
	2 = Not at risk;
value Race
	1 = Mexican American
	2 = Other Hispanic
	3 = NonHispanic White
	4 = NonHispanic Black
	6 = NonHispanic Asian
	7 = Other Race Including Multi Racial;
run;

*Set lables;

data PD.stat;
set PD.ifthen2;
format DMStat Status. DMRisk Risk. RIDRETH3 Race.;
label DMStat = "Diabetes Status" DMRisk = "Population at Risk" RIDRETH3 = "Race and Ethnicity";
run;

*Check contents of Dataset;

proc contents data = PD.stat;
run;

**Step 4: Set Weights and Clusters to create population counts;

*Sort Data by strata and cluster;

proc sort data = PD.stat;
by SDMVSTRA SDMVPSU;
run;

*Population count Using SAS, Save Results to SAS Dataset;

proc surveyfreq data = PD.stat NOSUMMARY varheader = label;
tables  DMRisk * DMStat * RIDRETH3; *variables to use in table;
ods output CrossTabs = PD.result;
strata  SDMVSTRA; *first stage strata;
cluster SDMVPSU; *first stage cluster;
weight  WTMEC2YR; *survey weight;
run;

**Step Extra: Export Data;

*Export SAS Dataset to CSV;

proc export data = PD.result dbms = csv
outfile = "E:PreDM\_data\nhanes_dmstatus_raw.csv"
replace;
run;




