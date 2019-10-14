#### NHANES Population Counts
### Post SUDAAN Data Manipulation
## Code Script by DrewC!

### Section 1: Improt Libraries, Import Dataset, Prepare for Classification

## Import Standard Libraries
import os # Inlcuded in every script DC!
import numpy as np # Inclduded in every code script DC!
import pandas as pd # Incldued in every code script for DC!

## Import Dataset
os.chdir("C:/Users/drewc/GitHub/PreDM") # Set wd to project repository
df_nh = pd.read_csv("_data/nhanes_dmstatus_sudaan_raw.csv", encoding = "ISO-8859-1") # Import dataset with outcome and ecological variable for each geographical id, all datasets in _data folder in repository

## Tidy Data Types and Missing Values
df_nh["_C1"] = df_nh[df_nh._C1 > 0]
df_nh["_C2"] = df_nh[df_nh._C2 > 0]
df_nh["_C3"] = df_nh[df_nh._C3 > 0]
df_nh["_C4"] = df_nh[df_nh._C4 > 0]
df_nh["_C5"] = df_nh[df_nh._C5 > 0]
df_nh["_C7"] = df_nh[df_nh._C7 > 0]
df_nh["NSUM"] = df_nh["NSUM"].astype("int64")
df_nh["WSUM"] = df_nh["WSUM"].astype("int64")

## Verify
df_nh.info()
df_nh.head()
sum = df_nh["WSUM"].sum(axis = 0)
print(sum)

## Export to CSV
df_nh.to_csv("_data/nhanes_predm_sudaan_stage.csv")

### Section 2: Group by Population Percent











