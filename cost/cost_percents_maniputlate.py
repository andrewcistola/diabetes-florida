#### Diabetes Status and Costs
### Group Percent Manipulation
## Code Script by DrewC!

### Section 1: Improt Libraries, Import Dataset, Prepare for Classification

## Import Standard Libraries
import os # Inlcuded in every script DC!
import numpy as np # Inclduded in every code script DC!
import pandas as pd # Incldued in every code script for DC!

## Import Dataset
os.chdir("C:/Users/drewc/GitHub/PreDM") # Set wd to project repository
df_nh = pd.read_csv("_data/cost_percents_stage.csv", encoding = "ISO-8859-1") # Import dataset, all datasets in _data folder in repository

## Verify
df_nh.info()
df_nh.head()

### Remove Group Totals
df_tot = df_nh
df_tot = df_tot[~df_tot["Age"].str.contains("Total Age")]
df_tot = df_tot[~df_tot["Race"].str.contains("Total Race")]
df_tot = df_tot[~df_tot["Gender"].str.contains("Total Gender")]
df_tot = df_tot[~df_tot["BMI"].str.contains("Total BMI")]
df_tot = df_tot[~df_tot["Risk"].str.contains("Total Risk")]

## Sort by Group Percentages
df_PD = df_PD[df_PD["N"] > 20] # Subset by groups with more than 20 surveyed
df_PD = df_PD.sort_values(by = ["Percent"], ascending = False) # Sort by column value

## Verify
df_PD.head(20) # Show top 20 observations

### Subset by Groups

## Isolate Undiagnosed Prediabetes
df_PD = df_nh[df_nh["Status"].str.contains("Undiagnosed Prediabetes")] # Subset by status

## Create Subset
df_risk = df_PD
df_risk = df_risk[df_risk["Risk"].str.contains("At risk")] # Subset by risk
df_risk = df_risk.drop(columns = ["Risk"])

## Verify
df_risk.head()

## Isolate Totals for Race
df_race = df_risk
df_race = df_race[df_race["Age"].str.contains("Total Age")]
df_race = df_race[df_race["Gender"].str.contains("Total Gender")]
df_race = df_race[df_race["BMI"].str.contains("Total BMI")]
df_race = df_race.drop(columns = ["Age", "Gender", "BMI"])

## Verify
df_race.head(10)










