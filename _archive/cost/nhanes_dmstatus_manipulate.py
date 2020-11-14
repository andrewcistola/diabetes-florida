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
df_dgDM = pd.read_csv("_data/nhanes_dgDM_sudaan_raw.csv", encoding = "ISO-8859-1") # Import dataset all datasets in _data folder in repository
df_dgPD = pd.read_csv("_data/nhanes_dgPD_sudaan_raw.csv", encoding = "ISO-8859-1") # Import dataset all datasets in _data folder in repository
df_unDM = pd.read_csv("_data/nhanes_unDM_sudaan_raw.csv", encoding = "ISO-8859-1") # Import dataset all datasets in _data folder in repository
df_unPD = pd.read_csv("_data/nhanes_unPD_sudaan_raw.csv", encoding = "ISO-8859-1") # Import dataset all datasets in _data folder in repository
df_misd = pd.read_csv("_data/nhanes_misd_sudaan_raw.csv", encoding = "ISO-8859-1") # Import dataset all datasets in _data folder in repository
df_hlty = pd.read_csv("_data/nhanes_hlty_sudaan_raw.csv", encoding = "ISO-8859-1") # Import dataset all datasets in _data folder in repository
df_unkn = pd.read_csv("_data/nhanes_unkn_sudaan_raw.csv", encoding = "ISO-8859-1") # Import dataset all datasets in _data folder in repository

## Tidy Data Types and Missing Values for Diagnosed Diabetes
df_dgDM["N"] = df_dgDM["NSUM"].astype("int64")
df_dgDM["Population"] = df_dgDM["WSUM"].astype("int64")
df_dgDM["Percent"] = df_dgDM["PERCENT"].astype("float64")
df_dgDM["DMAGE"] = df_dgDM["DMAGE"].str.replace("0", "Total Age", regex = True)
df_dgDM["DMRACE"] = df_dgDM["DMRACE"].str.replace("0", "Total Race", regex = True)
df_dgDM["DMGNDR"] = df_dgDM["DMGNDR"].str.replace("0", "Total Gender", regex = True)
df_dgDM["DMBMI"] = df_dgDM["DMBMI"].str.replace("0", "Total BMI", regex = True)
df_dgDM["DMRISK"] = df_dgDM["DMRISK"].str.replace("0", "Total Risk", regex = True)
df_dgDM["Status"] = "Diagnosed Diabetes"

## Tidy Data Types and Missing Values for Diagnosed Prediabetes
df_dgPD["N"] = df_dgPD["NSUM"].astype("int64")
df_dgPD["Population"] = df_dgPD["WSUM"].astype("int64")
df_dgPD["Percent"] = df_dgPD["PERCENT"].astype("float64")
df_dgPD["DMAGE"] = df_dgPD["DMAGE"].str.replace("0", "Total Age", regex = True)
df_dgPD["DMRACE"] = df_dgPD["DMRACE"].str.replace("0", "Total Race", regex = True)
df_dgPD["DMGNDR"] = df_dgPD["DMGNDR"].str.replace("0", "Total Gender", regex = True)
df_dgPD["DMBMI"] = df_dgPD["DMBMI"].str.replace("0", "Total BMI", regex = True)
df_dgPD["DMRISK"] = df_dgPD["DMRISK"].str.replace("0", "Total Risk", regex = True)
df_dgPD["Status"] = "Diagnosed Prediabetes"

## Tidy Data Types and Missing Values for Undiagnosed Diabetes
df_unDM["N"] = df_unDM["NSUM"].astype("int64")
df_unDM["Population"] = df_unDM["WSUM"].astype("int64")
df_unDM["Percent"] = df_unDM["PERCENT"].astype("float64")
df_unDM["DMAGE"] = df_unDM["DMAGE"].str.replace("0", "Total Age", regex = True)
df_unDM["DMRACE"] = df_unDM["DMRACE"].str.replace("0", "Total Race", regex = True)
df_unDM["DMGNDR"] = df_unDM["DMGNDR"].str.replace("0", "Total Gender", regex = True)
df_unDM["DMBMI"] = df_unDM["DMBMI"].str.replace("0", "Total BMI", regex = True)
df_unDM["DMRISK"] = df_unDM["DMRISK"].str.replace("0", "Total Risk", regex = True)
df_unDM["Status"] = "Undiagnosed Diabetes"

