#### Prep Code: import libraries, set wd, import data

import os
import numpy as np
import pandas as pd

os.chdir("C:/Users/drewc/GitHub/PreDM")

df = pd.read_csv("_data/nhanes_dmstatus_ready.csv", encoding = "ISO-8859-1")
df.info()

#### Group data By Columns and Sum

group = df.groupby(["Status", "Risk"], as_index = False).sum()
group

#### Write to CSV

group.to_csv("cost/cost_dmstatus_groups.csv")

#### Filter by Column Value

risk = df[(df.Risk == "At risk")]

#### Group data By Columns and Sum

group_risk = risk.groupby(["Status"], as_index = False).sum()
group_risk

#### Write to CSV

group_risk.to_csv("cost/cost_dmstatus_risk.csv")

#### Filter by Column Value

PreDM = risk[risk["Status"].str.contains("Prediabetes")]

#### Group data By Columns and Sum

race = PreDM.groupby(["Status", "Race"], as_index = False).sum()
sex = PreDM.groupby(["Status", "Sex"], as_index = False).sum()
age = PreDM.groupby(["Status", "Age"], as_index = False).sum()

#### Write to CSV

race.to_csv("cost/cost_dmstatus_race.csv")
age.to_csv("cost/cost_dmstatus_age.csv")
sex.to_csv("cost/cost_dmstatus_sex.csv")

race
sex
age



