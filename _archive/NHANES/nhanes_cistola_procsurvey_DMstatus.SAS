nhanes_cistola_DMStatus_procsurvey.SAS

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
