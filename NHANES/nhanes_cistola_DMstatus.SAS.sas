**Prediabetes Cost of Prevention Study - NHANES Population COunts

*Merge and sorting the NHANEs Dataset to find population with undiagnosed prediabetes
*Variables are stored in E:\NHANES\ for easy access for individual projects
*Saved libraries correspond to years of NHANES

**Prep Code: Set Libraries;

libname NH "C:\Users\drewc\Dropbox (UFL)\UF- Health Service Research, Management, and Policy\NHANES Data Library\2015-2016\DATA";
libname PD "C:\Users\drewc\GitHub\PreDM\NHANES";
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

*Use Coniditons to Create New Variabe 1;

data PD.ifthen;
set PD.merge;
If DIQ010 = 1 then DMStat = 1; *1 = Diagnosed Diabetes;
Else If DIQ160 = 1 then DMStat = 2; *2 = Diagnosed Prediabetes;
Else If LBXGH >= 6.4 and DIQ010 ~= 1 then DMStat = 3; *3 = Undiagnosed Diabetes;
Else If LBXGH < 6.4 and LBXGH >= 5.7 and DIQ160 ~= 1 then DMStat = 4; *4 = Undiagnosed Prediabetes;
Else If (LBXGH < 6.4 and LBXGH >= 5.7 and DIQ160 = 2) or (LBXGH > 6.4 and DIQ160 = 1) then DMStat = 5; *5 = Misdiagnosed;
Else If LBXGH < 5.7 then DMStat = 6; *6 = Healthy;
Else If LBXGH = . or DIQ010 in (3 7 9 .) or DIQ160 in (7 9 .) then DMStat = 7; *7 Unknown;
run;

*Show first 5 observations of Dataset;

proc print data = PD.ifthen (OBS = 5);
var DMStat;
run;

*Use Coniditons to Create New Variabe Varible 2;

data Pd.ifthen2;
set PD.ifthen;
If BMXBMI > 25 then DMBMI = 1; *Obese;
Else If BMXBMI < 25 and BMXBMI >= 21 then DMBMI = 2; *Overweight;
Else If BMXBMI < 21 or BMXBMI = . then DMBMI = 3; *Healthy;
run;

*Use Coniditons to Create New Variabe Varible 3;

data Pd.ifthen3;
set PD.ifthen2;
if ridageyr < 40 then DMAge = 1; *Age Under 40; 
else if ridageyr >= 40 and ridageyr < 45 then DMAge = 2; *Age 40-44;
else if ridageyr >= 45 and ridageyr < 50 then DMAge = 3; *Age 45-49;
else if ridageyr >= 50 and ridageyr < 55 then DMAge = 4; *Age 50-54;
else if ridageyr >= 55 and ridageyr < 60 then DMAge = 5; *Age 55-59;
else if ridageyr >= 60 and ridageyr < 65 then DMAge = 6; *Age 60-64;
else if ridageyr >= 65 and ridageyr <=  70 then DMAge = 7; *Age 65-70;
else if ridageyr > 70 then DMAge = 8; *Age over 70;
else if ridageyr = . then DMAge = 9; *Age Unknown;
run;

*Use Coniditons to Create New Variabe Varible 4;

data PD.ifthen4;
set PD.ifthen3;
if DMAge in (2 3 4 5 6 7) and DMBMI = 1 then DMRisk = 1;
Else if DMRisk ~= 1 then DMRisk = 2;
run;

*Get frequency of Unique Values in tables;

proc freq data = PD.ifthen4;
tables DMStat DMRisk DMBMI DMAge RIDRETH3 RIAGENDR;
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
value BMI 	 	
	1 = Obese
	2 = Overwweight
	3 = Healthy;
value Age
	1 = "Under 40"
	2 = "40-44"
    3 = "45-49"
	4 = "50-54"
	5 = "55-59"
	6 = "60-64"
	7 = "65-70"
	8 = "Over 70"
	9 = "Unknown";
value Race
	1 = Mexican American
	2 = Other Hispanic
	3 = NonHispanic White
	4 = NonHispanic Black
	6 = NonHispanic Asian
	7 = Other Race Including Multi Racial;
value Sex
	1 = Male
	2 = Female;
run;

*Set lables;

data PD.stat;
set PD.ifthen4;
format DMStat Status. DMRisk Risk. DMBMI BMI. DMAge Age. RIDRETH3 Race. RIAGENDR Sex.;
label DMStat = "Diabetes Status" DMBMI = "BMI" DMAge = "Age Groups" RIDRETH3 = "Race and Ethnicity" DMRisk = "Population at Risk";
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
tables  DMStat * DMRisk * DMBMI * DMAge * RIDRETH3 * RIAGENDR; *variables to use in table;
ods output CrossTabs = PD.result;
strata  SDMVSTRA; *first stage strata;
cluster SDMVPSU; *first stage cluster;
weight  WTMEC2YR; *survey weight;
run;

**Step Extra: Export Data;

*Export SAS Dataset to CSV;

proc export data = PD.result dbms = csv
outfile = "C:\Users\drewc\GitHub\PreDM\_data\nhanes_dmstatus_raw.csv"
replace;
run;




