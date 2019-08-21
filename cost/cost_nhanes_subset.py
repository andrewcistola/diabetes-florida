#### Prep Code: import libraries, set wd, import data

import os
import pandas as pd
import numpy as np

os.chdir("C:/Users/andrewcistola/GitHub/PreDM")

nhanes = pd.read_csv("cost/nhanes_cost_staged.csv", encoding = "ISO-8859-1")
nhanes.head()

#### Subset Data by Column Value

subs = nhanes[(nhanes["ToldDiagnosis"] !== "Borderline") | (nhanes["ToldDiagnosis"] !== "Healthy")]
subs.info()

#### Drop Unwanted Columns

dropt = nhanes.drop(columns = ["InterviewWeight"])
dropt.info()

#### Group data By Columns and Sum

group = nhanes.groupby(["ToldDiagnosis"], as_index = False).sum()
group.head()

print(nhanes["ToldDiagnosis"].unique())