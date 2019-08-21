#### Prep Code: import libraries, set wd, import data

import os
import pandas as pd
import numpy as np

os.chdir("C:/Users/andrewcistola/GitHub/PreDM")

nhanes = pd.read_csv("_data/nhanes_merged_staged.csv", encoding = "ISO-8859-1")
nhanes.dtypes

#### Create New Column Based on Conditions

df["ColC"] = np.where(["ColA"] >= 50, "yes", "no")


#### Create New Column Based on Conditions

age = (nhanes["RIDAGEYR"]> 40) & (nhanes["RIDAGEYR"] < 70)
predm = (nhanes["DIQ160"] != 1)
dm = (nhanes["DIQ010"] != 1)
hba1c = (nhanes["LBXGH"] >= 5.7) & (nhanes["LBXGH"] <= 6.4)

nhanes["UndgPDM"] = np.where(age & predm & dm & hba1c, 1, 2)
nhanes["UndgPDM"]
