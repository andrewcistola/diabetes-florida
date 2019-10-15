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

data PD.merge;
merge NH.DEMO_I NH.GHB_I NH.DIQ_I NH.GLU_I NH.HIQ_I NH.HUQ_I NH.INS_I NH.OGTT_I NH.BMX_I; 
by SEQN;
run;

*Check contents of Dataset;

proc contents data = PD.merge;
run;

**Step 3: Create categorical variables;

*Use Coniditons to Create Demographic Categories: Age;

data Pd.demo;
set PD.merge;
if RIDAGEYR >= 10 and RIDAGEYR < 20 then DMAge = 1; *Age 10-19;
else if RIDAGEYR >= 20 and RIDAGEYR < 30 then DMAge = 2; *Age 20-29;
else if RIDAGEYR >= 30 and RIDAGEYR < 40 then DMAge = 3; *Age 30-39;
else if RIDAGEYR >= 40 and RIDAGEYR < 50 then DMAge = 4; *Age 40-49;
else if RIDAGEYR >= 50 and RIDAGEYR < 60 then DMAge = 5; *Age 50-59;
else if RIDAGEYR >= 60 and RIDAGEYR < 70 then DMAge = 6; *Age 60-69;
else if RIDAGEYR >= 70 and RIDAGEYR < 80 then DMAge = 7; *Age 70-79;
else if RIDAGEYR >= 80 then DMAge = 8; *Age Over 80;
else if RIDAGEYR < 10 then DMAge = 9; *Age Under 10;
else if RIDAGEYR = 0 or RIDAGEYR = . then DMAge = 10; *Unknown;
run;

*Use Coniditons to Create Demographic Categories: Race;

data PD.demo2;
set PD.demo;
if RIDRETH3 = 1 then DMRace = 1; *1 = Mexican-American;
else if RIDRETH3 = 2 then DMRace = 2; *2 = Other Hispanic;
else if RIDRETH3 = 3 then DMRace = 3; *3 = Non-Hispanic White;
else if RIDRETH3 = 4 then DMRace = 4; *4 = Non-Hispanic Black;
else if RIDRETH3 = 6 then DMRace = 5; *5 = Non-Hispanic Asian;
else if RIDRETH3 = 7 then DMRace = 6; *6 = Other Non-Hispanic;
else if RIDRETH3 = . then DMRace = 7; *7 = Unknown;
run;

*Use Coniditons to Create Demographic Categories: Gender;

data PD.demo3;
set PD.demo2;
if RIAGENDR = 1 then DMGndr = 1; *1 = Male;
else if RIAGENDR = 2 then DMGndr = 2; *2 = Female;
else if RIAGENDR = 7 then DMGndr = 6; *6 = Other;
else if RIAGENDR = . then DMGndr = 7; *7 = Unknown;
run;

*Use Coniditons to Create Biomarker Categories: BMI;

data PD.bio;
set PD.demo3;
If BMXBMI >= 25 then DMBMI = 1; *Obese;
Else If BMXBMI < 25 and BMXBMI >= 21 then DMBMI = 2; *Overweight;
Else If BMXBMI < 21 then DMBMI = 3; *Healthy;
Else If BMXBMI = . then DMBMI = 4; *Unknown;
run;

*Use Coniditons to Create Outcome Categories: USPSTF Diabetes Screening for Risk;

data PD.outcome;
set PD.bio;
if DMBMI = 1 and ridageyr >= 40 and ridageyr <= 70 then DMRisk = 1; *At risk;
Else if DMAge = 9 or DMAge = 8 or DMAge = 1 or BMXBMI = 2 or BMXBMI = 3 then DMRisk = 2; *Not at Risk;
Else if DMAge = 9 or DMBMI = 4 then DMRisk = 3; *Unknown;
run;

*Use Coniditons to Create Outcome Categories: Diabetes Diagnosis Status;

data PD.categories;
set PD.outcome;
If DIQ010 = 1 then DMStat = 1; *1 = Diagnosed Diabetes;
Else If DIQ160 = 1 then DMStat = 2; *2 = Diagnosed Prediabetes;
Else If LBXGH >= 6.4 and DIQ010 ~= 1 then DMStat = 3; *3 = Undiagnosed Diabetes;
Else If LBXGH < 6.4 and LBXGH >= 5.7 and DIQ160 ~= 1 then DMStat = 4; *4 = Undiagnosed Prediabetes;
Else If (LBXGH < 6.4 and LBXGH >= 5.7 and DIQ010 = 1) or (LBXGH > 6.4 and DIQ160 = 1) or DIQ010 = 3 or (LBXGH < 5.7 and DIQ010 = 1) or (LBXGH < 5.7 and DIQ160 = 1) then DMStat = 5; *5 = Misdiagnosed;
Else If LBXGH < 5.7 then DMStat = 6; *6 = Healthy;
Else If LBXGH = . or DIQ010 = 3 or DIQ010 = 7 or DIQ010 = 9 or DIQ010 = . or DIQ160 = 7 or DIQ160 = 9 or DIQ160 = . then DMStat = 7; *7 Unknown;
run;

