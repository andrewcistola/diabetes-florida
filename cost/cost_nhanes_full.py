#### Prep Code: import libraries, set wd, import data

import os
import pandas as pd
import numpy as np

os.chdir("C:/Users/andrewcistola/GitHub/PreDM")

nhanes = pd.read_csv("_data/nhanes_merged_staged.csv", encoding = "ISO-8859-1")
nhanes.dtypes

#### Create New Column Based on Conditions

nhanes["UndgDM"] = np.where(
        (nhanes["DIQ160"] != 1) & 
        (nhanes["DIQ010"] != 1) & 
        (nhanes["LBXGH"] >= 6.4), 1, 2)

nhanes["UndgPD"] = np.where(
        (nhanes["DIQ160"] != 1) & 
        (nhanes["DIQ010"] != 1) & 
        (nhanes["UndgDM"] != 1) & 
        (nhanes["LBXGH"] >= 5.7) & 
        (nhanes["LBXGH"] < 6.4), "Prediabetes", "Healthy or Unknown")

nhanes.to_csv("_data/nhanes_merged_undg_staged.csv")

#### Subset by Column Value

age = nhanes[(nhanes["RIDAGEYR"]>= 40) & (nhanes["RIDAGEYR"] <= 70)]
age.info()

bmi = age[(age["BMXBMI"] > 25)]
bmi.info()

#### Filter Columns

filtr = bmi.filter(["UndgPD", "WTMEC2YR"])
filtr.info()

#### Group data By Columns and Sum

groups = filtr.groupby(["UndgPD"], as_index = False).sum()
groups.info()

#### Create Percent Column

groups["Percent"] = groups["WTMEC2YR"] / groups["WTMEC2YR"].sum()

#### Rename and Drop Unwanted Columns

groups["Total"] = groups["WTMEC2YR"]
groups["Status"] = groups["UndgPD"]
final = groups.drop(columns = ["WTMEC2YR", "UndgPD"])
final.to_csv("_reports/predm_nhanes_undaignosed.csv")

#### Create Bar Graph of Multipel Values

import matplotlib.pyplot as plt

fig, ax1 = plt.subplots(figsize = (8, 8))
plt.xlabel("Population Age 40-70, BMI > 25, No told Diagnosis of DM or PD, No HbA1c above 6.4")
plt.xticks([])

ax1.bar(0.5, final.Total[0], color = "b", width = 0.66)
ax1.bar(1.5, final.Total[1], color = "r", width = 0.66)
ax1.set_ylabel("Total Population (Millions)")

ax2 = ax1.twinx()

ax2.bar(2.5, final.Percent[0], color = "b", width = 0.66)
ax2.bar(3.5, final.Percent[1], color = "r", width = 0.66)
ax2.set_ylabel("Percent of Population")

plt.legend(["5.7> or NA", "5.7-6.4"])
fig.suptitle("Population at Risk and Undiagnosed in NHANES 2015-2016", y = 0.95, fontsize = 14)
fig.savefig("_fig/predm_nhanes_undiagnosed.jpeg", bbox_inches = "tight")