#### Diabetes Status and Costs
### At Risk Subgroup Manipulation
## Code Script by DrewC!

### Section 1: Improt Libraries, Import Dataset, Prepare for Classification

## Import Standard Libraries
import os # Inlcuded in every script DC!
import numpy as np # Inclduded in every code script DC!
import pandas as pd # Incldued in every code script for DC!

## Import Dataset
os.chdir("C:/Users/drewc/GitHub/PreDM") # Set wd to project repository
df_unPD = pd.read_csv("_data/cost_atrisk_stage.csv", encoding = "ISO-8859-1") # Import dataset, all datasets in _data folder in repository

## Tidy
df_unPD = df_unPD.fillna(0) # Drop all rows with NA values

## Change 0 to Totals
df_unPD["Age"] = df_unPD["Age"].str.replace("0", "Total Age", regex = True)
df_unPD["Race"] = df_unPD["Race"].str.replace("0", "Total Race", regex = True)
df_unPD["Gender"] = df_unPD["Gender"].str.replace("0", "Total Gender", regex = True)

## Verify
df_unPD.info()
df_unPD.head()

### Identify Subgroups in At risk groups

## Isolate Totals for Race
df_race = df_unPD[df_unPD["Age"].str.contains("Total Age")]
df_race = df_race[df_race["Gender"].str.contains("Total")]
df_race

