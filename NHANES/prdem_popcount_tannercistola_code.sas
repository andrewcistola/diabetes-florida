**Prediabetes Cost of Prevention Study - NHANES Population COunts

*Merge and sorting the NHANEs Dataset to find population with undiagnosed prediabetes
*Variables are stored in E:\NHANES\ for easy access for individual projects
*Saved libraries correspond to years of NHANES

**Prep Code: Set Libraries;

libname NH "C:\Users\drewc\Dropbox (UFL)\NHANES Data Library\2015-2016\DATA";
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

**** Rebcca Tanner Code;

data PD.tanner;
set PD.merge;
if diq010 in (7 9 .) or lbxgh = . or diq160 in (7 9) then predm = .;
else if diq010 = 1 then predm = 3; *diagnosed diabetes;
else if diq160 = 1 or diq010 = 3 then predm = 2; *diagnosed prediabetes;
else if lbxgh >= 5.7 and lbxgh <= 6.4 then predm = 1; *undiagnosed prediabetes;
else if diq010 = 2 and lbxgh < 5.7 then predm = 4; *normal;
else if diq010 = 2 and lbxgh > 6.4 then predm = 5; *undiagnosed diabetes;

label predm = "prediabetes/diabetes status";
run;

data PD.tanner;
set PD.tanner;
if bmxbmi = . then oo = .;
if bmxbmi >= 25 then oo = 1; *overweight/obese;
else oo = 2; *everyone else;

label oo = "overweight/obese";

if ridreth3 = . then race = .;
else if ridreth3 = 3 then race = 1; *white;
else if ridreth3 = 4 then race = 2; *black;
else if ridreth3 in (1 2) then race = 3; *hispanic;
else if ridreth3 = 6 then race = 4; *asian;
else if ridreth3 = 7 then race = 5; *other/multiracial;

label race = "respondent race";

if ridageyr >= 40 and ridageyr <= 70 then age = 1; *age 40 - 70;
else age = 2; *everyone else;
label age = "age 40-70";

rename riagendr = sex;

if age = 1 then do;
	if ridageyr >= 40 and ridageyr < 45 then agecat = 1; *age 40-44;
	else if ridageyr >= 45 and ridageyr < 50 then agecat = 2; *age 45-49;
	else if ridageyr >= 50 and ridageyr < 55 then agecat = 3; *age 50-54;
	else if ridageyr >= 55 and ridageyr < 60 then agecat = 4; *age 55-59;
	else if ridageyr >= 60 and ridageyr < 65 then agecat = 5; *age 60-64;
	else if ridageyr >= 65 and ridageyr <= 70 then agecat = 6; *age 65+;
end;

label agecat = "age in 5 year increments";
run;


proc format;
value yesno 1 = "yes"
            2 = "no";

value predm 1 = "undiagnosed prediabetes"
            2 = "diagnosed prediabetes"
			3 = "diagnosed diabetes"
			4 = "normal"
            5 = "undiagnosed diabetes";

value race  1 = "NH White"
            2 = "NH Black"
			3 = "Hispanic"
			4 = "NH Asian"
			5 = "Other/Multiracial";

value sex 1 = "male"
          2 = "female";

value age 1 = "age 40-70";

value oo 1 = "overweight/obese";

value agecat 1 = "age 40-44"
             2 = "age 45-49"
			 3 = "age 50-54"
			 4 = "age 55-59"
			 5 = "age 60-64"
			 6 = "age 65-70";

value udxpredm 1 = "undiagnosed prediabetes"
               2 = "everyone else";
run;


data PD.tanner;
set PD.tanner;
if predm = . then udxpredm = .;
else if predm = 1 then udxpredm = 1; *undiagnosed prediabetes;
else udxpredm = 2; *everyone else;

label udxpredm = "undiagnosed prediabetes indicator";
run;

ods pdf file="C:\Users\drewc\GitHub\PreDM\NHANES\predm_tanner_unweighted_crosstabs.pdf";

proc freq data=PD.tanner;
where age=1 and oo=1;
tables  udxpredm race*udxpredm sex*udxpredm agecat*udxpredm;
format  udxpredm udxpredm. race race. sex sex. agecat agecat.;
title "undiagnosed prediabetes and race/sex/age crosstabs";
run;
ods pdf close;


proc sort data=PD.tanner;
by sdmvstra sdmvpsu;
run;
proc crosstab data=PD.tanner;
rtitle "Weighted crosstabs and prevalence estimate";
nest sdmvstra sdmvpsu;
weight wtmec2yr;
subpopn age=1 and oo=1;
class sex race udxpredm agecat;
tables udxpredm race*udxpredm sex*udxpredm agecat*udxpredm;
print nsum wsum rowper colper;
rformat udxpredm udxpredm.;
rformat sex sex.;
rformat race race.;
rformat agecat agecat.;
run;


*Check contents of Dataset;

proc contents data = PD.tanner;
run;


data PD.tanner;
set PD.tanner;
if predm = . then allpredm = .;
if predm in (1 2) then allpredm = 1; *diagnosed/undiagnosed prediabetes;
else allpredm = 2; *everyone else;

label allpredm = "all prediabetes";

if predm = . then propudx = .;
else if predm = 1 then propudx = 1; *undiagnosed prediabetes;
else if predm = 2 then propudx = 2; *diagnosed prediabetes;

label propudx = "prediabetes";
run;


proc format;
value allpredm 1 = "all prediabetes"
               2 = "everyone else";

value propudx 1 = "undiagnosed prediabetes"
              2 = "diagnosed prediabetes";
run;


proc sort data=PD.tanner;
by sdmvstra sdmvpsu;
run;
proc crosstab data=PD.tanner;
rtitle "Weighted all prediabetes estimate and percentage of prediabetes who are undiagnosed";
nest sdmvstra sdmvpsu;
weight wtmec2yr;
subpopn age=1 and oo=1;
class allpredm propudx;
tables allpredm propudx;
setenv colwidth = 15;
print nsum wsum rowper colper;
rformat allpredm allpredm.;
rformat propudx propudx.;
run;