*Check contents of Dataset;

proc contents data = PD.categories;
run;

**Step 4: Set Dummy Variable, Formats and Labels based on Categorical Variables;

*Create Dummy Variables;

data PD.dummy;
set PD.categories;
if DMStat = 1 then dgDMX = 100;
else if DMStat ~= 1 then dgDMX = 0;
else if DMStat = 2 then dgPDX = 100;
else if DMStat ~= 2 then dgPDX = 0;
else if DMStat = 3 then unDMX = 100;
else if DMStat ~= 3 then unDMX = 0;
else if DMStat = 4 then unPDX = 100;
else if DMStat ~= 4 then unPDX = 0;
else if DMStat = 5 then misDMX = 100;
else if DMStat ~= 5 then misDMX = 0;
else if DMStat = 6 then hlthX = 100;
else if DMStat ~= 6 then hlthX = 0;
else if DMStat = 7 then unknX = 100;
else if DMStat ~= 7 then unknX = 0;
run;

*Set formats;

proc format;                                                                                       
value Age
	1 = "Teen"
	2 = "Twenty"
    3 = "Thirty"
	4 = "Forty"
	5 = "Fifty"
	6 = "Sixty"
	7 = "Seventy"
	8 = "Over Eighty"
	9 = "Under Ten"
	10 = "Unknown";
value Race
	1 = "Mexican American"
	2 = "Other Hispanic"
	3 = "Non-Hispanic White"
	4 = "Non-Hispanic Black"
	5 = "Non-Hispanic Asian"
	6 = "Other Race Including Multi Racial"
	7 = "Unknown";
value Gender
	1 = "Male"
	2 = "Female"
	3 = "Other"
	4 = "Unknown";
value BMI 	 	
	1 = "Obese"
	2 = "Overwweight"
	3 = "Healthy"
	4 = "Unknown";
value Risk
	1 = "At risk"
	2 = "Not at risk"
	3 = "Unknown";
value Status	
	1 = "Diagnosed Diabetes"
	2 = "Diagnosed Prediabetes"
	3 = "Undiagnosed Diabetes"
	4 = "Undiagnosed Prediabetes"	
	5 = "Misdiagnosed"	
	6 = "Healthy"
	7 = "Unknown";
run;

*Set lables;

data PD.labels;
set PD.dummy;
format DMAge Age. DMRace Race. DMGndr Gender.  DMBMI BMI. DMRisk Risk. DMStat Status.;
label DMAge = "Age Groups" DMRace = "Race and Ethnicity" DMGndr = "Gender" DMRisk = "Population at Risk";
run;

*Check contents of Dataset;

proc contents data = PD.labels;
run;

**Step 4: Set Weights and Clusters to get prevalence of diabetes status for those at risk;

*Sort Data by strata and cluster;

proc sort data = PD.labels;
by SDMVSTRA SDMVPSU;
run;

*Get Prevaence of Diabetes Status and Risk in Population Using SUDAAN: Diagnosed Diabetes;

proc descript data = PD.labels design = wr atlevel1 = 1 atlevel2 = 2;
NEST SDMVSTRA SDMVPSU;
WEIGHT WTMEC2YR;
SUBGROUP DMAge DMRace DMGndr DMBMI;
LEVELS 10 7 4 4;
CATLEVEL 1;
var DMStat;
tables DMAge*DMRace*DMGndr*DMBMI;
output nsum wsum percent / FILENAME = PD.dgDM FILETYPE = SAS REPLACE;
run;

*Export SAS file to Excel;

proc export data = PD.dgDM dbms = csv
outfile = "C:\Users\drewc\GitHub\PreDM\_data\nhanes_dgDM_sudaan_raw.csv"
replace;
run;

*Get Prevaence of Diabetes Status and Risk in Population Using SUDAAN: Diagnosed Prediabtes;