## Tidy Data Types and Missing Values for Undiagnosed Prediabetes
df_unPD["N"] = df_unPD["NSUM"].astype("int64")
df_unPD["Population"] = df_unPD["WSUM"].astype("int64")
df_unPD["Percent"] = df_unPD["PERCENT"].astype("float64")
df_unPD["DMAGE"] = df_unPD["DMAGE"].str.replace("0", "Total Age", regex = True)
df_unPD["DMRACE"] = df_unPD["DMRACE"].str.replace("0", "Total Race", regex = True)
df_unPD["DMGNDR"] = df_unPD["DMGNDR"].str.replace("0", "Total Gender", regex = True)
df_unPD["DMBMI"] = df_unPD["DMBMI"].str.replace("0", "Total BMI", regex = True)
df_unPD["DMRISK"] = df_unPD["DMRISK"].str.replace("0", "Total Risk", regex = True)
df_unPD["Status"] = "Undiagnosed Prediabetes"

## Tidy Data Types and Missing Values for Misdiagnosis
df_misd["N"] = df_misd["NSUM"].astype("int64")
df_misd["Population"] = df_misd["WSUM"].astype("int64")
df_misd["Percent"] = df_misd["PERCENT"].astype("float64")
df_misd["DMAGE"] = df_misd["DMAGE"].str.replace("0", "Total Age", regex = True)
df_misd["DMRACE"] = df_misd["DMRACE"].str.replace("0", "Total Race", regex = True)
df_misd["DMGNDR"] = df_misd["DMGNDR"].str.replace("0", "Total Gender", regex = True)
df_misd["DMBMI"] = df_misd["DMBMI"].str.replace("0", "Total BMI", regex = True)
df_misd["DMRISK"] = df_misd["DMRISK"].str.replace("0", "Total Risk", regex = True)
df_misd["Status"] = "Misdiagnosed"

## Tidy Data Types and Missing Values for Healthy
df_hlty["N"] = df_hlty["NSUM"].astype("int64")
df_hlty["Population"] = df_hlty["WSUM"].astype("int64")
df_hlty["Percent"] = df_hlty["PERCENT"].astype("float64")
df_hlty["DMAGE"] = df_hlty["DMAGE"].str.replace("0", "Total Age", regex = True)
df_hlty["DMRACE"] = df_hlty["DMRACE"].str.replace("0", "Total Race", regex = True)
df_hlty["DMGNDR"] = df_hlty["DMGNDR"].str.replace("0", "Total Gender", regex = True)
df_hlty["DMBMI"] = df_hlty["DMBMI"].str.replace("0", "Total BMI", regex = True)
df_hlty["DMRISK"] = df_hlty["DMRISK"].str.replace("0", "Total Risk", regex = True)
df_hlty["Status"] = "Healthy"

## Tidy Data Types and Missing Values for Unknown Diagnosis
df_unkn["N"] = df_unkn["NSUM"].astype("int64")
df_unkn["Population"] = df_unkn["WSUM"].astype("int64")
df_unkn["Percent"] = df_unkn["PERCENT"].astype("float64")
df_unkn["DMAGE"] = df_unkn["DMAGE"].str.replace("0", "Total Age", regex = True)
df_unkn["DMRACE"] = df_unkn["DMRACE"].str.replace("0", "Total Race", regex = True)
df_unkn["DMGNDR"] = df_unkn["DMGNDR"].str.replace("0", "Total Gender", regex = True)
df_unkn["DMBMI"] = df_unkn["DMBMI"].str.replace("0", "Total BMI", regex = True)
df_unkn["DMRISK"] = df_unkn["DMRISK"].str.replace("0", "Total Risk", regex = True)
df_unkn["Status"] = "Unknown"

## Stack Dataframes to create master dataset
df_nh = pd.concat([df_dgDM, df_dgPD, df_unDM, df_unPD, df_misd, df_hlty, df_unkn])

## Tidy
df_nh = df_nh.fillna(0) # Drop all rows with NA values

## Stage
df_nh = df_nh.drop(columns = ["PROCNUM", "TABLENO", "_C1", "_C2", "_C3", "_C4", "_C5", "VARIABLE", "NSUM", "WSUM", "PERCENT"])
df_nh = df_nh.rename(columns = {"DMAGE" : "Age", "DMRACE" : "Race", "DMGNDR" : "Gender", "DMBMI" : "BMI", "DMRISK" : "Risk"})

## Verify
df_nh.info()
df_nh.head()

## Export to CSV
df_nh.to_csv("_data/cost_percents_stage.csv")