proc descript data = PD.labels design = wr atlevel1 = 1 atlevel2 = 2;
NEST SDMVSTRA SDMVPSU;
WEIGHT WTMEC2YR;
SUBGROUP DMAge DMRace DMGndr DMBMI;
LEVELS 10 7 4 4;
CATLEVEL 2;
var DMStat;
tables DMAge*DMRace*DMGndr*DMBMI;
output nsum wsum percent / FILENAME = PD.dgPD FILETYPE = SAS REPLACE;
run;

*Export SAS file to Excel;

proc export data = PD.unPD dbms = csv
outfile = "C:\Users\drewc\GitHub\PreDM\_data\nhanes_dgPD_sudaan_raw.csv"
replace;
run;


*Get Prevaence of Diabetes Status and Risk in Population Using SUDAAN: Undiagnosed Diabetes;


proc descript data = PD.labels design = wr atlevel1 = 1 atlevel2 = 2;
NEST SDMVSTRA SDMVPSU;
WEIGHT WTMEC2YR;
SUBGROUP DMAge DMRace DMGndr DMBMI;
LEVELS 10 7 4 4;
CATLEVEL 3;
var DMStat;
tables DMAge*DMRace*DMGndr*DMBMI;
output nsum wsum percent / FILENAME = PD.unDM FILETYPE = SAS REPLACE;
run;

*Export SAS file to Excel;

proc export data = PD.unDM dbms = csv
outfile = "C:\Users\drewc\GitHub\PreDM\_data\nhanes_unDM_sudaan_raw.csv"
replace;
run;


*Get Prevaence of Diabetes Status and Risk in Population Using SUDAAN: Undiagnosed Prediabtes;

proc descript data = PD.labels design = wr atlevel1 = 1 atlevel2 = 2;
NEST SDMVSTRA SDMVPSU;
WEIGHT WTMEC2YR;
SUBGROUP DMAge DMRace DMGndr DMBMI;
LEVELS 10 7 4 4;
CATLEVEL 4;
var DMStat;
tables DMAge*DMRace*DMGndr*DMBMI;
output nsum wsum percent / FILENAME = PD.unPD FILETYPE = SAS REPLACE;
run;

*Export SAS file to Excel;

proc export data = PD.unPD dbms = csv
outfile = "C:\Users\drewc\GitHub\PreDM\_data\nhanes_unPD_sudaan_raw.csv"
replace;
run;

*Get Prevaence of Diabetes Status in Population Using SUDAAN: Misdiagnosis;

proc descript data = PD.labels design = wr atlevel1 = 1 atlevel2 = 2;
NEST SDMVSTRA SDMVPSU;
WEIGHT WTMEC2YR;
SUBGROUP DMAge DMRace DMGndr DMBMI;
LEVELS 10 7 4 4;
CATLEVEL 5;
var DMStat;
tables DMAge*DMRace*DMGndr*DMBMI;
output nsum wsum percent / FILENAME = PD.misd FILETYPE = SAS REPLACE;
run;

*Export SAS file to Excel;

proc export data = PD.misd dbms = csv
outfile = "C:\Users\drewc\GitHub\PreDM\_data\nhanes_misd_sudaan_raw.csv"
replace;
run;

*Get Prevaence of Diabetes Status and Risk in Population Using SUDAAN: Healthy;

proc descript data = PD.labels design = wr atlevel1 = 1 atlevel2 = 2;
NEST SDMVSTRA SDMVPSU;
WEIGHT WTMEC2YR;
SUBGROUP DMAge DMRace DMGndr DMBMI;
LEVELS 10 7 4 4;
CATLEVEL 6;
var DMStat;
tables DMAge*DMRace*DMGndr*DMBMI;
output nsum wsum percent / FILENAME = PD.hlty FILETYPE = SAS REPLACE;
run;

*Export SAS file to Excel;

proc export data = PD.hlty dbms = csv
outfile = "C:\Users\drewc\GitHub\PreDM\_data\nhanes_hlty_sudaan_raw.csv"
replace;
run;

*Get Prevaence of Diabetes Status and Risk in Population Using SUDAAN: Unknown;

proc descript data = PD.labels design = wr atlevel1 = 1 atlevel2 = 2;
NEST SDMVSTRA SDMVPSU;
WEIGHT WTMEC2YR;
SUBGROUP DMAge DMRace DMGndr DMBMI;
LEVELS 10 7 4 4;
CATLEVEL 7;
var DMStat;
tables DMAge*DMRace*DMGndr*DMBMI;
output nsum wsum percent / FILENAME = PD.unkn FILETYPE = SAS REPLACE;
run;

*Export SAS file to Excel;

proc export data = PD.unkn dbms = csv
outfile = "C:\Users\drewc\GitHub\PreDM\_data\nhanes_unkn_sudaan_raw.csv"
replace;
run;

